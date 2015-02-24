/-
Copyright (c) 2014 Microsoft Corporation. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.

Module: data.prod
Author: Leonardo de Moura, Jeremy Avigad
-/
import logic.eq
open inhabited decidable eq.ops

namespace prod
  variables {A B : Type} {a₁ a₂ : A} {b₁ b₂ : B} {u : A × B}

  theorem pair_eq : a₁ = a₂ → b₁ = b₂ → (a₁, b₁) = (a₂, b₂) :=
  assume H1 H2, H1 ▸ H2 ▸ rfl

  protected theorem equal {p₁ p₂ : prod A B} : pr₁ p₁ = pr₁ p₂ → pr₂ p₁ = pr₂ p₂ → p₁ = p₂ :=
  destruct p₁ (take a₁ b₁, destruct p₂ (take a₂ b₂ H₁ H₂, pair_eq H₁ H₂))

  protected definition is_inhabited [instance] [h₁ : inhabited A] [h₂ : inhabited B] : inhabited (prod A B) :=
  inhabited.mk (default A, default B)

  protected definition has_decidable_eq [instance] [h₁ : decidable_eq A] [h₂ : decidable_eq B] : decidable_eq (A × B) :=
  take (u v : A × B),
    have H₃ : u = v ↔ (pr₁ u = pr₁ v) ∧ (pr₂ u = pr₂ v), from
      iff.intro
        (assume H, H ▸ and.intro rfl rfl)
        (assume H, and.elim H (assume H₄ H₅, equal H₄ H₅)),
    decidable_of_decidable_of_iff _ (iff.symm H₃)
end prod
