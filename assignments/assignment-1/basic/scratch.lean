
-- domain : ℕ x ℕ, range : ℕ
-- constant type1 (a : ℕ) (b : ℕ) : ℕ

-- domain : boolean, range: boolean
-- constant typeOfNot (p : bool) : bool

-- domain : boolean, range: boolean
-- constant isPrime (n : ℕ) : bool

-- C : int* listName : ptr to some memory location that stores a series of ints
-- note: list is a function that constructs a list 
-- python : list()
-- list.nil : list a
#check list.nil
-- list.cons over integers specifically :: domain: ℕ x list ℕ; range: list ℕ
#check list.cons

-- add :: domain : ℕ x ℕ, range: ℕ
constant addType (a : ℕ) (b : ℕ) : ℕ

-- f1 :: domain : ℕ, range: (f2 :: domain : ℕ, range : ℕ)
constant addTypeCurr : ℕ -> ℕ -> ℕ 

variable n : ℕ
-- #check addTypeCurr n
-- (1 * 3) + 2 -> 3 + 2 -> 5
def f (a : ℕ) (b : ℕ) : ℕ := (a * b) + a - b
#reduce (f 1) 
-- output: f' : (1 * b) + 1 - b

-- find out the lean analog of `reduce` that can be applied in brackets: (reduce (reduce (something)))
