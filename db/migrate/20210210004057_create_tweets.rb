class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.string :content
      t.references :user, null: false, foreign_key: true
<<<<<<< HEAD
      t.references :tweet, null: false,foreign_key: true
=======
      t.references :tweet, null: false, foreign_key: true
>>>>>>> ea00b4a1c6b4b070a99da0d57b885c0f9427add5

      t.timestamps
    end
  end
end
