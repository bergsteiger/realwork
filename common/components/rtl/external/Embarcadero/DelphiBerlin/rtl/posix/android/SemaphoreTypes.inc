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
  sem_t = {packed} record
    [Volatile] count: UInt32;
  end;
  {$EXTERNALSYM sem_t}
  Psem_t = ^sem_t;

const
  // Value returned if `sem_open' failed
  SEM_FAILED: Psem_t = Psem_t(0);
  {$EXTERNALSYM SEM_FAILED}
  
