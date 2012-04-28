class ApplicationsController < ApplicationController
#  before_filter :signed_in_user, only: [:create, :destroy]

  def create
    @form = Form.find(params[:application][:form_id])
    @application = current_user.applications.build(cu_name: "testy", cu_email: "testy@testy.com", :form_id => params[:application][:form_id], :excel_attachment => params[:application][:excel_attachment])
    if @application.save
      flash[:success] = "Insurance application has been filled. You can #{ActionController::Base.helpers.link_to "Download", @application.filled_pdf.expiring_url(:original)} a copy.".html_safe
      redirect_to root_path
    else
#      flash.now[:error] = "Application has been filled!" + params[:application][:form_id]
      @form = Form.find(params[:application][:form_id])
      render 'forms/show'
    end
  end

  def destroy
  end

end
