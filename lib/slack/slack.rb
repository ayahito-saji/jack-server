module Slack
  class Slack
    require 'net/http'
    require 'uri'
    require 'json'

    # activeなメンバーリストを取得
    def getActiveMembersList
      return getMembersListWithoutBot.select{|member| (!member['deleted'])}
    end

    # bot以外のメンバーリストを取得
    def getMembersListWithoutBot
      return getMembersList.select{|member| (!member['is_bot']) && (member['id'] != 'USLACKBOT')}
    end

    # メンバーリストを取得
    def getMembersList
      url = 'https://slack.com/api/users.list'
      data = {}
      data['token'] = ENV['SLACK_BOT_TOKEN']

      res = JSON.parse(post(url, data))
      return res['members']
    end

    # メッセージを投げる
    def postMessage(data)
      url = 'https://slack.com/api/chat.postMessage'
      data['token'] = ENV['SLACK_BOT_TOKEN']

      JSON.parse(post(url, data))
    end

    # メッセージを更新する
    def update(data)
      url = 'https://slack.com/api/chat.update'
      data['token'] = ENV['SLACK_BOT_TOKEN']

      JSON.parse(post(url, data))
    end

    private
    def post(url, data)
      escaped_url=URI.escape(url)
      uri = URI.parse(escaped_url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      req = Net::HTTP::Post.new(uri.request_uri)

      req.set_form_data(data)

      res = http.request(req)
      return res.body
    end
  end
end