module SvgSprite::Set
  def style
    "display:none"
  end

  def svg_class
    "svg-sprite svg-#{@name}-sprite"
  end
end
