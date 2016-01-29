unit StructureViewServices;

interface

uses
  DataExplorerAPI,
  System.Bindings.Factories, System.Bindings.Expression, System.Bindings.Outputs,
  System.Bindings.Helper, System.StrUtils, System.Bindings.Consts, System.Rtti,
  System.Classes, System.SysUtils, System.Bindings.EvalProtocol, System.Bindings.Methods,
  System.Bindings.EvalSys, System.Bindings.ObjEval,
  System.Generics.Collections;

type
  IScopes = Interface
    ['{1CEE87BB-4AC8-4002-B7F0-AC591594C9CD}']
    function GetCount: Integer;
    function GetItem(I: Integer): TScope;
    procedure Add(AScope: TScope);
    function ToArray: TScopesArray;
  end;
  TScopes = class(TInterfacedObject, IScopes)
  private
    FList: TList<TScope>;
  public
    constructor Create;
    destructor Destroy; override;
    function GetCount: Integer;
    function GetItem(I: Integer): TScope;
    procedure Add(AScope: TScope);
    function ToArray: TScopesArray;
  end;

  IDECommands = Interface
    ['{C9AAA794-C844-4ED6-B697-76C5F93BFAB4}']
    function GetCount: Integer;
    function GetItem(I: Integer): IOTADataExplorerCommand;
    procedure Add(ACommand: IOTADataExplorerCommand);
    function ToArray: TDECommandsArray;
  End;
  TDECommands = class(TInterfacedObject, IDECommands)
  private
    FList: IInterfaceListEx;
    function GetCount: Integer;
    function GetItem(I: Integer): IOTADataExplorerCommand;
    function ToArray: TDECommandsArray;
  public
    constructor Create;
    procedure Add(ACommand: IOTADataExplorerCommand);
    property Count: Integer read GetCount;
    property Items[I: Integer]: IOTADataExplorerCommand read GetItem;
  end;

  TDEComponentStream = class abstract(TInterfacedObject, IOTADataExplorerComponentStream)
  protected
    function GetFormat: Word; virtual;
    function GetCaption: string; virtual;
    function GetEnabled: Boolean; virtual;
    function GetVisible: Boolean; virtual;
  public
    property Caption: string read GetCaption;
    property Enabled: Boolean read GetEnabled;
    property Visible: Boolean read GetVisible;
    property Format: Word read GetFormat;
    function GetStream(AItem: IOTADataExplorerItem; AScopes: TScopesArray; AStream: TStream): Boolean; virtual; abstract;
    procedure Update(AItem: IOTADataExplorerItem; AScopes: TScopesArray); virtual;
  end;

  IOTADataExplorerComponentStreamForObject = Interface(IOTADataExplorerComponentStream)
    ['{BAFFA45F-402E-434A-9BF1-A967C6F286CC}']
    function GetStreamForObject(AObject: TObject; AStream: TStream): Boolean;
  End;

  TDEComponentStreamForObject = class(TDEComponentStream, IOTADataExplorerComponentStreamForObject)
  protected
    function GetStreamForObject(AObject: TObject; AStream: TStream): Boolean; virtual;
  end;

  IDEComponentStreams = Interface
    ['{7B90C43B-34BD-4FF2-85C6-45145D4286A3}']
    function GetCount: Integer;
    function GetItem(I: Integer): IOTADataExplorerComponentStream;
    procedure Add(AStream: IOTADataExplorerComponentStream);
    function ToArray: TDEComponentStreamArray;
  End;

  TDEComponentStreams = class(TInterfacedObject, IDEComponentStreams)
  private
    FList: IInterfaceListEx;
    function GetCount: Integer;
    function GetItem(I: Integer): IOTADataExplorerComponentStream;
  public
    constructor Create;
    procedure Add(AStream: IOTADataExplorerComponentStream);
    property Count: Integer read GetCount;
    property Items[I: Integer]: IOTADataExplorerComponentStream read GetItem;
    function ToArray: TDEComponentStreamArray;
  end;

  TExprItem = class;
  IDEItems = Interface
    ['{DC80F67D-E27F-49C8-8B18-5AB528F78EBC}']
    function GetCount: Integer;
    function GetItem(I: Integer): IOTADataExplorerItem;
    procedure Add(AItem: IOTADataExplorerItem);
    function ToArray: TDEItemsArray;
  End;
  TExprItems = class(TInterfacedObject, IDEItems)
  private
    FList: IInterfaceListEx;
    FOwner: TExprItem;
  protected
    function GetCount: Integer;
    function GetItem(I: Integer): IOTADataExplorerItem;
    function ToArray: TDEItemsArray;
  public
    constructor Create(AOwner: TExprItem);
    procedure Add(AItem: IOTADataExplorerItem);
    property Item[I: Integer]: IOTADataExplorerItem read GetItem;
    property Count: Integer read GetCount;
  end;

  TExprNodeCollectionItem = class;
  TExprStaticNodeItem = class;
  IExprItem = Interface(IOTADataExplorerItem)
    ['{C2D0E9F5-7AB0-46AF-BABF-7295CF21F032}']
    function AddCollectionItem(const AEnumeratorScopeName: string = ''; const AEnumeratorValue: string = ''): TExprNodeCollectionItem;
    function AddStaticItem(const AIdentity: string = '';
      const AName: string = ''; const ADisplayName: string = ''): TExprStaticNodeItem;
    procedure AddCommand(const ACaptionExpr, AExecuteExpr, AEnabledExpr, AVisibleExpr: string); overload;
    procedure AddCommand(const ACaptionExpr, AExecuteExpr: string); overload;
  End;

  TExprItem = class(TInterfacedObject, IOTADataExplorerItem, IExprItem)
  private
    FScopes: IScopes;
    FItems: IDEItems;
    FParent: TExprItem;
    FCommands: IDECommands;
    FNameExpression: string;
    FIdentityExpression: string;
    FEnabledExpression: string;
    function GetEnabled(AScopes: TScopesArray): Boolean; virtual;
  protected
    function EvaluateValueRec(const AValueRec: TDEValueRec; AScopes: TScopesArray): TValue;
    function GetItemCount: Integer;
    function GetItemsArray: TDEItemsArray;
    function GetScopesArray: TScopesArray;
    function GetCommandsArray: TDECommandsArray;
    function IsRoot: Boolean;
    function GetParent: TExprItem;
    procedure SetParent(const AParent: TExprItem);
    function GetScopes: IScopes; virtual;
    function GetCommands: IDECommands;
    function GetItems: IDEItems;
    function GetNameValue: TDEValueRec;
    procedure SetNameValue(const AValue: TDEValueRec);
    function GetIdentityValue: TDEValueRec;
    procedure SetIdentityValue(const AValue: TDEValueRec);
    function GetEnabledValue: TDEValueRec;
    procedure SetEnabledValue(const AValue: TDEValueRec);
    property Items: IDEItems read GetItems;
  public
    constructor Create;
    function AddCollectionItem(const AEnumeratorScopeName: string = ''; const AEnumeratorValue: string = ''): TExprNodeCollectionItem;
    function AddStaticItem(const AIdentity: string = '';
      const AName: string = ''; const ADisplayName: string = ''): TExprStaticNodeItem;
    procedure AddCommand(const ACaptionExpr, AExecuteExpr: string); overload;
    procedure AddCommand(const ACaptionExpr, AExecuteExpr, AEnabledExpr, AVisibleExpr: string); overload;
    property Parent: TExprItem read GetParent;
    property Scopes: IScopes read GetScopes;
    property Commands: IDECommands read GetCommands;
    property NameValue: TDEValueRec read GetNameValue write SetNameValue;
    property IdentityValue: TDEValueRec read GetIdentityValue write SetIdentityValue;
    property EnabledValue: TDEValueRec read GetEnabledValue write SetEnabledValue;
  end;

  TExprNodeCollectionItem = class(TExprItem, IOTADataExplorerNodeCollectionItem)
  private
    FEnumeratorExpression: string;
    FRefreshExpression: string;
    FEnumeratorScopeName: string;
    function GetEnumeratorValue: TDEValueRec;
    procedure SetEnumeratorValue(const AValue: TDEValueRec);
    function GetEnumeratorScopeName: string;
    procedure SetEnumeratorScopeName(const AValue: string);
    function GetRefreshValue: TDEValueRec;
    procedure SetRefreshValue(const AValue: TDEValueRec);
  public
    constructor Create;
    property EnumeratorValue: TDEValueRec read GetEnumeratorValue write SetEnumeratorValue;
    property RefreshValue: TDEValueRec read GetRefreshValue write SetRefreshValue;
    property EnumeratorScopeName: string read GetEnumeratorScopeName write SetEnumeratorScopeName;
  end;

  TExprStaticNodeItem = class(TExprItem, IOTADataExplorerStaticNodeItem)
  private
    FComponentStreams: IDEComponentStreams;
    FDisplayNameExpression: string;
    FObjectExpression: string;
    FImageIndex: Integer;
    FImageIndexExpression: string;
    function GetImageIndex: Integer;
    procedure SetImageIndex(const AIndex: Integer);
    function GetDisplayNameValue: TDEValueRec;
    procedure SetDisplayNameValue(const AValue: TDEValueRec);
    function GetImageIndexValue: TDEValueRec;
    procedure SetImageIndexValue(const AValue: TDEValueRec);
    function GetObjectValue: TDEValueRec;
    procedure SetObjectValue(const AValue: TDEValueRec);
    function GetEnabled(AScopes: TScopesArray): Boolean; override;
    function GetComponentStreams: IDEComponentStreams;
    function GetComponentStreamsArray: TDEComponentStreamArray;
  public
    constructor Create;
    property ImageIndex: Integer read GetImageIndex write SetImageIndex;
    property DisplayNameValue: TDEValueRec read GetDisplayNameValue write SetDisplayNameValue;
    property ImageIndexValue: TDEValueRec read GetImageIndexValue write SetImageIndexValue;
    property ObjectValue: TDEValueRec read GetObjectValue write SetObjectValue;
    property ComponentStreams: IDEComponentStreams read GetComponentStreams;
  end;

  TExprRootItem = class(TExprStaticNodeItem, IOTADataExplorerStaticNodeItem, IOTADataExplorerRootItem)
  public
    constructor Create(const AIdentity, AName, ADisplayName: string; const AScopes: Array of TScope);
  end;

  IExprCommand = Interface
    ['{6323FEF7-E555-4DF5-A07B-69122AED1220}']
    function GetCaptionExpression: string;
    procedure SetCaptionExpression(const AValue: string);
    function GetEnabledExpression: string;
    procedure SetEnabledExpression(const AValue: string);
    function GetExecuteExpression: string;
    procedure SetExecuteExpression(const AValue: string);
    function GetVisibleExpression: string;
    procedure SetVisibleExpression(const AValue: string);
    property CaptionExpression: string read GetCaptionExpression write SetCaptionExpression;
    property EnabledExpression: string read GetEnabledExpression write SetEnabledExpression;
    property ExecuteExpression: string read GetExecuteExpression write SetExecuteExpression;
    property VisibleExpression: string read GetVisibleExpression write SetVisibleExpression;
  End;
  TExpressionCommand = class(TInterfacedObject, IOTADataExplorerCommand, IExprCommand)
  private
    FCaptionExpression: string;
    FEnabledExpression: string;
    FExecuteExpression: string;
    FVisibleExpression: string;
    FVisible: Boolean;
    FCaption: string;
    FEnabled: Boolean;
  protected
    function GetCaption: string;
    function GetEnabled: Boolean;
    function GetVisible: Boolean;
    function GetCaptionExpression: string;
    procedure SetCaptionExpression(const AValue: string);
    function GetEnabledExpression: string;
    procedure SetEnabledExpression(const AValue: string);
    function GetExecuteExpression: string;
    procedure SetExecuteExpression(const AValue: string);
    function GetVisibleExpression: string;
    procedure SetVisibleExpression(const AValue: string);
  public
    constructor Create;
    property Caption: string read GetCaption;
    property Enabled: Boolean read GetEnabled;
    property Visible: Boolean read GetVisible;
    property CaptionExpression: string read GetCaptionExpression write SetCaptionExpression;
    property EnabledExpression: string read GetEnabledExpression write SetEnabledExpression;
    property ExecuteExpression: string read GetExecuteExpression write SetExecuteExpression;
    property VisibleExpression: string read GetVisibleExpression write SetVisibleExpression;
    procedure Execute(AItem: IOTADataExplorerItem; AScopes: TScopesArray);
    procedure Update(AItem: IOTADataExplorerItem; AScopes: TScopesArray);
  end;

  TExprComponentStreamForObject = class(TDEComponentStreamForObject, IOTADataExplorerComponentStreamForObject)
  public
    function GetStream(AItem: IOTADataExplorerItem; AScopes: TScopesArray; AStream: TStream): Boolean; override;
  end;

