{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit MidReg;

interface

uses
  Classes, Variants, DSDesign, MConnect, MidasCon,  DBClient, Provider,
  ActiveX, ComObj, ShlObj, FldLinks, DBReg, DBConsts, DesignIntf, DesignEditors,
  Windows, Forms, SysUtils, DsnDBCst, MidConst, DataBkr, SConnect, MtsRdm, TConnect,
  ObjBrkr, Dialogs, Controls, DB, DMForm, TreeIntf, DsnDb, LMidReg;

type

  { object brokers }

  TSimpleObjectBrokerSprig = class(TCustomObjectBrokerSprig)
  public
    function AnyProblems: Boolean; override;
  end;

  { connections }

  TWebConnectionSprig = class(TStreamedConnectionSprig)
  public
    class function ParentProperty: string; override;
    function AnyProblems: Boolean; override;
  end;

  TSocketConnectionSprig = class(TStreamedConnectionSprig)
  public
    class function ParentProperty: string; override;
    function AnyProblems: Boolean; override;
  end;

  TCOMConnectionSprig = class(TDispatchConnectionSprig)
  public
    function AnyProblems: Boolean; override;
  end;

  TDCOMConnectionSprig = class(TCOMConnectionSprig)
  public
    class function ParentProperty: string; override;
  end;

  TOLEnterpriseConnectionSprig = class(TCOMConnectionSprig)
  end;

  // TMidasConnectionSprig is handled by TDCOMConnectionSprig
  // TRemoteServerSprig is handled by TDCOMConnectionSprig


procedure Register;

implementation

{ TComputerNameProperty }

type

  TComputerNameProperty = class(TStringProperty)
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

function TComputerNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

procedure TComputerNameProperty.Edit;
var
  BrowseInfo: TBrowseInfo;
  ItemIDList: PItemIDList;
  ComputerName: array[0..MAX_PATH] of Char;
  Title: string;
  WindowList: Pointer;
  Result: Boolean;
  ShellMalloc: IMalloc;
begin
  if Failed(SHGetSpecialFolderLocation(Application.Handle, CSIDL_NETWORK, ItemIDList)) then
    raise Exception.CreateRes(@SComputerNameDialogNotSupported);
  try
    FillChar(BrowseInfo, SizeOf(BrowseInfo), 0);
    BrowseInfo.hwndOwner := Application.Handle;
    BrowseInfo.pidlRoot := ItemIDList;
    BrowseInfo.pszDisplayName := ComputerName;
    Title := sSelectRemoteServer;
    BrowseInfo.lpszTitle := PChar(Pointer(Title));
    BrowseInfo.ulFlags := BIF_BROWSEFORCOMPUTER;
    WindowList := DisableTaskWindows(0);
    try
      Result := SHBrowseForFolder(BrowseInfo) <> nil;
    finally
      EnableTaskWindows(WindowList);
    end;
    if Result then SetValue(ComputerName);
  finally
    if Succeeded(SHGetMalloc(ShellMalloc)) then
      ShellMalloc.Free(ItemIDList);
  end;
end;

{ TProviderNameProperty }

type
  TProviderNameProperty = class(TStringProperty)
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

function TProviderNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paValueList, paSortList];
end;

type
  TServerProtectedAccess = class(TCustomRemoteServer); // Allows us to call protected methods.

procedure TProviderNameProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Dataset: TClientDataSet;
  RemoteServer: TCustomRemoteServer;
begin
  DataSet := (GetComponent(0) as TClientDataSet);
  RemoteServer := DataSet.RemoteServer;
  if RemoteServer <> nil then
    TServerProtectedAccess(RemoteServer).GetProviderNames(Proc)
  else
    if Assigned(DataSet.Owner) then
    with DataSet.Owner do
      for I := 0 to ComponentCount - 1 do
        if Components[I] is TCustomProvider then
          Proc(Components[I].Name);
end;

{ TServerNameProperty }

type
  TServerNameProperty = class(TStringProperty)
    function AutoFill: Boolean; override;
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

function TServerNameProperty.AutoFill: Boolean; 
begin
  Result := False;
end;

function TServerNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paValueList, paSortList];
end;

type
  TConnectionAccess = class(TCustomRemoteServer);

procedure TServerNameProperty.GetValues(Proc: TGetStrProc);
var
  Connection: TConnectionAccess;
  Data: OleVariant;
  i: Integer;
begin
  Screen.Cursor := crHourGlass;
  try
    Connection := TConnectionAccess(GetComponent(0));
    Data := Connection.GetServerList;
    if VarIsArray(Data) then
      for i := 0 to VarArrayHighBound(Data, 1) do
        Proc(Data[i]);
  finally
    Screen.Cursor := crDefault;
  end;
end;

{ TInterceptorNameProperty }

type
  TInterceptorNameProperty = class(TStringProperty)
    function AutoFill: Boolean; override;
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

function TInterceptorNameProperty.AutoFill: Boolean;
begin
  Result := False;
end;

function TInterceptorNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paValueList, paSortList];
end;

