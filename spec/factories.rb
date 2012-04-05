include ActionDispatch::TestProcess



FactoryGirl.define do
  factory :user do
    name                           "Luis Urrea"
    email                           "lfurrea@example.com"
    password                     "foobar"
    password_confirmation "foobar"
  end

  factory :carrier do
    name   "EmblemHealth"
  end


  #TODO: fixture_file_upload is broken on Rails 3.2
  #https://github.com/rspec/rspec-rails/issues/252
  # factory :form do
  #   name "EmblemHealth HNY Sole_P App 2012"
  #   carrier
  #   pdf_form {fixture_file_upload('/files/EmblemHealthHNYSole_PApp2012.pdf', 'application/pdf')}
  # end
end


