module SvgSprite::Icon
  def href
    "#svg-#{@set}-#{@name}-icon"
  end

  def svg_class
    "svg-#{@set}-icon svg-#{@set}-#{@name}-icon"
  end
end
