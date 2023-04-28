defmodule ATProto.BSky.RichText do
  @link_re ~r{https?://[\w.-\\\?]+}
  @mention_re ~r{@[\w.-]+}

  def detect_facets(text) do
    ((find_links(text) |> Enum.map(&link_facet/1)) ++
       (find_mentions(text) |> Enum.map(&mention_facet/1)))
    |> Enum.filter(& &1)
  end

  def find_links(text) do
    links = Regex.scan(@link_re, text) |> Enum.map(&List.first(&1))
    positions = Regex.scan(@link_re, text, return: :index) |> Enum.map(&List.first(&1))
    Enum.zip(links, positions)
  end

  def find_mentions(text) do
    mentions = Regex.scan(@mention_re, text) |> Enum.map(&List.first(&1))
    positions = Regex.scan(@mention_re, text, return: :index) |> Enum.map(&List.first(&1))
    Enum.zip(mentions, positions)
  end

  def link_facet({uri, {start_index, length}}) do
    %{
      "$type": "app.bsky.richtext.facet",
      index: %{
        byteStart: start_index,
        byteEnd: start_index + length
      },
      features: [
        %{"$type": "app.bsky.richtext.facet#link", uri: uri}
      ]
    }
  end

  def mention_facet({mention, {start_index, length}}) do
    "@" <> handle = mention

    case resolve_handle(handle) do
      {:ok, %{"did" => did}} ->
        %{
          "$type": "app.bsky.richtext.facet",
          index: %{
            byteStart: start_index,
            byteEnd: start_index + length
          },
          features: [
            %{"$type": "app.bsky.richtext.facet#mention", did: did}
          ]
        }

      _ ->
        nil
    end
  end

  def resolve_handle(handle) do
    XRPC.Client.new("https://bsky.social")
    |> ATProto.resolve_handle(handle)
  end
end
