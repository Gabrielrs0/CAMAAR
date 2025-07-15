module Admin
  class DashboardController < ApplicationController
    def index
      render plain: "Admin Dashboard"
    end
  end
end