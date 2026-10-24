import AlmanacDefs
/-! The Almanac's statement (written by the site; the judge writes this file over any
file of the same name): S(n) ≤ 153 + (n − 5)·n·n! for n ≥ 5 -/
namespace Almanac
def Claim : Prop := UpperBoundFrom 5 (.add (.const 153) (.mul (.mul (.sub (.var) (.const 5)) (.var)) (.fact 0)))
end Almanac
