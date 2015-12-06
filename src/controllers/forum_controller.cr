class ForumsController < ApplicationController
  get "/" do
    mforums = Forum.main_forums
    mforums_threads = Hash(Int32, Array({Int32, Int32, Int32, String})).new

    mforums.each do |mf|
      mfid = mf[0] as Int32
      grouped_forums = Forum.grouped_forums(mfid)
      mforums_threads[mfid] = [] of {Int32, Int32, Int32, String}

      grouped_forums.each do |group|
        threads = Forum.site_threads(group[0], group[1], 3)
        site_forum_threads = threads.map { |thr| {thr[0], thr[1], thr[2], thr[3]} }

        if mforums_threads.has_key?(mfid)
          mforums_threads[mfid] = mforums_threads[mf[0]] + site_forum_threads
        else
          mforums_threads[mfid] = site_forum_threads
        end
      end
    end
    respond_to(:html, GroupedForumsView.new(mforums, mforums_threads).set_view)
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
