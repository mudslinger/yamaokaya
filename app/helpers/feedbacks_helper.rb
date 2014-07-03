module FeedbacksHelper
  def age_opts
    Feedback.ages.map do |e|
      [Feedback.human_attribute_name(e[0]),e[0]]
    end
  end
  def rep_opts
    Feedback.repetitions.map do |e|
      [Feedback.human_attribute_name(e[0]),e[0]]
    end
  end
  def time_opts
    Feedback.visit_times.map do |e|
      [Feedback.human_attribute_name(e[0]),e[0]]
    end
  end

  def categorized_menu_opts
    c = Struct.new('Category',:id,:name,:menus)
    Menu.categories.map do |e|
      c.new(e[1],e[0],Menu.send(e[0]))
    end
  end
end
