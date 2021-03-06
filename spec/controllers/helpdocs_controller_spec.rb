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

describe HelpdocsController do

  # This should return the minimal set of attributes required to create a valid
  # Helpdoc. As you add validations to Helpdoc, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "title" => "MyString" }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # HelpdocsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all helpdocs as @helpdocs" do
      helpdoc = Helpdoc.create! valid_attributes
      get :index, {}, valid_session
      assigns(:helpdocs).should eq([helpdoc])
    end
  end

  describe "GET show" do
    it "assigns the requested helpdoc as @helpdoc" do
      helpdoc = Helpdoc.create! valid_attributes
      get :show, {:id => helpdoc.to_param}, valid_session
      assigns(:helpdoc).should eq(helpdoc)
    end
  end

  describe "GET new" do
    it "assigns a new helpdoc as @helpdoc" do
      get :new, {}, valid_session
      assigns(:helpdoc).should be_a_new(Helpdoc)
    end
  end

  describe "GET edit" do
    it "assigns the requested helpdoc as @helpdoc" do
      helpdoc = Helpdoc.create! valid_attributes
      get :edit, {:id => helpdoc.to_param}, valid_session
      assigns(:helpdoc).should eq(helpdoc)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Helpdoc" do
        expect {
          post :create, {:helpdoc => valid_attributes}, valid_session
        }.to change(Helpdoc, :count).by(1)
      end

      it "assigns a newly created helpdoc as @helpdoc" do
        post :create, {:helpdoc => valid_attributes}, valid_session
        assigns(:helpdoc).should be_a(Helpdoc)
        assigns(:helpdoc).should be_persisted
      end

      it "redirects to the created helpdoc" do
        post :create, {:helpdoc => valid_attributes}, valid_session
        response.should redirect_to(Helpdoc.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved helpdoc as @helpdoc" do
        # Trigger the behavior that occurs when invalid params are submitted
        Helpdoc.any_instance.stub(:save).and_return(false)
        post :create, {:helpdoc => { "title" => "invalid value" }}, valid_session
        assigns(:helpdoc).should be_a_new(Helpdoc)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Helpdoc.any_instance.stub(:save).and_return(false)
        post :create, {:helpdoc => { "title" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested helpdoc" do
        helpdoc = Helpdoc.create! valid_attributes
        # Assuming there are no other helpdocs in the database, this
        # specifies that the Helpdoc created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Helpdoc.any_instance.should_receive(:update_attributes).with({ "title" => "MyString" })
        put :update, {:id => helpdoc.to_param, :helpdoc => { "title" => "MyString" }}, valid_session
      end

      it "assigns the requested helpdoc as @helpdoc" do
        helpdoc = Helpdoc.create! valid_attributes
        put :update, {:id => helpdoc.to_param, :helpdoc => valid_attributes}, valid_session
        assigns(:helpdoc).should eq(helpdoc)
      end

      it "redirects to the helpdoc" do
        helpdoc = Helpdoc.create! valid_attributes
        put :update, {:id => helpdoc.to_param, :helpdoc => valid_attributes}, valid_session
        response.should redirect_to(helpdoc)
      end
    end

    describe "with invalid params" do
      it "assigns the helpdoc as @helpdoc" do
        helpdoc = Helpdoc.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Helpdoc.any_instance.stub(:save).and_return(false)
        put :update, {:id => helpdoc.to_param, :helpdoc => { "title" => "invalid value" }}, valid_session
        assigns(:helpdoc).should eq(helpdoc)
      end

      it "re-renders the 'edit' template" do
        helpdoc = Helpdoc.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Helpdoc.any_instance.stub(:save).and_return(false)
        put :update, {:id => helpdoc.to_param, :helpdoc => { "title" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested helpdoc" do
      helpdoc = Helpdoc.create! valid_attributes
      expect {
        delete :destroy, {:id => helpdoc.to_param}, valid_session
      }.to change(Helpdoc, :count).by(-1)
    end

    it "redirects to the helpdocs list" do
      helpdoc = Helpdoc.create! valid_attributes
      delete :destroy, {:id => helpdoc.to_param}, valid_session
      response.should redirect_to(helpdocs_url)
    end
  end

end
