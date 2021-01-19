require 'cinch'

require_relative 'lib/helpers.rb'

username = get_arg(0)
password = get_arg(1)

input_channels = read_config("./channels.txt")
input_greetings = read_config("./greetings.txt")
input_return_greetings = read_config("./return_greetings.txt")

# Where we will 'remember'
unless File.exist?("./met")
  Dir.mkdir("./met")
end

# Which Channels We Will Listen For:
bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.chat.twitch.tv"
    c.port = 6697
    c.ssl.use = true
    c.nick = "#{username}"
    c.realname = "#{username}"
    c.user = "#{username}"
    c.password = "oauth:#{password}"
    c.channels = input_channels
  end

  on :connect do |c|
    bot.irc.send("CAP REQ :twitch.tv/membership")
  end

  on :message do |j|
    if j.user.nick != bot.nick && j.user.nick != j.channel.name[1..-1]
      # Not me
      greet = false
      returning = false
      
      file_name = "met/#{j.channel.name}/#{j.user.nick}.mem"
      if File.exist?(file_name)
        if (Time.now() > File.ctime(file_name) + (12 * 60 * 60))
          # It's been over 2 hours
          greet = true
          returning = true
        end
      else
        # Create the channel's 'remember' folder
        unless File.exist?("./met/#{j.channel.name}")
          Dir.mkdir("./met/#{j.channel.name}")
        end
        
        greet = true
      end

      if greet
        # Delete & Re-Create File.
        # This resets the file's "created_at" time
	File.delete(file_name) if File.exist?(file_name)
        File.open(file_name, "w") do |f| f.write("#{Time.now}") end
        
        if returning
          j.reply "Welcome back, #{j.user.nick}! #{input_return_greetings.sample}"
        else
          j.reply "Welcome, #{j.user.nick}! #{input_greetings.sample}"
        end
      end
    end
  end
end

bot.start
