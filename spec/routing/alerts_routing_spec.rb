require "spec_helper"

describe AlertsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/alerts" }.should route_to(:controller => "alerts", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/alerts/new" }.should route_to(:controller => "alerts", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/alerts/1" }.should route_to(:controller => "alerts", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/alerts/1/edit" }.should route_to(:controller => "alerts", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/alerts" }.should route_to(:controller => "alerts", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/alerts/1" }.should route_to(:controller => "alerts", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/alerts/1" }.should route_to(:controller => "alerts", :action => "destroy", :id => "1")
    end

  end
end
