class MembersController < ApplicationController
  def index
    @members = Member.all
  end
  def new
  end
  def create
  end
  def show
    @member = Member.find_by(member_id: params[:member_id])
  end
  def edit
  end
  def update
  end
  def destroy
  end
end
