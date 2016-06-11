/*------------------------------------------------------------------------
 * filename - getinfo1.c
 *
 * function(s)
 *      _getLocaleTimeInfo - return the required info about the locale
 *
 *
 *
 *
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1998, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 34095 $        */

#include <windows.h>
#include <winnls.h>
#include <locale.h>
#include <_locale.h>

const void* _getLocaleTimeInfo(LCTYPE info)
{
    void *val;

   _lock_locale();

    switch (info)
    {
    case LOCALE_SDATE:              val = (__locale->time->DateSeparator); break;
    case LOCALE_STIME:              val = (__locale->time->TimeSeparator); break;
    case LOCALE_STIMEFORMAT:        val = (__locale->time->TimeFormat); break;
    case LOCALE_SSHORTDATE:         val = (__locale->time->ShortFormat); break;
    case LOCALE_SLONGDATE:          val = (__locale->time->LongFormat); break;
    case LOCALE_S1159:              val = (__locale->time->AM); break;
    case LOCALE_S2359:              val = (__locale->time->PM); break;
    case LOCALE_SDAYNAME1:          val = (__locale->time->DayName1); break;
    case LOCALE_SDAYNAME2:          val = (__locale->time->DayName2); break;
    case LOCALE_SDAYNAME3:          val = (__locale->time->DayName3); break;
    case LOCALE_SDAYNAME4:          val = (__locale->time->DayName4); break;
    case LOCALE_SDAYNAME5:          val = (__locale->time->DayName5); break;
    case LOCALE_SDAYNAME6:          val = (__locale->time->DayName6); break;
    case LOCALE_SDAYNAME7:          val = (__locale->time->DayName7); break;
    case LOCALE_SABBREVDAYNAME1:    val = (__locale->time->AbrvDayName1); break;
    case LOCALE_SABBREVDAYNAME2:    val = (__locale->time->AbrvDayName2); break;
    case LOCALE_SABBREVDAYNAME3:    val = (__locale->time->AbrvDayName3); break;
    case LOCALE_SABBREVDAYNAME4:    val = (__locale->time->AbrvDayName4); break;
    case LOCALE_SABBREVDAYNAME5:    val = (__locale->time->AbrvDayName5); break;
    case LOCALE_SABBREVDAYNAME6:    val = (__locale->time->AbrvDayName6); break;
    case LOCALE_SABBREVDAYNAME7:    val = (__locale->time->AbrvDayName7); break;
    case LOCALE_SMONTHNAME1:        val = (__locale->time->MonthName1); break;
    case LOCALE_SMONTHNAME2:        val = (__locale->time->MonthName2); break;
    case LOCALE_SMONTHNAME3:        val = (__locale->time->MonthName3); break;
    case LOCALE_SMONTHNAME4:        val = (__locale->time->MonthName4); break;
    case LOCALE_SMONTHNAME5:        val = (__locale->time->MonthName5); break;
    case LOCALE_SMONTHNAME6:        val = (__locale->time->MonthName6); break;
    case LOCALE_SMONTHNAME7:        val = (__locale->time->MonthName7); break;
    case LOCALE_SMONTHNAME8:        val = (__locale->time->MonthName8); break;
    case LOCALE_SMONTHNAME9:        val = (__locale->time->MonthName9); break;
    case LOCALE_SMONTHNAME10:       val = (__locale->time->MonthName10); break;
    case LOCALE_SMONTHNAME11:       val = (__locale->time->MonthName11); break;
    case LOCALE_SMONTHNAME12:       val = (__locale->time->MonthName12); break;
    case LOCALE_SABBREVMONTHNAME1:  val = (__locale->time->AbrvMonthName1); break;
    case LOCALE_SABBREVMONTHNAME2:  val = (__locale->time->AbrvMonthName2); break;
    case LOCALE_SABBREVMONTHNAME3:  val = (__locale->time->AbrvMonthName3); break;
    case LOCALE_SABBREVMONTHNAME4:  val = (__locale->time->AbrvMonthName4); break;
    case LOCALE_SABBREVMONTHNAME5:  val = (__locale->time->AbrvMonthName5); break;
    case LOCALE_SABBREVMONTHNAME6:  val = (__locale->time->AbrvMonthName6); break;
    case LOCALE_SABBREVMONTHNAME7:  val = (__locale->time->AbrvMonthName7); break;
    case LOCALE_SABBREVMONTHNAME8:  val = (__locale->time->AbrvMonthName8); break;
    case LOCALE_SABBREVMONTHNAME9:  val = (__locale->time->AbrvMonthName9); break;
    case LOCALE_SABBREVMONTHNAME10: val = (__locale->time->AbrvMonthName10); break;
    case LOCALE_SABBREVMONTHNAME11: val = (__locale->time->AbrvMonthName11); break;
    case LOCALE_SABBREVMONTHNAME12: val = (__locale->time->AbrvMonthName12); break;

    case LOCALE_IDATE     :         val = (void*) (__locale->time->Order); break;
    case LOCALE_ILDATE    :         val = (void*) (__locale->time->LongOrder); break;
    case LOCALE_ITIME     :         val = (void*) (__locale->time->TimeFmt); break;
    case LOCALE_ICENTURY  :         val = (void*) (__locale->time->Century); break;
    case LOCALE_ITLZERO   :         val = (void*) (__locale->time->TimeLeadZeros); break;
    case LOCALE_IDAYLZERO :         val = (void*) (__locale->time->DayLeadZeros); break;
    case LOCALE_IMONLZERO :         val = (void*) (__locale->time->MonthLeadZeros); break;
    default:                        val = NULL; break;
    }
    _unlock_locale();
    return val;
}
