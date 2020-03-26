module SvgSprite::Icon
  def href
    "#svg-#{@name}-icon"
  end

  def svg_class
    "svg-icon svg-#{@name}-icon"
  end

  def use_class
    ""
  end
end