type
  TStreamedConnectionAccess = class(TStreamedConnection);

procedure TInterceptorNameProperty.GetValues(Proc: TGetStrProc);
var
  Connection: TStreamedConnectionAccess;
  Data: OleVariant;
  i: Integer;
begin
  Screen.Cursor := crHourGlass;
  try
    Connection := TStreamedConnectionAccess(GetComponent(0));
    Data := Connection.GetInterceptorList;
    if VarIsArray(Data) then
      for i := 0 to VarArrayHighBound(Data, 1) do
        Proc(Data[i]);
  finally
    Screen.Cursor := crDefault;
  end;
end;

{ TUniqueProperty }

type
  TUniqueProperty = class(TComponentProperty)
  private
    FInheritedProc : TGetStrProc ;
    procedure OurProc(const s : string);
    function IsOurName(const s : string) : boolean;
  protected
    procedure GetValues(Proc : TGetStrProc); override;
  end;

procedure TUniqueProperty.GetValues(Proc: TGetStrProc);
begin
  FInheritedProc := Proc;
  inherited GetValues(OurProc);
end;

function TUniqueProperty.IsOurName(const s: string): boolean;
var
  i : integer;
begin
  Result := true;
  for i := 0 to PropCount - 1 do
    if (GetComponent(i) as TComponent).Name = s then exit;
  Result := false;
end;

procedure TUniqueProperty.OurProc(const s: string);
begin
  // only pass on if value is not our own name
  if not IsOurName(s) then
    FInheritedProc(s);
end;

{ TChildNameProperty }

type
  TChildNameProperty = class(TStringProperty)
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

function TChildNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paValueList, paSortList];
end;

procedure TChildNameProperty.GetValues(Proc: TGetStrProc);
var
  Connection: TSharedConnection;
  W: WideString;
  pTypeInfo: ITypeInfo;
  pClassTypeAttr, pTempTypeAttr: PTYPEATTR;
  pClassFuncDesc: PFuncDesc;
  pPropTypeDesc: PTypeDesc;
  idxFunc: integer;
  vt: TVarType;
  pTempTypeInfo, pTypeInfo3: ITypeInfo;
  hreftype: Cardinal;
  n: integer;
  FoundIAppServer: boolean;
  Disp: IDispatch;
begin
  Connection := TSharedConnection(GetComponent(0));
  if Connection.ParentConnection = nil then EXIT;
  Screen.Cursor := crHourGlass;
  try
    // works for all, but requires TLB to be registered on developer's machine
    Disp := CreateOleObject(Connection.ParentConnection.ServerName);
    OleCheck(Disp.GetTypeInfo(0, 0, pTypeInfo));
 
    OleCheck(pTypeInfo.GetTypeAttr(pClassTypeAttr));
    for idxFunc:=0 to pClassTypeAttr.cFuncs - 1 do
    begin
      OleCheck(pTypeInfo.GetFuncDesc(idxFunc, pClassFuncDesc));
      if (pClassFuncDesc.invkind = DISPATCH_PROPERTYGET) then
      begin
        if (pClassFuncDesc.elemdescFunc.tdesc.vt = VT_PTR) then
        begin
          pPropTypeDesc :=  pClassFuncDesc.elemdescFunc.tdesc.ptdesc;
          vt := pPropTypeDesc.vt;
          if vt = VT_USERDEFINED then
          begin
            FoundIAppServer := false;
            OleCheck(pTypeInfo.GetRefTypeInfo(pPropTypeDesc.hrefType, pTempTypeInfo));
            while (true) do
            begin
              OleCheck(pTempTypeInfo.GetDocumentation(MEMBERID_NIL, @w, nil, nil, nil));
              if w = 'IAppServer' then FoundIAppServer := true;
              pTempTypeInfo.GetTypeAttr(pTempTypeAttr);
              try
                if (pTempTypeAttr.typekind = TKIND_DISPATCH) and (pTempTypeAttr.wTypeFlags and TYPEFLAG_FDUAL <> 0) then
                  n := -1 else
                  n := 0;
                if pTempTypeAttr.cImplTypes = 0 then break; // Break when we get to IUnknown
              finally
                pTempTypeInfo.ReleaseTypeAttr(pTempTypeAttr);
              end;
              OleCheck(pTempTypeInfo.GetRefTypeOfImplType(n, hreftype));
              OleCheck(pTempTypeInfo.GetRefTypeInfo(hrefType, pTypeInfo3));
              pTempTypeInfo := pTypeInfo3;
            end;
 
            if FoundIAppServer then
            begin
              OleCheck(pTypeInfo.GetDocumentation(pClassFuncDesc.memid, @w, nil, nil, nil));
              Proc(w);
            end;
          end; // if VT_USERDEFINED
        end; // if VT_PTR
      end; // if PROPERTYGET
      pTypeInfo.ReleaseFuncDesc(pClassFuncDesc);
    end;
    pTypeInfo.ReleaseTypeAttr(pClassTypeAttr);
  finally
    Disp := nil;
    Screen.Cursor := crDefault;
  end;
end;

