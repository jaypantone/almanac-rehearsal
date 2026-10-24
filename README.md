# Superpermutation Almanac rehearsal fixtures

These are deliberate tests of the Almanac's Lean submission pipeline, not new
mathematical results. Each fixture is an immutable commit on its named branch.
Some branches intentionally fail a rule or proof check. Do not use them as proofs.

The two fixed witnesses use the standard recursive 153-symbol superpermutation
on five symbols and an elementary extension for larger n. One uses native
computation and needs human review; the other is checked entirely by the kernels.
No external superpermutation result is imported or newly credited here.
No Raudvere source or theorem is used. The custom fixture imports the pinned
current Mathlib and proves only True; it must remain unlisted.

| Fixture | Commit |
|---|---|
| refused-rules | `05af839def3f5503f73433608479696ff814aaf9` |
| refused-build | `e3295d9ad5b9c41970690babf45696ad84482d75` |
| refused-compare | `d0fae45d2a80acd374ee37947e9f28e63aa58e50` |
| refused-axioms | `038bd9cd4cdf2e04aa3c283310247b624eb78b09` |
| refused-native | `bec64bb0b644647d0dcb10468db61981f5065fe2` |
| refused-replay | `0516ff8369a9b3caaaac4fbc39dfdf92767c0b66` |
| custom-kernel | `47b11d758bae528cc89ae79da1ed806e83316770` |
| fixed-native | `fa606c47fcbdaaaa2474e7b3f2f46599e45a5595` |
| fixed-kernel | `a6c0b3915d69021def66627e1f5b3c678749edc5` |
