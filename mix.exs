defmodule ATProto.MixProject do
  use Mix.Project

  @source_url "https://github.com/moomerman/atproto"
  @version "0.1.0"

  def project do
    [
      app: :atproto,
      version: @version,
      elixir: "~> 1.14",
      description: "Implementation of the ATProtocol client spec in Elixir.",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package() do
    [
      files: ~w(lib mix.exs README* LICENSE*),
      links: %{GitHub: @source_url},
      licenses: ["MIT"]
    ]
  end

  defp docs() do
    [
      extras: [
        "README.md": [title: "Overview"],
        LICENSE: [title: "License"]
      ],
      main: "readme"
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto, "~> 3.10"},
      {:xrpc, "~> 0.1.0"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
