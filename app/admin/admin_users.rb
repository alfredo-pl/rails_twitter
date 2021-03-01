ActiveAdmin.register User do
  permit_params :email, :name, :photo, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :friends_count
    column :tweet_count
    column :like_count
    column :retweet_count
    column :created_at
    actions
  end

  filter :email
  filter :friends

  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :name
      f.input :photo
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
