class RetirementsController < ApplicationController
  def new
  end

  def create
    if current_user.destroy
      reset_session
      redirect_to(root_path, notice: "退会しました") and return
    end
    render :new, status: :unprocessable_entity
  end
end
