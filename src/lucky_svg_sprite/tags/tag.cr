abstract class LuckySvgSprite::Tag
  QUOTE      = '"'
  NAMED_TAGS = Lucky::BaseTags::TAGS +
               Lucky::BaseTags::EMPTY_TAGS +
               Lucky::BaseTags::RENAMED_TAGS.values.to_a
  ATTR_TO_AVOID       = %w[class id style]
  TOP_ATTR_TO_AVOID   = %w[height width version xmlns]
  COLOR_ATTR_TO_AVOID = %w[fill stroke]

  getter depth, tag, format

  def initialize(
    @tag : Myhtml::Node,
    @depth : Int32,
    @format : Format
  )
  end

  abstract def print_io(io : IO) : IO

  def padding
    " " * (depth * 2 + @format.indent)
  end

  def method_name
    if renamed_tag_method = Lucky::BaseTags::RENAMED_TAGS.to_h.invert[tag_name]?
      renamed_tag_method
    elsif custom_tag?
      "tag #{wrap_quotes(tag_name)}"
    else
      tag_name
    end
  end

  private def custom_tag?
    !NAMED_TAGS.map(&.to_s).includes?(tag_name)
  end

  def method_joiner
    if custom_tag?
      ", "
    else
      " "
    end
  end

  private def tag_name
    (depth == 0 && tag.tag_name == "svg") ? "symbol" : tag.tag_name
  end

  def attr_parameters
    params = convert_attributes_to_parameters
    params.push(%(id: "#{format.id_param}")) if format.id_param && depth == 0
    params.compact.sort_by do |string|
      string.gsub(/\"/, "")
    end
  end

  def attr_text
    attr_parameters.join(", ")
  end

  def convert_attributes_to_parameters
    tag.attributes.map do |key, value|
      if attribute_allowed?(key)
        if lucky_can_handle_as_symbol?(key)
          %(#{key.tr("-", "_")}: "#{value}")
        else
          %(#{wrap_quotes(key)}: "#{value}")
        end
      end
    end
  end

  private def attribute_allowed?(key)
    avoid = ATTR_TO_AVOID + (format.colorless ? COLOR_ATTR_TO_AVOID : %w[])
    !avoid.includes?(key) && (depth > 0 || !TOP_ATTR_TO_AVOID.includes?(key))
  end

  private def lucky_can_handle_as_symbol?(key)
    contains_only_alphanumeric_or_dashes?(key)
  end

  private def contains_only_alphanumeric_or_dashes?(key) : Bool
    (key =~ /[^\da-zA-Z\-]/).nil?
  end

  def squish(string : String)
    two_or_more_whitespace = /\s{2,}/
    string.gsub(two_or_more_whitespace, " ")
      .gsub(/\A\s+/, " ")
      .gsub(/\s+\Z/, " ")
  end

  private def wrap_quotes(string : String) : String
    QUOTE + string + QUOTE
  end
end
