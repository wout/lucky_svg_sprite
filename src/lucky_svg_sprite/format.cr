class LuckySvgSprite::Format
  property colorless, id_param, indent

  def initialize(
    @colorless = false,
    @indent = 0,
    @id_param : String? = nil
  )
  end
end
