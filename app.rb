require 'rubygems'
require 'sinatra'
require 'json'

BASE = "./public/stubby/"

get "/" do
  "<h2>hi.</h2><a href='/up'>up</a>"
end

get '/up' do
%Q|
<h1>Upload Image</h1>
<form action="/up" method="post" enctype="multipart/form-data">
	<input type="file" name="image">
	<input type="submit" value="Upload">
</form>
	|
end

post '/up' do
	puts params.to_s
	if params[:file] && params[:file][:filename]
	  ## the "web" branch
		filename = params[:file][:filename]
		file = params[:file][:tempfile]
		path = "#{BASE}#{filename}"
		# Write file to disk
		File.open(path, 'wb') do |f|
			f.write(file.read)
		end
		# Fix perms
		redirect to('/up')

	elsif params[:image] && params[:image][:filename]
		## the "api" branch
		filename = params[:image][:filename]
		file = params[:image][:tempfile]
		path = "#{BASE}#{filename}"
		# Write file to disk
		File.open(path, 'wb') do |f|
			puts path
			f.write(file.read)
		end
		return { 
			:bytesSent => 0, 
			:responseCode => 9000, 
			:response => 'Marvellous', 
			:headers => {:filename => filename}
		}.to_json
	end
end

