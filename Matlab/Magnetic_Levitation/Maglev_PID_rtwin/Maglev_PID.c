/*
 * Maglev_PID.c
 *
 * Real-Time Workshop code generation for Simulink model "Maglev_PID.mdl".
 *
 * Model Version              : 1.246
 * Real-Time Workshop version : 7.1  (R2008a)  23-Jan-2008
 * C source code generated on : Fri Sep 02 16:58:24 2016
 */

#include "Maglev_PID.h"
#include "Maglev_PID_private.h"
#include <stdio.h>
#include "Maglev_PID_dt.h"

/* list of Real-Time Windows Target boards */
const int RTWinBoardCount = 1;
RTWINBOARD RTWinBoards[1] = {
  { "Advantech/PCI-1711", 4294967295U, 0, NULL },
};

/* Block signals (auto storage) */
BlockIO_Maglev_PID Maglev_PID_B;

/* Block states (auto storage) */
D_Work_Maglev_PID Maglev_PID_DWork;

/* Real-time model */
RT_MODEL_Maglev_PID Maglev_PID_M_;
RT_MODEL_Maglev_PID *Maglev_PID_M = &Maglev_PID_M_;
static void rate_scheduler(void);

/*
 * This function updates active task flag for each subrate.
 * The function must be is called at model base rate, hence the
 * generated code self-manages all its subrates.
 */
static void rate_scheduler(void)
{
  /* Compute which subrates run during the next base time step.  Subrates
   * are an integer multiple of the base rate counter.  Therefore, the subtask
   * counter is reset when it reaches its limit (zero means run).
   */
  if (++Maglev_PID_M->Timing.TaskCounters.TID[2] == 10) {/* Sample time: [0.01s, 0.0s] */
    Maglev_PID_M->Timing.TaskCounters.TID[2] = 0;
  }

  Maglev_PID_M->Timing.sampleHits[2] = (Maglev_PID_M->Timing.TaskCounters.TID[2]
    == 0);
}

