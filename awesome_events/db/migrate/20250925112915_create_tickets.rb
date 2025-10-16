class CreateTickets < ActiveRecord::Migration[8.0]
  def change
    create_table :tickets do |t|
      t.references :user # foreign_key: true をつけないと外部キー制約がつかない。今回に限ってはユーザー退会（ユーザー削除）されても tickets テーブルのレコードは残す必要があるので、foreign_key: true　はつけない。
      t.references :event, null: false, foreign_key: true, index: false
      t.string :comment

      t.timestamps
    end

    add_index :tickets, %i[event_id user_id], unique: true #event_id を index の先頭に持ってきているため、event_idで絞り込みをする場合（単独でも）に高速で検索できる
  end
end