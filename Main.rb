require 'discordrb'
require 'open-uri'
require 'nokogiri'
require 'pry'

load 'Database.rb'
load 'Mon.rb'

URL_MON_LIST = 'https://summonerswar.co/category/monsters/page/'
THREADS_TO_USE = 10

BOT_TOKEN = ENV['TOKEN'] #replace with bot token
BOT_PREFIX = "!" #replace with prefix

puts "Starting Bot..."
db = Database.new URL_MON_LIST
db.update(THREADS_TO_USE)

bot = Discordrb::Commands::CommandBot.new token: BOT_TOKEN, prefix: BOT_PREFIX
puts "Bot ready!"
bot.command(:swc, min_args: 1, max_args: 1, description: 'Finds the info about the mon on summonerswar.co', usage: 'swc lapis || swc light-serpent [use hyphen for space]') do |_event, min, max|

  str = _event.message.to_s
  str.sub!("#{BOT_PREFIX}swc ","")
  link = db.link_by_name(str)
  mon = Mon.new link
  _event.channel.send_embed do |embed|
    embed.title = mon.title
    embed.colour = 0x205b6f
    embed.url = link
    embed.description = "Description of #{mon.title.to_s.strip}"

    embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: mon.icon_url)
    embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: "summonerswar.co", url: "https://summonerswar.co", icon_url: "https://43ch47qsavx2jcvnr30057vk-wpengine.netdna-ssl.com/wp-content/uploads/2016/10/favicon-96x96.png")
    embed.add_field(name: "Grade", value: mon.grade,inline: true)
    embed.add_field(name: "Type", value: mon.type,inline:true)
    embed.add_field(name: "Get From", value: mon.get_from)
    embed.add_field(name: "Awakened", value: mon.awaken)
    embed.add_field(name: "Good for", value: mon.good_for)
    embed.add_field(name: "Worth", value: mon.skillup)
  end
end


bot.run
