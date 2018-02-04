defmodule Calc do
  @moduledoc """
  Documentation for Calc.
  """

  # true if string is an operator
  # macro so can be used in guard
  defmacro is_op(s) do
    quote do
      unquote(s) in ["+", "-", "*", "/", "(", ")"]
    end
  end

  # return precedence of operator string
  defp precedence(op) do
    case op do
      op when op in ["+","-"] -> 1
      op when op in ["*","/"] -> 2
      op when op in ["(",")"] -> 999
      op ->
	raise ArgumentError, message: "invalid arithmetic operator #{op}"
    end
  end

  # true if string is an integer
  defp is_int?(s) do
    regex = ~r/[0-9]+/
    Regex.match?(regex, s)
  end
  
  # convert token from str to int if reasonable
  defp try_str_to_int(token) do
    if (is_int?(token)) do
      String.to_integer(token)
    else
      token
    end
  end

  # apply operation to two operands
  defp apply_op(v1, op, v2) do
    case op do
      "+" -> v1 + v2
      "-" -> v1 - v2
      "*" -> v1 * v2
      "/" -> div(v1, v2)
      op ->
	raise ArgumentError, message: "invalid arithmetic operator #{op}"
    end
  end

  # for convenience in main
  defp empty_to_zero(exp) do
    if String.trim(exp) == "" do
      "0"
    else
      exp
    end
  end
  
  
  # shunting-yard algorithm referenced from:
  # https://en.wikipedia.org/wiki/Shunting-yard_algorithm
  defp shuntyard(tokens) do
    shuntyard(tokens, [], [])
  end
  
  defp shuntyard([], [], out) do
    Enum.reverse(out)
  end
  
  defp shuntyard([], ops, out) do
    shuntyard([], tl(ops), [hd(ops)|out])
  end

  defp shuntyard([head|tail], ops, out) when is_integer(head) do
    shuntyard(tail, ops, [head|out])
  end
  
  defp shuntyard([head|tail], ops, out) when is_op(head) do
    cond do
      length(ops) != 0 and hd(ops) != "(" and precedence(head) <= precedence(hd(ops)) ->
	shuntyard([head|tail], tl(ops), [hd(ops)|out])
      head == "(" ->
	shuntyard(tail, [head|ops], out)
      head == ")" and hd(ops) != "(" ->
	shuntyard([head|tail], tl(ops), [hd(ops)|out])
      head == ")" ->
	shuntyard(tail, tl(ops), out)
      true ->
	shuntyard(tail, [head|ops], out)
    end
  end

  # reverse polish notation evaluator referenced from:
  # https://en.wikipedia.org/wiki/Reverse_Polish_notation
  defp rpn(tokens) do
    rpn(tokens, [])
  end
  
  defp rpn([], [result]) do
    result
  end

  defp rpn([token|cdr_tokens], stack) when is_op(token) do
    [car|cdr] = stack
    [cadr|cddr] = cdr
    rpn(cdr_tokens, [apply_op(cadr, token, car) | cddr])
  end

  defp rpn([token|cdr_tokens], stack) when is_integer(token) do
    rpn(cdr_tokens, [token|stack])
  end

  @doc """
  evaluate expression given by string
  """
  def eval(exp) do
    # regex split behavior referenced from:
    # https://groups.google.com/d/msg/elixir-lang-talk/3xQ4q5YSCnk/51yW7TzI9XIJ
    regex = ~r/()[\+|\-|\*|\/|\(|\)]()/

    # map magic referenced from:
    # https://stackoverflow.com/questions/39461665/how-do-i-map-any-given-function-over-a-list-of-values/39461693
    exp
    |> (&Regex.split(regex, &1, [on: [1,2], trim: true])).()
    |> Enum.map(&String.trim/1)
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(&try_str_to_int/1)
    |> shuntyard
    |> rpn
  end

  @doc """
  evaluate expressions given at prompt
  """
  def main do
    IO.gets("> ")
    |> empty_to_zero
    |> eval
    |> IO.puts
    
    main()
  end
end
