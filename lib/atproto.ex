defmodule ATProto do
  @moduledoc """
  `com.atproto` lexicon functions.
  """

  # com.atproto.identity (https://atproto.com/lexicons/com-atproto-identity)

  @doc """
  Provides the DID of a repo.
  """
  def resolve_handle(client, handle \\ nil) do
    params = [handle: handle]
    XRPC.query(client, "com.atproto.identity.resolveHandle", params: params)
  end

  # com.atproto.server (https://atproto.com/lexicons/com-atproto-server)

  @doc """
  Create an authentication session.
  """
  def create_session(client, identifier, password) do
    body = %{identifier: identifier, password: password} |> Jason.encode!()

    case XRPC.procedure(client, "com.atproto.server.createSession", body: body) do
      {:ok, body} -> ATProto.Session.new(body)
      result -> result
    end
  end

  # com.atproto.repo (https://atproto.com/lexicons/com-atproto-repo)

  @doc """
  Create a new record.
  """
  def create_record(client, repo, collection, record) do
    record =
      %{createdAt: DateTime.utc_now() |> DateTime.to_iso8601()}
      |> Map.merge(Enum.into(record, %{}))

    body = %{collection: collection, repo: repo, record: record} |> Jason.encode!()

    XRPC.procedure(client, "com.atproto.repo.createRecord", body: body)
  end

  @doc """
  Get information about the repo, including the list of collections.
  """
  def describe_repo(client, repo) do
    params = [repo: repo]
    XRPC.query(client, "com.atproto.repo.describeRepo", params: params)
  end

  @doc """
  Get a record.
  """
  def get_record(client, repo, collection, rkey, params \\ []) do
    params = [repo: repo, collection: collection, rkey: rkey] |> Keyword.merge(params)

    XRPC.query(client, "com.atproto.repo.getRecord", params: params)
  end

  @doc """
  List a range of records in a collection.
  """
  def list_records(client, repo, collection, params \\ []) do
    params = [repo: repo, collection: collection] |> Keyword.merge(params)

    XRPC.query(client, "com.atproto.repo.listRecords", params: params)
  end
end
