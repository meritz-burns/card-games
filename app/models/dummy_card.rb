##
# A Card-like object that can be rendered.
class DummyCard
  def owner
    "dummy"
  end

  def id
    "dummy"
  end

  def title
    "dummy"
  end

  def ops
    0
  end

  def text
    ""
  end

  def to_partial_path
    "cards/card"
  end
end
