
require 'open-uri'
require 'nokogiri'
require 'pry'
load 'Mon.rb'
# load 'Database.rb'
#
# URL_MON_LIST = 'https://summonerswar.co/category/monsters/page/'
# THREADS_TO_USE = 10
#
#
# db = Database.new URL_MON_LIST
# db.update(THREADS_TO_USE)
# binding.pry


#testing file
load 'Database.rb'
str = "!swc lapis"
BOT_PREFIX = "!"

str.sub!("#{BOT_PREFIX}swc ","")
puts str.to_s
db = Database.new 'URL_MON_LIST'
link = db.link_by_name(str)
puts link

puts "fetching link"
m = Mon.new link
