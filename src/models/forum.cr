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

  def self.site_threads(sid, fid)
    records = [] of {Int32, Int32, Int32, String, Time, Int32}
    connect { |db| records = db.exec({Int32, Int32, Int32, String, Time, Int32}, "select siteid,fid,tid,title,updated,responses from threads where siteid=$1 and fid=$2 order by updated desc", [sid, fid]).rows }
    records
  end

  def self.forum_name(sid, fid)
    records = [] of String
    connect { |db| records = db.exec("select name from forums where siteid=$1 and fid=$2", [sid, fid]).rows }
    records[0][0]
  end
end
