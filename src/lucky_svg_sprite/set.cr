abstract class LuckySvgSprite::Set < Lucky::BaseComponent
  include SvgSprite::Set

  needs name : String = "default"

  abstract def svg_icons

  def render
    tag "svg", id: id, xmlns: "http://www.w3.org/2000/svg", style: style do
      tag "defs" do
        svg_icons
      end
    end
  end
end
