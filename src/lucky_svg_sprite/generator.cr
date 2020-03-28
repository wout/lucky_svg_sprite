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

  def sprite_name
    @path.strip
      .gsub(/\/$/, "")
      .split('/').last
      .underscore
      .gsub(/[\.\-\s]+/, "_")
      .gsub(/^_|_$/, "")
      .camelcase
      .gsub(/^\d+/, "")
  end

  def generate(format : Format)
    format.indent = 4
    <<-CODE
    class SvgSprite::#{sprite_name} < BaseSvgSprite
      def render_icons : IO
        #{concatenate(format)}
      end

      class Icon < BaseSvgIcon
      end
    end
    CODE
  end
end
