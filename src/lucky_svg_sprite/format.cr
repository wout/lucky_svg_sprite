class LuckySvgSprite::Format
  property id_param, indent, strip

  def initialize(
    @id_param : String? = nil,
    @indent = 0,
    @strip = %w[]
  )
  end
end
