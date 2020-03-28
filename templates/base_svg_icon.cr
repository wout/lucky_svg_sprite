# Use this intermediate class to customize how the icons are rendered to HTML.
# More info:
# https://github.com/tilishop/lucky_svg_sprite.cr#customizing-attributes
abstract class BaseSvgIcon < LuckySvgSprite::Icon
  needs name : String
end
