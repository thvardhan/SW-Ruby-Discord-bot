class Database

  @@links = []
  @@scrape_link

  @@interrupt = false

  def initialize(link)
    @@scrape_link = link
    @@counter = 0
  end

  def update(thread_num)
    counter = 0
    threads = []
    puts "Updating DB"
    while !@@interrupt
      thread_num.times do
        link = "#{@@scrape_link}#{counter}"
        threads << Thread.new{fetch(link)}
        counter += 1
        #puts "Fetching #{counter} page"
      end
      threads.each { |thr| thr.join }
    end
    puts "Updating finished!"
  end

  def link_by_name(name)
    @@links.each do |item|
      if item.to_s.include?(name.downcase)
        return item
      end
    end
    nil
  end

  private def fetch(link)
    begin
      doc = Nokogiri::HTML(open(link.to_s))
      ndoc = doc.css('a.layer-link')
      found = ndoc.map {|element| element["href"]}.compact
      @@links = @@links+found
    rescue OpenURI::HTTPError
      @@interrupt = true
    end
  end

end
