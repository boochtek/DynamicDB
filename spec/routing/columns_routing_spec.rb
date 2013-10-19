require "spec_helper"

describe ColumnsController do
  describe "routing" do

    it "routes to #index" do
      get("/columns").should route_to("columns#index")
    end

    it "routes to #new" do
      get("/columns/new").should route_to("columns#new")
    end

    it "routes to #show" do
      get("/columns/1").should route_to("columns#show", :id => "1")
    end

    it "routes to #edit" do
      get("/columns/1/edit").should route_to("columns#edit", :id => "1")
    end

    it "routes to #create" do
      post("/columns").should route_to("columns#create")
    end

    it "routes to #update" do
      put("/columns/1").should route_to("columns#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/columns/1").should route_to("columns#destroy", :id => "1")
    end

  end
end
