module Search.Model (Search, initial) where


type alias Search =
  { value : String
  }


initial : Search
initial =
  Search ""
