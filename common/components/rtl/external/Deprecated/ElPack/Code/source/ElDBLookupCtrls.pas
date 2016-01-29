{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}

{$include elpack2.inc}
{$ifdef ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$else}
{$ifdef LINUX}
{$I ../ElPack.inc}
{$else}
{$I ..\ElPack.inc}
{$endif}
{$endif}

(*

Version History

03/19/2003

 fixed comparision of variants

08/11/2002

  TDBLookupListBox - now works via virtual list. Works only for Style in [lbVirtual, lbVirtualOwnerDraw]
  Delphi 6/7 only.
{todo: In IDE Cut(Copy)/Paste doesn't work. It's OK with Wide LookupListBox .}
*)

{$ifdef MSWINDOWS}
  {$ifdef VCL_6_USED}
     {$define _VIRTUAL_LIST_SUPPORTED_} // not support in CLX and less then Delphi 6
  {$endif VCL_6_USED}
{$endif MSWINDOWS}

unit ElDBLookupCtrls;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  {$ifdef VCL_6_USED}
  Variants,
  {$endif}
  StdCtrls,
  {$ifdef ELPACK_4_LOOKUPS}
  ElDBWidelookupControls,
  {$else}
  ElACtrls,
  {$endif}
  db,
  dbctrls;

type
  {$ifdef ELPACK_4_LOOKUPS}
  TElDBLookupListBox = class(TElWideDBLookupListbox);
  TElDBLookupComboBox = class(TElWideDBLookupCombobox);
  {$else}
  TElDBLookupListBox = class;
  TElDBLookupComboBox = class;
  TElDBLookupListControl = class;

  TElNotInListEvent = procedure(Sender: TObject; Text: string;
    var Accept: boolean) of object;

  TElDBLookupListControl = class( TDBLookupControl )
  private
    { Private declarations }
    FElDBLookupListBox: TElDBLookupListBox;
    FSelected: integer;
    FUpdate: Boolean;
    FSavedOnUpdateDataEvent: TNotifyEvent;
    //vAd:
    fOLDListState :TDataSetState;
  protected
    { Protected declarations }
    procedure KeyValueChanged; override;
    procedure UpdateListFields; override;
    //vAd:
    procedure UpdateBuffer;

    procedure SelectCurrent;
    procedure Select( Value: Integer );
    procedure UpdateData(Sender: TObject);
    procedure ListLinkDataChanged; override;
  public
    { Public declarations }
    function ExecuteAction( Action: TBasicAction ): Boolean; override;
    function UpdateAction( Action: TBasicAction ): Boolean; override;
  published
    { Published declarations }
  end;

  TElDBLookUpComboControl = class( TDBLookupControl )
  private
    { Private declarations }
    FElDBLookupComboBox: TElDBLookupComboBox;
    FSelected: integer;
    FSavedOnUpdateDataEvent: TNotifyEvent;
    FUpdate: Boolean;
  protected
    { Protected declarations }
    procedure KeyValueChanged; override;
    procedure UpdateListFields; override;
    procedure SelectCurrent;
    procedure Select( Value: Integer );
    property Selected: integer read FSelected;
    procedure UpdateData(Sender: TObject);
  public
    { Public declarations }
    function ExecuteAction( Action: TBasicAction ): Boolean; override;
    function UpdateAction( Action: TBasicAction ): Boolean; override;

  published
    { Published declarations }
  end;

  TElDBLookupListBox = class( TElAdvancedListBox )
  private
    { Private declarations }
    FElDBLookupControl: TElDBLookupListControl;
    FOnChange : TNotifyEvent;
    FReadOnly: Boolean;
    FFieldCount: integer;

    //vAd: FFields: array of TStrings;
    FFieldWidth: array of integer;

    procedure SetDataSource( Value: TDataSource );
    procedure SetListSource( Value: TDataSource );
    procedure SetDataFieldName( const Value: string );
    procedure SetListFieldName( const Value: string );
    procedure SetKeyFieldName( const Value: string );
    procedure SetKeyValue( const Value: Variant );
    procedure SetListFieldIndex( Value: integer );
    function GetField: TField;
    function GetListFieldIndex: integer;
    function GetDataSource: TDataSource;
    function GetListSource: TDataSource;
    function GetListFieldName: string;
    function GetDataFieldName: string;
    function GetKeyFieldName: string;
    function GetKeyValue: Variant;
    function GetSelectedString: string;
    procedure WMLButtonDown( var Message: TWMLButtonDown ); message WM_LBUTTONDOWN;
    procedure WMLButtonDblClk( var Message: TWMLButtonDblClk ); message WM_LBUTTONDBLCLK;
    procedure WMChar( var Message: TWMChar ); message WM_CHAR;
    //vAd: function GetFields( Index: integer ): TStrings;
    procedure WMSize( var Message: TWMSize ); message WM_SIZE;
    procedure WMKeyDown( var Message: TWMKeyDown ); message WM_KEYDOWN;
    function GetSelected(Index: Integer): Boolean;
    function GetHorizontalScroll:Boolean;
    procedure SetHorizontalScroll(Value:Boolean);

  protected
    { Protected declarations }
    procedure DrawItem( Index: Integer; Rect: TRect; State:
                     {$ifndef VCL_5_USED}StdCtrls{$else}Windows{$endif}.TOwnerDrawState ); override;
    procedure MouseDown( Button: TMouseButton; Shift: TShiftState; X, Y: Integer ); override;

    procedure SetFieldCount( Value: integer );
    procedure ClearFields;

    //vAd:
    function GetStyle:TListBoxStyle;
    procedure SetStyle(Value:TListBoxStyle);
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    //vAd: procedure AddItem( const Value: string; Field: integer );
    //vAd: property Fields[Index: Integer]: TStrings read GetFields{ write SetField};
    procedure DefineProperties(Filer: TFiler); override;
  public
    { Public declarations }
    constructor Create( AOwner: TComponent ); override;
    destructor Destroy; override;
    function ExecuteAction( Action: TBasicAction ): Boolean; override;
    function UpdateAction( Action: TBasicAction ): Boolean; override;
    property KeyValue: Variant read GetKeyValue write SetKeyValue;
    property SelectedItem: string read GetSelectedString;
    property ListFieldIndex: integer read GetListFieldIndex write SetListFieldIndex;
    property Field: TField read GetField;
    //vAd:
    property Selected[Index: Integer]: Boolean read GetSelected;
  published
    { Published declarations }
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ListSource: TDataSource read GetListSource write SetListSource;
    property DataField: string read GetDataFieldName write SetDataFieldName;
    property ListField: string read GetListFieldName write SetListFieldName;
    property KeyField: string read GetKeyFieldName write SetKeyFieldName;
    property OnChange : TNotifyEvent read FOnChange write FOnChange;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default false;
    //vAd:
    property Style:TListBoxStyle read GetStyle write SetStyle stored false;// emulate as read Only for reading from old dfm resource
    property HorizontalScroll: Boolean read GetHorizontalScroll write SetHorizontalScroll;
    property Items stored False;
    property ItemIndex stored False;
  end;

  TElDBLookupComboBox = class( TCustomElAdvancedComboBox )
  private
    { Private declarations }
    FElDBLookupControl: TElDBLookupComboControl;
    FSelected: array of Boolean;
    FMaxItems: integer;
    FFieldCount: integer;
    FFields: array of TStrings;
    FFieldWidth: array of integer;
    FReadOnly: boolean;
    FCompleteting: boolean;
    FOnNotInList: TElNotInListEvent;
    fNeedUpdate:Boolean;
    procedure SetDataSource( Value: TDataSource );
    procedure SetListSource( Value: TDataSource );
    procedure SetDataFieldName( const Value: string );
    procedure SetListFieldName( const Value: string );
    procedure SetKeyFieldName( const Value: string );
    procedure SetKeyValue( const Value: Variant );
    procedure SetListFieldIndex( Value: integer );
    procedure SetSelected( index: integer; Value: Boolean );
    function GetSelected( index: integer ): boolean;
    function GetField: TField;
    function GetListFieldIndex: integer;
    function GetDataSource: TDataSource;
    function GetListSource: TDataSource;
    function GetListFieldName: string;
    function GetDataFieldName: string;
    function GetKeyFieldName: string;
    function GetKeyValue: Variant;
    function GetSelectedString: string;
    function GetFields( Index: integer ): TStrings;
    procedure DoComplete(Accept: Boolean);
    procedure SetHScrollBarWidth;
    procedure WMMouseWheel( var Message: TWMMouseWheel ); message WM_MOUSEWHEEL;
    procedure CMFontChanged( var Msg: TMessage ); message CM_FONTCHANGED;
    procedure WMKeyDown( var Message: TWMKeyDown ); message WM_KEYDOWN;
    function GetStyle:TComboBoxStyle;

  protected
    { Protected declarations }
    procedure EditWndProc( var Message : TMessage ); override;
    procedure ListWndProc( var Message : TMessage ); override;
    procedure DrawItem( Index: Integer; Rect: TRect; State:
                     {$ifndef VCL_5_USED}StdCtrls{$else}Windows{$endif}.TOwnerDrawState ); override;
    procedure SetFieldCount( Value: integer );
    procedure ClearFields;
    procedure AddFieldItem( const Value: string; Field: integer );
    property Fields[Index: Integer]: TStrings read GetFields{ write SetField};
    procedure MouseDown( Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer ); override;
    procedure Change; override;
    procedure DoExit; override;
    procedure DefineProperties(Filer: TFiler); override;

    procedure DropDown; override;
    procedure SetStyle(Value:TComboBoxStyle); override;

  public
    { Public declarations }
    constructor Create( AOwner: TComponent ); override;
    destructor Destroy; override;
    procedure UpdateData;
    function ExecuteAction( Action: TBasicAction ): Boolean; override;
    function UpdateAction( Action: TBasicAction ): Boolean; override;
    property KeyValue: Variant read GetKeyValue write SetKeyValue;
    property SelectedItem: string read GetSelectedString;
    property ListFieldIndex: integer read GetListFieldIndex write SetListFieldIndex;
    property Field: TField read GetField;
    property Selected[Index: Integer]: Boolean read GetSelected write SetSelected;
  published
    { Published declarations }
    property AutoCompletion;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ListSource: TDataSource read GetListSource write SetListSource;
    property DataField: string read GetDataFieldName write SetDataFieldName;
    property ListField: string read GetListFieldName write SetListFieldName;
    property KeyField: string read GetKeyFieldName write SetKeyFieldName;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default false;
    property OnNotInList: TElNotInListEvent read FOnNotInList write FOnNotInList;

    property ActiveBorderType;
    property Align;
    property Style:TComboBoxStyle read GetStyle write SetStyle default csOwnerDrawFixed;
    {$ifdef VCL_4_USED}
    property Anchors;
    {$endif}
    {$ifdef VCL_4_USED}
    property BiDiMode;
    {$endif}
