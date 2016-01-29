{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.Bind.Editors;

interface

uses
  System.Classes, System.Bindings.EvalProtocol, Data.Bind.Components, System.Bindings.ObjEval,
  System.Rtti, System.Generics.Collections;

type
  TBindListEditorCommon = class(TInterfacedObject, IBindListEditorCommon)
  protected
    procedure BeginUpdate; virtual; abstract;
    procedure EndUpdate; virtual; abstract;
    procedure ClearList; virtual; abstract;
    function GetSelectedItem: TObject; virtual;
    function GetSelectedValue: TValue; virtual;
    function GetSelectedText: string; virtual; abstract;
    function GetRowCount: Integer; virtual; abstract;
    function GetPositionGetter(var AGetter: string; var ABase: Integer): Boolean; virtual; abstract;
    function GetPositionSetter(var ASetter: string; var ABase: Integer): Boolean; virtual; abstract;
  end;

  TBindListEditor = class(TBindListEditorCommon, IBindListEditor, IBindListEditorItem)
  private
  protected
    { IBindListGroupEditor }
    procedure FillGroupList(ARecordEnumerator: IScopeRecordEnumerator;
      AFormatProc, AFormatHeaderProc: TFormatCallback;
      AQueryBreakCallback: TQueryBreakCallback); virtual;
    function AddHeader: IScope; virtual;
    function CurrentHeaderItem: IScope; virtual;
    { IBindFillControlMembers }
    procedure GetItemMemberNames(ANames: TStrings); virtual;
    function GetItemMemberNameExpression(const AName: string): string; virtual;
    procedure GetHeaderMemberNames(ANames: TStrings); virtual;
    function GetHeaderMemberNameExpression(const AName: string): string; virtual;

    function AddItem(Select: Boolean = False): IScope; virtual; abstract;
    function CanInsertItem: Boolean; virtual; abstract;
    function InsertItem(Select: Boolean = False): IScope; virtual; abstract;
    function MoveNext: Boolean; virtual; abstract;
    function CurrentItem: IScope; virtual; abstract;
    procedure DeleteToEnd; virtual; abstract;
    function UpdateNeeded(ARecordEnumerator: IScopeRecordEnumerator): Boolean; virtual;
    function RefreshNeeded(ARecordEnumerator: IScopeRecordEnumerator): Boolean; virtual;
    procedure UpdateList(ARecordEnumerator: IScopeRecordEnumerator; AFormatProc: TFormatCallback); virtual;
    procedure FillList(ARecordEnumerator: IScopeRecordEnumerator; AFormatProc: TFormatCallback); virtual;
    procedure SetSelectedText(const AValue: string); virtual; abstract;
    procedure SetSelectedValue(const AValue: TValue); virtual;
    function GetPositionGetter(var AGetter: string;
      var ABase: Integer): Boolean; override;
    function GetPositionSetter(var ASetter: string;
      var ABase: Integer): Boolean; override;
    { IBindListEditorItem }
    function CurrentObject: TObject; virtual;
    function CurrentIndex: Integer; virtual;
  end;

  TBindListLookupEditor = class(TBindListEditor, IBindListLookupEditor)
  private
    FUseLookups: Boolean;
  protected
    function GetUseLookups: Boolean;
    procedure SetUseLookups(AUseLookups: Boolean);
    function GetLookupValue(const AScope: IScope): TValue; virtual; abstract;
    procedure SetLookupValue(const AScope: IScope; const AValue: TValue); virtual; abstract;
    function GetSelectedLookupValue: TValue; virtual; abstract;
    procedure SetSelectedLookupValue(const AValue: TValue); virtual; abstract;
    procedure SetSelectedValue(const AValue: TValue); override;
    function GetSelectedValue: TValue; override;
  end;

  TBindCheckBoxEditor = class(TInterfacedObject, IBindCheckBoxEditor)
  protected
    function GetState: TBindCheckBoxState; virtual; abstract;
    procedure SetState(Value: TBindCheckBoxState); virtual; abstract;
    function GetAllowGrayed: Boolean; virtual; abstract;
    procedure SetAllowGrayed(Value: Boolean); virtual; abstract;
  end;

  TBindGridEditor = class(TBindListEditor, IBindGridEditor)
  protected
    procedure GetColumnNames(AList: TStrings); virtual; abstract;
    procedure GetColumnIndices(AList: TStrings); virtual; abstract;
  end;

  TEditors = class(TComponent)
  private
    FDictionary: TDictionary<TComponent, IInterface>;
    function GetCount: Integer;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Add(AComponent: TComponent; const AEditor: IInterface);
    procedure Remove(AComponent: TComponent);
    function TryGetValue(AComponent: TComponent; out AEditor: IInterface): Boolean;
    property Count: Integer read GetCount;
  end;

function IsLinkFillControl(AComponent: TComponent; out ALookupControl: Boolean): Boolean; overload;
function IsLinkFillControl(AComponent: TComponent): Boolean; overload;

implementation

uses System.SysUtils, Data.Bind.Grid;

function IsLinkFillControl(AComponent: TComponent): Boolean;
var
  LLookup: Boolean;
begin
  Result := IsLinkFillControl(AComponent, LLookup);
end;

function IsLinkFillControl(AComponent: TComponent; out ALookupControl: Boolean): Boolean;
var
  LEditor: IInterface;
begin
  Result := False;
  ALookupControl := False;
  if AComponent <> nil then
  begin
    LEditor := GetBindEditor(AComponent, IBindListEditorCommon);
    if Supports(LEditor, IBindListLookupEditor) then
    begin
      ALookupControl := True;
      Result := True;
    end
    else if Supports(LEditor, IBindListEditor) then
    begin
      if not GetIsLinkGridToDataSourceControl(AComponent) then
        Result := True;
    end;
  end;
end;

{ TBindListEditorCommon }

function TBindListEditorCommon.GetSelectedItem: TObject;
begin
  Result := nil;
end;

function TBindListEditorCommon.GetSelectedValue: TValue;
begin
  Result := GetSelectedText;
end;

{ TBindListEditor }

procedure TBindListEditor.FillList(ARecordEnumerator: IScopeRecordEnumerator;
  AFormatProc: TFormatCallback);
var
  LEditor: IBindListEditor;
  LEnumerator: IScopeRecordEnumerator;
  LEditorScope: IScope;
begin
  LEditor := Self;
  LEditor.BeginUpdate;
  try
    LEnumerator := ARecordEnumerator;
    LEnumerator.First;
    LEditor.ClearList;
    if LEnumerator <> nil then
    begin
      while LEnumerator.MoveNext do
      begin
        LEditorScope := LEditor.AddItem;
        Assert(LEditorScope <> nil);
        if LEditorScope <> nil then
        begin
          AFormatProc(LEnumerator.Current, LEditorScope);
        end;
        LEditorScope := nil;
      end;
    end
    else
      Assert(False);
  finally
    LEditor.EndUpdate;
  end;

end;

function TBindListEditor.GetHeaderMemberNameExpression(
  const AName: string): string;
begin
  Result := '';
end;

procedure TBindListEditor.GetHeaderMemberNames(ANames: TStrings);
begin
 //
end;

function TBindListEditor.GetItemMemberNameExpression(
  const AName: string): string;
begin
  Result := '';
end;

procedure TBindListEditor.GetItemMemberNames(ANames: TStrings);
begin
 //
end;

function TBindListEditor.AddHeader: IScope;
begin
  Result := nil;
end;

function TBindListEditor.CurrentHeaderItem: IScope;
begin
  Result := nil;
end;

function TBindListEditor.CurrentIndex: Integer;
begin
  Result := -1;
end;

function TBindListEditor.CurrentObject: TObject;
begin
  Result := nil;
end;

procedure TBindListEditor.FillGroupList(ARecordEnumerator: IScopeRecordEnumerator;
      AFormatProc: TFormatCallback;
      AFormatHeaderProc: TFormatCallback;
      AQueryBreakCallback: TQueryBreakCallback);
var
  LEditor: IBindListEditor;
  LGroupEditor: IBindListGroupEditor;
  LEnumerator: IScopeRecordEnumerator;
  LEditorScope: IScope;
  LBreak: Boolean;
begin
  LEditor := Self;
  LGroupEditor := LEditor as IBindListGroupEditor;
  Assert(LGroupEditor <> nil);
  LEditor.BeginUpdate;
  try
    LEnumerator := ARecordEnumerator;
    LEnumerator.First;
    LEditor.ClearList;
                                                                               
    if LEnumerator <> nil then
    begin
      while LEnumerator.MoveNext do
      begin
        if Assigned(AQueryBreakCallback) then
          LBreak := AQueryBreakCallback(LEnumerator.Current)
        else
          LBreak := False;
        if LBreak then
          if Assigned(AFormatHeaderProc) then
          begin
            LEditorScope := LGroupEditor.AddHeader;
            if Assigned(LEditorScope) then
              AFormatHeaderProc(LEnumerator.Current, LEditorScope);
          end;
        if Assigned(AFormatProc) then
        begin
          LEditorScope := LEditor.AddItem;
          if Assigned(LEditorScope) then
            AFormatProc(LEnumerator.Current, LEditorScope);
        end;
      end;
    end
    else
      Assert(False);
  finally
    LEditor.EndUpdate;
  end;

end;

const
  sItemIndex = 'ItemIndex';

function TBindListEditor.GetPositionGetter(var AGetter: string;
  var ABase: Integer): Boolean;
begin
  AGetter := sItemIndex; // do not local
  ABase := 0;
  Result := True;
end;

function TBindListEditor.GetPositionSetter(var ASetter: string;
  var ABase: Integer): Boolean;
begin
  ASetter := sItemIndex;
  ABase := 0;
  Result := True;
end;


procedure TBindListEditor.SetSelectedValue(const AValue: TValue);
begin
  SetSelectedText(AValue.ToString);
end;

procedure TBindListEditor.UpdateList(ARecordEnumerator: IScopeRecordEnumerator;
  AFormatProc: TFormatCallback);
var
  LEditor: IBindListEditor;
  LEditorScope: IScope;
begin
  LEditor := Self;

  LEditor.BeginUpdate;
  try
    if ARecordEnumerator <> nil then
    begin
      // Update existing items
      while LEditor.MoveNext do
      begin
        if ARecordEnumerator.MoveNext then
        begin
          LEditorScope := LEditor.CurrentItem;
          Assert(LEditorScope <> nil);
          if LEditorScope <> nil then
          begin
            AFormatProc(ARecordEnumerator.Current, LEditorScope);
          end;
        end
        else
        begin
          Assert(True); //Debugging
          break;
        end;
      end;
      // Delete remaining items, if any
      LEditor.DeleteToEnd;
      // Add new items
      // do not call ARecordEnumerator.First 
      while ARecordEnumerator.MoveNext do
      begin
        LEditorScope := LEditor.AddItem;
        Assert(LEditorScope <> nil);
        if LEditorScope <> nil then
        begin
          AFormatProc(ARecordEnumerator.Current, LEditorScope);
        end;
      end;
    end
    else
      Assert(False);
  finally
    LEditor.EndUpdate;
  end;
end;

// Update from current item down
function TBindListEditor.UpdateNeeded(
  ARecordEnumerator: IScopeRecordEnumerator): Boolean;
var
  LEditor: IBindListEditor;
  LEnumeratorCount: IScopeRecordEnumeratorCount;
begin
  LEditor := Self;
  if ARecordEnumerator <> nil then
  begin
    if RefreshNeeded(ARecordEnumerator) then
      Exit(True);

    if Supports(ARecordEnumerator, IScopeRecordEnumeratorCount, LEnumeratorCount) then
      if LEditor.RowCount = LEnumeratorCount.RecordCount then
        // Assume record count changes because of insert or delete
        Exit(False);
  end;
  Result := True; // don't know default to true
end;

// Refresh entire list
function TBindListEditor.RefreshNeeded(
  ARecordEnumerator: IScopeRecordEnumerator): Boolean;
var
  LEditor: IBindListEditor;
  LEnumeratorStatus: IScopeRecordEnumeratorStatus;
begin
  LEditor := Self;
  if ARecordEnumerator <> nil then
  begin
    if Supports(ARecordEnumerator, IScopeRecordEnumeratorStatus, LEnumeratorStatus) then
      if LEnumeratorStatus.MultiRecordChange then
        // Handle something like sort or cancel updates
        Exit(True);
  end;
  Result := False;
end;

{ TBindListLookupEditor }

function TBindListLookupEditor.GetSelectedValue: TValue;
begin
  if FUseLookups then
    Result := GetSelectedLookupValue
  else
    Result := GetSelectedText;

end;

function TBindListLookupEditor.GetUseLookups: Boolean;
begin
  Result := FUseLookups;
end;

procedure TBindListLookupEditor.SetSelectedValue(const AValue: TValue);
begin
  if FUseLookups then
    SetSelectedLookupValue(AValue)
  else
    SetSelectedText(AValue.ToString);
end;

procedure TBindListLookupEditor.SetUseLookups(AUseLookups: Boolean);
begin
  FUseLookups := AUseLookups;
end;

{ TEditors }

procedure TEditors.Add(AComponent: TComponent; const AEditor: IInterface);
begin
  AComponent.FreeNotification(Self);
  FDictionary.Add(AComponent, AEditor);
end;

constructor TEditors.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDictionary := TDictionary<TComponent, IInterface>.Create();
end;

destructor TEditors.Destroy;
begin
  FDictionary.Free;
  inherited;
end;

function TEditors.GetCount: Integer;
begin
  Result := FDictionary.Count;
end;

procedure TEditors.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if Operation = TOperation.opRemove then
  begin
    Remove(AComponent);
  end;
end;

procedure TEditors.Remove(AComponent: TComponent);
begin
  if FDictionary.ContainsKey(AComponent) then
    FDictionary.Remove(AComponent);
end;

function TEditors.TryGetValue(AComponent: TComponent;
  out AEditor: IInterface): Boolean;
begin
  Result := FDictionary.TryGetValue(AComponent, AEditor);
end;

end.
