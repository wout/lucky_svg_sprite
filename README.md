# Lucky SVG Sprite generator

![Lucky SVG Sprite generator logo](https://raw.githubusercontent.com/wout/lucky_svg_sprite/master/logo.svg?sanitize=true)

Generate [Lucky](https://luckyframework.org/)-flavored SVG sprites from a 
folder of separate SVG icons. This shard includes the necessary Lucky components
to mount sprites and icons in pages. Styling icons, like `width`, 
`height`, `stroke`, `fill` and `opacity`, can be done in CSS.

![GitHub](https://img.shields.io/github/license/wout/lucky_svg_sprite)
![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/wout/lucky_svg_sprite)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/wout/lucky_svg_sprite/lucky_svg_sprite%20CI)

Turn your regular SVG icon files:

```svg
<!-- src/components/svg_icons/default/lucky-logo-symbolic.svg -->
<?xml version="1.0" encoding="UTF-8"?>
<svg viewBox="0 0 16 16" version="1.1" xmlns="http://www.w3.org/2000/svg">
  <g fill="none" stroke="#000000">
    <path d="m12.626 ... 5.1818z" stroke-width="1"/>
    <path d="m3.9846 ... 7.1105-12.89" stroke-width="0.5"/>
    <path d="m5.9305 ... 6.1854-11.213" stroke-width="0.5"/>
  </g>
</svg>
```

Into reusable Lucky components:

```crystal
tag "symbol", id: "svg-lucky-logo-symbolic-icon", viewBox="0 0 16 16" do
  tag "g", fill: "none", stroke: "#000000" do
    tag "path", d: "m12.626 ... 5.1818z", stroke_width: "1"
    tag "path", d: "m3.9846 ... 7.1105-12.89", stroke_width: "0.5"
    tag "path", d: "m5.9305 ... 6.1854-11.213", stroke_width: "0.5"
  end
end
```

Which you can then easily mount in your pages:

```crystal
body do
  mount SvgSprite::Default.new
  
  header do
    mount SvgSprite::Default::LuckyLogoSymbolic.new
  end
end
```

With just one single command:

```bash
$ lucky gen.svg_sprite
```

And that's all instantaneously! 🚀️

## Installation

Add the dependency to your `shard.yml`:

```yaml
dependencies:
  lucky_svg_sprite:
    github: wout/lucky_svg_sprite
```

Run `shards install`.

__📄️ Note:__ *Installation might take a while since the generator binary needs
to be built. Having it built now, means that you'll have instantaneous sprite
regeneration. So, don't worry, be patient and grab a ☕️.*

## Usage

First, make sure your require this library in Lucky's shards.cr file:

```crystal
require "lucky_svg_sprite"
```

### Setup

After installation, run the following command:

```bash
$ lucky gen.svg_sprite -- --init
```

This will set up the required structure and files:

- `src/components/base_svg_icon.cr` (for customization)
- `src/components/base_svg_sprite.cr` (for customization)
- `src/components/svg_icons/default/example.svg` (`example` icon)
- `src/components/svg_sprites` (where generated sprites will be stored)
- `src/components/svg_sprites/default.cr` (sprite component with `example` icon)

You can add a set name as well:

```bash
$ lucky gen.svg_sprite menu_symbolic -- --init
```

Which will generate a directory for the given set name instead of **default**: 

- `src/components/svg_icons/menu_symbolic/example.svg` (`example` icon)

### Generating sprites

To regenerate your sprite after adding new icons, run:

```bash
$ lucky gen.svg_sprite
```

This will generate a new sprite from the **default** set. Add the name of the
set you want to generate:

```bash
$ lucky gen.svg_sprite menu_icons
```

By default, this command assumes your icons are in the desired color and you 
don't change their `stroke` or `fill` through CSS. By passing the
`--strip-colors` flag, all `stroke` and `fill` attributes of your icons will be 
removed:

```bash
$ lucky gen.svg_sprite -- --strip-colors
# or
$ lucky gen.svg_sprite -- -c
```

By using this flag, you will then be able to style your icons using CSS:

```css
.svg-default-icon {
  stroke: pink;
  opacity: 0.8;
  fill: none;
}
```

__📄️ Note:__ *Obviously, this is not recommended for multicolor icons.*

What if you want to take it further and strip other attributes as well? We got 
you covered:

```bash
$ lucky gen.svg_sprite -- --strip=opacity,stroke-linecap,stroke-linejoin
# or
$ lucky gen.svg_sprite -- -s opacity,stroke-linecap,stroke-linejoin
```

All attributes you strip away can then be declared in your stylesheet.

### Automatically generating sprites 🚀️

If you have [Guardian.cr](https://github.com/f/guardian) installed, create a
`guardfile.yml` (`guardian --init`) and add the following line:

```yaml
files: ./src/components/svg_icons/default/*.svg
run: lucky gen.svg_sprite
```

You can do the same for all your icon sets, each with their own arguments:

```yml
files: ./src/components/svg_icons/default/*.svg
run: lucky gen.svg_sprite
---
files: ./src/components/svg_icons/symbolic/*.svg
run: lucky gen.svg_sprite symbolic -- --strip-colors
```

Then, in a new terminal window, simply run:

```
$ guardian
```

And watch your sprites be generated whenever you edit or add an icon to one of
your sets.

__📄️ Note:__ *This setup works well with Lucky's watcher, because when the new
sprite file is generated, Lucky will pick up on that and start recompiling the
app.*

### Mounting a sprite

In your layout file, mount the sprite at the top of the body tag:

```crystal
body do
  mount SvgSprite::Default.new
  ...
end
```

__📄️ Note:__ *Yes, it's awkward, but it should be that way due to a
[bug in Chrome](https://bugs.chromium.org/p/chromium/issues/detail?id=349175).
If they are not at the top, or at least mounted before they are used, Chrome
will not render the icons. There are fixes, but they are beyond the
scope of this shard.*

This will mount the **default** icon set. Yes, that's right, you can create
multiple icon sets. For example, you might need to have **symbolic** and 
**colored** set. In that case, you will need to mount two sets:

```crystal
body do
  mount SvgSprite::Colored.new
  mount SvgSprite::Symbolic.new
  ...
end
```

Evidently, icons for the respective sets should be stored in:

```
src/components/svg_icons/colored
src/components/svg_icons/symbolic
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
  mount SvgSprite::Default::UserProfile.new
  text "My Profile"
end

div class: "shopping-bag" do
  mount SvgSprite::MyLovelySet::ProductsShoppingBags.new
end
```

The name of the icon class is the classified version of its file name. Here are
some examples:

```crystal
# src/components/svg_icons/default/hairy-ball.svg
mount SvgSprite::Default::HairyBall.new

# src/components/svg_icons/default/aircraft_chopper_4.svg
mount SvgSprite::Default::AircraftChopper4.new

# src/components/svg_icons/my_lovely_set/ContactUs.svg
mount SvgSprite::MyLovelySet::ContactUs.new
```

__📄️ Note:__ *The great thing about having dedicated Crystal classes per icon, 
is that you'll never have a missing icon. And if an SVG icon's source file gets
deleted or renamed, the compiler will let you know after regenerating the
sprite. An added bonus of using Crystal.* 🎉️

If you find yourself in a situation where you want to mount a series of icons
using a loop (like in a menu for example), then a macro will come in handy:

```crystal
ul do
  {% for button in SvgSprite::Menu::MANIFEST %}
    {% name = button.gsub(/-/, "_").camelcase %}
    li do
      link to: {{name.id}}::Index, flow_id: "{{button.id}}-section-button" do
        mount SvgSprite::Menu::{{name.id}}.new
        text {{name}}
      end
    end
  {% end %}
end
```

__📄️ Note:__ *Every sprite carries a tuple containing the names of all its
icons; a manifest if you will. For the menu example above, it can be found in 
`SvgSprite::Menu::MANIFEST`. The returned list contains sanitized, parameterized 
icon file names, without their extension. So for example: 
`{"my-account", "dashboard", "blog-posts"}`*

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

If you believe style attributes have no place in HTML, then you are in luck.
Just add a `style` method to your `base_svg_sprite.cr` component returning an
empty string:

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
default, sprites have two class names. For example:
- `svg-sprite` (all sprites)
- `svg-default-set` (only the **default** set)

Similarly, icons also have three class names:
- `svg-icon` (all icons)
- `svg-default-icon` (all icons in the **default** set)
- `svg-default-example-icon` (the **example** icon in the **default** set)

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

**For icons:**

```crystal
# src/components/base_svg_icon.cr
abstract class BaseSvgIcon < LuckySvgSprite::Icon
  def class_name
    "#{set}__icon #{set}__icon--{name}"
  end
end
```

Which will result in:

```html
<svg class="menu__icon menu__icon--products">
  <use xlink:href="#svg-menu-products-icon"></use>
</svg>
```

## Useful tools

### Norde

Managing and searching icons manually can be a tedious job. I found
[Norde](https://norde.io/) to be very useful. It comes installed with a few icon
sets, like Font Awesome and Material Design, but you can install any set you
like. Best of all, it is available for Linux, macOS and Windows.

## Development

Make sure you have [Guardian.cr](https://github.com/f/guardian) installed. Then
run:

```bash
$ guardian
```

This will automatically:
- run ameba for src and spec files
- run the relevant spec for any file in src
- run spec file whenever they are saved
- install shards whenever you save shard.yml

## Documentation

- [API (master)](https://wout.github.io/lucky_svg_sprite)

## Contributing

1. Fork it (https://github.com/wout/lucky_svg_sprite/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [wout](https://github.com/wout) - creator and maintainer

## Thanks & attributions
- The SVG to Lucky component converter is heavily based on
[HTML2Lucky](https://luckyhtml.herokuapp.com/).
Thanks [@paulcsmith](https://github.com/paulcsmith)! 