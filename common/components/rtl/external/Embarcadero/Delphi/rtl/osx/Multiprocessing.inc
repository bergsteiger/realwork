{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{ From Multiprocessing.h }
type
  MPProcessID = type Pointer;
  {$EXTERNALSYM MPProcessID}
  MPTaskID = type Pointer;
  {$EXTERNALSYM MPTaskID}
  MPQueueID = type Pointer;
  {$EXTERNALSYM MPQueueID}
  MPSemaphoreID = type Pointer;
  {$EXTERNALSYM MPSemaphoreID}
  MPCriticalRegionID = type Pointer;
  {$EXTERNALSYM MPCriticalRegionID}
  MPTimerID = type Pointer;
  {$EXTERNALSYM MPTimerID}
  MPEventID = type Pointer;
  {$EXTERNALSYM MPEventID}
  MPAddressSpaceID = type Pointer;
  {$EXTERNALSYM MPAddressSpaceID}
  MPNotificationID = type Pointer;
  {$EXTERNALSYM MPNotificationID}
  MPCoherenceID = type Pointer;
  {$EXTERNALSYM MPCoherenceID}
  MPCpuID = type Pointer;
  {$EXTERNALSYM MPCpuID}
  MPAreaID = type Pointer;
  {$EXTERNALSYM MPAreaID}
  MPConsoleID = type Pointer;
  {$EXTERNALSYM MPConsoleID}
  MPOpaqueID = Pointer;
  {$EXTERNALSYM MPOpaqueID}

const
//  kInvalidID                    = 0;
//  { Values for MPOpaqueIDClass. }
  kOpaqueAnyID                  = 0;
  {$EXTERNALSYM kOpaqueAnyID}
  kOpaqueProcessID              = 1;
  {$EXTERNALSYM kOpaqueProcessID}
  kOpaqueTaskID                 = 2;
  {$EXTERNALSYM kOpaqueTaskID}
  kOpaqueTimerID                = 3;
  {$EXTERNALSYM kOpaqueTimerID}
  kOpaqueQueueID                = 4;
  {$EXTERNALSYM kOpaqueQueueID}
  kOpaqueSemaphoreID            = 5;
  {$EXTERNALSYM kOpaqueSemaphoreID}
  kOpaqueCriticalRegionID       = 6;
  {$EXTERNALSYM kOpaqueCriticalRegionID}
  kOpaqueCpuID                  = 7;
  {$EXTERNALSYM kOpaqueCpuID}
  kOpaqueAddressSpaceID         = 8;
  {$EXTERNALSYM kOpaqueAddressSpaceID}
  kOpaqueEventID                = 9;
  {$EXTERNALSYM kOpaqueEventID}
  kOpaqueCoherenceID            = 10;
  {$EXTERNALSYM kOpaqueCoherenceID}
  kOpaqueAreaID                 = 11;
  {$EXTERNALSYM kOpaqueAreaID}
  kOpaqueNotificationID         = 12;
  {$EXTERNALSYM kOpaqueNotificationID}
  kOpaqueConsoleID              = 13;
  {$EXTERNALSYM kOpaqueConsoleID}

  kMPNoID                       = kInvalidID; { New code should use kInvalidID everywhere.}
  {$EXTERNALSYM kMPNoID}

type
  MPOpaqueIDClass = type Cardinal;
  {$EXTERNALSYM MPOpaqueIDClass}

  MPTaskOptions = OptionBits;
  {$EXTERNALSYM MPTaskOptions}
  TaskStorageIndex = ItemCount;
  {$EXTERNALSYM TaskStorageIndex}
  TaskStorageValue = LogicalAddress;
  {$EXTERNALSYM TaskStorageValue}
  MPSemaphoreCount= ItemCount;
  {$EXTERNALSYM MPSemaphoreCount}
  MPTaskWeight = Cardinal;
  {$EXTERNALSYM MPTaskWeight}
  MPEventFlags = Cardinal;
  {$EXTERNALSYM MPEventFlags}
  MPExceptionKind = Cardinal;
  {$EXTERNALSYM MPExceptionKind}
  MPTaskStateKind = Cardinal;
  {$EXTERNALSYM MPTaskStateKind}
  MPPageSizeClass = Cardinal;
  {$EXTERNALSYM MPPageSizeClass}

const
  kDurationImmediate            = 0;
  {$EXTERNALSYM kDurationImmediate}
  kDurationForever              = $7FFFFFFF;
  {$EXTERNALSYM kDurationForever}
  kDurationMillisecond          = 1;
  {$EXTERNALSYM kDurationMillisecond}
  kDurationMicrosecond          = -1;
  {$EXTERNALSYM kDurationMicrosecond}

//  noErr                         = 0;
//  {$EXTERNALSYM noErr}
  paramErr                      = -50;
  {$EXTERNALSYM paramErr}
  memFullErr                    = -108;
  {$EXTERNALSYM memFullErr}

  kMPTaskBlockedErr             = -29291;
  {$EXTERNALSYM kMPTaskBlockedErr}
  kMPTaskStoppedErr             = -29292;
  {$EXTERNALSYM kMPTaskStoppedErr}
  kMPDeleteErr                  = -29295;
  {$EXTERNALSYM kMPDeleteErr}
  kMPTimeoutErr                 = -29296;
  {$EXTERNALSYM kMPTimeoutErr}
  kMPInsufficientResourcesErr   = -29298;
  {$EXTERNALSYM kMPInsufficientResourcesErr}
  kMPInvalidIDErr               = -29299;
  {$EXTERNALSYM kMPInvalidIDErr}

{*
   ===========================================================================================
   Process/Processor Services
   ==========================
*}

{*
 *  MPProcessors()
 *
 *  Mac OS X threading:
 *    Not thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *}

function MPProcessors: ItemCount {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPProcessors}


{* The physical total.*}

{*
 *  MPProcessorsScheduled()
 *
 *  Mac OS X threading:
 *    Not thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *}
function MPProcessorsScheduled: ItemCount {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPProcessorsScheduled}


{* Those currently in use.*}

{*
   ===========================================================================================
   Tasking Services
   ================
*}

const
  {* For MPCreateTask options*}
  kMPCreateTaskSuspendedMask    = 1 shl 0; {*    not supported on Mac OS X *}
  {$EXTERNALSYM kMPCreateTaskSuspendedMask}
  kMPCreateTaskTakesAllExceptionsMask = 1 shl 1;
  {$EXTERNALSYM kMPCreateTaskTakesAllExceptionsMask}
  kMPCreateTaskNotDebuggableMask = 1 shl 2;
  {$EXTERNALSYM kMPCreateTaskNotDebuggableMask}
  kMPCreateTaskValidOptionsMask = kMPCreateTaskSuspendedMask or kMPCreateTaskTakesAllExceptionsMask or kMPCreateTaskNotDebuggableMask;
  {$EXTERNALSYM kMPCreateTaskValidOptionsMask}

{* -------------------------------------------------------------------------------------------*}
type
  TaskProc = function (parameter: Pointer): OSStatus cdecl;
  {$EXTERNALSYM TaskProc}

{*
 *  MPCreateTask()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *}

function
MPCreateTask(
  entryPoint: TaskProc;
  parameter: Pointer;
  stackSize: ByteCount;
  notifyQueue: MPQueueID;
  terminationParameter1: Pointer;
  terminationParameter2: Pointer;
  options: MPTaskOptions;
  out task: MPTaskID): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
  {$EXTERNALSYM MPCreateTask}

{*
 *  MPTerminateTask()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *}
function
MPTerminateTask(
  task: MPTaskID;
  terminationStatus: OSStatus): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
  {$EXTERNALSYM MPTerminateTask}


{*
 *  MPSetTaskWeight()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *}
function
MPSetTaskWeight(
  task: MPTaskID;
  weight: MPTaskWeight): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
  {$EXTERNALSYM MPSetTaskWeight}


{*
 *  MPTaskIsPreemptive()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *}
function
MPTaskIsPreemptive(taskID: MPTaskID): Boolean {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPTaskIsPreemptive}

{* May be kInvalidID.*}

{*
 *  MPExit()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *}
procedure
MPExit(status: OSStatus) {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPExit}

{*
 *  MPYield()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *}
procedure
MPYield {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPYield}

{*
 *  MPCurrentTaskID()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *}
function
MPCurrentTaskID: MPTaskID {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPCurrentTaskID}

{*
 *  MPSetTaskType()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.1 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.3 and later
 *}
function
MPSetTaskType(
  task: MPTaskID;
  taskType: OSType): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER}; cdecl;
{$EXTERNALSYM MPSetTaskType}