var
  CF_COMPONENTS: Word;

implementation

uses
  WinApi.Windows;

const
  cfDelphiComponents = 'Delphi Components';

{ TExpressionCommand }

constructor TExpressionCommand.Create;
begin
  FEnabled := True;
  FVisible := True;
end;

procedure TExpressionCommand.Execute(AItem: IOTADataExplorerItem; AScopes: TScopesArray);
begin
  if Self.FExecuteExpression <> '' then
    AItem.EvaluateValueRec(TDEValueRec.Create(FExecuteExpression), AScopes);
end;

function TExpressionCommand.GetCaption: string;
begin
  Result := FCaption;
end;

function TExpressionCommand.GetCaptionExpression: string;
begin
  Result := FCaptionExpression;
end;

function TExpressionCommand.GetEnabled: Boolean;
begin
  Result := FEnabled;
end;

function TExpressionCommand.GetEnabledExpression: string;
begin
  Result := FEnabledExpression;
end;

function TExpressionCommand.GetExecuteExpression: string;
begin
  Result := FExecuteExpression;
end;

function TExpressionCommand.GetVisible: Boolean;
begin
  Result := FVisible;
end;

function TExpressionCommand.GetVisibleExpression: string;
begin
  Result := FVisibleExpression;
end;

procedure TExpressionCommand.SetCaptionExpression(const AValue: string);
begin
  FCaptionExpression := AValue;
