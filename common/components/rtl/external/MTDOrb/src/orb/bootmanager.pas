// **********************************************************************
//
// Copyright (c) 2001 MT Tools.
//
// All Rights Reserved
//
// MT_DORB is based in part on the product DORB,
// written by Shadrin Victor
//
// See Readme.txt for contact information
//
// **********************************************************************
unit bootmanager;

interface

uses orbtypes, bootmanager_int, exceptions, except_int, orb, orb_int, Classes,
  osthread, iior_int, SysUtils;

type
  {** IDL:mg.org/BootManager/NotFound:1.0 }
  TNotFound = class(UserException,INotFound)
  protected
    procedure throw; override;
    function clone(): IORBException; override;
    function repoid(): RepositoryId; override;
  public
    class function EXCEPTION_DOWNCAST(const ex: IORBException): INotFound;
  end;

  {** IDL:mg.org/BootManager/AlreadyExists:1.0 }
  TAlreadyExists = class(UserException,IAlreadyExists)
  protected
    procedure throw; override;
    function clone(): IORBException; override;
    function repoid(): RepositoryId; override;
  public
    class function EXCEPTION_DOWNCAST(const ex: IORBException): IAlreadyExists;
  end;

  {** IDL:mg.org/BootManager:1.0 }
  TBootManager = class(TLocalORBObject,IBootManager)
  private
    FBindings: TStrings;
    FBindingsLock: TRecursiveMutex;
    FBootLocator: IBootLocator;
  protected
    procedure add_binding(const oid: ObjectId; const obj: IORBObject);
    procedure remove_binding(const oid: ObjectId);
    procedure set_locator(const locator: IBootLocator);
    function locate(const oid: ObjectId): IORBObject;//IIOR;
    function narrow_helper(const str: RepositoryId): Pointer; override;
  public
    constructor Create();
    destructor Destroy; override;
    class function _narrow(const obj : IORBObject): IBootManager;
  end;

  {** IDL:mg.org/BootLocator:1.0 }
  TBootLocator = class(TLocalORBObject,IBootLocator)
  protected
    procedure locate(const oid: ObjectId; out obj: IORBObject; out add: boolean);
    function narrow_helper(const str: RepositoryId): Pointer; override;
  public
    class function _narrow(const obj : IORBObject): IBootLocator;
  end;

implementation

//***********************************************************
// TNotFound
//***********************************************************
procedure TNotFound.throw;
begin
  raise TNotFound.Create();
end;

function TNotFound.clone(): IORBException;
begin
  result := TNotFound.Create();
end;

function TNotFound.repoid(): RepositoryId;
begin
  result := 'IDL:mg.org/BootManager/NotFound:1.0';
end;

class function TNotFound.EXCEPTION_DOWNCAST(
  const ex: IORBException): INotFound;
begin
  result := nil;
  if assigned(ex) and (ex.repoid = 'IDL:mg.org/BootManager/NotFound:1.0') then
    result := ex as INotFound;
end;

//***********************************************************
// TAlreadyExists
//***********************************************************
procedure TAlreadyExists.throw;
begin
  raise TAlreadyExists.Create();
end;

function TAlreadyExists.clone(): IORBException;
begin
  result := TAlreadyExists.Create();
end;

function TAlreadyExists.repoid(): RepositoryId;
begin
  result := 'IDL:mg.org/BootManager/AlreadyExists:1.0';
end;

class function TAlreadyExists.EXCEPTION_DOWNCAST(
  const ex: IORBException): IAlreadyExists;
begin
  result := nil;
  if assigned(ex) and (ex.repoid = 'IDL:mg.org/BootManager/AlreadyExists:1.0') then
    result := ex as IAlreadyExists;
end;

//***********************************************************
// TBootManager
//***********************************************************
constructor TBootManager.Create;
begin
  inherited;
  FBindings := TStringList.Create;
  FBindingsLock := TRecursiveMutex.Create;
end;

destructor TBootManager.Destroy;
var
  i: integer;
begin
  FBindingsLock.lock;
  try
    for i := 0 to FBindings.Count - 1 do
      IInterface(Pointer(FBindings.Objects[i]))._Release;
  finally
    FBindingsLock.unlock;
  end; { try/finally }
  FreeAndNil(FBindings);
  FreeAndNil(FBindingsLock);
  inherited;
end;

function TBootManager.narrow_helper(const str: RepositoryId): Pointer;
begin
  result := nil;
  if str = 'IDL:mg.org/BootManager:1.0' then
    begin
      result := Pointer(self as IBootManager);
      exit;
    end;
end;

class function TBootManager._narrow(const obj : IORBObject): IBootManager;
var
  p: Pointer;
begin
  result := nil;
  if obj = nil then exit;
  p := obj.narrow_helper('IDL:mg.org/BootManager:1.0');
  if p <> nil then
    result := IBootManager(p);
end;

procedure TBootManager.add_binding(const oid: ObjectId;
  const obj: IORBObject);
var
  sync: ISynchronized;
  ex: IORBException;
begin
  sync := TSynchronized.Create(FBindingsLock);

  if FBindings.IndexOf(String(oid)) <> -1 then begin
    ex := TAlreadyExists.Create() as IORBException;
    ex.throw;
  end;

  obj._AddRef;
  FBindings.AddObject(String(oid), Pointer(obj));
end;

procedure TBootManager.remove_binding(const oid: ObjectId);
var
  sync: ISynchronized;
  ex: IORBException;
  idx: integer;
  obj: IORBObject;
begin
  sync := TSynchronized.Create(FBindingsLock);

  idx := FBindings.IndexOf(String(oid));
  if idx = -1 then begin
    ex := TNotFound.Create() as IORBException;
    ex.throw;
  end;

  obj := IORBObject(Pointer(FBindings.Objects[idx]));
  obj._Release;
  FBindings.Delete(idx);
end;

procedure TBootManager.set_locator(const locator: IBootLocator);
begin
  FBootLocator := locator;
end;

function TBootManager.locate(const oid: ObjectId): IORBObject;//IIOR;
var
  sync: ISynchronized;
  idx: integer;
  obj: IORBObject;
  add: boolean;
begin
  sync := TSynchronized.Create(FBindingsLock);

  idx := FBindings.IndexOf(String(oid));
  if idx = -1 then begin
    if FBootLocator <> nil then begin
      try
        FBootLocator.locate(oid, obj, add);
        if add then begin
          obj._AddRef;
          FBindings.AddObject(String(oid), Pointer(obj));
        end;
        result := obj;
      except
        on E: TNotFound do ;
        else
          raise;
      end; { try/except }
    end;
  end
  else
    result := IORBObject(Pointer(FBindings.Objects[idx]));
end;

//***********************************************************
// TBootLocator
//***********************************************************
function TBootLocator.narrow_helper(const str: RepositoryId): Pointer;
begin
  result := nil;
  if str = 'IDL:mg.org/BootLocator:1.0' then
    begin
      result := Pointer(self as IBootLocator);
      exit;
    end;
end;

class function TBootLocator._narrow(const obj : IORBObject): IBootLocator;
var
  p: Pointer;
begin
  result := nil;
  if obj = nil then exit;
  p := obj.narrow_helper('IDL:mg.org/BootLocator:1.0');
  if p <> nil then
    result := IBootLocator(p);
end;

procedure TBootLocator.locate(const oid: ObjectId; out obj: IORBObject;
  out add: boolean);
begin

end;

end.