/* Model output function */
void Maglev_PID_output(int_T tid)
{
  /* local block i/o variables */
  real_T rtb_Sinus;
  real_T rtb_Square;
  real_T rtb_DiscreteTransferFcn;
  real_T rtb_Product;
  real_T rtb_Product1;
  real_T rtb_Saturation;

  {
    real_T currentTime;

    /* S-Function Block: <S3>/Analog Input */
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE) Maglev_PID_P.AnalogInput_RangeMode;
      parm.rangeidx = Maglev_PID_P.AnalogInput_VoltRange;
      RTBIO_DriverIO(0, ANALOGINPUT, IOREAD, 1,
                     &Maglev_PID_P.AnalogInput_Channels,
                     &Maglev_PID_B.AnalogInput, &parm);
    }

    /* Step: '<Root>/Step' */
    currentTime = Maglev_PID_M->Timing.t[0];
    if (currentTime < Maglev_PID_P.Step_Time) {
      rtb_Product1 = Maglev_PID_P.Step_Y0;
    } else {
      rtb_Product1 = Maglev_PID_P.Step_YFinal;
    }

    /* SignalGenerator: '<Root>/Sinus' */
    {
      real_T sin2PiFT = sin(6.2831853071795862E+000*Maglev_PID_P.Sinus_Frequency*
                            Maglev_PID_M->Timing.t[0]);
      rtb_Sinus = Maglev_PID_P.Sinus_Amplitude*sin2PiFT;
    }

    /* SignalGenerator: '<Root>/Square' */
    {
      real_T phase = Maglev_PID_P.Square_Frequency*Maglev_PID_M->Timing.t[0];
      phase = phase-floor(phase);
      rtb_Square = ( phase >= 0.5 ) ?
        Maglev_PID_P.Square_Amplitude : -Maglev_PID_P.Square_Amplitude;
    }

    /* Switch: '<S5>/SwitchControl' incorporates:
     *  Constant: '<Root>/Constant'
     *  Constant: '<S5>/Constant'
     *  Sum: '<Root>/Sum'
     */
    if (Maglev_PID_P.Constant_Value_l > Maglev_PID_P.SwitchControl_Threshold) {
      Maglev_PID_B.SwitchControl = rtb_Product1;
    } else {
      /* Switch: '<S6>/SwitchControl' incorporates:
       *  Constant: '<S6>/Constant'
       */
      if (Maglev_PID_P.Constant_Value_k > Maglev_PID_P.SwitchControl_Threshold_k)
      {
        currentTime = rtb_Sinus;
      } else {
        currentTime = rtb_Square;
      }

      Maglev_PID_B.SwitchControl = currentTime + Maglev_PID_P.Constant_Value_m;
    }

    /* Sum: '<Root>/Sum1' */
    Maglev_PID_B.Sum1 = Maglev_PID_B.SwitchControl - Maglev_PID_B.AnalogInput;

    /* Gain: '<S7>/Gain' */
    currentTime = Maglev_PID_P.Gain_Gain * Maglev_PID_B.Sum1;

    /* Gain: '<S7>/Gain1' */
    Maglev_PID_B.Gain1 = Maglev_PID_P.Gain1_Gain * Maglev_PID_B.Sum1;

    /* DiscreteTransferFcn: '<S7>/Discrete Transfer Fcn' */
    rtb_DiscreteTransferFcn = Maglev_PID_P.DiscreteTransferFcn_D*
      Maglev_PID_B.Gain1;
    rtb_DiscreteTransferFcn += Maglev_PID_P.DiscreteTransferFcn_C*
      Maglev_PID_DWork.DiscreteTransferFcn_DSTATE;

    /* Clock: '<S7>/Clock' */
    rtb_Product1 = Maglev_PID_M->Timing.t[0];

    /* Product: '<S8>/Product' incorporates:
     *  Constant: '<S8>/qpp1'
     *  Constant: '<S9>/Constant'
     *  RelationalOperator: '<S9>/Compare'
     */
    rtb_Product = rtb_Product1 <= Maglev_PID_P.Constant_Value_c ?
      Maglev_PID_P.qpp1_Value : 0.0;

    /* Product: '<S8>/Product1' incorporates:
     *  Constant: '<S10>/Constant'
     *  RelationalOperator: '<S10>/Compare'
     */
    rtb_Product1 = rtb_Product1 > Maglev_PID_P.Constant_Value_mr ?
      Maglev_PID_B.Sum1 : 0.0;

    /* Sum: '<S8>/Sum1' */
    Maglev_PID_B.Sum1_h = rtb_Product + rtb_Product1;

    /* Gain: '<S7>/Gain3' */
    Maglev_PID_B.Gain3 = Maglev_PID_P.Gain3_Gain * Maglev_PID_B.Sum1_h;

    /* DiscreteTransferFcn: '<S7>/Discrete Transfer Fcn1' */
    rtb_Saturation = Maglev_PID_P.DiscreteTransferFcn1_D*Maglev_PID_B.Gain3;
    rtb_Saturation += Maglev_PID_P.DiscreteTransferFcn1_C*
      Maglev_PID_DWork.DiscreteTransferFcn1_DSTATE;

    /* Gain: '<S7>/Gain2' incorporates:
     *  Sum: '<S7>/Sum'
     */
    Maglev_PID_B.Gain2 = ((currentTime + rtb_DiscreteTransferFcn) +
                          rtb_Saturation) * Maglev_PID_P.Gain2_Gain;

    /* Sum: '<S4>/Add' incorporates:
     *  Constant: '<S4>/Constant'
     */
    rtb_Saturation = Maglev_PID_P.Constant_Value + Maglev_PID_B.Gain2;

    /* Saturate: '<S4>/Saturation' */
    rtb_Saturation = rt_SATURATE(rtb_Saturation,
      Maglev_PID_P.Saturation_LowerSat, Maglev_PID_P.Saturation_UpperSat);

    /* S-Function Block: <S4>/Analog Output */
    {
      {
        ANALOGIOPARM parm;
        parm.mode = (RANGEMODE) Maglev_PID_P.AnalogOutput_RangeMode;
        parm.rangeidx = Maglev_PID_P.AnalogOutput_VoltRange;
        RTBIO_DriverIO(0, ANALOGOUTPUT, IOWRITE, 1,
                       &Maglev_PID_P.AnalogOutput_Channels, &rtb_Saturation,
                       &parm);
      }
    }

    /* Clock: '<Root>/Clock' */
    Maglev_PID_B.Clock = Maglev_PID_M->Timing.t[0];
    if (Maglev_PID_M->Timing.TaskCounters.TID[2] == 0) {
    }

    /* Sum: '<S1>/Sum1' incorporates:
     *  Constant: '<S1>/Constant1'
     *  Gain: '<S1>/Gain2'
     */
    Maglev_PID_B.Sum1_b = Maglev_PID_P.Gain2_Gain_o * Maglev_PID_B.SwitchControl
      + Maglev_PID_P.Constant1_Value;

    /* Sum: '<S2>/Sum1' incorporates:
     *  Constant: '<S2>/Constant1'
     *  Gain: '<S2>/Gain2'
     */
    Maglev_PID_B.Sum1_a = Maglev_PID_P.Gain2_Gain_i * Maglev_PID_B.AnalogInput +
      Maglev_PID_P.Constant1_Value_i;
    if (Maglev_PID_M->Timing.TaskCounters.TID[2] == 0) {
    }
  }

  UNUSED_PARAMETER(tid);
}