//    property BtnFlat;
//    property BtnThinFrame;
//    property BtnTransparent;
    property Color;
    {$ifdef VCL_4_USED}
    property Constraints;
    {$endif}
    property Ctl3D;
    property DragCursor;
    {$ifdef VCL_4_USED}
    property DragKind;
    {$endif}
    property DragMode;
    property DropDownCount;
    property DropDownWidth;
    property Enabled;
    property Font;
    property Flat;
    property HandleDialogKeys;
    property Hint;
    property HorizontalScroll;
    property ImeMode;
    property ImeName;
    property InactiveBorderType;
    property ItemIndex stored false;
    property ItemHeight;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;
    property MaxLength;
    {$ifdef VCL_4_USED}
    property ParentBiDiMode;
    {$endif}
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text stored false;
    property UseXPThemes;
    property Visible;

    property OnChange;
    property OnClick;
    {$ifdef VCL_5_USED}
    property OnContextPopup;
    {$endif}
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnDropDown;
    {$ifdef VCL_4_USED}
    property OnEndDock;
    {$endif}
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    {$ifdef VCL_4_USED}
    property OnStartDock;
    {$endif}
    property OnStartDrag;

    {$ifdef VCL_7_USED}
    property AutoCloseUp default False;
    {$endif}

    {$ifdef VCL_6_USED}
    property AutoDropDown default False;

    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;

    property OnCloseUp;
    property OnSelect;
    {$endif}
    property Items stored false;
  end;
  {$endif}

implementation

{$B-}

{$ifndef ELPACK_4_LOOKUPS}

uses ElVCLUtils;

{ TElDBLookupListControl }

procedure TElDBLookupListControl.KeyValueChanged;
  var
    vItemIndex: Integer;
begin
  vItemIndex := FElDBLookupListBox.ItemIndex;

  inherited KeyValueChanged;

  if ListLink.Active then
  begin
    try
      if VarToStr(KeyValue) <> VarToStr(ListLink.DataSet.FieldValues[KeyField]) then
        ListLink.DataSet.Locate( KeyField, KeyValue, [loCaseInsensitive] );
    except
      ListLink.DataSet.Locate( KeyField, KeyValue, [loCaseInsensitive] );
    end;

    if VarToStr(ListLink.DataSet.FieldValues[KeyField])=VarToStr(KeyValue) then
    begin
      if  Field = nil then
      begin
        FElDBLookupListBox.ItemIndex := ListLink.ActiveRecord;
        FSelected := ListLink.ActiveRecord;
        if Assigned( FElDBLookupListBox.OnChange ) then
          FElDBLookupListBox.OnChange( FElDBLookupListBox );
      end
      else
        SelectCurrent;
    end
    else
    begin
      FElDBLookupListBox.ItemIndex := -1;
      FSelected := -1;
      if Assigned( FElDBLookupListBox.OnChange ) then
        FElDBLookupListBox.OnChange( FElDBLookupListBox );
      if vItemIndex <> FElDBLookupListBox.ItemIndex then
        FElDBLookupListBox.Invalidate;
    end;
  end;
end;

procedure TElDBLookupListControl.UpdateData(Sender: TObject);
begin
  if FUpdate then exit;
  if Assigned(FSavedOnUpdateDataEvent) then FSavedOnUpdateDataEvent(Sender);
  FUpdate := true;
  UpdateListFields;
end;

procedure TElDBLookupListControl.UpdateBuffer;
  var
    i, RecCount, FieldCount: integer;
