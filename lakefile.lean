import Lake
open Lake DSL

package almanac_case

lean_lib AlmanacDefs
lean_lib AlmanacStatement
lean_lib AlmanacChallenge
lean_lib AlmanacSolution
lean_lib S3

/-- C code compiled and linked by the lakefile: code the judge would run at build time. -/
target search.o pkg : System.FilePath := do
  let src ← inputTextFile <| pkg.dir / "ffi" / "search.c"
  buildO (pkg.buildDir / "ffi" / "search.o") src #[] #["-fPIC"] "cc"

extern_lib libsearch pkg := do
  let o ← search.o.fetch
  buildStaticLib (pkg.staticLibDir / nameToStaticLib "search") #[o]
