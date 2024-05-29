MODULE Module1
    CONST robtarget home:=[[343.462801043,-250,93.857381617],[0.5,-0.5,0.5,-0.5],[1,0,1,4],[-101.964427132,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget cup_pickup:=[[540.889,-185.389,-50.822428403],[0.5,-0.5,0.5,-0.5],[1,0,1,4],[-101.964427132,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget cup_drop:=[[505,-15,-40],[0.653281482,-0.653281482,0.27059805,-0.27059805],[1,0,1,4],[-101.964427132,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget cup_dropOut:=[[455.502525303,-64.497474669,-40],[0.653281482,-0.653281482,0.27059805,-0.27059805],[1,0,1,4],[-101.964427132,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget lid:=[[452,-25,45],[0.5,-0.5,0.5,-0.5],[1,0,1,4],[-101.964427132,9E+09,9E+09,9E+09,9E+09,9E+09]];
    VAR bool CONST_CALIBRATION_SG_R := FALSE;
    
!***********************************************************    
    
    PROC main()
        !MoveAbsJ [[0,-130,30,0,40,0], [-135,9E9,9E9,9E9,9E9,9E9]]\NoEOffs, v50, fine, tool0;
        MoveJ home,v500,fine,Servo\WObj:=wobj0;
        
        IF CONST_CALIBRATION_SG_R = FALSE THEN
            g_Init \maxSpd:=10 \holdForce:=5 \Calibrate;
            g_MoveTo 18;
            
            CONST_CALIBRATION_SG_R := TRUE;
        ELSE
            g_MoveTo 18;
        ENDIF
        
        lid_open;
        SetDO DO_ROBR_DONE, 1;
        
        WaitDO DO_ROBL_DONE, 1;
        SetDO DO_ROBL_DONE, 0;
        cup_load;
        SetDO DO_ROBR_DONE, 1;
        
        WaitDO DO_ROBL_DONE, 1;
        SetDO DO_ROBL_DONE, 0;
        WaitTime 20;
        cup_unload;
        
        MoveJ home,v500,fine,Servo\WObj:=wobj0;
        Stop;
    ENDPROC
    
    PROC lid_open()
        g_MoveTo 4;
        MoveJ Offs(lid,0,0,0),v200,fine,Servo\WObj:=wobj0;
        MoveL Offs(lid,-25,0,50),v10,fine,Servo\WObj:=wobj0;
        MoveL home,v500,fine,Servo\WObj:=wobj0;
    ENDPROC
    
    PROC cup_load()
        g_MoveTo 18;
        MoveL Offs(cup_pickup,-70,0,0),v200,fine,Servo\WObj:=wobj0;
        MoveL Offs(cup_pickup,0,0,0),v100,fine,Servo\WObj:=wobj0;
        g_MoveTo 2;
        WaitTime 0.5;
        MoveL Offs(cup_pickup,0,0,50),v100,fine,Servo\WObj:=wobj0;
        MoveL Offs(cup_drop,0,0,10),v100,fine,Servo\WObj:=wobj0;

        MoveL Offs(cup_drop,0,0,-15),v80,fine,Servo\WObj:=wobj0;
        g_MoveTo 18;
        WaitTime 0.5;
        MoveL Offs(cup_dropOut,0,0,-15),v100,z10,Servo\WObj:=wobj0;
    ENDPROC
    
    PROC cup_unload()
        MoveL Offs(cup_dropOut,0,0,-15),v100,z10,Servo\WObj:=wobj0;
        g_MoveTo 18;
        WaitTime 0.5;
        MoveL Offs(cup_drop,0,0,-15),v100,fine,Servo\WObj:=wobj0;
        g_MoveTo 2;
        WaitTime 0.5;
        MoveL Offs(cup_drop,0,0,10),v80,fine,Servo\WObj:=wobj0;
        MoveL Offs(cup_pickup,0,0,50),v100,fine,Servo\WObj:=wobj0;
        MoveL Offs(cup_pickup,0,0,0),v50,fine,Servo\WObj:=wobj0;
        g_MoveTo 18;
        WaitTime 0.5;
        MoveL Offs(cup_pickup,-70,0,0),v200,fine,Servo\WObj:=wobj0;
    ENDPROC
    
ENDMODULE