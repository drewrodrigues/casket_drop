module UsersHelper
  def bottom_fit_options
    ["Select your bottom fit", "Relaxed", "Skinny", "Straight"]
  end

  def top_size_options
    ["Select your top size", "SM", "MD", "LG", "XL"]
  end

  def waist_size_options
    ["Select your waist size"] + (28..36).to_a
  end
end
