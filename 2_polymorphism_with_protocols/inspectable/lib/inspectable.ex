defprotocol Inspectable do
  @fallback_to_any true
  def typeof(element)
end

defimpl Inspectable, for: Atom  do
  def typeof(atom), do: Atom
end

defimpl Inspectable, for: Tuple  do
  def typeof(tuple), do: Tuple
end

defimpl Inspectable, for: List  do
  def typeof(list), do: List
end

defimpl Inspectable, for: BitString  do
  def typeof(binary), do: String
end

defimpl Inspectable, for: Integer do
  def typeof(integer), do: Integer
end

defimpl Inspectable, for: Float do
  def typeof(float), do: Float
end

defimpl Inspectable, for: Map  do
  def typeof(map), do: Map
end

defimpl Inspectable, for: Function do
  def typeof(function), do: Function
end

defimpl Inspectable, for: PID do
  def typeof(pid), do: PID
end

defimpl Inspectable, for: Port do
  def typeof(port), do: Port
end

defimpl Inspectable, for: Reference do
  def typeof(reference), do: Reference
end

defimpl Inspectable, for: Any  do
  def typeof(_), do: "A random element"
end
