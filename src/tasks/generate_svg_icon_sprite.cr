class GenerateSvgIconSprite < LuckyCli::Task
  summary "Generates a SVG sprite from the available icons"
  name "gen.svg_icon_sprite"

  def call
    number = 0

    puts "Done adding #{number} icon#{'s' unless number == 1}"
  end
end
