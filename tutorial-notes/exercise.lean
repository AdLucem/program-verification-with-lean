notation `Var` := Sort 0
notation `Exp` := Sort 1

structure atomic (v : Var) : Exp
 
-- Exercise: why does this not work:
-- structure var : Prop :=
--  mk :: (idx : ℕ) 

-- But this does? : 
-- structure var : Type :=
-- mk :: (idx : ℕ) 
