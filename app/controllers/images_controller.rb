require 'fileutils'
class ImagesController < ApplicationController
	def show
		width = params[:width] || 0
		height = params[:height] || 0
		file = params[:file] if params[:file].present?
		AWS.config(AWS_CREDENTIALS)
		puts AWS_CREDENTIALS
		s3 = AWS::S3.new
		bucket = s3.buckets['assets.yamaokaya.com']
		o = bucket.objects[file]
		path = Rails.root.join('public','i',width,height,file)
		FileUtils.mkpath(File::dirname path)
		image = MiniMagick::Image.read(o.read)
		image.resize "#{width}x#{height}"
		blob = image.to_blob
		
		File.open(path,'wb') do |f|
			f << blob
		end
		send_data blob, :disposition => "inline", :type => "image/png"

	end
end
