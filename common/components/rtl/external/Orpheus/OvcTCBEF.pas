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
{*                  OVCTCBEF.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcTCBEF;
  {-Orpheus Table Cell - base entry field type}

interface

uses
  {$IFDEF Win32}
  Windows,
  {$ELSE}
  WinTypes, WinProcs,
  {$ENDIF}
  SysUtils, Messages,
  Graphics, Classes, Controls, Forms, StdCtrls, Menus,
  OvcData, OvcConst, OvcBase, OvcCaret, OvcColor,
  OvcCmd, OvcEF,
  OvcTCmmn, OvcTCell, OvcTGRes, OvcTable, OvcTCStr;

type
  TOvcTCBaseEntryField = class(TOvcTCBaseString)
    protected {private}
      {.Z+}
      FEdit        : TOvcBaseEntryField;
      FEditDisplay : TOvcBaseEntryField;

      FOnError          : TValidationErrorEvent;
      FOnUserCommand    : TUserCommandEvent;
      FOnUserValidation : TUserValidationEvent;

      CopyOfData     : pointer;
      CopyOfDataSize : Integer;                                        {!!.17}
      {.Z-}

    protected
      {.Z+}
      function GetAutoAdvanceChar : boolean;
      function GetAutoAdvanceLeftRight : boolean;
      function GetAutoSelect : boolean;
      function GetBeepOnError : boolean;
      function GetCaretIns : TOvcCaret;
      function GetCaretOvr : TOvcCaret;
      function GetCaretToEnd : boolean;
      function GetControlCharColor : TColor;
      function GetDataSize : integer;
      function GetDecimalPlaces : byte;
      function GetErrorColors : TOvcColors;
      function GetForceInsert : boolean;
      function GetForceOvertype : boolean;
      function GetHighlightColors : TOvcColors;
      function GetInsertPushes : boolean;
      function GetMaxLength : word;
      function GetModified : boolean;
      function GetPadChar : AnsiChar;
      function GetPasswordChar : AnsiChar;
      function GetPasswordMode : boolean;
      function GetRangeHi : string;
      function GetRangeLo : string;
      function GetRightAlign : boolean;                         {!!.10}
      function GetRightJustify : boolean;
      function GetSoftValidation : boolean;
      function GetStripLiterals : boolean;
      function GetTextMargin : integer;
      function GetTrimBlanks : boolean;

      procedure SetAutoAdvanceChar(AAC : boolean);
      procedure SetAutoAdvanceLeftRight(AALR : boolean);
      procedure SetAutoSelect(ASel : boolean);
      procedure SetBeepOnError(BOE : boolean);
      procedure SetCaretIns(CI : TOvcCaret);
      procedure SetCaretOvr(CO : TOvcCaret);
      procedure SetCaretToEnd(CTE : boolean);
      procedure SetControlCharColor(CCC : TColor);
      procedure SetDecimalPlaces(DP : byte);
      procedure SetErrorColors(EC : TOvcColors);
      procedure SetForceInsert(FI : boolean);
      procedure SetForceOvertype(FO : boolean);
      procedure SetHighlightColors(HC : TOvcColors);
      procedure SetInsertPushes(IP : boolean);
      procedure SetMaxLength(ML : word);
      procedure SetPadChar(PC : AnsiChar);
      procedure SetPasswordChar(PC : AnsiChar);
      procedure SetPasswordMode(PM : boolean);
      procedure SetRangeHi(RI : string);
      procedure SetRangeLo(RL : string);
      procedure SetRightAlign(RA : boolean);                    {!!.10}
      procedure SetRightJustify(RJ : boolean);
      procedure SetSoftValidation(SV : boolean);
      procedure SetStripLiterals(SL : boolean);
      procedure SetTextMargin(TM : integer);
      procedure SetTrimBlanks(TB : boolean);

      procedure DefineProperties(Filer: TFiler); override;

      procedure tcPaint(TableCanvas : TCanvas;
                  const CellRect    : TRect;
                        RowNum      : TRowNum;
                        ColNum      : TColNum;
                  const CellAttr    : TOvcCellAttributes;
                        Data        : pointer); override;
      {.Z-}

      {properties for entry fields, to be exposed by descendants}
      property AutoAdvanceChar : boolean
         read GetAutoAdvanceChar write SetAutoAdvanceChar;

      property AutoAdvanceLeftRight : boolean
         read GetAutoAdvanceLeftRight write SetAutoAdvanceLeftRight;

      property AutoSelect : boolean
         read GetAutoSelect write SetAutoSelect;

      property BeepOnError : boolean
         read GetBeepOnError write SetBeepOnError;

      property CaretIns : TOvcCaret
         read GetCaretIns write SetCaretIns;

      property CaretOvr : TOvcCaret
         read GetCaretOvr write SetCaretOvr;

      property CaretToEnd : boolean
         read GetCaretToEnd write SetCaretToEnd;

      property ControlCharColor : TColor
         read GetControlCharColor write SetControlCharColor;

      property DecimalPlaces : byte
         read GetDecimalPlaces write SetDecimalPlaces;

      property ForceInsert : boolean
         read GetForceInsert write SetForceInsert;

      property ForceOvertype : boolean
         read GetForceOvertype write SetForceOvertype;

      property HighlightColors : TOvcColors
         read GetHighlightColors write SetHighlightColors;

      property InsertPushes : boolean
         read GetInsertPushes write SetInsertPushes;

      property MaxLength : word
         read GetMaxLength write SetMaxLength;

      property PadChar : AnsiChar
         read GetPadChar write SetPadChar;

      property PasswordChar : AnsiChar
         read GetPasswordChar write SetPasswordChar;

      property PasswordMode : boolean
         read GetPasswordMode write SetPasswordMode;

      property RangeHi : string
         read GetRangeHi write SetRangeHi
         stored false;

      property RangeLo : string
         read GetRangeLo write SetRangeLo
         stored false;

      property RightAlign : boolean                             {!!.10}
         read GetRightAlign write SetRightAlign;                {!!.10}

      property RightJustify : boolean
         read GetRightJustify write SetRightJustify;

      property StripLiterals : boolean
         read GetStripLiterals write SetStripLiterals;

      property TextMargin : integer
         read GetTextMargin write SetTextMargin;

      property TrimBlanks : boolean
         read GetTrimBlanks write SetTrimBlanks;

      {events}
      property OnError : TValidationErrorEvent
         read FOnError write FOnError;

      property OnUserCommand : TUserCommandEvent
         read FOnUserCommand write FOnUserCommand;

      property OnUserValidation : TUserValidationEvent
         read FOnUserValidation write FOnUserValidation;

    public
      constructor Create(AOwner : TComponent); override;
      destructor Destroy;                                              {!!.17}
        override;
      function CreateEntryField(AOwner : TComponent) : TOvcBaseEntryField; virtual; abstract;

      function  EditHandle : THandle; override;
      procedure EditHide; override;
      procedure EditMove(CellRect : TRect); override;

      function CanSaveEditedData(SaveValue : boolean) : boolean; override;
      procedure SaveEditedData(Data : pointer); override;
      procedure StartEditing(RowNum : TRowNum; ColNum : TColNum;
                             CellRect : TRect;
                       const CellAttr : TOvcCellAttributes;
                             CellStyle: TOvcTblEditorStyle;
                             Data : pointer); override;
      procedure StopEditing(SaveValue : boolean;
                            Data : pointer); override;

      property DataSize : integer
         read GetDataSize;

      property Modified : boolean
         read GetModified;

    published                                                          {!!.13}
      property Version;                                                {!!.13}
  end;

implementation

type {for typecast to get around protected clause}
  TOvcBEF = class(TOvcBaseEntryField)
    public
      property AutoAdvanceChar;
      property AutoAdvanceLeftRight;
      property AutoSelect;
      property BeepOnError;
      property CaretIns;
      property CaretOvr;
      property ControlCharColor;
      property DecimalPlaces;
      property ErrorColors;
      property ForceInsert;
      property ForceOvertype;
      property HighlightColors;
      property InsertPushes;
      property MaxLength;
      property PadChar;
      property PasswordChar;
      property PasswordMode;
      property RangeHi;
      property RangeLo;
      property ShowHint;
      property SoftValidation;
      property TextMargin;
      property TrimBlanks;
  end;

{===TOvcTCBaseEntryField=============================================}
constructor TOvcTCBaseEntryField.Create(AOwner : TComponent);
  begin
    inherited Create(AOwner);

    FEdit := CreateEntryField(Self);
    FEdit.Visible := false;

    FEditDisplay := CreateEntryField(Self);
    FEditDisplay.Visible := false;
  end;

{!!.17} {added}
destructor TOvcTCBaseEntryField.Destroy;
begin
  if (CopyOfData <> nil) and (CopyOfDataSize > 0) then
    FreeMem(CopyOfData, CopyOfDataSize);

  inherited Destroy;
end;

{--------}
function TOvcTCBaseEntryField.CanSaveEditedData(SaveValue : boolean) : boolean;
  begin
    Result := true;
    if Assigned(FEdit) then
      if SaveValue then
        with TOvcBEF(FEdit) do                                  {!!.01}
          if Controller.ErrorPending then                       {!!.01}
            Result := false                                     {!!.01}
          else                                                  {!!.01}
            Result := ValidateSelf
      else
        FEdit.Restore;
  end;
{--------}
function TOvcTCBaseEntryField.EditHandle : THandle;
  begin
    if Assigned(FEdit) then
      Result := FEdit.Handle
    else
      Result := 0;
  end;
{--------}
procedure TOvcTCBaseEntryField.EditHide;
  begin
    if Assigned(FEdit) then
      with FEdit do
        begin
          SetWindowPos(FEdit.Handle, HWND_TOP,
                       0, 0, 0, 0,
                       SWP_HIDEWINDOW or SWP_NOREDRAW or SWP_NOZORDER);
        end;

  end;
{--------}
procedure TOvcTCBaseEntryField.EditMove(CellRect : TRect);
  var
    EditHandle : HWND;
  begin
    if Assigned(FEdit) then
      begin
        EditHandle := FEdit.Handle;
        with CellRect do
         SetWindowPos(EditHandle, HWND_TOP,
                       Left, Top + ((Bottom - Top) - FEdit.Height) div 2 + 3, Right-Left,
                       FEdit.Height,
                       SWP_SHOWWINDOW or SWP_NOREDRAW or SWP_NOZORDER);
        InvalidateRect(EditHandle, nil, false);
        UpdateWindow(EditHandle);

      end;
  end;
{--------}
procedure TOvcTCBaseEntryField.tcPaint(TableCanvas : TCanvas;
                                 const CellRect    : TRect;
                                       RowNum      : TRowNum;
                                       ColNum      : TColNum;
                                 const CellAttr    : TOvcCellAttributes;
                                       Data        : pointer);
  var
    S : ShortString;
  begin
    if (Data = nil) then
      inherited tcPaint(TableCanvas, CellRect, RowNum, ColNum, CellAttr, Data)
    else
      begin
        FEditDisplay.Controller := TOvcTable(FTable).Controller;
        FEditDisplay.Parent := FTable;
        SetWindowPos(FEditDisplay.Handle, HWND_TOP, 0, 0, 0, 0,
                     SWP_HIDEWINDOW or SWP_NOREDRAW or SWP_NOZORDER);
        FEditDisplay.SetValue(Data^);
        S := FEditDisplay.DisplayString;
        inherited tcPaint(TableCanvas, CellRect, RowNum, ColNum, CellAttr, @S);
      end;
  end;
{--------}
procedure TOvcTCBaseEntryField.SaveEditedData(Data : pointer);
  begin
    if Assigned(Data) then
      begin
        FEdit.GetValue(CopyOfData^);
        Move(CopyOfData^, Data^, CopyOfDataSize);                      {!!.17}
      end;
  end;
{--------}
procedure TOvcTCBaseEntryField.StartEditing(RowNum : TRowNum; ColNum : TColNum;
                                           CellRect : TRect;
                                     const CellAttr : TOvcCellAttributes;
                                           CellStyle: TOvcTblEditorStyle;
                                           Data : pointer);
  begin
    CopyOfDataSize := FEdit.DataSize;                                  {!!.17}
    GetMem(CopyOfData, CopyOfDataSize);                                {!!.17}
    if (Data = nil) then
      FillChar(CopyOfData^, CopyOfDataSize, 0)                         {!!.17}
    else
      Move(Data^, CopyOfData^, CopyOfDataSize);                        {!!.17}

    with TOvcBEF(FEdit) do
      begin
        Parent := FTable;
        Font := CellAttr.caFont;
        Font.Color := CellAttr.caFontColor;
        Color := CellAttr.caColor;
        BorderStyle := bsNone;
        Ctl3D := false;
        case CellStyle of
          tesBorder : BorderStyle := bsSingle;
          tes3D     : Ctl3D := true;
        end;{case}
        FEdit.Left := CellRect.Left;        {V}
        If Height >= CellRect.Bottom - CellRect.Top
         then
          Begin
           FEdit.Top := CellRect.Top;
           FEdit.Height := CellRect.Bottom - CellRect.Top;
          end
         else FEdit.Top:=CellRect.Top + ((CellRect.Bottom - CellRect.Top) - FEdit.Height) div 2 + 3;

        FEdit.Width := CellRect.Right - CellRect.Left;
        {Top := CellRect.Top;
        Width := CellRect.Right - CellRect.Left;
        Height := CellRect.Bottom - CellRect.Top;}
        Hint := Self.Hint;
        ShowHint := Self.ShowHint;
        TabStop := false;
        Controller := TOvcTable(FTable).Controller;
        SetValue(CopyOfData^);
        Visible := true;

        OnChange := Self.OnChange;
        OnClick := Self.OnClick;
        OnDblClick := Self.OnDblClick;
        OnDragDrop := Self.OnDragDrop;
        OnDragOver := Self.OnDragOver;
        OnEndDrag := Self.OnEndDrag;
        OnEnter := Self.OnEnter;
        OnError := Self.OnError;
        OnExit := Self.OnExit;
        OnKeyDown := Self.OnKeyDown;
        OnKeyPress := Self.OnKeyPress;
        OnKeyUp := Self.OnKeyUp;
        OnMouseDown := Self.OnMouseDown;
        OnMouseMove := Self.OnMouseMove;
        OnMouseUp := Self.OnMouseUp;
        OnUserCommand := Self.OnUserCommand;
        OnUserValidation := Self.OnUserValidation;
      end;
  end;
{--------}
procedure TOvcTCBaseEntryField.StopEditing(SaveValue : boolean;
                                           Data : pointer);
  begin
    if SaveValue and Assigned(Data) then
      begin
        FEdit.GetValue(CopyOfData^);
        Move(CopyOfData^, Data^, CopyOfDataSize);                      {!!.17}
      end;
    FreeMem(CopyOfData, CopyOfDataSize);                               {!!.17}
    CopyOfData := nil;
    CopyOfDataSize := 0;                                               {!!.17}
    EditHide;
  end;
{====================================================================}


{===TOvcTCBaseEntryField property access=============================}
procedure TOvcTCBaseEntryField.DefineProperties(Filer: TFiler);
  begin
    inherited DefineProperties(Filer);
    with Filer do
      begin
        DefineBinaryProperty('RangeHigh',
           TOvcBEF(FEdit).efReadRangeHi, TOvcBEF(FEdit).efWriteRangeHi, true);
        DefineBinaryProperty('RangeLow',
           TOvcBEF(FEdit).efReadRangeLo, TOvcBEF(FEdit).efWriteRangeLo, true);
      end;
  end;
{--------}
function TOvcTCBaseEntryField.GetAutoAdvanceChar : boolean;
  begin
    if Assigned(FEdit) then
         Result := FEdit.AutoAdvanceChar
    else Result := false;
  end;
{--------}
function TOvcTCBaseEntryField.GetAutoAdvanceLeftRight : boolean;
  begin
    if Assigned(FEdit) then
         Result := TOvcBEF(FEdit).AutoAdvanceLeftRight
    else Result := false;
  end;
{--------}
function TOvcTCBaseEntryField.GetAutoSelect : boolean;
  begin
    if Assigned(FEdit) then
         Result := TOvcBEF(FEdit).AutoSelect
    else Result := false;
  end;
{--------}
function TOvcTCBaseEntryField.GetBeepOnError : boolean;
  begin
    if Assigned(FEdit) then
         Result := TOvcBEF(FEdit).BeepOnError
    else Result := false;
  end;
{--------}
function TOvcTCBaseEntryField.GetCaretIns : TOvcCaret;
  begin
    if Assigned(FEdit) then
         Result := TOvcBEF(FEdit).CaretIns
    else Result := nil;
  end;
{--------}
function TOvcTCBaseEntryField.GetCaretOvr : TOvcCaret;
  begin
    if Assigned(FEdit) then
         Result := TOvcBEF(FEdit).CaretOvr
    else Result := nil;
  end;
{--------}
function TOvcTCBaseEntryField.GetCaretToEnd : boolean;
  begin
    if Assigned(FEdit) then
         Result := TOvcBEF(FEdit).CaretToEnd
    else Result := true;
  end;
{--------}
function TOvcTCBaseEntryField.GetControlCharColor : TColor;
  begin
    if Assigned(FEdit) then
         Result := TOvcBEF(FEdit).ControlCharColor
    else Result := clRed;
  end;
{--------}
function TOvcTCBaseEntryField.GetDataSize : integer;
  begin
    if Assigned(FEdit) then
         Result := TOvcBEF(FEdit).DataSize
    else Result := 0;
  end ;
{--------}
function TOvcTCBaseEntryField.GetDecimalPlaces : byte;
  begin
    if Assigned(FEdit) then
         Result := TOvcBEF(FEdit).DecimalPlaces
    else Result := 0;
  end ;
{--------}
function TOvcTCBaseEntryField.GetErrorColors : TOvcColors;
  begin
    if Assigned(FEdit) then
         Result := TOvcBEF(FEdit).ErrorColors
    else Result := nil;
  end;
{--------}
function TOvcTCBaseEntryField.GetForceInsert : boolean;
  begin
    if Assigned(FEdit) then
         Result := TOvcBEF(FEdit).ForceInsert
    else Result := false;
  end;
{--------}
function TOvcTCBaseEntryField.GetForceOvertype : boolean;
  begin
    if Assigned(FEdit) then
         Result := TOvcBEF(FEdit).ForceOvertype
    else Result := false;
  end;
{--------}
function TOvcTCBaseEntryField.GetHighlightColors : TOvcColors;
  begin
    if Assigned(FEdit) then
         Result := TOvcBEF(FEdit).HighlightColors
    else Result := nil;
  end;
{--------}
function TOvcTCBaseEntryField.GetInsertPushes : boolean;
  begin
    if Assigned(FEdit) then
         Result := TOvcBEF(FEdit).InsertPushes
    else Result := false;
  end;
{--------}
function TOvcTCBaseEntryField.GetModified : boolean;
  begin
    if Assigned(FEdit) then
         Result := TOvcBEF(FEdit).Modified
    else Result := false;
  end ;
{--------}
function TOvcTCBaseEntryField.GetMaxLength : word;
  begin
    if Assigned(FEdit) then
        Result := TOvcBEF(FEdit).MaxLength
   else Result := 0;
  end;
{--------}
function TOvcTCBaseEntryField.GetPadChar : AnsiChar;
  begin
    if Assigned(FEdit) then
         Result := TOvcBEF(FEdit).PadChar
    else Result := ' ';
  end;
{--------}
function TOvcTCBaseEntryField.GetPasswordChar : AnsiChar;
  begin
    if Assigned(FEdit) then
         Result := TOvcBEF(FEdit).PasswordChar
    else Result := '*';
  end;
{--------}
function TOvcTCBaseEntryField.GetPasswordMode : boolean;
  begin
    if Assigned(FEdit) then
         Result := TOvcBEF(FEdit).PasswordMode
    else Result := false;
  end;
{--------}
function TOvcTCBaseEntryField.GetRangeHi : string;
  begin
    if Assigned(FEdit) then
         Result := TOvcBEF(FEdit).RangeHi
    else Result := '';
  end;
{--------}
function TOvcTCBaseEntryField.GetRangeLo : string;
  begin
    if Assigned(FEdit) then
         Result := TOvcBEF(FEdit).RangeLo
    else Result := '';
  end;
{--------}
function TOvcTCBaseEntryField.GetRightAlign : boolean;          {!!.10}
  begin                                                         {!!.10}
    if Assigned(FEdit) then                                     {!!.10}
         Result := TOvcBEF(FEdit).RightAlign                    {!!.10}
    else Result := false;                                       {!!.10}
  end;                                                          {!!.10}
{--------}
function TOvcTCBaseEntryField.GetRightJustify : boolean;
  begin
    if Assigned(FEdit) then
         Result := TOvcBEF(FEdit).RightJustify
    else Result := false;
  end;
{--------}
function TOvcTCBaseEntryField.GetSoftValidation : boolean;
  begin
    if Assigned(FEdit) then
         Result := TOvcBEF(FEdit).SoftValidation
    else Result := false;
  end;
{--------}
function TOvcTCBaseEntryField.GetStripLiterals : boolean;
  begin
    if Assigned(FEdit) then
         Result := TOvcBEF(FEdit).StripLiterals
    else Result := false;
  end;
{--------}
function TOvcTCBaseEntryField.GetTextMargin : integer;
  begin
    if Assigned(FEdit) then
         Result := TOvcBEF(FEdit).TextMargin
    else Result := 0;
  end;
{--------}
function TOvcTCBaseEntryField.GetTrimBlanks : boolean;
  begin
    if Assigned(FEdit) then
         Result := TOvcBEF(FEdit).TrimBlanks
    else Result := false;
  end;
{--------}
procedure TOvcTCBaseEntryField.SetAutoAdvanceChar(AAC : boolean);
  begin
    if Assigned(FEdit) then TOvcBEF(FEdit).AutoAdvanceChar := AAC;
  end;
{--------}
procedure TOvcTCBaseEntryField.SetAutoAdvanceLeftRight(AALR : boolean);
  begin
    if Assigned(FEdit) then TOvcBEF(FEdit).AutoAdvanceLeftRight := AALR;
  end;
{--------}
procedure TOvcTCBaseEntryField.SetAutoSelect(ASel : boolean);
  begin
    if Assigned(FEdit) then TOvcBEF(FEdit).AutoSelect := ASel;
  end;
{--------}
procedure TOvcTCBaseEntryField.SetBeepOnError(BOE : boolean);
  begin
    if Assigned(FEdit) then TOvcBEF(FEdit).BeepOnError := BOE;
  end;
{--------}
procedure TOvcTCBaseEntryField.SetCaretIns(CI : TOvcCaret);
  begin
    if Assigned(FEdit) then TOvcBEF(FEdit).CaretIns := CI;
  end;
{--------}
procedure TOvcTCBaseEntryField.SetCaretOvr(CO : TOvcCaret);
  begin
    if Assigned(FEdit) then TOvcBEF(FEdit).CaretOvr := CO;
  end;
{--------}
procedure TOvcTCBaseEntryField.SetCaretToEnd(CTE : boolean);
  begin
    if Assigned(FEdit) then TOvcBEF(FEdit).CaretToEnd := CTE;
  end;
{--------}
procedure TOvcTCBaseEntryField.SetControlCharColor(CCC : TColor);
  begin
    if Assigned(FEdit) then TOvcBEF(FEdit).ControlCharColor := CCC;
  end;
{--------}
procedure TOvcTCBaseEntryField.SetDecimalPlaces(DP : byte);
  begin
    if Assigned(FEdit) then
      begin
        TOvcBEF(FEdit).DecimalPlaces := DP;
        TOvcBEF(FEditDisplay).DecimalPlaces := DP;
      end;
  end;
{--------}
procedure TOvcTCBaseEntryField.SetErrorColors(EC : TOvcColors);
  begin
    if Assigned(FEdit) then TOvcBEF(FEdit).ErrorColors := EC;
  end;
{--------}
procedure TOvcTCBaseEntryField.SetForceInsert(FI : boolean);
  begin
    if Assigned(FEdit) then TOvcBEF(FEdit).ForceInsert := FI;
  end;
{--------}
procedure TOvcTCBaseEntryField.SetForceOvertype(FO : boolean);
  begin
    if Assigned(FEdit) then TOvcBEF(FEdit).ForceOvertype := FO;
  end;
{--------}
procedure TOvcTCBaseEntryField.SetHighlightColors(HC : TOvcColors);
  begin
    if Assigned(FEdit) then TOvcBEF(FEdit).HighlightColors := HC;
  end;
{--------}
procedure TOvcTCBaseEntryField.SetInsertPushes(IP : boolean);
  begin
    if Assigned(FEdit) then TOvcBEF(FEdit).InsertPushes := IP;
  end;
{--------}
procedure TOvcTCBaseEntryField.SetMaxLength(ML : word);
  begin
    if Assigned(FEdit) then
      begin
        TOvcBEF(FEdit).MaxLength := ML;
        TOvcBEF(FEditDisplay).MaxLength := ML;
      end;
  end;
{--------}
procedure TOvcTCBaseEntryField.SetPadChar(PC : AnsiChar);
  begin
    if Assigned(FEdit) then
      begin
        TOvcBEF(FEdit).PadChar := PC;
        TOvcBEF(FEditDisplay).PadChar := PC;
      end;
  end;
{--------}
procedure TOvcTCBaseEntryField.SetPasswordChar(PC : AnsiChar);
  begin
    if Assigned(FEdit) then
      begin
        TOvcBEF(FEdit).PasswordChar := PC;
        TOvcBEF(FEditDisplay).PasswordChar := PC;
      end;
  end;
{--------}
procedure TOvcTCBaseEntryField.SetPasswordMode(PM : boolean);
  begin
    if Assigned(FEdit) then
      begin
        TOvcBEF(FEdit).PasswordMode := PM;
        TOvcBEF(FEditDisplay).PasswordMode := PM;
      end;
  end;
{--------}
procedure TOvcTCBaseEntryField.SetRangeHi(RI : string);
  begin
    if Assigned(FEdit) then TOvcBEF(FEdit).RangeHi := RI;
  end;
{--------}
procedure TOvcTCBaseEntryField.SetRangeLo(RL : string);
  begin
    if Assigned(FEdit) then TOvcBEF(FEdit).RangeLo := RL;
  end;
{--------}
procedure TOvcTCBaseEntryField.SetRightAlign(RA : boolean);     {!!.10}
  begin                                                         {!!.10}
    if Assigned(FEdit) then                                     {!!.10}
      begin                                                     {!!.10}
        TOvcBEF(FEdit).RightAlign := RA;                        {!!.10}
        TOvcBEF(FEditDisplay).RightAlign := RA;                 {!!.10}
      end;                                                      {!!.10}
  end;                                                          {!!.10}
{--------}
procedure TOvcTCBaseEntryField.SetRightJustify(RJ : boolean);
  begin
    if Assigned(FEdit) then
      begin
        TOvcBEF(FEdit).RightJustify := RJ;
        TOvcBEF(FEditDisplay).RightJustify := RJ;
      end;
  end;
{--------}
procedure TOvcTCBaseEntryField.SetSoftValidation(SV : boolean);
  begin
    if Assigned(FEdit) then TOvcBEF(FEdit).SoftValidation := SV;
  end;
{--------}
procedure TOvcTCBaseEntryField.SetStripLiterals(SL : boolean);
  begin
    if Assigned(FEdit) then TOvcBEF(FEdit).StripLiterals := SL;
  end;
{--------}
procedure TOvcTCBaseEntryField.SetTextMargin(TM : integer);
  begin
    if Assigned(FEdit) then TOvcBEF(FEdit).TextMargin := TM;
  end;
{--------}
procedure TOvcTCBaseEntryField.SetTrimBlanks(TB : boolean);
  begin
    if Assigned(FEdit) then
      begin
        TOvcBEF(FEdit).TrimBlanks := TB;
        TOvcBEF(FEditDisplay).TrimBlanks := TB;
      end;
  end;
{====================================================================}

end.