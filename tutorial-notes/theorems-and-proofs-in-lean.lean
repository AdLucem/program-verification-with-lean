open classical

variable A : Prop
constant proofby_contradiction : ¬A → false

example : A :=
by_contradiction
(assume h : ¬ A,
show false, from sorry)

((p → q) ∧ (¬r → ¬q)) → (p → r)
