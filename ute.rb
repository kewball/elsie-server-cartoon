module Ute
  ## Roll ID format: "Roll301"
  BASE = "#{Dir.pwd}/public/elsie-uploads"
  
  def contents
    out=[]
    Dir.glob("#{BASE}/Roll*").each do |d|
      out.push( d.split('/').pop() )
    end
    out
  end

  def numbers(inray)
    outray=[]
    inray.each do |n|
      tmp = n.split("Roll").last 
      unless tmp == ""
        outray.push tmp
      end
    end
    outray
  end

  def next_name(inray)
    jef = inray.sort.pop
    return "Roll#{jef.to_i + 1}"
  end

  def make_next (the_name)
    Dir.mkdir("#{BASE}/#{the_name}")
    Dir.mkdir("#{BASE}/#{the_name}/files")
    return Dir.glob("#{BASE}/#{the_name}*")
  end

end

# include Ute

# ## Roll ID format: "Roll301"
# # for testing, tell Ute this: 
# #     BASE = "#{Dir.pwd}/public/testes" # or whatever...

# bil = Ute.contents
# biz = Ute.numbers(bil)
# bob = Ute.next_name(biz)
# boz = Ute.make_next(bob)

# bil.each do |x| 
#   puts "bil #{x}"
# end
# biz.each do |x| 
#   puts "biz #{x}"
# end
# puts "bob #{bob}"
# puts "boz #{boz}"
# filename = params[:image][:filename]                                                                               
# [ ] on filename == "jayson.txt"
# [x] generate next "roll ID"
# [x] create "roll ID" in ~/stubby
# [ ] set that as BASE+rollID for this and subsequent uploads
# [ ] include "roll ID" in the response{header{envelope:"roll ID"}}

