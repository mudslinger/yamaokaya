class Entry < ActiveRecord::Base
	include EntryReportable

	scope :not_sent, -> { where.not(mail_sent: true)}

	enum sex: {male: 0, female: 1}
	enum work_type: {graduates2:0, career:1, pa:2}
	enum contact_means: {phone:0, email:1}
	enum work_commencing_time: {asap:0, within_a_month:1, other:2}
	enum area_restriction: {unlimited: 0,pref_only: 1,city_only: 2}
	has_many :wished_shops
	validates :name,presence: true
	validates :birthday,presence: true
	validates :postal_code,presence:true
	validates :address,presence:true
	validates :phone,presence:true
	validates :mail_addr,{
		presence: true,
		confirmation: true,
		format: {
		  with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/}
		}
	validates :mail_addr_confirmation,presence:true


	def age
		DateTime.now.year - (self[:birthday]).year
	end
	# def postal_code
	# 	Integer((self[:postal_code]|| 0).gsub(/[^0-9]/,'')).to_s.rjust(7,'0').gsub(/^(\d{3})(\d{4})$/){ $1 + '-' + $2 }
	# end

	# def postal_code=(value)
	# 	self[:postal_code] = Integer(value.gsub(/[^0-9]/,'')).to_s.rjust(7,'0').gsub(/^(\d{3})(\d{4})$/){ $1 + '-' + $2 }
	# end

	#動的メソッドの追加
	(0..31).each do |i|
		define_method("work_times_#{i}") do
			
			self.work_times = 0 if self.work_times.nil? 
			(self.work_times & (1 << i)).zero? ? 0 : 1
		end
		define_method("work_times_#{i}=") do |sv|
			v = sv.to_i
			v = 1 if v > 1
			v = 0 if v < 0
			self.work_times = 0 if self.work_times.nil?
			self.work_times = self.work_times | (v << i)
		end
	#attr "work_times_#{i}".to_sym
	end
end
