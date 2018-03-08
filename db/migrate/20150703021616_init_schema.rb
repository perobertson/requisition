class InitSchema < ActiveRecord::Migration[4.2]
  def up
    # These are extensions that must be enabled in order to support this database
    enable_extension 'plpgsql'

    create_table 'abilities', force: :cascade do |t|
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.datetime 'deleted_at'
      t.string 'kind',       null: false
    end

    add_index 'abilities', ['kind'], name: 'index_abilities_on_kind', unique: true, using: :btree

    create_table 'categories', force: :cascade do |t|
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.datetime 'deleted_at'
      t.string 'name',       null: false
    end

    add_index 'categories', ['name'], name: 'index_categories_on_name', unique: true, using: :btree

    create_table 'items', force: :cascade do |t|
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.datetime 'deleted_at'
      t.integer 'type_id',     null: false
      t.string 'name',        null: false
      t.boolean 'for_sale',    null: false
      t.integer 'category_id', null: false
    end

    add_index 'items', ['category_id'], name: 'index_items_on_category_id', using: :btree
    add_index 'items', ['name'], name: 'index_items_on_name', unique: true, using: :btree
    add_index 'items', ['type_id'], name: 'index_items_on_type_id', unique: true, using: :btree

    create_table 'order_items', force: :cascade do |t|
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.datetime 'deleted_at'
      t.integer 'order_id',   null: false
      t.integer 'item_id',    null: false
      t.integer 'quantity',   null: false
    end

    add_index 'order_items', ['item_id'], name: 'index_order_items_on_item_id', using: :btree
    add_index 'order_items', ['order_id'], name: 'index_order_items_on_order_id', using: :btree

    create_table 'orders', force: :cascade do |t|
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.datetime 'deleted_at'
      t.string 'character_name', null: false
    end

    create_table 'user_abilities', force: :cascade do |t|
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.datetime 'deleted_at'
      t.integer 'user_id',    null: false
      t.integer 'ability_id', null: false
    end

    add_index 'user_abilities', ['user_id', 'ability_id', 'deleted_at'], name: 'index_user_abilities_on_user_id_and_ability_id_and_deleted_at', unique: true, using: :btree

    create_table 'users', force: :cascade do |t|
      t.string 'email',                  default: '', null: false
      t.string 'encrypted_password',     default: '', null: false
      t.string 'reset_password_token'
      t.datetime 'reset_password_sent_at'
      t.datetime 'remember_created_at'
      t.integer 'sign_in_count',          default: 0,  null: false
      t.datetime 'current_sign_in_at'
      t.datetime 'last_sign_in_at'
      t.inet 'current_sign_in_ip'
      t.inet 'last_sign_in_ip'
      t.string 'confirmation_token'
      t.datetime 'confirmed_at'
      t.datetime 'confirmation_sent_at'
      t.string 'unconfirmed_email'
      t.integer 'failed_attempts',        default: 0,  null: false
      t.string 'unlock_token'
      t.datetime 'locked_at'
      t.datetime 'created_at',                          null: false
      t.datetime 'updated_at',                          null: false
    end

    add_index 'users', ['confirmation_token'], name: 'index_users_on_confirmation_token', unique: true, using: :btree
    add_index 'users', ['email'], name: 'index_users_on_email', unique: true, using: :btree
    add_index 'users', ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true, using: :btree
    add_index 'users', ['unlock_token'], name: 'index_users_on_unlock_token', unique: true, using: :btree
  end

  def down
    fail 'Can not revert initial migration'
  end
end
