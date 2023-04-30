defmodule ATProto.BSky do
  @moduledoc """
  `app.bsky` lexicon functions
  """

  # app.bsky.feed (https://atproto.com/lexicons/app-bsky-feed)

  @doc """
  A view of the user's home timeline.
  """
  def get_timeline(client, params \\ []) do
    case XRPC.query(client, "app.bsky.feed.getTimeline", params: params) do
      {:ok, body} -> ATProto.BSky.Feed.new(body)
      result -> result
    end
  end

  @doc """
  Wrapper around `ATProto.create_record` to create a BSky post
  """
  def create_post(client, repo, record) do
    record = Keyword.put_new(record, :"$type", "app.bsky.feed.post")
    ATProto.create_record(client, repo, "app.bsky.feed.post", record)
  end

  @doc """
  A view of an actor's feed.
  """
  def get_author_feed(client, actor, params \\ []) do
    params = [actor: actor] |> Keyword.merge(params)

    case XRPC.query(client, "app.bsky.feed.getAuthorFeed", params: params) do
      {:ok, body} -> ATProto.BSky.Feed.new(body)
      result -> result
    end
  end

  @doc """
  A view of an actor's feed.
  """
  def get_posts(client, uris) do
    params = [uris: uris]

    XRPC.query(client, "app.bsky.feed.getPosts", params: params)
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

  @doc """
  Who is following an actor?
  """

  def get_followers(client, actor, params \\ []) do
    params = [actor: actor] |> Keyword.merge(params)

    case XRPC.query(client, "app.bsky.graph.getFollowers", params: params) do
      {:ok, body} -> ATProto.BSky.Followers.new(body)
      result -> result
    end
  end

  @doc """
  Who is an actor following?
  """
  def get_follows(client, actor, params \\ []) do
    params = [actor: actor] |> Keyword.merge(params)

    case XRPC.query(client, "app.bsky.graph.getFollows", params: params) do
      {:ok, body} -> ATProto.BSky.Follows.new(body)
      result -> result
    end
  end

  @doc """
  Who does the viewer mute?
  """
  def get_mutes(client, params \\ []) do
    case XRPC.query(client, "app.bsky.graph.getMutes", params: params) do
      {:ok, body} -> ATProto.BSky.Mutes.new(body)
      result -> result
    end
  end

  @doc """
  Mute an actor by did or handle.
  """
  def mute_actor(client, actor) do
    body = %{actor: actor} |> Jason.encode!()
    XRPC.procedure(client, "app.bsky.graph.muteActor", body: body)
  end

  @doc """
  Unmute an actor by did or handle.
  """
  def unmute_actor(client, actor) do
    body = %{actor: actor} |> Jason.encode!()
    XRPC.procedure(client, "app.bsky.graph.unmuteActor", body: body)
  end

  # app.bsky.unspecced

  @doc """
  An unspecced view of globally popular items.
  """
  def get_popular(client, params \\ []) do
    case XRPC.query(client, "app.bsky.unspecced.getPopular", params: params) do
      {:ok, body} -> ATProto.BSky.Feed.new(body)
      result -> result
    end
  end
end
