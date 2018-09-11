module UsersHelper
  def bottom_fit_options
    %w(Skinny Straight Relaxed)
  end

  def shoe_size_options
    [7, 7.5, 8, 8.5, 9, 9.5, 10, 10.5, 11, 11.5]
  end

  def style_options
    %w(Athletic Casual Formal Hipster Street)
  end

  def top_size_options
    %w(SM MD LG XL)
  end

  def waist_size_options
    (28..40).to_a
  end
end
