# Flutter UI Implementation Rules

## General

This is a Flutter app.
Use Flutter-friendly, maintainable widget composition.

## Required usage

Always use:

- AppColors
- AppSpacing
- AppTextStyles
- Theme.of(context).textTheme

## Avoid

Do not write raw design values like:

- Color(0xFF...)
- EdgeInsets.all(17)
- BorderRadius.circular(13)
- TextStyle(...) inside screens unless necessary

## Preferred style

Prefer:

- const constructors
- small reusable widgets
- stateless widgets when possible
- clean widget trees
- composition over duplication

## Folder conventions

Shared reusable widgets go under:

- lib/shared/widgets/

Feature-specific widgets go under:

- lib/features/<feature>/widgets/

Screens go under:

- lib/features/<feature>/presentation/

## Screen implementation rules

When implementing a screen:

1. reuse shared widgets first
2. use feature widgets second
3. only add screen-specific layout in the screen file

Do not put complex repeated UI directly into a screen.

## Figma usage rules

When using Figma MCP:

- read only the relevant frame
- do not inspect unrelated nodes
- do not over-query Figma
- use Figma as layout reference, not as the source of truth for all raw values

## Styling rules

- prefer token-based values
- use existing theme definitions first
- introduce new tokens only when clearly necessary
- do not create multiple similar styles for the same UI purpose
