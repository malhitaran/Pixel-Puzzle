# Pixel Puzzle 🎮🧩

Pixel Puzzle is a pattern-copying game written entirely in low level STUMP assembly code which runs on a STUMP processor we designed and built: you’re shown a target pixel pattern, and your goal is to recreate it by toggling pixels on the grid until your board matches the target.

> This repo contains my **Exercise 3** submission files which achieved a 96% mark.

---

## Demo Videos

**Gameplay demo (click to watch):**  

<a href="https://youtube.com/shorts/2wOikNK8kIo?feature=share">
  <img src="assets/gameplay.gif" width="260">
</a>
---

## How the Game Works

- A random target pattern is displayed.
- You move around the grid and toggle pixels on/off.
- The objective is to match the target pattern as efficiently as possible.
- The game gets increasingly more difficult
- Once a player fails wrongly selected pixels flash, correct pixels selected stay red, unselected correct pixels go green.

---

## Main Game Logic

This project’s core loop follows the execution cycle shown in the `GAME LOGIC`
comments in `pixel_puzzel.s`.

### Pixel Puzzles Execution Cycle (quick view)

```text
-> [0] RESET/INIT SYSTEM -> [1] INIT DISPLAY -> [2] DISPLAYING LEVEL -> [3] ASSESSING USER INPUT
        ^                                                                          |
        |                                                                          v
   [6] OTHERWISE FAIL <- [6] CHECK FOR WIN <- [5] VERIFY <- [4] DRAW PIXEL
```
<details> <summary><b>Diagram view (Mermaid)</b></summary>
mermaid
Copy code
%%{init: {'theme': 'base', 'themeVariables': { 'fontSize': '10px' }, 'flowchart': { 'nodeSpacing': 10, 'rankSpacing': 15 }}}%%
flowchart TB

  subgraph TOP[""]
    direction LR
    S0["[0] RESET/INIT SYSTEM"] --> S1["[1] INIT DISPLAY"] --> S2["[2] DISPLAYING LEVEL"] --> S3["[3] ASSESSING USER INPUT"]
  end

  subgraph BOTTOM[""]
    direction RL
    S4["[4] DRAW PIXEL"] --> S5["[5] VERIFY"] --> S6["[6] CHECK FOR WIN"] --> F6["[6] OTHERWISE FAIL"]
  end

  S3 --> S4
  F6 --> S0

  style TOP fill:transparent,stroke:transparent
  style BOTTOM fill:transparent,stroke:transparent
</details> ```
