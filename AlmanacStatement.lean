import AlmanacDefs
/-! The Almanac's statement (written by the site; the judge writes this file over any
file of the same name): S(5) >= 153 -/
namespace Almanac
def Claim : Prop := LowerBoundAt 5 153
end Almanac