begin
  if (
       not(
       Assigned(ListSource.DataSet) and
       Assigned(ListSource.DataSet.FindField(KeyField))
       )
     ) or (ListFields.Count=0)
  then
    begin
      {$ifdef _VIRTUAL_LIST_SUPPORTED_}
      if FElDBLookupListBox.Style in [lbVirtual, lbVirtualOwnerDraw] then
        begin
            if FElDBLookupListBox.Count >0 then
              FElDBLookupListBox.Count := 0; //!!!
        end
      else
      {$endif}
        begin
          if FElDBLookupListBox.Items.Count>0 then
            FElDBLookupListBox.Items.Clear;
        end;
      FElDBLookupListBox.ItemIndex := -1;
      ListLink.BufferCount := 0;
      exit;
    end;
  ListLink.BufferCount := ListSource.DataSet.RecordCount;
  RecCount := ListLink.RecordCount;
  FieldCount := ListFields.Count;
  FElDBLookupListBox.SetFieldCount( FieldCount );

  {$ifdef _VIRTUAL_LIST_SUPPORTED_}
  if FElDBLookupListBox.Style in [lbVirtual, lbVirtualOwnerDraw] then
    begin
        if FElDBLookupListBox.Count <> RecCount then
          FElDBLookupListBox.Count := RecCount; //!!!
    end
  else   {$endif}
    begin
      if FElDBLookupListBox.Items.Count<>RecCount then
        begin
           FElDBLookupListBox.Items.BeginUpdate;
           try
             if FElDBLookupListBox.Items.Count>RecCount then                begin
                 i := (FElDBLookupListBox.Items.Count-RecCount);                  if i=FElDBLookupListBox.Items.Count then                    FElDBLookupListBox.Items.Clear
                 else
                 if (i/100*(RecCount)) > 25 then                    begin
                       FElDBLookupListBox.Items.Clear;
                       for i:= 1 to RecCount do
                          FElDBLookupListBox.Items.Add('');
                   end
                 else
                   for i:= 1 to i{FElDBLookupListBox.Items.Count-RecCount} do
                     FElDBLookupListBox.Items.Delete(FElDBLookupListBox.Items.Count-1)
               end
             else                for i:= 1 to RecCount-FElDBLookupListBox.Items.Count do
                 FElDBLookupListBox.Items.Add('');
           finally
             FElDBLookupListBox.Items.EndUpdate;
           end;
        end;

    end;
  for i := 0 to FieldCount-1 do
    FElDBLookupListBox.FFieldWidth[i] := TField( ListFields.Items[i] ).DisplayWidth;
  if FElDBLookupListBox.ItemIndex <> ListLink.ActiveRecord then
    KeyValueChanged;
end;

procedure TElDBLookupListControl.UpdateListFields;
  var i, HorisontalExtent:integer;
begin
  try
    inherited UpdateListFields;
  except
     begin
       FElDBLookupListBox.Update;
       UpdateBuffer;
       FElDBLookupListBox.Updated;
       FUpdate := false;
       if csDesigning in FElDBLookupListBox.ComponentState then
         raise
       else
         exit;
     end;
  end;

  FElDBLookupListBox.Update;

  if ListLink.Active and ( (KeyField<>'') or
    ( (Field<>nil) and (Field.FieldKind=fkLookup) ))
  then
    begin
      fOLDListState := ListLink.DataSet.State;
      UpdateBuffer;
      if FElDBLookupListBox.HorizontalScroll then
        begin
          HorisontalExtent := 0;
          for i:=0 to Length(FElDBLookupListBox.FFieldWidth)-1 do //ListFields.Count-1 do
            inc(HorisontalExtent, FElDBLookupListBox.FFieldWidth[i] );
          HorisontalExtent := (HorisontalExtent{+1}) * FElDBLookupListBox.Canvas.TextWidth('W');
          if HorisontalExtent <> SendMessage(FElDBLookupListBox.Handle, LB_GETHORIZONTALEXTENT, 0, 0) then
            SendMessage(FElDBLookupListBox.Handle, LB_SETHORIZONTALEXTENT, HorisontalExtent, 0);
        end
      else
        begin
            if 0 <> SendMessage(FElDBLookupListBox.Handle, LB_GETHORIZONTALEXTENT, 0, 0) then
            SendMessage(FElDBLookupListBox.Handle, LB_SETHORIZONTALEXTENT, 0, 0);
        end;
    end
  else
    begin
      fOLDListState := dsInactive;
      if FElDBLookupListBox.Items.Count>0 then
        begin
          {$ifdef _VIRTUAL_LIST_SUPPORTED_}
          if FElDBLookupListBox.Style in [lbVirtual, lbVirtualOwnerDraw] then
             FElDBLookupListBox.Count := 0
          else
          {$endif}
            FElDBLookupListBox.Items.Clear;
          FElDBLookupListBox.ItemIndex := -1;
          ListLink.BufferCount := 0;
        end;
    end;

  FElDBLookupListBox.Updated;

  FUpdate := false;
end;

//vAd:
procedure TElDBLookupListControl.ListLinkDataChanged;
begin
  if (not FUpdate)
      and
     (
       (ListLink.DataSet.State <> dsBrowse) or
       (ListLink.BufferCount <> ListLink.DataSet.RecordCount) or
       ( (fOLDListState = dsInsert) and (ListLink.DataSet.State = dsBrowse) )
     )
  then
    begin
        if (ListLink.DataSet.State = dsInsert) then//Insert not post
          begin
             {$ifdef _VIRTUAL_LIST_SUPPORTED_}
             FElDBLookupListBox.Count := FElDBLookupListBox.Count +1;
             {$else}
             FElDBLookupListBox.Items.BeginUpdate;
             FElDBLookupListBox.Items.Add('');
             {$endif}
             ListLink.BufferCount := ListLink.BufferCount+1;
             {$ifndef _VIRTUAL_LIST_SUPPORTED_}
             FElDBLookupListBox.Items.EndUpdate;
             {$endif}
          end
        else
        if (fOLDListState = dsInsert) and // Cancel
           (ListLink.BufferCount <> ListLink.DataSet.RecordCount)
        then
          begin
             {$ifdef _VIRTUAL_LIST_SUPPORTED_}
             FElDBLookupListBox.Count := FElDBLookupListBox.Count -1;
             {$else}
             FElDBLookupListBox.Items.BeginUpdate;
             FElDBLookupListBox.Items.Delete(FElDBLookupListBox.Items.Count-1);
             {$endif}
             ListLink.BufferCount := ListLink.BufferCount-1;
             {$ifndef _VIRTUAL_LIST_SUPPORTED_}
             FElDBLookupListBox.Items.EndUpdate;
             {$endif}
          end
        else
          begin
            if (ListLink.BufferCount <> ListLink.DataSet.RecordCount) then
              begin
                UpdateBuffer;
                if not FUpdate then
                  FElDBLookupListBox.Invalidate;
              end;
          end;
    end;
  fOLDListState := ListLink.DataSet.State;
end;

procedure TElDBLookupListControl.SelectCurrent;
var
  CurRec: integer;
begin
  if ListLink.Active and (Field<>nil) then
  begin
    //vAd: i := 0;
    CurRec := ListLink.ActiveRecord;
    if FElDBLookupListBox.ItemIndex <> CurRec then
    begin
      FElDBLookupListBox.ItemIndex := CurRec;
      FSelected := CurRec;
      FElDBLookupListBox.Invalidate;
      if Assigned( FElDBLookupListBox.OnChange ) then
        FElDBLookupListBox.OnChange( FElDBLookupListBox );
    end;
  end;
end;