{* -------------------------------------------------------------------------------------------*}


{*
   ---------------------------------------------------
   ! The task storage services are new in version 2.0.
*}

{*
 *  MPAllocateTaskStorageIndex()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *}
function
MPAllocateTaskStorageIndex(out taskIndex: TaskStorageIndex): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPAllocateTaskStorageIndex}

{*
 *  MPDeallocateTaskStorageIndex()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *}
function
MPDeallocateTaskStorageIndex(taskIndex: TaskStorageIndex): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPDeallocateTaskStorageIndex}

{*
 *  MPSetTaskStorageValue()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *}
function
MPSetTaskStorageValue(
  taskIndex: TaskStorageIndex;
  value: TaskStorageValue): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPSetTaskStorageValue}

{*
 *  MPGetTaskStorageValue()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *}
function
MPGetTaskStorageValue(taskIndex: TaskStorageIndex): TaskStorageValue {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPGetTaskStorageValue}



{*
   ===========================================================================================
   Synchronization Services
   ========================
*}


{*
 *  MPCreateQueue()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *}
function
MPCreateQueue(out queue: MPQueueID): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPCreateQueue}

{*
 *  MPDeleteQueue()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *}
function
MPDeleteQueue(queue: MPQueueID): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPDeleteQueue}

{*
 *  MPNotifyQueue()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *}
function
MPNotifyQueue(
  queue: MPQueueID;
  param1: Pointer;
  param2: Pointer;
  param3: Pointer): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPNotifyQueue}

{*
 *  MPWaitOnQueue()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *}
function
MPWaitOnQueue(
  queue: MPQueueID;
  param1: PPointer;
  param2: PPointer;
  param3: PPointer;
  timeout: Duration): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPWaitOnQueue}

