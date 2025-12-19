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

The Pixel Puzzle game follows a fixed execution cycle that continuously updates
the display, processes user input, and checks win/fail conditions.

### Execution Cycle Overview


flowchart LR
    A[Reset / Initialize System] --> B[Initialize Display]
    B --> C[Display Level]
    C --> D[Assess User Input]
    D --> E[Draw Pixel]
    E --> F[Verify Move]
    F --> G{Win Condition?}
    G -- Yes --> H[Game Complete]
    G -- No --> D
    D --> I{Invalid / Fail State?}
    I -- Yes --> J[Fail / Retry]
    J --> A
sql
Copy code

This **directly maps** to your assembly comments and makes the cycle *immediately understandable*.

---

## ✅ Then explain each stage (this is the right move)
After the diagram, explain each block clearly:

```md
### Logic Stages

**Reset / Initialize System**  
Resets registers, clears memory, and prepares the system for execution.

**Initialize Display**  
Sets up the pixel grid and prepares the output buffer for rendering.

**Display Level**  
Renders the current puzzle state to the screen.

**Assess User Input**  
Reads user controls and determines the intended action.

**Draw Pixel**  
Updates the grid based on the user input.

**Verify Move**  
Checks whether the move is valid and updates internal state.

**Win Condition Check**  
Determines whether the puzzle has been successfully completed.

**Fail / Retry**  
Handles invalid moves or failed attempts and resets the cycle if needed.
---

## Notes

- Filenames are kept as originally submitted (e.g. `pixel_puzzel.*`).
- Demo videos are stored in the `assets/` folder.