procedure TElDBLookupListControl.Select( Value: Integer );
begin
  if (Value>=0) and
     ListLink.Active and
     (ListLink.ActiveRecord <> Value)
  then
    begin
      ListLink.ActiveRecord := Value;
      FSelected := Value;
      if Assigned(ListSource.DataSet.FindField(KeyField)) then
        SelectKeyValue( ListSource.DataSet.FieldValues[KeyField] )
      else
      begin
        FElDBLookupListBox.ItemIndex := Value;
        FElDBLookupListBox.Invalidate;
      end;
    end;
end;

function TElDBLookupListControl.ExecuteAction( Action: TBasicAction ): Boolean;
begin
  Result := inherited ExecuteAction( Action ) or (DataSource<>nil)
    and ( DataSource.ExecuteAction( Action ) );
end;

function TElDBLookupListControl.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction( Action ) or (DataSource<>nil)
    and ( DataSource.UpdateAction( Action ) );
end;

{ TElDBLookupComboControl }

procedure TElDBLookupComboControl.KeyValueChanged;
  var
    vItemIndex: Integer;
begin
  vItemIndex := FElDBLookupComboBox.ItemIndex;
  inherited KeyValueChanged;

  if ListLink.Active then
  begin
    try
      if (VarToStr(KeyValue) <> VarToStr(ListLink.DataSet.FieldValues[KeyField]))
         or          (VarToStr(KeyValue) <> VarToStr(FElDBLookupComboBox.Fields[0][ListLink.ActiveRecord]))
        then
          begin
            ListLink.DataSet.Locate( KeyField, KeyValue, [loCaseInsensitive] );
            if (VarToStr(KeyValue) <> VarToStr(FElDBLookupComboBox.Fields[0][ListLink.ActiveRecord]))
               and
               (not FUpdate)
            then               begin
                FUpdate := true;
                UpdateListFields;
                ListLink.DataSet.Locate( KeyField, KeyValue, [loCaseInsensitive] );
              end;
          end;
    except
      ListLink.DataSet.Locate( KeyField, KeyValue, [loCaseInsensitive] );
    end;

    if (VarToStr(KeyValue) = VarToStr(ListLink.DataSet.FieldValues[KeyField])) then
    begin
      if Field = nil then
      begin
        FElDBLookupComboBox.ItemIndex := ListLink.ActiveRecord;
        FSelected := ListLink.ActiveRecord;
        if Assigned( FElDBLookupComboBox.OnChange ) then
          FElDBLookupComboBox.OnChange( FElDBLookupComboBox );
      end
      else
        SelectCurrent;
    end
    else
    begin
      FElDBLookupComboBox.ItemIndex := -1;
      FSelected := -1;
      if Assigned( FElDBLookupComboBox.OnChange ) then
        FElDBLookupComboBox.OnChange( FElDBLookupComboBox );
      if vItemIndex <> FElDBLookupComboBox.ItemIndex then
        FElDBLookupComboBox.Invalidate;
    end;
  end;
end;

procedure TElDBLookupComboControl.UpdateData(Sender: TObject);
 var j :integer;
begin
  if FUpdate then
    exit;
  if Assigned(FSavedOnUpdateDataEvent) then FSavedOnUpdateDataEvent(Sender);
//  FUpdate := true;
//  UpdateListFields;

  if (ListLink.DataSet.FieldValues[KeyField]=KeyValue) then
    begin
      if FElDBLookupComboBox.ItemIndex = -1 then
        begin
          FUpdate := true;
          UpdateListFields
        end
      else
      if (ListFields.Count>0) then
        begin
          if (FElDBLookupComboBox.Fields[0][ListLink.ActiveRecord] <> KeyValue) then
          begin
            FUpdate := true;
            UpdateListFields
          end else
          begin
            for j := 0 to ListFields.Count-1 do
              if (j <> 0)
                 and
                 ( FElDBLookupComboBox.Fields[j][ListLink.ActiveRecord] <>
                   ( TField( ListFields.Items[j] ).DisplayText) )
              then
                FElDBLookupComboBox.Fields[j][ListLink.ActiveRecord] :=
                  ( TField( ListFields.Items[j] ).DisplayText);
            FElDBLookupComboBox.Invalidate;
          end;
        end
      {}
    end
    else
      FElDBLookupComboBox.fNeedUpdate := True;
end;

procedure TElDBLookupComboControl.UpdateListFields;
var
  i, j, RecCount, ActiveRec, FieldCount: integer;
begin
  FElDBLookupComboBox.fNeedUpdate := False;

  inherited UpdateListFields;
  FElDBLookupComboBox.ClearFields;

  if ListLink.Active and ( (KeyField<>'') or
    ( (Field<>nil) and (Field.FieldKind=fkLookup) )) then
  begin
    ListLink.BufferCount := ListSource.DataSet.RecordCount;
    ListLink.DataSet.DisableControls;
    i := 0;
    ActiveRec := ListLink.ActiveRecord;
    RecCount := ListLink.RecordCount;
    FieldCount := ListFields.Count;
    FElDBLookupComboBox.SetFieldCount( FieldCount );
    repeat
      ListLink.ActiveRecord := i;
      for j := 0 to FieldCount-1 do
        FElDBLookupComboBox.AddFieldItem( TField( ListFields.Items[j] ).DisplayText, j );
      inc(i);
    until i >= RecCount;

    for j := 0 to FieldCount-1 do
      FElDBLookupComboBox.FFieldWidth[j] := TField( ListFields.Items[j] ).DisplayWidth;

    FElDBLookupComboBox.SetHScrollBarWidth;

    ListLink.ActiveRecord := ActiveRec;

//    if FUpdate then FElDBLookupComboBox.ItemIndex := ActiveRec;

    if (FElDBLookupComboBox.ItemIndex <> ListLink.ActiveRecord)
       or
       (VarToStr(ListLink.DataSet.FieldValues[KeyField])<>VarToStr(KeyValue))
    then
      KeyValueChanged;

    ListLink.DataSet.EnableControls;
{
    if FElDBLookupComboBox.ItemIndex <> ActiveRec then
    begin
      FElDBLookupComboBox.ItemIndex := ActiveRec;
      if Assigned( FElDBLookupComboBox.OnChange ) then
        FElDBLookupComboBox.OnChange( FElDBLookupComboBox );
    end;
}
  end;
  FUpdate := false;
end;

procedure TElDBLookupComboControl.SelectCurrent;
var
  i, RecCount, CurRec: integer;
  FKeyField: TField;
begin
  if ListLink.Active and (Field<>nil) then
  begin
    i := 0;
    CurRec := ListLink.ActiveRecord;
    RecCount := ListLink.RecordCount;
    FKeyField := GetFieldProperty( ListLink.DataSet, Self, KeyField );
    ListLink.DataSet.DisableControls;
//    FElDBLookupComboBox.Updating;
    repeat
      ListLink.ActiveRecord := i;
      try
        FElDBLookupComboBox.Selected[i] := FKeyField.Value = Field.Value;
      except
        FElDBLookupComboBox.Selected[i] := false;
      end;
      inc(i);
    until i >= RecCount;
    ListLink.ActiveRecord := CurRec;
//    FElDBLookupComboBox.Updated;
    ListSource.DataSet.EnableControls;
    if FElDBLookupComboBox.ItemIndex <> CurRec then
    begin
      FElDBLookupComboBox.ItemIndex := CurRec;
      FSelected := CurRec;
      if Assigned( FElDBLookupComboBox.OnChange ) then
        FElDBLookupComboBox.OnChange( FElDBLookupComboBox );
    end;

    if (ListLink.DataSet.FieldValues[KeyField]<>KeyValue) then
      FElDBLookupComboBox.ItemIndex := -1;

  end;