end;

procedure TExpressionCommand.SetEnabledExpression(const AValue: string);
begin
  FEnabledExpression := AValue;
end;

procedure TExpressionCommand.SetExecuteExpression(const AValue: string);
begin
  FExecuteExpression := AValue;
end;

procedure TExpressionCommand.SetVisibleExpression(const AValue: string);
begin
  FVisibleExpression := AValue;
end;

procedure TExpressionCommand.Update(AItem: IOTADataExplorerItem; AScopes: TScopesArray);
begin
  if Self.FCaptionExpression <> '' then
    FCaption := AItem.EvaluateValueRec(TDEValueRec.Create(FCaptionExpression), AScopes).AsString;

  if Self.FEnabledExpression <> '' then
    FEnabled := AItem.EvaluateValueRec(TDEValueRec.Create(FEnabledExpression), AScopes).AsBoolean;

  if Self.FVisibleExpression <> '' then
    FVisible := AItem.EvaluateValueRec(TDEValueRec.Create(FVisibleExpression), AScopes).AsBoolean;
end;

{ TExprComponentStreamForObject }

function TExprComponentStreamForObject.GetStream(AItem: IOTADataExplorerItem; AScopes: TScopesArray;
  AStream: TStream): Boolean;
var
  LObject: TObject;
  LValue: TValue;
  LStaticItem: IOTADataExplorerStaticNodeItem;
