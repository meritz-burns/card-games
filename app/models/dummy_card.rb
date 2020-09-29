##
# A Card-like object that can be rendered.
class DummyCard
  def type
    "dummy"
  end

  def id
    "dummy"
  end

  def name
    "dummy"
  end

  def charge
    0
  end

  def ability
    ""
  end

  def to_partial_path
    "cards/card"
  end
end
