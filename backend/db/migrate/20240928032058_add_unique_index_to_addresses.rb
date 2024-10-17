class AddUniqueIndexToAddresses < ActiveRecord::Migration[7.0]
  def change
    # address_cdカラムに一意制約（UNIQUE INDEX）を追加
    add_index :addresses, :address_cd, unique: true
  end
end
