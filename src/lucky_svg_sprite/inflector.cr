module LuckySvgSprite::Inflector
  def self.dasherize(
    value : String,
    from_path = false,
    from_class = false
  )
    value = File.basename(value, File.extname(value)) if from_path
    value = classify(value) if from_class
    Cadmium::Transliterator.parameterize(value.underscore.gsub(/_/, "-"))
  end

  # Convert a given string in to a classified version:
  #
  # ```crystal
  # Inflector.classify("some-string")
  # # => "SomeString"
  # Inflector.classify("/some/file/path/some-name.svg", from_path: true)
  # # => "SomeName"
  # ```
  def self.classify(
    value : String,
    from_path = false
  )
    dasherize(value, from_path: from_path)
      .gsub(/-/, "_")
      .camelcase
      .gsub(/^\d+/, "")
  end
end
