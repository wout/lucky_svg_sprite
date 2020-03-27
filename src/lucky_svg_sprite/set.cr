abstract class LuckySvgSprite::Set < Lucky::BaseComponent
  include SvgSprite::Set

  needs name : String = "default"

  abstract def svg_icons

  def render
    tag "svg", class: svg_class, style: style, xmlns: "http://www.w3.org/2000/svg" do
      tag "defs" do
        svg_icons(@name)
      end
    end
  end
end
