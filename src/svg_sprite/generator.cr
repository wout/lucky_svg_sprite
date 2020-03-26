class SvgSprite::Generator
  def initialize(@path : String)
  end

  def icons
    Dir.glob("#{@path}/*.svg")
  end
end
