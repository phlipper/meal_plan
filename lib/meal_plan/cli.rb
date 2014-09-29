require "meal_plan/cookbook"
require "thor"

module MealPlan
  # Public: Main command line entry point
  class CLI < Thor
    include Thor::Actions

    desc "version", "Display the program version and exit"
    def version
      say "Meal Plan v#{MealPlan::VERSION} - A healthy, delicious way to prepare your infrastructure" # rubocop:disable LineLength
      say "(c) 2014 Phil Cohen"
    end

    desc "prepare NAME", "Prepare a Meal Plan (bootstrap cookbook development for NAME)" # rubocop:disable LineLength

    method_option :output_directory, aliases: "-o", default: "."
    method_option :maintainer, aliases: "-m", default: ENV["USER"]
    method_option :maintainer_email, aliases: "-e", default: "FIXME@example.com"

    def prepare(name)
      say "Preparing a Meal Plan for `#{name}`", :yellow

      MealPlan::Cookbook.new.bootstrap(name, options)

      say "Happy Cooking!", :green
    end
  end
end
