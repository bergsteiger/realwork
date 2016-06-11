{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit Vcl.JumpList;

interface

uses
  System.Classes, System.SysUtils, Winapi.ShlObj, Winapi.ObjectArray;

type
  TJumpListItem = class(TCollectionItem)
  private
    FPath: TFileName;
    FIcon: TFileName;
    FArguments: string;
    FFriendlyName: string;
    FIsSeparator: Boolean;
    FVisible: Boolean;
    procedure SetIsSeparator(const Value: Boolean);
    procedure SetIcon(const Value: TFileName);
    procedure SetPath(const Value: TFileName);
    procedure SetFriendlyName(const Value: string);
    procedure SetArguments(const Value: string);
    procedure SetVisible(const Value: Boolean);
  public
    function GetAsIShellLink: IShellLink;
    constructor Create(Collection: TCollection); override;
  published
    property IsSeparator: Boolean read FIsSeparator write SetIsSeparator default False;
    property Icon: TFileName read FIcon write SetIcon;
    property Path: TFileName read FPath write SetPath;
    property FriendlyName: string read FFriendlyName write SetFriendlyName;
    property Arguments: string read FArguments write SetArguments;
    property Visible: Boolean read FVisible write SetVisible default True;
  end;

  TJumpListCollection = class(TOwnedCollection)
  private
    FOnChange: TNotifyEvent;
    function GetItem(Index: Integer): TJumpListItem;
    procedure SetItem(Index: Integer; const Value: TJumpListItem);
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    function GetObjectArray: IObjectArray;
    property Items[Index: Integer]: TJumpListItem read GetItem write SetItem; default;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TJumpCategoryItem = class(TCollectionItem)
  private
    FItems: TJumpListCollection;
    FCategoryName: string;
    FVisible: Boolean;
    procedure SetVisible(const Value: Boolean);
    procedure SetCategoryName(const Value: string);
    procedure SetItems(const Value: TJumpListCollection);
    procedure OnItemsChange(Sender: TObject);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Visible: Boolean read FVisible write SetVisible default True;
    property CategoryName: string read FCategoryName write SetCategoryName;
    property Items: TJumpListCollection read FItems write SetItems;
  end;

  TJumpCategories = class(TOwnedCollection)
  private
    FOnChange: TNotifyEvent;
    function GetItem(Index: Integer): TJumpCategoryItem;
    procedure SetItem(Index: Integer; const Value: TJumpCategoryItem);
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    function GetCategoryIndex(const CategoryName: string): Integer;
    property Items[Index: Integer]: TJumpCategoryItem read GetItem write SetItem; default;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TItemDeletedByUserEvent = procedure (Sender: TObject; const Item: TJumpListItem; const CategoryName: string; FromTasks: Boolean) of object;
  TCreatingListErrorEvent = procedure (Sender: TObject; WinErrorCode: Cardinal; const ErrorDescription: string; var Handled: Boolean) of object;

  TCustomJumpList = class(TComponent)
  private
    FCustomCategories: TJumpCategories;
    FTaskList: TJumpListCollection;
    FShowRecent: Boolean;
    FShowFrequent: Boolean;
    FOnItemDeleted: TItemDeletedByUserEvent;
    FDestinationList: ICustomDestinationList;
    FApplicationID: string;
    FAutoRefresh: Boolean;
    FIsCreatingList: Boolean;
    FOnListUpdateError: TCreatingListErrorEvent;
    FOnItemsLoaded: TNotifyEvent;
    FEnabled: Boolean;
    procedure ChangeProcessAppId(const AppId: string);
    procedure ProcessRemovedObjects(const ObjArray: IObjectArray);
    procedure ProcessRemoved(const Path, Arguments, FriendlyName: string);
    procedure SetAutoRefresh(const Value: Boolean);
    procedure SetCustomCategories(const Value: TJumpCategories);
    procedure SetTaskList(const Value: TJumpListCollection);
    procedure SetShowRecent(const Value: Boolean);
    procedure DoAutoRefresh;
    procedure SetShowFrequent(const Value: Boolean);
    procedure OnListChange(Sender: TObject);
    class procedure RetrievePathsFromArray(const ObjectArray: IObjectArray; out Items: TArray<string>);
    class function GetDocList(ListType: Integer; const AppModelID: string; out ObjectList: IObjectArray; NumItems: Integer = 0): Boolean; overload;
    procedure SetEnabled(const Value: Boolean);
    procedure CheckProcessAppId;
    procedure CheckCanEnable;
    procedure DoEnable;
    function CheckUpdateError(ErrNo: HRESULT; const Description: string): Boolean;
  protected
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    class procedure AddToRecent(const Path: string); overload; inline;
    class procedure AddToRecent(const ShellLink: IShellLink); overload; inline;
    class procedure AddToRecent(const JumpItem: TJumpListItem); overload; inline;
    class function RemoveFromRecent(const Path: string; const AppModelID: string): Boolean; overload;
    class function RemoveFromRecent(const ShellItem: IUnknown; const AppModelID: string): Boolean; overload;
    class function RemoveFromRecent(const JumpItem: TJumpListItem; const AppModelID: string): Boolean; overload;
    class function RemoveAllFromRecent(const AppModelID: string): Boolean;
    class function GetRecentList(const AppModelID: string; out ObjectList: IObjectArray; NumItems: Integer = 0): Boolean; overload; inline;
    class function GetRecentList(const AppModelID: string; out Items: TArray<string>; NumItems: Integer = 0): Boolean; overload;
    class function GetFrequentList(const AppModelID: string; out ObjectList: IObjectArray; NumItems: Integer = 0): Boolean; overload; inline;
    class function GetFrequentList(const AppModelID: string; out Items: TArray<string>; NumItems: Integer = 0): Boolean; overload;

    function AddCategory(const CategoryName: string): Integer;
    function AddTask(const FriendlyName: string; const Path: string = ''; const Arguments: string = '';
             const Icon: string = ''): TJumpListItem;
    function AddTaskSeparator: TJumpListItem;
    function AddItemToCategory(CategoryIndex: Integer; const FriendlyName: string; const Path: string = '';
             const Arguments: string = ''; const Icon: string = ''): TJumpListItem;
    function UpdateList: Boolean;
    function DeleteList: Boolean;

    property AutoRefresh: Boolean read FAutoRefresh write SetAutoRefresh default False;
    property Enabled: Boolean read FEnabled write SetEnabled default False;
    property ApplicationID: string read FApplicationID write FApplicationID;
    property CustomCategories: TJumpCategories read FCustomCategories write SetCustomCategories;
    property ShowRecent: Boolean read FShowRecent write SetShowRecent default False;
    property ShowFrequent: Boolean read FShowFrequent write SetShowFrequent default False;
    property TaskList: TJumpListCollection read FTaskList write SetTaskList;
    property OnItemDeleted: TItemDeletedByUserEvent read FOnItemDeleted write FOnItemDeleted;
    property OnListUpdateError: TCreatingListErrorEvent read FOnListUpdateError write FOnListUpdateError;
    property OnItemsLoaded: TNotifyEvent read FOnItemsLoaded write FOnItemsLoaded;
  end;

  TJumpList = class(TCustomJumpList)
  published
    property AutoRefresh;
    property Enabled;
    property ApplicationID;
    property CustomCategories;
    property ShowRecent;
    property ShowFrequent;
    property TaskList;
    property OnItemDeleted;
    property OnListUpdateError;
    property OnItemsLoaded;
  end;

  EJumpListItemException = class(Exception);
  EJumpListException = class(Exception);

implementation

uses
  Winapi.Activex, Winapi.PropSys, Winapi.PropKey, System.Win.ComObj, Winapi.Windows,
  System.Generics.Collections, Vcl.Consts;

procedure CheckError(ErrNo: HRESULT; const Description: string);
begin
  if not Succeeded(ErrNo) then
    raise EJumpListItemException.CreateFmt(SJumplistsItemException, [ErrNo, Description]);
end;

{ TJumpCategoryItem }

constructor TJumpCategoryItem.Create(Collection: TCollection);
begin
  inherited;
  FItems := TJumpListCollection.Create(Self, TJumpListItem);
  FItems.OnChange := OnItemsChange;
  FVisible := True;
end;

destructor TJumpCategoryItem.Destroy;
begin
  FItems.Destroy;
  inherited;
end;

procedure TJumpCategoryItem.OnItemsChange(Sender: TObject);
begin
  Changed(False);
end;

procedure TJumpCategoryItem.SetCategoryName(const Value: string);
begin
  if FCategoryName <> Value then
  begin
    FCategoryName := Value;
    Changed(False);
  end;
end;

procedure TJumpCategoryItem.SetItems(const Value: TJumpListCollection);
begin
  if FItems <> Value then
  begin
    FItems.Assign(Value);
    Changed(False);
  end;
end;

procedure TJumpCategoryItem.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed(False);
  end;
end;

{ TJumpListItem }

constructor TJumpListItem.Create(Collection: TCollection);
begin
  inherited;
  FVisible := True;
  FFriendlyName := 'Jump List Item ' + IntToStr(Collection.Count); // Do not localize
end;

function TJumpListItem.GetAsIShellLink: IShellLink;
var
  PropertyStore: Winapi.PropSys.IPropertyStore;
  LPropVariant: TPropVariant;
begin
  Result := CreateComObject(CLSID_ShellLink) as IShellLink;

  if FIsSeparator then
  begin
    CheckError(Result.QueryInterface(Winapi.PropSys.IPropertyStore, PropertyStore), SJumplistsItemErrorGetpsi);
    CheckError(InitPropVariantFromBoolean(True, LPropVariant), SJumplistsItemErrorInitializepropvar);
    CheckError(PropertyStore.SetValue(PKEY_AppUserModel_IsDestListSeparator, LPropVariant), SJumplistsItemErrorSetps);
    CheckError(PropertyStore.Commit, SJumplistsItemErrorCommitps);
    PropVariantClear(LPropVariant);
  end
  else
  begin
    if FFriendlyName <> '' then
    begin
      CheckError(Result.QueryInterface(Winapi.PropSys.IPropertyStore, PropertyStore), SJumplistsItemErrorGetpsi);
      CheckError(InitPropVariantFromString(PWideChar(FFriendlyName), LPropVariant), SJumplistsItemErrorInitializepropvar);
      CheckError(PropertyStore.SetValue(PKEY_Title, LPropVariant), SJumplistsItemErrorSetps);
      CheckError(PropertyStore.Commit, SJumplistsItemErrorCommitps);
      PropVariantClear(LPropVariant);
    end
    else
      raise EJumpListItemException.Create(SJumplistsItemErrorNofriendlyname);
    if FArguments <> '' then
      CheckError(Result.SetArguments(PWideChar(FArguments)), SJumplistsItemErrorSettingarguments);
    if FPath <> '' then
      CheckError(Result.SetPath(PWideChar(FPath)), SJumplistsItemErrorSettingpath)
    else
      CheckError(Result.SetPath(PWideChar(ParamStr(0))), SJumplistsItemErrorSettingpath);

    if FIcon <> '' then
      CheckError(Result.SetIconLocation(PWideChar(FIcon), 0), SJumplistsItemErrorSettingicon)
    else // use the current executable Icon
      CheckError(Result.SetIconLocation(PWideChar(Paramstr(0)), 0), SJumplistsItemErrorSettingicon);
  end;
end;

procedure TJumpListItem.SetArguments(const Value: string);
begin
  if FArguments <> Value then
  begin
    FArguments := Value;
    Changed(False);
  end;
end;

procedure TJumpListItem.SetFriendlyName(const Value: string);
begin
  if FFriendlyName <> Value then
  begin
    FFriendlyName := Value;
    Changed(False);
  end;
end;

procedure TJumpListItem.SetIcon(const Value: TFileName);
begin
  if FIcon <> Value then
  begin
    FIcon := Value;
    Changed(False);
  end;
end;

procedure TJumpListItem.SetIsSeparator(const Value: Boolean);
const
  SJumplistsItemSeparatorException = 'Separators are not allowed on categories.';
begin
  if Value <> FIsSeparator then
  begin
    if Collection.Owner is TJumpCategoryItem then
      raise EJumpListItemException.Create(SJumplistsItemSeparatorException);
    FIsSeparator := Value;
    Changed(False);
  end;
end;

procedure TJumpListItem.SetPath(const Value: TFileName);
begin
  if FPath <> Value then
  begin
    FPath := Value;
    Changed(False);
  end;
end;

procedure TJumpListItem.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed(False);
  end;
end;

{ TJumpCategories }

function TJumpCategories.GetCategoryIndex(const CategoryName: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
    if Items[I].CategoryName = CategoryName then
      Exit(I);
end;

function TJumpCategories.GetItem(Index: Integer): TJumpCategoryItem;
begin
  Result := TJumpCategoryItem(inherited GetItem(Index));
end;

procedure TJumpCategories.SetItem(Index: Integer; const Value: TJumpCategoryItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TJumpCategories.Update(Item: TCollectionItem);
begin
  inherited;
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

{ TJumpList }

function TJumpListCollection.GetItem(Index: Integer): TJumpListItem;
begin
  Result := TJumpListItem(inherited GetItem(Index));
end;

function TJumpListCollection.GetObjectArray: IObjectArray;
var
  LObjCollection: IObjectCollection;
  LItem: TJumpListItem;
  LShellLink: IShellLink;
  I: Integer;
begin
  if CheckWin32Version(6, 1) then
  begin
    if Succeeded(CoCreateInstance(CLSID_EnumerableObjectCollection, nil, CLSCTX_INPROC_SERVER, IID_IObjectCollection, LObjCollection)) then
    begin
      for I := 0 to Count - 1 do
      begin
        LItem := Items[I] as TJumpListItem;
        if LItem.Visible then
        begin
          LShellLink := LItem.GetAsIShellLink;
          if LShellLink <> nil then
            CheckError(LObjCollection.AddObject(LShellLink), SJumplistsItemErrorAddingtobjarr);
        end;
      end;
      CheckError(LObjCollection.QueryInterface(IObjectArray, Result), SJumplistsItemErrorGettingobjarr);
    end;
  end;
end;

procedure TJumpListCollection.SetItem(Index: Integer; const Value: TJumpListItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TJumpListCollection.Update(Item: TCollectionItem);
begin
  inherited;
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

{ TCustomJumpLists }

constructor TCustomJumpList.Create(AOwner: TComponent);
begin
  inherited;
  FCustomCategories := TJumpCategories.Create(Self, TJumpCategoryItem);
  FTaskList := TJumpListCollection.Create(Self, TJumpListItem);
  FCustomCategories.OnChange := OnListChange;
  FTaskList.OnChange := OnListChange;
end;

destructor TCustomJumpList.Destroy;
begin
  FCustomCategories.Free;
  FTaskList.Free;
  inherited;
end;

class procedure TCustomJumpList.AddToRecent(const Path: string);
begin
  SHAddToRecentDocs(SHARD_PATH, PWideChar(Path));
end;

class procedure TCustomJumpList.AddToRecent(const ShellLink: IShellLink);
begin
  if CheckWin32Version(6, 1) then
    SHAddToRecentDocs(SHARD_LINK, PWideChar(ShellLink));
end;

function TCustomJumpList.AddCategory(const CategoryName: string): Integer;
var
  LItem: TJumpCategoryItem;
begin
  FCustomCategories.BeginUpdate;
  LItem := TJumpCategoryItem(FCustomCategories.Add);
  try
    LItem.CategoryName := CategoryName;
    LItem.Visible := True;
    Result := LItem.Index;
  finally
    FCustomCategories.EndUpdate;
  end;
end;

function TCustomJumpList.AddItemToCategory(CategoryIndex: Integer; const FriendlyName, Path, Arguments,
  Icon: string): TJumpListItem;
begin
  FCustomCategories.Items[CategoryIndex].Items.BeginUpdate;
  Result := TJumpListItem(FCustomCategories.Items[CategoryIndex].Items.Add);
  try
    Result.Icon := Icon;
    Result.Path := Path;
    Result.Arguments := Arguments;
    Result.FriendlyName := FriendlyName;
    Result.IsSeparator := False;
    Result.Visible := True;
  finally
    FCustomCategories.Items[CategoryIndex].Items.EndUpdate;
  end;
end;

function TCustomJumpList.AddTask(const FriendlyName, Path, Arguments, Icon: string): TJumpListItem;
begin
  FTaskList.BeginUpdate;
  Result := TJumpListItem(FTaskList.Add);
  try
    Result.Icon := Icon;
    Result.Path := Path;
    Result.Arguments := Arguments;
    Result.FriendlyName := FriendlyName;
    Result.IsSeparator := False;
    Result.Visible := True;
  finally
    FTaskList.EndUpdate;
  end;
end;

function TCustomJumpList.AddTaskSeparator: TJumpListItem;
begin
  FTaskList.BeginUpdate;
  Result := TJumpListItem(FTaskList.Add);
  try
    Result.IsSeparator := True;
    Result.Visible := True;
  finally
    FTaskList.EndUpdate;
  end;
end;

class procedure TCustomJumpList.AddToRecent(const JumpItem: TJumpListItem);
begin
  AddToRecent(JumpItem.GetAsIShellLink);
end;

function TCustomJumpList.DeleteList: Boolean;
var
  LMaxSlots: Cardinal;
  LRemovedTasks: IObjectArray;
begin
  Result := False;
  if FEnabled and CheckWin32Version(6, 1) then
  begin
    ChangeProcessAppId(FApplicationID);
    if CheckUpdateError(FDestinationList.BeginList(LMaxSlots, IID_IObjectArray, LRemovedTasks), SJumplistErrorBeginlist) then
    begin
      try
        ProcessRemovedObjects(LRemovedTasks);
        Result := CheckUpdateError(FDestinationList.CommitList, SJumplistErrorCommitlist);
      except
        FDestinationList.AbortList;
        raise;
      end;
    end;
  end;
end;

procedure TCustomJumpList.CheckCanEnable;
begin
  if not CheckWin32Version(6, 1) then
    raise EJumpListException.Create(SJumplistExceptionInvalidOS);
  CheckProcessAppId;
end;

procedure TCustomJumpList.DoAutoRefresh;
begin
  if FAutoRefresh and not FIsCreatingList and not (csDesigning in ComponentState) then
    UpdateList;
end;

procedure TCustomJumpList.DoEnable;
begin
  CheckCanEnable;
  if FDestinationList = nil then
    FDestinationList := CreateComObject(CLSID_DestinationList) as ICustomDestinationList;
end;

class function TCustomJumpList.GetDocList(ListType: Integer; const AppModelID: string; out ObjectList: IObjectArray;
  NumItems: Integer): Boolean;
var
  LDocList: IApplicationDocumentLists;
begin
  Result := False;
  if CheckWin32Version(6, 1) then
  begin
    LDocList := CreateComObject(CLSID_ApplicationDocumentLists) as IApplicationDocumentLists;
    if AppModelID <> '' then
      LDocList.SetAppID(PWideChar(AppModelID));
    Result := Succeeded(LDocList.GetList(ListType, NumItems, IID_IObjectArray, ObjectList));
  end;
end;

class procedure TCustomJumpList.RetrievePathsFromArray(const ObjectArray: IObjectArray; out Items: TArray<string>);
var
  NumObjects: Cardinal;
  I: Integer;
  LLinkItem: IShellLink;
  LShellItem: IShellItem;
  LPath: array[0..MAX_PATH - 1] of Char;
  LPPath: PWideChar;
  LPfd: _WIN32_FIND_DATAW;
begin
  ObjectArray.GetCount(NumObjects);
  SetLength(Items, NumObjects);
  for I := 0 to Integer(NumObjects) - 1 do
  begin
    if Succeeded(ObjectArray.GetAt(I, IID_IShellLink, LLinkItem))  then
    begin
      LLinkItem.GetPath(LPath, MAX_PATH, LPfd, SLGP_RELATIVEPRIORITY);
      Items[I] := LPath;
    end;
    if Succeeded(ObjectArray.GetAt(I, IID_IShellItem, LShellItem))  then
    begin
      LShellItem.GetDisplayName(SIGDN_FILESYSPATH, LPPath);
      Items[I] := LPPath;
    end;
  end;
end;

class function TCustomJumpList.GetFrequentList(const AppModelID: string; out Items: TArray<string>;
  NumItems: Integer): Boolean;
var
  LItems: IObjectArray;
begin
  Result := False;
  if TJumpList.GetFrequentList(AppModelID, LItems, NumItems) then
  begin
    RetrievePathsFromArray(LItems, Items);
    Result := True;
  end;
end;

class function TCustomJumpList.GetRecentList(const AppModelID: string; out Items: TArray<string>;
  NumItems: Integer): Boolean;
var
  LItems: IObjectArray;
begin
  Result := False;
  if TJumpList.GetRecentList(AppModelID, LItems, NumItems) then
  begin
    RetrievePathsFromArray(LItems, Items);
    Result := True;
  end;
end;

class function TCustomJumpList.GetFrequentList(const AppModelID: string; out ObjectList: IObjectArray;
  NumItems: Integer): Boolean;
begin
  Result := GetDocList(ADLT_FREQUENT, AppModelID, ObjectList, NumItems);
end;

class function TCustomJumpList.GetRecentList(const AppModelID: string; out ObjectList: IObjectArray;
  NumItems: Integer): Boolean;
begin
  Result := GetDocList(ADLT_RECENT, AppModelID, ObjectList, NumItems);
end;

procedure TCustomJumpList.Loaded;
begin
  inherited;
  if not (csDesigning in ComponentState) then
  begin
    if Assigned(FOnItemsLoaded) then
    begin
      FIsCreatingList := True;
      try
        FOnItemsLoaded(Self);
      finally
        FIsCreatingList := False;
      end;
    end;
    if FEnabled then
      DoEnable;
    DoAutoRefresh;
  end;
end;

procedure TCustomJumpList.OnListChange(Sender: TObject);
begin
  DoAutoRefresh;
end;

procedure TCustomJumpList.SetAutoRefresh(const Value: Boolean);
begin
  if Value <> FAutoRefresh then
  begin
    FAutoRefresh := Value;
    DoAutoRefresh;
  end;
end;

procedure TCustomJumpList.ChangeProcessAppId(const AppId: string);
var
  LAppId : LPCWSTR;
begin
  if FEnabled and (CheckWin32Version(6, 1)) then
  begin
    LAppId := nil;
    if Succeeded(GetCurrentProcessExplicitAppUserModelID(LAppId)) and (LAppId = nil) then
      SetCurrentProcessExplicitAppUserModelID(PWideChar(AppId));
  end;
end;

procedure TCustomJumpList.CheckProcessAppId;
var
  LAppId : LPCWSTR;
begin
  if (CheckWin32Version(6, 1)) and (FApplicationID <> '') then
  begin
    LAppId := nil;
    if Succeeded(GetCurrentProcessExplicitAppUserModelID(LAppId)) and (LAppId <> nil) and (LAppId = FApplicationID) then
       raise EJumpListException.CreateFmt(SJumplistExceptionAppID, [LAppId]);
  end;
end;

procedure TCustomJumpList.SetCustomCategories(const Value: TJumpCategories);
begin
  if FCustomCategories <> Value then
  begin
    FCustomCategories.Assign(Value);
    DoAutoRefresh;
  end;
end;

procedure TCustomJumpList.SetEnabled(const Value: Boolean);
begin
  if Value <> FEnabled then
  begin
    if not (csLoading in ComponentState) and not (csDesigning in ComponentState) and Value then
      DoEnable;
    FEnabled := Value;
  end;
end;

procedure TCustomJumpList.SetShowFrequent(const Value: Boolean);
begin
  if Value <> FShowFrequent then
  begin
    FShowFrequent := Value;
    DoAutoRefresh;
  end;
end;

procedure TCustomJumpList.SetShowRecent(const Value: Boolean);
begin
  if Value <> FShowRecent then
  begin
    FShowRecent := Value;
    DoAutoRefresh;
  end;
end;

procedure TCustomJumpList.SetTaskList(const Value: TJumpListCollection);
begin
  if FTaskList <> Value then
  begin
    FTaskList.Assign(Value);
    DoAutoRefresh;
  end;
end;

procedure TCustomJumpList.ProcessRemoved(const Path, Arguments, FriendlyName: string);

  procedure ProcessTaskList(const ListToProcess: TJumpListCollection; IsFromTasks: Boolean; const CategoryName: string);
  var
    I: Integer;
    RemoveList: TList<Integer>;
  begin
    RemoveList := TList<Integer>.Create;
    try
      ListToProcess.BeginUpdate;
      try
        for I := 0 to ListToProcess.Count - 1 do
        begin
          if (ListToProcess[I].Path = Path) and (ListToProcess[I].Arguments = Arguments)  and
             (ListToProcess[I].FriendlyName = FriendlyName )then
          begin
            if Assigned(FOnItemDeleted) then
              FOnItemDeleted(Self, ListToProcess[I], CategoryName, IsFromTasks);
            RemoveList.Add(I);
          end;
        end;
        for I := RemoveList.Count - 1 downto 0 do
          ListToProcess.Delete(RemoveList.Items[I]);
      finally
        ListToProcess.EndUpdate;
      end;
    finally
      RemoveList.Free;
    end;
  end;

var
  I: Integer;
begin
  if FTaskList.Count > 0 then
    ProcessTaskList(FTaskList, True, '');
  for I := 0 to FCustomCategories.Count - 1  do
  begin
    if FCustomCategories[I].Items.Count > 0 then
      ProcessTaskList(FCustomCategories[I].Items, False, FCustomCategories[I].CategoryName);
  end;
end;

procedure TCustomJumpList.ProcessRemovedObjects(const ObjArray: IObjectArray);
var
  LRemoved: Cardinal;
  I: Cardinal;
  LError: Integer;
  LLinkItem: IShellLink;
  LPath: array[0..MAX_PATH -1] of Char;
  LArguments: array[0..MAX_PATH -1] of Char; //PWideChar;
  LFriendlyName: array[0..MAX_PATH -1] of Char; //PWideChar;
  LFileStr: _WIN32_FIND_DATAW;
  PropertyStore: Winapi.PropSys.IPropertyStore;
  LPropVariant: tagPROPVARIANT;
begin
  if (Win32MajorVersion >= 6) and (ObjArray <> nil) then
  begin
    ObjArray.GetCount(LRemoved);
    if LRemoved > 0 then
    begin
      for I:= 0 to LRemoved - 1 do
      begin
        LError := ObjArray.GetAt(I, IID_IShellLink, LLinkItem);
        if Succeeded(LError) then
        begin
          if Supports(LLinkItem, Winapi.PropSys.IPropertyStore, PropertyStore) then
          begin
            LLinkItem.GetPath(LPath, Length(LPath), LFileStr, SLGP_RELATIVEPRIORITY);
            LLinkItem.GetArguments(LArguments, Length(LArguments));
            InitPropVariantFromString(LFriendlyName, LPropVariant);
            PropertyStore.GetValue(PKEY_Title, LPropVariant);
            PropVariantToString(LPropVariant, LFriendlyName, Length(LFriendlyName));
            PropVariantClear(LPropVariant);
            ProcessRemoved(LPath, LArguments, LFriendlyName);
          end;
        end;
      end;
    end;
  end;
end;

class function TCustomJumpList.RemoveAllFromRecent(const AppModelID: string): Boolean;
var
  LAppDestinations: IApplicationDestinations;
begin
  Result := False;
  if CheckWin32Version(6, 1) then
  begin
    LAppDestinations := CreateComObject(CLSID_ApplicationDestinations) as IApplicationDestinations;
    if AppModelID <> '' then
      LAppDestinations.SetAppID(PWideChar(PWideChar(AppModelID)));
    Result := Succeeded(LAppDestinations.RemoveAllDestinations);
  end;
end;

class function TCustomJumpList.RemoveFromRecent(const Path, AppModelID: string): Boolean;
var
  ObjectArray: IObjectArray;
  LNumItems: Cardinal;
  I: Cardinal;
  LShellLink: IShellLink;
  LDocumentPath: string;
  LPath: PWideChar;
  LShellItem: IShellItem;
begin
  Result := False;
  if CheckWin32Version(6, 1) and GetRecentList(AppModelID, ObjectArray)
      and Succeeded(ObjectArray.GetCount(LNumItems)) and (LNumItems > 0) then
  begin
    LPath := @LDocumentPath;
    for I := 0 to LNumItems - 1 do
    begin
      if Succeeded(ObjectArray.GetAt(I, IID_IShellLink, LShellLink)) then
      begin
        LShellLink.GetArguments(PWideChar(LDocumentPath), MAX_PATH);
        if LDocumentPath = Path then
        begin
          TCustomJumpList.RemoveFromRecent(LShellLink, AppModelID);
          Exit(True);
        end;
      end
      else if Succeeded(ObjectArray.GetAt(I, IID_IShellItem, LShellItem)) then
      begin
        if not Succeeded(LShellItem.GetDisplayName(SIGDN_FILESYSPATH, LPath)) then
          LShellItem.GetDisplayName(SIGDN_URL, LPath);
        if LPath = Path then
        begin
          TCustomJumpList.RemoveFromRecent(LShellItem, AppModelID);
          Exit(True);
        end;
      end;
    end;
  end;
end;

class function TCustomJumpList.RemoveFromRecent(const ShellItem: IUnknown; const AppModelID: string): Boolean;
var
  LAppDestinations: IApplicationDestinations;
begin
  Result := False;
  if CheckWin32Version(6, 1) then
  begin
    LAppDestinations := CreateComObject(CLSID_ApplicationDestinations) as IApplicationDestinations;
    if AppModelID <> '' then
      LAppDestinations.SetAppID(PWideChar(PWideChar(AppModelID)));
    Result := Succeeded(LAppDestinations.RemoveDestination(ShellItem));
  end;
end;

class function TCustomJumpList.RemoveFromRecent(const JumpItem: TJumpListItem; const AppModelID: string): Boolean;
begin
  Result := RemoveFromRecent(JumpItem.GetAsIShellLink, AppModelID);
end;


function TCustomJumpList.CheckUpdateError(ErrNo: HRESULT; const Description: string): Boolean;
var
  LHandled: Boolean;
begin
  Result := Succeeded(ErrNo);
  if not Result then
  begin
    LHandled := false;
    if Assigned(FOnListUpdateError) then
      FOnListUpdateError(Self, ErrNo, Description, LHandled);
    if not LHandled then
      raise EJumpListException.CreateFmt(SJumplistException, [ErrNo, Description]);
  end;
end;

function TCustomJumpList.UpdateList: Boolean;
var
  LMaxSlots, LObjects: Cardinal;
  LRemovedTasks, LTasksList: IObjectArray;
  I: Integer;
begin
  Result := False;
  if FEnabled and CheckWin32Version(6, 1) and not (csLoading in ComponentState) then
  begin
    ChangeProcessAppId(FApplicationID);
    FIsCreatingList := True;
    try
      if CheckUpdateError(FDestinationList.BeginList(LMaxSlots, IID_IObjectArray, LRemovedTasks), SJumplistErrorBeginlist) then
      begin
        try
          ProcessRemovedObjects(LRemovedTasks);

          // Add recent and frequent categories
          if FShowRecent then
            CheckError(FDestinationList.AppendKnownCategory(KDC_RECENT), SJumplistErrorAppendrc);
          if FShowFrequent then
            CheckError(FDestinationList.AppendKnownCategory(KDC_FREQUENT), SJumplistErrorAppendfc);

          // Add task items
          if FTaskList.Count > 0 then
          begin
            LTasksList := FTaskList.GetObjectArray;
            if LTasksList <> nil then
            begin
              LTasksList.GetCount(LObjects);
              if (LTasksList <> nil) and (LObjects > 0) then
                CheckError(FDestinationList.AddUserTasks(LTasksList), SJumplistErrorAddusertasks);
            end;
          end;

          // Add custom categories
          for I := 0 to FCustomCategories.Count - 1 do
          begin
            if FCustomCategories[I].Visible then
            begin
              LTasksList := FCustomCategories[I].Items.GetObjectArray;
              if LTasksList <> nil then
              begin
                LTasksList.GetCount(LObjects);
                if (LTasksList <> nil) and (LObjects > 0) then
                  CheckError(FDestinationList.AppendCategory(PWideChar(FCustomCategories[I].CategoryName), LTasksList),
                              Format(SJumplistErrorAddcategory, [FCustomCategories[I].CategoryName]));
              end;
            end;
          end;
          Result := CheckUpdateError(FDestinationList.CommitList, SJumplistErrorCommitlist);
        except
          FDestinationList.AbortList;
          raise;
        end;
      end;
    finally
      FIsCreatingList := False
    end;
  end;
end;

end.
