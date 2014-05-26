require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe VatsController do

  # This should return the minimal set of attributes required to create a valid
  # Vat. As you add validations to Vat, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "amount" => "1.5" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # VatsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET show" do
    it "assigns the requested vat as @vat" do
      vat = Vat.create! valid_attributes
      get :show, {:id => vat.to_param}, valid_session
      assigns(:vat).should eq(vat)
    end
  end

  describe "GET new" do
    it "assigns a new vat as @vat" do
      get :new, {}, valid_session
      assigns(:vat).should be_a_new(Vat)
    end
  end

  describe "GET edit" do
    it "assigns the requested vat as @vat" do
      vat = Vat.create! valid_attributes
      get :edit, {:id => vat.to_param}, valid_session
      assigns(:vat).should eq(vat)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Vat" do
        expect {
          post :create, {:vat => valid_attributes}, valid_session
        }.to change(Vat, :count).by(1)
      end

      it "assigns a newly created vat as @vat" do
        post :create, {:vat => valid_attributes}, valid_session
        assigns(:vat).should be_a(Vat)
        assigns(:vat).should be_persisted
      end

      it "redirects to the created vat" do
        post :create, {:vat => valid_attributes}, valid_session
        response.should redirect_to(Vat.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved vat as @vat" do
        # Trigger the behavior that occurs when invalid params are submitted
        Vat.any_instance.stub(:save).and_return(false)
        post :create, {:vat => { "amount" => "invalid value" }}, valid_session
        assigns(:vat).should be_a_new(Vat)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Vat.any_instance.stub(:save).and_return(false)
        post :create, {:vat => { "amount" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested vat" do
        vat = Vat.create! valid_attributes
        # Assuming there are no other vats in the database, this
        # specifies that the Vat created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Vat.any_instance.should_receive(:update).with({ "amount" => "1.5" })
        put :update, {:id => vat.to_param, :vat => { "amount" => "1.5" }}, valid_session
      end

      it "assigns the requested vat as @vat" do
        vat = Vat.create! valid_attributes
        put :update, {:id => vat.to_param, :vat => valid_attributes}, valid_session
        assigns(:vat).should eq(vat)
      end

      it "redirects to the vat" do
        vat = Vat.create! valid_attributes
        put :update, {:id => vat.to_param, :vat => valid_attributes}, valid_session
        response.should redirect_to(vat)
      end
    end

    describe "with invalid params" do
      it "assigns the vat as @vat" do
        vat = Vat.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Vat.any_instance.stub(:save).and_return(false)
        put :update, {:id => vat.to_param, :vat => { "amount" => "invalid value" }}, valid_session
        assigns(:vat).should eq(vat)
      end

      it "re-renders the 'edit' template" do
        vat = Vat.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Vat.any_instance.stub(:save).and_return(false)
        put :update, {:id => vat.to_param, :vat => { "amount" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested vat" do
      vat = Vat.create! valid_attributes
      expect {
        delete :destroy, {:id => vat.to_param}, valid_session
      }.to change(Vat, :count).by(-1)
    end

    it "redirects to the vats list" do
      vat = Vat.create! valid_attributes
      delete :destroy, {:id => vat.to_param}, valid_session
      response.should redirect_to(vats_url)
    end
  end

end
