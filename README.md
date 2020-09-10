# Überauth Zoom [![Hex Version](https://img.shields.io/hexpm/v/ueberauth_zoom.svg)](https://hex.pm/packages/ueberauth_zoom)

> Zoom OAuth2 strategy for Überauth.

## Installation

1. Setup your application at [Zoom App Marketplace](https://marketplace.zoom.us/).

1. Add `:ueberauth_zoom` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:ueberauth_zoom, "~> 0.1"}]
    end
    ```

1. Add the strategy to your applications:

    ```elixir
    def application do
      [applications: [:ueberauth_zoom]]
    end
    ```

1. Add Zoom to your Überauth configuration:

    ```elixir
    config :ueberauth, Ueberauth,
      providers: [
        zoom: {Ueberauth.Strategy.Zoom, []}
      ]
    ```

1.  Update your provider configuration:

    Use that if you want to read client ID/secret from the environment
    variables in the compile time:

    ```elixir
    config :ueberauth, Ueberauth.Strategy.Zoom.OAuth,
      client_id: System.get_env("ZOOM_CLIENT_ID"),
      client_secret: System.get_env("ZOOM_CLIENT_SECRET")
    ```

    Use that if you want to read client ID/secret from the environment
    variables in the run time:

    ```elixir
    config :ueberauth, Ueberauth.Strategy.Zoom.OAuth,
      client_id: {System, :get_env, ["ZOOM_CLIENT_ID"]},
      client_secret: {System, :get_env, ["ZOOM_CLIENT_SECRET"]}
    ```

1.  Include the Überauth plug in your controller:

    ```elixir
    defmodule MyApp.AuthController do
      use MyApp.Web, :controller
      plug Ueberauth
      ...
    end
    ```

1.  Create the request and callback routes if you haven't already:

    ```elixir
    scope "/auth", MyApp do
      pipe_through :browser

      get "/:provider", AuthController, :request
      get "/:provider/callback", AuthController, :callback
    end
    ```

1. Your controller needs to implement callbacks to deal with `Ueberauth.Auth` and `Ueberauth.Failure` responses.

For an example implementation see the [Überauth Example](https://github.com/ueberauth/ueberauth_example) application.

## Calling

Depending on the configured url you can initiate the request through:

    /auth/zoom
    
## License

Please see [LICENSE](https://github.com/svycal/ueberauth_zoom/blob/master/LICENSE) for licensing details.
