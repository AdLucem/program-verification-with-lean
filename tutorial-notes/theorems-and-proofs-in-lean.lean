namespace hidden

constant Proof : Prop -> Type

constant and_comm : Π p q : Prop,
Proof (implies (and p q) (and q p))

variables p q : Prop
#check and_comm p q

constant modus_ponens :
  Π p q : Prop, Proof (implies p q) →  Proof p → Proof q

constant implies_intro :
  Π p q : Prop, (Proof p → Proof q) → Proof (implies p q).

end hidden
