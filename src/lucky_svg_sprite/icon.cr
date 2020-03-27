abstract class LuckySvgSprite::Icon < Lucky::BaseComponent
  include LuckySvgSprite::Mixins::Icon

  def initialize(@name : String)
  end

  def render
    tag "svg", class: class_name do
      tag "use", "xlink:href": "#svg-#{set}-#{name}-icon"
    end
  end
end
