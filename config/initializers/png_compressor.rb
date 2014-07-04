# Important to tell Sprockets this is a binary type, else you'll get UTF-8 byte sequence errors
Rails.application.assets.register_mime_type 'image/png', '.png'
 
Rails.application.assets.register_postprocessor 'image/png', :png_compressor do |context, data|
  IO.popen("pngquant -", "rb+") do |process|
    process.write(data)
    process.close_write
    process.read
  end
end