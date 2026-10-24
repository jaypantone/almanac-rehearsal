import AlmanacStatement
import Lean

run_cmd pure ()

theorem almanac_claim : (List.range 200).length = 200 := by native_decide
