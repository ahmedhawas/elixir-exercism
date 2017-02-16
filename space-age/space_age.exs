defmodule SpaceAge do
  @type planet :: :mercury | :venus | :earth | :mars | :jupiter
                | :saturn | :uranus | :neptune

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(:earth, seconds), do: seconds / 31557600
  def age_on(:mercury, seconds), do: 0.2408467 * seconds / 31557600
  def age_on(:venus, seconds), do: 0.61519726 * seconds / 31557600
  def age_on(:mars, seconds), do: 1.8808158 * seconds / 31557600
  def age_on(:jupiter, seconds), do: 11.862615 * seconds / 31557600
  def age_on(:saturn, seconds), do: 29.447498 * seconds / 31557600
  def age_on(:uranus, seconds), do: 84.016846 * seconds / 31557600
  def age_on(:neptune, seconds), do: 164.79132 * seconds / 31557600
  def age_on(_, _) do
    "I dont know what to do"
  end
end
