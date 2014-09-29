require "spec_helper"

describe MealPlan::CLI do
  describe "the public interface" do
    specify { expect(subject).to respond_to :version }
    specify { expect(subject).to respond_to :prepare }
  end

  describe "#version" do
    let(:output) do
      capture(:stdout) { MealPlan::CLI.new.version }
    end

    it "displays the program version" do
      expect(output).to match "Meal Plan v#{MealPlan::VERSION}"
    end
  end

  describe "#prepare" do
    let(:output) do
      capture(:stdout) { MealPlan::CLI.new.prepare("test") }
    end

    it "bootstraps a new cookbook environment" do
      expect_any_instance_of(MealPlan::Cookbook).to receive_messages(
        bootstrap: true
      )

      expect(output).to match "Preparing a Meal Plan for `test`"
      expect(output).to match "Happy Cooking!"
    end
  end
end