end;

procedure TElDBLookupComboControl.Select( Value: Integer );
var
  DataSet: TDataSet;
begin
  if (Value>=0) and
     ListLink.Active
  then
  begin
    DataSet := ListSource.DataSet;
    if (Value>=0)and (DataSet.Recordcount>0) then
    begin
      DataSet.Locate(TField( ListFields.Items[0] ).DisplayName,
        FElDBLookupComboBox.Items[Value], []);
      FSelected := Value;
      SelectKeyValue( DataSet.FieldValues[KeyField] );
    end;
  end;
end;

function TElDBLookupComboControl.ExecuteAction( Action: TBasicAction ): Boolean;
begin
  Result := inherited ExecuteAction( Action ) or (DataSource <> nil)
    and ( DataSource.ExecuteAction( Action ) );
end;

function TElDBLookupComboControl.UpdateAction( Action: TBasicAction ): Boolean;
begin
  Result := inherited UpdateAction( Action ) or (DataSource <> nil)
    and ( DataSource.UpdateAction( Action ) );
end;

{ TElDBLookupListBox }

constructor TElDBLookupListBox.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  MultiSelect := true;
  FElDBLookupControl := TElDBLookupListControl.Create( Self );
  FElDBLookupControl.FElDBLookupListBox := Self;
  FFieldCount := 0;
  FReadOnly := false;
  {$ifdef _VIRTUAL_LIST_SUPPORTED_}
    inherited Style := lbVirtualOwnerDraw;
  {$endif}
end;

destructor TElDBLookupListBox.Destroy;
//vAd: var
//vAd:   i: integer;
begin
  FElDBLookupControl.FElDBLookupListBox := nil;
  FElDBLookupControl.free;
  FElDBLookupControl := nil;

  SetLength( FFieldWidth, 0 );
  //vAd: for i := 1 to FFieldCount do FFields[i-1].Free;
  //vAd: SetLength( FFields, 0 );

  inherited Destroy;
end;

procedure TElDBLookupListBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  // read unknown properties "TElWideDBListBox":
  with GetElReader do
  begin
    FakeDefineProperty(Filer);
  end;
end;

function TElDBLookupListBox.GetStyle:TListBoxStyle;
begin
    Result := inherited Style;
end;

procedure TElDBLookupListBox.SetStyle(Value:TListBoxStyle);
begin
end;

procedure TElDBLookupListBox.SetDataSource( Value: TDataSource );
begin
  FElDBLookupControl.DataSource := Value;
end;

procedure TElDBLookupListBox.SetListSource( Value: TDataSource );
begin
  if FElDBLookupControl.ListSource <> Value then
  begin
    if FElDBLookupControl.ListSource <> nil then
    begin
      FElDBLookupControl.ListSource.OnUpdateData := FElDBLookupControl.FSavedOnUpdateDataEvent;
      FElDBLookupControl.FSavedOnUpdateDataEvent := nil;
    end;

    FElDBLookupControl.ListSource := Value;
    if Value <> nil then
    begin
      if Assigned(FElDBLookupControl.ListSource.OnUpdateData) then
        FElDBLookupControl.FSavedOnUpdateDataEvent := FElDBLookupControl.ListSource.OnUpdateData
      else
        FElDBLookupControl.FSavedOnUpdateDataEvent := nil;
      FElDBLookupControl.ListSource.OnUpdateData := FElDBLookupControl.UpdateData;
    end;
  end;
end;

procedure TElDBLookupListBox.SetDataFieldName( const Value: string );
begin
  FElDBLookupControl.DataField := Value;
end;

procedure TElDBLookupListBox.SetListFieldName( const Value: string );
begin
  FElDBLookupControl.ListField := Value;
end;

procedure TElDBLookupListBox.SetKeyFieldName( const Value: string );
begin
  FElDBLookupControl.KeyField := Value;
end;

function TElDBLookupListBox.GetDataSource: TDataSource;
begin
  Result := FElDBLookupControl.DataSource;
end;

function TElDBLookupListBox.GetListSource: TDataSource;
begin
  Result := FElDBLookupControl.ListSource;
end;

function TElDBLookupListBox.GetListFieldName: string;
begin
  Result := FElDBLookupControl.ListField;
end;

function TElDBLookupListBox.GetDataFieldName: string;
begin
  Result := FElDBLookupControl.DataField;
end;

function TElDBLookupListBox.GetKeyFieldName: string;
begin
  Result := FElDBLookupControl.KeyField;
end;

procedure TElDBLookupListBox.MouseDown( Button: TMouseButton; Shift: TShiftState;
    X, Y: Integer );
begin
  if Button = mbLeft then
    FElDBLookupControl.Select( ItemAtPos( Point( X, Y ), true ) )
  else//???
    inherited MouseDown( Button, Shift, X, Y );
end;

procedure TElDBLookupListBox.WMLButtonDown( var Message: TWMLButtonDown );
 var idx: integer;
begin
  //vAd:
  if not Focused then
    Windows.SetFocus(Handle);

  if FReadOnly then exit;
  idx := ItemIndex;

  MouseDown( mbLeft, [], Message.XPos, Message.YPos );

  if ( idx<>ItemIndex ) and Assigned( FOnChange ) then
    FOnChange( Self );
end;

procedure TElDBLookupListBox.WMLButtonDblClk( var Message: TWMLButtonDblClk );
begin
end;

procedure TElDBLookupListBox.SetKeyValue( const Value: Variant );
begin
  FElDBLookupControl.KeyValue := Value;
end;

function TElDBLookupListBox.GetKeyValue: Variant;
begin
  Result := FElDBLookupControl.KeyValue;
end;

//vAd:
function TElDBLookupListBox.GetSelectedString: string;
 var i, ActiveRec: integer;
     FKeyField :TField;
begin
  Result := '';
  if Items.Count=0 then
    exit;
  FKeyField := FElDBLookupControl.ListLink.DataSet.FindField(FElDBLookupControl.KeyField);
  if FKeyField= nil then
    exit;
  ActiveRec := FElDBLookupControl.ListLink.ActiveRecord;
  for i := 0 to Items.Count-1 do
    if Selected[i] then
      //vAd: Result := Result + Items.Strings[i] + ';';
      begin
          FElDBLookupControl.ListLink.ActiveRecord := i;
          Result := Result + FKeyField.AsString + ';';
      end;

  FElDBLookupControl.ListLink.ActiveRecord := ActiveRec;
  if Result <> '' then
      SetLength( Result, length( Result )-1 );
end;

function TElDBLookupListBox.GetHorizontalScroll:Boolean;
begin
    Result := inherited HorizontalScroll;
end;

procedure TElDBLookupListBox.SetHorizontalScroll(Value:Boolean);
  var i, HorisontalExtent: integer;
begin
  if Value <> HorizontalScroll then
    begin
      inherited HorizontalScroll := Value;
      if HorizontalScroll then
        begin
          HorisontalExtent := 0;
          for i:=0 to FElDBLookupControl.ListFields.Count-1 do
            inc(HorisontalExtent, FFieldWidth[i] );
          HorisontalExtent := (HorisontalExtent) * Canvas.TextWidth('W');
          SendMessage(Handle, LB_SETHORIZONTALEXTENT, HorisontalExtent, 0);
          Width := Width+1;
          Width := Width -1;
        end
      else
        begin
            if 0 <> SendMessage(Handle, LB_GETHORIZONTALEXTENT, 0, 0) then
            SendMessage(Handle, LB_SETHORIZONTALEXTENT, 0, 0);
        end;
    end;
