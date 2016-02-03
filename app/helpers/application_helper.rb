module ApplicationHelper
  def category_helper(multiplier)
    return "Child" if multiplier == 1
    return "Adult" if multiplier == 2
    return "#{multiplier/2.to_f} Adult"
  end
end
