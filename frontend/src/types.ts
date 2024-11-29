export interface Address {
  id: number;
  address_cd: number;
  prefecture_cd: number;
  city_cd: number;
  town_cd: number;
  postal_code: string;
  business_flag: boolean;
  abolished_flag: boolean;
  prefecture: string;
  prefecture_kana: string;
  city: string;
  city_kana: string;
  town: string;
  town_kana: string;
  town_supplement: string;
  kyoto_street: string;
  chome: string;
  chome_kana: string;
  supplement: string;
  business_name: string;
  business_name_kana: string;
  business_address: string;
  new_address_cd: number | null;
  created_at: string;
  updated_at: string;
}
