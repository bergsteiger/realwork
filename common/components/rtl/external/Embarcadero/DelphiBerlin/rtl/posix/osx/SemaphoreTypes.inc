{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{ semaphore.h }

type
  sem_t = Integer;
  {$EXTERNALSYM sem_t}
  Psem_t = ^sem_t;

const
  SEM_VALUE_MAX = 32767;
  {$EXTERNALSYM SEM_VALUE_MAX}
  SEM_FAILED: Psem_t = Psem_t(-1);
  {$EXTERNALSYM SEM_FAILED}
