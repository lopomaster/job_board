require 'rails_helper'

RSpec.describe Company, type: :model do
  it { should have_one :user }
  it { should have_many :job_adverts }
  it { should validate_presence_of :description }
  it { should validate_presence_of :name }

  it { should respond_to(:name) }
  it { should respond_to(:description) }

end
