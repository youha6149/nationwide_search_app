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

    trait :shinagawa do
      address_cd { 140000000 }
      prefecture_cd { 13 }
      city_cd { 13109 }
      town_cd { 131090000 }
      postal_code { "140-0000" }
      business_flag { false }
      abolished_flag { false }
      prefecture { "東京都" }
      prefecture_kana { "トウキョウト" }
      city { "品川区" }
      city_kana { "シナガワク" }
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
    end

    trait :osaka do
      address_cd { 577000000 }
      prefecture_cd { 27 }
      city_cd { 27227 }
      town_cd { 272270000 }
      postal_code { "577-0000" }
      prefecture { "大阪府" }
      prefecture_kana { "オオサカフ" }
      city { "東大阪市" }
      city_kana { "ヒガシオオサカシ" }
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
    end

    trait :kanagawa_minami_ashigara do
      address_cd { 250011700 }
      prefecture_cd { 14 }
      city_cd { 14217 }
      town_cd { 142170016 }
      postal_code { "250-0117" }
      prefecture { "神奈川県" }
      prefecture_kana { "カナガワケン" }
      city { "南足柄市" }
      city_kana { "ミナミアシガラシ" }
      town { "塚原" }
      town_kana { "ツカハラ" }
    end

    trait :kanagawa_kawasaki_asao do
      address_cd { 215002400 }
      prefecture_cd { 14 }
      city_cd { 14137 }
      town_cd { 141370014 }
      postal_code { "215-0024" }
      prefecture { "神奈川県" }
      prefecture_kana { "カナガワケン" }
      city { "川崎市麻生区" }
      city_kana { "カワサキシアサオク" }
      town { "白鳥" }
      town_kana { "シラトリ" }
    end

    trait :yamaguchi_shimonoseki do
      address_cd { 759652200 }
      prefecture_cd { 35 }
      city_cd { 35201 }
      town_cd { 352010366 }
      postal_code { "759-6522" }
      prefecture { "山口県" }
      prefecture_kana { "ヤマグチケン" }
      city { "下関市" }
      city_kana { "シモノセキシ" }
      town { "吉見竜王町" }
      town_kana { "ヨシミリュウオウチョウ" }
    end

    trait :yamanashi_kitatsuru_tabayama do
      address_cd { 409030500 }
      prefecture_cd { 19 }
      city_cd { 19443 }
      town_cd { 194430010 }
      postal_code { "409-0305" }
      prefecture { "山梨県" }
      prefecture_kana { "ヤマナシケン" }
      city { "北都留郡丹波山村" }
      city_kana { "キタツルグンタバヤマムラ" }
      town { "高尾" }
      town_kana { "タカオ" }
    end

    trait :niigata_minamiuonuma do
      address_cd { 949643100 }
      prefecture_cd { 15 }
      city_cd { 15226 }
      town_cd { 152260052 }
      postal_code { "949-6431" }
      prefecture { "新潟県" }
      prefecture_kana { "ニイガタケン" }
      city { "南魚沼市" }
      city_kana { "ミナミウオヌマシ" }
      town { "樺野沢" }
      town_kana { "カバノサワ" }
    end
  end
end
