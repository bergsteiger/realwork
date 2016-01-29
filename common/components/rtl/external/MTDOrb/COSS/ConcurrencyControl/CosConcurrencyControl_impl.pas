// **********************************************************************
//
// Copyright (c) 2002 MT Tools.
//
// All Rights Reserved
//
// MT_DORB is based in part on the product DORB,
// written by Shadrin Victor
//
// See Readme.txt for contact information
//
// **********************************************************************
unit CosConcurrencyControl_impl;

interface

uses SysUtils, Classes, orb_int, poa_int, map_int, CCS, CCS_int, MTDORBCCS,
  osthread;

type
  TCCS_LockSetFactory_impl = class(TCCS_LockSetFactory_serv)
  private
    FLockSetList: IStringInterfaceMap;
    FLockSetPOA: IPOA;
  protected
    function _create: ILockSet; override;
    function create_related(const which: ILockSet): ILockSet; override;
    function create_transactional: ITransactionalLockSet; override;
    function create_transactional_related(const which: ITransactionalLockSet): ITransactionalLockSet; override;
    function create_lockset(const object_name: AnsiString): ILockSet; override;
    function get_lockset(const object_name: AnsiString; const create: boolean): ILockSet; override;
  public
    constructor Create;
  end;

  ILockSetImpl = interface(IInterface)
  ['{F9F3D51B-312D-4AC8-8EE8-4A42F9CE7C4F}']
    procedure SetRelatedLockSet(const ARelatedLockSet: ILockSet);
  end;

  TUsedMode = array [Tlock_mode] of Integer;

  TLockSet_impl = class(TLockSet_serv, ILockSetImpl)
  private
    FRelatedLockSet: ILockSet;
    FUsedMode: TUsedMode;
    FMonitor: TThreadMonitor;
    function IsLockable(const Mode: Tlock_mode): Boolean;
    function IsRelatedLockSetLockable(const Mode: Tlock_mode): Boolean;
  protected
    procedure lock(const mode: Tlock_mode); override;
    function try_lock(const mode: Tlock_mode): boolean; override;
    procedure unlock(const mode: Tlock_mode); override;
    procedure change_mode(const held_mode: Tlock_mode; const new_mode: Tlock_mode); override;
    { ILockSetImpl }
    procedure SetRelatedLockSet(const ARelatedLockSet: ILockSet);
  public
    constructor Create;
    destructor Destroy; override;
  end;

procedure CCServiceInit(ORB: IORB; POA: IPOA; props: TStrings);

implementation

uses throw, poa_impl, bootmanager, bootmanager_int, exceptions, map;

procedure CCServiceInit(ORB: IORB; POA: IPOA; props: TStrings);
var
  bootManager: IBootManager;
  obj: IORBObject;
  factObj: TCCS_LockSetFactory_impl;
  serv: IServant;
begin
  assert(POA <> nil);
  factObj := TCCS_LockSetFactory_impl.Create();
  factObj.FLockSetPOA := POA.create_POA('LockSet', POA.the_POAManager(), nil);;
  serv := factObj as IServant;
  POA.activate_object_with_id('LockSetFactory', serv);
  obj := POA.servant_to_reference(serv);
  ORB.register_initial_reference('LockSetFactory', obj);

  //BootManager
  bootManager := TBootManager._narrow(ORB.resolve_initial_reference('BootManager'));
  if bootManager <> nil then
    bootManager.add_binding('LockSetFactory', obj);
end;

{ TCCS_LockSetFactory_impl }

constructor TCCS_LockSetFactory_impl.Create;
begin
  FLockSetList := TStringInterfaceMap.Create;
end;

(**
 * creates a new lock set or retrieve the existing lock set if existing
 * @param objectName the object name
 * @result the lock set associated to the object name
 *)
function TCCS_LockSetFactory_impl.create_lockset(
  const object_name: AnsiString): ILockSet;
var
  lockSet: TLockSet_impl;
begin
  Result := ILockSet(FLockSetList[object_name]);
  if Result <> nil then
    Exit;
  lockSet := TLockSet_impl.Create;
  try
    FLockSetPOA.activate_object(lockSet as IServant);
  except
    on E: Exception do
      raise INTERNAL.Create;
  end; { try/except }
  Result := lockSet._this();
  FLockSetList[object_name] := Result;
end;

(**
 * Creates a new lock set that is related to an existing lock set
 * @param which the existing lock set
 * @result the new lock set
 *)
function TCCS_LockSetFactory_impl.create_related(
  const which: ILockSet): ILockSet;
var
  relatedLockSet: TLockSet_impl;
  serv: IServant;
begin
  relatedLockSet := TLockSet_impl.Create;
  try
    FLockSetPOA.activate_object(relatedLockSet);
    serv := FLockSetPOA.reference_to_servant(which as IORBObject);
  except
    on E: Exception do
      raise INTERNAL.Create;
  end; { try/except }
  relatedLockSet.SetRelatedLockSet(which);
  (serv as ILockSetImpl).SetRelatedLockSet(relatedLockSet);
  Result := relatedLockSet._this();
end;

