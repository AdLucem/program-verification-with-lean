/- The syntax of propositional logic expressions is defined here in lean (along with a few helpful operators) -/

namespace hidden

structure var :=
mk :: (idx : ℕ) 

-- utility function here: define equality over natural numbers
def nat_eq : ℕ -> ℕ -> bool 
  | 0 0 := tt
  | n 0 := ff
  | 0 m := ff
  | (nat.succ n) (nat.succ m) := nat_eq n m

-- using this, define equality over variables
def var_eq (u : var) (v : var) : bool := 
  nat_eq (u.idx) (v.idx)


--  | n 0 := ff
--  | (suc n) (suc m) := eq n m 
inductive Expr
| atom (v : var) : Expr
| not  : Expr -> Expr
| and  : Expr -> Expr -> Expr
| or   : Expr -> Expr -> Expr
| impl : Expr -> Expr -> Expr

prefix `atom` : 49 := Expr.atom
prefix `¯`    : 50 := Expr.not -- \=
prefix `not`  : 50 := Expr.not
infix `Λ`     : 51 := Expr.and -- \GL
infix `V`     : 52 := Expr.or -- V 
infix `⇒`     : 53 := Expr.impl -- \=>

/- Q1: This question is a warm-up to using propositions inductively. Define a function `size` that returns the size of the propositional logic expression -/
def size : Expr -> ℕ
| (atom v) := 1
| (¯p) := size p
| (p Λ q) := (size p) + (size q)
| (p V q) := (size p) + (size q)
| (p ⇒ q) := (size p) + (size q)

/- Q2. Now we get into a bit of an open area. Remember the definitions of an `interpretation` and a `valuation` that we did in class.

How would you build propositional logic syntax and semantics in lean, such that you can have a function `valuation : Expr x Interpretation -> bool` - that takes a type `Expr` - your type for propositional expressions ; a type `Interpretation`, and returns a boolean?

(Note: your `valuation` function does not need to be exactly this type! What this question asks of you is to implement propositional logic syntax and semantics in a way that supports a mechanism for defining expressions, defining interpretations and computing valuations on the expressions x interpretations)  

To see what "building propositional logic" means, you could refer to the propositional logic syntax I built in [the Propositions In Lean tutorial notes](../../tutorial-notes/propositions-in-lean.org). -/

-- *********************** ANSWER *************************

-- first of all some boolean functions
def bnot : bool -> bool
| tt := ff
| ff := tt

def band : bool -> bool -> bool
| tt tt := tt
| _ _   := ff

def bor : bool -> bool -> bool
| ff ff := ff
| _ _ := tt

def bimpl : bool -> bool -> bool
| tt tt := tt
| ff ff := tt
| _ _ := ff


-- an interpretation is a mapping of a variable to a boolean value
structure In := 
mk :: (b : bool) (v : var)
notation `val_t` := In.mk tt
notation `val_f` := In.mk ff

-- examples
def v1 := var.mk 1
def v2 := var.mk 2 

def i1 := val_t v1 
def i2 := val_f v2

-- utility function: define a 'match' between an interpretation and a variable- i.e: the interpretation refers to that variable
def match_in (v : var) (i : In) : bool := 
  nat_eq (v.idx) (i.v.idx)
 
-- another utility function: given a variable and a list of interpretations, find the interpretation of that variable
-- if it does not exist, return false
def get_in : list In -> var -> bool
  | [] v := ff
  | (i :: li) v := if (match_in v i) then i.b else (get_in li v)

-- test this function a couple of times
-- def il := [i1, i2]
-- #eval get_in il v1
-- #eval get_in il v2

-- and here is our valuation function
def valuation : Expr -> list In -> bool
  | (atom v) li := get_in li v  
  | (¯p) li     :=  bnot (valuation p li)
  | (p Λ q) li  := band (valuation p li) (valuation q li)
  | (p V q) li  := bor (valuation p li) (valuation q li)
  | (p ⇒ q) li  := bimpl (valuation p li) (valuation q li)

  
/- Q3. Can you implement a type `is_sat (e : Expr)? Implement it as a record type (remember `vector` from the class notes) -/

-- more utility functions time yay! given an expression, get the list of variables in it
def get_varlist : Expr -> list var
  | (atom v) := [v]  
  | (¯p)     := get_varlist p  
  | (p Λ q)  := list.append (get_varlist p) (get_varlist q)
  | (p V q)  := list.append (get_varlist p) (get_varlist q)
  | (p ⇒ q)  := list.append (get_varlist p) (get_varlist q)

-- now given a varlist, get the list of all possible interpretation-lists for it

-- utility function for length of a list
def length {α : Type} : list α -> ℕ
  | [] := 0
  | (a :: ls) := 1 + (length ls)

-- n : number of variables
-- get list of all possible booleans of length n
def bool_perms : ℕ -> list (list bool)
  | 0 := [[]] 
  | (n+1) := (list.map (list.cons tt) (bool_perms n)) ++ (list.map (list.cons ff) (bool_perms n))

-- given list of vars and list of bools, generate list of interpretations
def gen_ins (vlist : list var) (blist : list bool) : list In :=
    list.zip_with In.mk blist vlist

-- finally, list-of-all-interpretations function
def all_in (vlist : list var) : list (list In) := 
  list.map (gen_ins vlist) (bool_perms (length vlist))

-- given that we have:
-- (a) a list of all variables in an expression
-- (b) a list of all interpretations
-- we can get all possible valuations of an expression!
def all_val (e : Expr) : list bool := 
  let
    varlist := get_varlist e,
    inlist  := all_in varlist
  in 
    list.map (valuation e) inlist

-- now if any _one_ of those interpretations is true, we have a satisfiable expression!
def fold {α : Type} : (α -> α -> α) -> list α -> α -> α
  | f [] acc        := acc
  | f (x :: ls) acc := fold f ls (f acc x)


def is_it_satisfiable (e : Expr) : bool := 
  let
    -- list of all valuations
    vallist := all_val e
  in
    -- `or` all the valuations with each other to see if any one is true
    fold bor (all_val e) tt

structure is_sat (e : Expr) (b : bool)

-- now putting it all together for some tests
def v3 := var.mk 3
def v4 := var.mk 4
def v5 := var.mk 5

def e1 := ( (not (atom v3)) V ((atom v1) Λ (atom v2))) ⇒ not ((atom v4) V (atom v5)) 

def solve_for_e1 := is_sat e1 (is_it_satisfiable e1)
-- now to show this expression
#reduce solve_for_e1 

end hidden
