{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

function sched_get_priority_min(p1: Integer): Integer; cdecl;
  external libc name _PU + 'sched_get_priority_min';
{$EXTERNALSYM sched_get_priority_min}
function sched_get_priority_max(p1: Integer): Integer; cdecl;
  external libc name _PU + 'sched_get_priority_max';
{$EXTERNALSYM sched_get_priority_max}

{ Yield the processor.  }
function sched_yield: Integer; cdecl;
  external libc name _PU + 'sched_yield';
{$EXTERNALSYM sched_yield}
