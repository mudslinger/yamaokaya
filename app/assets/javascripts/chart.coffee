$ ->
	DEFAULT_XTICKS = [
		# [2012,'第18期<br/>(H23/1期)']
		# [2013,'第19期<br/>(H24/1期)']
		# [2014,'第20期<br/>(H25/1期)']
		[2015,'第21期<br/>(H26/1期)']
		[2016,'第22期<br/>(H27/1期)']
		[2017,'第23期<br/>(H28/1期)']
		[2018,'第24期<br/>(H29/1期)']
		[2019,'第25期<br/>(H30/1期)']
	]
	DEFAULT_XAXIS =
		ticks: DEFAULT_XTICKS
		tickLength: 0
		autoscaleMargin: .10
	DEFAULT_YAXIS =
		tickFormatter: (y)->
			return y.toString().replace(/\B(?=(?:\d{3})+(?!\d))/g, ",")
	BAR_ONLY =
		lines:
			show: false
		points:
			show: false
		bars:
			show: true
	LINE_ONLY =
		lines:
			show: true
		points:
			show: true
		bars:
			show: false
	LINE_AND_BAR =
		lines:
			show: true
		points:
			show: true
		bars:
			show: true
	BAR_SETTING =
		align: 'center'
		barWidth: 0.3
	opts =
		sales: {
			yaxis: DEFAULT_YAXIS
			xaxis: DEFAULT_XAXIS
			series: BAR_ONLY
			bars: BAR_SETTING
		}
		op: {
			yaxis: DEFAULT_YAXIS
			xaxis: DEFAULT_XAXIS
			series: BAR_ONLY
			bars: BAR_SETTING
		}
		ni: {
			yaxis: DEFAULT_YAXIS
			xaxis: DEFAULT_XAXIS
			series: BAR_ONLY
			bars: BAR_SETTING
		}
		na_ta: {
			yaxis: DEFAULT_YAXIS
			xaxis: DEFAULT_XAXIS
			series: BAR_ONLY
			bars: BAR_SETTING
		}
		bps: {
			yaxis: DEFAULT_YAXIS
			xaxis: DEFAULT_XAXIS
			series: LINE_ONLY
		}
		eps: {
			yaxis: DEFAULT_YAXIS
			xaxis: DEFAULT_XAXIS
			series: LINE_ONLY
		}
	data =
		sales: {}
		op: {}
		ni: {}
		na_ta: []
		bps: {}
		eps: {}

	#会社概要用
	if $('body.corporate.company').get(0)?
		data =
			sales: {}
			op: {}
		$.getJSON '/ir/financial_infomation.json',(finfo)->
			data.sales =
				label: '売上高(単位:千円)'
				color: 1
				data:([f.year,f.sales] for f in finfo)
			data.op =
				label: '経常利益(単位:千円)'
				color: 2
				data:([f.year,f.op] for f in finfo)
			for k,v of data
				if $("##{k}-chart").get(0)?
					$.plot(
						"##{k}-chart"
						if Array.isArray(v) then v else [v]
						opts[k]
					)

	#IRハイライト用
	if $('body.corporate.ir').get(0)?
		data =
			sales: {}
			op: {}
			ni: {}
			na_ta: []
			bps: {}
			eps: {}
		$.getJSON '/ir/financial_infomation.json',(finfo)->
			data.sales =
				label: '売上高(単位:千円)'
				color: 1
				data:([f.year,f.sales] for f in finfo)
			data.op =
				label: '経常利益(単位:千円)'
				color: 2
				data:([f.year,f.op] for f in finfo)
			data.ni =
				label: '当期純利益(単位:千円)'
				color: 3
				data:([f.year,f.ni] for f in finfo)
			data.na_ta[0] =
				label: '総資産額(単位:千円)'
				color: 4
				data:([f.year-0.15,f.ta] for f in finfo)
				bars:
					order: 1
			data.na_ta[1] =
				label: '純資産額(単位:千円)'
				color: 3
				data:([f.year+0.15,f.na] for f in finfo)
				bars:
					order: 2
			data.bps =
				label: '一株あたり純資産額(単位:千円)'
				color: 5
				data:([f.year,f.bps] for f in finfo when f.year > 2012)
			data.eps =
				label: '一株あたり当期純利益額(単位:千円)'
				color: 6
				data:([f.year,f.eps] for f in finfo  when f.year > 2012)

			for k,v of data
				if $("##{k}-chart").get(0)?
					$.plot(
						"##{k}-chart"
						if Array.isArray(v) then v else [v]
						opts[k]
					)


