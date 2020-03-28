class LuckySvgSprite::TagFactory
  TEXT_TAG_NAME = "-text"

  getter depth, tag, format

  def initialize(
    @tag : Myhtml::Node,
    @depth : Int32,
    @format : Format
  )
  end

  def build : Tag
    tag_class.new(tag, depth, format)
  end

  private def tag_class : Tag.class
    if text_tag?(tag)
      TextTag
    elsif single_line_tag?(tag)
      SingleLineTag
    else
      MultiLineTag
    end
  end

  def single_line_tag?(tag)
    return false if tag.children.to_a.size != 1
    child_tag = tag.children.to_a.first
    return false unless text_tag?(child_tag)
    return true if child_tag.tag_text =~ /\A\s*\Z/
    return false if child_tag.tag_text =~ /\n/
    true
  end

  def text_tag?(tag)
    tag.tag_name == TEXT_TAG_NAME
  end
end
