class HomeController < ApplicationController
  def dashboard
    @workers = Worker.all
    @offline_workers = Worker.offline
  end
end
