require "thor"

module MealPlan
  # Public: Actions to bootstrap a new cookbook
  class Cookbook < Thor
    include Thor::Actions

    attr_accessor :cookbook_name
    attr_accessor :maintainer
    attr_accessor :maintainer_email
    attr_accessor :output_directory

    def self.source_root
      ::File.expand_path "../../../templates/cookbook", __FILE__
    end

    desc "bootstrap NAME", "Bootstrap a new Cookbook development environment"
    def bootstrap(name, options = {})
      self.cookbook_name = name
      self.maintainer = options[:maintainer]
      self.maintainer_email = options[:maintainer_email]
      self.output_directory = ::File.expand_path options[:output_directory]

      create_directories
      create_templates
      copy_files

      bundle_install
      berks_install
      git_init
    end

  private

    def bundle_install
      run "bundle check || bundle install --path=.bundle --binstubs=.bundle/bin"
    end

    def berks_install
      run "berks install"
    end

    def git_init
      run "test -d .git || (git init && git add .)"
    end

    # setup directories which contain templates
    def create_directories
      create_empty_directories

      directories = %w[attributes recipes spec test]

      directories.each do |name|
        directory name, ::File.join(output_directory, name)
      end
    end

    # setup empty directories
    def create_empty_directories
      directories = %w[
        files/default libraries providers resources templates/default
      ]

      directories.each do |name|
        empty_directory ::File.join(output_directory, name)
      end
    end

    # setup template files to place
    def create_templates
      templates = %w[LICENSE.txt README.md metadata.rb]

      templates.each do |name|
        template name, ::File.join(output_directory, name)
      end
    end

    # copy static files
    def copy_files
      files = %w[.gitignore .rubocop.yml Berksfile Gemfile Guardfile Rakefile]

      files.each do |name|
        copy_file name, ::File.join(output_directory, name)
      end
    end
  end
end