begin
  Result := False;
  if Supports(AItem, IOTADataExplorerStaticNodeItem, LStaticItem) then
  begin
    LValue := LStaticItem.EvaluateValueRec(LStaticItem.ObjectValue, AScopes);
    if LValue.IsType<TPersistent> then
      LObject := LValue.AsType<TPersistent>
    else
      LObject := nil;
    if LObject <> nil then
      Result := Self.GetStreamForObject(LObject, AStream);
  end;
end;

{ TExprRootItem }

constructor TExprRootItem.Create(const AIdentity, AName, ADisplayName: string; const AScopes: Array of TScope);
var
  LScope: TScope;
begin
  inherited Create;
  DisplayNameValue := TDEValueRec.Create(ADisplayName);
  NameValue := TDEValueRec.Create(AName);
  IdentityValue := TDEValueRec.Create(AIdentity);
  if AIdentity <> '' then
    ObjectValue := TDEValueRec.Create(AIdentity);                                     
  for LScope in AScopes do
    Scopes.Add(LScope);
end;

{ TExprStaticNodeItem }

constructor TExprStaticNodeItem.Create;
begin
  inherited;
  FImageIndex := -1;
  FComponentStreams := TDEComponentStreams.Create;
end;

function TExprStaticNodeItem.GetComponentStreams: IDEComponentStreams;
begin
  Result := FComponentStreams;
