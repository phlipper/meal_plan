# Meal Plan

_"A healthy, delicious way to prepare and enjoy your infrastructure development"_

`meal_plan` is an opinionated set of generators to aid development of Chef cookbooks, currently supporting the following tools:

* chef
* chefspec
* berkshelf
* foodcritic
* rake
* rubocop

## Installation

I recommend installing this in a central location, because:

* it is useful across multiple projects
* the `prepare` command can overwrite a _Gemfile_
* this is how I use it

```
$ gem install meal_plan
```


## Usage

```
Commands:
  meal_plan help [COMMAND]  # Describe available commands or one specific command
  meal_plan prepare NAME    # Prepare a Meal Plan (bootstrap cookbook development for NAME)
  meal_plan version         # Display the program version and exit
```

### `prepare` command

```
Usage:
  meal_plan prepare NAME

Options:
  -o, [--output-directory=OUTPUT_DIRECTORY]  # Default: "."
  -m, [--maintainer=MAINTAINER]
  -e, [--maintainer-email=MAINTAINER_EMAIL]

Prepare a Meal Plan (bootstrap cookbook development for NAME)
```

**Example**

```
$ meal_plan prepare discourse -m "Phil Cohen" -e "github@phlippers.net"

Preparing a Meal Plan for `discourse`
      create  files/default
      create  libraries
      create  providers
      create  resources
      create  templates/default
      create  attributes
      create  attributes/default.rb
      create  recipes
      create  recipes/default.rb
      create  spec
      create  spec/default_spec.rb
      create  spec/spec_helper.rb
      create  test
      create  test/.chef/knife.rb
      create  test/rubocop/disabled.yml
      create  test/rubocop/enabled.yml
      create  LICENSE.txt
      create  README.md
      create  metadata.rb
      create  .gitignore
      create  .rubocop.yml
      create  Berksfile
      create  Gemfile
      create  Guardfile
      create  Rakefile
         run  bundle check || bundle install --path=.bundle --binstubs=.bundle/bin from "."
         run  berks install from "."
         run  test -d .git || (git init && git add .) from "."
Happy Cooking!
```

## Contributing

1. [Fork it](https://github.com/phlipper/meal_plan/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a [new Pull Request](https://github.com/phlipper/meal_plan/pulls/new)


## License

**meal_plan**

* Freely distributable and licensed under the [MIT license](http://phlipper.mit-license.org/2014/license.html).
* Copyright (c) 2014 Phil Cohen (github@phlippers.net)  [![endorse](http://api.coderwall.com/phlipper/endorsecount.png)](http://coderwall.com/phlipper)  [![Gittip](http://img.shields.io/gittip/phlipper.png)](https://www.gittip.com/phlipper/)
* http://phlippers.net
