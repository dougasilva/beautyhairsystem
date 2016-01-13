require "rails_helper"

RSpec.describe ServicosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/servicos").to route_to("servicos#index")
    end

    it "routes to #new" do
      expect(:get => "/servicos/new").to route_to("servicos#new")
    end

    it "routes to #show" do
      expect(:get => "/servicos/1").to route_to("servicos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/servicos/1/edit").to route_to("servicos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/servicos").to route_to("servicos#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/servicos/1").to route_to("servicos#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/servicos/1").to route_to("servicos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/servicos/1").to route_to("servicos#destroy", :id => "1")
    end

  end
end
