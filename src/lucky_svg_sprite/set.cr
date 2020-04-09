abstract class LuckySvgSprite::Set < Lucky::BaseComponent
  include LuckySvgSprite::Mixins::Set

  abstract def render_icons

  def render
    tag "svg", class: class_name, style: style, xmlns: "http://www.w3.org/2000/svg" do
      tag "defs" do
        render_icons
      end
    end
  end
end