{*
 *  MPSetQueueReserve()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *}
function
MPSetQueueReserve(
  queue: MPQueueID;
  count: ItemCount): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPSetQueueReserve}

{* -------------------------------------------------------------------------------------------*}

{*
 *  MPCreateSemaphore()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *}
function
MPCreateSemaphore(
  maximumValue: MPSemaphoreCount;
  initialValue: MPSemaphoreCount;
  out semaphore: MPSemaphoreID): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPCreateSemaphore}

{*
 *  MPDeleteSemaphore()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *}
function
MPDeleteSemaphore(semaphore: MPSemaphoreID): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPDeleteSemaphore}

{*
 *  MPSignalSemaphore()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *}
function
MPSignalSemaphore(semaphore: MPSemaphoreID): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPSignalSemaphore}

{*
 *  MPWaitOnSemaphore()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *}
function
MPWaitOnSemaphore(
  semaphore: MPSemaphoreID;
  timeout: Duration): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPWaitOnSemaphore}

function MPCreateBinarySemaphore(out semaphore: MPSemaphoreID): OSStatus; inline;
{$EXTERNALSYM MPCreateBinarySemaphore}

{* -------------------------------------------------------------------------------------------*}

{*
 *  MPCreateCriticalRegion()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *}
function
MPCreateCriticalRegion(out criticalRegion: MPCriticalRegionID): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPCreateCriticalRegion}

{*
 *  MPDeleteCriticalRegion()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *}
function
MPDeleteCriticalRegion(criticalRegion: MPCriticalRegionID): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPDeleteCriticalRegion}

{*
 *  MPEnterCriticalRegion()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *}
function
MPEnterCriticalRegion(
  criticalRegion: MPCriticalRegionID;
  timeout: Duration): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPEnterCriticalRegion}

{*
 *  MPExitCriticalRegion()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *}
function
MPExitCriticalRegion(criticalRegion: MPCriticalRegionID): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPExitCriticalRegion}

{* -------------------------------------------------------------------------------------------*}


{*
 *  MPCreateEvent()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *}
function
MPCreateEvent(out event: MPEventID): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPCreateEvent}

{*
 *  MPDeleteEvent()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *}
function
MPDeleteEvent(event: MPEventID): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPDeleteEvent}

{*
 *  MPSetEvent()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *}
function
MPSetEvent(
  event: MPEventID;
  flags: MPEventFlags): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPSetEvent}

{*
 *  MPWaitForEvent()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *}
function
MPWaitForEvent(
  event: MPEventID;
  out flags: MPEventFlags;
  timeout: Duration): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPWaitForEvent}

{*
   ===========================================================================================
   Notification Services (API)
   =====================
*}



{*
 *  MPCreateNotification()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.1 and later
 *}
function
MPCreateNotification(out notificationID: MPNotificationID): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPCreateNotification}

{*
 *  MPDeleteNotification()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.1 and later
 *}
function
MPDeleteNotification(notificationID: MPNotificationID): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER};
{$EXTERNALSYM MPDeleteNotification}

{*
 *  MPModifyNotification()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.1 and later
 *}
function
MPModifyNotification(
  notificationID: MPNotificationID;
  anID: MPOpaqueID;
  notifyParam1: Pointer;
  notifyParam2: Pointer;
  notifyParam3: Pointer): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPModifyNotification}

{*
 *  MPModifyNotificationParameters()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.1 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.3 and later
 *}
function
MPModifyNotificationParameters(
  notificationID: MPNotificationID;
  kind: MPOpaqueIDClass;
  notifyParam1: Pointer;
  notifyParam2: Pointer;
  notifyParam3: Pointer): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPModifyNotificationParameters}

{*
 *  MPCauseNotification()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.1 and later
 *}
function
MPCauseNotification(notificationID: MPNotificationID): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPCauseNotification}

{*
   ===========================================================================================
   Timer Services
   ==============
*}


{*
   --------------------------------------------
   ! The timer services are new in version 2.0.
*}

const
  {* For MPArmTimer options*}
  kMPPreserveTimerIDMask        = 1 shl 0;
  {$EXTERNALSYM kMPPreserveTimerIDMask}
  kMPTimeIsDeltaMask            = 1 shl 1;
  {$EXTERNALSYM kMPTimeIsDeltaMask}
  kMPTimeIsDurationMask         = 1 shl 2;
  {$EXTERNALSYM kMPTimeIsDurationMask}

{*
 *  MPDelayUntil()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *}
function
MPDelayUntil(const expirationTime: AbsoluteTime): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPDelayUntil}

{*
 *  MPDelayUntilSys()
 *
 *  Availability:
 *    Mac OS X:         not available
 *    CarbonLib:        not available
 *    Non-Carbon CFM:   in MPLibrary 2.1 and later
 *}

{*
 *  MPCreateTimer()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *}
function
MPCreateTimer(out timerID: MPTimerID): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPCreateTimer}

{*
 *  MPDeleteTimer()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *}
function
MPDeleteTimer(timerID: MPTimerID): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPDeleteTimer}

{*
 *  MPSetTimerNotify()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *}