end;

function TExprStaticNodeItem.GetComponentStreamsArray: TDEComponentStreamArray;
begin
  Result := ComponentStreams.ToArray;
end;

function TExprStaticNodeItem.GetDisplayNameValue: TDEValueRec;
begin
  Result := TDEValueRec.Create(FDisplayNameExpression);
end;

function TExprStaticNodeItem.GetEnabled(AScopes: TScopesArray): Boolean;
var
  LValue: TValue;
begin
  if Length(AScopes) > 0 then
    LValue := EvaluateValueRec(GetEnabledValue, AScopes)
  else
    LValue := EvaluateValueRec(GetEnabledValue, GetScopesArray);
  if (not LValue.IsEmpty) and LValue.IsType<Boolean> then
    Result := LValue.AsBoolean
  else
    Result := True;
end;

function TExprStaticNodeItem.GetImageIndex: Integer;
begin
  Result := FImageIndex;
end;

function TExprStaticNodeItem.GetImageIndexValue: TDEValueRec;
begin
  Result := TDEValueRec.Create(FImageIndexExpression);
end;

function TExprStaticNodeItem.GetObjectValue: TDEValueRec;
begin
  Result := TDEValueRec.Create(FObjectExpression);
end;

procedure TExprStaticNodeItem.SetDisplayNameValue(const AValue: TDEValueRec);
begin
  FDisplayNameExpression := AValue.Value;
end;

procedure TExprStaticNodeItem.SetImageIndex(const AIndex: Integer);
begin
  //ImageIndex properties should be mutually exclusive
  FImageIndexExpression := '';
  FImageIndex := AIndex;
end;

procedure TExprStaticNodeItem.SetImageIndexValue(const AValue: TDEValueRec);
begin
  //ImageIndex properties should be mutually exclusive
  FImageIndex := -1;
  FImageIndexExpression := AValue.Value;
end;

procedure TExprStaticNodeItem.SetObjectValue(const AValue: TDEValueRec);
begin
  FObjectExpression := AValue.Value;
end;

{ TExprItem }

constructor TExprItem.Create;
begin
  inherited;
  FScopes := TScopes.Create;
  FItems := TExprItems.Create(Self);
  FCommands := TDECommands.Create;
end;

function TExprItem.EvaluateValueRec(const AValueRec: TDEValueRec;
  AScopes: TScopesArray): TValue;
