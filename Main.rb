require 'discordrb'

BOT_TOKEN = ENV['TOKEN'] #replace with bot token

bot = Discordrb::Bot.new token: BOT_TOKEN

bot.message(with_text: 'Ping!') do |event|
  event.respond 'Pong!'
end

bot.run
