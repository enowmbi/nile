require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "#database columns" do
  it { is_expected.to have_db_column(:title).of_type(:string) }
  it { is_expected.to have_db_column(:published_date).of_type(:date) }
  it { is_expected.to have_db_column(:author_id).of_type(:integer) }
  it { is_expected.to have_db_index(:title).unique(:true) }
  end

  describe "#associations" do
    it { is_expected.to belong_to(:author) }
  end

  describe "#validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:published_date) }
    it { is_expected.to validate_uniqueness_of(:title) }
  end
end