var
  LDictionaryScope: TDictionaryScope;
  LItem: IOTADataExplorerItem;
  LItemScope: TScope;
  LObjectScope: IScope;
  LBindingExpression: TBindingExpression;
  LScopeIntf: IScope;
  LPair: TScope;
  LValue: IValue;
  I: Integer;
  LScopes: TScopesArray;
begin
  if AValueRec.Value = '' then
    Exit(TValue.Empty);

  LDictionaryScope := TDictionaryScope.Create;
  LScopeIntf := LDictionaryScope; // be sure this object is freed even if except
  if Supports(Self, IOTADataExplorerItem, LItem) then
  begin
    LObjectScope := WrapObject(TObject(LItem));
    // Pass tree object named _Item
    LDictionaryScope.Map.Add('_Item', LObjectScope);
  end;
  while LItem <> nil do
  begin
    LScopes := LItem.GetScopesArray;
    for I := 0 to Length(LScopes) - 1 do
    begin
      LItemScope := TScope.Create(LScopes[I].Name, LScopes[I].Obj);
      LObjectScope := WrapObject(LItemScope.Obj);
      LDictionaryScope.Map.Add(LItemScope.Name, LObjectScope);
    end;
    LItem := TExprItem(LItem).Parent;
  end;
  if AScopes <> nil then
    for LPair in AScopes do
    begin
      LObjectScope := WrapObject(LPair.Obj);
      if not LDictionaryScope.Map.ContainsKey(LPair.Name) then
        LDictionaryScope.Map.Add(LPair.Name, LObjectScope);
    end;
  LScopeIntf := TNestedScope.Create(TBindingMethodsFactory.GetMethodScope, LScopeIntf);
  LBindingExpression := TBindings.CreateExpression(
    LScopeIntf,
    AValueRec.Value);
  try
    //Note: We must retrieve the TValue before freeing the TBindingExpression
    // otherwise the interfaced objects containing the data will be gone as well
    LValue := LBindingExpression.Evaluate;
    if LValue = nil then
      Result := TValue.Empty
    else
      Result := LValue.GetValue;
  finally
    LBindingExpression.Free;
  end;
end;

function TExprItem.GetCommandsArray: TDECommandsArray;
var
  LCommands: IDECommands;
begin
  if Supports(FCommands, IDECommands, LCommands) then
    Result := LCommands.ToArray
  else
    Result := nil;
end;

function TExprItem.GetEnabled(AScopes: TScopesArray): Boolean;
begin
  Result := True;
end;

function TExprItem.GetEnabledValue: TDEValueRec;
begin
  Result := TDEValueRec.Create(FEnabledExpression);
end;

function TExprItem.GetScopesArray: TScopesArray;
var
  LScopes: IScopes;
begin
  if Supports(FScopes, IScopes, LScopes) then
    Result := LScopes.ToArray
  else
    Result := nil;
end;

function TExprItem.GetItemsArray: TDEItemsArray;
begin
  if FItems = nil then
    Result := nil
  else
    Result := FItems.ToArray;
end;

function TExprItem.IsRoot: Boolean;
begin
  if Supports(Self, IOTADataExplorerRootItem) then
    Result := True
  else
    Result := False;
end;

procedure TExprItem.SetParent(const AParent: TExprItem);
begin
  FParent := AParent;
end;

function TExprItem.GetParent: TExprItem;
begin
  Result := FParent;
end;

function TExprItem.GetScopes: IScopes;
begin
  Result := FScopes;
end;

function TExprItem.GetItemCount: Integer;
begin
  Result := FItems.GetCount;
end;

function TExprItem.GetItems: IDEItems;
begin
  Result := FItems;
end;

function TExprItem.GetCommands: IDECommands;
begin
  Result := FCommands;
end;

procedure TExprItem.AddCommand(const ACaptionExpr, AExecuteExpr: string);
begin
  AddCommand(ACaptionExpr, AExecuteExpr, '', '');
end;