{ TCOMConnectionSprig }

function TCOMConnectionSprig.AnyProblems: Boolean;
begin
  Result := (TCOMConnection(Item).ServerGUID = '') and
            (TCOMConnection(Item).ServerName = '');
end;

{ TSimpleObjectBrokerSprig }

function TSimpleObjectBrokerSprig.AnyProblems: Boolean;
begin
  Result := TSimpleObjectBroker(Item).Servers.Count = 0;
end;

{ TDCOMConnectionSprig }

class function TDCOMConnectionSprig.ParentProperty: string;
begin
  Result := 'ObjectBroker'; { do not localize }
end;

{ TSocketConnectionSprig }

function TSocketConnectionSprig.AnyProblems: Boolean;
begin
  Result := ((TSocketConnection(Item).Address = '') and
             (TSocketConnection(Item).Host = '') and
             (TSocketConnection(Item).ObjectBroker = nil))
            or
             ((TSocketConnection(Item).ServerName = '') and
              (TSocketConnection(Item).ServerGUID = ''));
end;

class function TSocketConnectionSprig.ParentProperty: string;
begin
  Result := 'ObjectBroker'; { do not localize }
end;

{ TWebConnectionSprig }

function TWebConnectionSprig.AnyProblems: Boolean;
begin
  Result := ((TWebConnection(Item).URL = '')
             and (TWebConnection(Item).ObjectBroker = nil )
            )
            or
            ((TWebConnection(Item).ServerName = '')
              and (TWebConnection(Item).ServerGUID = ''));
end;

class function TWebConnectionSprig.ParentProperty: string;
begin
  Result := 'ObjectBroker'; { do not localize }
end;


procedure Register;
begin
  { MIDAS components are only available in the Enterprise SKU }
  if GDAL = 0 then
  begin
    GroupDescendentsWith(TSocketConnection, Controls.TControl);
    GroupDescendentsWith(TDCOMConnection, Controls.TControl);
    GroupDescendentsWith(TLocalConnection, Controls.TControl);
    GroupDescendentsWith(TSharedConnection, Controls.TControl);
    GroupDescendentsWith(TWebConnection, Controls.TControl);
    GroupDescendentsWith(TConnectionBroker, Controls.TControl);
    GroupDescendentsWith(TCustomObjectBroker, Controls.TControl);

    RegisterComponents(srMIDAS, [TDCOMConnection,
      TSocketConnection, TSimpleObjectBroker, TWebConnection, TConnectionBroker,
      TSharedConnection, TLocalConnection]);

    RegisterPropertyEditor(TypeInfo(string), TDispatchConnection, 'ComputerName', TComputerNameProperty);
    RegisterPropertyEditor(TypeInfo(string), TSocketConnection, 'Host', TComputerNameProperty);
    RegisterPropertyEditor(TypeInfo(string), TOLEnterpriseConnection, 'BrokerName', TComputerNameProperty);
    RegisterPropertyEditor(TypeInfo(string), TCustomRemoteServer, 'ServerName', TServerNameProperty);
    RegisterPropertyEditor(TypeInfo(string), TStreamedConnection, 'InterceptName', TInterceptorNameProperty);
    RegisterPropertyEditor(TypeInfo(string), TServerItem, 'ComputerName', TComputerNameProperty);
    RegisterPropertyEditor(TypeInfo(TDispatchConnection), TConnectionBroker, 'Connection', TUniqueProperty);
    RegisterPropertyEditor(TypeInfo(string), TSharedConnection, 'ChildName', TChildNameProperty);
    RegisterCustomModule(TRemoteDataModule, TDataModuleCustomModule);//TDataModuleDesignerCustomModule);
    RegisterCustomModule(TMtsDataModule, TDataModuleCustomModule);//TDataModuleDesignerCustomModule);
    RegisterCustomModule(TCRemoteDataModule, TDataModuleCustomModule);//TDataModuleDesignerCustomModule);

    { Property Category registration }
    RegisterPropertiesInCategory(SMidasCategoryName, TDispatchConnection,
      ['ComputerName', 'Host', 'BrokerName', 'ServerName', 'ServerGUID']);

    RegisterPropertiesInCategory(SMidasCategoryName, TServerItem,
      ['ComputerName', 'Port']);

    RegisterPropertiesInCategory(SMidasCategoryName,
      ['FetchOnDemand', 'PacketRecords', 'RemoteServer', 'OnReconcileError']);

    RegisterSprigType(TCustomObjectBroker, TCustomObjectBrokerSprig);
    RegisterSprigType(TSimpleObjectBroker, TSimpleObjectBrokerSprig);

    RegisterSprigType(TCustomRemoteServer, TCustomRemoteServerSprig);

    RegisterSprigType(TDCOMConnection, TDCOMConnectionSprig);
    RegisterSprigType(TOLEnterpriseConnection, TOLEnterpriseConnectionSprig);
    RegisterSprigType(TWebConnection, TWebConnectionSprig);
    RegisterSprigType(TSocketConnection, TSocketConnectionSprig);

  end;
end;

end.
