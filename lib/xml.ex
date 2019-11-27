defmodule IntegrationEx.XML do
  @moduledoc """
  Get information from XML format
  """
  def get(xml, path) do
    Exml.get(xml, path)
  end
end
