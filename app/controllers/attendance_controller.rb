class AttendanceController < ApplicationController
  def new
    calendar = Calendar::Calendar.new
    start_day = Time.now.midnight.since(1.days)
    end_day = start_day.since(7.days)

    slack = Slack::Slack.new

    res = ""

    # Googleカレンダーのイベントを取得して，同期
    calendar.events(start_day, end_day).each do |g_event|

      # g_eventがなければ，取得する
      event = Event.find_by(event_id: g_event.id)
      unless event
        event = Event.create(
            {
                event_id: g_event.id,
                title: g_event.title,
                place: g_event.location,
                description: g_event.description,
                start_at: Time.zone.parse(g_event.start_time),
                end_at: Time.zone.parse(g_event.end_time)
            }
        )
      end

      Member.all.each do |member|
        member_event = MemberEvent.find_by(member: member, event: event)
        unless member_event
          data = {
              channel: member.slack_id,
              as_user: true,
              attachments: [
                  fallback: event.event_id,
                  title: "#{event.title} #{event.start_at.strftime("%m/%d(%a) %H:%M")}〜",
                  text: "未回答 https://jack-server.herokuapp.com/events/#{event.event_id}",
                  callback_id: 'attendance_check',
                  attachment_type: 'default',
                  actions: [
                      {
                          name: '出席する',
                          text: '出席する',
                          type: 'button',
                          style: 'primary',
                          value: '0'
                      },
                      {
                          name: '途中から参加',
                          text: '途中から参加',
                          type: 'button',
                          style: 'default',
                          value: '1'
                      },
                      {
                          name: '欠席する',
                          text: '欠席する',
                          type: 'button',
                          style: 'danger',
                          value: '2'
                      }
                  ]
              ].to_json.to_s
          }
          res = slack.postMessage(data)
        end
      end
    end
    render :json => JSON.dump(res)
  end
end