function
MPSetTimerNotify(
  timerID: MPTimerID;
  anID: MPOpaqueID;
  notifyParam1: Pointer;
  notifyParam2: Pointer;
  notifyParam3: Pointer): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPSetTimerNotify}

{*
 *  MPArmTimer()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *}
function
MPArmTimer(
  timerID: MPTimerID;
  const expirationTime: AbsoluteTime;
  options: OptionBits): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPArmTimer}

{*
 *  MPCancelTimer()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *}
function
MPCancelTimer(
  timerID: MPTimerID;
  out timeRemaining: AbsoluteTime): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPCancelTimer}

{*
   ===========================================================================================
   Memory Services
   ===============
*}


const
  {* Maximum allocation request size is 1GB.*}
  kMPMaxAllocSize               = 1024 * 1024 * 1024;
  {$EXTERNALSYM kMPMaxAllocSize}

  {* Values for the alignment parameter to MPAllocateAligned.*}
  kMPAllocateDefaultAligned     = 0;
  {$EXTERNALSYM kMPAllocateDefaultAligned}
  kMPAllocate8ByteAligned       = 3;
  {$EXTERNALSYM kMPAllocate8ByteAligned}
  kMPAllocate16ByteAligned      = 4;
  {$EXTERNALSYM kMPAllocate16ByteAligned}
  kMPAllocate32ByteAligned      = 5;
  {$EXTERNALSYM kMPAllocate32ByteAligned}
  kMPAllocate1024ByteAligned    = 10;
  {$EXTERNALSYM kMPAllocate1024ByteAligned}
  kMPAllocate4096ByteAligned    = 12;
  {$EXTERNALSYM kMPAllocate4096ByteAligned}
  kMPAllocateMaxAlignment       = 16;   {* Somewhat arbitrary limit on expectations.*}
  {$EXTERNALSYM kMPAllocateMaxAlignment}
  kMPAllocateAltiVecAligned     = kMPAllocate16ByteAligned; {* The P.C. name.*}
  {$EXTERNALSYM kMPAllocateAltiVecAligned}
  kMPAllocateVMXAligned         = kMPAllocateAltiVecAligned; {* The older; common name.*}
  {$EXTERNALSYM kMPAllocateVMXAligned}
  kMPAllocateVMPageAligned      = 254;  {* Pseudo value; converted at runtime.*}
  {$EXTERNALSYM kMPAllocateVMPageAligned}
  kMPAllocateInterlockAligned   = 255;  {* Pseudo value; converted at runtime.*}
  {$EXTERNALSYM kMPAllocateInterlockAligned}

  {* Values for the options parameter to MPAllocateAligned.*}
  kMPAllocateClearMask          = $0001; {* Zero the allocated block.*}
  {$EXTERNALSYM kMPAllocateClearMask}
  kMPAllocateGloballyMask       = $0002; {* Allocate from the globally visible pool.*}
  {$EXTERNALSYM kMPAllocateGloballyMask}
  kMPAllocateResidentMask       = $0004; {* Allocate from the RAM-resident pool.*}
  {$EXTERNALSYM kMPAllocateResidentMask}
  kMPAllocateNoGrowthMask       = $0010; {* Do not attempt to grow the pool.*}
  {$EXTERNALSYM kMPAllocateNoGrowthMask}
  kMPAllocateNoCreateMask       = $0020; {* Do not attempt to create the pool if it doesn't exist yet.*}
  {$EXTERNALSYM kMPAllocateNoCreateMask}

{* -------------------------------------------------------------------------------------------*}

{*
 *  MPAllocateAligned()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *}
function
MPAllocateAligned(
  size: ByteCount;
  alignment: Byte;
  options: OptionBits): LogicalAddress {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPAllocateAligned}


{* ! MPAllocateAligned is new in version 2.0.*}

{*
 *  MPAllocate()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *}
function
MPAllocate(size: ByteCount): LogicalAddress {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPAllocate}


{* Use MPAllocateAligned instead.*}

{*
 *  MPFree()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *}
procedure
MPFree(AObject: LogicalAddress) {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPFree}

{*
 *  MPGetAllocatedBlockSize()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *}
function
MPGetAllocatedBlockSize(AObject: LogicalAddress): ByteCount {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPGetAllocatedBlockSize}

{* -------------------------------------------------------------------------------------------*}

{*
 *  MPBlockCopy()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *}
procedure
MPBlockCopy(
  source: LogicalAddress;
  destination: LogicalAddress;
  size: ByteCount) {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPBlockCopy}

{*
 *  MPBlockClear()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *}
procedure
MPBlockClear(
  address: LogicalAddress;
  size: ByteCount) {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPBlockClear}

{$IFNDEF __LP64__}
{*
 *  MPDataToCode()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only]
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *}
procedure
MPDataToCode(
  address: LogicalAddress;
  size: ByteCount) {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPDataToCode}

{* NOTE:    MPDataToCode is not supported for 64-bit applications. Use mprotect(2) instead.*}

{*
   ===========================================================================================
   Exception/Debugging Services
   ============================
*}

