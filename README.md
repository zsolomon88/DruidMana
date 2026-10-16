# Druid Mana

Druid Mana is a small World of Warcraft addon that displays a separate mana bar
while your character is in a druid shapeshift form. The bar is anchored below
the player frame when available.

## Install

1. Make sure the addon folder is named `DruidMana`.
2. Copy it into the beta client's `Interface\AddOns` folder.
3. If the client marks it out of date, check its interface version in-game with
   `/run print(select(4, GetBuildInfo()))` and update the `## Interface` value
   in `DruidMana.toc` to that number.
4. Enable **Druid Mana** in the AddOns list and reload the UI.

The beta client may change its addon interface version or APIs between builds.