end;

procedure TElDBLookupListBox.SetListFieldIndex( Value: integer );
begin
  FElDBLookupControl.ListFieldIndex := Value;
end;

function TElDBLookupListBox.GetListFieldIndex: integer;
begin
  Result := FElDBLookupControl.ListFieldIndex;
end;

function TElDBLookupListBox.GetField: TField;
begin
  Result := FElDBLookupControl.Field;
end;

function TElDBLookupListBox.ExecuteAction( Action: TBasicAction ): boolean;
begin
  Result := inherited ExecuteAction( Action ) and FElDBLookupControl.ExecuteAction( Action );
end;

function TElDBLookupListBox.UpdateAction( Action: TBasicAction ): boolean;
begin
  Result := inherited UpdateAction( Action ) and FElDBLookupControl.UpdateAction( Action );
end;

procedure TElDBLookupListBox.WMChar( var Message: TWMChar );
begin
end;

procedure TElDBLookupListBox.WMKeyDown(var Message: TWMKeyDown);
begin
  if not FElDBLookupControl.FUpdate then
    case Message.CharCode of
      VK_DOWN:
        begin
            if ItemIndex<Items.Count-1 then
              begin
                FElDBLookupControl.Select( ItemIndex+1 );
                if Assigned( FOnChange ) then
                  FOnChange( self );
              end;
        end;
      VK_UP:
        begin
            if ItemIndex>0 then
              begin
                FElDBLookupControl.Select( ItemIndex-1 );
                if Assigned( FOnChange ) then
                  FOnChange( self );
              end;
        end;
      VK_HOME:
        begin
            if ItemIndex>0 then
              begin
                FElDBLookupControl.Select( 0 );
              end;
        end;
      VK_END:
        begin
            if ( ItemIndex < Items.Count-1 ) then
              begin
                FElDBLookupControl.Select( Items.Count-1 );
              end;
        end;
      VK_PRIOR,VK_NEXT:
        begin
            if ( (Message.CharCode = VK_PRIOR) and ( ItemIndex >0 ) )
               or
               ( (Message.CharCode = VK_NEXT) and ( ItemIndex < Items.Count-1 ) )
            then
              begin
                Items.BeginUpdate;
                  inherited;
                  FElDBLookupControl.Select( ItemIndex );
                Items.EndUpdate;
              end;
        end;
      VK_ESCAPE:
        begin
            if Assigned(DataSource) and
               Assigned(DataSource.DataSet) and
               DataSource.DataSet.Active and
               ( DataSource.DataSet.State in [dsEdit, dsInsert] )
            then
              begin
                DataSource.DataSet.Cancel;
                //???
                if Assigned( FOnChange ) then
                  FOnChange( self );
              end;
        end;
      else
        inherited;
    end
  else
    inherited;
end;

procedure TElDBLookupListBox.WMPaint(var Message: TWMPaint);
 var ActiveRec:integer;
begin
    if (not HandleAllocated) then
      exit;

    if Assigned(FElDBLookupControl.ListLink.DataSet) and
       FElDBLookupControl.ListLink.DataSet.Active and
       Assigned(DataSource) and
       Assigned(DataSource.DataSet) and
       DataSource.DataSet.Active
    then
    begin
        //FElDBLookupControl.FUpdate := True;
        ActiveRec := FElDBLookupControl.ListLink.ActiveRecord;
        inherited;
        FElDBLookupControl.ListLink.ActiveRecord := ActiveRec;
        //FElDBLookupControl.FUpdate := False;
    end
    else
      inherited;
end;

function VarEquals(const V1, V2: Variant): Boolean;
begin
  Result := False;
  try
    Result := V1 = V2;
  except
  end;
end;

procedure TElDBLookupListBox.DrawItem( Index: Integer; Rect: TRect;
  State: {$ifndef VCL_5_USED}StdCtrls{$else}Windows{$endif}.TOwnerDrawState
);
var
  i, TextWidth, TextHeight: integer;
  R: TRect;
  S: String;
begin
//  if csUpdating in ComponentState then exit;
//  if FElDBLookupControl.FUpdate then
//    exit;

  Canvas.Font := Font;

  TextWidth := Canvas.TextWidth( '0' );
  TextHeight := Canvas.TextHeight( '0' );
  R := Rect;
//vAd:   {$ifdef _VIRTUAL_LIST_SUPPORTED_}
//vAd:   if Style in [lbVirtual, lbVirtualOwnerDraw] then
    begin         FElDBLookupControl.ListLink.ActiveRecord := Index;

        if  FReadOnly then Canvas.Font.Color := clGrayText;

        if ColorToRGB( Color ) <> ColorToRGB( clBtnFace ) then
          Canvas.Pen.Color := clBtnFace
        else
          Canvas.Pen.Color := clBtnShadow;

        // Check Selected
        if Assigned(DataSource) and Assigned(DataSource.DataSet) and
           Assigned(DataSource.DataSet.FindField(DataField)) and
           (not VarIsNull(KeyValue)) and
           Assigned(ListSource.DataSet) and
           Assigned(ListSource.DataSet.FindField(FElDBLookupControl.KeyField)) and
           VarEquals(
            FElDBLookupControl.ListLink.DataSet.FindField(FElDBLookupControl.KeyField).Value,
            KeyValue
           )
        then
        begin// is selected
           Canvas.Font.Color  := SelectedFont.Color;
           Canvas.Brush.Color := SelectedColor;
        end
        else
        begin
           Canvas.Font.Color  := Font.Color;
           Canvas.Brush.Color := Color;//???: Transparent
        end;

        for i := 1 to FFieldCount do
        begin

            if Index>FElDBLookupControl.ListLink.ActiveRecord then
              exit;

            S := TField(FElDBLookupControl.ListFields.Items[i-1]).DisplayText;

            Canvas.FillRect( R );
            Canvas.TextOut( R.Left + 4, R.Top, S );

            R.Left := R.Left + FFieldWidth[i-1]*TextWidth;
            if i < FFieldCount then
            begin
              Canvas.MoveTo( R.Left-1, R.Top );
              Canvas.LineTo( R.Left-1, R.Top + TextHeight+3 );
            end;

        end;
    end
end;


procedure TElDBLookupListBox.SetFieldCount( Value: integer );
begin
  if Value > FFieldCount then
  begin
    //vAd: SetLength( FFields, Value );
    SetLength( FFieldWidth, Value );
    inc( FFieldCount );
    FFieldCount := Value;
  end
  else
    if Value < FFieldCount then
    begin
      SetLength( FFieldWidth, Value );
      FFieldCount := Value;
    end;
end;

procedure TElDBLookupListBox.ClearFields;
begin
  Items.Clear;
end;


procedure TElDBLookupListBox.WMSize(var Message: TWMSize);
  var i, HorisontalExtent: integer;