procedure TExprItem.AddCommand(const ACaptionExpr, AExecuteExpr, AEnabledExpr, AVisibleExpr: string);
var
  LCommand: IExprCommand;
begin
  LCommand := TExpressionCommand.Create;
  LCommand.CaptionExpression := ACaptionExpr;
  LCommand.ExecuteExpression := AExecuteExpr;
  LCommand.EnabledExpression := AEnabledExpr;
  LCommand.VisibleExpression := AVisibleExpr;
  Commands.Add(LCommand as IOTADataExplorerCommand);
end;

function TExprItem.AddStaticItem(const AIdentity: string = '';
  const AName: string = ''; const ADisplayName: string = ''): TExprStaticNodeItem;
begin
  Result := TExprStaticNodeItem.Create;
  Items.Add(Result);
  Result.DisplayNameValue := TDEValueRec.Create(ADisplayName);
  Result.NameValue := TDEValueRec.Create(AName);
  Result.IdentityValue := TDEValueRec.Create(AIdentity);
  if AIdentity <> '' then
    Result.ObjectValue := TDEValueRec.Create(AIdentity);                                     
end;

function TExprItem.AddCollectionItem(const AEnumeratorScopeName, AEnumeratorValue: string): TExprNodeCollectionItem;
begin
  Result := TExprNodeCollectionItem.Create;
  Items.Add(Result);
  Result.EnumeratorScopeName := AEnumeratorScopeName;
  Result.EnumeratorValue := TDEValueRec.Create(AEnumeratorValue);
end;

function TExprItem.GetNameValue: TDEValueRec;
begin
  Result := TDEValueRec.Create(FNameExpression);
end;

procedure TExprItem.SetNameValue(const AValue: TDEValueRec);
begin
  FNameExpression := AValue.Value;
end;

function TExprItem.GetIdentityValue: TDEValueRec;
begin
  Result := TDEValueRec.Create(FIdentityExpression);
end;

procedure TExprItem.SetEnabledValue(const AValue: TDEValueRec);
begin
  FEnabledExpression := AValue.Value;
end;

procedure TExprItem.SetIdentityValue(const AValue: TDEValueRec);
begin
  FIdentityExpression := AValue.Value;
end;

{ TExprNodeCollectionItem }

function TExprNodeCollectionItem.GetEnumeratorScopeName: string;
begin
  Result := FEnumeratorScopeName;
end;

function TExprNodeCollectionItem.GetEnumeratorValue: TDEValueRec;
begin
  Result := TDEValueRec.Create(FEnumeratorExpression);
end;

function TExprNodeCollectionItem.GetRefreshValue: TDEValueRec;
begin
  Result := TDEValueRec.Create(FRefreshExpression);
end;

procedure TExprNodeCollectionItem.SetEnumeratorScopeName(const AValue: string);
begin
  FEnumeratorScopeName := AValue;
end;

procedure TExprNodeCollectionItem.SetEnumeratorValue(const AValue: TDEValueRec);
begin
  FEnumeratorExpression := AValue.Value;
end;

procedure TExprNodeCollectionItem.SetRefreshValue(const AValue: TDEValueRec);
begin
  FRefreshExpression := AValue.Value;
end;

constructor TExprNodeCollectionItem.Create;
begin
  inherited;
end;

{ TScopes }

procedure TScopes.Add(AScope: TScope);
begin
  FList.Add(AScope);
end;

function TScopes.ToArray: TScopesArray;
begin
  Result := FList.toArray;
end;

constructor TScopes.Create;
begin
  inherited Create;
  FList := TList<TScope>.Create;
end;

destructor TScopes.Destroy;
begin
  FList.Free;
  inherited;
end;

function TScopes.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TScopes.GetItem(I: Integer): TScope;
begin
  Result := FList[I];
end;

{ TExprItems }

constructor TExprItems.Create(AOwner: TExprItem);
begin
  inherited Create;
  FOwner := AOwner;
  FList := TInterfaceList.Create;
end;