{*
   -------------------------------------------------------------------------------------------
   *** Important Note ***
   ----------------------

   The functions MPExtractTaskState and MPSetTaskState infer the size of the "info" buffer
   from the "kind" parameter.  A given value for MPTaskStateKind will always refer to a
   single specific physical buffer layout.  Should new register sets be added, or the size
   or number of any registers change, new values of MPTaskStateKind will be introduced to
   refer to the new buffer layouts.

   The following types for the buffers are in MachineExceptions. The correspondence between
   MPTaskStateKind values and MachineExceptions types is:

        kMPTaskStateRegisters               -> RegisterInformation
        kMPTaskStateFPU                     -> FPUInformation
        kMPTaskStateVectors                 -> VectorInformation
        kMPTaskStateMachine                 -> MachineInformation
        kMPTaskState32BitMemoryException    -> ExceptionInfo for old-style 32-bit memory exceptions

    For reference, on PowerPC the MachineExceptions types contain:

        RegisterInformation -> The GPRs, 32 values of 64 bits each.
        FPUInformation      -> The FPRs plus FPSCR, 32 values of 64 bits each, one value of
                                32 bits.
        VectorInformation   -> The AltiVec vector registers plus VSCR and VRSave, 32 values
                                of 128 bits each, one value of 128 bits, and one 32 bit value.
        MachineInformation  -> The CTR, LR, PC, each of 64 bits.  The CR, XER, MSR, MQ,
                                exception kind, and DSISR, each of 32 bits.  The 64 bit DAR.
        ExceptionInfo       -> Only memory exceptions are specified, 4 fields of 32 bits each.
                                Note that this type only covers memory exceptions on 32-bit CPUs!
   The following types are declared here:
        kMPTaskStateTaskInfo                -> MPTaskInfo
*}

{$ENDIF}  {* !__LP64__ *}

const
  {* Values for the TaskStateKind to MPExtractTaskState and MPSetTaskState.*}
  kMPTaskStateRegisters         = 0;    {* The task general registers.*}
  {$EXTERNALSYM kMPTaskStateRegisters}
  kMPTaskStateFPU               = 1;    {* The task floating point registers*}
  {$EXTERNALSYM kMPTaskStateFPU}
  kMPTaskStateVectors           = 2;    {* The task vector registers*}
  {$EXTERNALSYM kMPTaskStateVectors}
  kMPTaskStateMachine           = 3;    {* The task machine registers*}
  {$EXTERNALSYM kMPTaskStateMachine}
  kMPTaskState32BitMemoryException = 4; {* The task memory exception information for 32-bit CPUs.*}
  {$EXTERNALSYM kMPTaskState32BitMemoryException}
  kMPTaskStateTaskInfo          = 5;    {* Static and dynamic information about the task.*}
  {$EXTERNALSYM kMPTaskStateTaskInfo}

  {* Option bits and numbers for MPDisposeTaskException.*}
  kMPTaskPropagate              = 0;    {* The exception is propagated.*}
  {$EXTERNALSYM kMPTaskPropagate}
  kMPTaskResumeStep             = 1;    {* The task is resumed and single step is enabled.*}
  {$EXTERNALSYM kMPTaskResumeStep}
  kMPTaskResumeBranch           = 2;    {* The task is resumed and branch stepping is enabled.*}
  {$EXTERNALSYM kMPTaskResumeBranch}
  kMPTaskResumeMask             = $0000; {* The task is resumed.*}
  {$EXTERNALSYM kMPTaskResumeMask}
  kMPTaskPropagateMask          = 1 shl kMPTaskPropagate;    {* The exception is propagated.*}
  {$EXTERNALSYM kMPTaskPropagateMask}
  kMPTaskResumeStepMask         = 1 shl kMPTaskResumeStep;   {* The task is resumed and single step is enabled.*}
  {$EXTERNALSYM kMPTaskResumeStepMask}
  kMPTaskResumeBranchMask       = 1 shl kMPTaskResumeBranch; {* The task is resumed and branch stepping is enabled.*}
  {$EXTERNALSYM kMPTaskResumeBranchMask}

  {* For kMPTaskStateTaskInfo, the task's runState*}
  kMPTaskBlocked                = 0;    {* Task is blocked (queued on resource)*}
  {$EXTERNALSYM kMPTaskBlocked}
  kMPTaskReady                  = 1;    {* Task is runnable*}
  {$EXTERNALSYM kMPTaskReady}
  kMPTaskRunning                = 2;    {* Task is running*}
  {$EXTERNALSYM kMPTaskRunning}

  {* For kMPTaskStateTaskInfo, the version of the MPTaskInfo structure requested.*}
  kMPTaskInfoVersion            = 3;
  {$EXTERNALSYM kMPTaskInfoVersion}

type
  MPTaskInfoVersion2 = record
    version:            PBVersion;              {* Version 2 of the data structure requested*}

    name:               OSType;                 {* Task name*}

    queueName:          OSType;                 {* Task's queue owner name*}
    runState:           Word;                   {* Running, ready, blocked*}
    lastCPU:            Word;                   {* Address of CPU where task previously ran*}
    weight:             Cardinal;               {* Processing weight: 1 - 10,000*}

    processID:          MPProcessID;            {* Owning process ID*}

    cpuTime:            AbsoluteTime;           {* Accumulated task time*}
    schedTime:          AbsoluteTime;           {* Time when last scheduled*}
    creationTime:       AbsoluteTime;           {* Time when task created*}

    codePageFaults:     ItemCount;              {* Page faults from code execution*}
    dataPageFaults:     ItemCount;              {* Page faults from data access*}
    preemptions:        ItemCount;              {* Number of times task was preempted*}

    cpuID:              MPCpuID;                {* ID of CPU where task previously ran*}
  end;
  {$EXTERNALSYM MPTaskInfoVersion2}

  MPTaskInfo = record
    version:            PBVersion;              {* Version 2 of the data structure requested*}

    name:               OSType;                 {* Task name*}

    queueName:          OSType;                 {* Task's queue owner name*}
    runState:           Word;                   {* Running, ready, blocked*}
    lastCPU:            Word;                   {* Address of CPU where task previously ran*}
    weight:             Cardinal;               {* Processing weight: 1 - 10,000*}

    processID:          MPProcessID;            {* Owning process ID*}

    cpuTime:            AbsoluteTime;           {* Accumulated task time*}
    schedTime:          AbsoluteTime;           {* Time when last scheduled*}
    creationTime:       AbsoluteTime;           {* Time when task created*}

    codePageFaults:     ItemCount;              {* Page faults from code execution*}
    dataPageFaults:     ItemCount;              {* Page faults from data access*}
    preemptions:        ItemCount;              {* Number of times task was preempted*}

    cpuID:              MPCpuID;                {* ID of CPU where task previously ran*}
    blockedObject:      MPOpaqueID;             {* ID of blocked object.*}
    spaceID:            MPAddressSpaceID;       {* Address space ID of this task.*}

    stackBase:          LogicalAddress;         {* Base of stack (lowest address).*}
    stackLimit:         LogicalAddress;         {* Stack limit (highest address).*}
    stackCurr:          LogicalAddress;         {* Current stack address.*}
  end;
  {$EXTERNALSYM MPTaskInfo}

{*
    Upon a task exception, the following message is sent to the designated queue:
      1. The MPTaskID,
      2. The exception kind. These are enumerated in the interfaces header MachineExceptions.h
      3. N/A
*}

{* -------------------------------------------------------------------------------------------*}

{*
 *  MPSetExceptionHandler()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *}
function
MPSetExceptionHandler(
  task: MPTaskID;
  exceptionQ: MPQueueID): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPSetExceptionHandler}

{*
 *  MPDisposeTaskException()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *}
function
MPDisposeTaskException(
  task: MPTaskID;
  action: OptionBits): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPDisposeTaskException}

{*
 *  MPExtractTaskState()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *}
function
MPExtractTaskState(
  task: MPTaskID;
  kind: MPTaskStateKind;
  info: Pointer): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPExtractTaskState}

