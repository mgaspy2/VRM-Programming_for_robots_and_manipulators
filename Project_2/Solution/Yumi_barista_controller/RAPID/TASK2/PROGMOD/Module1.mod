MODULE Module1 
    CONST robtarget home:=[[259.652363007,267.424842662,45.814803016],[-0.000000148,0.000000042,1,0.00000012],[-1,0,-2,4],[102.439085026,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget drawer_pickup:=[[445.014694932,0.14816124,93.168280464],[0.000000052,0.707106862,-0.000000139,0.707106701],[-1,1,-1,5],[101.964431479,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget drawer_drop:=[[525,178.590241378,35],[0.000000052,0.707106862,-0.000000139,0.707106701],[-1,2,-2,5],[101.964431479,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget capsule_pickup:=[[496.025,339.11995587,-39.380539821],[0,0,0.996298575,0.085960157],[-1,0,-2,4],[101.964427132,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget capsule_drop:=[[574.674,176.59,-27.99],[0,0,1,0],[-1,0,-2,4],[101.964431565,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget capsule_unload:=[[544.904952794,333.227817091,100.168280464],[0.000000052,0.707106862,-0.000000139,0.707106701],[-1,1,-1,5],[101.964431479,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget capsule_unloadDown:=[[544.904952794,333.227817091,100.168280464],[0.707106701,0.000000139,0.707106862,0.000000052],[-1,1,-1,5],[101.964431479,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget button:=[[475,-14.965023083,158.503],[0.707106781,0,0.707106781,0],[-1,-1,-1,4],[101.964431802,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget lid_close:=[[411.900622949,6.12,183.241520144],[0.270598051,0.653281482,0.653281482,0.270598051],[0,0,0,0],[110.755976877,9E+09,9E+09,9E+09,9E+09,9E+09]];
    VAR bool CONST_CALIBRATION_SG_L := FALSE;
    
!***********************************************************
    
    PROC main()
        !MoveAbsJ [[0,-130,30,0,40,0],[135,9E9,9E9,9E9,9E9,9E9]] \NoEOffs, v50, fine, tool0;
        MoveJ home,v200,fine,VaccumOne\WObj:=wobj0;
        SetDO DO_ROBL_DONE, 0;
        SetDO DO_ROBR_DONE, 0;
        
        IF CONST_CALIBRATION_SG_L = FALSE THEN
            g_Init \maxSpd:=10 \holdForce:=3 \Calibrate;
            g_MoveTo 10;
            
            CONST_CALIBRATION_SG_L := TRUE;
        ELSE
            g_MoveTo 10;
        ENDIF
        
        WaitDO DO_ROBR_DONE, 1;
        SetDO DO_ROBR_DONE, 0;
        drawer_removal;
        capsule_load_cool;
        drawer_insert;
        SetDO DO_ROBL_DONE, 1;
        MoveJ home,v200,fine,VaccumOne\WObj:=wobj0;
        
        WaitDO DO_ROBR_DONE, 1;
        SetDO DO_ROBR_DONE, 0;
        button_push;
        SetDO DO_ROBL_DONE, 1;
        
        MoveJ home,v200,fine,VaccumOne\WObj:=wobj0;
        Stop;

    ENDPROC
    
    PROC drawer_removal()
        MoveJ drawer_pickup,v500,fine,Servo\WObj:=wobj0;
        MoveL Offs(drawer_pickup,43,0,0),v100,fine,Servo\WObj:=wobj0;
        g_GripIn;
        WaitTime 0.25;
        MoveL Offs(drawer_pickup,-43,0,0),v100,fine,Servo\WObj:=wobj0;
        MoveL Offs(drawer_pickup,-43,100,0),v200,z100,Servo\WObj:=wobj0;
        
        MoveL Offs(capsule_unload,0,0,0),v200,z100,Servo\WObj:=wobj0;
        MoveL Offs(capsule_unloadDown,0,0,0),v200,z100,Servo\WObj:=wobj0;
        
        MoveL Offs(drawer_drop,0,0,0),v100,z10,Servo\WObj:=wobj0;
        MoveL Offs(drawer_drop,0,0,-42),v50,fine,Servo\WObj:=wobj0;
        WaitTime 0.25;
        g_GripOut;
        MoveL Offs(drawer_drop,0,0,-50),v10,fine,Servo\WObj:=wobj0;
        MoveL Offs(drawer_drop,-60,0,-10),v100,z50,Servo\WObj:=wobj0;
    ENDPROC
        
    PROC drawer_insert()
        MoveL Offs(capsule_drop,-150,0,150),v100,z50,VaccumOne\WObj:=wobj0;
        
        MoveJ Offs(drawer_drop,-60,0,-50),v200,fine,Servo\WObj:=wobj0;
        MoveL Offs(drawer_drop,0,0,-50),v50,fine,Servo\WObj:=wobj0;
        MoveL Offs(drawer_drop,0,0,-42),v50,fine,Servo\WObj:=wobj0;
        g_GripIn;
        MoveL Offs(drawer_drop,0,0,0),v50,fine,Servo\WObj:=wobj0;
        MoveL Offs(drawer_pickup,-43,100,13),v100,z50,Servo\WObj:=wobj0;
        MoveL Offs(drawer_pickup,-43,0,13),v100,fine,Servo\WObj:=wobj0;
        MoveL Offs(drawer_pickup,14,2,10),v50,fine,Servo\WObj:=wobj0;
        WaitTime 0.5;
        g_MoveTo 10;
        MoveL Offs(drawer_pickup,33,2,10),v50,fine,Servo\WObj:=wobj0;
        MoveL Offs(drawer_pickup,33,2,5),v50,fine,Servo\WObj:=wobj0;
        MoveL Offs(drawer_pickup,12,2,2),v50,fine,Servo\WObj:=wobj0;
        g_MoveTo 0;
        MoveL Offs(drawer_pickup,33,2,2),v50,fine,Servo\WObj:=wobj0;
        MoveL Offs(drawer_pickup,-10,0,0),v50,fine,Servo\WObj:=wobj0;
        MoveL Offs(drawer_pickup,-10,0,150),v50,z10,Servo\WObj:=wobj0;
        MoveL Offs(drawer_pickup,85,0,150),v50,z50,Servo\WObj:=wobj0;
        
        MotionSup\Off;
        MoveL Offs(drawer_pickup,70,0,85),v50,fine,Servo\WObj:=wobj0;  
        MotionSup\On;
        
        MoveL Offs(drawer_pickup,-10,0,150),v100,z10,Servo\WObj:=wobj0;
    ENDPROC
    
    PROC capsule_load_cool()
        MoveJ Offs(capsule_pickup,0,0,60),v200,fine,VaccumOne\WObj:=wobj0;
        MoveL Offs(capsule_pickup,0,0,-4),v50,fine,VaccumOne\WObj:=wobj0;
        
        g_VacuumOn1;
        WaitTime 1;
        
        MoveL Offs(capsule_pickup,0,0,100),v100,z50,VaccumOne\WObj:=wobj0;
        
        MoveL Offs(capsule_drop,0,0,100),v100,fine,VaccumOne\WObj:=wobj0;
        
        WaitTime 2;
        g_VacuumOff1;
    ENDPROC
    
    PROC button_push()
        g_MoveTo 0;
        MoveJ Offs(button,0,0,3),v100,fine,Servo\WObj:=wobj0;
        MoveL Offs(button,20,0,-1),v10,fine,Servo\WObj:=wobj0;
        WaitTime 1;
        MoveL Offs(button,0,0,-1),v100,fine,Servo\WObj:=wobj0;
    ENDPROC
    
ENDMODULE