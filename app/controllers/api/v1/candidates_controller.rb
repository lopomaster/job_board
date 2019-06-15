class Api::V1::CandidatesController < Api::V1::ApplicationController

  def new_candidate
    @user = User.new(profile: Candidate.new)
  end

end

