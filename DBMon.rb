class DBMon
  @@BASE_URL = "https://www.sw-database.com/"
  attr_reader :icon_url,:good_for,:skills,:name,:strengths,:weak

  def initialize(url)
    name_trig = false
    good_trig = false
    skill_trig = false
    skill_f_trig = false
    str_trig = false
    weak_trig = false

    @name = ""
    @skills = [""]
    @strengths = []
    @weak = []
    counter = 0
    doc = Nokogiri::HTML(open(@@BASE_URL+url.to_s))

    @icon_url = doc.css('image').map {|element| element["xlink:href"]}.compact[0].to_s.strip

    doc.css('span[style*="font-family:open sans,sans-serif;"]').map(&:text).compact.each do |item|
      # puts item
      if weak_trig and item.to_s.start_with?("*")
        weak_trig = false
      end

      if item.to_s.start_with?("Weakness:")
        str_trig = false
        weak_trig = true
        next
      end
      if name_trig and counter <= 1
        @name += item.to_s.strip
        counter += 1
      end
      if good_trig
        @good_for = item.to_s.strip
        good_trig = false
      end
      if skill_f_trig and not item.to_s.include?(":")
        @skills [0] = item.to_s
        next
      end
      if skill_f_trig and item.to_s.include?(":")
        @skills[0] = skills[0]+item.to_s
        skill_f_trig = false
        next
      end
      if skill_trig and item.to_s.include?(":")
        if item.downcase.start_with?("multiplier")
          next
        end
        @skills << item.to_s
      end
      if str_trig
        @strengths << item.to_s.strip
        next
      end
      if weak_trig
        @weak << item.to_s.strip
        next
      end



      if item.to_s.start_with?("HOME | BEST MONSTERS | TIPS  | MEMES | CONTACT")
        name_trig = true
      end
      if item.to_s.start_with?("GOOD FOR")
        good_trig = true
      end
      if item.to_s.start_with?("SKILLS")
        if not skill_trig
          skill_f_trig = true
        end
        skill_trig = !skill_trig

      end
      if item.to_s.start_with?("Strengths:")
        str_trig = true
      end


    end
    puts "SKILLS =========================="
    puts @skills.inspect

  end

end
