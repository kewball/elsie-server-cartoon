require 'rubygems'
require 'sinatra'
require 'json'
require './ute' ; include Ute

BASE = "./public/testes"

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
		redirect to('/up')

		# vagrant@drcrook elsie-sinatra-server » ruby ute.rb 
		# bil Roll2
		# bil Roll1
		# biz 2
		# biz 1
		# bob Roll3
		# boz ["/home/vagrant/src/elsie-sinatra-server/public/testes/Roll3"]

	elsif params[:image] && params[:image][:filename]
		## the "api" branch
		path = false
		filename = params[:image][:filename]
	
		## is this time to prepare for a new roll of pictures?
		if filename == 'jayson.txt'
			@bil = Ute.contents
			@biz = Ute.numbers(@bil)
			@bob = Ute.next_name(@biz)
			@boz = Ute.make_next(@bob)
			@path = @boz.pop
		end
		
		if @path
			fullpath = "#{@path}/#{filename}"
			file = params[:image][:tempfile]
			# Write file to disk
			File.open(fullpath, 'wb') do |f|
				puts fullpath
				f.write(file.read)
			end
			response = { 
				:bytesSent => 0, 
				:responseCode => 200, 
				:response => 'Marvellous', 
				:headers => {:filename => filename, :folder => @path}
			}.to_json
		else
			response = { 
				:bytesSent => 0, 
				:responseCode => 500, 
				:response => 'ERROR', 
				:headers => {:filename => filename, 
					:folder => {
						bil: @bil, biz: @biz, bob: @bob, boz: @boz
					}
				}
			}.to_json
		end

		return response

	end
end

