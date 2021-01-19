# Simple-Ruby-IRC-Bot
Made this bot as a simple auto-greeter for use on Twitch.TV

## Dependancies
I wrote this bot using ruby-2.7.0.

I have not tested it using any other ruby versions.

This bot also relies on the [cinch](https://github.com/cinchrb/cinch) gem.

install it using:
```
> gem install cinch
```

It is the framework that we use to automate our IRC input/output.

## Configuration
In order to log in to the Twitch.TV servers, you will need to provide your twitch username and OAuth token.

```
> ruby run_bot.rb username oauth_token
```

You will also need to inform the bot which channels to listen in on. This is configured in the local `channels.txt` file.

```
.
|____channels.txt
|____greetings.txt
|____lib
| |____helpers.rb
|____LICENSE
|____README.md
|____return_greetings.txt
|____run_bot.rb
```

**channels.txt**
```
#rgonzaleztechtips
#channeltwo
#channel_three
```

You can also customize the greeting phrases that the bot uses.

**greetings.txt**
```
Enjoy your stay!
Thanks for joining!
We're happy to have you!
One of us... One of us... gooble gobble

```

**return_greetings.txt**
```
Thanks for coming back!
Always glad to have you!
Pleasure as always

```
