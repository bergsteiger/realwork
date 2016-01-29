{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{ from DriverServices.h }

const
  durationMicrosecond = -1;             { Microseconds are negative }
  {$EXTERNALSYM durationMicrosecond}
  durationMillisecond = 1;              { Milliseconds are positive }
  {$EXTERNALSYM durationMillisecond}
  durationSecond      = 1000;           { 1000 * durationMillisecond }
  {$EXTERNALSYM durationSecond}
  durationMinute      = 60000;          { 60 * durationSecond, }
  {$EXTERNALSYM durationMinute}
  durationHour        = 3600000;        { 60 * durationMinute, }
  {$EXTERNALSYM durationHour}
  durationDay         = 86400000;       { 24 * durationHour, }
  {$EXTERNALSYM durationDay}
  durationNoWait      = 0;              { don't block }
  {$EXTERNALSYM durationNoWait}
  durationForever     = $7FFFFFFF;      { no time limit }
  {$EXTERNALSYM durationForever}


type
  Nanoseconds = UnsignedWide;
  {$EXTERNALSYM Nanoseconds}
{
 *  UpTime()
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
 }
function UpTime: AbsoluteTime; cdecl;
{$EXTERNALSYM UpTime}

{
 *  GetTimeBaseInfo()
 *
 *  Availability:
 *    Mac OS X:         not available
 *    CarbonLib:        not available
 *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
 }

{
 *  AbsoluteToNanoseconds()
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
 }
function AbsoluteToNanoseconds(absoluteTime: AbsoluteTime): Nanoseconds; cdecl;
{$EXTERNALSYM AbsoluteToNanoseconds}

{
 *  AbsoluteToDuration()
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
 }
function AbsoluteToDuration(absoluteTime: AbsoluteTime): Duration; cdecl;
{$EXTERNALSYM AbsoluteToDuration}

{
 *  NanosecondsToAbsolute()
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
 }
function NanosecondsToAbsolute(nanoseconds: Nanoseconds): AbsoluteTime; cdecl;
{$EXTERNALSYM NanosecondsToAbsolute}

{
 *  DurationToAbsolute()
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
 }
function DurationToAbsolute(duration: Duration): AbsoluteTime; cdecl;
{$EXTERNALSYM DurationToAbsolute}

{
 *  AddAbsoluteToAbsolute()
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
 }
function AddAbsoluteToAbsolute(absoluteTime1: AbsoluteTime; absoluteTime2: AbsoluteTime): AbsoluteTime; cdecl;
{$EXTERNALSYM AddAbsoluteToAbsolute}

{
 *  SubAbsoluteFromAbsolute()
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
 }
function SubAbsoluteFromAbsolute(leftAbsoluteTime: AbsoluteTime; rightAbsoluteTime: AbsoluteTime): AbsoluteTime; cdecl;
{$EXTERNALSYM SubAbsoluteFromAbsolute}

{
 *  AddNanosecondsToAbsolute()
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
 }
function AddNanosecondsToAbsolute(nanoseconds: Nanoseconds; absoluteTime: AbsoluteTime): AbsoluteTime; cdecl;
{$EXTERNALSYM AddNanosecondsToAbsolute}

{
 *  AddDurationToAbsolute()
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
 }
function AddDurationToAbsolute(duration: Duration; absoluteTime: AbsoluteTime): AbsoluteTime; cdecl;
{$EXTERNALSYM AddDurationToAbsolute}

{
 *  SubNanosecondsFromAbsolute()
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
 }
function SubNanosecondsFromAbsolute(nanoseconds: Nanoseconds; absoluteTime: AbsoluteTime): AbsoluteTime; cdecl;
{$EXTERNALSYM SubNanosecondsFromAbsolute}

{
 *  SubDurationFromAbsolute()
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
 }
function SubDurationFromAbsolute(duration: Duration; absoluteTime: AbsoluteTime): AbsoluteTime; cdecl;
{$EXTERNALSYM SubDurationFromAbsolute}

{
 *  AbsoluteDeltaToNanoseconds()
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
 }
function AbsoluteDeltaToNanoseconds(leftAbsoluteTime: AbsoluteTime; rightAbsoluteTime: AbsoluteTime): Nanoseconds; cdecl;
{$EXTERNALSYM AbsoluteDeltaToNanoseconds}

{
 *  AbsoluteDeltaToDuration()
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
 }
function AbsoluteDeltaToDuration(leftAbsoluteTime: AbsoluteTime;
  rightAbsoluteTime: AbsoluteTime): Duration; cdecl;
{$EXTERNALSYM AbsoluteDeltaToDuration}

{
 *  DurationToNanoseconds()
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
 }
function DurationToNanoseconds(theDuration: Duration): Nanoseconds; cdecl;
{$EXTERNALSYM DurationToNanoseconds}

{
 *  NanosecondsToDuration()
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
 }
function NanosecondsToDuration(theNanoseconds: Nanoseconds): Duration; cdecl;
{$EXTERNALSYM NanosecondsToDuration}

