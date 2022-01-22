
-- in lean, the purpose of types is, well- something like defining domains and ranges
-- instead of _just_ being for memory reasons 

-- nats
#check 1
-- bools
#check tt
#check ff

-- Prop
#check true
#check false

variables P Q R : Prop
#check P ∧ Q ↔ R
#check P ↔ R

-- Show that ¬ P ∧ Q is a Proposition (or an expression of type Prop)
#check ¬ P ∧ Q
-- Show that ¬ P ∧ is not a valid proposition
-- #check not P and
 




