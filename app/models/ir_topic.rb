class IrTopic
	include ActiveModel::Model
	attr_accessor :released,:url,:title,:size,:type,:year,:file_type
	def self.find(count)
		find_all[0..count-1]
	end

	def self.find_all
		list = get_all
		def list.press
			self.select do |item|
				item.type == 'press'
			end.group_by do |item|
				item.released.year
			end
		end
		def list.yuho
			self.select do |item|
				item.type == 'yuho'
			end.group_by do |item|
				item.year
			end
		end
		def list.tanshin
			self.select do |item|
				item.type == 'tanshin'
			end.group_by do |item|
				item.year
			end
		end
		list
	end

	private
	def self.get_all
		tmp = get_from_pnx('http://v4.eir-parts.net/V4Public/EIR/3399/ja/announcement/announcement_4.js')['item']
		tmp.map do |src|
			IrTopic.new(
				released: Time.strptime(src['date'],'%Y/%m/%d %H:%M'),
				url: src['link'],
				title: src['title'],
				size: src['file_size'],
				file_type: src['type'],
				year: src['fiscal_ym'][0..3],
				type: src['news_type']
			)
		end
	end

	def self.get_other
		tmp = get_from_pnx('http://v4.eir-parts.net/V4Public/EIR/3399/ja/press/press_3.js')['item']
		tmp.map do |src|
			IrTopic.new(
				released: Time.strptime(src['date'],'%Y/%m/%d %H:%M'),
				url: src['link_tanshin'],
				title: src['tanshin_type'],
				size: src['tanshin_size'],
				type: '開示'
			)
		end
	end

	def self.get_tanshin
		tmp = get_from_pnx('http://v4.eir-parts.net/V4Public/EIR/3399/ja/press/press_1.js')['item']
		tmp.map do |src|
			IrTopic.new(
				released: Time.strptime(src['date'],'%Y/%m/%d %H:%M'),
				url: src['link_tanshin'],
				title: src['tanshin_type'],
				size: src['tanshin_size'],
				year: src['tanshin_year'],
				type: '短信'
			)
		end
	end

	#todo 有報フォーマットに合わせる
	def self.get_yuho
		tmp = get_from_pnx('http://v4.eir-parts.net/V4Public/EIR/3399/ja/yuho/yuho_2.js')['item']
		tmp.map do |src|
			IrTopic.new(
				released: Time.strptime(src['date'],'%Y/%m/%d %H:%M'),
				url: src['link_tanshin'],
				title: src['tanshin_type'],
				size: src['tanshin_size'],
				type: '有価証券報告書'
			)
		end
	end

	def self.get_from_pnx(url)
		data = 
			RestClient.get url
		text = 
			data.force_encoding('utf-8')
			.gsub(/\r\n|\t/,'')
			.scan(/eolparts_[a-z]+_[0-9]\((.+)\);/)[0][0]
		JSON.parse(text)
	end
end