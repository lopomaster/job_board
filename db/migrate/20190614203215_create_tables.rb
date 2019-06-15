class CreateTables < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|

      t.references :profile, polymorphic: true, null: false

      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :username,           null: false
      t.string :first_name
      t.string :last_name
      t.string :encrypted_password, null: false, default: ""

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
    add_index :users, :username, unique: true


    # create_table :user_profiles do |t|
    #   t.belongs_to :user, foreign_key: true
    #   t.integer :user_type_cd, default: 0
    #   t.timestamps
    # end

    create_table :jobs do |t|
      t.string :company
      t.string :description
      t.timestamps
    end

    create_table :companies do |t|
      t.string :name
      t.string :description
      t.timestamps
    end

    add_index :companies, :name, unique: true

    create_table :candidates do |t|
      t.string :profession
      t.string :notes
      t.timestamps
    end

  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end

end
