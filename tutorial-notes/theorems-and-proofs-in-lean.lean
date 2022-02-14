variables P Q R : Prop
variable h : P ∧ Q

#check h
#check and.left h
#check and.right h

variable hp : P
variable hq : Q
#check and.intro hp hq  

theorem andComm (A B : Prop) : A ∧ B → B ∧ A := 
  assume h : A ∧ B,
  and.intro (and.right h) (and.left h)

A ∨ B → B ∨ A
A ∧ (B ∨ C) → (A ∧ B) ∨ (A ∧ C)

DeMorgan's laws:
¬ (P ∨ Q) ↔ ¬P ∧ ¬Q
¬ (P ∧ Q) ↔ ¬P ∨ ¬Q
