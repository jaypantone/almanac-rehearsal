import AlmanacStatement

theorem almanac_claim : Almanac.Claim := by
  intro w hw
  exact Nat.le_refl _
