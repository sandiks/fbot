module ForumHelper
  def self.get_thread_link(sid, fname, tid)
    case sid
    when 2
      "http://rsdn.ru/forum/#{fname}/#{tid}.flat.1"
    when 3
      "http://www.linux.org.ru/forum/#{fname}/#{tid}"
    when 4
      "http://www.gamedev.ru/#{fname}/forum/?id=#{tid}"
    when 6
      "http://www.sql.ru/forum/#{tid}"
    end
  end

  def self.get_site_name(sid)
    sites = ["", "", "rsdn", "lor", "gamedev", "onln", "sqlru"]
    sites[sid]
  end
end
