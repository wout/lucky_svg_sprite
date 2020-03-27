module SvgSprite::Set
  def style
    "display:none"
  end

  def class_name
    "svg-sprite svg-#{name}-set"
  end

  def name
    {{@type.id.split("::").last.underscore.gsub(/_/, "-")}}
  end
end
