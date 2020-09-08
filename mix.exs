defmodule UeberauthZoom.MixProject do
  use Mix.Project

  @version "0.1.0"
  @url "https://github.com/svycal/ueberauth_zoom"

  def project do
    [
      app: :ueberauth_zoom,
      version: @version,
      name: "Ueberauth Zoom Strategy",
      package: package(),
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      source_url: @url,
      homepage_url: @url,
      description: description(),
      deps: deps(),
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:oauth2, "~> 1.0 or ~> 2.0"},
      {:ueberauth, "~> 0.6.0"},
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: [:dev], runtime: false},
      {:mox, "~> 0.5", only: :test}
    ]
  end

  defp docs do
    [extras: ["README.md"]]
  end

  defp description do
    "An Überauth strategy for Zoom authentication."
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Derrick Reimer"],
      licenses: ["MIT"],
      links: %{GitHub: @url}
    ]
  end
end
