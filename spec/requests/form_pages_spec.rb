require 'spec_helper'

describe "FormPages" do
   subject { page }

  # describe "form profile page" do
  #   let(:form)   { FactoryGirl.create(:form) }
  #   before { visit form_path(form) }

  #   it { should have_selector('h1',   text: form.name) }
  #   it { should have_selector('title', text: form.name) }
  # end

  describe "Forms index" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      visit forms_path
      fill_in "Email",      with: user.email
      fill_in "Password", with: user.password
      click_button "Sign in"
    end

    it { should have_selector('title', text: 'All forms') }
  end

end
