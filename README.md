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

## Project Structure

- `Exercise3/`
  - `pixel_puzzel.s` — main implementation
  - `pixel_puzzel.s.kmd` — supporting/config file

---
## Main Game Logic

This project’s core loop follows the same execution cycle shown in the `GAME LOGIC`
comments in `pixel_puzzel.s`.

### Pixel Puzzles Execution Cycle

```mermaid
flowchart TB

  %% --- TOP ROW (left -> right) ---
  subgraph TOP[" "]
    direction LR
    S0["[0] RESET / INIT<br/>SYSTEM"] --> S1["[1] INIT<br/>DISPLAY"] --> S2["[2] DISPLAYING<br/>LEVEL"] --> S3["[3] ASSESSING<br/>USER INPUT"]
  end

  %% --- BOTTOM ROW (right -> left) ---
  subgraph BOTTOM[" "]
    direction RL
    S4["[4] DRAW<br/>PIXEL"] --> S5["[5] VERIFY"] --> S6["[6] CHECK<br/>FOR WIN"] --> F6["[6] OTHERWISE<br/>FAIL"]
  end

  %% --- Vertical drop + loopback (matches your ASCII) ---
  S3 --> S4
  F6 --> S0

  %% Hide the subgraph boxes (cleaner look)
  style TOP fill:transparent,stroke:transparent
  style BOTTOM fill:transparent,stroke:transparent

