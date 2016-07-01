defmodule PageObject.Queries.Property do
  defmacro property(name, prop, css_selector, _opts \\ []) do
    quote do
      scope = Module.get_attribute(__MODULE__, :scope) || ""

      if scope != "" do
        def unquote(name)(el) do
          IO.puts "Getting value of #{unquote(prop)} for element's first #{unquote(css_selector)}"
        end
      else
        def unquote(name)() do
          IO.puts "Getting value of #{unquote(prop)} for #{unquote(css_selector)}"
        end
      end
    end
  end
end
