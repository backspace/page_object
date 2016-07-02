defmodule CollectionTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  defmodule IndexPage do
    use PageObject

    visitable :visit, "http://localhost:4000/index.html"

    collection :things, item_scope: "ul .thing" do
      text :title, "a.title"
      attribute :special_attr, "data-special-attr", "a.title"
      value :text_input, "input[type='text']"
      fillable :fill_input, "input[type='text']"
    end
  end

  test "collection is scoped to the item_scope" do
    IndexPage.visit
    assert Enum.count(IndexPage.Things.all) == 5
  end

  test "collection scopes queries to the item_scope" do
    IndexPage.visit

    last_item_title =
      IndexPage.Things.get(4)
      |> IndexPage.Things.title

    first_special_attr =
      IndexPage.Things.get(0)
      |> IndexPage.Things.special_attr

    second_input_val =
      IndexPage.Things.get(1)
      |> IndexPage.Things.text_input

    assert last_item_title == "Thing #5"
    assert first_special_attr == "thing-1"
    assert second_input_val == "thing-2-value"
  end
end
