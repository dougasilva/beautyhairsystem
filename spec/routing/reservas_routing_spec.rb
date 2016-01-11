require "rails_helper"

RSpec.describe ReservasController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/reservas").to route_to("reservas#index")
    end

    it "routes to #new" do
      expect(:get => "/reservas/new").to route_to("reservas#new")
    end

    it "routes to #show" do
      expect(:get => "/reservas/1").to route_to("reservas#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/reservas/1/edit").to route_to("reservas#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/reservas").to route_to("reservas#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/reservas/1").to route_to("reservas#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/reservas/1").to route_to("reservas#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/reservas/1").to route_to("reservas#destroy", :id => "1")
    end

  end
end
