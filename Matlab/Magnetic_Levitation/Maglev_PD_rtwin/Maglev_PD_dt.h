/*
 * Maglev_PD_dt.h
 *
 * Real-Time Workshop code generation for Simulink model "Maglev_PD.mdl".
 *
 * Model Version              : 1.259
 * Real-Time Workshop version : 7.1  (R2008a)  23-Jan-2008
 * C source code generated on : Fri Sep 02 16:37:35 2016
 */

#include "ext_types.h"

/* data type size table */
static uint_T rtDataTypeSizes[] = {
  sizeof(real_T),
  sizeof(real32_T),
  sizeof(int8_T),
  sizeof(uint8_T),
  sizeof(int16_T),
  sizeof(uint16_T),
  sizeof(int32_T),
  sizeof(uint32_T),
  sizeof(boolean_T),
  sizeof(fcn_call_T),
  sizeof(int_T),
  sizeof(pointer_T),
  sizeof(action_T),
  2*sizeof(uint32_T)
};

/* data type name table */
static const char_T * rtDataTypeNames[] = {
  "real_T",
  "real32_T",
  "int8_T",
  "uint8_T",
  "int16_T",
  "uint16_T",
  "int32_T",
  "uint32_T",
  "boolean_T",
  "fcn_call_T",
  "int_T",
  "pointer_T",
  "action_T",
  "timer_uint32_pair_T"
};

/* data type transitions for block I/O structure */
static DataTypeTransition rtBTransitions[] = {
  { (char_T *)(&Maglev_PD_B.AnalogInput), 0, 0, 9 }
  ,

  { (char_T *)(&Maglev_PD_DWork.DiscreteTransferFcn1_DSTATE), 0, 0, 2 },

  { (char_T *)(&Maglev_PD_DWork.ToWorkspace1_PWORK.LoggedData), 11, 0, 5 }
};

/* data type transition table for block I/O structure */
static DataTypeTransitionTable rtBTransTable = {
  3U,
  rtBTransitions
};

/* data type transitions for Parameters structure */
static DataTypeTransition rtPTransitions[] = {
  { (char_T *)(&Maglev_PD_P.Constant_Value), 0, 0, 27 },

  { (char_T *)(&Maglev_PD_P.AnalogInput_Channels), 6, 0, 6 },

  { (char_T *)(&Maglev_PD_P.Constant_Value_b), 3, 0, 4 }
};

/* data type transition table for Parameters structure */
static DataTypeTransitionTable rtPTransTable = {
  3U,
  rtPTransitions
};

/* [EOF] Maglev_PD_dt.h */
