abstract class LuckySvgSprite::Icon < Lucky::BaseComponent
  include SvgSprite::Icon

  needs name : String
  needs set : String = "default"

  def render
    tag "svg", class: svg_class do
      tag "use", "xlink:href": "#svg-#{@set}-#{@name}-icon"
    end
  end
end
