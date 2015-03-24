class Recruit::EntriesController < Recruit::BaseController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  def new
    @entry = Entry.new(
      work_type: params[:type].to_sym,
      sex: :male,
      contact_means: :email,
      work_commencing_time: :asap,
      area_restriction: :unlimited,
      mail_sent: false
    )
  end

  def create
    @entry = Entry.new(entry_params)
    respond_to do |format|
      if @entry.save
        Entry.not_sent.each do |e|
          e.report
        end
        format.html { redirect_to :entries, notice: @entry.id }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      #リモートIPを保存
      params[:entry][:remote_ip] = request.remote_ip()
      permitted = params.require(:entry).permit(
        :sex,
        :work_type,
        :birthday,
        :postal_code,
        :address,
        :phone,
        :mail_addr,
        :mail_addr_confirmation,
        # :work_style,
        # :method,
        :remote_ip,
        :area_restriction,
        :lat,
        :lng,
        :name,
        :message,
        :contact_means,
        :mail_sent,
        :work_commencing_time,
        :work_times_0,:work_times_1,:work_times_2,:work_times_3,:work_times_4,:work_times_5,:work_times_6,
        :work_times_7,:work_times_8,:work_times_9,:work_times_10,:work_times_11,:work_times_12,:work_times_13,
        :work_times_14,:work_times_15,:work_times_16,:work_times_17,:work_times_18,:work_times_19,:work_times_20,
        :work_times_21,:work_times_22,:work_times_23,:work_times_24,:work_times_25,:work_times_26,:work_times_27,
        :work_times_28,:work_times_29,:work_times_30,:work_times_31,
        wished_shops: []
      )
      permitted[:wished_shops].select! do |k|
        !k.empty?
      end.collect! do |k|
        WishedShop.new(shop: Shop.find_by(id: k))
      end unless permitted[:wished_shops].nil? 
      permitted
    end
end
