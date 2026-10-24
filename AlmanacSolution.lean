import AlmanacStatement
import Lean

/-! An ill-typed `almanac_claim` admitted with the kernel check skipped: with
`debug.skipKernelTC`, `addDecl` adds a theorem of type `Almanac.Claim` whose proof has type `True`
without checking it. The compare and axiom stages pass, but Lean's kernel replay recomputes it and
refuses. -/
set_option debug.skipKernelTC true in
open Lean Elab Command in
run_cmd do
  let (ty, val) ← liftTermElabM do
    let ty ← instantiateMVars (← Term.elabTerm (← `(Almanac.Claim)) (some (.sort .zero)))
    let val ← instantiateMVars (← Term.elabTerm (← `(trivial)) (some (.const ``True [])))
    return (ty, val)
  liftCoreM <| addDecl (.thmDecl { name := `almanac_claim, levelParams := [], type := ty, value := val })