procedure TExprItems.Add(AItem: IOTADataExplorerItem);
  function FindParentStaticNode(const AItem: TExprItem): TExprStaticNodeItem;
  begin
    Result := nil;
    if (AItem <> nil) then
    begin
      if AItem is TExprStaticNodeItem then
        Exit(AItem as TExprStaticNodeItem);
      if AItem is TExprItem then
        Result := FindParentStaticNode(TExprItem(AItem.Parent))
    end;
  end;
var
  LStaticItem: TExprStaticNodeItem;
begin
  FList.Add(AItem);

  if AItem is TExprItem then
  begin
    Assert(TExprItem(AItem).Parent = nil);
    TExprItem(AItem).SetParent(FOwner);
    if FOwner <> nil then
    begin
      if AItem is TExprStaticNodeItem then
      begin
        LStaticItem := FindParentStaticNode(FOwner);
        if LStaticItem <> nil then
        begin
          if LStaticItem.ImageIndex = -1 then
            TExprStaticNodeItem(AItem).ImageIndexValue := LStaticItem.ImageIndexValue
          else
            TExprStaticNodeItem(AItem).ImageIndex := LStaticItem.ImageIndex;
        end;
      end;
    end;
  end;
end;

function TExprItems.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TExprItems.GetItem(I: Integer): IOTADataExplorerItem;
begin
  Result := FList[I] as IOTADataExplorerItem;
end;

function TExprItems.ToArray: TDEItemsArray;
var
  I: Integer;
begin
  SetLength(Result, FList.Count);
  for I := 0 to FList.Count - 1 do
    Result[I] := FList.Items[I] as IOTADataExplorerItem;
end;

{ TDECommands }

procedure TDECommands.Add(ACommand: IOTADataExplorerCommand);
begin
  FList.Add(ACommand);
end;

constructor TDECommands.Create;
begin
  inherited;
  FList := TInterfaceList.Create;
end;

function TDECommands.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TDECommands.GetItem(I: Integer): IOTADataExplorerCommand;
begin
  Result := FList[I] as IOTADataExplorerCommand;
end;

function TDECommands.ToArray: TDECommandsArray;
var
  I: Integer;
begin
  SetLength(Result, FList.Count);
  for I := 0 to FList.Count - 1 do
    Result[I] := FList.Items[I] as IOTADataExplorerCommand;
end;

{ TDEComponentStreams }

procedure TDEComponentStreams.Add(AStream: IOTADataExplorerComponentStream);
begin
  FList.Add(AStream);
end;

function TDEComponentStreams.ToArray: TDEComponentStreamArray;
var
  I: Integer;
begin
  SetLength(Result, FList.Count);
  for I := 0 to FList.Count - 1 do
    Result[I] := FList.Items[I] as IOTADataExplorerComponentStream;
end;

constructor TDEComponentStreams.Create;
begin
  inherited;
  FList := TInterfaceList.Create;
end;

function TDEComponentStreams.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TDEComponentStreams.GetItem(I: Integer): IOTADataExplorerComponentStream;
begin
  Result := FList[I] as IOTADataExplorerComponentStream;
end;

{ TDEComponentStreamForObject }

function TDEComponentStreamForObject.GetStreamForObject(AObject: TObject; AStream: TStream): Boolean;
begin
  Result := False;
  assert(False);
end;

{ TDEComponentStream }

function TDEComponentStream.GetCaption: string;
begin
  Result := '';
end;

function TDEComponentStream.GetEnabled: Boolean;
begin
  Result := True;
end;

function TDEComponentStream.GetFormat: Word;
begin
  Result := CF_COMPONENTS;
end;

function TDEComponentStream.GetVisible: Boolean;
begin
  Result := True;
end;

procedure TDEComponentStream.Update(AItem: IOTADataExplorerItem; AScopes: TScopesArray);
begin
  //
end;

initialization
  CF_COMPONENTS := RegisterClipboardFormat(cfDelphiComponents);

end.
