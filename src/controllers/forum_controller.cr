class ForumsController < ApplicationController
  get "/" do
    mforums = Forum.main_forums
    mforums_threads = Hash(Int32, Array({Int32, Int32, Int32, String, Time, Int32})).new

    mforums.each do |mf|
      mfid = mf[0] as Int32
      grouped_forums = Forum.grouped_forums(mfid)
      mforums_threads[mfid] = [] of {Int32, Int32, Int32, String, Time, Int32}

      grouped_forums.each do |group|
        threads = Forum.site_threads(group[0], group[1], 3)
        # site_forum_threads = threads.map { |thr| {thr[0], thr[1], thr[2], thr[3], thr[4]} }
        mforums_threads[mfid] = mforums_threads[mf[0]] + threads
      end
    end
    respond_to(:html, GroupedAllThreadsView.new(mforums, mforums_threads).set_view)
  end

  get "/group/:gid" do |params|
    gid = 0
    unless params.empty?
      gid = params["gid"]
    end
    site_group = Forum.main_forums
    grouped_forums = Forum.grouped_forums(gid)
    group_threads = [] of {Int32, Int32, Int32, String, Time, Int32}

    grouped_forums.each do |group|
      threads = Forum.site_threads(group[0], group[1], 20)
      # site_forum_threads = threads.map { |thr| {thr[0], thr[1], thr[2], thr[3], thr[4]} }
      group_threads = group_threads + threads
    end
    respond_to(:html, GroupedThreadsView.new(site_group, group_threads).set_view)
  end
  get "/site/:sid/forums" do |params|
    unless params.empty?
      forums = Forum.site_forums(params["sid"])
      # ff = ["id", "forum title"]
      # forums = [{"forum": " forum title"}]*100
      respond_to(:html, ForumsListView.new(forums).set_view)
    else
      forums = Forum.all
      respond_to(:html, ForumsListView.new(forums).set_view)
    end
  end

  get "/rsn/forums" do |params|
    forums = Forum.site_forums(2)
    respond_to(:html, ForumsNavView.new(2, forums).set_view)
  end

  get "/lor/forums" do |params|
    forums = Forum.site_forums(3)
    respond_to(:html, ForumsNavView.new(3, forums).set_view)
  end

  get "/sqlr/forums" do |params|
    forums = Forum.site_forums(6)
    respond_to(:html, ForumsNavView.new(6, forums).set_view)
  end
  get "/rsn/forum/:fid" do |params|
    forums = Forum.site_forums(2)
    unless params.empty?
      threads = Forum.site_threads(2, params["fid"])
      fname = Forum.forum_name(2, params["fid"])
      respond_to(:html, ForumThreadsView.new(forums, threads, 2, fname).set_view)
    else
      redirect_to "/"
    end
  end
  get "/lor/forum/:fid" do |params|
    forums = Forum.site_forums(3)
    unless params.empty?
      threads = Forum.site_threads(3, params["fid"])
      fname = Forum.forum_name(3, params["fid"])
      respond_to(:html, ForumThreadsView.new(forums, threads, 3, fname).set_view)
    else
      redirect_to "/"
    end
  end

  get "/sqlr/forum/:fid" do |params|
    forums = Forum.site_forums(6)
    unless params.empty?
      threads = Forum.site_threads(6, params["fid"])
      fname = Forum.forum_name(6, params["fid"])
      respond_to(:html, ForumThreadsView.new(forums, threads, 6, fname).set_view)
    else
      redirect_to "/"
    end
  end
end
