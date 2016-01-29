{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBXClassRegistry;

interface

uses
  System.Classes,
  System.Generics.Collections,
  System.SysUtils
;

type
  // TObject constructor is not virtual, so allow for virtual constructor
  // for registered Objects.
  //
  TClassRegistryObject = class
  public
    constructor Create; virtual;
  end;

  EClassRegistryError = class(Exception);

  TClassRegistryPackageItem = class
  private
    FPackageName: string;
{$IFNDEF NEXTGEN}
    FPackageHandle: HMODULE;
{$ENDIF !NEXTGEN}
    constructor Create(PackageName: string);
  public
    destructor Destroy; override;
  end;

  TClassRegistry = class
  private
    FLock: TThreadList;
    FClasses: TDictionary<string, TClass>;
    FPackages: TDictionary<string, TClassRegistryPackageItem>;
    FCanDestroy: Boolean;
    class var ClassRegistry: TClassRegistry;
  public
    constructor Create;
    destructor Destroy; override;
    class function GetClassRegistry: TClassRegistry;
    procedure RegisterPackageClass(ClassName: string;
      PackageName: string);
    procedure RegisterClass(ClassName: string; ObjectClass: TClass);
    procedure RegisterRegistryClass(ClassName: string;
      RegistryClass: TClass);
    procedure UnregisterClass(ClassName: string);
    function HasClass(ClassName: string): Boolean;
    function CreateInstance(ClassName: string): TObject;
  end;

implementation

uses
  Data.DBXCommonResStrs, System.Generics.Defaults;

{ TClassRegistry }

constructor TClassRegistry.Create;
begin
  inherited Create;
  FLock       := TThreadList.Create;
  FClasses    := TDictionary<string, TClass>.Create(TIStringComparer.Ordinal);
  FPackages   := TObjectDictionary<string, TClassRegistryPackageItem>.Create([doOwnsValues], TIStringComparer.Ordinal);
  FCanDestroy := true;
end;

destructor TClassRegistry.Destroy;
begin
  if not FCanDestroy then
    raise EClassRegistryError.Create(SCannotFreeClassRegistry);
  FreeAndNil(FLock);
  FClasses.Free;
  FPackages.Free;
end;

function TClassRegistry.CreateInstance(ClassName: string): TObject;
begin
  FLock.LockList;
  try
    if not FClasses.ContainsKey(ClassName) then
      raise EClassRegistryError.Create(Format(SNotRegistered, [ClassName]));
  finally
    FLock.UnlockList;
  end;
  // To improve performance, create the instance out of the critical section.
  //
  Result := FClasses.Items[ClassName].Create;
end;

class function TClassRegistry.GetClassRegistry: TClassRegistry;
begin
  if TClassRegistry.ClassRegistry = nil then
  begin
    TClassRegistry.ClassRegistry := TClassRegistry.Create;
    TClassRegistry.ClassRegistry.FCanDestroy := false;
  end;
  Result := ClassRegistry;
end;

function TClassRegistry.HasClass(ClassName: string): Boolean;
begin
  Result := FClasses.ContainsKey(ClassName);
end;

procedure TClassRegistry.RegisterClass(ClassName: string;
  ObjectClass: TClass);
begin
  if ObjectClass = nil then
    raise EClassRegistryError.Create(Format(SInvalidClassRegister, [ClassName]));

  FLock.LockList;
  try
    if FClasses.ContainsKey(ClassName) then
    begin
      // Subtle.  Get here on .net if RegisterPackageClass was called first
      // and then the initialization section is consequently invoked
      // and calls RegisterClass.  The initial RegisterPackageClass did
      // not have the class reference, so it is nil.  Corner case resulting
      // from a general system for static and dynamic linkage across native
      // and managed code.
      //
      if FClasses.Items[ClassName] <> nil then
        raise EClassRegistryError.Create(Format(SAlreadyRegistered, [ClassName]));
      FClasses.Items[ClassName] := ObjectClass;
    end
    else
      FClasses.Add(ClassName, ObjectClass);
  finally
    FLock.UnlockList;
  end;
end;

procedure TClassRegistry.RegisterRegistryClass(ClassName: string;
  RegistryClass: TClass);
begin
  if RegistryClass = nil then
    raise EClassRegistryError.Create(Format(SInvalidClassRegister, [ClassName]));
  FLock.LockList;
  try
    if FClasses.ContainsKey(ClassName) then
    begin
      // Subtle.  Get here on .net if RegisterPackageClass was called first
      // and then the initialization section is consequently invoked
      // and calls RegisterClass.  The initial RegisterPackageClass did
      // not have the class reference, so it is nil.  Corner case resulting
      // from a general system for static and dynamic linkage across native
      // and managed code.
      //
      if FClasses.Items[ClassName] <> nil then
        raise EClassRegistryError.Create(Format(SAlreadyRegistered, [ClassName]));
    end
    else
      FClasses.Add(ClassName, RegistryClass);
  finally
    FLock.UnlockList;
  end;
end;

procedure TClassRegistry.RegisterPackageClass(ClassName,
  PackageName: string);
var
  PackageItem: TClassRegistryPackageItem;
begin
  FLock.LockList;
  try
    if FClasses.ContainsKey(ClassName) then
      raise EClassRegistryError.Create(Format(SAlreadyRegistered, [ClassName]));
    // native unit initialization section is invoked when the package was loaded.
    //
    if not FPackages.ContainsKey(PackageName) then
    begin
      PackageItem := TClassRegistryPackageItem.Create(PackageName);
      try
        FPackages.Add(PackageName, PackageItem);
      except
        PackageItem.Free;
        raise;
      end;
    end;
    if not FClasses.ContainsKey(ClassName) then
      FClasses.Add(ClassName, nil);
  finally
    FLock.UnlockList;
  end;
end;

procedure TClassRegistry.UnregisterClass(ClassName: string);
begin
  FLock.LockList;
  try
    if FClasses.ContainsKey(ClassName) then
      FClasses.Remove(ClassName);
  finally
    FLock.UnlockList;
  end;
end;


{ TClassRegistryPackageItem }

constructor TClassRegistryPackageItem.Create(PackageName: string);
begin
  inherited Create;
  FPackageName := PackageName;
{$IFNDEF NEXTGEN}
  FPackageHandle := LoadPackage(PackageName);
{$ENDIF !NEXTGEN}
end;

destructor TClassRegistryPackageItem.Destroy;
begin
{$IFNDEF NEXTGEN}
  if FPackageHandle <> 0 then
    UnloadPackage(FPackageHandle);
{$ENDIF !NEXTGEN}
  inherited;
end;

{ TClassRegistryObject }

constructor TClassRegistryObject.Create;
begin
  inherited Create;
end;

initialization
finalization
  if TClassRegistry.ClassRegistry <> nil then
  begin
    TClassRegistry.ClassRegistry.FCanDestroy := true;
    FreeAndNil(TClassRegistry.ClassRegistry);
  end;
end.







