-module(sort).
-export([quicksort/1, mergesort/1]).

quicksort([])-> [];
quicksort([First | Rest]) ->
  Smaller = [],
  Larger = [],
  quicksort(find_smaller(First, Rest, Smaller)) ++ [First] ++ quicksort(find_larger(First, Rest, Larger)).

find_smaller(Pivot, [First | Rest], Smaller) when ((First < Pivot) or (First == Pivot)) ->
  find_smaller(Pivot, Rest, Smaller ++ [First]);
find_smaller(Pivot, [First | Rest], Smaller) when (First > Pivot) ->
  find_smaller(Pivot, Rest, Smaller);
find_smaller(_, [], Smaller) -> Smaller.

find_larger(Pivot, [First | Rest], Larger) when (First > Pivot) ->
  find_larger(Pivot, Rest, Larger ++ [First]);
find_larger(Pivot, [First | Rest], Larger) when ((First < Pivot) or (First == Pivot)) ->
  find_larger(Pivot, Rest, Larger);
find_larger(_, [], Larger) -> Larger.


mergesort([]) -> [];
mergesort([First | Rest]) -> [First | Rest].