# encoding: utf-8

require 'twitter'
require 'optparse'
options={}

OptionParser.new do |opt|

  opt.banner='Usage: twitter.rb [options]'
  opt.on('-h', 'вывод помощи') do
    puts opt
    exit
  end
  opt.on('--twit "TWIT", "Zatwitit"') { |o| options[:twit]=o }
  opt.on('--timeline USER_NAME', 'Последние твиты') { |o| options[:timeline]=o } #
end.parse!

client=Twitter::REST::Client.new do |config|
  config.consumer_key='C9TkOjG6e5eLrqLtT2yJZSBvA'
  config.consumer_secret='VlRJ89e5UhQ1mKCuWKajEMZGbdQhymb902Fd32mtnVrWzBjN2R'
  config.access_token='4832082772-Bw7Em1ZWsBcWNhzA00ij70NjJMeUwuLNyOuBIjM'
  config.access_token_secret='jxi6E0PXRbSWx2OIgr6tu44R0lKyxk6YGiNoFzPst8T9W'
end

if options.key?(:twit)
  puts "Постим твит"
  client.update(options[:twit])
  puts "Готово"
end

if options.key?(:timeline)
  puts "лента юзера: #{options[:timeline]}"
  opts={count: 7, include_rts: true}
  twits=client.user_timeline(options[:timeline], opts)
  twits.each do |twit|
    puts twit.text
    puts "by @#{twit.user.screen_name}, #{twit.created_at}"
    puts "-"*40
  end

else

  puts "моя лента"

  twits=client.home_timeline({count: 5})
  twits.each do |twit|
    puts twit.text
    puts "by @#{twit.user.screen_name}, #{twit.created_at}"
    puts "-"*40
  end

end



