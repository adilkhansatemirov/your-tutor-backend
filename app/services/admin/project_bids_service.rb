module Admin::ProjectBidsService

  def self.create_mutiple(project_bids, project)
    bids = []
    project_bids.each do |project_bid|
      bid = {
        :user_id => project_bid[:user_id],
        :project_id => project.id,
        :bids_status => "new_project",
      }
      bids << ProjectBid.new(bid)
    end
    ProjectBid.import bids,
                      on_duplicate_key_update: { conflict_target: [:user_id, :project_id],
                                                 columns: [:user_id, :project_id, :compensation, :bids_status] }
    bids
  end

end
