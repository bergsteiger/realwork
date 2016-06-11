{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{              FireDAC interface factories              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Stan.Factory;

interface

uses
  System.SysUtils, System.Classes,
  FireDAC.Stan.Intf;

type
  TFDObject = class;
  TFDObjectClass = class of TFDObject;
  TFDFactory = class;
  TFDSingletonFactory = class;
  TFDMultyInstanceFactory = class;

  TFDObject = class(TInterfacedObject,
    {$IFNDEF FireDAC_SkipIUnk} IUnknown, {$ENDIF} IFDStanComponentReference)
  private
    FComponentReference: IInterfaceComponentReference;
  protected
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    // IFDStanComponentReference
    procedure SetComponentReference(const AValue: IInterfaceComponentReference);
    // etc
    class function IsFactoryEnabled(const AMyProvider, AReqProvider: String): Boolean; virtual;
    procedure Finalize; virtual;
  public
    function FDDecRef(const AValue: Integer = 1): Integer;
    function FDAddRef(const AValue: Integer = 1): Integer;
    constructor Create; virtual;
    procedure Initialize; virtual;
    destructor Destroy; override;
  end;

  TFDFactory = class(TObject)
  private
    FClass: TFDObjectClass;
    FClassID: TGUID;
    FProviders: TStringList;
  protected
    function CreateObject(const AProvider: String): TObject; virtual; abstract;
    function Match(const AIID: TGUID; const AProvider: String; AValidate: Boolean): Boolean; virtual;
  public
    constructor Create(AClass: TFDObjectClass; const AClassID: TGUID;
      const AProviders: String = '');
    destructor Destroy; override;
    procedure GetProviders(AList: TStrings);
  end;

  TFDSingletonFactory = class(TFDFactory)
  private
    FSingleton: TFDObject;
    FSingletonIntf: IUnknown;
  protected
    function CreateObject(const AProvider: String): TObject; override;
  public
    destructor Destroy; override;
  end;

  TFDMultyInstanceFactory = class(TFDFactory)
  protected
    function CreateObject(const AProvider: String): TObject; override;
  end;

  procedure FDCreateInterface(const AIID: TGUID; out AIntf;
    const ARequired: Boolean = True; const AProvider: String = '');
  procedure FDGetProviders(const AIID: TGUID; AList: TStrings);
  function FDGetUnit(const AIID: TGUID; const AProvider: String = ''): String;
  procedure FDReleaseFactory(var AFactory: TFDFactory);
  procedure FDTerminate;

implementation

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF}
  System.Generics.Collections, System.Types, System.SyncObjs,
  FireDAC.Stan.ResStrs, FireDAC.Stan.Util, FireDAC.Stan.Consts,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.UI.Intf;

{ ---------------------------------------------------------------------------- }
{ TFDManager                                                                   }
{ ---------------------------------------------------------------------------- }
type
  TFDManager = class(TObject)
  private
    FFactories: TFDObjList;
    FLock: TCriticalSection;
    FObjects: Integer;
    function Find(const AIID: TGUID; const AProvider: String; AValidate: Boolean): Integer;
    procedure GetProviders(const AIID: TGUID; AList: TStrings);
    function GetUnit(const AIID: TGUID; const AProvider: String): String;
    procedure AddObj;
    procedure RemObj;
  public
    constructor Create;
    destructor Destroy; override;
    procedure CreateInterface(const AIID: TGUID; out AIntf; ARequired: Boolean;
      const AProvider: String);
    procedure AddFactory(AFactory: TFDFactory);
    procedure RemoveFactory(AFactory: TFDFactory);
  end;

var
  GTerminating: Boolean;
  GManager: TFDManager;

{ ---------------------------------------------------------------------------- }
constructor TFDManager.Create;
begin
  inherited Create;
  FFactories := TFDObjList.Create;
  FLock := TCriticalSection.Create;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDManager.AddFactory(AFactory: TFDFactory);
begin
  FLock.Enter;
  try
    FFactories.Add(AFactory);
  finally
    FLock.Leave;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDManager.RemoveFactory(AFactory: TFDFactory);
begin
  FLock.Enter;
  try
    FFactories.Remove(AFactory);
  finally
    FLock.Leave;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TFDManager.Find(const AIID: TGUID; const AProvider: String;
  AValidate: Boolean): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to FFactories.Count - 1 do
    if TFDFactory(FFactories[i]).Match(AIID, AProvider, AValidate) then begin
      Result := i;
      Break;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDManager.GetProviders(const AIID: TGUID; AList: TStrings);
var
  i: Integer;
  oFact: TFDFactory;
begin
  for i := 0 to FFactories.Count - 1 do begin
    oFact := TFDFactory(FFactories[i]);
    if IsEqualGUID(AIID, oFact.FClassID) then
      oFact.GetProviders(AList);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TFDManager.GetUnit(const AIID: TGUID; const AProvider: String): String;
var
  i: Integer;
  oFact: TFDFactory;
begin
  i := Find(AIID, AProvider, False);
  if i >= 0 then begin
    oFact := TFDFactory(FFactories[i]);
    if oFact.FClass <> nil then
      Result := oFact.FClass.UnitName;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDManager.CreateInterface(const AIID: TGUID; out AIntf; ARequired: Boolean;
  const AProvider: String);
var
  i: Integer;
  oObj: TObject;
  oFact: TFDFactory;

  procedure ObjFactMissError;
  var
    s, sProv: String;
  begin
    if IsEqualGUID(AIID, IFDGUIxWaitCursor) then
      s := Format(S_FD_StanHowToReg, ['TFDGUIxWaitCursor'])
    else if IsEqualGUID(AIID, IFDGUIxAsyncExecuteDialog) then
      s := Format(S_FD_StanHowToReg, ['TFDGUIxAsyncExecuteDialog'])
    else if IsEqualGUID(AIID, IFDGUIxErrorDialog) then
      s := Format(S_FD_StanHowToReg, ['TFDGUIxErrorDialog'])
    else if IsEqualGUID(AIID, IFDGUIxLoginDialog) then
      s := Format(S_FD_StanHowToReg, ['TFDGUIxLoginDialog'])
    else if IsEqualGUID(AIID, IFDGUIxScriptDialog) then
      s := Format(S_FD_StanHowToReg, ['TFDGUIxScriptDialog'])
    else if IsEqualGUID(AIID, IFDPhysManager) then
      s := Format(S_FD_StanHowToReg, ['TFDPhysXXXDriverLink'])
{$IFDEF FireDAC_MONITOR}
    else if IsEqualGUID(AIID, IFDMoniRemoteClient) then
      s := Format(S_FD_StanHowToReg, ['TFDMoniRemoteClientLink'])
    else if IsEqualGUID(AIID, IFDMoniCustomClient) then
      s := Format(S_FD_StanHowToReg, ['TFDMoniCustomClientLink'])
    else if IsEqualGUID(AIID, IFDMoniFlatFileClient) then
      s := Format(S_FD_StanHowToReg, ['TFDMoniFlatFileClientLink'])
{$ENDIF}
    else if IsEqualGUID(AIID, IFDDAptTableAdapter) or
            IsEqualGUID(AIID, IFDDAptSchemaAdapter) then
      s := Format(S_FD_StanHowToInc, ['FireDAC.DApt'])
    else if IsEqualGUID(AIID, IFDStanObjectFactory) then
      s := Format(S_FD_StanHowToInc, ['FireDAC.Stan.Pool'])
    else if IsEqualGUID(AIID, IFDStanAsyncExecutor) then
      s := Format(S_FD_StanHowToInc, ['FireDAC.Stan.Async'])
    else if IsEqualGUID(AIID, IFDStanExpressionParser) then
      s := Format(S_FD_StanHowToInc, ['FireDAC.Stan.Expr'])
    else if IsEqualGUID(AIID, IFDStanConnectionDefs) or
            IsEqualGUID(AIID, IFDStanConnectionDef) or
            IsEqualGUID(AIID, IFDStanDefinition) or
            IsEqualGUID(AIID, IFDStanDefinitions) or
            IsEqualGUID(AIID, IFDStanDefinitionStorage) then
      s := Format(S_FD_StanHowToInc, ['FireDAC.Stan.Def'])
    else
      s := '';
    if AProvider <> '' then
      sProv := ', provider [' + AProvider + '],'
    else
      sProv := '';
    raise Exception.CreateFmt('Object factory for class %s%s is missing. ' + s,
      [GUIDToString(AIID), sProv]);
  end;

  procedure IntfNotImplError;
  begin
    raise Exception.CreateFmt('Class [%s] does not implement interface [%s]',
      [oFact.FClass.ClassName, GUIDToString(AIID)]);
  end;

begin
  FLock.Enter;
  try
    i := Find(AIID, AProvider, True);
    if i = -1 then begin
      if not ARequired then begin
        IUnknown(AIntf) := nil;
        Exit;
      end;
      ObjFactMissError;
    end;
    oFact := TFDFactory(FFactories[i]);
  finally
    FLock.Leave;
  end;
  oObj := oFact.CreateObject(AProvider);
  if oObj is TFDObject then begin
    if TFDObject(oObj).QueryInterface(AIID, AIntf) <> 0 then
      IntfNotImplError;
  end
  else begin
    if not oObj.GetInterface(AIID, AIntf) then
      IntfNotImplError;
  end;
end;

{ ---------------------------------------------------------------------------- }
destructor TFDManager.Destroy;
var
  i: Integer;
begin
  FLock.Enter;
  for i := FFactories.Count - 1 downto 0 do
    FDFree(TFDFactory(FFactories[i]));
  FDFreeAndNil(FFactories);
  FDFreeAndNil(FLock);
  GManager := nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDManager.AddObj;
begin
  AtomicIncrement(FObjects);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDManager.RemObj;
begin
  AtomicDecrement(FObjects);
end;

{ ---------------------------------------------------------------------------- }
procedure FDCreateInterface(const AIID: TGUID; out AIntf;
  const ARequired: Boolean = True; const AProvider: String = '');
begin
  if GTerminating then
    IUnknown(AIntf) := nil
  else
    GManager.CreateInterface(AIID, AIntf, ARequired, AProvider);
end;

{ ---------------------------------------------------------------------------- }
procedure FDGetProviders(const AIID: TGUID; AList: TStrings);
begin
  if not GTerminating then
    GManager.GetProviders(AIID, AList);
end;

{ ---------------------------------------------------------------------------- }
function FDGetUnit(const AIID: TGUID; const AProvider: String = ''): String;
begin
  if not GTerminating then
    Result := GManager.GetUnit(AIID, AProvider)
  else
    Result := '';
end;

{ ---------------------------------------------------------------------------- }
procedure FDReleaseFactory(var AFactory: TFDFactory);
begin
  // At design time (actually, when FireDAC is packaged) the factories must be
  // destroyed in the implementation unit finilization sections (see FD-0261).
  // At run time (actually, when FireDAC is not packaged) the FDManager must
  // destroy the factories. Because the units finalization order is not
  // dependent on the FireDAC services dependency, so a factory may be destroyed
  // before all it interfaces will be released.
  if FDIsDesignTime then
    FDFreeAndNil(AFactory);
end;

{ ---------------------------------------------------------------------------- }
procedure FDTerminate;
begin
  if not GTerminating then begin
    GTerminating := True;
    FDFreeAndNil(GManager);
  end;
end;

{ ---------------------------------------------------------------------------- }
{ TFDObject                                                                    }
{ ---------------------------------------------------------------------------- }
constructor TFDObject.Create;
begin
  inherited Create;
  Initialize;
  if GManager <> nil then
    GManager.AddObj;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDObject.Initialize;
begin
  // nothing
end;

{ ---------------------------------------------------------------------------- }
destructor TFDObject.Destroy;
begin
  if GManager <> nil then
    GManager.RemObj;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TFDObject.QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
begin
  Result := inherited QueryInterface(IID, Obj);
  if (Result = E_NOINTERFACE) and Assigned(FComponentReference) then
    Result := FComponentReference.QueryInterface(IID, Obj);
end;

{ ---------------------------------------------------------------------------- }
function TFDObject.FDAddRef(const AValue: Integer = 1): Integer;
begin
  if AValue = 1 then
    Result := AtomicIncrement(FRefCount)
  else begin
    Inc(FRefCount, AValue);
    Result := FRefCount;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TFDObject.FDDecRef(const AValue: Integer = 1): Integer;
begin
  if AValue = 1 then
    Result := AtomicDecrement(FRefCount)
  else begin
    Dec(FRefCount, AValue);
    Result := FRefCount;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDObject.SetComponentReference(const AValue: IInterfaceComponentReference);
begin
  FComponentReference := AValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDObject.Finalize;
begin
  // none
end;

{ ---------------------------------------------------------------------------- }
class function TFDObject.IsFactoryEnabled(const AMyProvider, AReqProvider: String): Boolean;
begin
  Result := CompareText(AMyProvider, AReqProvider) = 0;
end;

{ ---------------------------------------------------------------------------- }
{ TFDFactory                                                                   }
{ ---------------------------------------------------------------------------- }
constructor TFDFactory.Create(AClass: TFDObjectClass; const AClassID: TGUID;
  const AProviders: String = '');
begin
  inherited Create;
  FClass := AClass;
  FClassID := AClassID;
  FProviders := TFDStringList.Create(#0, ';');
  FProviders.DelimitedText := AProviders;
  GManager.AddFactory(Self);
end;

{ ---------------------------------------------------------------------------- }
destructor TFDFactory.Destroy;
begin
  FDFreeAndNil(FProviders);
  if GManager <> nil then
    GManager.RemoveFactory(Self);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDFactory.GetProviders(AList: TStrings);
var
  sProv: String;
begin
  for sProv in FProviders do
    AList.Add(sProv + '=' + FClass.UnitName);
end;

{ ---------------------------------------------------------------------------- }
function TFDFactory.Match(const AIID: TGUID; const AProvider: String;
  AValidate: Boolean): Boolean;

  function MatchProviders: Boolean;
  var
    sProv: String;
  begin
    Result := (FProviders.Count = 0) and (AProvider = '');
    if not Result then
      for sProv in FProviders do
        if AValidate and FClass.IsFactoryEnabled(sProv, AProvider) or
           not AValidate and TFDObject.IsFactoryEnabled(sProv, AProvider) then begin
          Result := True;
          Break;
        end;
  end;

begin
  Result := IsEqualGUID(AIID, FClassID) and ((FClass = nil) or MatchProviders);
end;

{ ---------------------------------------------------------------------------- }
{ TFDSingletonFactory                                                          }
{ ---------------------------------------------------------------------------- }
function TFDSingletonFactory.CreateObject(const AProvider: String): TObject;
begin
  if FSingleton = nil then begin
    FSingleton := FClass.Create;
    FSingletonIntf := FSingleton as IUnknown;
  end;
  Result := FSingleton;
end;

{ ---------------------------------------------------------------------------- }
destructor TFDSingletonFactory.Destroy;
begin
  if FSingleton <> nil then
    FSingleton.Finalize;
  if not GTerminating and (FSingleton <> nil) and (FSingleton.RefCount > 1) then
    FDSystemMessage(C_FD_Product + ' Warning', 'Class [' + FClass.ClassName +
      '] singleton factory has unreleased interfaces', True);
  FSingletonIntf := nil;
  FSingleton := nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
{ TFDMultyInstanceFactory                                                      }
{ ---------------------------------------------------------------------------- }
function TFDMultyInstanceFactory.CreateObject(const AProvider: String): TObject;
begin
  Result := FClass.Create;
end;

{ ---------------------------------------------------------------------------- }
initialization
  GTerminating := False;
  GManager := TFDManager.Create;

{ ---------------------------------------------------------------------------- }
finalization
  FDTerminate;

end.
