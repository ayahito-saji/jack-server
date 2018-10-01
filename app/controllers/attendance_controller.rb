class AttendanceController < ApplicationController
  def new
    slack = Slack::Slack.new
    res = slack.attendanceCheck
    render :json => res
  end
  def create
  end
end
