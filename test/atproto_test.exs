defmodule ATProtoTest do
  use ExUnit.Case
  doctest ATProto

  describe "resolve_handle/2" do
    test "makes a successful request" do
      {:ok, response} =
        XRPC.Client.new("https://bsky.social")
        |> ATProto.resolve_handle("atproto.com")

      assert response == %{"did" => "did:plc:ewvi7nxzyoun6zhxrhs64oiz"}
    end
  end
end
