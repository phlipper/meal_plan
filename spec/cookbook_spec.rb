require "fileutils"
require "spec_helper"

describe MealPlan::Cookbook do
  def read_template(file)
    ::File.read ::File.join(sandbox_path, file)
  end

  let(:sandbox_path) do
    File.expand_path("../sandbox", __FILE__)
  end

  let(:file_list) do
    %w[
      files/default libraries providers resources templates/default attributes
      attributes/default.rb recipes recipes/default.rb spec spec/default_spec.rb
      spec/spec_helper.rb test test/.chef/knife.rb test/rubocop/disabled.yml
      test/rubocop/enabled.yml LICENSE.txt README.md metadata.rb .gitignore
      .rubocop.yml Berksfile Gemfile Guardfile Rakefile
    ]
  end

  after do
    FileUtils.rm_rf sandbox_path
  end

  specify { expect(described_class).to respond_to :source_root }

  describe "the public interface" do
    specify { expect(subject).to respond_to :bootstrap }

    specify { expect(subject).to respond_to :cookbook_name }
    specify { expect(subject).to respond_to :cookbook_name= }
    specify { expect(subject).to respond_to :maintainer }
    specify { expect(subject).to respond_to :maintainer= }
    specify { expect(subject).to respond_to :maintainer_email }
    specify { expect(subject).to respond_to :maintainer_email= }
    specify { expect(subject).to respond_to :output_directory }
    specify { expect(subject).to respond_to :output_directory= }
  end

  describe "#bootstrap" do
    let(:berks_cmd) { "berks install" }

    let(:bundle_cmd) do
      "bundle check || bundle install --path=.bundle --binstubs=.bundle/bin"
    end

    let(:git_cmd) { "test -d .git || (git init && git add .)" }

    let(:output) do
      capture(:stdout) do
        MealPlan::Cookbook.new.bootstrap("test", output_directory: sandbox_path)
      end
    end

    it "runs through all of the bootstrap steps" do
      expect_any_instance_of(described_class).to receive_messages(
        create_directories: true,
        create_templates: true,
        copy_files: true,
        bundle_install: true,
        berks_install: true,
        git_init: true
      )

      MealPlan::Cookbook.new.bootstrap("test", output_directory: sandbox_path)
    end

    it "outputs a list of created files" do
      expect_any_instance_of(described_class).to receive(:run).with(
        "test -d .bundle || " \
        "bundle install --path=.bundle --binstubs=.bundle/bin"
      )
      expect_any_instance_of(described_class).to receive(:run).with(
        "berks install"
      )
      expect_any_instance_of(described_class).to receive(:run).with(
        "test -d .git || (git init && git add .)"
      )

      file_list.each do |file|
        expect(output).to match "create  spec/sandbox/#{file}"
      end
    end

    # rubocop:disable LineLength
    it "outputs a list of executed commands" do
      expect(output).to match %(run  test -d .bundle || bundle install --path=.bundle --binstubs=.bundle/bin from ".")
      expect(output).to match %(run  berks install from ".")
      expect(output).to match %(run  test -d .git || (git init && git add .) from ".")
    end
    # rubocop:enable LineLength

    it "writes files to the sandbox" do
      capture(:stdout) do
        MealPlan::Cookbook.new.bootstrap("test", output_directory: sandbox_path)
      end

      file_list.each do |file|
        file_path = ::File.join(sandbox_path, file)

        expect(::File.exist?(file_path)).to eq true
      end
    end

    it "properly interpolates template files" do
      capture(:stdout) do
        MealPlan::Cookbook.new.bootstrap(
          "test",
          output_directory: sandbox_path,
          maintainer: "Joe Test",
          maintainer_email: "joe@test.com"
        )
      end

      expect(read_template "attributes/default.rb").to match(
        "# Cookbook Name:: test"
      )

      expect(read_template "recipes/default.rb").to match(
        "# Cookbook Name:: test"
      )

      expect(read_template "spec/default_spec.rb").to match(
        %(describe "test::default")
      )

      metadata = read_template "metadata.rb"
      expect(metadata).to match "Joe Test"
      expect(metadata).to match "joe@test.com"
      expect(metadata).to match %(recipe "test")
    end
  end

end
