require 'line/bot'

class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    body = request.body.read
    events = client.parse_events_from(body)
    events.each do |event|
      message = {
        type: 'text',
        text: event.message['text'] || event.type
      }
      response = client.reply_message(event['replyToken'], message)
      pp response
    end
    head :ok
  rescue => e
    pp e
    head :ok
  end

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = 'cb9fb5cdb7c1c8dca8ab81eb26542515'
      config.channel_token = 'DSA7s5gRjVPttdQKJz34BcLqwPeBh+Jt5UZrAe1VG/QDOj1bBlDgUbf6yd+kdr7jfgqHyAnKFKLGlDTPl88gYzTmpwSVCzhnH733mrzAyCUsF+rYjXsOChvbXc/AkxqrljEtNWMDO8NlkFgSMFo0IwdB04t89/1O/w1cDnyilFU='
    end
  end
end
