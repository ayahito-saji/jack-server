class AttendanceController < ApplicationController
  def new
    calendar = Calendar::Calendar.new
    start_day = Time.now.midnight.since(1.days)
    end_day = start_day.since(7.days)

    slack = Slack::Slack.new

    res = ""

    calendar.events(start_day, end_day).each do |event|
      ['@saji.ayahito'].each do |member|
        data = {
            channel: member,
            as_user: true,
            attachments: [
                fallback: 'fallback string',
                title: "#{event.title} #{Time.zone.parse(event.start_time).strftime("%m/%d(%a) %H:%M")}〜",
                text: '未回答',
                callback_id: 'attendance_check',
                attachment_type: 'default',
                actions: [
                    {
                        name: 'attendance',
                        text: '出席する',
                        type: 'button',
                        style: 'primary',
                        value: '出席する'
                    },
                    {
                        name: 'midway_attendance',
                        text: '途中から参加',
                        type: 'button',
                        style: 'default',
                        value: '途中から参加'
                    },
                    {
                        name: 'absence',
                        text: '欠席する',
                        type: 'button',
                        style: 'danger',
                        value: '欠席する'
                    }
                ]
            ].to_json.to_s
        }
        res = slack.postMessage(data)
      end
    end
    render :json => JSON.dump(res)
  end
end
