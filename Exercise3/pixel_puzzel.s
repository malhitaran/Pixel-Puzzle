
ORG 0x0000
B REET

; ==============================================================================
; MAIN TABLE (Root Pointers)
; ==============================================================================
MAIN_TABLE:
    COLOUR_TABLE_POINTER:       DEFW COLOUR_TABLE
    ADDRESS_TABLE_POINTER:      DEFW ADDRESS_TABLE
    SOUND_TABLE_POINTER:        DEFW SOUND_TABLE
    KEYPAD_TABLE_POINTER:       DEFW KEYPAD_TABLE
    ASCII_TABLE_POINTER:        DEFW ASCII_TABLE
    POSITION_TABLE_POINTER:     DEFW POSITION_TABLE
    VARIABLES_TABLE_POINTER:    DEFW VARIABLES_TABLE
    TABLE_POINTERS:             DEFW JUMP_TABLE
    BRANCHES_POINTER:           DEFW BRANCHES_TABLE
    MESSAGE_TABLE_POINTER:      DEFW MSG_TABLE 

; Root Table Accessors (Absolute Labels used with R0)
COLOURS             EQU COLOUR_TABLE_POINTER
ADDRESS             EQU ADDRESS_TABLE_POINTER
SOUND               EQU SOUND_TABLE_POINTER
KEYPAD              EQU KEYPAD_TABLE_POINTER
ASCII               EQU ASCII_TABLE_POINTER
POSITION            EQU POSITION_TABLE_POINTER
VARIABLES           EQU VARIABLES_TABLE_POINTER
JUMPTABLE           EQU TABLE_POINTERS
BRANCH              EQU BRANCHES_POINTER
MESSAGE             EQU MESSAGE_TABLE_POINTER

; ==============================================================================
; COLOUR TABLE
; ==============================================================================
COLOUR_TABLE:
    WHITE_COLOR: DEFW 0xFF
    RED_COLOR:   DEFW 0x00E0
    BLACK_COLOR: DEFW 0x00
    GREEN_COLOR: DEFW 0x001C 

; Offsets
WHITE_OFF EQU (WHITE_COLOR - COLOUR_TABLE)
RED_OFF   EQU (RED_COLOR - COLOUR_TABLE)
BLACK_OFF EQU (BLACK_COLOR - COLOUR_TABLE)
GREEN_OFF EQU (GREEN_COLOR - COLOUR_TABLE)

; ==============================================================================
; ADDRESS TABLE
; ==============================================================================
ADDRESS_TABLE:
    MATRIX_BASE_ADDR: DEFW 0xFF00
    MATRIX_END_ADDR:  DEFW 0xFF3F
    LCD_START:        DEFW 0xFF40
    SOUND_ADDR:       DEFW 0xFF92
    KEYPAD_ADDR:      DEFW 0xFF94
    FRC_ADDR:         DEFW 0xFFA4
    SW_SWITCH_ADDR:   DEFW 0xFF95
    SW_LED_ADDR:      DEFW 0xFF97

; Offsets
MAT_BASE_OFF   EQU (MATRIX_BASE_ADDR - ADDRESS_TABLE)
MAT_END_OFF    EQU (MATRIX_END_ADDR - ADDRESS_TABLE)
LCD_START_OFF  EQU (LCD_START - ADDRESS_TABLE)
SOUND_ADDR_OFF EQU (SOUND_ADDR - ADDRESS_TABLE)
KEY_ADDR_OFF   EQU (KEYPAD_ADDR - ADDRESS_TABLE)
FRC_ADDR_OFF   EQU (FRC_ADDR - ADDRESS_TABLE)
SW_SWITCH_ADDR_OFF EQU (SW_SWITCH_ADDR   - ADDRESS_TABLE)
SW_LED_ADDR_OFF EQU (SW_LED_ADDR     - ADDRESS_TABLE)


