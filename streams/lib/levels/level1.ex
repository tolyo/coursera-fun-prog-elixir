defmodule Level1 do
  use Solver
  use Level

  @spec level :: String.t()
  def level do
    """
    o0o-------
    oSoooo----
    ooooooooo-
    -ooooooooo
    -----ooToo
    ------ooo-
    """
  end
end
