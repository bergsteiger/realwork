{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$IF NOT DECLARED(_PU)}
const
  {$IFDEF UNDERSCOREIMPORTNAME}
  _PU = '_';
  {$ELSE}
  _PU = '';
  {$ENDIF}
{$ENDIF}

function UpTime; external CarbonCoreLib name _PU + 'UpTime';
function AbsoluteDeltaToDuration; external CarbonCoreLib name _PU + 'AbsoluteDeltaToDuration';
function AbsoluteDeltaToNanoseconds; external CarbonCoreLib name _PU + 'AbsoluteDeltaToNanoseconds';
function AbsoluteToDuration; external CarbonCoreLib name _PU + 'AbsoluteToDuration';
function AbsoluteToNanoseconds; external CarbonCoreLib name _PU + 'AbsoluteToNanoseconds';
function AddAbsoluteToAbsolute; external CarbonCoreLib name _PU + 'AddAbsoluteToAbsolute';
function AddDurationToAbsolute; external CarbonCoreLib name _PU + 'AddDurationToAbsolute';
function AddNanosecondsToAbsolute; external CarbonCoreLib name _PU + 'AddNanosecondsToAbsolute';
function DurationToAbsolute; external CarbonCoreLib name _PU + 'DurationToAbsolute';
function DurationToNanoseconds; external CarbonCoreLib name _PU + 'DurationToNanoseconds';
function NanosecondsToAbsolute; external CarbonCoreLib name _PU + 'NanosecondsToAbsolute';
function NanosecondsToDuration; external CarbonCoreLib name _PU + 'NanosecondsToDuration';
function SubAbsoluteFromAbsolute; external CarbonCoreLib name _PU + 'SubAbsoluteFromAbsolute';
function SubDurationFromAbsolute; external CarbonCoreLib name _PU + 'SubDurationFromAbsolute';
function SubNanosecondsFromAbsolute; external CarbonCoreLib name _PU + 'SubNanosecondsFromAbsolute';
