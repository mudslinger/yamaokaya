require 'fileutils'
class ImagesController < ApplicationController
	include MiniMagick
	skip_before_filter :set_title
	ssl_allowed :all
	def show
		size = params[:size] || 'origin'
		file = params[:file] if params[:file].present?
		notfound = false
		s3 = AWS::S3.new
		bucket = s3.buckets['assets.yamaokaya.com']
		o = bucket.objects[file]
		begin
			blob = o.read
		rescue
			#ファイルが見つからない場合の処理。noimageを表示
			notfound = true
			bg = bucket.objects['images/transparent.png']
			noimg = bucket.objects['images/noimage.png']
			bg_img = Image.read bg.read
			bg_img.resize size == 'origin' ? '200x100' : size
			result = bg_img.composite(Image.read noimg.read) do |c|
			  c.gravity "center"
			end
			blob = result.to_blob
		end
		path = Rails.root.join('public','i',size,file)
		FileUtils.mkpath(File::dirname path)

		image = MiniMagick::Image.read(blob)
		#originじゃ無いときはリサイズ
		image.resize size unless size == 'origin'
		#クオリティ調整
		image.quality 75
		#メタデータ削除
		image.strip

		#キャッシュに書き込み
		meta = Rails.cache.fetch(image_url: request.path_info) do
			{
				assets_url: "//assets#{Digest::MD5.hexdigest(request.path_info).hex % 8}.yamaokaya.com#{request.path_info}",
				width: image[:width],
				height: image[:height],
				notfound: notfound
			}
		end
		blob = image.to_blob

		#TODO PNG以外に対応
		response.headers["Expires"] = 10.days.from_now.httpdate
		send_data blob, :disposition => "inline", :type => image.mime_type
		#吐き出してからファイルに書きたい
		File.open(path,'wb') do |f|
			f << blob
		end
	end

	def clean

	end
end
