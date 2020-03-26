abstract class LuckySvgSprite::Icon < Lucky::BaseComponent
  include SvgSprite::Icon

  needs name : String

  def render
    tag "svg", class: svg_class do
      tag "use", "xlink:href": href, class: use_class
    end
  end
end
