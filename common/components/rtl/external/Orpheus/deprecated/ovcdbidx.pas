{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                  OVCDBIDX.PAS 2.17                    *}
{*     Copyright 1995-98 (c) TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcDbIdx;
  {-Data-aware index selection combobox component}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, Controls, Db, DbTables, {DbiProcs,} Forms, Graphics, Menus, {!!.13}
  Messages, StdCtrls, SysUtils,
  OvcBase, OvcConst, OvcData, OvcExcpt, OvcVer;

type
  {possible display modes for the items shown in the drop-down list}
  TDisplayMode   = (dmFieldLabel, dmIndexName, dmFieldNames, dmFieldNumbers, dmUserDefined);
    {
     dmFieldLabel   - Displays the DisplayLabel of the primary field in the index
     dmIndexName    - Displays the actual index name ("Default" for Paradox's primary index)
     dmFieldNames   - Displays the list of field names that make up the index
     dmFieldNumbers - Displays the list of field numbers that make of the index
     dmUserDefined  - Displays a string returned from calls to the OnGetDisplayLabel event handler
    }

const
  DefDisplayMode = dmFieldLabel;
  DefMonitorIdx  = False;
  DefShowHidden  = True;

type
  TOvcDbIndexSelect = class;

  TGetDisplayLabelEvent =
    procedure(Sender : TOvcDbIndexSelect; const FieldNames,
              IndexName : string; IndexOptions : TIndexOptions;
              var DisplayName : string)
    of object;

  TOvcIndexInfo = class(TObject)
  {.Z+}
  protected {private }
    FDisplayName  : string;            {display name}
    FFields       : TStringList;       {list of field names for this index}
    FFieldNames   : string;            {names of index fields}
    FIndexName    : string;            {name of this index}
    FIndexOptions : TIndexOptions;     {index options}
    FOwner        : TOvcDbIndexSelect;
    FTable        : TTable;            {table that has this index}

    procedure SetDisplayName(const Value : string);

  protected

  public
  {.Z-}
    constructor Create(AOwner : TOvcDbIndexSelect;
      ATable : TTable; const AIndexName, AFieldNames : string);        {!!.13}
      virtual;
  {.Z+}
    destructor Destroy;
      override;
  {.Z-}

    procedure RefreshIndexInfo;

    property DisplayName : string
      read FDisplayName
      write SetDisplayName;

    property Fields : TStringList
      read FFields;

    property FieldNames : string
      read FFieldNames;

    property IndexName : string
      read FIndexName;
  end;

  {.Z+}
  TOvcIndexSelectDataLink = class(TDataLink)
  protected {private }
    FIndexSelect : TOvcDbIndexSelect;
  protected
    procedure ActiveChanged;
      override;
    procedure DataSetChanged;
      override;
    procedure LayoutChanged;
      override;
  public
    constructor Create(AIndexSelect : TOvcDbIndexSelect);
  end;
  {.Z-}

  TOvcDbIndexSelect = class(TCustomComboBox)
  {.Z+}
  protected {private}
    {property variables}
    FDataLink          : TOvcIndexSelectDataLink;
    FDisplayMode       : TDisplayMode;           {what to display as index name}
    FMonitorIdx        : Boolean;                {True, to monitor index changes}
    FShowHidden        : Boolean;                {True, to show index for hidden fields}

    {event variables}
    FOnGetDisplayLabel : TGetDisplayLabelEvent;

    {internal variables}
    isRefreshPending : Boolean;

    {property methods}
    function GetDataSource : TDataSource;
    function GetVersion : string;                                      {!!.13}
    procedure SetDataSource(Value : TDataSource);
    procedure SetDisplayMode(Value : TDisplayMode);
    procedure SetMonitorIdx(Value : Boolean);
    procedure SetShowHidden(Value : Boolean);
    procedure SetVersion(Value : string);                              {!!.13}

    {windows message handling methods}
    procedure WMPaint(var Msg : TWMPaint);
      message WM_PAINT;

    {internal methods}
    procedure isFindIndex;

  protected
    procedure Change;
      override;
    procedure ClearObjects;
      virtual;
    procedure CreateWnd;
      override;
    procedure DestroyWnd;
      override;
    procedure DropDown;
      override;

  public
    constructor Create(AOwner: TComponent);
      override;
    destructor Destroy;
      override;
  {.Z-}

    procedure RefreshList;
    procedure RefreshNow;
    procedure SetRefreshPendingFlag;

    {public properties}
    property Canvas;
    property Items;
    property MaxLength;
    property Text;

  published
    {properties}
    property DataSource : TDataSource
      read GetDataSource
      write SetDataSource;

    property DisplayMode : TDisplayMode
      read FDisplayMode
      write SetDisplayMode
      default DefDisplayMode;

    property MonitorIndexChanges : Boolean
      read FMonitorIdx
      write SetMonitorIdx
      default DefMonitorIdx;

    property ShowHidden : Boolean
      read FShowHidden
      write SetShowHidden
      default DefShowHidden;

    property Version : string                                          {!!.13}
      read GetVersion                                                  {!!.13}
      write SetVersion                                                 {!!.13}
      stored False;                                                    {!!.13}

    {inherited properties}
    property Color;
    property Ctl3D;
    property DragMode;
    property DragCursor;
    property DropDownCount;
    property Enabled;
    property Font;
    property ItemHeight;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property Visible;

    {events}
    property OnGetDisplayLabel : TGetDisplayLabelEvent
      read FOnGetDisplayLabel
      write FOnGetDisplayLabel;

    {inherited events}
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDrawItem;
    property OnDropDown;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
  end;

implementation


{$IFDEF TRIALRUN}
uses OrTrial;
{$I ORTRIALF.INC}
{$ENDIF}


{*** TOvcIndexInfo ***}

constructor TOvcIndexInfo.Create(AOwner : TOvcDbIndexSelect;
            ATable : TTable; const AIndexName, AFieldNames : string);  {!!.13}
begin
  inherited Create;

  FOwner      := AOwner;
  FTable      := ATable;
  FIndexName  := AIndexName;                                           {!!.13}
  FFieldNames := AFieldNames;

  FFields := TStringList.Create;

  RefreshIndexInfo;
end;

destructor TOvcIndexInfo.Destroy;
begin
  FFields.Free;
  FFields := nil;

  inherited Destroy;
end;

procedure TOvcIndexInfo.RefreshIndexInfo;
var
  I   : Integer;
  ID  : TIndexDef;
  Fld : TField;
begin
  if not FTable.Active then
    Exit;

  {!!.13} {begin revised block}
  if FFieldNames = '' then begin

    {use the previously saved index name}
    FDisplayName := FIndexName;

    {is this a FlashFiler default index}
    if AnsiCompareText(FIndexName, 'Seq. Access Index') = 0 then
      FDisplayName := GetOrphStr(SCDefaultIndex);

    if (FOwner.DisplayMode = dmUserDefined) and Assigned(FOwner.FOnGetDisplayLabel) then
      FOwner.FOnGetDisplayLabel(FOwner, FFieldNames, FIndexName, FIndexOptions, FDisplayName);

    Exit;
  end;

  ID := nil;
  I := FTable.IndexDefs.IndexOf(FIndexName);
  if I > -1 then
    ID := FTable.IndexDefs[I];
  {!!.13} {end revised block}

  if Assigned(ID) then begin
    FIndexName := ID.Name;
    FIndexOptions := ID.Options;

    {fill list with field names}
    I := 1;
    FFields.Clear;
    while I < Length(FFieldNames) do
      FFields.Add(ExtractFieldName(FFieldNames, I));

    {set the text to use as the display name}
    if (FFields.Count > 0) and ((ID.Name > '') or
       (FOwner.DisplayMode in [dmFieldNames, dmFieldNumbers, dmUserDefined])) then begin
      Fld := FTable.FieldByName(FFields[0]);
      if (FOwner.DisplayMode = dmFieldLabel) and Assigned(Fld) then
        FDisplayName := Fld.DisplayLabel
      else if (FOwner.DisplayMode = dmFieldNames) then
        FDisplayName := FFieldNames
      else if (FOwner.DisplayMode = dmIndexName) then
        FDisplayName := FIndexName
      else if (FOwner.DisplayMode = dmFieldNumbers) and Assigned(Fld) then begin
        FDisplayName := '';
        for I := 0 to Pred(FFields.Count) do begin
          Fld := FTable.FieldByName(FFields[I]);
          if Assigned(Fld) then begin
            if FDisplayName > '' then
              FDisplayName := FDisplayName + ';';
            FDisplayName := FDisplayName + IntToStr(Fld.FieldNo);
          end;
        end;
      end else if (FOwner.DisplayMode = dmUserDefined) and
                   Assigned(FOwner.FOnGetDisplayLabel) then begin
        FDisplayName := FIndexName; {set up default display name}
        FOwner.FOnGetDisplayLabel(FOwner, FFieldNames, FIndexName, FIndexOptions, FDisplayName);
      {if nothing else is possible, try these}
      end else if Assigned(Fld) then
        FDisplayName := Fld.DisplayLabel
      else
        FDisplayName := FIndexName;

      if not (FOwner.DisplayMode = dmUserDefined) then
        if (ixDescending in ID.Options) then
          FDisplayName := FDisplayName  + GetOrphStr(SCDescending);
    end else
      FDisplayName := GetOrphStr(SCDefaultIndex);
  end;
end;

procedure TOvcIndexInfo.SetDisplayName(const Value : string);
begin
  if (Value <> FDisplayName) then begin
    FDisplayName := Value;
    FOwner.SetRefreshPendingFlag;
    FOwner.Invalidate;
  end;
end;


{*** TOvcIndexSelectDataLink ***}

procedure TOvcIndexSelectDataLink.ActiveChanged;
begin
  inherited ActiveChanged;

  if not (csLoading in FIndexSelect.ComponentState) then
    FIndexSelect.RefreshNow;
end;

constructor TOvcIndexSelectDataLink.Create(AIndexSelect : TOvcDbIndexSelect);
begin
  inherited Create;

  FIndexSelect := AIndexSelect;
end;

procedure TOvcIndexSelectDataLink.DataSetChanged;
begin
  inherited DataSetChanged;

  FIndexSelect.isFindIndex;
end;

procedure TOvcIndexSelectDataLink.LayoutChanged;
begin
  inherited LayOutChanged;

  if Active then
    FIndexSelect.SetRefreshPendingFlag;
end;


{*** TOvcDbIndexSelect ***}

procedure TOvcDbIndexSelect.Change;
var
  Table      : TTable;
  IndexInfo  : TOvcIndexInfo;
begin
  if (DataSource = nil) or (DataSource.DataSet = nil) or
     not (DataSource.DataSet.Active) then
    Exit;

  {we have already verified that DataSet is a TTable}
  Table := TTable(DataSource.DataSet);

  if ItemIndex > -1 then begin
    IndexInfo := TOvcIndexInfo(Items.Objects[ItemIndex]);
    if IndexInfo.Fields.Count > 1 then
      Table.IndexFieldNames := IndexInfo.FieldNames
    else
      Table.IndexName := IndexInfo.IndexName;
  end;

  inherited Change;
end;

procedure TOvcDbIndexSelect.ClearObjects;
var
  I : Integer;
begin
  if not HandleAllocated then
    Exit;

  {free all associated TOvcIndexInfo objects}
  for I := 0 to Pred(Items.Count) do
    if (Items.Objects[I] <> nil) then begin
      Items.Objects[I].Free;
      Items.Objects[I] := nil;
    end;
end;

constructor TOvcDbIndexSelect.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  Style := csDropDownList;

  FDataLink    := TOvcIndexSelectDataLink.Create(Self);
  FDisplayMode := DefDisplayMode;
  FMonitorIdx  := DefMonitorIdx;
  FShowHidden  := DefShowHidden;
end;

procedure TOvcDbIndexSelect.CreateWnd;
{$IFDEF TRIALRUN}
var
  X : Integer;
{$ENDIF}
begin
  inherited CreateWnd;

  SetRefreshPendingFlag;

{$IFDEF TRIALRUN}
  X := _CC_;
  if (X < ccRangeLow) or (X > ccRangeHigh) then Halt;
  X := _VC_;
  if (X < ccRangeLow) or (X > ccRangeHigh) then Halt;
{$ENDIF}
end;

destructor TOvcDbIndexSelect.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;

  inherited Destroy;
end;

procedure TOvcDbIndexSelect.DestroyWnd;
begin
  {free field info objects here instead of in an overriden Clear
  method, because ancestor's Clear method isn't virtual}
  ClearObjects;

  inherited DestroyWnd;
end;

procedure TOvcDbIndexSelect.DropDown;
begin
  if isRefreshPending then
    RefreshList;

  inherited DropDown;
end;

function TOvcDbIndexSelect.GetDataSource : TDataSource;
begin
  if Assigned(FDataLink) then
    Result := FDataLink.DataSource
  else
    Result := nil;
end;

{!!.13}
function TOvcDbIndexSelect.GetVersion : string;
begin
  Result := OvcVersionStr;
end;

procedure TOvcDbIndexSelect.isFindIndex;
var
  I         : Integer;
  Idx       : Integer;
  Table     : TTable;
  IndexInfo : TOvcIndexInfo;
begin
  if not FMonitorIdx then
    Exit;

  {exit if a refresh operation is pending--it will update the display}
  if isRefreshPending then
    Exit;

  if (DataSource = nil) or (DataSource.DataSet = nil) then
    Exit;

  {we have already verified that DataSet is a TTable}
  Table := TTable(DataSource.DataSet);

  {find the current index}
  Idx := -1;
  for I := 0 to Pred(Items.Count) do begin
    IndexInfo := TOvcIndexInfo(Items.Objects[I]);
    if Assigned(IndexInfo) then begin
      if (Table.IndexFieldNames = '') then begin
        if AnsiCompareText(IndexInfo.IndexName, Table.IndexName) = 0 then
          Idx := I;
      end else begin
        if AnsiCompareText(IndexInfo.FieldNames, Table.IndexFieldNames) = 0 then
          Idx := I;
      end;
    end;
  end;

  ItemIndex := Idx;
end;

procedure TOvcDbIndexSelect.RefreshList;
var
  I           : Integer;
  Idx         : Integer;
  Fld         : TField;
  Table       : TTable;
  IndexInfo   : TOvcIndexInfo;
  ActiveIndex : string;
begin
  if not isRefreshPending then
    Exit;

  if not HandleAllocated then
    Exit;

  {clear refresh flag}
  isRefreshPending := False;

  {free field info objects}
  ClearObjects;

  {remove items from list}
  Items.Clear;

  if (DataSource = nil) or (DataSource.DataSet = nil) or
     not (DataSource.DataSet.Active) then
    Exit;

  {we have already verified that DataSet is a TTable}
  Table := TTable(DataSource.DataSet);

  if Table.MasterSource <> nil then
    raise EOvcException.CreateFmt(GetOrphStr(SCChildTableError), [Self.Name]);

  {update the index information}
  Table.IndexDefs.Update;

  ActiveIndex := '';
  for I := 0 to Pred(Table.IndexDefs.Count) do begin
    IndexInfo := TOvcIndexInfo.Create(Self, Table,                     {!!.13}
      Table.IndexDefs.Items[I].Name,                                   {!!.13}
      Table.IndexDefs.Items[I].Fields);                                {!!.13}
    if (Items.IndexOf(IndexInfo.DisplayName) < 0) and                  {!!.13}
       (Length(IndexInfo.DisplayName) > 0) then begin                  {!!.13}
      Items.AddObject(IndexInfo.DisplayName, IndexInfo);
      if (Table.IndexFieldNames = '') then begin
        if AnsiCompareText(Table.IndexDefs.Items[I].Name, Table.IndexName) = 0 then
          ActiveIndex := IndexInfo.DisplayName;
      end else begin
        if AnsiCompareText(Table.IndexFieldNames, Table.IndexDefs.Items[I].Fields) = 0 then
          ActiveIndex := IndexInfo.DisplayName;
      end;
    end else
      IndexInfo.Free;
  end;

  {conditionally remove non-visible Fields}
  if not ShowHidden and not (DataSource.DataSet.DefaultFields) then begin
    for I := Pred(Items.Count) downto 0 do begin
      IndexInfo := TOvcIndexInfo(Items.Objects[I]);
      Fld := Table.FieldByName(IndexInfo.FFields[0]);
      if Assigned(Fld) then begin
        if not Fld.Visible then begin
          Items.Objects[I].Free;
          Items.Delete(I);
        end;
      end;
    end;
  end;

  Idx := -1;
  for I := 0 to Pred(Items.Count) do
    if AnsiCompareText(Items[I], ActiveIndex) = 0 then
      Idx := I;
  ItemIndex := Idx;
end;

procedure TOvcDbIndexSelect.RefreshNow;
begin
  SetRefreshPendingFlag;
  RefreshList;
end;

procedure TOvcDbIndexSelect.SetDataSource(Value : TDataSource);
begin
  if Assigned(Value) and (Value.DataSet <> nil) and not (Value.DataSet is TTable) then
    raise EOvcException.Create(GetOrphStr(SCNoTableAttached));

  FDataLink.DataSource := Value;
  {$IFDEF Win32}
  if (Value <> nil) then
    Value.FreeNotification(Self);
  {$ENDIF}

  if not (csLoading in ComponentState) then
    RefreshNow;
end;

procedure TOvcDbIndexSelect.SetDisplayMode(Value : TDisplayMode);
begin
  if (Value <> FDisplayMode) then begin
    FDisplayMode := Value;
    if not (csLoading in ComponentState) then
      RefreshNow;
  end;
end;

procedure TOvcDbIndexSelect.SetMonitorIdx(Value : Boolean);
begin
  if (Value <> FMonitorIdx) then begin
    FMonitorIdx := Value;
    if not (csLoading in ComponentState) then
      if FMonitorIdx then
        isFindIndex;
  end;
end;

procedure TOvcDbIndexSelect.SetRefreshPendingFlag;
begin
  isRefreshPending := True;
end;

procedure TOvcDbIndexSelect.SetShowHidden(Value : Boolean);
begin
  if (Value <> FShowHidden) then begin
    FShowHidden := Value;
    if not (csLoading in ComponentState) then
      RefreshNow;
  end;
end;

{!!.13}
procedure TOvcDbIndexSelect.SetVersion(Value : string);
begin
end;

procedure TOvcDbIndexSelect.WMPaint(var Msg : TWMPaint);
begin
  if isRefreshPending then
    RefreshList;

  inherited;
end;


end.