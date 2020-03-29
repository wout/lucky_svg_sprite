class LuckySvgSprite::Converter
  getter output = IO::Memory.new
  getter format

  def initialize(
    @input : String,
    @format : Format = Format.new
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
    factory = TagFactory.new(tag, depth: 0, format: format)
    factory.build.print_io(output)
  end

  def self.from_file(
    file : String,
    format : Format = Format.new
  )
    format.id_param = id_for_icon(file)
    new(File.read(file), format).convert
  end

  def self.id_for_icon(file : String)
    parts = file
      .gsub(/\.svg$/i, "")
      .underscore
      .gsub(/[-_\.\s]+/, '-')
      .split('/')
      .map { |p| p
        .gsub(/^-|-$/, "")
        .gsub(/^\d+-/, "") }
    "svg-#{parts[-2]}-#{parts[-1]}-icon"
  end
end
