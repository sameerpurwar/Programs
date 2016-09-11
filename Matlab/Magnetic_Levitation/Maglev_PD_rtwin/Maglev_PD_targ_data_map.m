  function targMap = targDataMap(),

  ;%***********************
  ;% Create Parameter Map *
  ;%***********************
      
    nTotData      = 0; %add to this count as we go
    nTotSects     = 3;
    sectIdxOffset = 0;
    
    ;%
    ;% Define dummy sections & preallocate arrays
    ;%
    dumSection.nData = -1;  
    dumSection.data  = [];
    
    dumData.logicalSrcIdx = -1;
    dumData.dtTransOffset = -1;
    
    ;%
    ;% Init/prealloc paramMap
    ;%
    paramMap.nSections           = nTotSects;
    paramMap.sectIdxOffset       = sectIdxOffset;
      paramMap.sections(nTotSects) = dumSection; %prealloc
    paramMap.nTotData            = -1;
    
    ;%
    ;% Auto data (Maglev_PD_P)
    ;%
      section.nData     = 27;
      section.data(27)  = dumData; %prealloc
      
	  ;% Maglev_PD_P.Constant_Value
	  section.data(1).logicalSrcIdx = 0;
	  section.data(1).dtTransOffset = 0;
	
	  ;% Maglev_PD_P.Step_Time
	  section.data(2).logicalSrcIdx = 1;
	  section.data(2).dtTransOffset = 1;
	
	  ;% Maglev_PD_P.Step_Y0
	  section.data(3).logicalSrcIdx = 2;
	  section.data(3).dtTransOffset = 2;
	
	  ;% Maglev_PD_P.Step_YFinal
	  section.data(4).logicalSrcIdx = 3;
	  section.data(4).dtTransOffset = 3;
	
	  ;% Maglev_PD_P.Sinus_Amplitude
	  section.data(5).logicalSrcIdx = 4;
	  section.data(5).dtTransOffset = 4;
	
	  ;% Maglev_PD_P.Sinus_Frequency
	  section.data(6).logicalSrcIdx = 5;
	  section.data(6).dtTransOffset = 5;
	
	  ;% Maglev_PD_P.Square_Amplitude
	  section.data(7).logicalSrcIdx = 6;
	  section.data(7).dtTransOffset = 6;
	
	  ;% Maglev_PD_P.Square_Frequency
	  section.data(8).logicalSrcIdx = 7;
	  section.data(8).dtTransOffset = 7;
	
	  ;% Maglev_PD_P.Constant_Value_d
	  section.data(9).logicalSrcIdx = 8;
	  section.data(9).dtTransOffset = 8;
	
	  ;% Maglev_PD_P.Gain_Gain
	  section.data(10).logicalSrcIdx = 9;
	  section.data(10).dtTransOffset = 9;
	
	  ;% Maglev_PD_P.Gain3_Gain
	  section.data(11).logicalSrcIdx = 10;
	  section.data(11).dtTransOffset = 10;
	
	  ;% Maglev_PD_P.DiscreteTransferFcn1_A
	  section.data(12).logicalSrcIdx = 11;
	  section.data(12).dtTransOffset = 11;
	
	  ;% Maglev_PD_P.DiscreteTransferFcn1_C
	  section.data(13).logicalSrcIdx = 12;
	  section.data(13).dtTransOffset = 12;
	
	  ;% Maglev_PD_P.DiscreteTransferFcn1_D
	  section.data(14).logicalSrcIdx = 13;
	  section.data(14).dtTransOffset = 13;
	
	  ;% Maglev_PD_P.Gain1_Gain
	  section.data(15).logicalSrcIdx = 15;
	  section.data(15).dtTransOffset = 14;
	
	  ;% Maglev_PD_P.DiscreteTransferFcn_A
	  section.data(16).logicalSrcIdx = 16;
	  section.data(16).dtTransOffset = 15;
	
	  ;% Maglev_PD_P.DiscreteTransferFcn_C
	  section.data(17).logicalSrcIdx = 17;
	  section.data(17).dtTransOffset = 16;
	
	  ;% Maglev_PD_P.DiscreteTransferFcn_D
	  section.data(18).logicalSrcIdx = 18;
	  section.data(18).dtTransOffset = 17;
	
	  ;% Maglev_PD_P.Gain2_Gain
	  section.data(19).logicalSrcIdx = 20;
	  section.data(19).dtTransOffset = 18;
	
	  ;% Maglev_PD_P.Saturation_UpperSat
	  section.data(20).logicalSrcIdx = 21;
	  section.data(20).dtTransOffset = 19;
	
	  ;% Maglev_PD_P.Saturation_LowerSat
	  section.data(21).logicalSrcIdx = 22;
	  section.data(21).dtTransOffset = 20;
	
	  ;% Maglev_PD_P.AnalogOutput_InitialValue
	  section.data(22).logicalSrcIdx = 23;
	  section.data(22).dtTransOffset = 21;
	
	  ;% Maglev_PD_P.AnalogOutput_FinalValue
	  section.data(23).logicalSrcIdx = 24;
	  section.data(23).dtTransOffset = 22;
	
	  ;% Maglev_PD_P.Gain2_Gain_m
	  section.data(24).logicalSrcIdx = 25;
	  section.data(24).dtTransOffset = 23;
	
	  ;% Maglev_PD_P.Constant1_Value
	  section.data(25).logicalSrcIdx = 26;
	  section.data(25).dtTransOffset = 24;
	
	  ;% Maglev_PD_P.Gain2_Gain_n
	  section.data(26).logicalSrcIdx = 27;
	  section.data(26).dtTransOffset = 25;
	
	  ;% Maglev_PD_P.Constant1_Value_d
	  section.data(27).logicalSrcIdx = 28;
	  section.data(27).dtTransOffset = 26;
	
      nTotData = nTotData + section.nData;
      paramMap.sections(1) = section;
      clear section
      
      section.nData     = 6;
      section.data(6)  = dumData; %prealloc
      
	  ;% Maglev_PD_P.AnalogInput_Channels
	  section.data(1).logicalSrcIdx = 29;
	  section.data(1).dtTransOffset = 0;
	
	  ;% Maglev_PD_P.AnalogInput_RangeMode
	  section.data(2).logicalSrcIdx = 30;
	  section.data(2).dtTransOffset = 1;
	
	  ;% Maglev_PD_P.AnalogInput_VoltRange
	  section.data(3).logicalSrcIdx = 31;
	  section.data(3).dtTransOffset = 2;
	
	  ;% Maglev_PD_P.AnalogOutput_Channels
	  section.data(4).logicalSrcIdx = 32;
	  section.data(4).dtTransOffset = 3;
	
	  ;% Maglev_PD_P.AnalogOutput_RangeMode
	  section.data(5).logicalSrcIdx = 33;
	  section.data(5).dtTransOffset = 4;
	
	  ;% Maglev_PD_P.AnalogOutput_VoltRange
	  section.data(6).logicalSrcIdx = 34;
	  section.data(6).dtTransOffset = 5;
	
      nTotData = nTotData + section.nData;
      paramMap.sections(2) = section;
      clear section
      
      section.nData     = 4;
      section.data(4)  = dumData; %prealloc
      
	  ;% Maglev_PD_P.Constant_Value_b
	  section.data(1).logicalSrcIdx = 35;
	  section.data(1).dtTransOffset = 0;
	
	  ;% Maglev_PD_P.Constant_Value_p
	  section.data(2).logicalSrcIdx = 36;
	  section.data(2).dtTransOffset = 1;
	
	  ;% Maglev_PD_P.SwitchControl_Threshold
	  section.data(3).logicalSrcIdx = 37;
	  section.data(3).dtTransOffset = 2;
	
	  ;% Maglev_PD_P.SwitchControl_Threshold_a
	  section.data(4).logicalSrcIdx = 38;
	  section.data(4).dtTransOffset = 3;
	
      nTotData = nTotData + section.nData;
      paramMap.sections(3) = section;
      clear section
      
    
      ;%
      ;% Non-auto Data (parameter)
      ;%
    

    ;%
    ;% Add final counts to struct.
    ;%
    paramMap.nTotData = nTotData;
    


  ;%**************************
  ;% Create Block Output Map *
  ;%**************************
      
    nTotData      = 0; %add to this count as we go
    nTotSects     = 1;
    sectIdxOffset = 0;
    
    ;%
    ;% Define dummy sections & preallocate arrays
    ;%
    dumSection.nData = -1;  
    dumSection.data  = [];
    
    dumData.logicalSrcIdx = -1;
    dumData.dtTransOffset = -1;
    
    ;%
    ;% Init/prealloc sigMap
    ;%
    sigMap.nSections           = nTotSects;
    sigMap.sectIdxOffset       = sectIdxOffset;
      sigMap.sections(nTotSects) = dumSection; %prealloc
    sigMap.nTotData            = -1;
    
    ;%
    ;% Auto data (Maglev_PD_B)
    ;%
      section.nData     = 9;
      section.data(9)  = dumData; %prealloc
      
	  ;% Maglev_PD_B.AnalogInput
	  section.data(1).logicalSrcIdx = 0;
	  section.data(1).dtTransOffset = 0;
	
	  ;% Maglev_PD_B.SwitchControl
	  section.data(2).logicalSrcIdx = 1;
	  section.data(2).dtTransOffset = 1;
	
	  ;% Maglev_PD_B.Sum1
	  section.data(3).logicalSrcIdx = 2;
	  section.data(3).dtTransOffset = 2;
	
	  ;% Maglev_PD_B.Gain3
	  section.data(4).logicalSrcIdx = 3;
	  section.data(4).dtTransOffset = 3;
	
	  ;% Maglev_PD_B.Gain1
	  section.data(5).logicalSrcIdx = 4;
	  section.data(5).dtTransOffset = 4;
	
	  ;% Maglev_PD_B.Gain2
	  section.data(6).logicalSrcIdx = 5;
	  section.data(6).dtTransOffset = 5;
	
	  ;% Maglev_PD_B.Clock
	  section.data(7).logicalSrcIdx = 6;
	  section.data(7).dtTransOffset = 6;
	
	  ;% Maglev_PD_B.Sum1_f
	  section.data(8).logicalSrcIdx = 7;
	  section.data(8).dtTransOffset = 7;
	
	  ;% Maglev_PD_B.Sum1_p
	  section.data(9).logicalSrcIdx = 8;
	  section.data(9).dtTransOffset = 8;
	
      nTotData = nTotData + section.nData;
      sigMap.sections(1) = section;
      clear section
      
    
      ;%
      ;% Non-auto Data (signal)
      ;%
    

    ;%
    ;% Add final counts to struct.
    ;%
    sigMap.nTotData = nTotData;
    


  ;%*******************
  ;% Create DWork Map *
  ;%*******************
      
    nTotData      = 0; %add to this count as we go
    nTotSects     = 2;
    sectIdxOffset = 1;
    
    ;%
    ;% Define dummy sections & preallocate arrays
    ;%
    dumSection.nData = -1;  
    dumSection.data  = [];
    
    dumData.logicalSrcIdx = -1;
    dumData.dtTransOffset = -1;
    
    ;%
    ;% Init/prealloc dworkMap
    ;%
    dworkMap.nSections           = nTotSects;
    dworkMap.sectIdxOffset       = sectIdxOffset;
      dworkMap.sections(nTotSects) = dumSection; %prealloc
    dworkMap.nTotData            = -1;
    
    ;%
    ;% Auto data (Maglev_PD_DWork)
    ;%
      section.nData     = 2;
      section.data(2)  = dumData; %prealloc
      
	  ;% Maglev_PD_DWork.DiscreteTransferFcn1_DSTATE
	  section.data(1).logicalSrcIdx = 0;
	  section.data(1).dtTransOffset = 0;
	
	  ;% Maglev_PD_DWork.DiscreteTransferFcn_DSTATE
	  section.data(2).logicalSrcIdx = 1;
	  section.data(2).dtTransOffset = 1;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(1) = section;
      clear section
      
      section.nData     = 5;
      section.data(5)  = dumData; %prealloc
      
	  ;% Maglev_PD_DWork.ToWorkspace1_PWORK.LoggedData
	  section.data(1).logicalSrcIdx = 2;
	  section.data(1).dtTransOffset = 0;
	
	  ;% Maglev_PD_DWork.Signalscope_PWORK.LoggedData
	  section.data(2).logicalSrcIdx = 3;
	  section.data(2).dtTransOffset = 1;
	
	  ;% Maglev_PD_DWork.Signalscope1_PWORK.LoggedData
	  section.data(3).logicalSrcIdx = 4;
	  section.data(3).dtTransOffset = 2;
	
	  ;% Maglev_PD_DWork.ToWorkspace_PWORK.LoggedData
	  section.data(4).logicalSrcIdx = 5;
	  section.data(4).dtTransOffset = 3;
	
	  ;% Maglev_PD_DWork.ToWorkspace2_PWORK.LoggedData
	  section.data(5).logicalSrcIdx = 6;
	  section.data(5).dtTransOffset = 4;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(2) = section;
      clear section
      
    
      ;%
      ;% Non-auto Data (dwork)
      ;%
    

    ;%
    ;% Add final counts to struct.
    ;%
    dworkMap.nTotData = nTotData;
    


  ;%
  ;% Add individual maps to base struct.
  ;%

  targMap.paramMap  = paramMap;    
  targMap.signalMap = sigMap;
  targMap.dworkMap  = dworkMap;
  
  ;%
  ;% Add checksums to base struct.
  ;%


  targMap.checksum0 = 2405431628;
  targMap.checksum1 = 4276893873;
  targMap.checksum2 = 2115234442;
  targMap.checksum3 = 4197356474;