function TCCS_LockSetFactory_impl.create_transactional: ITransactionalLockSet;
begin
  raise NO_IMPLEMENT.Create();
end;

function TCCS_LockSetFactory_impl.create_transactional_related(
  const which: ITransactionalLockSet): ITransactionalLockSet;
begin
  raise NO_IMPLEMENT.Create();
end;

(**
 * retrieves the lock set of an object. you can precise to create it if it doesn't exist
 * @param objectName the object name
 * @param create if true, it creates a new lock set if not found
 * @result the lock set of the object
 *)
function TCCS_LockSetFactory_impl.get_lockset(const object_name: AnsiString;
  const create: boolean): ILockSet;
var
  lockSet: TLockSet_impl;
begin
  Result := ILockSet(FLockSetList[object_name]);
  if Result <> nil then
    Exit;
  if create then begin
    lockSet := TLockSet_impl.Create;
    try
      FLockSetPOA.activate_object(lockSet as IServant);
    except
      on E: Exception do
        raise INTERNAL.Create;
    end; { try/except }
    Result := lockSet._this();
    FLockSetList[object_name] := Result;
  end
  else
    raise TCCS_LockSetNotFound.Create;
end;

(**
 * creates a new lock set
 * @result the new lock set
 *)
function TCCS_LockSetFactory_impl._create: ILockSet;
var
  lockSet: TLockSet_impl;
begin
  lockSet := TLockSet_impl.Create;
  try
    FLockSetPOA.activate_object(lockSet as IServant);
  except
    on E: Exception do
      raise INTERNAL.Create;
  end; { try/except }
  Result := lockSet._this();
end;

{ TLockSet_impl }

(**
 * Changes the mode of a single lock
 * @param held_mode the current held mode
 * @param new_mode the new mode
 *)
procedure TLockSet_impl.change_mode(const held_mode, new_mode: Tlock_mode);
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMonitor);
  if (FUsedMode[held_mode] = 0) then
    raise TLockNotHeld.Create
  else begin
    Dec(FUsedMode[held_mode]);
    if FUsedMode[held_mode] < 0 then
      FUsedMode[held_mode] := 0;
    lock(new_mode);
    FMonitor.notifyAll;
  end;
end;

constructor TLockSet_impl.Create;
begin
  FMonitor := TThreadMonitor.Create;
end;

destructor TLockSet_impl.Destroy;
begin
  FMonitor.Free;
  inherited;
end;

(**
 * return whether the current lock mode permits the required lock mode
 * @param mode the required lock mode
 * @result true if the lock set can be locked to this mode
 *)
function TLockSet_impl.IsLockable(const Mode: Tlock_mode): Boolean;
begin
  Result := False;
  if FUsedMode[write] > 0 then
    Exit;
  case Mode of    //
    read: Result := FUsedMode[intention_read] = 0;
    write: Result := (FUsedMode[read] = 0) and (FUsedMode[write] = 0) and
      (FUsedMode[upgrade] = 0) and (FUsedMode[intention_read] = 0) and (FUsedMode[intention_write] = 0);
    upgrade: Result := (FUsedMode[upgrade] = 0) and (FUsedMode[intention_write] = 0);
    intention_read: Result := True;
    intention_write: Result := (FUsedMode[upgrade] = 0) and (FUsedMode[read] = 0);
  end;    // case
end;

(**
 * tests whether the related lock set can be locked in the required lock_mode
 * @mode the lock_mode
 * @result true if possible
 *)
function TLockSet_impl.IsRelatedLockSetLockable(
  const Mode: Tlock_mode): Boolean;
begin
  Result := True;
end;

(**
 * Acquires a lock on the specified lock set in the specified mode
 * @param mode the specified mode
 *)
procedure TLockSet_impl.lock(const mode: Tlock_mode);
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMonitor);
  while not IsLockable(mode) or not IsRelatedLockSetLockable(mode) do begin
    Inc(FUsedMode[mode]);
    try
      FMonitor.wait;
    finally
      Dec(FUsedMode[mode]);
    end; { try/finally }
  end;
  Inc(FUsedMode[mode]);
end;

(**
 * sets the related lock set
 * @param relatedLoscSet the related lock set
 *)
procedure TLockSet_impl.SetRelatedLockSet(const ARelatedLockSet: ILockSet);
begin
  FRelatedLockSet := ARelatedLockSet;
end;

(**
 * Attempts to acquire a lock on the specified lock set
 * @param mode the lock mode
 *)
function TLockSet_impl.try_lock(const mode: Tlock_mode): boolean;
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMonitor);
  Result := IsLockable(mode) and IsRelatedLockSetLockable(mode);
end;

(**
 * Drops a single lock on the specified lock set in the specified mode
 * @param mode the lock mode
 * @exception LockNotHeld if calls to a lock that is not held
 *)
procedure TLockSet_impl.unlock(const mode: Tlock_mode);
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMonitor);
  if FUsedMode[mode] > 0 then begin
    Dec(FUsedMode[mode]);
    if FUsedMode[mode] < 0 then
      FUsedMode[mode] := 0;
    FMonitor.notifyAll;
  end
  else
    raise TLockNotHeld.Create;
end;

end.
