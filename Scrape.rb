
require 'open-uri'
require 'nokogiri'
require 'pry'
load 'Mon.rb'
load 'DBMon.rb'
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
str = "!swc emma"
BOT_PREFIX = "!"

str.sub!("#{BOT_PREFIX}swc ","")
puts str.to_s
db = DBMon.new str
puts db

puts "fetching link"
