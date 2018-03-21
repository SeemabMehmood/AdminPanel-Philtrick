class DeviseCreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email,              null: false, default: ""
      t.string :username,           null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      t.datetime :remember_created_at

      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at

      t.string   :name,         null: false
      t.string   :country,      null: false
      t.string   :company_name, null: false
      t.decimal  :profit_share, null: false, precision: 4, scale: 1

      t.string   :currency,     null: false, default: "USD"
      t.string   :language,     null: false, default: "en"

      t.integer  :zip
      t.decimal :net_income, precision: 10, scale: 2
      t.string   :street_name

      t.boolean  :admin,        null: false, default: false

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :username,             unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
  end
end
