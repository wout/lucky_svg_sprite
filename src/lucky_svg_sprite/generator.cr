class LuckySvgSprite::Generator
  def initialize(@path : String)
  end

  def icons
    Dir.glob("#{@path}/*.svg").sort
  end

  def concatenate(format : Format)
    icons.map do |icon|
      Converter.from_file(icon, format)
    end.join("\n").strip
  end

  def namespace
    @path.strip
      .gsub(/\/$/, "")
      .split('/').last
      .gsub(/[\.\-\s]+/, "_")
      .camelcase
      .gsub(/^\d+/, "")
  end

  def generate(format : Format)
    format.indent = 4
    <<-CODE
    class SvgSprite::#{namespace} < BaseSvgSprite
      def render_icons : IO
        #{concatenate(format)}
      end

      class Icon < BaseSvgIcon
      end
    end
    CODE
  end
end
