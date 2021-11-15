    
let rec getRowHelper s i n = 
  match s with
  | toprow::remaining -> if (i=n) then toprow else (getRowHelper remaining i (n+1))

let rec getValHelper row j n =
  match row with
  | v::remaining -> if (j=n) then v else (getValHelper remaining j (n+1))
    
let getVal s i j = getValHelper (getRowHelper s i 0) j 0

let rec inColumnHelper i s j v =
  (i < 9) && (getVal s i j = v || (inColumnHelper (i+1) s j v))

let inColumn = (inColumnHelper 0)

let rec inRowHelper row v =
  match row with
  | front::remaining -> (front = v || (inRowHelper remaining v))
  | [] -> false
    
let inRow s i = inRowHelper (getRowHelper s i 0)

let rec inBoxHelper i s bi bj v =
  (i < 9) &&
  (getVal s (bi*3 + (i/3)) (bj*3 + (i mod 3)) = v || (inBoxHelper (i+1) s bi bj v))
    
let inBox = (inBoxHelper 0)
    

let checkValidity s i j v =
  if (getVal s i j != ' ') then (v = getVal s i j)
  else
    not ( (inColumn s j v) || (inRow s i v) || (inBox s (i/3) (j/3) v) )
        
let checkValidityAssumingijNotYetSolved s i j v = not ( (inColumn s j v) || (inRow s i v) || (inBox s (i/3) (j/3) v) )
  
  
let rec solveSquareHelper s i j poss found = 
  match found with
  | f1::f2::fs -> (s, false)
  | [f] -> (
      match poss with
      | v::vs -> if checkValidity s i j v then (solveSquareHelper s i j vs (v::found)) else (solveSquareHelper s i j vs found)
      | [] -> (
          match (i,j,s) with
          | (_,_,[]::rows)         -> ([]::rows, false)
          | (_,_,[])               -> ([], false)
          | (0,0,(sq::cols)::rows) -> ((f::cols)::rows, true)
          | (0,j,(sq::cols)::rows) -> let soln = (solveSquareHelper (cols::rows) 0 (j-1) [] [f]) in
              (
                match soln with
                | (cols::rows, u) -> ((sq::cols)::rows, u)
              )
          | (i,j,r::rows)          -> let soln = (solveSquareHelper rows (i-1) j [] [f]) in
              match soln with
              | (rows, u) -> (r::rows, u)
        )
    )
  | [] ->
      match poss with
      | v::vs -> if checkValidity s i j v then (solveSquareHelper s i j vs (v::found)) else (solveSquareHelper s i j vs found)
      | [] -> (s, false)
        
let solveSquare s i j =  
  if getVal s i j != ' ' then 
    (s,false) 
  else 
    (solveSquareHelper s i j ['1';'2';'3';'4';'5';'6';'7';'8';'9'] [])
    
    
let rec solveHelper s i j = 
  let (ss, u) = solveSquare s i j in
  let (srest, urest) =
    match i,j with
    | 0,0 -> (ss,u)
    | i,0 -> solveHelper ss (i-1) 8
    | i,j -> solveHelper ss i (j-1)
  in
  (srest, urest||u)

let rec solve s =
  let (ss, u) = solveHelper s 8 8 in
  if (not u) then s else (solve ss)
      
  

let s = [['5';'3';' ';' ';'7';' ';' ';' ';' '];
         ['6';' ';' ';'1';'9';'5';' ';' ';' '];
         [' ';'9';'8';' ';' ';' ';' ';'6';' '];
         ['8';' ';' ';' ';'6';' ';' ';' ';'3'];
         ['4';' ';' ';'8';' ';'3';' ';' ';'1'];
         ['7';' ';' ';' ';'2';' ';' ';' ';'6'];
         [' ';'6';' ';' ';' ';' ';'2';'8';' '];
         [' ';' ';' ';'4';'1';'9';' ';' ';'5'];
         [' ';' ';' ';' ';'8';' ';' ';'7';'9']]
    
;;solve s
      
    