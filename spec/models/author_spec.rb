require 'rails_helper'

RSpec.describe Author, type: :model do
  describe "#database columns" do
    it{ is_expected.to have_db_column(:first_name).of_type(:string) }
    it{ is_expected.to have_db_column(:last_name).of_type(:string) }
    it{ is_expected.to have_db_column(:email).of_type(:string) }
    it{ is_expected.to have_db_index(:email).unique(:true) }
  end

  describe "#associations" do
    it { is_expected.to have_many(:books).dependent(:destroy) }
  end

  describe "#validations" do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
  end
end
