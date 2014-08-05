class TopMessagesController < ApplicationController
  include TopMessagesHelper
  skip_before_filter :set_title
  layout false

  def show
      @type = params[:type].to_sym if  params[:type].present?
      @key = 0
      @key = params[:key].to_i if params[:key].present?

      list = TopMessage.articles(@type)
      @entry = list[@key]
      @prev_entry = @key == 0 ? nil : list[@key-1]
      @next_entry = @key < list.size ? list[@key+1] : nil
  end
end
