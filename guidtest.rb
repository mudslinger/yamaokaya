str = '000000000FF'
aiu = '1234567890あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわをんがぎぐげござじずぜぞだぢづでどばびぶべぼ'
i = str.hex
len = aiu.length
while i >= len do
	t = i % len
	i = i.div(len)
	puts aiu[t]
end
puts aiu[i]
puts 16 **(14)
