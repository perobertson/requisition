# frozen_string_literal: true

class RemoveUnusedUserAttributes < ActiveRecord::Migration[4.2]
  def up
    ## Recoverable
    remove_column :users, :reset_password_token, :string
    remove_column :users, :reset_password_sent_at, :datetime

    ## Rememberable
    remove_column :users, :remember_created_at, :datetime

    ## Trackable
    remove_column :users, :sign_in_count, :integer, default: 0, null: false
    remove_column :users, :current_sign_in_at, :datetime
    remove_column :users, :last_sign_in_at, :datetime
    remove_column :users, :current_sign_in_ip, :inet
    remove_column :users, :last_sign_in_ip, :inet

    ## Confirmable
    remove_column :users, :confirmation_token, :string
    remove_column :users, :confirmed_at, :datetime
    remove_column :users, :confirmation_sent_at, :datetime
    remove_column :users, :unconfirmed_email, :string

    ## Lockable
    remove_column :users, :failed_attempts, :integer, default: 0, null: false
    remove_column :users, :unlock_token, :string
    remove_column :users, :locked_at, :datetime

    ## Confirmable (Moved to end of table since they are nullable)
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email, :string
    add_index :users, %i[confirmation_token], unique: true
  end

  def down
    ## Recoverable
    add_column :users, :reset_password_token, :string
    add_column :users, :reset_password_sent_at, :datetime
    add_index :users, %i[reset_password_token], unique: true

    ## Rememberable
    add_column :users, :remember_created_at, :datetime

    ## Trackable
    add_column :users, :sign_in_count, :integer, default: 0, null: false
    add_column :users, :current_sign_in_at, :datetime
    add_column :users, :last_sign_in_at, :datetime
    add_column :users, :current_sign_in_ip, :inet
    add_column :users, :last_sign_in_ip, :inet

    ## Lockable
    add_column :users, :failed_attempts, :integer, default: 0, null: false
    add_column :users, :unlock_token, :string
    add_column :users, :locked_at, :datetime
    add_index :users, %i[unlock_token], unique: true
  end
end
