/*
 * rt_defines.h
 *
 * Real-Time Workshop code generation for Simulink model "Maglev_PD.mdl".
 *
 * Model Version              : 1.259
 * Real-Time Workshop version : 7.1  (R2008a)  23-Jan-2008
 * C source code generated on : Fri Sep 02 16:37:35 2016
 */

#ifndef RTW_HEADER_rt_defines_h_
#define RTW_HEADER_rt_defines_h_
#include <stdlib.h>
#define RT_PI                          3.14159265358979323846
#define RT_LN_10                       2.30258509299404568402
#define RT_LOG10E                      0.43429448190325182765
#define RT_E                           2.7182818284590452354
#define rt_ABS(u1)                     ( ((u1) >= 0 ) ? (u1) : -(u1) )
#define rt_MAX(u1,u2)                  ( ((u1) >= (u2)) ? (u1) : (u2) )
#define rt_MIN(u1,u2)                  ( ((u1) <= (u2)) ? (u1) : (u2) )
#define rt_SATURATE(sig,ll,ul)         ( ((sig ) >= (ul)) ? (ul) : (((sig) <= (ll)) ? (ll) : (sig)) )
#define rt_SGN(u1)                     ( ((u1) >= 0 ) ? ((u1) > 0 ? 1 : 0 ) : -1 )
#define rt_UNSGN(u1)                   ( ((u1) > 0U ) ? 1U : 0U )
#define rt_SIGNd(u1)                   ( ((u1) >= 0.0 ) ? ((u1) > 0.0 ? 1.0 : 0.0 ) : -1.0 )
#define rt_SIGNf(u1)                   ( ((u1) >= 0.0F ) ? ((u1) > 0.0F ? 1.0F : 0.0F ) : -1.0F )
#define rt_DIVREM(u1, u2)              (div((u1),(u2)).rem)
#define rt_DIVQUOT(u1, u2)             (div((u1),(u2)).quot)
#endif                                 /* RTW_HEADER_rt_defines_h_ */
