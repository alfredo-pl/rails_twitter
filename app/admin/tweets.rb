ActiveAdmin.register Tweet do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :content, :user_id, :tweet_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:content, :user_id, :tweet_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :content
    column :user_id
    column :tweet_id
    column :created_at
    actions
  end

  filter :content
  filter :user_id
  filter :tweet_id
  filter :created_at

  form do |f|
    f.inputs do
      f.input :content
      f.input :user_id
      f.input :tweet_id
    end
    f.actions
  end

end
