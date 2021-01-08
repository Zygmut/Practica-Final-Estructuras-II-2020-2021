AUDIOINIT
;   DES :   SAVES ALL AUDIO FILES TO SOUND MEMORY
;   IN  :   NONE
;   OUT :   NONE
;   MOD :   NONE
        MOVEM.L A0-A2/D0-D1, -(A7)

        LEA     AUDIOLIST, A0
        LEA     AUDIOIDS, A2
.LOOP   MOVE.L  (A0)+, D0
        BEQ     .END            ; END OF VECTOR
        MOVE.L  DO, A1
        MOVE.B  (A2)+, D1
        MOVE.B  #71, D0
        TRAP    #15
        BRA     .LOOP
.END    MOVE.B  #AUDIOACCY, (AUDIOACCSND)   ; ACTIVATE SOUNDS

        MOVEM.L +(A7), A0-A2/D0-D1
        RTS

PLAYONLYAUDIO
;   DES : PLAYS A GIVEN SOUND WITHOUT STOPING ALL OTHERS
;   IN  :  
;   OUT : 
;   MOD : 
        CMP.B   #AUDIOACCY, (AUDIOACCSND)
        BNE     .END

.END
        RTS

PLAYAUDIO

        RTS