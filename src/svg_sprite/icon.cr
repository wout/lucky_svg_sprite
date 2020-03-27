module SvgSprite::Icon
  def svg_class
    "svg-icon svg-#{@set}-icon svg-#{@set}-#{@name}-icon"
  end
end