/* Model update function */
void Maglev_PID_update(int_T tid)
{
  /* DiscreteTransferFcn Block: '<S7>/Discrete Transfer Fcn' */
  {
    Maglev_PID_DWork.DiscreteTransferFcn_DSTATE = Maglev_PID_B.Gain1 +
      (Maglev_PID_P.DiscreteTransferFcn_A)*
      Maglev_PID_DWork.DiscreteTransferFcn_DSTATE;
  }

  /* DiscreteTransferFcn Block: '<S7>/Discrete Transfer Fcn1' */
  {
    Maglev_PID_DWork.DiscreteTransferFcn1_DSTATE = Maglev_PID_B.Gain3 +
      Maglev_PID_P.DiscreteTransferFcn1_A*
      Maglev_PID_DWork.DiscreteTransferFcn1_DSTATE;
  }

  /* Update absolute time for base rate */
  if (!(++Maglev_PID_M->Timing.clockTick0))
    ++Maglev_PID_M->Timing.clockTickH0;
  Maglev_PID_M->Timing.t[0] = Maglev_PID_M->Timing.clockTick0 *
    Maglev_PID_M->Timing.stepSize0 + Maglev_PID_M->Timing.clockTickH0 *
    Maglev_PID_M->Timing.stepSize0 * 4294967296.0;

  {
    /* Update absolute timer for sample time: [0.001s, 0.0s] */
    if (!(++Maglev_PID_M->Timing.clockTick1))
      ++Maglev_PID_M->Timing.clockTickH1;
    Maglev_PID_M->Timing.t[1] = Maglev_PID_M->Timing.clockTick1 *
      Maglev_PID_M->Timing.stepSize1 + Maglev_PID_M->Timing.clockTickH1 *
      Maglev_PID_M->Timing.stepSize1 * 4294967296.0;
  }

  if (Maglev_PID_M->Timing.TaskCounters.TID[2] == 0) {
    /* Update absolute timer for sample time: [0.01s, 0.0s] */
    if (!(++Maglev_PID_M->Timing.clockTick2))
      ++Maglev_PID_M->Timing.clockTickH2;
    Maglev_PID_M->Timing.t[2] = Maglev_PID_M->Timing.clockTick2 *
      Maglev_PID_M->Timing.stepSize2 + Maglev_PID_M->Timing.clockTickH2 *
      Maglev_PID_M->Timing.stepSize2 * 4294967296.0;
  }

  rate_scheduler();
  UNUSED_PARAMETER(tid);
}

