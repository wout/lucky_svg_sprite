require "option_parser"

class GenerateSvgSprite < LuckyCli::Task
  summary "Generates a SVG sprite from the available icons for a given set"
  name "gen.svg_sprite"

  @strip_colors : Bool = false

  def call
    parse_options(ARGV)
    ensure_target_structure

    generator = LuckySvgSprite::Generator.new(icon_set_path)
    generate_sprite(generator)

    puts generated_message(generator)
  rescue e : Exception
    puts e.message.colorize.red
  end

  private def icon_set_name
    ARGV.first? || "default"
  end

  private def base_path
    "./src/components"
  end

  private def templates_path
    "./lib/lucky_svg_sprite/templates"
  end

  private def sprites_path
    "#{base_path}/svg_sprites"
  end

  private def icon_set_path
    "#{base_path}/svg_icons/#{icon_set_name}"
  end

  private def sprite_file_name
    "#{sprites_path}/#{icon_set_name}.cr"
  end

  private def generate_sprite(generator : LuckySvgSprite::Generator)
    format = LuckySvgSprite::Format.new(colorless: @strip_colors)
    File.write(sprite_file_name, generator.generate(format))
  end

  private def generated_message(generator : LuckySvgSprite::Generator)
    size = generator.icons.size
    sprite = "SvgSprite::#{generator.sprite_name}".colorize.cyan

    "Generated #{sprite} with #{size} icon#{'s' unless size == 1}"
  end

  private def ensure_target_structure
    if !File.exists?(icon_set_path)
      raise %(Icon set "#{icon_set_path}" does not exist)
    elsif !File.exists?(sprites_path)
      raise %(Target dir "#{sprites_path}" does not exist)
    end
  end

  private def initial_setup
    [sprites_path, icon_set_path].each do |dir|
      if File.exists?(dir)
        puts %(Skipping "#{dir}" as it already exists).colorize.yellow
      else
        Dir.mkdir_p(dir)
        puts %(Created "#{dir}").colorize.green
      end
    end

    if Dir.glob("#{icon_set_path}/*.svg").empty?
      example = "#{icon_set_path}/example.svg"
      copy_file("#{templates_path}/example.svg", example)
    end

    %w[icon sprite].each do |name|
      name = "base_svg_#{name}.cr"
      if File.exists?(file = "#{base_path}/#{name}")
        puts %(Skipping "#{file}" as it already exists).colorize.yellow
      else
        copy_file("#{templates_path}/#{name}", "#{base_path}/#{name}")
      end
    end
  end

  private def parse_options(args)
    OptionParser.parse(args) do |parser|
      parser.on("-s", "--strip-colors", "Strips all fill and stroke attributes from SVG nodes") do
        @strip_colors = true
      end
      parser.on("--init", "Puts all required files and folders in the right places") do
        initial_setup
        exit
      end
    end
  end

  private def copy_file(source : String, target : String)
    File.write(target, File.read(source))
    puts %(Created "#{target}").colorize.green
  end
end
