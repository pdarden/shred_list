class Listing < ActiveRecord::Base

  validates_presence_of :title, :description, :state_id
  validates_numericality_of :asking_price,
    greater_than_or_equal_to: 0,
    allow_nil: true

  belongs_to :user,
    inverse_of: :listings
  belongs_to :state,
    inverse_of: :listings

  has_many :equipment,
    inverse_of: :listing,
    dependent: :destroy
  has_many :offers,
    inverse_of: :listing,
    dependent: :destroy

  def price_in_dollars
    "#{'%.2f' % (asking_price.to_d / 100) if asking_price}"
  end

  def price_in_dollars=(dollars)
    dollars = dollars.to_s.gsub(/[^0-9\.]+/, '')
    self.asking_price = dollars.to_d * 100 if dollars.present?
  end

  def owned_by?(viewer)
    if !viewer.nil?
      self.user_id == viewer.id
    end
  end

  def has_image?
    Picture.where(picturable_id: self.id).count > 0
  end

  def equipment_image
    pictures = equipment.sample.pictures
    pictures.sample.image_url(:thumb).to_s if pictures.count > 0
  end

  def state_name
    id = self.state_id
    State.find(id).name
  end

  def categories
    equipment.map{ |e| Category.find(e.category_id) }.uniq
  end

  def brands
    equipment.map{ |e| Brand.find(e.brand_id) }.uniq
  end

  def user_id
    self.user.id
  end

  def username
    user.username.capitalize
  end

  def currency_code
    currencies[state.name][0]
  end

  def currency_symbol
    currencies[state.name][1]
  end

  def currencies
    {
      "Alaska" => ['USD', '$'],
      "Alabama" => ['USD', '$'],
      "Arkansas" => ['USD', '$'],
      "American Samoa" => ['USD', '$'],
      "Arizona" => ['USD', '$'],
      "California" => ['USD', '$'],
      "Colorado" => ['USD', '$'],
      "Connecticut" => ['USD', '$'],
      "District of Columbia" => ['USD', '$'],
      "Delaware" => ['USD', '$'],
      "Florida" => ['USD', '$'],
      "Georgia" => ['USD', '$'],
      "Guam" => ['USD', '$'],
      "Hawaii" => ['USD', '$'],
      "Iowa" => ['USD', '$'],
      "Idaho" => ['USD', '$'],
      "Illinois" => ['USD', '$'],
      "Indiana" => ['USD', '$'],
      "Kansas" => ['USD', '$'],
      "Kentucky" => ['USD', '$'],
      "Louisiana" => ['USD', '$'],
      "Massachusetts" => ['USD', '$'],
      "Maryland" => ['USD', '$'],
      "Maine" => ['USD', '$'],
      "Michigan" => ['USD', '$'],
      "Minnesota" => ['USD', '$'],
      "Missouri" => ['USD', '$'],
      "Mississippi" => ['USD', '$'],
      "Montana" => ['USD', '$'],
      "North Carolina" => ['USD', '$'],
      "North Dakota" => ['USD', '$'],
      "Nebraska" => ['USD', '$'],
      "New Hampshire" => ['USD', '$'],
      "New Jersey" => ['USD', '$'],
      "New Mexico" => ['USD', '$'],
      "Nevada" => ['USD', '$'],
      "New York" => ['USD', '$'],
      "Ohio" => ['USD', '$'],
      "Oklahoma" => ['USD', '$'],
      "Oregon" => ['USD', '$'],
      "Pennsylvania" => ['USD', '$'],
      "Puerto Rico" => ['USD', '$'],
      "Rhode Island" => ['USD', '$'],
      "South Carolina" => ['USD', '$'],
      "South Dakota" => ['USD', '$'],
      "Tennessee" => ['USD', '$'],
      "Texas" => ['USD', '$'],
      "Utah" => ['USD', '$'],
      "Virginia" => ['USD', '$'],
      "Virgin Islands" => ['USD', '$'],
      "Vermont" => ['USD', '$'],
      "Washington" => ['USD', '$'],
      "Wisconsin" => ['USD', '$'],
      "West Virginia" => ['USD', '$'],
      "Wyoming" => ['USD', '$'],
      "Afghanistan" => ['AFN', '؋'],
      "Albania" => ['ALL', 'Lek'],
      "Algeria" => ['DZD', 'د.ج'],
      "Andorra" => ['EUR', '€'],
      "Angola" => ['AOA', 'Kz' ],
      "Anguilla" => ['XCD', '$'],
      "Antigua and Barbuda" => ['XCD', '$'],
      "Argentina" => ['ARS', '$'],
      "Armenia" => ['AMD', '&#1423;'],
      "Aruba" => ['AWG', 'ƒ'],
      "Australia" => ['AUD', '$'],
      "Austria" => ['EUR', '€'],
      "Azerbaijan" => ['AZN', 'ман'],
      "Bahamas" => ['BSD', '$'],
      "Bahrain" => ['BHD', '.د.ب '],
      "Bangladesh" => ['BDT', '৳'],
      "Barbados" => ['BBD', '$'],
      "Belarus" => ['BYR', 'p.'],
      "Belgium" => ['EUR', '€'],
      "Belize" => ['BZD', '$'],
      "Benin" => ['XOF', 'CFA'],
      "Bermuda" => ['BMD', '$'],
      "Bhutan" => ['BTN', 'Nu.'],
      "Bolivia" => ['BOB', '$b'],
      "Bosnia and Herzegowina" => ['BAM', 'KM'],
      "Botswana" => ['BWP', 'P'],
      "Bouvet Island" => ['EUR', '€'],
      "Brazil" => ['BRL', 'R$'],
      "British Indian Ocean Territory" => ['GBP', '£'],
      "Brunei Darussalam" => ['BND', '$'],
      "Bulgaria" => ['BGN', 'лв'],
      "Burkina Faso" => ['XOF', 'CFA'],
      "Burundi" => ['BIF','FBu'],
      "Cambodia" => ['',''],
      "Cameroon" => ['',''],
      "Canada" => ['',''],
      "Cape Verde" => ['',''],
      "Cayman Islands" => ['',''],
      "Central African Republic" => ['',''],
      "Chad" => ['',''],
      "Chile" => ['',''],
      "China" => ['',''],
      "Christmas Island" => ['',''],
      "Cocos (Keeling) Islands" => ['',''],
      "Colombia" => ['',''],
      "Comoros" => ['',''],
      "Congo" => ['',''],
      "Congo, the Democratic Republic of the" => ['',''],
      "Cook Islands" => ['',''],
      "Costa Rica" => ['',''],
      "Cote d'Ivoire" => ['',''],
      "Croatia (Hrvatska)" => ['',''],
      "Cuba" => ['',''],
      "Cyprus" => ['',''],
      "Czech Republic" => ['',''],
      "Denmark" => ['',''],
      "Djibouti" => ['',''],
      "Dominica" => ['',''],
      "Dominican Republic" => ['',''],
      "East Timor" => ['',''],
      "Ecuador" => ['',''],
      "Egypt" => ['',''],
      "El Salvador" => ['',''],
      "Equatorial Guinea" => ['',''],
      "Eritrea" => ['',''],
      "Estonia" => ['',''],
      "Ethiopia" => ['',''],
      "Falkland Islands (Malvinas)" => ['',''],
      "Faroe Islands" => ['',''],
      "Fiji" => ['',''],
      "Finland" => ['',''],
      "France" => ['',''],
      "France Metropolitan" => ['',''],
      "French Guiana" => ['',''],
      "French Polynesia" => ['',''],
      "French Southern Territories" => ['',''],
      "Gabon" => ['',''],
      "Gambia" => ['',''],
      "Georgia" => ['',''],
      "Germany" => ['',''],
      "Ghana" => ['',''],
      "Gibraltar" => ['',''],
      "Greece" => ['',''],
      "Greenland" => ['',''],
      "Grenada" => ['',''],
      "Guadeloupe" => ['',''],
      "Guam" => ['',''],
      "Guatemala" => ['',''],
      "Guinea" => ['',''],
      "Guinea-Bissau" => ['',''],
      "Guyana" => ['',''],
      "Haiti" => ['',''],
      "Heard and Mc Donald Islands" => ['',''],
      "Holy See (Vatican City State)" => ['',''],
      "Honduras" => ['',''],
      "Hong Kong" => ['',''],
      "Hungary" => ['',''],
      "Iceland" => ['',''],
      "India" => ['',''],
      "Indonesia" => ['',''],
      "Iran (Islamic Republic of)" => ['',''],
      "Iraq" => ['',''],
      "Ireland" => ['',''],
      "Israel" => ['',''],
      "Italy" => ['',''],
      "Jamaica" => ['',''],
      "Japan" => ['',''],
      "Jordan" => ['',''],
      "Kazakhstan" => ['',''],
      "Kenya" => ['',''],
      "Kiribati" => ['',''],
      "Korea" => ['',''],
      "Democratic People's Republic of" => ['',''],
      "Korea, Republic of" => ['',''],
      "Kuwait" => ['',''],
      "Kyrgyzstan" => ['',''],
      "Lao, People's Democratic Republic" => ['',''],
      "Latvia" => ['',''],
      "Lebanon" => ['',''],
      "Lesotho" => ['',''],
      "Liberia" => ['',''],
      "Libyan Arab Jamahiriya" => ['',''],
      "Liechtenstein" => ['',''],
      "Lithuania" => ['',''],
      "Luxembourg" => ['',''],
      "Macau" => ['',''],
      "Macedonia, The Former Yugoslav Republic of" => ['',''],
      "Madagascar" => ['',''],
      "Malawi" => ['',''],
      "Malaysia" => ['',''],
      "Maldives" => ['',''], 
      "Mali" => ['',''], 
      "Malta" => ['',''], 
      "Marshall Islands" => ['',''], 
      "Martinique" => ['',''], 
      "Mauritania" => ['',''], 
      "Mauritius" => ['',''], 
      "Mayotte" => ['',''], 
      "Mexico" => ['',''], 
      "Micronesia, Federated States of" => ['',''], 
      "Moldova, Republic of" => ['',''], 
      "Monaco" => ['',''], 
      "Mongolia" => ['',''], 
      "Montserrat" => ['',''], 
      "Morocco" => ['',''], 
      "Mozambique" => ['',''], 
      "Myanmar" => ['',''], 
      "Namibia" => ['',''], 
      "Nauru" => ['',''], 
      "Nepal" => ['',''], 
      "Netherlands" => ['',''], 
      "Netherlands Antilles" => ['',''], 
      "New Caledonia" => ['',''], 
      "New Zealand" => ['',''], 
      "Nicaragua" => ['',''], 
      "Niger" => ['',''], 
      "Nigeria" => ['',''], 
      "Niue" => ['',''], 
      "Norfolk Island" => ['',''], 
      "Northern Mariana Islands" => ['',''], 
      "Norway" => ['',''], 
      "Oman" => ['',''], 
      "Pakistan" => ['',''], 
      "Palau" => ['',''], 
      "Panama" => ['',''], 
      "Papua New Guinea" => ['',''], 
      "Paraguay" => ['',''], 
      "Peru" => ['',''], 
      "Philippines" => ['',''], 
      "Pitcairn" => ['',''], 
      "Poland" => ['',''], 
      "Portugal" => ['',''], 
      "Puerto Rico" => ['',''], 
      "Qatar" => ['',''], 
      "Reunion" => ['',''], 
      "Romania" => ['',''], 
      "Russian Federation" => ['',''], 
      "Rwanda" => ['',''], 
      "Saint Kitts and Nevis" => ['',''], 
      "Saint Lucia" => ['',''], 
      "Saint Vincent and the Grenadines" => ['',''], 
      "Samoa" => ['',''], 
      "San Marino" => ['',''], 
      "Sao Tome and Principe" => ['',''], 
      "Saudi Arabia" => ['',''], 
      "Senegal" => ['',''], 
      "Seychelles" => ['',''], 
      "Sierra Leone" => ['',''], 
      "Singapore" => ['',''], 
      "Slovakia (Slovak Republic)" => ['',''], 
      "Slovenia" => ['',''], 
      "Solomon Islands" => ['',''], 
      "Somalia" => ['',''], 
      "South Africa" => ['ZAR','R'], 
      "South Georgia and the South Sandwich Islands" => ['',''], 
      "Spain" => ['',''], 
      "Sri Lanka" => ['',''], 
      "St. Helena" => ['',''], 
      "St. Pierre and Miquelon" => ['',''], 
      "Sudan" => ['',''], 
      "Suriname" => ['',''], 
      "Svalbard and Jan Mayen Islands" => ['',''], 
      "Swaziland" => ['',''], 
      "Sweden" => ['',''], 
      "Switzerland" => ['',''], 
      "Syrian Arab Republic" => ['',''], 
      "Taiwan, Province of China" => ['',''], 
      "Tajikistan" => ['',''], 
      "Tanzania, United Republic of" => ['',''], 
      "Thailand" => ['',''], 
      "Togo" => ['',''], 
      "Tokelau" => ['',''], 
      "Tonga" => ['',''], 
      "Trinidad and Tobago" => ['',''], 
      "Tunisia" => ['',''], 
      "Turkey" => ['',''], 
      "Turkmenistan" => ['',''], 
      "Turks and Caicos Islands" => ['',''], 
      "Tuvalu" => ['',''], 
      "Uganda" => ['',''], 
      "Ukraine" => ['',''], 
      "United Arab Emirates" => ['',''], 
      "United Kingdom" => ['',''], 
      "United States" => ['',''], 
      "United States Minor Outlying Islands" => ['',''], 
      "Uruguay" => ['',''], 
      "Uzbekistan" => ['',''], 
      "Vanuatu" => ['',''], 
      "Venezuela" => ['',''], 
      "Vietnam" => ['',''], 
      "Virgin Islands (British)" => ['',''], 
      "Virgin Islands (U.S.)" => ['',''], 
      "Wallis and Futuna Islands" => ['',''], 
      "Western Sahara" => ['',''], 
      "Yemen" => ['',''], 
      "Yugoslavia" => ['',''],
      "Zambia" => ['ZMW', 'ZK'],
      "Zimbabwe" => ['ZWD', 'Z$']
    }
  end
end

