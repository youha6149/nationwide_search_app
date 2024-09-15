class CreateAddresses < ActiveRecord::Migration[7.2]
  def change
    create_table :addresses do |t|
      t.integer :address_cd
      t.integer :prefecture_cd
      t.integer :city_cd
      t.integer :town_cd
      t.string :postal_code
      t.boolean :business_flag
      t.boolean :abolished_flag
      t.string :prefecture
      t.string :prefecture_kana
      t.string :city
      t.string :city_kana
      t.string :town
      t.string :town_kana
      t.string :town_supplement
      t.string :kyoto_street
      t.string :chome
      t.string :chome_kana
      t.string :supplement
      t.string :business_name
      t.string :business_name_kana
      t.string :business_address
      t.integer :new_address_cd

      t.timestamps
    end
  end
end
