# Lucky SVG Sprite generator

Generate a [Lucky](https://luckyframework.org/) flavored SVG sprite from a 
folder of separate SVG icons. This shard includes the necessary Lucky components
to mount sprites and icons in your pages. Styling your icons, like `width`, 
`height`, `stroke`, `fill` and `opacity`, can be done in CSS.

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
- src/components/shared/svg_sprite.cr (for customization)
- src/components/shared/svg_icons/default.cr (generated sprite)
- src/components/shared/svg_icons/default/example.svg (example icon)
- tasks/generate_svg_icon_sprite.cr (CLI task to generate sprites)

## Usage

First, make sure your require this library in Lucky's shards.cr file:

```crystal
require "lucky_svg_sprite"
```

### Generating sprites

You'll get a command to regenerate your icon sprite whenever icons are added:

```bash
gen.svg_sprite
```

This will generate a new sprite from the **default** set. Add the name of the
set you want to generate:

```bash
gen.svg_sprite menu
```

By default, this command assumes your icons are in the desired color and you 
don't change their `stroke` or `fill` through CSS. By passing the
`--strip-color` flag, all `stroke` and `fill` attributes of your icons will be 
removed:

```bash
gen.svg_sprite --strip-color
```

By using this flag, you will then be able to style your icons using CSS:

```css
.svg-default-icon {
  stroke: pink;
  opacity: 0.8;
  fill: none;
}
```

*__📄️ Note:__ Obviously, this is not recommended for multicolor icons.*

### Mounting the sprite

In your layout file, mount the sprite at the top of your body:

```crystal
body do
  mount Shared::SvgSprite.new
  ...
end
```

*__📄️ Note:__ This might seem awkward, but it should be that way due to a
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

__☝ Tip:__ If you have many icons in your app, sets can also be useful to
create groups of icons that belong together on the same page or in the same
component. For example, you could have a set for menu icons, a set for icons
used on the dashboard and so on. Then you can mount those sets wherever you need
them and avoid one large blob of icons mounted on every page where you only
actually need a selection of them at the same time.

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

The first argument, which is the `name` of the icon, is directly
derived from the file name. Some examples:

```crystal
# src/components/shared/svg_icons/default/hairy-ball.svg
mount Shared::SvgIcon.new("hairy-ball")
# src/components/shared/svg_icons/sidebar/aircraft_chopper_4.svg
mount Shared::SvgIcon.new("aircraft_chopper_4", set: "sidebar")
# src/components/shared/svg_icons/ThirdFooter/ContactUs.svg
mount Shared::SvgIcon.new("ContactUs", set: "ThirdFooter")
```

### Customizing attributes

#### `style`

Generated sprites are hidden with an inline style tag:

```html
<svg class="svg-sprite svg-default-sprite" style="display:none" xmlns="http://www.w3.org/2000/svg">
  <defs>
    ...
  </defs>
</svg>
```

If you are an puritan and believe style attributes have no place in HTML, then
you are in luck. Just add a `style` method to your svg_sprite.cr component
returning an empty string:

```crystal
# src/components/shared/svg_sprite.cr
class Shared::SvgSprite < LuckySvgSprite::Base
  include Shared::SvgIcons

  def style
    ""
  end
end
```

Of course, this will mess up your layout, so you'll need to make sure to hide it
in your stylesheet:

```css
.svg-sprite {
  display: none;
}
```

#### `class`

Class names can be a very personal thing. By default, the sprites have two class
names:
- `svg-sprite` (all sprites)
- `svg-default-sprite` (this set alone)

Similarly, icons also have three class name:
- `svg-icon` (all icons)
- `svg-default-icon` (all icons in a given set)
- `svg-default-example-icon` (a specific icon in a given set)

You can change them by adding a method called `svg_class` which returns the
class name you prefer.

**For sprites:**

```crystal
# src/components/shared/svg_sprite.cr
class Shared::SvgSprite < LuckySvgSprite::Set
  include Shared::SvgIcons

  def svg_class
    "my-sprite my-#{@name}-sprite"
  end
end
```

Which will result in:

```html
<svg class="my-sprite my-default-sprite" style="display:none" xmlns="http://www.w3.org/2000/svg">
  <defs>
    ...
  </defs>
</svg>
```

**For icons:***

```crystal
class Shared::SvgIcon < LuckySvgSprite::Icon
  def svg_class
    "my-icon my-#{@set}-icon my-#{@set}-#{@name}-icon"
  end
end
```

Which will result in:

```html
<svg class="my-icon my-default-icon my-default-example-icon">
  <use xlink:href="#svg-example-icon"></use>
</svg>
```

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (https://github.com/tilishop/lucky_svg_sprite/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [wout](https://github.com/wout) - creator and maintainer
- [tilishop](https://github.com/tilishop) - owner and maintainer
