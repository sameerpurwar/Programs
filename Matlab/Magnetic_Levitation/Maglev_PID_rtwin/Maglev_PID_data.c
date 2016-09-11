/*
 * Maglev_PID_data.c
 *
 * Real-Time Workshop code generation for Simulink model "Maglev_PID.mdl".
 *
 * Model Version              : 1.246
 * Real-Time Workshop version : 7.1  (R2008a)  23-Jan-2008
 * C source code generated on : Fri Sep 02 16:58:24 2016
 */

#include "Maglev_PID.h"
#include "Maglev_PID_private.h"

/* Block parameters (auto storage) */
Parameters_Maglev_PID Maglev_PID_P = {
  5.0,                                 /* Constant_Value : '<S4>/Constant'
                                        */
  0.0,                                 /* Step_Time : '<Root>/Step'
                                        */
  0.0,                                 /* Step_Y0 : '<Root>/Step'
                                        */
  -2.0,                                /* Step_YFinal : '<Root>/Step'
                                        */
  0.5,                                 /* Sinus_Amplitude : '<Root>/Sinus'
                                        */
  0.5,                                 /* Sinus_Frequency : '<Root>/Sinus'
                                        */
  0.3,                                 /* Square_Amplitude : '<Root>/Square'
                                        */
  0.5,                                 /* Square_Frequency : '<Root>/Square'
                                        */
  -1.5,                                /* Constant_Value_m : '<Root>/Constant'
                                        */
  11.0,                                /* Gain_Gain : '<S7>/Gain'
                                        */
  100.0,                               /* Gain1_Gain : '<S7>/Gain1'
                                        */
  0.0,                                 /* DiscreteTransferFcn_A : '<S7>/Discrete Transfer Fcn'
                                        */
  -1.0,                                /* DiscreteTransferFcn_C : '<S7>/Discrete Transfer Fcn'
                                        */
  1.0,                                 /* DiscreteTransferFcn_D : '<S7>/Discrete Transfer Fcn'
                                        */
  0.0,                                 /* qpp1_Value : '<S8>/qpp1'
                                        */
  15.0,                                /* Constant_Value_c : '<S9>/Constant'
                                        */
  15.0,                                /* Constant_Value_mr : '<S10>/Constant'
                                        */
  1.8000000000000002E-002,             /* Gain3_Gain : '<S7>/Gain3'
                                        */
  1.0,                                 /* DiscreteTransferFcn1_A : '<S7>/Discrete Transfer Fcn1'
                                        */
  1.0,                                 /* DiscreteTransferFcn1_C : '<S7>/Discrete Transfer Fcn1'
                                        */
  1.0,                                 /* DiscreteTransferFcn1_D : '<S7>/Discrete Transfer Fcn1'
                                        */
  -1.0,                                /* Gain2_Gain : '<S7>/Gain2'
                                        */
  10.0,                                /* Saturation_UpperSat : '<S4>/Saturation'
                                        */
  0.0,                                 /* Saturation_LowerSat : '<S4>/Saturation'
                                        */
  5.0,                                 /* AnalogOutput_InitialValue : '<S4>/Analog Output'
                                        */
  5.0,                                 /* AnalogOutput_FinalValue : '<S4>/Analog Output'
                                        */
  0.007,                               /* Gain2_Gain_o : '<S1>/Gain2'
                                        */
  0.0195,                              /* Constant1_Value : '<S1>/Constant1'
                                        */
  0.007,                               /* Gain2_Gain_i : '<S2>/Gain2'
                                        */
  0.0195,                              /* Constant1_Value_i : '<S2>/Constant1'
                                        */
  10,                                  /* AnalogInput_Channels : '<S3>/Analog Input'
                                        */
  0,                                   /* AnalogInput_RangeMode : '<S3>/Analog Input'
                                        */
  0,                                   /* AnalogInput_VoltRange : '<S3>/Analog Input'
                                        */
  0,                                   /* AnalogOutput_Channels : '<S4>/Analog Output'
                                        */
  0,                                   /* AnalogOutput_RangeMode : '<S4>/Analog Output'
                                        */
  1,                                   /* AnalogOutput_VoltRange : '<S4>/Analog Output'
                                        */
  1U,                                  /* Constant_Value_l : '<S5>/Constant'
                                        */
  1U,                                  /* Constant_Value_k : '<S6>/Constant'
                                        */
  0U,                                  /* SwitchControl_Threshold : '<S5>/SwitchControl'
                                        */
  1U                                   /* SwitchControl_Threshold_k : '<S6>/SwitchControl'
                                        */
};
