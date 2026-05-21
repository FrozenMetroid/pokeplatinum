#include "macros/btlcmd.inc"


_000:
    PrintAttackMessage
    Wait
    WaitButtonABTime 30
    // But it failed!
    PrintMessage BattleStrings_Text_ButItFailed, TAG_NONE
    Wait 
    WaitButtonABTime 30
    // the following line shouldn't be needed because the same effect happens before this subscript starts
    // UpdateVar OPCODE_FLAG_ON, BTLVAR_MOVE_STATUS_FLAGS, MOVE_STATUS_NO_MORE_WORK
    End 
