defmodule Phone do
  @regex_phone_number_pieces ~r/^(?<area_code>\d{3})(?<first_part>\d{3})(?<second_part>\d{4})$/
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("123-456-7890")
  "1234567890"

  iex> Phone.number("+1 (303) 555-1212")
  "3035551212"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) do
    raw
    |> sanitize_invalid_letters
    |> String.replace(~r/[^\d]/, "")
    |> cleanup
  end

  @spec cleanup(String.t) :: String.t
  defp cleanup(phone_number) do
    phone_number
    |> format_number
    |> trim_extra_leading_one
  end

  @spec sanitize_invalid_letters(String.t) :: String.t
  defp sanitize_invalid_letters (raw_number) do
    if number_has_letters?(raw_number) do
      "0000000000"
    else
      raw_number
    end
  end

  @spec number_has_letters?(String.t) :: boolean
  def number_has_letters?(raw_number) do
    Regex.match?(~r/[a-z]/, raw_number)
  end

  @spec format_number(String.t) :: String.t
  defp format_number(phone_number) do
    if phone_is_invalid?(phone_number) do
      "0000000000"
    else
      phone_number
    end
  end

  @spec phone_is_invalid?(String.t) :: boolean
  defp phone_is_invalid?(phone_number) do
    (!has_extra_leading_one?(phone_number) && String.length(phone_number) == 11)
    || (String.length(phone_number) === 9)
  end

  @spec trim_extra_leading_one(String.t) :: String.t
  defp trim_extra_leading_one(numerical_string) do
    if has_extra_leading_one?(numerical_string) do
      Regex.named_captures(~r/^1(?<remainder>\d{10}+)$/, numerical_string)["remainder"]
    else
      numerical_string
    end
  end

  @spec has_extra_leading_one?(String.t) :: boolean
  defp has_extra_leading_one?(numerical_string) do
    String.length(numerical_string) == 11 &&
    String.starts_with?(numerical_string, "1")
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("123-456-7890")
  "123"

  iex> Phone.area_code("+1 (303) 555-1212")
  "303"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    raw
    |> cleanup
    |> String.slice(0..2)
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("123-456-7890")
  "(123) 456-7890"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    {area_code, first_part, second_part} =
    raw
    |> cleanup
    |> extract_phone_number

    "(#{area_code}) #{first_part}-#{second_part}"
  end

  @spec extract_phone_number(String.t) :: {String.t, String.t, String.t}
  def extract_phone_number(phone_number) do
    pieces = Regex.named_captures(@regex_phone_number_pieces, phone_number)
    { pieces["area_code"], pieces["first_part"], pieces["second_part"] }
  end
end