/* Model initialize function */
void Maglev_PID_initialize(boolean_T firstTime)
{
  (void)firstTime;

  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* initialize real-time model */
  (void) memset((char_T *)Maglev_PID_M,0,
                sizeof(RT_MODEL_Maglev_PID));

  {
    /* Setup solver object */
    rtsiSetSimTimeStepPtr(&Maglev_PID_M->solverInfo,
                          &Maglev_PID_M->Timing.simTimeStep);
    rtsiSetTPtr(&Maglev_PID_M->solverInfo, &rtmGetTPtr(Maglev_PID_M));
    rtsiSetStepSizePtr(&Maglev_PID_M->solverInfo,
                       &Maglev_PID_M->Timing.stepSize0);
    rtsiSetErrorStatusPtr(&Maglev_PID_M->solverInfo, (&rtmGetErrorStatus
      (Maglev_PID_M)));
    rtsiSetRTModelPtr(&Maglev_PID_M->solverInfo, Maglev_PID_M);
  }

  rtsiSetSimTimeStep(&Maglev_PID_M->solverInfo, MAJOR_TIME_STEP);
  rtsiSetSolverName(&Maglev_PID_M->solverInfo,"FixedStepDiscrete");

  /* Initialize timing info */
  {
    int_T *mdlTsMap = Maglev_PID_M->Timing.sampleTimeTaskIDArray;
    mdlTsMap[0] = 0;
    mdlTsMap[1] = 1;
    mdlTsMap[2] = 2;
    Maglev_PID_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
    Maglev_PID_M->Timing.sampleTimes = (&Maglev_PID_M->Timing.sampleTimesArray[0]);
    Maglev_PID_M->Timing.offsetTimes = (&Maglev_PID_M->Timing.offsetTimesArray[0]);

    /* task periods */
    Maglev_PID_M->Timing.sampleTimes[0] = (0.0);
    Maglev_PID_M->Timing.sampleTimes[1] = (0.001);
    Maglev_PID_M->Timing.sampleTimes[2] = (0.01);

    /* task offsets */
    Maglev_PID_M->Timing.offsetTimes[0] = (0.0);
    Maglev_PID_M->Timing.offsetTimes[1] = (0.0);
    Maglev_PID_M->Timing.offsetTimes[2] = (0.0);
  }

  rtmSetTPtr(Maglev_PID_M, &Maglev_PID_M->Timing.tArray[0]);

  {
    int_T *mdlSampleHits = Maglev_PID_M->Timing.sampleHitArray;
    mdlSampleHits[0] = 1;
    mdlSampleHits[1] = 1;
    mdlSampleHits[2] = 1;
    Maglev_PID_M->Timing.sampleHits = (&mdlSampleHits[0]);
  }

  rtmSetTFinal(Maglev_PID_M, 100.0);
  Maglev_PID_M->Timing.stepSize0 = 0.001;
  Maglev_PID_M->Timing.stepSize1 = 0.001;
  Maglev_PID_M->Timing.stepSize2 = 0.01;

  /* external mode info */
  Maglev_PID_M->Sizes.checksums[0] = (286701852U);
  Maglev_PID_M->Sizes.checksums[1] = (2737657646U);
  Maglev_PID_M->Sizes.checksums[2] = (639832223U);
  Maglev_PID_M->Sizes.checksums[3] = (3591947185U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[2];
    Maglev_PID_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    systemRan[1] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(&rt_ExtModeInfo,
      &Maglev_PID_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(&rt_ExtModeInfo, Maglev_PID_M->Sizes.checksums);
    rteiSetTPtr(&rt_ExtModeInfo, rtmGetTPtr(Maglev_PID_M));
  }

  Maglev_PID_M->solverInfoPtr = (&Maglev_PID_M->solverInfo);
  Maglev_PID_M->Timing.stepSize = (0.001);
  rtsiSetFixedStepSize(&Maglev_PID_M->solverInfo, 0.001);
  rtsiSetSolverMode(&Maglev_PID_M->solverInfo, SOLVER_MODE_SINGLETASKING);

  /* block I/O */
  Maglev_PID_M->ModelData.blockIO = ((void *) &Maglev_PID_B);

  {
    int_T i;
    void *pVoidBlockIORegion;
    pVoidBlockIORegion = (void *)(&Maglev_PID_B.AnalogInput);
    for (i = 0; i < 10; i++) {
      ((real_T*)pVoidBlockIORegion)[i] = 0.0;
    }
  }

  /* parameters */
  Maglev_PID_M->ModelData.defaultParam = ((real_T *) &Maglev_PID_P);

  /* states (dwork) */
  Maglev_PID_M->Work.dwork = ((void *) &Maglev_PID_DWork);
  (void) memset((char_T *) &Maglev_PID_DWork,0,
                sizeof(D_Work_Maglev_PID));

  {
    real_T *dwork_ptr = (real_T *) &Maglev_PID_DWork.DiscreteTransferFcn_DSTATE;
    dwork_ptr[0] = 0.0;
    dwork_ptr[1] = 0.0;
  }

  /* data type transition information */
  {
    static DataTypeTransInfo dtInfo;
    (void) memset((char_T *) &dtInfo,0,
                  sizeof(dtInfo));
    Maglev_PID_M->SpecialInfo.mappingInfo = (&dtInfo);
    dtInfo.numDataTypes = 14;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    /* Block I/O transition table */
    dtInfo.B = &rtBTransTable;

    /* Parameters transition table */
    dtInfo.P = &rtPTransTable;
  }
}

/* Model terminate function */
void Maglev_PID_terminate(void)
{
  /* S-Function Block: <S4>/Analog Output */
  {
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE) Maglev_PID_P.AnalogOutput_RangeMode;
      parm.rangeidx = Maglev_PID_P.AnalogOutput_VoltRange;
      RTBIO_DriverIO(0, ANALOGOUTPUT, IOWRITE, 1,
                     &Maglev_PID_P.AnalogOutput_Channels,
                     &Maglev_PID_P.AnalogOutput_FinalValue, &parm);
    }
  }

  /* External mode */
  rtExtModeShutdown(3);
}

