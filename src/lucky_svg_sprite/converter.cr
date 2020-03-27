class LuckySvgSprite::Converter
  getter output = IO::Memory.new

  def initialize(
    @input : String,
    @colorless : Bool = false
  )
  end

  def convert : String
    html = Myhtml::Parser.new(@input)
    body = html.body!
    body.children.each do |child_tag|
      convert_tag(child_tag)
    end
    output.to_s
  end

  def convert_tag(tag)
    TagFactory.new(tag, depth: 0, colorless: @colorless).build.print_io(output)
  end
end
