class SorceryCore < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      #sorcery core fileds
      t.string :username,         :null => false  # if you use another field as a username, for example email, you can safely remove this field.
      t.string :email,            :default => nil # if you use this field as a username, you might want to make it :null => false.
      t.string :crypted_password, :default => nil
      t.string :salt,             :default => nil
     
     
      # custom fields
      t.boolean :is_admin,         :default => 0
      t.boolean :is_active,        :default => true
      
      t.string :first_name
      t.string :last_name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :county
      t.string :post_code
      t.string :country
      t.string :tel_number
      t.string :mobile_number
      t.date :date_of_birth
      
      
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end