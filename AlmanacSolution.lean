import AlmanacStatement
import M7Witness

set_option maxRecDepth 4096
set_option maxHeartbeats 4000000

theorem m7_coverage : M7Witness.covers 5 M7Witness.word5 = true := by
  native_decide

theorem almanac_claim : Almanac.Claim := M7Witness.upperFrom m7_coverage
