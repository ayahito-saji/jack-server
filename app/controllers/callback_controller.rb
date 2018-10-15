class CallbackController < ApplicationController
  protect_from_forgery :except => [:slack]
  require 'pp'
  require 'json'
  def slack
    if params['command']
      @body = params
      case params['command']
        when '/jack_atd'
          jack_atd
      end
      render plain: ""
    else
      @body = JSON.parse(params['payload'])
      case @body['type']
        when 'url_verification'
          render json: @body
        when 'interactive_message'
          case @body['callback_id']
            when 'attendance_check'
              attendance_check()
          end
          render plain: ""
      end
    end
  end
  private
  def attendance_check

    data = @body['original_message']
    data['channel'] = @body['channel']['id']
    data['ts'] = @body['message_ts']
    data['attachments'][0]['text'] = @body['actions'][0]['value']
    data['attachments'] = data['attachments'].to_json.to_s

    slack = Slack::Slack.new
    res = slack.update(data)
    pp res
  end

  # 出席者一覧を表示するコマンド
  def jack_atd

    data = {
        channel: @body['user_id'],
        as_user: true,
        text: ' */jack_atd*',
        attachments: [
            {
                title: "出席する (#{Member.count})",
                text: (Member.all.map {|member| "<@#{member.slack_id}>"}).join(", "),
                color: "#5cb85c"
            },
            {
                title: "途中から出席 (0)",
                text: "",
                color: "#4f4f4f"
            },
            {
                title: "欠席する (0)",
                text: "",
                color: "#d9534f"
            },

        ].to_json.to_s
    }

    slack = Slack::Slack.new
    res = slack.postMessage(data)
  end

end