{*
 *  MPSetTaskState()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *}
function
MPSetTaskState(
  task: MPTaskID;
  kind: MPTaskStateKind;
  info: Pointer): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPSetTaskState}

{*
 *  MPThrowException()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *}
function
MPThrowException(
  task: MPTaskID;
  kind: MPExceptionKind): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPThrowException}

{* -------------------------------------------------------------------------------------------*}

type
  MPDebuggerLevel = Cardinal;
  {$EXTERNALSYM MPDebuggerLevel}

const
  kMPLowLevelDebugger           = $00000000; {* MacsBug-like*}
  {$EXTERNALSYM kMPLowLevelDebugger}
  kMPMidLevelDebugger           = $10000000; {* Jasik-like*}
  {$EXTERNALSYM kMPMidLevelDebugger}
  kMPHighLevelDebugger          = $20000000; {* Metrowerks-like*}
  {$EXTERNALSYM kMPHighLevelDebugger}

{*
 *  MPRegisterDebugger()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *}
function
MPRegisterDebugger(
  queue: MPQueueID;
  level: MPDebuggerLevel): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPRegisterDebugger}

{*
 *  MPUnregisterDebugger()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *}
function
MPUnregisterDebugger(queue: MPQueueID): OSStatus {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPUnregisterDebugger}



{*
   ===========================================================================================
   Remote Call Services
   ====================
*}

type
  MPRemoteProcedure = function (parameter: Pointer): Pointer cdecl;
  {$EXTERNALSYM MPRemoteProcedure}

  MPRemoteContext = Byte;
  {$EXTERNALSYM MPRemoteContext}

const
  kMPAnyRemoteContext           = 0;
  {$EXTERNALSYM kMPAnyRemoteContext}
  kMPOwningProcessRemoteContext = 1;
  {$EXTERNALSYM kMPOwningProcessRemoteContext}
  kMPInterruptRemoteContext     = 2;
  {$EXTERNALSYM kMPInterruptRemoteContext}
  kMPAsyncInterruptRemoteContext = 3;
  {$EXTERNALSYM kMPAsyncInterruptRemoteContext}

