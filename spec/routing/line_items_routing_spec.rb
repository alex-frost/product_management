require "spec_helper"

describe LineItemsController do
  describe "routing" do

    it "routes to #index" do
      get("/orders/1/line_items").should route_to("line_items#index", order_id: "1")
    end

    it "routes to #show" do
      get("/orders/1/line_items/1").should route_to("line_items#show", :id => "1", order_id: "1")
    end

    it "routes to #create" do
      post("/orders/1/line_items").should route_to("line_items#create", order_id: "1")
    end

    it "routes to #update" do
      put("/orders/1/line_items/1").should route_to("line_items#update", :id => "1", order_id: "1")
    end

    it "routes to #destroy" do
      delete("/orders/1/line_items/1").should route_to("line_items#destroy", :id => "1", order_id: "1")
    end

  end
end
