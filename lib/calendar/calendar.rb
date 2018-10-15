module Calendar
  class Calendar
    require 'google_calendar'
    def initialize
      @calendar = Google::Calendar.new(
          {
              client_id: ENV['GOOGLE_CALENDAR_CLIENT_ID'],
              client_secret: ENV['GOOGLE_CALENDAR_CLIENT_SECRET'],
              calendar: ENV['GOOGLE_CALENDAR_ID'],
              redirect_url: 'urn:ietf:wg:oauth:2.0:oob'
          })
      @calendar.login_with_refresh_token('1/RDcEFVBGUcpgS6FoqXQ4bYBdheX75INJHBgu8piY0wiwRju7GWC7uf2Km-hobvNR')
    end
    def events(min, max)
      @calendar.find_events_in_range(min, max).each
    end
  end
end