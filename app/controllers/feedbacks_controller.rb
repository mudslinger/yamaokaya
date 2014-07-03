class FeedbacksController < ApplicationController
  layout :domain_layout
  def new
    @feedback = Feedback.new(
      quality: :q_moderate,
      service: :s_moderate,
      cleanliness: :c_moderate,
      atomosphere: :a_moderate,
      reply: :true
    )
  end

  def create
    @feedback = Feedback.new(feedback_params)
    respond_to do |format|
      if @feedback.save
        Feedback.not_sent.each do |f|
          f.report
        end
        format.html { redirect_to :feedbacks, notice: @feedback.id }
        format.json { render :show, status: :created, location: @feedback }
      else
        format.html { render :new }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def set_feedback
    @feedback = Feedback.find(params[:id])
  end

  def feedback_params
    params[:feedback][:remote_ip] = request.remote_ip()
    params[:feedback][:mail_sent] = false

    params.require(:feedback).permit(
      :mail_addr,:name,:age,:male,:address,:phone,:lat,:lng,:region,
      :shop_id,:menu_id,:visit_date,:visit_time,:repetition,
      :quality,:service,:cleanliness,:atomosphere,:reply,
      :message,:mail_sent,:remote_ip,:mail_addr_confirmation
    )
  end
end
