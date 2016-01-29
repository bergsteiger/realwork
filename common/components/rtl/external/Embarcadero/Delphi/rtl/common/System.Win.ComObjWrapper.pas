{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit System.Win.ComObjWrapper;

interface

uses
  System.Classes, System.Win.ComObj;

type

{ TComComponent }

  TWrappedComObject = class;
  TComComponent = class;

  TGetComClassEvent = procedure(Sender: TComComponent; var ComClass: TComClass) of object;
  TComObjectEvent = procedure(Sender: TComComponent; const ComObject: TWrappedComObject) of object;

  TComComponent = class(TComponent)
  private
    FDescription: string;
    FGUID: TGUID;
    FOnGetComClass: TGetComClassEvent;
    FOnCreated: TComObjectEvent;
    FOnDestroy: TComObjectEvent;
    procedure SetGUIDString(const Value: string);
    procedure RegisterClass; virtual;
    procedure UnregisterClass; virtual;
    function GetGUIDString: string;
  protected
    procedure DoCreated(const ComObj: TWrappedComObject); virtual;
    procedure DoDestroy(const ComObj: TWrappedComObject); virtual;
    function GetComClass: TComClass; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CreateObject: IUnknown;
    property Description: string read FDescription write FDescription;
    property GUID: string read GetGUIDString write SetGUIDString;
    property OnGetComClass: TGetComClassEvent read FOnGetComClass write FOnGetComClass;
    property OnCreated: TComObjectEvent read FOnCreated write FOnCreated;
    property OnDestroy: TComObjectEvent read FOnDestroy write FOnDestroy;
  end;

{ TWrappedComObject }

  TWrappedComObject = class(TComObject)
  private
    FComComponent: TComComponent;
  protected
    property ComComponent: TComComponent read FComComponent;
  public
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure Initialize; override;
  end;

implementation

uses
  Winapi.Windows, Winapi.ActiveX,
  System.SysUtils, System.RTLConsts, System.Generics.Collections;

type
  TCOMServer = class(TComServerObject)
  private
    FObjectCount: Integer;
    FFactoryCount: Integer;
    FHelpFileName: string;
    procedure FactoryFree(Factory: TComObjectFactory);
  protected
    function CountObject(Created: Boolean): Integer; override;
    function CountFactory(Created: Boolean): Integer; override;
    function GetHelpFileName: string; override;
    function GetServerFileName: string; override;
    function GetServerKey: string; override;
    function GetServerName: string; override;
    function GetStartSuspended: Boolean; override;
    function GetTypeLib: ITypeLib; override;
    procedure SetHelpFileName(const Value: string); override;
  public
    destructor Destroy; override;
  end;

var
  COMComponents: TThreadList<TComComponent>;
  COMServersList: TList<TComServer>;
  COMClassesList: TList<TComClass>;

procedure CheckForDuplicateGUID(const AGUID: TGUID);
var
  I: Integer;
  Component: TCOMComponent;
begin
  if COMComponents = nil then
    raise Exception.Create(SNoCOMClassesRegistered);
  with COMComponents.LockList do
  try
    for I := 0 to Count - 1 do
    begin
      Component := Items[I];
      if IsEqualGUID(StringToGUID(Component.GUID), AGUID) then
        raise Exception.CreateFmt(SGUIDAlreadyDefined, [GUIDToString(AGUID)]);
    end;
  finally
    COMComponents.UnlockList;
  end;
end;

function ShortToLongFileName(FileName: string): string;
var
  FindData: TWin32FindData;
  Search: THandle;
begin
  Result := '';
  // Strip off one directory level at a time starting with the file name
  // and store it into the result. FindFirstFile will return the long file
  // name from the short file name.
  while (True) do
  begin
    Search := Winapi.Windows.FindFirstFile(PChar(FileName), FindData);
    if Search = INVALID_HANDLE_VALUE then
      Break;
    Result := string('\') + FindData.cFileName + Result;  { do not localize }
    FileName := ExtractFileDir(FileName);
    Winapi.Windows.FindClose(Search);
    // Found the drive letter followed by the colon.
    if Length(FileName) <= 2 then
      Break;
  end;
  Result := ExtractFileDrive(FileName) + Result;
end;

function GetModuleFileName: string;
var
  Buffer: array[0..MAX_PATH + 1] of Char;
begin
  SetString(Result, Buffer, Winapi.Windows.GetModuleFileName(MainInstance,
    Buffer, Length(Buffer)));
  Result := ShortToLongFileName(Result);
end;

function GetModuleName: string;
begin
  Result := ChangeFileExt(ExtractFileName(GetModuleFileName), '');
end;

function COMServer(ComClass: TComClass): TCOMServer;
var
  Idx: Integer;
begin
  if COMClass = nil then
    raise Exception.Create(SNoCOMClassSpecified);
  if COMClassesList = nil then
    COMClassesList := TList<TComClass>.Create;
  Idx := COMClassesList.IndexOf(ComClass);
  if Idx = -1 then
  begin
    COMClassesList.Add(ComClass);
    Result := TCOMServer.Create;
    if COMServersList = nil then
      COMServersList := TList<TComServer>.Create;
    COMServersList.Add(Result);
  end
  else
    Result := COMServersList.Items[Idx];
end;

{ TCOMServer }

function TCOMServer.CountFactory(Created: Boolean): Integer;
begin
  if Created then
    Result := AtomicIncrement(FFactoryCount)
  else
    Result := AtomicDecrement(FFactoryCount);
end;

function TCOMServer.CountObject(Created: Boolean): Integer;
begin
  if Created then
    Result := AtomicIncrement(FObjectCount)
  else
    Result := AtomicDecrement(FObjectCount);
end;

destructor TCOMServer.Destroy;
begin
  ComClassManager.ForEachFactory(Self, FactoryFree);
  inherited;
end;

procedure TCOMServer.FactoryFree(Factory: TComObjectFactory);
begin
  Factory.Free;
end;

function TCOMServer.GetHelpFileName: string;
begin
  Result := FHelpFileName;
end;

function TCOMServer.GetServerFileName: string;
begin
  Result := GetModuleFileName;
end;

function TCOMServer.GetServerKey: string;
begin
  Result := 'LocalServer32';    { do not localize }
end;

function TCOMServer.GetServerName: string;
begin
  Result := GetModuleName;
end;

function TCOMServer.GetStartSuspended: Boolean;
begin
  Result := False;
end;

function TCOMServer.GetTypeLib: ITypeLib;
begin
  Result := nil;
end;

procedure TCOMServer.SetHelpFileName(const Value: string);
begin
  FHelpFileName := Value;
end;

{ TComComponent }

constructor TComComponent.Create(AOwner: TComponent);
begin
  inherited;
  if COMComponents = nil then
    COMComponents := TThreadList<TComComponent>.Create;
  FGUID := IUnknown;
  with COMComponents.LockList do
  try
    Add(Self);
  finally
    COMComponents.UnlockList;
  end;
end;

function TComComponent.CreateObject: IUnknown;
begin
  RegisterClass;
  Result := CreateComObject(StringToGUID(GUID));
end;

destructor TComComponent.Destroy;
begin
  UnregisterClass;
  if COMComponents <> nil then
    with COMComponents.LockList do
    try
      Remove(Self);
    finally
      COMComponents.UnlockList;
    end;
  inherited;
end;

procedure TComComponent.DoCreated(const ComObj: TWrappedComObject);
begin
  if Assigned(FOnCreated) then FOnCreated(Self, ComObj);
end;

procedure TComComponent.DoDestroy(const ComObj: TWrappedComObject);
begin
  if Assigned(FOnDestroy) then FOnDestroy(Self, ComObj);
end;

function TComComponent.GetComClass: TComClass;
begin
  Result := nil;
  if Assigned(FOnGetComClass) then
    FOnGetComClass(Self, Result);
end;

function TComComponent.GetGUIDString: string;
begin
  Result := GUIDToString(FGUID);
end;

procedure TComComponent.RegisterClass;
var
  ComClass: TComClass;
  Factory: TComObjectFactory;
begin
  if (csDesigning in ComponentState) then exit;
  if not (csLoading in ComponentState) and not IsEqualGUID(IUnknown, StringToGUID(GUID)) then
  begin
    Factory := ComClassManager.GetFactoryFromClassID(StringToGUID(GUID));
    if Factory = nil then
    begin
      ComClass := GetComClass;
      if Assigned(ComClass) then
      begin
        Factory := TComObjectFactory.Create(COMServer(ComClass), ComClass, StringToGUID(GUID),
          ClassName, FDescription, ciMultiInstance, tmApartment);
        Factory.RegisterClassObject;
      end
      else
        raise Exception.CreateFmt(SNoComClass, [Classname]);
    end;
  end;
end;

procedure TComComponent.SetGUIDString(const Value: string);
begin
  if CompareText(GUID, Value) <> 0 then
  begin
    if not IsEqualGUID(FGUID, IUnknown) then
      UnregisterClass;
    if not (csDesigning in ComponentState) and
       (Length(Value) > 0) and not IsEqualGUID(StringToGUID(Value), IUnknown) then
      CheckForDuplicateGUID(StringToGUID(Value));
    if Value = '' then
      FGUID := IUnknown
    else
      FGUID := StringToGUID(Value);
  end;
end;

procedure TComComponent.UnregisterClass;
var
  Factory: TComObjectFactory;
begin
  if not (csLoading in ComponentState) and not IsEqualGUID(FGUID, IUnknown) then
  begin
    Factory := ComClassManager.GetFactoryFromClassID(FGUID);
    if Factory <> nil then
      Factory.Free;
  end;
end;

{ TWrappedComObject }

procedure TWrappedComObject.AfterConstruction;
begin
  inherited;
  // FComComponent is assigned in the Initialize method
  if Assigned(FComComponent) then
    FComComponent.DoCreated(Self);
end;

destructor TWrappedComObject.Destroy;
var
  FoundComComponent: Boolean;
begin
  if Assigned(FComComponent) then
  begin
    FoundComComponent := False;
    if COMComponents <> nil then
      with COMComponents.LockList do
      try
        FoundComComponent := IndexOf(FComComponent) >= 0;
       finally
        COMComponents.UnlockList;
      end;
    if FoundComComponent then
    begin
      FComComponent.DoDestroy(Self);
      inherited;
    end
    else
    begin
      // FComComponent was already freed.  Do not call DoDestroy.
      // Also do not call inherited.Destroy because FFactory has
      // also been freed.
      // The following code is equivalent to TComObject.Destroy
      if Assigned(SafeCallErrorProc) then
      begin
        // if (FFactory <> nil) and not FNonCountedObject then
        //  FFactory.ComServer.CountObject(False);
        if RefCount > 0 then CoDisconnectObject(Self, 0);
      end;
    end
  end
  else
    inherited;
end;

procedure TWrappedComObject.Initialize;
var
  I: Integer;
  ComComponent: TComComponent;
begin
  inherited;
  with COMComponents.LockList do
  try
    for I := 0 to Count - 1 do
    begin
      ComComponent := Items[I];
      if IsEqualGUID(Factory.ClassID, ComComponent.FGUID) then
      begin
        FComComponent := ComComponent;
        Break;
      end;
    end;
    if FComComponent = nil then
      raise Exception.CreateFmt(SNoComComponent, [GUIDToString(Factory.ClassID)]);
  finally
    ComComponents.UnlockList;
  end;
end;

initialization
finalization
  FreeAndNil(COMComponents);
  if Assigned(COMServersList) then
    while COMServersList.Count > 0 do
      COMServersList.Delete(0);
  FreeAndNil(COMServersList);
  FreeAndNil(COMClassesList);
end.
