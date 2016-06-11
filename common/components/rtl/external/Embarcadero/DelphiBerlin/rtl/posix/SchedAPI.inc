{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
 
function sched_rr_get_interval(pid: pid_t; param: Psched_param): Integer; cdecl;
  external libc name _PU + 'sched_rr_get_interval';
{$EXTERNALSYM sched_rr_get_interval}

function sched_getparam(pid: pid_t; param: Psched_param): Integer; cdecl;
  external libc name _PU + 'sched_getparam';
{$EXTERNALSYM sched_getparam}

function sched_setparam(pid: pid_t; param: Psched_param): Integer; cdecl;
  external libc name _PU + 'sched_setparam';
{$EXTERNALSYM sched_setparam}

function sched_setscheduler(pid: pid_t; policy: Integer; param: Psched_param): Integer; cdecl;
  external libc name _PU + 'sched_setscheduler';
{$EXTERNALSYM sched_setscheduler}

function sched_getscheduler(pid: pid_t): Integer; cdecl;
  external libc name _PU + 'sched_getscheduler';
{$EXTERNALSYM sched_getscheduler}

function sched_get_priority_min(policy: Integer): Integer; cdecl;
  external libc name _PU + 'sched_get_priority_min';
{$EXTERNALSYM sched_get_priority_min}

function sched_get_priority_max(policy: Integer): Integer; cdecl;
  external libc name _PU + 'sched_get_priority_max';
{$EXTERNALSYM sched_get_priority_max}

{ Yield the processor.  }
function sched_yield: Integer; cdecl;
  external libc name _PU + 'sched_yield';
{$EXTERNALSYM sched_yield}
