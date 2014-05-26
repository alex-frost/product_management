require "spec_helper"

describe VatsController do
  describe "routing" do

    it "routes to #show" do
      get("/vat").should route_to("vats#show")
    end

    it "routes to #update" do
      put("/vat").should route_to("vats#update")
    end

  end
end
