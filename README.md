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
gen.svg_sprite my_lovely_set
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

### Mounting a sprite

In your layout file, mount the sprite at the top of your body:

```crystal
body do
  mount SvgSprite::Default.new
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
  mount SvgSprite::Default.new
  mount SvgSprite::UnicornsAndRainbows.new
  ...
end
```

Evidently, icons for this set will go in:

```
src/components/svg_icons/unicorns_and_rainbows
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
link to: Profile::Show do
  mount SvgSprite::Default::Icon.new("user-profile")
  text "My Profile"
end

div class: "shopping-bag" do
  mount Shared::MyLovelySet::Icon.new("products-shopping-bags")
end
```

The `Icon` initializer takes one argument, which is its `name`. It is a
dasherized version of the original file name. Some examples:

```crystal
# src/components/shared/svg_icons/default/hairy-ball.svg
mount SvgSprite::Default::Icon.new("hairy-ball")
# src/components/shared/svg_icons/default/aircraft_chopper_4.svg
mount SvgSprite::Default::Icon.new("aircraft-chopper-4")
# src/components/shared/svg_icons/my_lovely_set/ContactUs.svg
mount SvgSprite::MyLovelySet::Icon.new("contact-us")
```

### Customizing attributes

#### `style`

Generated sprites are hidden with an inline style tag:

```html
<svg class="svg-sprite svg-default-set" style="display:none" xmlns="http://www.w3.org/2000/svg">
  <defs>
    ...
  </defs>
</svg>
```

If you are a puritan and believe style attributes have no place in HTML, then
you are in luck. Just add a `style` method to your base_svg_sprite.cr component
returning an empty string:

```crystal
# src/components/base_svg_sprite.cr
abstract class BaseSvgSprite < LuckySvgSprite::Set
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

Class names can be a very personal thing, so you might want to change them. By
default, the sprites have two class names. For example:
- `svg-sprite` (all sprites)
- `svg-default-set` (only the "default" set)

Similarly, icons also have three class name:
- `svg-icon` (all icons)
- `svg-default-icon` (all icons in the "default" set)
- `svg-default-example-icon` (the "example" icon in the "default" set)

You can change them by adding a method called `class_name`, which returns the
class name you prefer over the default one.

**For sprites:**

```crystal
# src/components/base_svg_sprite.cr
abstract class BaseSvgSprite < LuckySvgSprite::Set
  def class_name
    "my-sprite my-#{name}-set"
  end
end
```

Which will result in:

```html
<svg class="my-sprite my-default-set" style="display:none" xmlns="http://www.w3.org/2000/svg">
  <defs>
    ...
  </defs>
</svg>
```

**For icons:***

```crystal
# src/components/base_svg_icon.cr
abstract class BaseSvgIcon < LuckySvgSprite::Icon
  def class_name
    "my-icon my-#{set}-icon my-#{set}-#{name}-icon"
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
