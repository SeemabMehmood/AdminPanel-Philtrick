module HomeHelper
  def to_euro(amount, currency)
    return btc_to_euro(amount) if currency == 'BTC'
    return ltc_to_euro(amount) if currency == 'LTC'
    bch_to_euro(amount) if currency == 'BCH'
  end

  def btc_to_euro(amount)
    round_income(amount * Currency.bitcoin_rate, 8)
  end

  def ltc_to_euro(amount)
    round_income(amount * Currency.litcoin_rate, 8)
  end

  def bch_to_euro(amount)
    round_income(amount * Currency.bitcash_rate, 8)
  end

  def round_income(income, decimal)
    "%.#{decimal}f" % income
  end

  def currency_icon_box(currency)
    return image_tag("LTC-icon.png", class: "ltc-icon custom-icon box-icon", alt: "Litcoin") if currency == 'LTC'
    return image_tag("BCH-icon.png", class: "bch-icon custom-icon box-icon", alt: "Bitcoin Cash") if currency == 'BCH'
    "<div class='icon'><i class='ion ion-social-bitcoin'></i></div>".html_safe if currency == 'BTC'
  end

  def currency_icon_balance(currency)
    return image_tag("LTC-icon.png", class: "ltc-icon custom-icon", alt: "Litcoin") if currency == 'LTC'
    return image_tag("BCH-icon.png", class: "bch-icon custom-icon", alt: "Bitcoin Cash") if currency == 'BCH'
    "<i class='ion ion-social-bitcoin'></i>".html_safe if currency == 'BTC'
  end
end