begin
  if HorizontalScroll then
    begin
      HorisontalExtent := 0;
      for i:=0 to Length(FFieldWidth)-1 do // FElDBLookupControl.ListFields.Count-1 do
        inc(HorisontalExtent, FFieldWidth[i] );
      HorisontalExtent := (HorisontalExtent) * Canvas.TextWidth('W');
      if HorisontalExtent <> SendMessage(Handle, LB_GETHORIZONTALEXTENT, 0, 0) then
        SendMessage(Handle, LB_SETHORIZONTALEXTENT, HorisontalExtent, 0);
    end
  else
    begin
        if 0 <> SendMessage(Handle, LB_GETHORIZONTALEXTENT, 0, 0) then
        SendMessage(Handle, LB_SETHORIZONTALEXTENT, 0, 0);
    end;
  inherited;
end;

//vAd:
function TElDBLookupListBox.GetSelected(Index: Integer): Boolean;
 var ActiveRec:Integer;
     FKeyField:TField;
begin
    Items[Index];//check range overflow
    Result := False;
    FKeyField := GetFieldProperty( FElDBLookupControl.ListLink.DataSet, Self, KeyField );
    if FKeyField=nil
      then exit;
    ActiveRec := FElDBLookupControl.ListLink.ActiveRecord;
    FElDBLookupControl.ListLink.DataSet.DisableControls;
    try
      FElDBLookupControl.ListLink.ActiveRecord := Index;
      Result := FKeyField.Value = Field.Value;
      FElDBLookupControl.ListLink.ActiveRecord := ActiveRec;
    finally
      FElDBLookupControl.ListLink.DataSet.EnableControls;
    end;
end;

{ TElDBLookupComboBox }

constructor TElDBLookupComboBox.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );
  inherited Style := csOwnerDrawFixed;
  FElDBLookupControl := TElDBLookupComboControl.Create( Self );
  FElDBLookupControl.FElDBLookupComboBox := Self;
  FMaxItems := 0;
  FFieldCount := 0;
  FReadOnly := false;
  FCompleteting := false;
end;

destructor TElDBLookupComboBox.Destroy;
var
  i: integer;
begin
  FElDBLookupControl.FElDBLookupComboBox := nil;
  FElDBLookupControl.free;
  FElDBLookupControl := nil;
  SetLength( FSelected, 0 );
  SetLength( FFieldWidth, 0 );
  for i := 1 to FFieldCount do FFields[i-1].Free;
  SetLength( FFields, 0 );
  inherited Destroy;
end;

procedure TElDBLookupComboBox.UpdateData;
begin
  FElDBLookupControl.FUpdate := true;
  FElDBLookupControl.UpdateListFields;
end;

procedure TElDBLookupComboBox.Change;
begin
  inherited;
  if (not FCompleteting) and (FElDBLookupControl.Selected <> ItemIndex) then
  begin
    FElDBLookupControl.Select( ItemIndex );
    if Assigned( OnChange ) then OnChange( Self );
  end;
end;

procedure TElDBLookupComboBox.DoExit;
begin
  inherited;
  if FCompleteting then DoComplete( true );
end;

function TElDBLookupComboBox.GetStyle:TComboBoxStyle;
begin
    Result := inherited Style;
end;

procedure TElDBLookupComboBox.SetStyle(Value:TComboBoxStyle);
begin
    if Value=csSimple then
      begin
         if (csDesigning in ComponentState) and
            (not (csReading in ComponentState) )
         then
           raise exception.Create('TElDBLookupComboBox do not supported "csSimple" mode');
      end
    else
      inherited SetStyle(Value);
end;

procedure TElDBLookupComboBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  // read unknown properties "TElWideDBListBox":
  with GetElReader do
  begin
    FakeDefineProperty(Filer);
  end;
end;

procedure TElDBLookupComboBox.DropDown;
begin
  if (not HandleAllocated) or (csDestroying in ComponentState) then
    inherited
  else
  begin
    if fNeedUpdate
       or
       (
        Assigned(FElDBLookupControl.ListSource) and Assigned(FElDBLookupControl.ListSource.DataSet) and
        (FElDBLookupControl.ListSource.DataSet.Active) and
        (FElDBLookupControl.ListSource.DataSet.RecordCount <> Items.Count)
       )
    then FElDBLookupControl.UpdateListFields;
    inherited;
  end;
end;

procedure TElDBLookupComboBox.SetDataSource( Value: TDataSource );
begin
  FElDBLookupControl.DataSource := Value;
end;

procedure TElDBLookupComboBox.SetListSource( Value: TDataSource );
begin
  if FElDBLookupControl.ListSource <> Value then
  begin
    if FElDBLookupControl.ListSource <> nil then
    begin
      FElDBLookupControl.ListSource.OnUpdateData := FElDBLookupControl.FSavedOnUpdateDataEvent;
      FElDBLookupControl.FSavedOnUpdateDataEvent := nil;
//      FElDBLookupControl.ListSource.OnDataChange := nil;
    end;
    FElDBLookupControl.ListSource := Value;
    if Value <> nil then
    begin
      if Assigned(FElDBLookupControl.ListSource.OnUpdateData) then
        FElDBLookupControl.FSavedOnUpdateDataEvent := FElDBLookupControl.ListSource.OnUpdateData
      else
        FElDBLookupControl.FSavedOnUpdateDataEvent := nil;
      FElDBLookupControl.ListSource.OnUpdateData := FElDBLookupControl.UpdateData;
//      FElDBLookupControl.ListSource.OnDataChange := FElDBLookupControl.DataChange;
    end;
  end;
end;

procedure TElDBLookupComboBox.SetDataFieldName( const Value: string );
begin
  FElDBLookupControl.DataField := Value;
end;

procedure TElDBLookupComboBox.SetListFieldName( const Value: string );
begin
  FElDBLookupControl.ListField := Value;
end;

procedure TElDBLookupComboBox.SetKeyFieldName( const Value: string );
begin
  FElDBLookupControl.KeyField := Value;
end;

function TElDBLookupComboBox.GetDataSource: TDataSource;
begin
  Result := FElDBLookupControl.DataSource;
end;

function TElDBLookupComboBox.GetListSource: TDataSource;
begin
  Result := FElDBLookupControl.ListSource;
end;

function TElDBLookupComboBox.GetListFieldName: string;
begin
  Result := FElDBLookupControl.ListField;
end;

function TElDBLookupComboBox.GetDataFieldName: string;
begin
  Result := FElDBLookupControl.DataField;
end;

function TElDBLookupComboBox.GetKeyFieldName: string;
begin
  Result := FElDBLookupControl.KeyField;
end;

procedure TElDBLookupComboBox.SetKeyValue( const Value: Variant );
begin
  FElDBLookupControl.KeyValue := Value;
end;

function TElDBLookupComboBox.GetKeyValue: Variant;
begin
  Result := FElDBLookupControl.KeyValue;
end;

function TElDBLookupComboBox.GetSelectedString: string;
var
  i: integer;
begin
  Result := '';
  for i := 0 to Items.Count-1 do
    if FSelected[i] then Result := Result + Items.Strings[i] + ';';
  if Result <> '' then SetLength( Result, length( Result )-1 );
end;

procedure TElDBLookupComboBox.SetListFieldIndex( Value: integer );
begin
  FElDBLookupControl.ListFieldIndex := Value;
end;

function TElDBLookupComboBox.GetListFieldIndex: integer;
begin
  Result := FElDBLookupControl.ListFieldIndex;
end;

function TElDBLookupComboBox.GetField: TField;
begin
  Result := FElDBLookupControl.Field;
end;

