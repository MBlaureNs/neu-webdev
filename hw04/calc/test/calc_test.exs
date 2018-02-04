defmodule CalcTest do
  use ExUnit.Case
  doctest Calc
  
  test "givens" do
    assert Calc.eval("2 + 3") == 5
    assert Calc.eval("5 * 1") == 5
    assert Calc.eval("20 / 4") == 5
    assert Calc.eval("24 / 6 + (5 - 4)") == 5
    assert Calc.eval("1 + 3 * 3 + 1") == 11
  end

  test "spacing" do
    assert Calc.eval("    24    /   6    +   (    5   -  4  )   ") == 5
    assert Calc.eval("24/6+(5-4)") == 5
    assert Calc.eval("\n24\n/\n6\n+\n(\n5\n-\n4\n)") == 5
  end

  test "order of ops" do
    assert Calc.eval("2-3-4") == -5
    assert Calc.eval("2-(3-4)") == 3
    assert Calc.eval("2*3-4") == 2
    assert Calc.eval("2*(3-4)") == -2
    assert Calc.eval("7+4*5-6/3") == 25
    assert Calc.eval("3+24/6+2") == 9
    assert Calc.eval("24/6/2") == 2
    assert Calc.eval("5-4-3-2-1") == -5
  end

  test "nested paren" do
    assert Calc.eval("(((((12)))))") == 12
    assert Calc.eval("5-(4-(3-(2-1)))") == 3
    assert Calc.eval("((8/2)+(3-1))*2") == 12
  end

  test "literal" do
    assert Calc.eval("0") == 0
    assert Calc.eval("12") == 12
  end

  test "int div" do
    assert Calc.eval("5/3") == 1
    assert Calc.eval("6/3") == 2
    assert Calc.eval("7/3") == 2
  end
end