{*
 *  MPRemoteCall()
 *
 *  Summary:
 *    Calls a nonreentrant function and blocks the current task.
 *
 *  Discussion:
 *    You use this function primarily to indirectly execute Mac OS
 *    system software functions. The task making the remote call is
 *    blocked until the call completes. The amount of time taken to
 *    schedule the remote procedure depends on the choice of the
 *    designated operating context. Specifying kMPAnyRemoteContext
 *    offers the lowest latency, but the called procedure may not have
 *    access to process-specific resources such as some low-memory
 *    values. Specifying kMPOwningProcessRemoteContext has higher
 *    latency because the remote procedure is deferred until the owning
 *    process becomes active. However, the remote procedure is
 *    guaranteed to execute within the owning process. Note that with
 *    the exception of functions in Multiprocessing Services, you
 *    cannot safely call any system software functions directly from a
 *    preemptive task. Even if some system software function appears to
 *    work today when called from a preemptive task, unless explicitly
 *    stated otherwise there is no guarantee that subsequent versions
 *    of the same function will continue to work in future versions of
 *    system software. In Mac OS 8 implementations of Multiprocessing
 *    Services, the only exceptions to this rule are the atomic memory
 *    operations (such as AddAtomic ) exported in the InterfaceLib
 *    shared library. Even these functions may switch to 68K mode if
 *    the operands to them are not aligned. If you need to access
 *    system software functions from a preemptive task, you must do so
 *    using the MPRemoteCall function.
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Parameters:
 *
 *    remoteProc:
 *      A pointer of type MPRemoteProcedure that references the
 *      application-defined function you want to call. See
 *      MyRemoteProcedure for more information about the form of this
 *      function.
 *
 *    parameter:
 *      A pointer to a parameter to pass to the application-defined
 *      function. For example, this value could point to a data
 *      structure or a memory location.
 *
 *    context:
 *      A value of type MPRemoteContext that specifies which contexts
 *      (that is processes) are allowed to execute the function. See
 *      “Remote Call Context Option Constants” for a list of possible
 *      values.
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *}
function
MPRemoteCall(
  remoteProc: MPRemoteProcedure;
  parameter: Pointer;
  context: MPRemoteProcedure): Pointer {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPRemoteCall}

{*
 *  MPRemoteCallCFM()
 *
 *  Summary:
 *    Calls a nonreentrant function and blocks the current task.
 *
 *  Discussion:
 *    You use this function primarily to indirectly execute Mac OS
 *    system software functions. The task making the remote call is
 *    blocked until the call completes. The amount of time taken to
 *    schedule the remote procedure depends on the choice of the
 *    designated operating context. Specifying kMPAnyRemoteContext
 *    offers the lowest latency, but the called procedure may not have
 *    access to process-specific resources such as some low-memory
 *    values. Specifying kMPOwningProcessRemoteContext has higher
 *    latency because the remote procedure is deferred until the owning
 *    process becomes active. However, the remote procedure is
 *    guaranteed to execute within the owning process. Note that with
 *    the exception of functions in Multiprocessing Services, you
 *    cannot safely call any system software functions directly from a
 *    preemptive task. Even if some system software function appears to
 *    work today when called from a preemptive task, unless explicitly
 *    stated otherwise there is no guarantee that subsequent versions
 *    of the same function will continue to work in future versions of
 *    system software.
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Parameters:
 *
 *    remoteProc:
 *      A pointer of type MPRemoteProcedure to a CFM function that
 *      references the application-defined function you want to call.
 *      See MyRemoteProcedure for more information about the form of
 *      this function.
 *
 *    parameter:
 *      A pointer to a parameter to pass to the application-defined
 *      function. For example, this value could point to a data
 *      structure or a memory location.
 *
 *    context:
 *      A value of type MPRemoteContext that specifies which contexts
 *      (that is processes) are allowed to execute the function. See
 *      “Remote Call Context Option Constants” for a list of possible
 *      values.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *}
function
MPRemoteCallCFM(
  remoteProc: MPRemoteProcedure;
  parameter: Pointer;
  context: MPRemoteProcedure): Pointer {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM MPRemoteCallCFM}

{*
   ===========================================================================================
   Checking API Availability
   =========================
*}

(*
   ===========================================================================================
   *** WARNING: You must properly check the availability of MP services before calling them!
   ===========================================================================================

   Checking for the availability of the MP API is rather ugly.  This is a historical problem,
   caused by the original implementation letting itself get prepared when it really wasn't
   usable and complicated by some important clients then depending on weak linking to "work".
   (And further complicated by CFM not supporting "deferred" imports, which is how many
   programmers think weak imports work.)

   The end result is that the MP API library may get prepared by CFM but be totally unusable.
   This means that if you import from the MP API library, you cannot simply check for a
   resolved import to decide if MP services are available.  Worse, if you explicitly prepare
   the MP API library you cannot assume that a noErr result from GetSharedLibrary means that
   MP services are available.

   - If you import from the MP API library you MUST:

        Use the MPLibraryIsLoaded macro (or equivalent code in languages other than C) to tell
        if the MP API services are available.  It is not sufficient to simply check that an
        imported symbol is resolved as is commonly done for other libraries.  The macro expands
        to the expression:

            ( ( (UInt32)_MPIsFullyInitialized != (UInt32)kUnresolvedCFragSymbolAddress ) &&
              ( _MPIsFullyInitialized () ) )

        This checks if the imported symbol _MPIsFullyInitialized is resolved and if resolved
        calls it.  Both parts must succeed for the MP API services to be available.

   - If you explicitly prepare the MP API library you MUST:

        Use code similar to the following example to tell if the MP API services are available.
        It is not sufficient to depend on just a noErr result from GetSharedLibrary.

            OSErr                       err;
            Boolean                     mpIsAvailable           = false;
            CFragConnectionID           connID                  = kInvalidID;
            MPIsFullyInitializedProc    mpIsFullyInitialized    = NULL;

            err = GetSharedLibrary  ( "\pMPLibrary", kCompiledCFragArch, kReferenceCFrag,
                                      &connID, NULL, NULL );

            if ( err == noErr ) {
                err = FindSymbol    ( connID, "\p_MPIsFullyInitialized",
                                      (Ptr * ) &mpIsFullyInitialized, NULL );
            }

            if ( err == noErr ) {
                mpIsAvailable = (* mpIsFullyInitialized) ();
            }

   ===========================================================================================
*)