/*========================================================================*
 * Start of GRT compatible call interface                                 *
 *========================================================================*/
void MdlOutputs(int_T tid)
{
  Maglev_PID_output(tid);
}

void MdlUpdate(int_T tid)
{
  Maglev_PID_update(tid);
}

void MdlInitializeSizes(void)
{
  Maglev_PID_M->Sizes.numContStates = (0);/* Number of continuous states */
  Maglev_PID_M->Sizes.numY = (0);      /* Number of model outputs */
  Maglev_PID_M->Sizes.numU = (0);      /* Number of model inputs */
  Maglev_PID_M->Sizes.sysDirFeedThru = (0);/* The model is not direct feedthrough */
  Maglev_PID_M->Sizes.numSampTimes = (3);/* Number of sample times */
  Maglev_PID_M->Sizes.numBlocks = (44);/* Number of blocks */
  Maglev_PID_M->Sizes.numBlockIO = (10);/* Number of block outputs */
  Maglev_PID_M->Sizes.numBlockPrms = (40);/* Sum of parameter "widths" */
}

void MdlInitializeSampleTimes(void)
{
}

void MdlInitialize(void)
{
}

void MdlStart(void)
{
  /* S-Function Block: <S4>/Analog Output */
  {
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE) Maglev_PID_P.AnalogOutput_RangeMode;
      parm.rangeidx = Maglev_PID_P.AnalogOutput_VoltRange;
      RTBIO_DriverIO(0, ANALOGOUTPUT, IOWRITE, 1,
                     &Maglev_PID_P.AnalogOutput_Channels,
                     &Maglev_PID_P.AnalogOutput_InitialValue, &parm);
    }
  }

  MdlInitialize();
}

RT_MODEL_Maglev_PID *Maglev_PID(void)
{
  Maglev_PID_initialize(1);
  return Maglev_PID_M;
}

void MdlTerminate(void)
{
  Maglev_PID_terminate();
}

/*========================================================================*
 * End of GRT compatible call interface                                   *
 *========================================================================*/
