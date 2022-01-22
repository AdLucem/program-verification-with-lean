inductive PropBool : Type
  | p0 : PropBool
  | p1 : PropBool

variables P Q R : Prop

#check P ∧ Q
#check ¬ P ∨ Q
#check ¬ P → Q ∧ R

namespace hidden
 
structure var :=
  mk :: (idx : ℕ) 

def p1 := var.mk 1
def p2 := var.mk 2

#eval p1.idx

def neq : ℕ -> ℕ -> bool
   | 0 0 := tt
   | (n+1) 0 := ff
   | 0 (n+1) := ff
   | (n+1) (m+1) := neq n m

def vareq (pA : var) (pB : var) : bool := neq pA.idx pB.idx

#eval vareq p1 p2
#eval vareq p2 p2

inductive and (p q : Prop) : Prop
  | intro : p -> q -> and
infix `Λ` : 50 := and

inductive or (p q : Prop) : Prop
  | intro : p -> q -> or
infix `V` : 51 := or

inductive impl (p q : Prop) : Prop
  | intro : p -> q -> impl
infix `⇒` : 52 := impl

inductive equiv (p q : Prop) : Prop
  | intro : p -> q -> equiv
infix `<->` : 53 := equiv

inductive not (p : Prop) : Prop
  | intro : p -> not

#check P Λ Q
#check P V Q <-> R

def bnot : bool -> bool
  | tt := ff
  | ff := tt

def band : bool -> bool -> bool
  | tt tt := tt
  | _ _   := ff

def bor : bool -> bool -> bool
  | ff ff := ff
  | _ _ := tt

structure interpretn :=
  mk :: (k : var) (v : bool)

def i1 := interpretn.mk p1 tt

def i2 := interpretn.mk p2 ff

def intps : Type := list interpretn

def is := [i1, i2] 
#check is

end hidden
