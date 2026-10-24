import AlmanacDefs
import Mathlib

/-!
Own M7 rehearsal proof. The literal word is the standard recursive 153-symbol
construction for five symbols, not a new result. No external superpermutation
theorem is imported. The generator is outside the theorem's trusted basis.
-/
namespace M7Witness

def permutations (n : Nat) : List (Almanac.Word n) := (List.finRange n).permutations

theorem mem_permutations {n : Nat} (p : Almanac.Word n)
    (hp : p.Nodup) (hlen : p.length = n) : p ∈ permutations n := by
  apply List.mem_permutations.mpr
  have hsub : List.Subperm p (List.finRange n) :=
    List.subperm_of_subset hp (fun a _ => List.mem_finRange a)
  exact hsub.perm_of_length_le (by simp [hlen])

def covers (n : Nat) (w : Almanac.Word n) : Bool :=
  ((List.finRange n).permutations').all (fun p => decide (p <:+: w))

theorem superpermutation_of_covers {n : Nat} {w : Almanac.Word n}
    (h : covers n w = true) : Almanac.IsSuperpermutation n w := by
  intro p hp hlen
  have hmem : p ∈ (List.finRange n).permutations' :=
    List.mem_permutations'.mpr (List.mem_permutations.mp (mem_permutations p hp hlen))
  exact of_decide_eq_true (List.all_eq_true.mp h p hmem)

def word5 : Almanac.Word 5 :=
  [0, 1, 2, 3, 4, 0, 1, 2, 3, 0, 4, 1, 2, 3, 0, 1, 4, 2, 3, 0, 1, 2, 4, 3, 0, 1, 2, 0, 3, 4, 1, 2, 0, 3, 1, 4, 2, 0, 3, 1, 2, 4, 0, 3, 1, 2, 0, 4, 3, 1, 2, 0, 1, 3, 4, 2, 0, 1, 3, 2, 4, 0, 1, 3, 2, 0, 4, 1, 3, 2, 0, 1, 4, 3, 2, 0, 1, 0, 2, 3, 4, 1, 0, 2, 3, 1, 4, 0, 2, 3, 1, 0, 4, 2, 3, 1, 0, 2, 4, 3, 1, 0, 2, 1, 3, 4, 0, 2, 1, 3, 0, 4, 2, 1, 3, 0, 2, 4, 1, 3, 0, 2, 1, 4, 3, 0, 2, 1, 0, 3, 4, 2, 1, 0, 3, 2, 4, 1, 0, 3, 2, 1, 4, 0, 3, 2, 1, 0, 4, 3, 2, 1, 0]

theorem word5_length : word5.length = 153 := by rfl

def concatenated (n : Nat) : Almanac.Word n := (permutations n).flatten

theorem concatenated_superpermutation (n : Nat) :
    Almanac.IsSuperpermutation n (concatenated n) := by
  intro p hp hlen
  exact List.infix_of_mem_flatten (mem_permutations p hp hlen)

theorem uniform_flatten_length {α : Type} (xs : List (List α)) (n : Nat)
    (h : ∀ x ∈ xs, x.length = n) : xs.flatten.length = xs.length * n := by
  induction xs with
  | nil => simp
  | cons x xs ih =>
    have hx : x.length = n := h x (by simp)
    have ht : xs.flatten.length = xs.length * n :=
      ih (by intro y hy; exact h y (by simp [hy]))
    simp only [List.flatten_cons, List.length_append, List.length_cons, hx, ht,
      Nat.add_mul, Nat.one_mul]
    omega

theorem concatenated_length (n : Nat) : (concatenated n).length = n * n.factorial := by
  have h : ∀ p ∈ permutations n, p.length = n := by
    intro p hp
    simpa using (List.mem_permutations.mp hp).length_eq
  rw [concatenated, uniform_flatten_length (permutations n) n h]
  simp [permutations, List.length_permutations, Nat.mul_comm]

theorem fact_eq : ∀ n, Almanac.fact n = n.factorial
  | 0 => rfl
  | n + 1 => by rw [Almanac.fact, fact_eq n, Nat.factorial_succ]

def formula : Almanac.Expr :=
  .add (.const 153) (.mul (.mul (.sub .var (.const 5)) .var) (.fact 0))

theorem upperFrom (h : covers 5 word5 = true) : Almanac.UpperBoundFrom 5 formula := by
  intro n hn
  by_cases heq : n = 5
  · subst n
    refine ⟨word5, superpermutation_of_covers h, ?_⟩
    rw [word5_length]
    norm_num [formula, Almanac.Expr.eval]
  · have hn6 : 6 ≤ n := by omega
    refine ⟨concatenated n, concatenated_superpermutation n, ?_⟩
    have hnq : (6 : Rat) ≤ (n : Rat) := by exact_mod_cast hn6
    have hnonneg : 0 ≤ (n : Rat) * (n.factorial : Rat) :=
      mul_nonneg (Nat.cast_nonneg n) (Nat.cast_nonneg n.factorial)
    have hcoef : (1 : Rat) ≤ (n : Rat) - 5 := by linarith
    have hmul := mul_le_mul_of_nonneg_right hcoef hnonneg
    simp only [formula, Almanac.Expr.eval, Nat.sub_zero, concatenated_length,
      fact_eq, Nat.cast_mul]
    nlinarith only [hmul]

end M7Witness
