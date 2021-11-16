abstract class LuckySvgSprite::Icon < Lucky::BaseComponent
  include LuckySvgSprite::Mixins::Icon

  def render
    tag "svg", class: class_name do
      tag "use", "xlink:href": "#svg-#{set}-#{name}-icon"
    end
  end

  class Raw < Lucky::BaseComponent
    needs set : String
    needs name : String
    needs class_name : String? = nil

    def render
      tag "svg", class: class_name do
        tag "use", "xlink:href": "#svg-#{@set}-#{@name}-icon"
      end
    end

    private def class_name
      @class_name || "svg-icon svg-#{@set}-icon svg-#{@set}-#{@name}-icon"
    end
  end
end
