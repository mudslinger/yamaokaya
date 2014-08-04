class Feedback < ActiveRecord::Base
  include FeedbackReportable
  validates :name,presence: true
  validates :mail_addr,{
    presence: true,
    confirmation: true,
    format: {
      with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/}
  }
  validates :mail_addr_confirmation,presence:true
  belongs_to :shop
  belongs_to :menu
  scope :not_sent, -> { where(mail_sent: false)}

  attr :mail_addr_confirmation

  enum quality: {q_excellent: 2,q_good: 1,q_moderate: 0,q_bad: -1,q_terrible: -2}
  enum service: {s_excellent: 2,s_good: 1,s_moderate: 0,s_bad: -1,s_terrible: -2}
  enum cleanliness: {c_excellent: 2,c_good: 1,c_moderate: 0,c_bad: -1,c_terrible: -2}
  enum atomosphere: {a_excellent: 2,a_good: 1,a_moderate: 0,a_bad: -1,a_terrible: -2}

  def q_point
    Feedback.qualities[quality]
  end
  def s_point
    Feedback.services[service]
  end  
  def c_point
    Feedback.cleanlinesses[cleanliness]
  end  
  def a_point
    Feedback.atomospheres[atomosphere]
  end

  enum age: {
    ageunder12: 12,
    age13to15: 13,
    age16to19: 16,
    age20to24: 20,
    age25to29: 25,
    age30to34: 30,
    age35to39: 35,
    age40to44: 40,
    age45to49: 45,
    age50to54: 50,
    age55to59: 55,
    age60to64: 60,
    age65to69: 65,
    age70over: 70
  }

  def age_number
    Feedback.ages[age]
  end

  enum visit_time: {
    time9to10:9,
    time10to11:10,
    time11to12:11,
    time12to13:12,
    time13to14:13,
    time14to15:14,
    time15to16:15,
    time16to17:16,
    time17to18:17,
    time18to19:18,
    time19to20:19,
    time20to21:20,
    time21to22:21,
    time22to23:22,
    time23to0:23,
    time0to1:0,
    time1to2:1,
    time2to3:2,
    time3to4:3,
    time4to5:4,
    time5to6:5,
    time6to7:6,
    time7to8:7,
    time8to9:8
  }
  def visit_time_number
    Feedback.visit_times[visit_time]
  end
  enum repetition:{
    first_time: 0,
    once_par_year: 1,
    once_par_half: 2,
    once_par_quater: 4,
    once_par_month: 12,
    twice_par_month: 24,
    once_par_week: 48,
    twice_par_week: 96,
    holic: 180
  }
  def repetition_number
    Feedback.repetitions[repetition]
  end
end
