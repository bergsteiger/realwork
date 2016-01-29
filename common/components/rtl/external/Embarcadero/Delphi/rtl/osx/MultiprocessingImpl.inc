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
function MPProcessors; external CarbonCoreLib name _PU + 'MPProcessors';
function MPProcessorsScheduled; external CarbonCoreLib name _PU + 'MPProcessorsScheduled';
function MPCreateTask; external CarbonCoreLib name _PU + 'MPCreateTask';
function MPTerminateTask; external CarbonCoreLib name _PU + 'MPTerminateTask';
function MPSetTaskWeight; external CarbonCoreLib name _PU + 'MPSetTaskWeight';
function MPTaskIsPreemptive; external CarbonCoreLib name _PU + 'MPTaskIsPreemptive';
procedure MPExit; external CarbonCoreLib name _PU + 'MPExit';
procedure MPYield; external CarbonCoreLib name _PU + 'MPYield';
function MPCurrentTaskID; external CarbonCoreLib name _PU + 'MPCurrentTaskID';
function MPSetTaskType; external CarbonCoreLib name _PU + 'MPSetTaskType';
function MPAllocateTaskStorageIndex; external CarbonCoreLib name _PU + 'MPAllocateTaskStorageIndex';
function MPDeallocateTaskStorageIndex; external CarbonCoreLib name _PU + 'MPDeallocateTaskStorageIndex';
function MPSetTaskStorageValue; external CarbonCoreLib name _PU + 'MPSetTaskStorageValue';
function MPGetTaskStorageValue; external CarbonCoreLib name _PU + 'MPGetTaskStorageValue';
function MPCreateQueue; external CarbonCoreLib name _PU + 'MPCreateQueue';
function MPDeleteQueue; external CarbonCoreLib name _PU + 'MPDeleteQueue';
function MPNotifyQueue; external CarbonCoreLib name _PU + 'MPNotifyQueue';
function MPWaitOnQueue; external CarbonCoreLib name _PU + 'MPWaitOnQueue';
function MPSetQueueReserve; external CarbonCoreLib name _PU + 'MPSetQueueReserve';
function MPCreateSemaphore; external CarbonCoreLib name _PU + 'MPCreateSemaphore';
function MPDeleteSemaphore; external CarbonCoreLib name _PU + 'MPDeleteSemaphore';
function MPSignalSemaphore; external CarbonCoreLib name _PU + 'MPSignalSemaphore';
function MPWaitOnSemaphore; external CarbonCoreLib name _PU + 'MPWaitOnSemaphore';
function MPCreateCriticalRegion; external CarbonCoreLib name _PU + 'MPCreateCriticalRegion';
function MPDeleteCriticalRegion; external CarbonCoreLib name _PU + 'MPDeleteCriticalRegion';
function MPEnterCriticalRegion; external CarbonCoreLib name _PU + 'MPEnterCriticalRegion';
function MPExitCriticalRegion; external CarbonCoreLib name _PU + 'MPExitCriticalRegion';
function MPCreateEvent; external CarbonCoreLib name _PU + 'MPCreateEvent';
function MPDeleteEvent; external CarbonCoreLib name _PU + 'MPDeleteEvent';
function MPSetEvent; external CarbonCoreLib name _PU + 'MPSetEvent';
function MPWaitForEvent; external CarbonCoreLib name _PU + 'MPWaitForEvent';
function MPCreateNotification; external CarbonCoreLib name _PU + 'MPCreateNotification';
function MPDeleteNotification; external CarbonCoreLib name _PU + 'MPDeleteNotification';
function MPModifyNotification; external CarbonCoreLib name _PU + 'MPModifyNotification';
function MPModifyNotificationParameters; external CarbonCoreLib name _PU + 'MPModifyNotificationParameters';
function MPCauseNotification; external CarbonCoreLib name _PU + 'MPCauseNotification';
function MPDelayUntil; external CarbonCoreLib name _PU + 'MPDelayUntil';
function MPCreateTimer; external CarbonCoreLib name _PU + 'MPCreateTimer';
function MPDeleteTimer; external CarbonCoreLib name _PU + 'MPDeleteTimer';
function MPSetTimerNotify; external CarbonCoreLib name _PU + 'MPSetTimerNotify';
function MPArmTimer; external CarbonCoreLib name _PU + 'MPArmTimer';
function MPCancelTimer; external CarbonCoreLib name _PU + 'MPCancelTimer';
function MPAllocateAligned; external CarbonCoreLib name _PU + 'MPAllocateAligned';
function MPAllocate; external CarbonCoreLib name _PU + 'MPAllocate';
procedure MPFree; external CarbonCoreLib name _PU + 'MPFree';
function MPGetAllocatedBlockSize; external CarbonCoreLib name _PU + 'MPGetAllocatedBlockSize';
procedure MPBlockCopy; external CarbonCoreLib name _PU + 'MPBlockCopy';
procedure MPBlockClear; external CarbonCoreLib name _PU + 'MPBlockClear';

{$IFNDEF __LP64__}
procedure MPDataToCode; external CarbonCoreLib name _PU + 'MPDataToCode';
{$ENDIF __LP64__}

function MPSetExceptionHandler; external CarbonCoreLib name _PU + 'MPSetExceptionHandler';
function MPDisposeTaskException; external CarbonCoreLib name _PU + 'MPDisposeTaskException';
function MPExtractTaskState; external CarbonCoreLib name _PU + 'MPExtractTaskState';
function MPSetTaskState; external CarbonCoreLib name _PU + 'MPSetTaskState';
function MPThrowException; external CarbonCoreLib name _PU + 'MPThrowException';
function MPRegisterDebugger; external CarbonCoreLib name _PU + 'MPRegisterDebugger';
function MPUnregisterDebugger; external CarbonCoreLib name _PU + 'MPUnregisterDebugger';
function MPRemoteCall; external CarbonCoreLib name _PU + 'MPRemoteCall';
function MPRemoteCallCFM; external CarbonCoreLib name _PU + 'MPRemoteCallCFM';
function _MPIsFullyInitialized; external CarbonCoreLib name _PU + '_MPIsFullyInitialized';
procedure _MPLibraryVersion; external CarbonCoreLib name _PU + '_MPLibraryVersion';
function _MPLibraryIsCompatible; external CarbonCoreLib name _PU + '_MPLibraryIsCompatible';


function MPCreateBinarySemaphore(out semaphore: MPSemaphoreID): OSStatus; inline;
begin
  Result := MPCreateSemaphore(1, 1, semaphore);
end;

function MPLibraryIsLoaded: Boolean;
begin
  Result := (@_MPIsFullyInitialized <> nil) and _MPIsFullyInitialized;
{  ( ( (UInt32)_MPIsFullyInitialized != (UInt32)kMPUnresolvedCFragSymbolAddress ) &&   \
      ( _MPIsFullyInitialized () ) )}
end;
