require "./tag"

class LuckySvgSprite::MultiLineTag < LuckySvgSprite::Tag
  BLOCK_START = " do\n"
  BLOCK_END   = "end"

  def print_io(io) : IO
    io << padding
    io << method_name
    if attr_parameters.any?
      io << method_joiner
      io << attr_text
    end
    children(io)
    io << "\n"
  end

  private def children(io)
    if children?
      io << BLOCK_START
      tag.children.each do |child_tag|
        TagFactory.new(child_tag, depth + 1, format).build.print_io(io)
      end
      io << padding + BLOCK_END
    end
  end

  private def children?
    tag.children.size > 0
  end
end
