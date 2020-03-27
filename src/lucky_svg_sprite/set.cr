abstract class LuckySvgSprite::Set < Lucky::BaseComponent
  include SvgSprite::Set

  abstract def render_icons : IO

  def render
    tag "svg", class: svg_class, style: style, xmlns: "http://www.w3.org/2000/svg" do
      tag "defs" do
        render_icons
      end
    end
  end
end
