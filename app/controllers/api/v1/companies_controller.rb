class Api::V1::CompaniesController < Api::V1::ApplicationController

  def new_company
    @user = User.new(profile: Company.new)
  end

end



