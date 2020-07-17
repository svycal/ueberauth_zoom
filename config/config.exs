use Mix.Config

config :ueberauth, Ueberauth,
  providers: [
    zoom:
      {Ueberauth.Strategy.Zoom,
       [
         oauth2_module: OAuthMock
       ]}
  ]
