# ATProto

Implementation of the [ATProtocol](https://atproto.com/docs) client spec in Elixir.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `atproto` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:atproto, "~> 0.1.0"}
  ]
end
```

The docs can be found at <https://hexdocs.pm/atproto>.

## Usage

`ATProtocol` uses `XRPC` for API communication, so we need to build an `XRPC.Client` and then we can call `ATProto` or `ATProto.BSky` functions.

Unauthenticated example:

```elixir
XRPC.Client.new("https://bsky.social")
|> ATProto.resolve_handle("atproto.com")

{:ok, %{"did" => "did:plc:ewvi7nxzyoun6zhxrhs64oiz"}}
```

Authenticated example:

```elixir
client = XRPC.Client.new("https://bsky.social")

{:ok, session} = ATProto.create_session(client, "atproto@example.com", "xxxx-xxxx-xxxx-xxxx")

client
|> Map.put(:access_token, session.access_jwt)
|> ATProto.BSky.get_profile("atproto.com")

{:ok,
 %ATProto.BSky.ProfileViewDetailed{
   avatar: "https://cdn.bsky.social/imgproxy/EoCjH1lIwK1YNFuG_xYYK76vuHhEAQKWAkzlz8BSO_Q/rs:fill:1000:1000:1:0/plain/bafkreibjfgx2gprinfvicegelk5kosd6y2frmqpqzwqkg7usac74l3t2v4@jpeg",
   banner: "https://cdn.bsky.social/imgproxy/Goxx1Ze2lScFMdlEXE0pVTzXBxsIuwbdxhYkWo1CVUA/rs:fill:3000:1000:1:0/plain/bafkreib4xwiqhxbqidwwatoqj7mrx6mr7wlc5s6blicq5wq2qsq37ynx5y@jpeg",
   description: "Social networking technology created by Bluesky.",
   did: "did:plc:ewvi7nxzyoun6zhxrhs64oiz",
   display_name: "AT Protocol",
   followers_count: 1965,
   follows_count: 11,
   handle: "atproto.com",
   posts_count: 10,
   ...
 }}
```

Creating a new post on Blue Sky:

```elixir
{:ok, session} = ....
XRPC.Client.new("https://bsky.social", session.access_jwt)
|> ATProto.BSky.create_post("atproto.com", text: "Hello Elixir 💜")
```