function TElDBLookupComboBox.ExecuteAction( Action: TBasicAction ): boolean;
begin
  Result := inherited ExecuteAction( Action ) and FElDBLookupControl.ExecuteAction( Action );
end;

function TElDBLookupComboBox.UpdateAction( Action: TBasicAction ): boolean;
begin
  Result := inherited UpdateAction( Action ) and FElDBLookupControl.UpdateAction( Action );
end;

procedure TElDBLookupComboBox.DoComplete(Accept: Boolean);
var
  i: integer;
  ac: boolean;
begin
  FCompleteting := false;
  if FReadOnly then exit;
  if Accept then
  begin
    i := Items.IndexOf(Text);
    if i<0 then
    begin
      if Assigned(FOnNotInList) then FOnNotInList(Self, Text, ac);
      if not ac then
      begin
        ItemIndex := FElDBLookupControl.Selected;
        Change;
      end
      else
        FCompleteting := true;
    end
    else
    begin
      ItemIndex := i;
      Change;
    end;
  end
  else
    ItemIndex := FElDBLookupControl.Selected;
end;

function TElDBLookupComboBox.GetSelected(index: integer): boolean;
begin
  if (index >= Items.Count) or (index >= FMaxItems) then
    raise ERangeError.CreateFmt( 'Index out of range!', [] )
  else
    Result := FSelected[index];
end;

procedure TElDBLookupComboBox.SetSelected( index: integer; Value: Boolean );
begin
  if ( index >= Items.Count ) or ( index >= FMaxItems ) then
    raise ERangeError.CreateFmt( 'Index out of range!', [] )
  else
    FSelected[index] := Value;
end;

procedure TElDBLookupComboBox.EditWndProc( var Message : TMessage );
begin
  FCompleteting := FCompleteting or (Message.Msg = WM_CHAR);

  inherited EditWndProc( Message );

  if Message.Msg = WM_CHAR then
  case TWMChar(Message).CharCode of
    VK_RETURN: DoComplete( true );
    VK_ESCAPE: DoComplete( false );
  end;
end;

procedure TElDBLookupComboBox.WMKeyDown( var Message: TWMKeyDown );
begin
  if DroppedDown and ((Style=csOwnerDrawVariable) or (Style=csOwnerDrawFixed)) then
  begin
    FCompleteting := false;
    Selected[ItemIndex] := false;
  end;
  inherited;
end;

procedure TElDBLookupComboBox.DrawItem( Index: Integer; Rect: TRect;
   State: {$ifndef VCL_5_USED}StdCtrls{$else}Windows{$endif}.TOwnerDrawState
);
var
  i: integer;
  R: TRect;
  S: String;
  TextWidth, TextHeight: integer;
begin
  Canvas.Font := Font;
  if FSelected[Index] or (odSelected in State) then
  begin
    Canvas.Font.Color := clHighlightText;
    Canvas.Brush.Color := clHighlight;
  end;

  if FFieldCount = 1 then inherited;

  if FReadOnly then
    Canvas.Font.Color := clGrayText;

  if ColorToRGB( Color ) <> ColorToRGB( clBtnFace ) then
    Canvas.Pen.Color := clBtnFace
  else
    Canvas.Pen.Color := clBtnShadow;

  TextWidth := Canvas.TextWidth( '0' );
  TextHeight := Canvas.TextHeight( '0' );
  R := Rect;
  for i := 1 to FFieldCount do
  begin
    if FFields[i-1].Count > Index then
      S := FFields[i-1].Strings[index]
    else
      S := '';
    Canvas.FillRect( R );
    Canvas.TextOut( R.Left+4, R.Top, S );
    R.Left := R.Left + FFieldWidth[i-1]*TextWidth;
    if i < FFieldCount then
    begin
      Canvas.MoveTo( R.Left-1, R.Top );
      Canvas.LineTo( R.Left-1, R.Top + TextHeight+3 );
    end;
  end;
end;

procedure TElDBLookupComboBox.ListWndProc( var Message : TMessage );
var
  Index: integer;
begin
  if Message.Msg = WM_SIZE then SetHScrollBarWidth;
  if (Message.Msg = WM_LBUTTONDOWN) and FReadOnly then
  begin
    Index := ItemIndex;
    inherited ListWndProc( Message );
    ItemIndex := Index
  end
  else
  begin
    if Message.Msg <> WM_MOUSEMOVE then inherited ListWndProc( Message );
    if Message.Msg = WM_LBUTTONDOWN then
    begin
      if FCompleteting then
        DoComplete( true )
      else
        FElDBLookupControl.Select( ItemIndex );
    end;
  end;
end;

procedure TElDBLookupComboBox.AddFieldItem( const Value: string; Field: integer );
var
  i, count: integer;
begin
  Fields[Field].Add( Value );
  if Field = 0 then
  begin
    Items.Add( Value );
    if FMaxItems <= Items.Count then
    begin
      count := FMaxItems;
      FMaxItems := Items.Count+1;
      SetLength( FSelected, FMaxItems );
      for i := count to FMaxItems do FSelected[i-1] := false;
    end;
  end;
end;

function TElDBLookupComboBox.GetFields( Index: integer ): TStrings;
begin
  Result := FFields[Index];
end;

procedure TElDBLookupComboBox.SetFieldCount( Value: integer );
var
  i: integer;
begin
  if Value > FFieldCount then
  begin
    SetLength( FFields, Value );
    SetLength( FFieldWidth, Value );
    inc( FFieldCount );
    for i := FFieldCount to Value do FFields[i-1] := TStringList.Create;
    FFieldCount := Value;
  end
  else
    if Value < FFieldCount then
    begin
      for i := Value+1 to FFieldCount do FFields[i-1].Free;
      SetLength( FFields, Value );
      SetLength( FFieldWidth, Value );
      FFieldCount := Value;
    end;
end;

procedure TElDBLookupComboBox.ClearFields;
var
  i: integer;
begin
  Items.Clear;
  for i := 1 to FFieldCount do FFields[i-1].Clear;
end;

procedure TElDBLookupComboBox.MouseDown( Button: TMouseButton; Shift: TShiftState;
X, Y: Integer );
begin
  if not ReadOnly then inherited MouseDown( Button, Shift, X, Y );
end;

procedure TElDBLookupComboBox.WMMouseWheel( var Message: TWMMouseWheel );
var
  idx: integer;
begin
  idx := ItemIndex;
  inherited;
  if idx <> ItemIndex then
  begin
    if FReadOnly then
    begin
      ItemIndex := idx;
      exit;
    end;
    FElDBLookupControl.Select( ItemIndex );
    if Assigned( OnChange ) then OnChange( Self );
  end;
end;

procedure TElDBLookupComboBox.SetHScrollBarWidth;
var
  ts: string;
   j: integer;
begin
  if HorizontalScroll then
    begin
      ts := '';
      for j := 0 to FFieldCount-1 do ts := ts + StringOfChar( '0', FFieldWidth[j] );
      Perform( CB_SETHORIZONTALEXTENT, Canvas.TextWidth( ts ), 0 );
    end
    else
      Perform( CB_SETHORIZONTALEXTENT, 0, 0 );
end;


procedure TElDBLookupComboBox.CMFontChanged(var Msg: TMessage);
var tm : TTextMetric;
begin
  inherited;
  Canvas.Font.Assign( Font );
  GetTextMetrics( Canvas.Handle, tm );
  Perform( CB_SETITEMHEIGHT, 0, tm.tmHeight );
end;

{$endif}

end.
