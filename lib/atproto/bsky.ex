defmodule ATProto.BSky do
  @moduledoc """
  `app.bsky` lexicon functions
  """

  # app.bsky.feed (https://atproto.com/lexicons/app-bsky-feed)

  def get_timeline(client) do
    XRPC.query(client, "app.bsky.feed.getTimeline")
  end

  def create_post(client, repo, record) do
    record = Keyword.put_new(record, :"$type", "app.bsky.feed.post")
    ATProto.create_record(client, repo, "app.bsky.feed.post", record)
  end

  # app.bsky.actor (https://atproto.com/lexicons/app-bsky-actor)

  def get_profile(client, actor) do
    params = [actor: actor]

    case XRPC.query(client, "app.bsky.actor.getProfile", params: params) do
      {:ok, body} -> ATProto.BSky.ProfileViewDetailed.new(body)
      result -> result
    end
  end

  # app.bsky.graph (https://atproto.com/lexicons/app-bsky-graph)

  def get_followers(client, actor) do
    params = [actor: actor]
    XRPC.query(client, "app.bsky.graph.getFollowers", params: params)
  end

  # app.bsky.unspecced

  @doc """
  An unspecced view of globally popular items.
  """
  def get_popular(client, params \\ []) do
    XRPC.query(client, "app.bsky.unspecced.getPopular", params: params)
  end
end
