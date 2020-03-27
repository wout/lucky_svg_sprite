class SvgSprite::Generator
  def initialize(@path : String)
  end

  def icons
    Dir.glob("#{@path}/*.svg")
  end

  def generate : String
    icons.map do |icon|
      Converter.new(icon).convert
    end.join("\n\n")
  end
end
