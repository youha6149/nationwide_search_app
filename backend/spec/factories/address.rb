FactoryBot.define do
  factory :address do
    address_cd { 105000000 }
    prefecture_cd { 13 }
    city_cd { 13103 }
    town_cd { 131030000 }
    postal_code { "105-0000" }
    business_flag { false }
    abolished_flag { false }
    prefecture { "東京都" }
    prefecture_kana { "トウキョウト" }
    city { "港区" }
    city_kana { "ミナトク" }
    town { nil }
    town_kana { "　" }
    town_supplement { "（該当なし）" }
    kyoto_street { nil }
    chome { nil }
    chome_kana { nil }
    supplement { nil }
    business_name { nil }
    business_name_kana { nil }
    business_address { nil }
    new_address_cd { nil }
    created_at { "2024-09-15T08:20:55.666Z" }
    updated_at { "2024-09-15T08:20:55.666Z" }

    trait :osaka do
      address_cd { 123456789 }
      prefecture_cd { 27 }
      city_cd { 27100 }
      town_cd { 271000000 }
      postal_code { "530-0000" }
      prefecture { "大阪府" }
      prefecture_kana { "オオサカフ" }
      city { "大阪市" }
      city_kana { "オオサカシ" }
    end
  end
end
