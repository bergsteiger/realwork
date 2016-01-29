{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

const
{
 * POSIX scheduling policies
}
  SCHED_OTHER = 1;
  {$EXTERNALSYM SCHED_OTHER}
  SCHED_FIFO = 4;
  {$EXTERNALSYM SCHED_FIFO}
  SCHED_RR = 2;
  {$EXTERNALSYM SCHED_RR}

  __SCHED_PARAM_SIZE__ = 4;
  {$EXTERNALSYM __SCHED_PARAM_SIZE__}

type
  sched_param = record
    sched_priority: Integer;
    __opaque: packed array[0..__SCHED_PARAM_SIZE__-1] of Byte;
  end;
  {$EXTERNALSYM sched_param}
  Psched_param = ^sched_param;
