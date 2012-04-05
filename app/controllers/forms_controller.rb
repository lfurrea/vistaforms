class FormsController < ApplicationController
  before_filter :signed_in_user

  def new
    @form = Form.new
  end

  def create
    @form = Form.new(params[:form])
    if @form.save
      #TODO: Add Create New Link to sucessful Flash
      flash[:success] = "Form has been properly uploaded!"
      redirect_to @form
    else
      render 'new'
    end
  end

  def show
    @form = Form.find(params[:id])
  end

  def index
    @forms = Form.all
  end

  def signed_in_user
    redirect_to signin_path unless signed_in?
  end
end