{*
 *  _MPIsFullyInitialized()
 *
 *  Mac OS X threading:
 *    Thread safe
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *}
function _MPIsFullyInitialized: Boolean; cdecl;
{$EXTERNALSYM _MPIsFullyInitialized}

type
  MPIsFullyInitializedProc = function: Boolean cdecl;
  {$EXTERNALSYM MPIsFullyInitializedProc}

const
  kMPUnresolvedCFragSymbolAddress = 0;
  {$EXTERNALSYM kMPUnresolvedCFragSymbolAddress}

function MPLibraryIsLoaded: Boolean; inline;
{$EXTERNALSYM MPLibraryIsLoaded}

{*
   ===========================================================================================
   Miscellaneous Services
   ======================
*}


{*
 *  _MPLibraryVersion()
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *}
procedure
_MPLibraryVersion(
  out versionCString: MarshaledAString;
  out major: Cardinal;
  out minor: Cardinal;
  out release: Cardinal;
  out revision: Cardinal) {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM _MPLibraryVersion}

{*
   ===========================================================================================
   Unofficial Services
   ===================
*}


{*
   ===========================================================================================
   *** WARNING ***
   These services are not part of the officially documented multiprocessing API.  They may not
   be avaliable in future versions of Mac OS multiprocessing support, or in environments that
   have a different underlying OS architecture such as Mac OS on top of a microkernel, the
   Mac OS Blue Box under Mac OS X, native MP support in Mac OS X, etc.
   ===========================================================================================
*}

{$IFDEF CALL_NOT_IN_CARBON}
{*
 *  _MPAllocateSys()
 *
 *  Availability:
 *    Mac OS X:         not available
 *    CarbonLib:        not available
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *}


{* Use MPAllocateAligned instead.*}
{*
 *  _MPRPC()
 *
 *  Availability:
 *    Mac OS X:         not available
 *    CarbonLib:        not available
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *}


{* Use _MPRemoteCall instead.*}
{*
 *  _MPTaskIsToolboxSafe()
 *
 *  Availability:
 *    Mac OS X:         not available
 *    CarbonLib:        not available
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *}


{$ENDIF}  {* CALL_NOT_IN_CARBON *}

{*
 *  _MPLibraryIsCompatible()
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *}
function
_MPLibraryIsCompatible(
  versionCString: MarshaledAString;
  major: Cardinal;
  minor: Cardinal;
  release: Cardinal;
  revision: Cardinal): Boolean {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{$EXTERNALSYM _MPLibraryIsCompatible}

{#define MPRPC                   _MPRPC
#define MPTaskIsToolboxSafe     _MPTaskIsToolboxSafe}

{*
   ===========================================================================================
   Defunct Services
   ================
*}

//#if CALL_NOT_IN_CARBON
//#ifndef MPIncludeDefunctServices
//#define MPIncludeDefunctServices 0
//#endif  {* !defined(MPIncludeDefunctServices) *}

//#if MPIncludeDefunctServices
{*
 *  _MPDebugStr()
 *
 *  Availability:
 *    Mac OS X:         not available
 *    CarbonLib:        not available
 *    Non-Carbon CFM:   in MPLibraryObsolete 1.0 and later
 *}


{*
 *  _MPStatusPString()
 *
 *  Availability:
 *    Mac OS X:         not available
 *    CarbonLib:        not available
 *    Non-Carbon CFM:   in MPLibraryObsolete 1.0 and later
 *}


{*
 *  _MPStatusCString()
 *
 *  Availability:
 *    Mac OS X:         not available
 *    CarbonLib:        not available
 *    Non-Carbon CFM:   in MPLibraryObsolete 1.0 and later
 *}



//#include <stdarg.h>
//typedef CALLBACK_API_C( void , MPPrintfHandler )(MPTaskID taskID, const char *format, va_list args);
{*
 *  _MPInitializePrintf()
 *
 *  Availability:
 *    Mac OS X:         not available
 *    CarbonLib:        not available
 *    Non-Carbon CFM:   in MPLibraryObsolete 1.0 and later
 *}


{*
 *  _MPPrintf()
 *
 *  Availability:
 *    Mac OS X:         not available
 *    CarbonLib:        not available
 *    Non-Carbon CFM:   in MPLibraryObsolete 1.0 and later
 *}


//#endif  {* MPIncludeDefunctServices *}

