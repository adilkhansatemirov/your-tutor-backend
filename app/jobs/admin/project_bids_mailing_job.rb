module Admin
  class ProjectBidsMailingJob < ApplicationJob
    queue_as :project_bid

    def perform(bids)
      Admin::NotificationsService.notify_about_new_opportunity(bids)
    end
  end
end
