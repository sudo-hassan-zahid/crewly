require "rails_helper"

RSpec.describe Department, type: :model do
  describe "validations" do
    it "is valid with name and code" do
      department = Department.new(name: "Engineering", code: "ENG")
      expect(department).to be_valid
    end

    it "is invalid without name" do
      department = Department.new(code: "ENG")
      expect(department).not_to be_valid
    end

    it "is invalid without code" do
      department = Department.new(name: "Engineering")
      expect(department).not_to be_valid
    end
  end
end
