class Forum < Amatista::Model
  property connection

  def self.all
    records = [] of String
    connect { |db| records = db.exec("select * from forums").rows }
    records
  end

  def self.site_forums(sid)
    records = [] of String
    connect { |db| records = db.exec("select * from forums where siteid=$1", [sid]).rows }
    records
  end
end