LD R1, [R0, #ADDRESS]
LD R1, [R1, #MAT_BASE_OFF] ;MATRIX BASE ADDRESS

; ==============================================================================
; SOUND TABLE
; ==============================================================================
SOUND_TABLE:
    G_NOTE:      DEFW 0x8147
    NOTE2:       DEFW 0x8444
    T_R1_SAVE:   DEFW 0x0000
    T_R2_SAVE:   DEFW 0x0000
    MASK_6BITS:  DEFW 0x003F
    value64:     DEFW 64
    LED_L_PAT:   DEFW 0x006A

; Offsets
G_NOTE_OFF      EQU (G_NOTE - SOUND_TABLE)
NOTE2_OFF       EQU (NOTE2 - SOUND_TABLE)
T_R1_SAVE_OFF   EQU (T_R1_SAVE - SOUND_TABLE)
T_R2_SAVE_OFF   EQU (T_R2_SAVE - SOUND_TABLE)
MASK_6BITS_OFF  EQU (MASK_6BITS - SOUND_TABLE)
VALUE_64_OFFSET EQU (value64 - SOUND_TABLE)
LED_L_PAT_OFF   EQU (LED_L_PAT   - SOUND_TABLE)

; ==============================================================================
; KEYPAD TABLE
; ==============================================================================
KEYPAD_TABLE:
    KEYPAD_8:      DEFW 0x0100 ; DOWN
    KEYPAD_2:      DEFW 0x0004 ; UP
    KEYPAD_4:      DEFW 0x0010 ; LEFT
    KEYPAD_6:      DEFW 0x0040 ; RIGHT
    KEYPAD_5:      DEFW 0x0020 ; SELECT/STORE
    KEYPAD_FINISH: DEFW 0x0800 ; '#' / PASSED

; Offsets
KEY_DOWN_OFF   EQU (KEYPAD_8 - KEYPAD_TABLE)
KEY_UP_OFF     EQU (KEYPAD_2 - KEYPAD_TABLE)
KEY_LEFT_OFF   EQU (KEYPAD_4 - KEYPAD_TABLE)
KEY_RIGHT_OFF  EQU (KEYPAD_6 - KEYPAD_TABLE)
KEY_SELECT_OFF EQU (KEYPAD_5 - KEYPAD_TABLE)
KEY_PASS_OFF   EQU (KEYPAD_FINISH - KEYPAD_TABLE)

; ==============================================================================
; ASCII TABLE
; ==============================================================================
ASCII_TABLE:
    ASCII_P: DEFW 0x50      ; 'P'
    ASCII_0: DEFW 0x30      ; '0'

ASCII_P_OFF EQU (ASCII_P - ASCII_TABLE)
ASCII_0_OFF EQU (ASCII_0 - ASCII_TABLE)

; ==============================================================================
; MESSAGE TABLE (Intro / text)
; ==============================================================================

MSG_TABLE:
    MSG_START_PTR:     DEFW PIXEL_MSG        ; pointer to first character
    MSG_END_PTR:       DEFW PIXEL_MSG_END    ; pointer one past last character
    MSG_SCROLL_PTR:    DEFW PIXEL_MSG        ; (legacy – not used by new intro)
    MSG_LOOP_COUNT:    DEFW 64               ; (legacy – not used by new intro)
    MSG_ROWS:          DEFW 4                ; number of LCD rows
    MSG_COLS:          DEFW 20               ; number of columns per row

    PIXEL_WORD_PTR:    DEFW WORD_PIXEL       ; "PIXEL"
    PUZZLE_WORD_PTR:   DEFW WORD_PUZZLE      ; "PUZZLE"
    PRESS_PTR:         DEFW PRESS_MSG        ; bottom-row prompt

; Message: "        PIXEL PUZZLE        "  (kept for convenience)
PIXEL_MSG:
    DEFW 0x20    ; ' '
    DEFW 0x20
    DEFW 0x20
    DEFW 0x20
    DEFW 0x20
    DEFW 0x20
    DEFW 0x20
    DEFW 0x20
    DEFW 0x50    ; 'P'
    DEFW 0x49    ; 'I'
    DEFW 0x58    ; 'X'
    DEFW 0x45    ; 'E'
    DEFW 0x4C    ; 'L'
    DEFW 0x20    ; ' '
    DEFW 0x50    ; 'P'
    DEFW 0x55    ; 'U'
    DEFW 0x5A    ; 'Z'
    DEFW 0x5A    ; 'Z'
    DEFW 0x4C    ; 'L'
    DEFW 0x45    ; 'E'
    DEFW 0x20    ; ' '
    DEFW 0x20
    DEFW 0x20
    DEFW 0x20
    DEFW 0x20
    DEFW 0x20
    DEFW 0x20
    DEFW 0x20
PIXEL_MSG_END:

; "PIXEL"
WORD_PIXEL:
    DEFW 0x50  ; 'P'
    DEFW 0x49  ; 'I'
    DEFW 0x58  ; 'X'
    DEFW 0x45  ; 'E'
    DEFW 0x4C  ; 'L'

; "PUZZLE"
WORD_PUZZLE:
    DEFW 0x50  ; 'P'
    DEFW 0x55  ; 'U'
    DEFW 0x5A  ; 'Z'
    DEFW 0x5A  ; 'Z'
    DEFW 0x4C  ; 'L'
    DEFW 0x45  ; 'E'

; "PRESS ANY KEY       "  (exactly 20 chars for the bottom row)
PRESS_MSG:
    DEFW 0x50  ; 'P'
    DEFW 0x52  ; 'R'
    DEFW 0x45  ; 'E'
    DEFW 0x53  ; 'S'
    DEFW 0x53  ; 'S'
    DEFW 0x20  ; ' '
    DEFW 0x41  ; 'A'
    DEFW 0x4E  ; 'N'
    DEFW 0x59  ; 'Y'
    DEFW 0x20  ; ' '
    DEFW 0x4B  ; 'K'
    DEFW 0x45  ; 'E'
    DEFW 0x59  ; 'Y'
    DEFW 0x20  ; ' '
    DEFW 0x20  ; ' '
    DEFW 0x20  ; ' '
    DEFW 0x20  ; ' '
    DEFW 0x20  ; ' '
    DEFW 0x20  ; ' '
    DEFW 0x20  ; ' '

; Offsets inside MSG_TABLE
MSG_START_OFF        EQU (MSG_START_PTR      - MSG_TABLE)
MSG_END_OFF          EQU (MSG_END_PTR        - MSG_TABLE)
MSG_SCROLL_PTR_OFF   EQU (MSG_SCROLL_PTR     - MSG_TABLE)
MSG_LOOP_COUNT_OFF   EQU (MSG_LOOP_COUNT     - MSG_TABLE)
MSG_ROWS_OFF         EQU (MSG_ROWS           - MSG_TABLE)
MSG_COLS_OFF         EQU (MSG_COLS           - MSG_TABLE)
PIXEL_WORD_PTR_OFF   EQU (PIXEL_WORD_PTR     - MSG_TABLE)
PUZZLE_WORD_PTR_OFF  EQU (PUZZLE_WORD_PTR    - MSG_TABLE)
PRESS_PTR_OFF        EQU (PRESS_PTR          - MSG_TABLE)






; ==============================================================================
; POSITION TABLE
; ==============================================================================
POSITION_TABLE:
    CURRENT_POS:    DEFW 0xFF1B
    BOUND1:         DEFW 0xFF0F
    BOUND2:         DEFW 0xFF1F
    BOUND3:         DEFW 0xFF2F
    POINTER_POS1:   DEFW POS_0
    POINTER_POS2:   DEFW POS_16
    POINTER_POS3:   DEFW POS_32
    POINTER_POS4:   DEFW POS_48
    LOWER_BOUND1:   DEFW 0xFF00
    LOWER_BOUND2:   DEFW 0xFF10
    LOWER_BOUND3:   DEFW 0xFF20
    LOWER_BOUND4:   DEFW 0xFF30
    POINTER2_POS1:  DEFW POS2_0
    POINTER2_POS2:  DEFW POS2_16
    POINTER2_POS3:  DEFW POS2_32
    POINTER2_POS4:  DEFW POS2_48

; Offsets
POS_CURRENT_OFF      EQU (CURRENT_POS - POSITION_TABLE)
POS_BOUND1_OFF       EQU (BOUND1 - POSITION_TABLE)
POS_BOUND2_OFF       EQU (BOUND2 - POSITION_TABLE)
POS_BOUND3_OFF       EQU (BOUND3 - POSITION_TABLE)
POS_PTR1_OFF         EQU (POINTER_POS1 - POSITION_TABLE)
POS_PTR2_OFF         EQU (POINTER_POS2 - POSITION_TABLE)
POS_PTR3_OFF         EQU (POINTER_POS3 - POSITION_TABLE)
POS_PTR4_OFF         EQU (POINTER_POS4 - POSITION_TABLE)
POS_LOWER1_OFF       EQU (LOWER_BOUND1 - POSITION_TABLE)
POS_LOWER2_OFF       EQU (LOWER_BOUND2 - POSITION_TABLE)
POS_LOWER3_OFF       EQU (LOWER_BOUND3 - POSITION_TABLE)
POS_LOWER4_OFF       EQU (LOWER_BOUND4 - POSITION_TABLE)
POS_PTR2_POS1_OFF    EQU (POINTER2_POS1 - POSITION_TABLE)
POS_PTR2_POS2_OFF    EQU (POINTER2_POS2 - POSITION_TABLE)
POS_PTR2_POS3_OFF    EQU (POINTER2_POS3 - POSITION_TABLE)
POS_PTR2_POS4_OFF    EQU (POINTER2_POS4 - POSITION_TABLE)

SEL_POS_TABLE EQU (POINTER_POS1 - POSITION_TABLE)
LEV_POS_TABLE EQU (POINTER2_POS1 - POSITION_TABLE)

REET:
    B REST

; ==============================================================================
; VARIABLES TABLE
; ==============================================================================
VARIABLES_TABLE:
    OUTER_COUNT:   DEFW 0x0FFF
    INNER_COUNT:   DEFW 0x0004
    LOWER_BOUND:   DEFW 0xFF00
    UPPER_BOUND:   DEFW 0xFF3F
    POINTER_POS:   DEFW POS_0
    ONE:           DEFW 0x0001
    ZERO:          DEFW 0x00
    UPBRANCH1:     DEFW 0x00A1
    UPBRANCH2:     DEFW 0x00A2
    LEFTBRANCH1:   DEFW 0x00B1
    LEFTBRANCH2:   DEFW 0x00B2
    RIGHTBRANCH1:  DEFW 0x00C1
    RIGHTBRANCH2:  DEFW 0x00C2
    DOWNBRANCH1:   DEFW 0x00D1
    DOWNBRANCH2:   DEFW 0x00D2
    LEVEL_COUNTER: DEFW 0x0001

; Offsets
VAR_OUTER_OFF      EQU (OUTER_COUNT - VARIABLES_TABLE)
VAR_INNER_OFF      EQU (INNER_COUNT - VARIABLES_TABLE)
VAR_LOWER_OFF      EQU (LOWER_BOUND - VARIABLES_TABLE)
VAR_UPPER_OFF      EQU (UPPER_BOUND - VARIABLES_TABLE)
VAR_PTR_OFF        EQU (POINTER_POS - VARIABLES_TABLE)
VAR_ONE_OFF        EQU (ONE - VARIABLES_TABLE)
VAR_ZERO_OFF       EQU (ZERO - VARIABLES_TABLE)
VAR_UP1_OFF        EQU (UPBRANCH1 - VARIABLES_TABLE)
VAR_UP2_OFF        EQU (UPBRANCH2 - VARIABLES_TABLE)
VAR_LEFT1_OFF      EQU (LEFTBRANCH1 - VARIABLES_TABLE)
VAR_LEFT2_OFF      EQU (LEFTBRANCH2 - VARIABLES_TABLE)
VAR_RIGHT1_OFF     EQU (RIGHTBRANCH1 - VARIABLES_TABLE)
VAR_RIGHT2_OFF     EQU (RIGHTBRANCH2 - VARIABLES_TABLE)
VAR_DOWN1_OFF      EQU (DOWNBRANCH1 - VARIABLES_TABLE)
VAR_DOWN2_OFF      EQU (DOWNBRANCH2 - VARIABLES_TABLE)
VAR_LEVEL_CNT_OFF  EQU (LEVEL_COUNTER - VARIABLES_TABLE)


; ==============================================================================
; JUMP TABLE
; ==============================================================================
JUMP_TABLE:
    NEAR_JUMP: DEFW NEAR_UPDATE_CURRENT
    RESET1:    DEFW RESET
    LEVEL1_J:  DEFW LEVEL1       ; new entry

JUMP_NEAR_OFF  EQU (NEAR_JUMP  - JUMP_TABLE)
JUMP_RST_OFF   EQU (RESET1     - JUMP_TABLE)
JUMP_LVL1_OFF  EQU (LEVEL1_J   - JUMP_TABLE)


; ==============================================================================
; SELECTED POSITIONS TABLES
; ==============================================================================
SELECTED_POSITIONS_TABLE:
    POS_0:   DEFW 0
    POS_1:   DEFW 0
    POS_2:   DEFW 0
    POS_3:   DEFW 0
    POS_4:   DEFW 0
    POS_5:   DEFW 0
    POS_6:   DEFW 0
    POS_7:   DEFW 0
    POS_8:   DEFW 0
    POS_9:   DEFW 0
    POS_10:  DEFW 0
    POS_11:  DEFW 0
    POS_12:  DEFW 0
    POS_13:  DEFW 0
    POS_14:  DEFW 0
    POS_15:  DEFW 0

SELECTED_POSITIONS_TABLE2:
    POS_16:  DEFW 0
    POS_17:  DEFW 0
    POS_18:  DEFW 0
    POS_19:  DEFW 0
    POS_20:  DEFW 0
    POS_21:  DEFW 0
    POS_22:  DEFW 0
    POS_23:  DEFW 0
    POS_24:  DEFW 0
    POS_25:  DEFW 0
    POS_26:  DEFW 0
    POS_27:  DEFW 0
    POS_28:  DEFW 0
    POS_29:  DEFW 0
    POS_30:  DEFW 0
    POS_31:  DEFW 0

SELECTED_POSITIONS_TABLE3:
    POS_32:  DEFW 0
    POS_33:  DEFW 0
    POS_34:  DEFW 0
    POS_35:  DEFW 0
    POS_36:  DEFW 0
    POS_37:  DEFW 0
    POS_38:  DEFW 0
    POS_39:  DEFW 0
    POS_40:  DEFW 0
    POS_41:  DEFW 0
    POS_42:  DEFW 0
    POS_43:  DEFW 0
    POS_44:  DEFW 0
    POS_45:  DEFW 0
    POS_46:  DEFW 0
    POS_47:  DEFW 0

SELECTED_POSITIONS_TABLE4:
    POS_48:  DEFW 0
    POS_49:  DEFW 0
    POS_50:  DEFW 0
    POS_51:  DEFW 0
    POS_52:  DEFW 0
    POS_53:  DEFW 0
    POS_54:  DEFW 0
    POS_55:  DEFW 0
    POS_56:  DEFW 0
    POS_57:  DEFW 0
    POS_58:  DEFW 0
    POS_59:  DEFW 0
    POS_60:  DEFW 0
    POS_61:  DEFW 0
    POS_62:  DEFW 0
    POS_63:  DEFW 0

; ==============================================================================
; BRANCHES TABLE
; ==============================================================================
BRANCHES_TABLE:
    WAIT1:         DEFW WAIT
    CHECK1:        DEFW CHECK
    UPBRANCH11:    DEFW UPBRANC1
    UPBRANCH21:    DEFW UPBRANC2
    UPBRANCH31:    DEFW UPBRANC3
    LEFTBRANCH11:  DEFW LEFTBRANC1
    LEFTBRANCH21:  DEFW LEFTBRANC2
    LEFTBRANCH31:  DEFW LEFTBRANC3
    RIGHTBRANCH11: DEFW RIGHTBRANC1
    RIGHTBRANCH21: DEFW RIGHTBRANC2
    RIGHTBRANCH31: DEFW RIGHTBRANC3
    DOWNBRANCH11:  DEFW DOWNBRANC1
    DOWNBRANCH21:  DEFW DOWNBRANC2
    DOWNBRANCH31:  DEFW DOWNBRANC3

; Offsets
BR_WAIT_OFF     EQU (WAIT1 - BRANCHES_TABLE)
BR_CHECK_OFF    EQU (CHECK1 - BRANCHES_TABLE)
BR_UP1_OFF      EQU (UPBRANCH11 - BRANCHES_TABLE)
BR_UP2_OFF      EQU (UPBRANCH21 - BRANCHES_TABLE)
BR_UP3_OFF      EQU (UPBRANCH31 - BRANCHES_TABLE)
BR_LEFT1_OFF    EQU (LEFTBRANCH11 - BRANCHES_TABLE)
BR_LEFT2_OFF    EQU (LEFTBRANCH21 - BRANCHES_TABLE)
BR_LEFT3_OFF    EQU (LEFTBRANCH31 - BRANCHES_TABLE)
BR_RIGHT1_OFF   EQU (RIGHTBRANCH11 - BRANCHES_TABLE)
BR_RIGHT2_OFF   EQU (RIGHTBRANCH21 - BRANCHES_TABLE)
BR_RIGHT3_OFF   EQU (RIGHTBRANCH31 - BRANCHES_TABLE)
BR_DOWN1_OFF    EQU (DOWNBRANCH11 - BRANCHES_TABLE)
BR_DOWN2_OFF    EQU (DOWNBRANCH21 - BRANCHES_TABLE)
BR_DOWN3_OFF    EQU (DOWNBRANCH31 - BRANCHES_TABLE)

REST:
    B RESET

; ==============================================================================
; LEVEL POSITIONS TABLES
; ==============================================================================
LEVEL_POSITIONS_TABLE:
    POS2_0:   DEFW 0
    POS2_1:   DEFW 0
    POS2_2:   DEFW 0
    POS2_3:   DEFW 0
    POS2_4:   DEFW 0
    POS2_5:   DEFW 0
    POS2_6:   DEFW 0
    POS2_7:   DEFW 0
    POS2_8:   DEFW 0
    POS2_9:   DEFW 0
    POS2_10:  DEFW 0
    POS2_11:  DEFW 0
    POS2_12:  DEFW 0
    POS2_13:  DEFW 0
    POS2_14:  DEFW 0
    POS2_15:  DEFW 0

LEVEL_POSITIONS_TABLE2:
    POS2_16:  DEFW 0
    POS2_17:  DEFW 0
    POS2_18:  DEFW 0
    POS2_19:  DEFW 0
    POS2_20:  DEFW 0
    POS2_21:  DEFW 0
    POS2_22:  DEFW 0
    POS2_23:  DEFW 0
    POS2_24:  DEFW 0
    POS2_25:  DEFW 0
    POS2_26:  DEFW 0
    POS2_27:  DEFW 0
    POS2_28:  DEFW 0
    POS2_29:  DEFW 0
    POS2_30:  DEFW 0
    POS2_31:  DEFW 0

LEVEL_POSITIONS_TABLE3:
    POS2_32:  DEFW 0
    POS2_33:  DEFW 0
    POS2_34:  DEFW 0
    POS2_35:  DEFW 0
    POS2_36:  DEFW 0
    POS2_37:  DEFW 0
    POS2_38:  DEFW 0
    POS2_39:  DEFW 0
    POS2_40:  DEFW 0
    POS2_41:  DEFW 0
    POS2_42:  DEFW 0
    POS2_43:  DEFW 0
    POS2_44:  DEFW 0
    POS2_45:  DEFW 0
    POS2_46:  DEFW 0
    POS2_47:  DEFW 0

LEVEL_POSITIONS_TABLE4:
    POS2_48:  DEFW 0
    POS2_49:  DEFW 0
    POS2_50:  DEFW 0
    POS2_51:  DEFW 0
    POS2_52:  DEFW 0
    POS2_53:  DEFW 0
    POS2_54:  DEFW 0
    POS2_55:  DEFW 0
    POS2_56:  DEFW 0
    POS2_57:  DEFW 0
    POS2_58:  DEFW 0
    POS2_59:  DEFW 0
    POS2_60:  DEFW 0
    POS2_61:  DEFW 0
    POS2_62:  DEFW 0
    POS2_63:  DEFW 0

; ==============================================================================
; GAME LOGIC
; ==============================================================================


; ----------------------------------------------------------------------------------
; PIXEL PUZZLES EXECUTION CYCLE
; ----------------------------------------------------------------------------------
;
; ->[0] RESET/INIT SYSTEM -> [1] INIT DISPLAY -> [2] DISPLAYING LEVEL -> [3] ASSESSING USER INPUT
;          ^                                                                            |
;          |                                                                            |
;          |                                                                            V            
; [6] OTHERWISE FAIL      <- [6] CHECK FOR WIN       <- [5] VERIFY          <- [4] DRAW PIXEL
; 
; +-----------------------------------------------------------------------------
;




; ==============================================================================
; RESET/INIT SYSTEM
; ==============================================================================



RESET:
    LD R1, [R0,#ADDRESS] ;MATRIX END ADDRESS
    LD R1, [R1,#MAT_END_OFF]

    LD R3, [R0, #COLOURS]
    LD R3, [R3, #BLACK_OFF];BLACK COLOUR

    LD R2, [R0, #ADDRESS]
    LD R2, [R2, #MAT_BASE_OFF];MATRIX BASE ADDRESS

LOOP:
    ST R3, [R2]
    ADD R2, R2, #1
    CMP R2, R1
    BNE LOOP

    ST R3, [R2]

    LD R1, [R0, #VARIABLES]
    LD R1, [R1, #VAR_LEVEL_CNT_OFF]

    LD R2, [R0, #VARIABLES]
    LD R2, [R2, #VAR_ONE_OFF]

    CMP R1, R2

    BEQ INIT_DISPLAY

    ;need to reset all memory tables

    LD R1, [R0,#POSITION]
    LD R2, [R1,#SEL_POS_TABLE];r2 contains first element of the table from what the user selected
    LD R3, [R1,#LEV_POS_TABLE];r3 contains first element of the table from what the level selected

    LD R1, [R0,#SOUND]
    LD r1, [r1,#VALUE_64_OFFSET] ;r1 = 64

ZERO_LOOP:
    ST R0, [R2]
    ST R0, [R3]
    ADD R2, R2, #1
    ADD R3, R3, #1 
    SUBS R1, R1, #1
    BEQ INIT_DISPLAY2
    BAL ZERO_LOOP






; ==============================================================================
; INIT DISPLAY
; ==============================================================================


;this is our LCD display for when the level is greater than 1, so when it shows the levels e.g. 2, 3, 4, etc
INIT_DISPLAY2:
    ; --------------------------------------
    ; Clear entire LCD and show current level
    ; --------------------------------------

    ; R3 = ' ' (space) from PIXEL_MSG[0]
    LD  R1, [R0, #MESSAGE]
    LD  R3, [R1, #MSG_START_OFF]   ; R3 = &PIXEL_MSG
    LD  R3, [R3]                   ; first char = 0x20 (' ')

    ; R6 = LCD start address
    LD  R6, [R0, #ADDRESS]
    LD  R6, [R6, #LCD_START_OFF]

    ; R1 = row counter = MSG_ROWS
    LD  R1, [R0, #MESSAGE]
    LD  R1, [R1, #MSG_ROWS_OFF]

INIT2_CLR_ROWS:
    ; R5 = column counter = MSG_COLS
    LD  R2, [R0, #MESSAGE]
    LD  R5, [R2, #MSG_COLS_OFF]

INIT2_CLR_COLS:
    ST  R3, [R6]                   ; write space
    ADD R6, R6, #1
    SUBS R5, R5, #1
    BNE INIT2_CLR_COLS

    SUBS R1, R1, #1
    BNE INIT2_CLR_ROWS

    ; --------------------------------------
    ; Now show the current level number
    ; --------------------------------------

    ; R3 = LEVEL_COUNTER (1,2,3,...)
    LD  R3, [R0, #VARIABLES]
    LD  R3, [R3, #VAR_LEVEL_CNT_OFF]

    ; R1 = ASCII '0'
    LD  R1, [R0, #ASCII]
    LD  R1, [R1, #ASCII_0_OFF]

    ; R3 = '0' + LEVEL_COUNTER -> '1','2',...
    ADD R3, R3, R1

    ; R2 = LCD start address again
    LD  R2, [R0, #ADDRESS]
    LD  R2, [R2, #LCD_START_OFF]

    ; Put digit in first character cell (row 0, col 0)
    ST  R3, [R2]

    ; --------------------------------------
    ; Long jump to LEVEL1 via jump table
    ; --------------------------------------
    LD  R1, [R0, #JUMPTABLE]
    LD  R1, [R1, #JUMP_LVL1_OFF]
    ADD R7, R1, R0






;this is our LCD display for when the level is 1, we need to show the pixel puzzle name, show press any key, then start the game
INIT_DISPLAY:

    ; ---------------------------------------------
    ; 0) Get a SPACE character from PIXEL_MSG[0]
    ;      R3 = ' '
    ; ---------------------------------------------
    LD  R1, [R0, #MESSAGE]
    LD  R3, [R1, #MSG_START_OFF]   ; R3 = &PIXEL_MSG
    LD  R3, [R3]                   ; R3 = first char = 0x20 (space)

    ; ---------------------------------------------
    ; 1) Clear entire LCD (MSG_ROWS x MSG_COLS)
    ; ---------------------------------------------

    ; R6 = LCD start address
    LD  R6, [R0, #ADDRESS]
    LD  R6, [R6, #LCD_START_OFF]

    ; R1 = row counter = MSG_ROWS
    LD  R1, [R0, #MESSAGE]
    LD  R1, [R1, #MSG_ROWS_OFF]

INIT_CLR_ROWS:
    ; R5 = column counter = MSG_COLS
    LD  R2, [R0, #MESSAGE]
    LD  R5, [R2, #MSG_COLS_OFF]

INIT_CLR_COLS:
    ST  R3, [R6]
    ADD R6, R6, #1
    SUBS R5, R5, #1
    BNE INIT_CLR_COLS

    SUBS R1, R1, #1
    BNE INIT_CLR_ROWS


    ; ---------------------------------------------
    ; 2) Row 0: "PIXEL" sweeps left -> right
    ; ---------------------------------------------

    ; POS in R1 (start at 0)
    ADD R1, R0, #0

PIXEL_SWEEP_LOOP:

    ; Row 0 base in R4
    LD  R4, [R0, #ADDRESS]
    LD  R4, [R4, #LCD_START_OFF]

    ; Clear row 0 to spaces
    LD  R2, [R0, #MESSAGE]
    LD  R5, [R2, #MSG_COLS_OFF]
    ADD R6, R4, R0           ; R6 = row0 pointer

PIXEL_CLR_ROW0:
    ST  R3, [R6]
    ADD R6, R6, #1
    SUBS R5, R5, #1
    BNE PIXEL_CLR_ROW0

    ; Destination pointer = row0 base + POS
    ADD R6, R4, R1

    ; Copy 5 letters from WORD_PIXEL
    LD  R2, [R0, #MESSAGE]
    LD  R5, [R2, #PIXEL_WORD_PTR_OFF]   ; R5 = &WORD_PIXEL
    ADD R2, R0, #5                      ; length = 5

PIXEL_COPY_LOOP:
    LD  R4, [R5]
    ST  R4, [R6]
    ADD R5, R5, #1
    ADD R6, R6, #1
    SUBS R2, R2, #1
    BNE PIXEL_COPY_LOOP

    ; Delay (OUTER x INNER)
    LD  R2, [R0, #VARIABLES]
    LD  R5, [R2, #VAR_OUTER_OFF]

PIXEL_DELAY_OUTER:
    LD  R2, [R0, #VARIABLES]
    LD  R6, [R2, #VAR_INNER_OFF]

PIXEL_DELAY_INNER:
    SUBS R6, R6, #1
    BNE  PIXEL_DELAY_INNER

    SUBS R5, R5, #1
    BNE  PIXEL_DELAY_OUTER

    ; POS++ until COLS - 5
    LD  R2, [R0, #MESSAGE]
    LD  R5, [R2, #MSG_COLS_OFF]
    SUB R5, R5, #5           ; max start = COLS - 5

    CMP R1, R5
    BEQ PIXEL_SWEEP_DONE

    ADD R1, R1, #1
    B   PIXEL_SWEEP_LOOP

PIXEL_SWEEP_DONE:


    ; ---------------------------------------------
    ; 3) Row 1: "PUZZLE" sweeps right -> left
    ; ---------------------------------------------

    ; POS2 = COLS - 6 in R1
    LD  R2, [R0, #MESSAGE]
    LD  R5, [R2, #MSG_COLS_OFF]
    SUB R1, R5, #6

PUZZLE_SWEEP_LOOP:

    ; Row1 base = LCD_START + COLS
    LD  R4, [R0, #ADDRESS]
    LD  R4, [R4, #LCD_START_OFF]      ; row0 base

    LD  R2, [R0, #MESSAGE]
    LD  R5, [R2, #MSG_COLS_OFF]       ; COLS
    ADD R4, R4, R5                    ; row1 base

    ; Clear row1
    LD  R2, [R0, #MESSAGE]
    LD  R5, [R2, #MSG_COLS_OFF]
    ADD R6, R4, R0

PUZZLE_CLR_ROW1:
    ST  R3, [R6]
    ADD R6, R6, #1
    SUBS R5, R5, #1
    BNE PUZZLE_CLR_ROW1

    ; Destination pointer = row1 base + POS2
    ADD R6, R4, R1

    ; Copy 6 letters from WORD_PUZZLE
    LD  R2, [R0, #MESSAGE]
    LD  R5, [R2, #PUZZLE_WORD_PTR_OFF]
    ADD R2, R0, #6                     ; length = 6

PUZZLE_COPY_LOOP:
    LD  R4, [R5]
    ST  R4, [R6]
    ADD R5, R5, #1
    ADD R6, R6, #1
    SUBS R2, R2, #1
    BNE PUZZLE_COPY_LOOP

    ; Delay (same OUTER x INNER)
    LD  R2, [R0, #VARIABLES]
    LD  R5, [R2, #VAR_OUTER_OFF]

PUZZLE_DELAY_OUTER:
    LD  R2, [R0, #VARIABLES]
    LD  R6, [R2, #VAR_INNER_OFF]

PUZZLE_DELAY_INNER:
    SUBS R6, R6, #1
    BNE  PUZZLE_DELAY_INNER

    SUBS R5, R5, #1
    BNE  PUZZLE_DELAY_OUTER

    ; POS2-- until 0
    CMP R1, R0
    BEQ PUZZLE_SWEEP_DONE

    SUB R1, R1, #1
    B   PUZZLE_SWEEP_LOOP

PUZZLE_SWEEP_DONE:


    ; ---------------------------------------------
    ; 4) Clear rows 0..2 (top three rows blank)
    ; ---------------------------------------------

    ; Row0 base in R6
    LD  R6, [R0, #ADDRESS]
    LD  R6, [R6, #LCD_START_OFF]

    LD  R2, [R0, #MESSAGE]
    LD  R5, [R2, #MSG_COLS_OFF]   ; COLS

    ADD R1, R0, #3                ; 3 rows (0,1,2)

CLEAR_TOP_ROWS:
    ADD R4, R5, R0                ; R4 = COLS (column counter)

CLEAR_TOP_COLS:
    ST  R3, [R6]                  ; space
    ADD R6, R6, #1
    SUBS R4, R4, #1
    BNE CLEAR_TOP_COLS

    SUBS R1, R1, #1
    BNE CLEAR_TOP_ROWS


    ; ---------------------------------------------
    ; 5) Bottom row: "PRESS ANY KEY" and wait
    ; ---------------------------------------------

    ; Compute row3 base: LCD_START + 3 * COLS

    LD  R6, [R0, #ADDRESS]
    LD  R6, [R6, #LCD_START_OFF]  ; row0 base

    LD  R2, [R0, #MESSAGE]
    LD  R5, [R2, #MSG_COLS_OFF]   ; COLS

    ADD R4, R5, R5                ; 2 * COLS
    ADD R4, R4, R5                ; 3 * COLS
    ADD R6, R6, R4                ; R6 = row3 base

    ; Copy PRESS_MSG to row3
    LD  R2, [R0, #MESSAGE]
    LD  R1, [R2, #PRESS_PTR_OFF]  ; R1 = &PRESS_MSG
    LD  R4, [R2, #MSG_COLS_OFF]   ; column counter

    ADD R5, R6, R0                ; dest pointer = row3 base

PRESS_COPY_LOOP:
    LD  R3, [R1]
    ST  R3, [R5]
    ADD R1, R1, #1
    ADD R5, R5, #1
    SUBS R4, R4, #1
    BNE PRESS_COPY_LOOP

    ; Wait for any key press
WAIT_KEY_PRESS:
    LD  R1, [R0, #ADDRESS]
    LD  R1, [R1, #KEY_ADDR_OFF]
    LD  R2, [R1]
    CMP R2, R0
    BEQ WAIT_KEY_PRESS            ; still no key

    ; Then wait for key release (so game doesnt see it as a move)
WAIT_KEY_RELEASE:
    LD  R1, [R0, #ADDRESS]
    LD  R1, [R1, #KEY_ADDR_OFF]
    LD  R2, [R1]
    CMP R2, R0
    BNE WAIT_KEY_RELEASE

    B   LEVEL1



; ==============================================================================
; DISPLAYING LEVEL
; ==============================================================================



LEVEL1:

    ; Get current level: how many pixels to show this level
    LD R6, [R0, #VARIABLES]
    LD R6, [R6, #VAR_LEVEL_CNT_OFF]    ; R6 = LEVEL_COUNTER (>= 1)

    B DISPLAY_LEVEL_PATTERN



; --- Display and store winning pattern for current level ---

DISPLAY_LEVEL_PATTERN:

    ; If no pixels remaining, finish this level
    CMP R6, R0
    BEQ FINISH_LEVEL_PATTERN


CHOOSE_RANDOM_PIXEL_FOR_LEVEL:

    ; -------------------------------------------------------------
    ; 1. Get a random matrix address using Free Running Counter FRC
    ; -------------------------------------------------------------

    LD R1, [R0, #ADDRESS]
    LD R1, [R1, #FRC_ADDR_OFF]         ; R1 = &FRC (&FFA4)
    LD R1, [R1]                        ; R1 = FRC value

    LD R2, [R0, #SOUND]
    LD R2, [R2, #MASK_6BITS_OFF]       ; R2 = 0x003F
    AND R1, R1, R2                     ; R1 = random index 0..63

    LD R2, [R0, #ADDRESS]
    LD R2, [R2, #MAT_BASE_OFF]         ; R2 = MATRIX_BASE (&FF00)
    ADD R2, R2, R1                     ; R2 = random matrix address (&FF00..&FF3F)

    ; Keep a copy of matrix address in R4 for mapping
    MOV R4, R2



    ; -------------------------------------------------------------
    ; 2. Map matrix address to LEVEL_POSITIONS_TABLE entry (POS2_xx)
    ;    Use the same row/offset scheme as your STORE code.
    ; -------------------------------------------------------------

    LD R1, [R0, #POSITION]
    LD R1, [R1, #POS_BOUND1_OFF]       ; BOUND1 (0xFF0F)
    CMP R4, R1
    BLE LOAD_FIRST_POS_FOR_LEVEL

    LD R1, [R0, #POSITION]
    LD R1, [R1, #POS_BOUND2_OFF]       ; BOUND2 (0xFF1F)
    CMP R4, R1
    BLE LOAD_SECOND_POS_FOR_LEVEL

    LD R1, [R0, #POSITION]
    LD R1, [R1, #POS_BOUND3_OFF]       ; BOUND3 (0xFF2F)
    CMP R4, R1
    BLE LOAD_THIRD_POS_FOR_LEVEL

    B LOAD_FOURTH_POS_FOR_LEVEL



; --- Select which POS2 block (0..15 / 16..31 / 32..47 / 48..63) ---

; On entry to each LOAD_*_POS_FOR_LEVEL:
;   R4 = matrix address (&FF00..&FF3F)
; On exit to AFTER_LOADING_POS_FOR_LEVEL:
;   R3 = base pointer for POS2 block (POS2_0 / 16 / 32 / 48)
;   R5 = lower bound address for that row (FF00 / FF10 / FF20 / FF30)

LOAD_FIRST_POS_FOR_LEVEL:

    LD R3, [R0, #POSITION]
    LD R3, [R3, #POS_PTR2_POS1_OFF]    ; -> POS2_0

    LD R5, [R0, #POSITION]
    LD R5, [R5, #POS_LOWER1_OFF]       ; LOWER_BOUND1 (&FF00)

    B AFTER_LOADING_POS_FOR_LEVEL


LOAD_SECOND_POS_FOR_LEVEL:

    LD R3, [R0, #POSITION]
    LD R3, [R3, #POS_PTR2_POS2_OFF]    ; -> POS2_16

    LD R5, [R0, #POSITION]
    LD R5, [R5, #POS_LOWER2_OFF]       ; LOWER_BOUND2 (&FF10)

    B AFTER_LOADING_POS_FOR_LEVEL


LOAD_THIRD_POS_FOR_LEVEL:

    LD R3, [R0, #POSITION]
    LD R3, [R3, #POS_PTR2_POS3_OFF]    ; -> POS2_32

    LD R5, [R0, #POSITION]
    LD R5, [R5, #POS_LOWER3_OFF]       ; LOWER_BOUND3 (&FF20)

    B AFTER_LOADING_POS_FOR_LEVEL


LOAD_FOURTH_POS_FOR_LEVEL:

    LD R3, [R0, #POSITION]
    LD R3, [R3, #POS_PTR2_POS4_OFF]    ; -> POS2_48

    LD R5, [R0, #POSITION]
    LD R5, [R5, #POS_LOWER4_OFF]       ; LOWER_BOUND4 (&FF30)

    B AFTER_LOADING_POS_FOR_LEVEL



; --- Compute offset within POS2 block, check duplicates, then store ---

AFTER_LOADING_POS_FOR_LEVEL:

    ; R4 = matrix address
    ; R5 = lower bound for this row (FF00 / 10 / 20 / 30)
    ; R3 = base pointer to POS2 block (POS2_0 / 16 / 32 / 48)

    SUB R5, R4, R5                     ; R5 = offset 0..15 within row
    ADD R3, R3, R5                     ; R3 -> POS2_(blockStart + offset)

    ; Check if this level position is already used
    LD R1, [R3]                        ; R1 = 0 or 1
    CMP R1, R0
    BNE CHOOSE_RANDOM_PIXEL_FOR_LEVEL  ; duplicate → pick a new random pixel



    ; -------------------------------------------------------------
    ; 3. Pixel is unique for this level: show it and store '1'
    ; -------------------------------------------------------------

    ; Show red pixel at matrix address R2
    LD R1, [R0, #COLOURS]
    LD R1, [R1, #RED_OFF]              ; R1 = RED colour
    ST R1, [R2]

    ; Play note at SOUND_ADDR
    LD R1, [R0, #SOUND]
    LD R1, [R1, #G_NOTE_OFF]           ; R1 = G_NOTE

    LD R4, [R0, #ADDRESS]
    LD R4, [R4, #SOUND_ADDR_OFF]       ; R4 = SOUND_ADDR (&FF92)
    ST R1, [R4]

    ; Mark this position in LEVEL_POSITIONS_TABLE as '1'
    LD R1, [R0, #VARIABLES]
    LD R1, [R1, #VAR_ONE_OFF]          ; R1 = 1
    ST R1, [R3]

    ; One fewer pixel remaining for this level
    SUBS R6, R6, #1

    ; Longish delay so the pattern is visible
    B DELAY_LEVEL_DISPLAY



; --- Delay routine (×4 OUTER/INNER loops) – preserves R6 ---

DELAY_LEVEL_DISPLAY:

    ; Build K = 4 in R5 using ONE constant (only small immediates)
    LD R5, [R0, #VARIABLES]
    LD R5, [R5, #VAR_ONE_OFF]          ; R5 = 1
    ADD R5, R5, R5                     ; R5 = 2
    ADD R5, R5, R5                     ; R5 = 4

LVL_DELAY_K_LOOP:

    ; Outer delay counter R2 = OUTER_COUNT
    LD R2, [R0, #VARIABLES]
    LD R2, [R2, #VAR_OUTER_OFF]

LVL_OUTER_L_LOOP:

    ; Inner delay counter R1 = INNER_COUNT
    LD R1, [R0, #VARIABLES]
    LD R1, [R1, #VAR_INNER_OFF]

LVL_INNER_L_LOOP:

    SUBS R1, R1, #1
    CMP R1, #0
    BNE LVL_INNER_L_LOOP

    SUBS R2, R2, #1
    CMP R2, #0
    BNE LVL_OUTER_L_LOOP

    ; Repeat the whole OUTER/INNER delay K times
    SUBS R5, R5, #1
    BNE LVL_DELAY_K_LOOP

    ; Go show the next pixel (or finish if R6 == 0)
    B DISPLAY_LEVEL_PATTERN



; --- After all pixels for this level have been displayed/stored ---

FINISH_LEVEL_PATTERN:

    ; 1. Clear the sound
    LD R4, [R0, #ADDRESS]
    LD R4, [R4, #SOUND_ADDR_OFF]       ; R4 = SOUND_ADDR
    ST R0, [R4]

    ; 2. Clear the matrix so the player starts from a blank screen

    LD R1, [R0, #ADDRESS]
    LD R1, [R1, #MAT_END_OFF]          ; MATRIX END ADDRESS

    LD R3, [R0, #COLOURS]
    LD R3, [R3, #BLACK_OFF]            ; BLACK colour

    LD R2, [R0, #ADDRESS]
    LD R2, [R2, #MAT_BASE_OFF]         ; MATRIX BASE ADDRESS

LOOP_CLEAR:

    ST R3, [R2]
    ADD R2, R2, #1
    CMP R2, R1
    BNE LOOP_CLEAR

    B LOAD                              ; Jump to start the game



LOAD:
    LD R4, [R0, #POSITION];CURRENT POSITION
    LD R4, [R4, #POS_CURRENT_OFF]

    LD R1, [R0, #ADDRESS]
    LD R1, [R1, #KEY_ADDR_OFF];KEYPAD ADDR

    LD R5, [R0, #COLOURS]
    LD R5, [R5, #BLACK_OFF];BLACK COLOUR

    LD R3, [R0, #COLOURS];WHITE COLOUR
    LD R3, [R3, #WHITE_OFF]


    B START_GAME



; ==============================================================================
; ASSESSING USER INPUT
; ==============================================================================



;wait for keypad to go back to zero, but still have the contents of it stored into r2. 
;we can use r1 and r2, 
WAIT_FOR_KEYPAD_ZERO:
    LD R1, [R0, #ADDRESS]
    LD R1, [R1, #KEY_ADDR_OFF];KEYPAD ADDR
    LD R1, [R1]
    CMP R1, R0
    BNE WAIT_FOR_KEYPAD_ZERO
    B KEY_PAD_NOW_ZERO


NEAR_UPDATE_CURRENT:
    LD R6, [R0, #POSITION]
    ST R4, [R6, #POS_CURRENT_OFF]
    B DELAY3


DELAY3:
    LD R6, [R0, #VARIABLES];OUTER_COUNT
    LD R6, [R6, #VAR_OUTER_OFF]
OUTER_LOOP3:
    LD R1, [R0, #VARIABLES]
    LD R1, [R1, #VAR_INNER_OFF];INNER COUNT
INNER_LOOP3:
    SUBS R1, R1, #1
    CMP R1, #0
    BNE INNER_LOOP3

    SUBS R6, R6, #1
    CMP R6, #0
    BNE OUTER_LOOP3
    
    B WAIT



START_GAME:
    
    ST R3, [R4]
    B WAIT



WAIT:
    LD R1, [R0, #ADDRESS]
    LD R1, [R1, #KEY_ADDR_OFF];KEYPAD ADDR
    LD R2, [R1]

    CMP R2, R0
    BEQ WAIT

    ;this is the point in whcih there is an input
    B WAIT_FOR_KEYPAD_ZERO
KEY_PAD_NOW_ZERO:

    LD R6, [R0, #KEYPAD];DOWN
    LD R6, [R6, #KEY_DOWN_OFF]

    CMP R2, R6
    BEQ DOWN

    LD R6, [R0, #KEYPAD];UP
    LD R6, [R6, #KEY_UP_OFF]

    
    CMP R2, R6
    BEQ UP


    LD R6, [R0, #KEYPAD];LEFT
    LD R6, [R6, #KEY_LEFT_OFF]

    CMP R2, R6
    BEQ LEFT

    LD R6, [R0, #KEYPAD];RIGHT
    LD R6, [R6, #KEY_RIGHT_OFF]
    CMP R2, R6
    BEQ RIGHT


    ;5
    ;STORE
    LD R6, [R0, #KEYPAD];SELECTED
    LD R6, [R6, #KEY_SELECT_OFF]
    CMP R2, R6
    BEQ STORE


    ;#
    ;so we need to firstly we need to store the level position in a table, so the initial display needs to be fixed 
    ; then we compare these tables

    ;first way would be to get a second memory table, then compare both tables
    ;second way would be to use the same memory table setting selected pixels to red, then when a user sets it instead
    ;of going to 1, it will go to 0 right
    ;then at the end we loop through the whole table to see if its all 0
    LD R6, [R0, #KEYPAD]
    LD R6, [R6, #KEY_PASS_OFF]
    CMP R2, R6
    BEQ PASSED


    B WAIT


; ==============================================================================
; DRAW USER PIXEL/VERIFY
; ==============================================================================


UP:
    ;need to check if current block is seleted, if so skip setting it to black 
    ;current is in r4
    ;KNOW WHAT BRANCH WERE ON WITH R5
    LD R2, [R0, #VARIABLES]
    LD R2, [R2, #VAR_UP1_OFF]

    ;B CHECK
    LD R1, [R0, #BRANCH]
    LD R1, [R1, #BR_CHECK_OFF]
    ADD R7, R1, R0
    
UPBRANC1:
    ST R5, [R4]
UPBRANC2:
    SUB R4, R4, #8
    LD R6, [R0, #VARIABLES]
    LD R6, [R6, #VAR_LOWER_OFF];LOWER BOUND

    CMP R4, R6
    BLT UP_CHECK
   
UP_BACK:
    ;check again if current block is selected, if so skip this store
    LD R2, [R0, #VARIABLES]
    LD R2, [R2, #VAR_UP2_OFF]


    ;B CHECK
    LD R1, [R0, #BRANCH]
    LD R1, [R1, #BR_CHECK_OFF]
    ADD R7, R1, R0

UPBRANC3:
    ST R3, [R4]
    B NEAR_UPDATE_CURRENT



LEFT:
    LD R2, [R0, #VARIABLES]
    LD R2, [R2, #VAR_LEFT1_OFF]


    ;B CHECK
    LD R1, [R0, #BRANCH]
    LD R1, [R1, #BR_CHECK_OFF]
    ADD R7, R1, R0
LEFTBRANC1:
    ST R5, [R4]
LEFTBRANC2:
    SUB R4, R4, #1
    LD R6, [R0, #VARIABLES]
    LD R6, [R6, #VAR_LOWER_OFF];LOWER BOUND

    CMP R4, R6
    BLT LEFT_CHECK
LEFT_BACK:
    LD R2, [R0, #VARIABLES]
    LD R2, [R2, #VAR_LEFT2_OFF]

    ;B CHECK
    LD R1, [R0, #BRANCH]
    LD R1, [R1, #BR_CHECK_OFF]
    ADD R7, R1, R0
LEFTBRANC3:
    ST R3, [R4]
    
    B NEAR_UPDATE_CURRENT




DOWN:
    LD R2, [R0, #VARIABLES]
    LD R2, [R2, #VAR_DOWN1_OFF]

    ;B CHECK
    LD R1, [R0, #BRANCH]
    LD R1, [R1, #BR_CHECK_OFF]
    ADD R7, R1, R0
   
DOWNBRANC1:
    ST R5, [R4]
DOWNBRANC2:
    ADD R4, R4, #8
    LD R6, [R0, #VARIABLES]
    LD R6, [R6, #VAR_UPPER_OFF];UPPER BOUND
    
    CMP R4, R6
    BGT DOWN_CHECK
DOWN_BACK:
    LD R2, [R0, #VARIABLES]
    LD R2, [R2, #VAR_DOWN2_OFF]

    LD R1, [R0, #BRANCH]
    LD R1, [R1, #BR_CHECK_OFF]
    ADD R7, R1, R0

DOWNBRANC3:
    ST R3, [R4]
    B NEAR_UPDATE_CURRENT


RIGHT:
    LD R2, [R0, #VARIABLES]
    LD R2, [R2, #VAR_RIGHT1_OFF]
    ;B CHECK
    LD R1, [R0, #BRANCH]
    LD R1, [R1, #BR_CHECK_OFF]
    ADD R7, R1, R0
RIGHTBRANC1:
    ST R5, [R4]
RIGHTBRANC2:
    ADD R4, R4, #1
    LD R6, [R0, #VARIABLES]
    LD R6, [R6, #VAR_UPPER_OFF];UPPER BOUND

    CMP R4, R6
    BGT RIGHT_CHECK
RIGHT_BACK:
    LD R2, [R0, #VARIABLES]
    LD R2, [R2, #VAR_RIGHT2_OFF]


    ;B CHECK
    LD R1, [R0, #BRANCH]
    LD R1, [R1, #BR_CHECK_OFF]
    ADD R7, R1, R0
RIGHTBRANC3:
    ST R3, [R4]
    B NEAR_UPDATE_CURRENT


UP_CHECK:
    ADD R4, R4, #8
    B UP_BACK


DOWN_CHECK:
    SUB R4, R4, #8
    B DOWN_BACK

LEFT_CHECK:
    ADD R4, R4, #1
    B LEFT_BACK

RIGHT_CHECK:
    SUB R4, R4, #1
    B RIGHT_BACK



STORE:
    LD R1, [R0, #POSITION]
    LD R1, [R1, #POS_BOUND1_OFF];BOUND 1
    CMP R4, R1
    BLE LOAD_FIRST_POS_TABLE2

    LD R1, [R0, #POSITION]
    LD R1, [R1, #POS_BOUND2_OFF];BOUND 2
    CMP R4, R1
    BLE LOAD_SECOND_POS_TABLE2

    LD R1, [R0, #POSITION]
    LD R1, [R1, #POS_BOUND3_OFF];BOUND 3
    CMP R4, R1
    BLE LOAD_THIRD_POS_TABLE2

    B LOAD_FOURTH_POS_TABLE2


    ;need to change here
AFTER_LOADING_POS_TABLE2:
    SUB R2, R4, R6;OFFSET
    ADD R3, R3, R2
    LD R1, [R3]


    CMP R1, R0
    BEQ ADD_DATA_IN

    B DELETE_DATA




; ==============================================================================
; CHECK FOR WIN
; ==============================================================================


PASS:
    LD R6, [R0, #VARIABLES]
    LD R6, [R6, #VAR_LEVEL_CNT_OFF]
    ADD R6, R6, #1

    LD R4, [R0, #VARIABLES]
    ST R6, [R4, #VAR_LEVEL_CNT_OFF]

    LD R1, [R0, #JUMPTABLE]
    LD R1, [R1, #JUMP_RST_OFF];wait
    ADD R7, R1, R0
    
;OUTER LOOP needs to point to the next variable
;r6r2
;inner loop needs to take e.g. pos 0 and add 1 to it 16 times
;r1, r5

PASSED:
    
    LD R1, [R0,#POSITION]
    LD R2, [R1,#SEL_POS_TABLE]
    LD R3, [R1,#LEV_POS_TABLE]

    LD R1, [R0,#SOUND]
    LD r1, [r1,#VALUE_64_OFFSET] ;r1 = 64

CHECK_LOOP:
    LD R4, [R2] ;r4 = sel[i] 
    LD R5, [R3] ;R5 = lev[i]
    CMP R4, R5
    BNE FAIL 
    ADD R2, R2, #1
    ADD R3, R3, #1 
    SUBS R1, R1, #1
    BEQ PASS  
    BAL CHECK_LOOP


LOAD_FIRST_POS_TABLE2:
    LD R3, [R0, #POSITION]
    LD R3, [R3, #POS_PTR1_OFF];POINTER

    LD R6, [R0, #POSITION];LOWER_BOUND1
    LD R6, [R6, #POS_LOWER1_OFF]

    B AFTER_LOADING_POS_TABLE2



LOAD_SECOND_POS_TABLE2:
    LD R3, [R0, #POSITION]
    LD R3, [R3, #POS_PTR2_OFF];POINTER TO POS16

    LD R6, [R0, #POSITION];LOWER_BOUND2
    LD R6, [R6, #POS_LOWER2_OFF]

    B AFTER_LOADING_POS_TABLE2


LOAD_THIRD_POS_TABLE2:
    LD R3, [R0, #POSITION]
    LD R3, [R3, #POS_PTR3_OFF];POINTER TO POS32

    LD R6, [R0, #POSITION];LOWER_BOUND3
    LD R6, [R6, #POS_LOWER3_OFF]
    B AFTER_LOADING_POS_TABLE2


LOAD_FOURTH_POS_TABLE2:
    LD R3, [R0, #POSITION]
    LD R3, [R3, #POS_PTR4_OFF];POINTER TO POS48

    LD R6, [R0, #POSITION];LOWER_BOUND4
    LD R6, [R6, #POS_LOWER4_OFF]

    B AFTER_LOADING_POS_TABLE2




ADD_DATA_IN:
    LD R2, [R0, #VARIABLES]
    LD R2, [R2, #VAR_ONE_OFF];ONE
    ST R2, [R3]
    LD R3, [R0, #COLOURS];Because we changed white we have to change it back
    LD R3, [R3, #WHITE_OFF]
    LD R1, [R0, #COLOURS]
    LD R1, [R1, #RED_OFF];RED
    ST R1, [R4]


    
    LD R1, [R0, #BRANCH]
    LD R1, [R1, #BR_WAIT_OFF];wait
    ADD R7, R1, R0

DELETE_DATA:
    ST R0, [R3]
    LD R1, [R0, #COLOURS]
    LD R1, [R1, #WHITE_OFF];WHITE
    ST R1, [R4]



    LD R1, [R0, #BRANCH]
    LD R1, [R1, #BR_WAIT_OFF];wait
    ADD R7, R1, R0



    ;TAKE CURRENT POS CHECK IF ALREADY IN ARRAY
    ;IF ITS ALREADY IN ARRAY WE NEED TO REMOVE IT
    ;IF NOT THEN ADD IT TO ARRAY


    ;DELETE ALL 
    ;CHECK FUNCTION CHECKS IF ITS 0 OR SOMETHING IS IN THERE



; ==============================================================================
; OTHERWISE FAIL
; ==============================================================================

FAIL:
    ; -------------------------------------------------
    ; Initial paint of mistakes (extras red, missed green)
    ; -------------------------------------------------

    ; R2 = &SELECTED_POSITIONS_TABLE[0]
    ; R3 = &LEVEL_POSITIONS_TABLE[0]
    LD  R6, [R0, #POSITION]
    LD  R2, [R6, #SEL_POS_TABLE]
    LD  R3, [R6, #LEV_POS_TABLE]

    ; R4 = MATRIX_BASE_ADDR (0xFF00)
    LD  R6, [R0, #ADDRESS]
    LD  R4, [R6, #MAT_BASE_OFF]

    ; R1 = 64 entries
    LD  R1, [R0, #SOUND]
    LD  R1, [R1, #VALUE_64_OFFSET]

FAIL_INIT_LOOP:
    LD  R5, [R2]          ; R5 = SEL[i]
    LD  R6, [R3]          ; R6 = LEV[i]

    CMP R5, R6
    BEQ FAIL_INIT_NEXT    ; equal -> correct (stay as-is: red if user got it)

    ; mismatch
    CMP R5, R0
    BEQ FAIL_INIT_MISSED  ; SEL=0, LEV=1 -> missed pixel (GREEN)

    ; SEL=1, LEV=0 -> extra selection (RED)
    LD  R6, [R0, #COLOURS]
    LD  R6, [R6, #RED_OFF]
    ST  R6, [R4]
    B   FAIL_INIT_NEXT

FAIL_INIT_MISSED:
    LD  R6, [R0, #COLOURS]
    LD  R6, [R6, #GREEN_OFF]
    ST  R6, [R4]

FAIL_INIT_NEXT:
    ADD R2, R2, #1
    ADD R3, R3, #1
    ADD R4, R4, #1
    SUBS R1, R1, #1
    BNE FAIL_INIT_LOOP

    ; -------------------------------------------------
    ; Turn on 'L' on the SW-LEDs (as before)
    ; -------------------------------------------------
    LD  R1, [R0, #ADDRESS]
    LD  R1, [R1, #SW_LED_ADDR_OFF]     ; R1 = &SW LEDs (0xFF97)

    LD  R2, [R0, #SOUND]
    LD  R2, [R2, #LED_L_PAT_OFF]       ; 0x006A pattern
    ST  R2, [R1]                       ; turn on 'L'

    ; -------------------------------------------------
    ; Main FAIL loop: flash extra selections in red
    ; -------------------------------------------------
FAIL_LOOP:

    ; ===== Phase A: extras RED, missed GREEN =====
    LD  R6, [R0, #POSITION]
    LD  R2, [R6, #SEL_POS_TABLE]
    LD  R3, [R6, #LEV_POS_TABLE]

    LD  R6, [R0, #ADDRESS]
    LD  R4, [R6, #MAT_BASE_OFF]

    LD  R1, [R0, #SOUND]
    LD  R1, [R1, #VALUE_64_OFFSET]     ; 64 pixels

FAIL_RED_LOOP:
    LD  R5, [R2]          ; SEL[i]
    LD  R6, [R3]          ; LEV[i]

    CMP R5, R6
    BEQ FAIL_RED_NEXT     ; correct -> leave as-is (solid red or black)

    CMP R5, R0
    BEQ FAIL_RED_MISSED   ; SEL=0,LEV=1 -> missed => GREEN

    ; SEL=1, LEV=0 -> extra => RED
    LD  R6, [R0, #COLOURS]
    LD  R6, [R6, #RED_OFF]
    ST  R6, [R4]
    B   FAIL_RED_NEXT

FAIL_RED_MISSED:
    LD  R6, [R0, #COLOURS]
    LD  R6, [R6, #GREEN_OFF]
    ST  R6, [R4]

FAIL_RED_NEXT:
    ADD R2, R2, #1
    ADD R3, R3, #1
    ADD R4, R4, #1
    SUBS R1, R1, #1
    BNE FAIL_RED_LOOP

    ; short delay
FAIL_RED_DELAY_OUTER:
    LD  R6, [R0, #VARIABLES]
    LD  R6, [R6, #VAR_OUTER_OFF]
FAIL_RED_DELAY_O:
    LD  R1, [R0, #VARIABLES]
    LD  R1, [R1, #VAR_INNER_OFF]
FAIL_RED_DELAY_I:
    SUBS R1, R1, #1
    BNE  FAIL_RED_DELAY_I
    SUBS R6, R6, #1
    BNE  FAIL_RED_DELAY_O

    ; ===== Phase B: extras BLACK, missed still GREEN =====
    LD  R6, [R0, #POSITION]
    LD  R2, [R6, #SEL_POS_TABLE]
    LD  R3, [R6, #LEV_POS_TABLE]

    LD  R6, [R0, #ADDRESS]
    LD  R4, [R6, #MAT_BASE_OFF]

    LD  R1, [R0, #SOUND]
    LD  R1, [R1, #VALUE_64_OFFSET]

FAIL_BLK_LOOP:
    LD  R5, [R2]          ; SEL[i]
    LD  R6, [R3]          ; LEV[i]

    CMP R5, R6
    BEQ FAIL_BLK_NEXT     ; correct -> leave as-is

    CMP R5, R0
    BEQ FAIL_BLK_MISSED   ; SEL=0,LEV=1 -> GREEN

    ; SEL=1, LEV=0 -> extra => BLACK
    LD  R6, [R0, #COLOURS]
    LD  R6, [R6, #BLACK_OFF]
    ST  R6, [R4]
    B   FAIL_BLK_NEXT

FAIL_BLK_MISSED:
    LD  R6, [R0, #COLOURS]
    LD  R6, [R6, #GREEN_OFF]
    ST  R6, [R4]

FAIL_BLK_NEXT:
    ADD R2, R2, #1
    ADD R3, R3, #1
    ADD R4, R4, #1
    SUBS R1, R1, #1
    BNE FAIL_BLK_LOOP

    ; short delay
FAIL_BLK_DELAY_OUTER:
    LD  R6, [R0, #VARIABLES]
    LD  R6, [R6, #VAR_OUTER_OFF]
FAIL_BLK_DELAY_O:
    LD  R1, [R0, #VARIABLES]
    LD  R1, [R1, #VAR_INNER_OFF]
FAIL_BLK_DELAY_I:
    SUBS R1, R1, #1
    BNE  FAIL_BLK_DELAY_I
    SUBS R6, R6, #1
    BNE  FAIL_BLK_DELAY_O

    ; ===== After one full RED+BLACK flash cycle, check SW-D =====
    LD  R1, [R0, #ADDRESS]
    LD  R1, [R1, #SW_SWITCH_ADDR_OFF]  ; R1 = &switches (0xFF95)
    LD  R2, [R1]                       ; read switches A..H

    ADD R3, R0, #8                     ; mask = 0x0008 (bit 3 -> SW-D)
    AND R2, R2, R3
    CMP R2, R0
    BEQ FAIL_LOOP                      ; SW-D not pressed -> keep flashing

    ; -------------------------------------------------
    ; SW-D pressed -> full hard reset (same as before)
    ; -------------------------------------------------
FAIL_HARD_RESET:
    ; 1) LEVEL_COUNTER := 1
    LD  R4, [R0, #VARIABLES]
    LD  R5, [R4, #VAR_ONE_OFF]
    ST  R5, [R4, #VAR_LEVEL_CNT_OFF]

    ; 2) Clear SEL_POS_TABLE and LEV_POS_TABLE (64 entries)
    LD  R1, [R0, #POSITION]
    LD  R2, [R1, #SEL_POS_TABLE]       ; R2 = &SELECTED_POSITIONS_TABLE[0]
    LD  R3, [R1, #LEV_POS_TABLE]       ; R3 = &LEVEL_POSITIONS_TABLE[0]

    LD  R1, [R0, #SOUND]
    LD  R1, [R1, #VALUE_64_OFFSET]     ; R1 = 64 (loop count)

FAIL_ZERO_LOOP:
    ST  R0, [R2]
    ST  R0, [R3]
    ADD R2, R2, #1
    ADD R3, R3, #1
    SUBS R1, R1, #1
    BNE FAIL_ZERO_LOOP

    ; turn off LEDs when restarting
    LD  R6, [R0, #ADDRESS]
    LD  R6, [R6, #SW_LED_ADDR_OFF]
    ST  R0, [R6]

    ; 3) Long jump to RESET using jump table
    LD  R1, [R0, #JUMPTABLE]
    LD  R1, [R1, #JUMP_RST_OFF]        ; address of RESET
    ADD R7, R1, R0                     ; PC := RESET






; ==============================================================================
; VERIFY
; ==============================================================================

CHECK:

    LD R1, [R0, #POSITION]
    LD R1, [R1, #POS_BOUND1_OFF];BOUND 1
    CMP R4, R1
    BLE LOAD_FIRST_POS_TABLE

    LD R1, [R0, #POSITION]
    LD R1, [R1, #POS_BOUND2_OFF];BOUND 2
    CMP R4, R1
    BLE LOAD_SECOND_POS_TABLE

    LD R1, [R0, #POSITION]
    LD R1, [R1, #POS_BOUND3_OFF];BOUND 3
    CMP R4, R1
    BLE LOAD_THIRD_POS_TABLE

    B LOAD_FOURTH_POS_TABLE



AFTER_LOADING_POS_TABLE:
    SUB R5, R4, R6;OFFSET
    ADD R3, R3, R5
    LD R1, [R3]

    LD R3, [R0, #COLOURS];Because we changed white we have to change it back
    LD R3, [R3, #WHITE_OFF]

    LD R5, [R0, #COLOURS]
    LD R5, [R5, #BLACK_OFF]

    CMP R1, R0

    BEQ SET_REGISTER_0

    BNE SET_REGISTER_1
    ;SET SOME REGISTER TO SHOW THAT THE VALUE IS EMPTY


SET_REGISTER_0:

    LD R1, [R0, #VARIABLES]
    LD R1, [R1, #VAR_UP1_OFF];UPBRANCH 1

    CMP R1, R2
    BEQ UPBRANC1TRAMPOLINE


    LD R1, [R0, #VARIABLES]
    LD R1, [R1, #VAR_UP2_OFF];UPBRANCH 3 (originally used offset 8 in code, which points to UPBRANCH2, but check logic for reuse)

    CMP R1, R2
    BEQ UPBRANC3TRAMPOLINE


    LD R1, [R0, #VARIABLES]
    LD R1, [R1, #VAR_LEFT1_OFF];LEFTBRANCH1

    CMP R1, R2
    BEQ LEFTBRANC1TRAMPOLINE
   

    LD R1, [R0, #VARIABLES]
    LD R1, [R1, #VAR_LEFT2_OFF];LEFTBRANCH 3 (originally offset 10, points to LEFTBRANCH2)

    CMP R1, R2
    BEQ LEFTBRANC3TRAMPOLINE


    LD R1, [R0, #VARIABLES]
    LD R1, [R1, #VAR_RIGHT1_OFF];RIGHTBRANCH 1

    CMP R1, R2
    BEQ RIGHTBRANC1TRAMPOLINE


    LD R1, [R0, #VARIABLES]
    LD R1, [R1, #VAR_RIGHT2_OFF];RIGHTBRANCH 2

    CMP R1, R2
    BEQ RIGHTBRANC3TRAMPOLINE


    LD R1, [R0, #VARIABLES]
    LD R1, [R1, #VAR_DOWN1_OFF];DOWNBRANCH1

    CMP R1, R2
    BEQ DOWNBRANC1TRAMPOLINE
   

    LD R1, [R0, #VARIABLES]
    LD R1, [R1, #VAR_DOWN2_OFF];DOWNBRANCH 3

    CMP R1, R2
    BEQ DOWNBRANC3TRAMPOLINE



SET_REGISTER_1:

    LD R1, [R0, #VARIABLES]
    LD R1, [R1, #VAR_UP1_OFF];UPBRANCH 2 (Note: original code checked offset #7 here, which is UPBRANCH1, likely meant for trampling check)

    CMP R1, R2
    BEQ UPBRANC2TRAMPOLINE

    LD R1, [R0, #VARIABLES]
    LD R1, [R1, #VAR_UP2_OFF]

    CMP R1, R2

    BEQ TRAMPOLINE;near current update


    LD R1, [R0, #VARIABLES]
    LD R1, [R1, #VAR_LEFT1_OFF];LEFTBRANCH2

    CMP R1, R2
    BEQ LEFTBRANC2TRAMPOLINE
   

    LD R1, [R0, #VARIABLES]
    LD R1, [R1, #VAR_LEFT2_OFF];near current update

    CMP R1, R2
    BEQ TRAMPOLINE


    LD R1, [R0, #VARIABLES]
    LD R1, [R1, #VAR_RIGHT1_OFF];RIGHTBRANCH 2

    CMP R1, R2
    BEQ RIGHTBRANC2TRAMPOLINE


    LD R1, [R0, #VARIABLES]
    LD R1, [R1, #VAR_RIGHT2_OFF];near

    CMP R1, R2
    BEQ TRAMPOLINE


    LD R1, [R0, #VARIABLES]
    LD R1, [R1, #VAR_DOWN1_OFF];DOWNBRANCH2

    CMP R1, R2
    BEQ DOWNBRANC2TRAMPOLINE
   

    LD R1, [R0, #VARIABLES]
    LD R1, [R1, #VAR_DOWN2_OFF];nearcurrent

    CMP R1, R2

    
    BEQ TRAMPOLINE
   

LOAD_FIRST_POS_TABLE:
    LD R3, [R0, #POSITION]
    LD R3, [R3, #POS_PTR1_OFF];POINTER

    LD R6, [R0, #POSITION];LOWER_BOUND1
    LD R6, [R6, #POS_LOWER1_OFF]

    B AFTER_LOADING_POS_TABLE


LOAD_SECOND_POS_TABLE:
    LD R3, [R0, #POSITION]
    LD R3, [R3, #POS_PTR2_OFF];POINTER TO POS16

    LD R6, [R0, #POSITION];LOWER_BOUND2
    LD R6, [R6, #POS_LOWER2_OFF]

    B AFTER_LOADING_POS_TABLE


LOAD_THIRD_POS_TABLE:
    LD R3, [R0, #POSITION]
    LD R3, [R3, #POS_PTR3_OFF];POINTER TO POS32

    LD R6, [R0, #POSITION];LOWER_BOUND3
    LD R6, [R6, #POS_LOWER3_OFF]
    B AFTER_LOADING_POS_TABLE


LOAD_FOURTH_POS_TABLE:
    LD R3, [R0, #POSITION]
    LD R3, [R3, #POS_PTR4_OFF];POINTER TO POS48

    LD R6, [R0, #POSITION];LOWER_BOUND4
    LD R6, [R6, #POS_LOWER4_OFF]

    B AFTER_LOADING_POS_TABLE



UPBRANC1TRAMPOLINE:
    LD R2, [R0, #BRANCH]
    LD R2, [R2, #BR_UP1_OFF]
    ADD R7, R2, R0
UPBRANC2TRAMPOLINE:
    LD R2, [R0, #BRANCH]
    LD R2, [R2, #BR_UP2_OFF]
    ADD R7, R2, R0
UPBRANC3TRAMPOLINE:
    LD R2, [R0, #BRANCH]
    LD R2, [R2, #BR_UP3_OFF]
    ADD R7, R2, R0
LEFTBRANC1TRAMPOLINE:
    LD R2, [R0, #BRANCH]
    LD R2, [R2, #BR_LEFT1_OFF]
    ADD R7, R2, R0
LEFTBRANC2TRAMPOLINE:
    LD R2, [R0, #BRANCH]
    LD R2, [R2, #BR_LEFT2_OFF]
    ADD R7, R2, R0
LEFTBRANC3TRAMPOLINE:
    LD R2, [R0, #BRANCH]
    LD R2, [R2, #BR_LEFT3_OFF]
    ADD R7, R2, R0
RIGHTBRANC1TRAMPOLINE:
    LD R2, [R0, #BRANCH]
    LD R2, [R2, #BR_RIGHT1_OFF]
    ADD R7, R2, R0
RIGHTBRANC2TRAMPOLINE:
    LD R2, [R0, #BRANCH]
    LD R2, [R2, #BR_RIGHT2_OFF]
    ADD R7, R2, R0
RIGHTBRANC3TRAMPOLINE:
    LD R2, [R0, #BRANCH]
    LD R2, [R2, #BR_RIGHT3_OFF]
    ADD R7, R2, R0
DOWNBRANC1TRAMPOLINE:
    LD R2, [R0, #BRANCH]
    LD R2, [R2, #BR_DOWN1_OFF]
    ADD R7, R2, R0
DOWNBRANC2TRAMPOLINE:
    LD R2, [R0, #BRANCH]
    LD R2, [R2, #BR_DOWN2_OFF]
    ADD R7, R2, R0
DOWNBRANC3TRAMPOLINE:
    LD R2, [R0, #BRANCH]
    LD R2, [R2, #BR_DOWN3_OFF]
    ADD R7, R2, R0

TRAMPOLINE:
    LD R2, [R0, #JUMPTABLE]
    LD R2, [R2, #JUMP_NEAR_OFF]
    ADD R7, R2, R0

