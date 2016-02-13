# [HappilyEverAttfield](http://www.happilyeverattfield.com/)

[![Build Status](https://travis-ci.org/Sinetheta/happilyeverattfield.svg?branch=master)](https://travis-ci.org/Sinetheta/happilyeverattfield)

## Development

Our website uses Middleman. After running `bundle` simply load up a local server:

```
bundle exec middleman server
```

Navigate to http://localhost:4567 and hack away.

### Icons

We are using a custom build of [Fontello](http://fontello.com/) which is
described by [config.json][1]. We are using [railslove/fontello_rails_converter][2]
to update/convert the fontello assets to SCSS.

The current glyph set can be seen at http://localhost:4567/fontello-demo.html.

#### To Update Fontello

1. `sh bin/fontello_open.sh` to open our custom glyph set in the Fontello web app.
2. Change selected glyphs as needed and save your session.
3. `sh bin/fontello_convert.sh` to fetch those changes and update vendor assets.


[1]: https://github.com/Sinetheta/HappilyEverAttfield/blob/master/data/fontello.json
[2]: https://github.com/railslove/fontello_rails_converter
