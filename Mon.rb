class Mon

  attr_reader :icon_url,:title,:grade,:type,:get_from,:awaken,:good_for,:skillup

  def initialize(url)
    doc = Nokogiri::HTML(open(url.to_s))
    @icon_url = icon_url1(doc).to_s
    @title = title1(doc).map(&:text).compact[0]
    details(doc)
  end

  private def icon_url1(doc)
    doc.css('img.featured2').map {|element| element["src"]}.compact[0]
  end
  private def title1(doc)
    doc.css('h1.main-title')
  end
  private def details(doc)
    items = doc.css('div.detail-item').css('p').map(&:text).compact
    @grade = items[0]
    @type = items[1]
    @get_from = items[2]
    @awaken = items[3]
    @good_for = items[4]
    @skillup = items[5]
  end
end
