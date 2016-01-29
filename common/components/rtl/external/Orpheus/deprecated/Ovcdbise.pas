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
{*                  OVCDBISE.PAS 2.17                    *}
{*     Copyright 1995-98 (c) TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcDbIsE;
  {-data-aware incremental search edit control}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, Controls, Db, DbTables, ExtCtrls, Forms, Graphics,
  Menus, StdCtrls, SysUtils,
  OvcBase, OvcISEB, OvcExcpt, OvcVer;


type
  TOvcDbSearchEdit = class(TOvcBaseISE)
  {.Z+}
  protected {private}
    {property variables}
    FDataLink    : TDataLink;

    {property methods}
    function GetDataSource : TDataSource;
    function GetVersion : string;                                      {!!.13}
    procedure SetDataSource(Value : TDataSource);
    procedure SetVersion(Value : string);                              {!!.13}

  protected
  public
    constructor Create(AOwner: TComponent);
      override;
    destructor Destroy;
      override;
  {.Z-}

    {public methods}
    procedure PerformSearch;
      override;

  published
    property AutoSearch;
    property CaseSensitive;
    property Controller;

    property DataSource : TDataSource
      read GetDataSource
      write SetDataSource;

    property Version : string                                          {!!.13}
      read GetVersion                                                  {!!.13}
      write SetVersion                                                 {!!.13}
      stored False;                                                    {!!.13}

    property KeyDelay;
    property ShowResults;

    {inherited properties}
    property AutoSelect;
    property AutoSize;
    property BorderStyle;
    property CharCase;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property MaxLength;
    property OEMConvert;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;

    {inherited events}
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    {$IFDEF Win32}
    property OnStartDrag;
    {$ENDIF}
  end;


implementation

{$IFDEF TRIALRUN}
uses OrTrial;
{$I ORTRIALF.INC}
{$ENDIF}


{*** TOvcDbSearchEdit ***}

constructor TOvcDbSearchEdit.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  FDataLink := TDataLink.Create;
end;

destructor TOvcDbSearchEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;

  inherited Destroy;
end;

function TOvcDbSearchEdit.GetDataSource : TDataSource;
begin
  if Assigned(FDataLink) then
    Result := FDataLink.DataSource
  else
    Result := nil;
end;

{!!.13}
function TOvcDbSearchEdit.GetVersion : string;
begin
  Result := OvcVersionStr;
end;

procedure TOvcDbSearchEdit.PerformSearch;
var
  Table      : TTable;
  L          : Integer;
  BM         : TBookMark;
  FoundValue : string;
begin
  if (DataSource = nil) or (DataSource.DataSet = nil) then
    Exit;

 if not DataSource.DataSet.Active then
   Exit;

 if not (DataSource.DataSet is TTable) then
   Exit;

  Table := TTable(DataSource.DataSet);
  if Table.IndexFieldCount = 0 then
    Exit;

  with Table do begin

    {BM := GetBookMark;}  {save location of current record}            {!!.12}
    BM := nil;                                                         {!!.12}
    try
      if DataBase.isSqlBased then begin
        Screen.Cursor := crHourGlass;
        try
          DisableControls;
          try
            try
              SetRangeStart;
              BM := GetBookMark;  {save location of current record}    {!!.12}
              IndexFields[0].AsString := Text;
              SetRangeEnd;
              ApplyRange;
            except
              on EConvertError do begin
                SelStart := 0;
                SelLength := Length(Text);
              end else
                raise;
            end;
          finally
            EnableControls;
          end;
        finally
          Screen.Cursor := crDefault;
        end;
      end else begin
        BM := GetBookMark;  {save location of current record}          {!!.12}
        try
          FindNearest([Text]);
        except
          on EConvertError do begin
            SelStart := 0;
            SelLength := Length(Text);
          end else
            raise;
        end;
      end;

      FoundValue := IndexFields[0].AsString;

      {check to make sure match conforms to CaseSensitive setting}
      if Pos(ISUpperCase(Text), ISUpperCase(FoundValue)) <> 1 then
        GotoBookMark(BM)
      else if ShowResults then begin {found}
        {record previous value}
        PreviousText := ISUpperCase(Text);

        {assign new value and select added characters}
        L := Length(Text);
        Text := FoundValue;
        SelStart := L;
        SelLength := Length(Text)-L;
        Self.Modified := False;
      end;

    finally
      FreeBookMark(BM);
    end;

  end;
end;

procedure TOvcDbSearchEdit.SetDataSource(Value : TDataSource);
begin
  FDataLink.DataSource := Value;
  {$IFDEF Win32}
  if Value <> nil then
    Value.FreeNotification(Self);
  {$ENDIF}
end;

{!!.13}
procedure TOvcDbSearchEdit.SetVersion(Value : string);
begin
end;


end.