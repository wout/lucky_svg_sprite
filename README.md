# Lucky SVG Sprite generator

Generate a [Lucky](https://luckyframework.org/) flavored SVG sprite from a 
folder of separate SVG icons. This shard includes the necessary Lucky components
to mount the sprite and icons in your pages. Styling your icons, like `width`, 
`height`, `stroke`, `fill` and `opacity`, is done in CSS.

## Installation

Add the dependency to your `shard.yml`:

```yaml
dependencies:
  lucky_svg_sprite:
    github: tilishop/lucky_svg_sprite
```

Run `shards install`.

## Setup

At installation, this shard will install a few files in your app.
- src/components/shared/svg_sprite.cr
- src/components/shared/svg_icons/default.cr
- src/components/shared/svg_icons/default/example.svg
- tasks/generate_svg_icon_sprite.cr

## Usage

Make sure your require this shard in Lucky's shards.cr:

```crystal
require "lucky_svg_sprite"
```

### Generating a sprite

You'll get a command to regenerate your icon sprite whenever icons are added:

```
gen.svg_sprite
```

This will generate 

### Mounting the sprite

In your layout file, mount the sprite at the top of your body:

```crystal
body do
  mount Shared::SvgSprite.new
  ...
end
```

*__Note:__ This might seem awkward, but it should be that way due to a
[bug in Chrome](https://bugs.chromium.org/p/chromium/issues/detail?id=349175).
If they are not at the top, or at least mounted before they are used, Chrome
will not render the icons.*

This will mount the **default** icon set. Yes, that's right, you can create
multiple icon sets. For example, you might need to have **symbolic** and 
**colored** set. In that case, you will need to mount two sets:

```crystal
body do
  # mounts the "default" set
  mount Shared::SvgSprite.new
  # mounts the "other" set
  mount Shared::SvgSprite.new("other")
  ...
end
```

Evidently, icons for this set will go in:

```
src/components/shared/svg_icons/other
```

### Mounting an icon

Icons can be mounted wherever you like:

```crystal
link to: Example::Show do
  mount Shared::SvgIcon.new("example")
  text "Example"
end
```

Similar to sets, this will mount an icon from the **default** set, but another
set can be defined as well:

```crystal
link to: Example::Show do
  mount Shared::SvgIcon.new("example", set: "other")
  text "Example"
end
```

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/your-github-user/lucky_svg_sprite/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [wout](https://github.com/your-github-user) - creator and maintainer
