class Forum < Amatista::Model
  property connection

  def self.all
    records = [] of String
    connect { |db| records = db.exec("select * from forums").rows }
    records
  end

  def self.main_forums
    records = [] of {Int32, String}
    connect { |db| records = db.exec("select * from main_forums").rows }
    records
  end

  def self.grouped_forums(group_id)
    records = [] of {Int32, Int32}
    connect { |db| records = db.exec("select siteid, fid from site_forums where mfid=$1", [group_id]).rows }
    records
  end

  def self.site_forums(sid)
    records = [] of String
    connect { |db| records = db.exec("select * from forums where \"check\"=1 and siteid=$1", [sid]).rows }
    records
  end

  def self.site_threads(sid, fid, size = 50)
    records = [] of {Int32, Int32, Int32, String, Time, Int32}
    connect { |db| records = db.exec({Int32, Int32, Int32, String, Time, Int32},
      "select siteid,fid,tid,title,updated,responses from threads where siteid=$1 and fid=$2 order by updated desc  limit $3", [sid, fid, size]).rows }
    records
  end

  def self.forum_name(sid, fid)
    records = [] of String
    connect { |db| records = db.exec("select name from forums where siteid=$1 and fid=$2", [sid, fid]).rows }
    records[0][0]
  end
end
