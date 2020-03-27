module LuckySvgSprite::Mixins::Icon
  macro included
    getter name : String
  end

  def class_name
    "svg-icon svg-#{set}-icon svg-#{set}-#{name}-icon"
  end

  def set
    {{@type.id.split("::")[-2].underscore.gsub(/_/, "-")}}
  end
end
