defmodule Ueberauth.Strategy.ZoomTest do
  @moduledoc false
  use ExUnit.Case, async: true

  use Plug.Test

  import Mox

  describe "handle_request!/1" do
    test "passes the correct data to the OAuth request" do
      authorize_url = "https://zoomapi.test"

      expect(OAuthMock, :authorize_url!, fn params, opts ->
        assert params == []
        assert opts == [{:redirect_uri, "http://www.example.com/auth/zoom/callback"}]
        authorize_url
      end)

      conn =
        conn(:get, "/", %{})
        |> Ueberauth.run_request(:zoom, provider_config())

      assert %Plug.Conn{
               private: %{
                 ueberauth_request_options: %{
                   callback_methods: ["GET"],
                   callback_path: "/auth/zoom/callback",
                   request_path: "/auth/zoom",
                   strategy: Ueberauth.Strategy.Zoom,
                   strategy_name: :zoom
                 }
               },
               resp_headers: [
                 {"cache-control", "max-age=0, private, must-revalidate"},
                 {"location", ^authorize_url}
               ],
               scheme: :http,
               script_name: [],
               secret_key_base: nil,
               state: :sent,
               status: 302
             } = conn
    end

    test "passes the state value as a param if specified" do
      authorize_url = "https://zoomapi.test"
      optional_state = %{"state" => "state-value"}

      expect(OAuthMock, :authorize_url!, fn params, opts ->
        assert params == []

        assert opts == [
                 {:params, optional_state},
                 {:redirect_uri, "http://www.example.com/auth/zoom/callback"}
               ]

        authorize_url
      end)

      conn =
        conn(:get, "/", %{state: "state-value"})
        |> Ueberauth.run_request(:zoom, @provider_config)

      assert %Plug.Conn{params: ^optional_state} = conn
    end
  end

  defp provider_config do
    Keyword.get(Application.get_env(:ueberauth, Ueberauth)[:providers], :zoom)
  end
end
