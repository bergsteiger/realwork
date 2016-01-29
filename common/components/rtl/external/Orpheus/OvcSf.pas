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
{*                    OVCSF.PAS 2.17                     *}
{*     Copyright 1995-98 (c) TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcSF;
  {-Simple field visual component}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, Controls, Forms, Graphics, Menus, Messages, SysUtils,
  OvcBase, OvcColor, OvcCaret, OvcConst, OvcCmd,
  OvcData, OvcEf, OvcExcpt, OvcIntl, OvcMisc, OvcStr;

type
  {simple field type names}
  TSimpleDataType    = (
    sftString, sftChar, sftBoolean, sftYesNo,
    sftLongInt, sftWord, sftInteger, sftByte, sftShortInt,
    sftReal, sftExtended, sftDouble, sftSingle, sftComp);

const
  sfDefCaretToEnd      = True;
  sfDefInsertPushes    = True;
  sfDefParentColor     = False;
  sfDefTabStop         = True;
  sfDefSimpleDataType  = sftString;
  sfDefSimpleMask      = pmAnyChar;

type
  TOvcCustomSimpleField = class(TOvcBaseEntryField)
  {.Z+}
  protected {private}
    {property instance variables}
    FSimpleDataType : TSimpleDataType;  {data type for this field}
    FPictureMask    : AnsiChar;             {picture mask name}

    function sfGetDataType(Value : TSimpleDataType) : Byte;
      {-return a Byte value representing the type of this field}
    procedure sfResetFieldProperties(FT : TSimpleDataType);
      {-reset field properties}
    procedure sfSetDefaultRanges;
      {-set default range values based on the field type}

  protected
    procedure CreateWnd;
      override;

    procedure efEdit(var Msg : TMessage; Cmd : Word);
      override;
      {-process the specified editing command}
    function efGetDisplayString(Dest : PAnsiChar; Size : Word) : PAnsiChar;
      override;
      {-return the display string in Dest and a pointer as the result}
    procedure efIncDecValue(Wrap : Boolean; Delta : Double);
      override;
      {-increment field by Delta}
    function efTransfer(DataPtr : Pointer; TransferFlag : Word) : Word;
      override;
      {-transfer data to/from the entry fields}

    {virtual property methods}
    procedure sfSetDataType(Value : TSimpleDataType);
      virtual;
      {-set the data type for this field}
    procedure sfSetPictureMask(Value: AnsiChar);
      virtual;
      {-set the picture mask}

  public
    procedure Assign(Source : TPersistent);                            {!!.D4}
      override;
    constructor Create(AOwner: TComponent);
      override;

    function efValidateField : Word;
      override;
      {-validate contents of field; result is error code or 0}
  {.Z-}

    {public properties}
    property DataType : TSimpleDataType
      read FSimpleDataType
      write sfSetDataType
      default sfDefSimpleDataType;

    property PictureMask : AnsiChar
      read FPictureMask
      write sfSetPictureMask
      default sfDefSimpleMask;

  end;

  TOvcSimpleField = class(TOvcCustomSimpleField)
  published
    {inherited properties}
    property DataType;       {needs to loaded before most other properties}
    property ArrowIncDec;                                              {!!.10}
    property AutoAdvanceChar;
    property AutoAdvanceLeftRight;
    property AutoAdvanceUpDown;
    property AutoSelect;
    property AutoSize;
    property BeepOnError;
    property BorderStyle;
    property CaretIns;
    property CaretOvr;
    property CaretToEnd;
    property Color;
    property ControlCharColor;
    property Controller;
    property Ctl3D;
    property DecimalPlaces;
    property DragCursor;
    property DisabledColors;                                           {!!.12}
    property DragMode;
    property Enabled;
    property ErrorColors;
    property Font;
    property ForceInsert;
    property ForceOvertype;
    property HighlightColors;
    property InputRequired;
    property InsertPushes;
    property MaxLength;
    property PadChar;
    property ParentColor default sfDefParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PasswordMode;
    property PictureMask;
    property PopupMenu;
    property RangeHi stored False;
    property RangeLo stored False;
    property ReadOnly;
    property RightAlign;                                               {!!.10}
    property ShowHint;
    property SoftValidation;
    property TabOrder;
    property TabStop default sfDefTabStop;
    property Tag;
    property TextMargin;
    property TrimBlanks;
    property Uninitialized;
    property Visible;
    property ZeroDisplay;
    property ZeroDisplayValue;

    {inherited events}
    property AfterEnter;                                               {!!.12}
    property AfterExit;                                                {!!.12}
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnError;
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
    property OnUserCommand;
    property OnUserValidation;
  end;

implementation

{$IFDEF TRIALRUN}
uses OrTrial;
{$I ORTRIALF.INC}
{$ENDIF}

{*** TOvcCustomSimpleField ***}

procedure TOvcCustomSimpleField.Assign(Source : TPersistent);
var
  SF : TOvcCustomSimpleField absolute Source;
begin
  if (Source <> nil) and (Source is TOvcCustomSimpleField) then begin
    DataType             := SF.DataType;
    AutoAdvanceChar      := SF.AutoAdvanceChar;
    AutoAdvanceLeftRight := SF.AutoAdvanceLeftRight;
    AutoAdvanceUpDown    := SF.AutoAdvanceUpDown;
    AutoSelect           := SF.AutoSelect;
    AutoSize             := SF.AutoSize;
    BeepOnError          := SF.BeepOnError;
    BorderStyle          := SF.BorderStyle;
    CaretToEnd           := SF.CaretToEnd;
    Color                := SF.Color;
    ControlCharColor     := SF.ControlCharColor;
    DecimalPlaces        := SF.DecimalPlaces;
    ErrorColors.Assign(SF.ErrorColors);
    ForceInsert          := SF.ForceInsert;
    ForceOvertype        := SF.ForceOvertype;
    HighlightColors.Assign(SF.HighlightColors);
    InputRequired        := SF.InputRequired;
    InsertPushes         := SF.InsertPushes;
    MaxLength            := SF.MaxLength;
    PadChar              := SF.PadChar;
    PasswordChar         := SF.PasswordChar;
    PasswordMode         := SF.PasswordMode;
    PictureMask          := SF.PictureMask;
    RangeHi              := SF.RangeHi;
    RangeLo              := SF.RangeLo;
    ReadOnly             := SF.ReadOnly;
    SoftValidation       := SF.SoftValidation;
    TextMargin           := SF.TextMargin;
    TrimBlanks           := SF.TrimBlanks;
    Uninitialized        := SF.Uninitialized;
    ZeroDisplay          := SF.ZeroDisplay;
    ZeroDisplayValue     := SF.ZeroDisplayValue;
  end else
    inherited Assign(Source);
end;

constructor TOvcCustomSimpleField.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FSimpleDataType := sfDefSimpleDataType;
  FPictureMask    := sfDefSimpleMask;

  efFieldClass    := fcSimple;
  efDataType      := sfGetDataType(FSimpleDataType);
  efPicture[0]    := sfDefSimpleMask;
  efPicture[1]    := #0;
end;

procedure TOvcCustomSimpleField.CreateWnd;
var
  P : array[0..MaxEditLen+1] of Byte;
begin
  {save field data}
  if efSaveData then
    efTransfer(@P, otf_GetData);

  inherited CreateWnd;

  sfSetDefaultRanges;
  efSetInitialValue;

  {if we saved the field data, restore it}
  if efSaveData then
    efTransfer(@P, otf_SetData);

  {set save data flag}
  efSaveData := True;
end;

procedure TOvcCustomSimpleField.efEdit(var Msg : TMessage; Cmd : Word);
  {-process the specified editing command}

  procedure EditSimple(var Msg : TMessage; Cmd : Word);
    {-process the specified editing command for String and PChar fields}
  label
    ExitPoint;
  var
    SaveHPos    : Word;
    DelEnd      : Word;
    Len         : Word;
    Ch          : AnsiChar;
    PrevCh      : AnsiChar;
    MF          : ShortInt;
    HaveSel     : Boolean;
    SelExtended : Boolean;

    function CharIsOK : Boolean;
      {-return true if Ch can be added to the string}
    var
      PrevCh : AnsiChar;
    begin
      if efIsNumericType then
        if Ch = IntlSupport.DecimalChar then
          Ch := pmDecimalPt
        else if Ch = pmDecimalPt then
          Ch := #0;
      if (Ch < ' ') and not (sefLiteral in sefOptions) then begin
        CharIsOK := False;
        Exit;
      end;
      if efHPos = 0 then
        PrevCh := ' '
      else
        PrevCh := efEditSt[efHPos-1];
      CharIsOK := efCharOK(efPicture[0], Ch, PrevCh, True);
      if efIsNumericType and (Ch = pmDecimalPt) then
        Ch := IntlSupport.DecimalChar;
    end;

    function CheckAutoAdvance(SP : Integer) : Boolean;
      {-see if we need to auto-advance to next/previous field}
    begin
      CheckAutoAdvance := False;
      if (SP < 0) and AutoAdvanceLeftRight then begin
        efMoveFocusToPrevField;
        CheckAutoAdvance := True;
      end else if (SP >= MaxLength) then
        if (Cmd = ccChar) and AutoAdvanceChar then begin
          efMoveFocusToNextField;
          CheckAutoAdvance := True;
        end else if (Cmd <> ccChar) and AutoAdvanceLeftRight then begin
          efMoveFocusToNextField;
          CheckAutoAdvance := True;
        end;
    end;

    procedure FixSelValues;
    var
      I : Integer;
    begin
      if efSelStart > efSelEnd then begin
        I := efSelStart;
        efSelStart := efSelEnd;
        efSelEnd := I;
      end;
    end;

    procedure UpdateSel;
    begin
      if efSelStart = SaveHPos then
        efSelStart := efHPos
      else
        efSelEnd := efHPos;
      FixSelValues;
    end;

    procedure WordLeftPrim;
    begin
      Dec(efHPos);
      while (efHPos >= 0) and ((efHPos >= Len) or (efEditSt[efHPos] = ' ')) do
        Dec(efHPos);
      while (efHPos >= 0) and (efEditSt[efHPos] <> ' ') do
        Dec(efHPos);
      Inc(efHPos);
    end;

    procedure WordRightPrim;
    begin
      if efEditSt[efHPos] <> ' ' then
        Inc(efHPos);
      while (efHPos < Len) and (efEditSt[efHPos] <> ' ') do
        Inc(efHPos);
      while (efHPos < Len) and (efEditSt[efHPos] = ' ') do
        Inc(efHPos);
    end;

    procedure DeleteSel;
    begin
      StrStDeletePrim(efEditSt, efSelStart, efSelEnd-efSelStart);
      Len := StrLen(efEditSt);
      efHPos := efSelStart;
      efSelEnd := efHPos;
      MF := 10;
    end;

    procedure PastePrim(P : PAnsiChar);
    var
      Ch    : AnsiChar;
      IsNum : Boolean;
    begin
      if HaveSel then
        DeleteSel;
      IsNum := efIsNumericType;
      while P^ <> #0 do begin
        Ch := P^;
        if IsNum then
          if Ch = IntlSupport.DecimalChar then
            Ch := pmDecimalPt
          else if (Ch = pmDecimalPt) or (Ch = ' ') then
            Ch := #0;
        if efCharOK(efPicture[0], Ch, #255, True) then begin
          if (Len = MaxLength) and (efHPos < Len) and InsertPushes then begin
            Dec(Len);
            efEditSt[Len] := #0;
          end;
          if (Len < MaxLength) then begin
            if efIsNumericType and (Ch = pmDecimalPt) then
              Ch := IntlSupport.DecimalChar;
            StrChInsertPrim(efEditSt, Ch, efHPos);
            Inc(efHPos);
            Inc(Len);
          end;
          MF := 10;
        end;
        Inc(P);
      end;
    end;

  begin
    HaveSel := efSelStart <> efSelEnd;
    MF := Ord(HaveSel);
    SaveHPos := efHPos;
    SelExtended := False;

    case Cmd of
      ccAccept   : {};
      ccCtrlChar : Include(sefOptions, sefLiteral);
    else
      if Cmd <> ccChar then
        Exclude(sefOptions, sefLiteral);
    end;

    Len := StrLen(efEditSt);
    Exclude(sefOptions, sefCharOK);

    case Cmd of
      ccChar :
        begin
          Ch := AnsiChar(Lo(Msg.wParam));
          if (sefAcceptChar in sefOptions) and CharIsOk then begin
            Exclude(sefOptions, sefAcceptChar);
            Exclude(sefOptions, sefLiteral);
            if HaveSel then begin
              DeleteSel;
              if efHPos = 0 then
                PrevCh := ' '
              else
                PrevCh := efEditSt[efHPos-1];
              efCharOK(efPicture[0], Ch, PrevCh, True);
            end;
            if (sefInsert in sefOptions) then begin
              if (Len = MaxLength) and (efHPos < Len) and InsertPushes then begin
                Dec(Len);
                efEditSt[Len] := #0;
              end;
              if (Len < MaxLength) then begin
                StrChInsertPrim(efEditSt, Ch, efHPos);
                Inc(efHPos);
                CheckAutoAdvance(efHPos);
              end else if not CheckAutoAdvance(efHPos) then
                efConditionalBeep;
            end else if (efHPos+1) <= MaxLength then begin
              efEditSt[efHPos] := Ch;
              if efHPos >= Len then
                efEditSt[efHPos+1] := #0;
              Inc(efHPos);
              CheckAutoAdvance(efHPos);
            end else begin
              if not CheckAutoAdvance(efHPos) then
                efConditionalBeep;
              Dec(MF, 10);
            end;
            Inc(MF, 10);
          end else begin
            Exclude(sefOptions, sefLiteral);
            if sefAcceptChar in sefOptions then
              efConditionalBeep
            else
              goto ExitPoint;
          end;
        end;
      ccMouse :
        if Len > 0 then begin
          efHPos := efGetMousePos(SmallInt(Msg.lParamLo));
          {drag highlight initially if shift key is being pressed}
          if (GetKeyState(vk_Shift) < 0) then begin
            SelExtended := True;
            if HaveSel then begin
              if efHPos > efSelStart then
                efSelEnd := efHPos
              else
                efSelStart := efHPos;
            end else begin
              efSelStart := SaveHPos;
              efSelEnd := efHPos;
            end;
            FixSelValues;
          end else begin
            SetSelection(efHPos, efHPos);
            efPositionCaret(False);
          end;
        end;
      ccMouseMove :
        if Len > 0 then begin
          efHPos := efGetMousePos(SmallInt(Msg.lParamLo));
          UpdateSel;
        end;
      ccDblClk :
        if Len > 0 then begin
          efHPos := efGetMousePos(SmallInt(Msg.lParamLo));
          WordLeftPrim;
          SaveHPos := efHPos;
          efSelStart := SaveHPos;
          efSelEnd := SaveHPos;
          WordRightPrim;
          UpdateSel;
        end;
      ccLeft :
        if efHPos > 0 then
          Dec(efHPos)
        else
          CheckAutoAdvance(-1);
      ccRight :
        if efHPos < Len then
          Inc(efHPos)
        else
          CheckAutoAdvance(MaxLength);
      ccUp :
        if AutoAdvanceUpDown then
          efMoveFocusToPrevField
        else if ArrowIncDec and not ReadOnly then              {!!.10}{!!.14}
          IncreaseValue(True, 1)                                      {!!.10}
        else if efHPos > 0 then
          Dec(efHPos)
        else
          CheckAutoAdvance(-1);
      ccDown :
        if AutoAdvanceUpDown then
          efMoveFocusToNextField
        else if ArrowIncDec and not ReadOnly then              {!!.10}{!!.14}
          DecreaseValue(True, 1)                                      {!!.10}
        else if efHPos < Len then
          Inc(efHPos)
        else
          CheckAutoAdvance(MaxLength);
      ccWordLeft :
        if efHPos > 0 then
          WordLeftPrim
        else
          CheckAutoAdvance(-1);
      ccWordRight :
        if efHPos < Len then
          WordRightPrim
        else
          CheckAutoAdvance(MaxLength);
      ccHome :
        efHPos := 0;
      ccEnd :
        efHPos := Len;
      ccExtendLeft :
        if efHPos > 0 then begin
          Dec(efHPos);
          UpdateSel;
        end else
          MF := -1;
      ccExtendRight :
        if efHPos < Len then begin
          Inc(efHPos);
          UpdateSel;
        end else
          MF := -1;
      ccExtendHome :
        begin
          efHPos := 0;
          UpdateSel;
        end;
      ccExtendEnd :
        begin
          efHPos := Len;
          UpdateSel;
        end;
      ccExtWordLeft :
        if efHPos > 0 then begin
          WordLeftPrim;
          UpdateSel;
        end else
          MF := -1;
      ccExtWordRight :
        if efHPos < Len then begin
          WordRightPrim;
          UpdateSel;
        end else
          MF := -1;
      ccCut :
        if HaveSel then
          DeleteSel;
      ccCopy : {} ;
      ccPaste :
        PastePrim(PAnsiChar(Msg.lParam));
      ccBack :
        if HaveSel then
          DeleteSel
        else if efHPos > 0 then begin
          Dec(efHPos);
          StrStDeletePrim(efEditSt, efHPos, 1);
          MF := 10;
        end;
      ccDel :
        if HaveSel then
          DeleteSel
        else if efHPos < Len then begin
          StrStDeletePrim(efEditSt, efHPos, 1);
          MF := 10;
        end;
      ccDelWord :
        if HaveSel then
          DeleteSel
        else if efHPos < Len then begin
          {start deleting at the caret}
          DelEnd := efHPos;

          {delete all of the current word, if any}
          if efEditSt[efHPos] <> ' ' then
            while (efEditSt[DelEnd] <> ' ') and (DelEnd < Len) do
              Inc(DelEnd);

          {delete any spaces prior to the next word, if any}
          while (efEditSt[DelEnd] = ' ') and (DelEnd < Len) do
            Inc(DelEnd);

          StrStDeletePrim(efEditSt, efHPos, DelEnd-efHPos);
          MF := 10;
        end;
      ccDelLine :
        if Len > 0 then begin
          efEditSt[0] := #0;
          efHPos := 0;
          MF := 10;
        end;
      ccDelEol :
        if efHPos < Len then begin
          efEditSt[efHPos] := #0;
          MF := 10;
        end;
      ccDelBol :
        if Len > 0 then begin
          StrStDeletePrim(efEditSt, 0, efHPos);
          efHPos := 0;
          MF := 10;
        end;
      ccIns :
        begin
          if sefInsert in sefOptions then
            Exclude(sefOptions, sefInsert)
          else
            Include(sefOptions, sefInsert);
          efCaret.InsertMode := (sefInsert in sefOptions);
        end;
      ccRestore : Restore;
      ccAccept :
        begin
          Include(sefOptions, sefCharOK);
          Include(sefOptions, sefAcceptChar);
          Exit;
        end;
      ccDec :
        DecreaseValue(True, 1);
      ccInc :
        IncreaseValue(True, 1);
      ccCtrlChar, ccSuppress, ccPartial :
        goto ExitPoint;
    else
      Include(sefOptions, sefCharOK);
      goto ExitPoint;
    end;
    Exclude(sefOptions, sefAcceptChar);

    case Cmd of
      ccRestore, ccMouseMove, ccDblClk,
      ccExtendLeft, ccExtendRight,
      ccExtendHome, ccExtendEnd,
      ccExtWordLeft, ccExtWordRight :
        Inc(MF);
      ccMouse :
        if SelExtended then
          Inc(MF);
    else
      efSelStart := efHPos;
      efSelEnd := efHPos;
    end;

  ExitPoint:
    if efPositionCaret(True) then
      Inc(MF);
    if MF >= 10 then
      efFieldModified;
    if MF > 0 then
      Invalidate;
  end;

  procedure EditChar(var Msg : TMessage; Cmd : Word);
    {-process the specified editing command for Char fields}
  label
    ExitPoint;
  var
    MF : Byte;
    Ch : AnsiChar;

    function CharIsOK : Boolean;
      {-return true if Ch can be added to the string}
    begin
      if (Ch < ' ') and not (sefLiteral in sefOptions) then
        CharIsOK := False
      else
        CharIsOK := efCharOK(efPicture[0], Ch, ' ', True);
    end;

    function CheckAutoAdvance(SP : Integer) : Boolean;
      {-see if we need to auto-advance to next/previous field}
    begin
      CheckAutoAdvance := False;
      if (SP < 0) and AutoAdvanceLeftRight then begin
        efMoveFocusToPrevField;
        Result := True;
      end else if (SP > 0) then
        if (Cmd = ccChar) and AutoAdvanceChar then begin
          efMoveFocusToNextField;
          Result := True;
        end else if (Cmd <> ccChar) and AutoAdvanceLeftRight then begin
          efMoveFocusToNextField;
          Result := True;
        end;
    end;

    procedure PastePrim(P : PAnsiChar);
    begin
      while P^ <> #0 do begin
        Ch := P^;
        if efCharOK(efPicture[0], Ch, #255, True) then begin
          efEditSt[0] := Ch;
          MF := 10;
          Exit;
        end;
        Inc(P);
      end;
    end;

  begin
    MF := Ord(efSelStart <> efSelEnd);
    case Cmd of
      ccAccept : ;
      ccCtrlChar :
        Include(sefOptions, sefLiteral);
      else
        efHPos := 0;
        if Cmd <> ccChar then
          Exclude(sefOptions, sefLiteral);
    end;

    Exclude(sefOptions, sefCharOK);
    case Cmd of
      ccChar :
        begin
          Ch := AnsiChar(Lo(Msg.wParam));
          if sefAcceptChar in sefOptions then
            if CharIsOk then begin
              efEditSt[0] := Ch;
              efEditSt[1] := #0;
              CheckAutoAdvance(1);
              MF := 10;
            end else                                                   {!!.13}
              efConditionalBeep;
            {end;}                                                     {!!.13}
          sefOptions := sefOptions - [sefAcceptChar, sefLiteral];
        end;
      ccLeft, ccWordLeft :
        CheckAutoAdvance(-1);
      ccRight, ccWordRight :
        CheckAutoAdvance(MaxLength);
      ccUp :
        if AutoAdvanceUpDown then
          efMoveFocusToPrevField
        else
          CheckAutoAdvance(-1);
      ccDown :
        if AutoAdvanceUpDown then
          efMoveFocusToNextField
        else
          CheckAutoAdvance(MaxLength);
      ccRestore :
        Restore;
      ccExtendRight, ccExtendEnd, ccExtWordRight :
        efSelEnd := 1;
      ccMouseMove :
        if efGetMousePos(SmallInt(Msg.lParamLo)) > 0 then
          efSelEnd := 1
        else
          efSelEnd := 0;
      ccDblClk :
        efSelEnd := 1;
      ccPaste :
        PastePrim(PAnsiChar(Msg.lParam));
      ccAccept :
        begin
          sefOptions := sefOptions + [sefCharOK, sefAcceptChar];
          Exit;
        end;
      ccMouse, ccExtendLeft, ccExtendHome, ccExtWordLeft : ;
      ccDec :
        DecreaseValue(True, 1);
      ccInc :
        IncreaseValue(True, 1);
      ccCtrlChar, ccSuppress, ccPartial :
        goto ExitPoint;
    else
      Include(sefOptions, sefCharOK);
      goto ExitPoint;
    end;
    Exclude(sefOptions, sefAcceptChar);

    case Cmd of
      ccRestore, ccMouseMove, ccDblClk, ccExtendRight,
      ccExtendEnd, ccExtWordRight :
        Inc(MF);
    else
      efSelStart := 0;
      efSelEnd := 0;
    end;

  ExitPoint:
    if efPositionCaret(True) then
      Inc(MF);
    if MF >= 10 then
      efFieldModified;
    if MF > 0 then
      Invalidate;
  end;

begin  {edit}
  case FSimpleDataType of
    sftString,
    sftLongInt, sftWord, sftInteger, sftByte, sftShortInt,
    sftReal, sftExtended, sftDouble, sftSingle, sftComp :
      EditSimple(Msg, Cmd);
    sftChar, sftBoolean, sftYesNo :
      EditChar(Msg, Cmd);
  end;
end;

function TOvcCustomSimpleField.efGetDisplayString(Dest : PAnsiChar; Size : Word) : PAnsiChar;
  {-return the display string in Dest and a pointer as the result}
var
  Len   : Word;
begin
  Result := inherited efGetDisplayString(Dest, Size);

  Len := StrLen(Dest);
  if Len = 0 then
    Exit;

  if Uninitialized and not (sefHaveFocus in sefOptions) then begin
    FillChar(Dest[0], Len, ' ');
    Exit;
  end;

  if PasswordMode then
    FillChar(Dest[0], Len, PasswordChar);

  if PadChar <> ' ' then begin
    FillChar(Dest[Len], MaxLength-Len, PadChar);
    Dest[MaxLength] := #0;
  end;
end;

procedure TOvcCustomSimpleField.efIncDecValue(Wrap : Boolean; Delta : Double);
  {-increment field by Delta}
var
  S : TEditString;

  procedure IncDecValueChar;
    {-increment Char field by Delta}
  var
    C, CC, CL, CH, MC : AnsiChar;
    OK : Boolean;
  begin
    {get valid range}
    CL := efRangeLo.rtChar;
    CH := efRangeHi.rtChar;
    if CL = CH then begin
      CL := #1;
      CH := #255;
    end;

    {get current character}
    C := efEditSt[0];

    {get mask character}
    MC := efPicture[0];

    {exit if we're at the range limit and not allowed to wrap}
    if (Delta < 0) and (C = CL) then begin
      if not Wrap then
        Exit;
    end else if (Delta > 0) and (C = CH) then
      if not Wrap then
        Exit;

    {find the next/prev allowable character}
    OK := False;
    repeat
      repeat
        if Delta = 1 then
          Inc(C)
        else
          Dec(C);
        CC := C;
        efFixCase(MC, CC, ' ');
      until efCharOK(MC, C, ' ', False) and (C = CC);

      {check result to see if it's in valid range}
      if (C >= CL) and (C <= CH) then
        OK := True
      else if Wrap then
        OK := False
      else
        Exit;
    until OK;

    efTransfer(@C, otf_SetData);
    efPerformRepaint(True);
  end;

  procedure IncDecValueBoolean;
  var
    Ch : AnsiChar;
    B  : Boolean;
  begin
    Ch := UpCaseChar(efEditSt[0]);
    if Ch = IntlSupport.TrueChar then
      Ch := IntlSupport.FalseChar
    else
      Ch := IntlSupport.TrueChar;
    B := Ch = IntlSupport.TrueChar;

    efTransfer(@B, otf_SetData);
    efPerformRepaint(True);
  end;

  procedure IncDecValueYesNo;
  var
    Ch : AnsiChar;
    B  : Boolean;
  begin
    Ch := UpCaseChar(efEditSt[0]);
    if Ch = IntlSupport.YesChar then
      Ch := IntlSupport.NoChar
    else
      Ch := IntlSupport.YesChar;
    B := Ch = IntlSupport.YesChar;

    efTransfer(@B, otf_SetData);
    efPerformRepaint(True);
  end;

  procedure IncDecValueLongInt;
  var
    L : LongInt;
  begin
    if efStr2Long(efEditSt, L) then begin
      if (Delta < 0) and (L <= efRangeLo.rtLong) then
        if Wrap then
          L := efRangeHi.rtLong
        else Exit
      else if (Delta > 0) and (L >= efRangeHi.rtLong) then
        if Wrap then
          L := efRangeLo.rtLong
        else Exit
      else
        Inc(L, Trunc(Delta));

      {!!.11}
      {insure valid value}
      if L < efRangeLo.rtLong then
        L := efRangeLo.rtLong;
      if L > efRangeHi.rtLong then
        L := efRangeHi.rtLong;

      efTransfer(@L, otf_SetData);
      efPerformRepaint(True);
    end;
  end;

  procedure IncDecValueReal;
  var
    Re   : Real;
    Code : Integer;
  begin
    {convert efEditSt to a real}
    StrLCopy(S, efEditSt, 80);
    FixRealPrim(S, IntlSupport.DecimalChar);                           {!!.16}
    Val(S, Re, Code);
    if Code = 0 then begin
      if (Delta < 0) and (Re <= efRangeLo.rtReal) then
        if Wrap then
          Re := efRangeHi.rtReal
        else Exit
      else if (Delta > 0) and (Re >= efRangeHi.rtReal) then
        if Wrap then
          Re := efRangeLo.rtReal
        else Exit
      else
        Re := Re + Delta;

      {!!.11}
      {insure valid value}
      if Re < efRangeLo.rtReal then
        Re := efRangeLo.rtReal;
      if Re > efRangeHi.rtReal then
        Re := efRangeHi.rtReal;

      efTransfer(@Re, otf_SetData);
      efPerformRepaint(True);
    end;
  end;

  procedure IncDecValueExtended;
  var
    Ex   : Extended;
    Code : Integer;
  begin
    {convert efEditSt to an real}
    StrLCopy(S, efEditSt, 80);
    FixRealPrim(S, IntlSupport.DecimalChar);                           {!!.16}
    Val(S, Ex, Code);
    if Code = 0 then begin
      if (Delta < 0) and (Ex <= efRangeLo.rtExt) then
        if Wrap then
          Ex := efRangeHi.rtExt
        else Exit
      else if (Delta > 0) and (Ex >= efRangeHi.rtExt) then
        if Wrap then
          Ex := efRangeLo.rtExt
        else Exit
      else
        Ex := Ex + Delta;

      {!!.11}
      {insure valid value}
      if Ex < efRangeLo.rtExt then
        Ex := efRangeLo.rtExt;
      if Ex > efRangeHi.rtExt then
        Ex := efRangeHi.rtExt;

      efTransfer(@Ex, otf_SetData);
      efPerformRepaint(True);
    end;
  end;

  procedure IncDecValueDouble;
  var
    Db   : Double;
    Code : Integer;
  begin
    {convert efEditSt to an real}
    StrLCopy(S, efEditSt, 80);
    FixRealPrim(S, IntlSupport.DecimalChar);                           {!!.16}
    Val(S, Db, Code);
    if Code = 0 then begin
      if (Delta < 0) and (Db <= efRangeLo.rtExt) then
        if Wrap then
          Db := efRangeHi.rtExt
        else Exit
      else if (Delta > 0) and (Db >= efRangeHi.rtExt) then
        if Wrap then
          Db := efRangeLo.rtExt
        else Exit
      else
        Db := Db + Delta;

      {!!.11}
      {insure valid value}
      if Db < efRangeLo.rtExt then
        Db := efRangeLo.rtExt;
      if Db > efRangeHi.rtExt then
        Db := efRangeHi.rtExt;

      efTransfer(@Db, otf_SetData);
      efPerformRepaint(True);
    end;
  end;

  procedure IncDecValueSingle;
  var
    Si   : Single;
    Code : Integer;
  begin
    {convert efEditSt to an real}
    StrLCopy(S, efEditSt, 80);
    FixRealPrim(S, IntlSupport.DecimalChar);                           {!!.16}
    Val(S, Si, Code);
    if Code = 0 then begin
      if (Delta < 0) and (Si <= efRangeLo.rtExt) then
        if Wrap then
          Si := efRangeHi.rtExt
        else Exit
      else if (Delta > 0) and (Si >= efRangeHi.rtExt) then
        if Wrap then
          Si := efRangeLo.rtExt
        else Exit
      else
        Si := Si + Delta;

      {!!.11}
      {insure valid value}
      if Si < efRangeLo.rtExt then
        Si := efRangeLo.rtExt;
      if Si > efRangeHi.rtExt then
        Si := efRangeHi.rtExt;

      efTransfer(@Si, otf_SetData);
      efPerformRepaint(True);
    end;
  end;

  procedure IncDecValueComp;
  var
    Co   : Comp;
    Code : Integer;
  begin
    {convert efEditSt to an real}
    StrLCopy(S, efEditSt, 80);
    FixRealPrim(S, IntlSupport.DecimalChar);                           {!!.16}
    Val(S, Co, Code);
    if Code = 0 then begin
      if (Delta < 0) and (Co <= efRangeLo.rtExt) then
        if Wrap then
          Co := efRangeHi.rtExt
        else Exit
      else if (Delta > 0) and (Co >= efRangeHi.rtExt) then
        if Wrap then
          Co := efRangeLo.rtExt
        else Exit
      else
        Co := Co + Delta;

      {!!.11}
      {insure valid value}
      if Co < efRangeLo.rtExt then
        Co := efRangeLo.rtExt;
      if Co > efRangeHi.rtExt then
        Co := efRangeHi.rtExt;

      efTransfer(@Co, otf_SetData);
      efPerformRepaint(True);
    end;
  end;

begin
  if not (sefHaveFocus in sefOptions) then
    Exit;
  case FSimpleDataType of
    sftString   : {not supported for this field type};
    sftChar     : IncDecValueChar;
    sftBoolean  : IncDecValueBoolean;
    sftYesNo    : IncDecValueYesNo;
    sftLongInt,
    sftWord,
    sftInteger,
    sftByte,
    sftShortInt : IncDecValueLongInt;
    sftReal     : IncDecValueReal;
    sftExtended : IncDecValueExtended;
    sftDouble   : IncDecValueDouble;
    sftSingle   : IncDecValueSingle;
    sftComp     : IncDecValueComp;
  else
    raise EOvcException.Create(GetOrphStr(SCInvalidParamValue));
  end;
  efPositionCaret(False);
end;

function TOvcCustomSimpleField.efTransfer(DataPtr : Pointer; TransferFlag : Word) : Word;
  {-transfer data to/from the entry fields}
var
  S : TEditString;

  procedure TransferString;
  var
    I : Integer;
  begin
    if TransferFlag = otf_GetData then
      ShortString(DataPtr^) := StrPas(efEditSt)
    else begin
      if ShortString(DataPtr^) = '' then
        efEditSt[0] := #0
      else begin
        StrPLCopy(efEditSt, ShortString(DataPtr^), MaxLength);
        for I := 0 to Integer(StrLen(efEditSt))-1 do
          efFixCase(efNthMaskChar(I), efEditSt[I], #255);
      end;
    end;
  end;

  procedure TransferChar;
  begin
    if TransferFlag = otf_GetData then
      AnsiChar(DataPtr^) := efEditSt[0]
    else begin
      efEditSt[0] := AnsiChar(DataPtr^);
      efEditSt[1] := #0;
    end;
  end;

  procedure TransferBoolean;
  begin
    if TransferFlag = otf_GetData then
      Boolean(DataPtr^) := (UpCaseChar(efEditSt[0]) = IntlSupport.TrueChar)
    else begin
      if Boolean(DataPtr^) then
        efEditSt[0] := IntlSupport.TrueChar
      else
        efEditSt[0] := IntlSupport.FalseChar;
      efEditSt[1] := #0;
    end;
  end;

  procedure TransferYesNo;
  begin
    if TransferFlag = otf_GetData then
      Boolean(DataPtr^) := (UpCaseChar(efEditSt[0]) = IntlSupport.YesChar)
    else begin
      if Boolean(DataPtr^) then
        efEditSt[0] := IntlSupport.YesChar
      else
        efEditSt[0] := IntlSupport.NoChar;
      efEditSt[1] := #0;
    end;
  end;

  procedure TransferLongInt;
  begin
    if TransferFlag = otf_GetData then begin
      if not efStr2Long(efEditSt, LongInt(DataPtr^)) then
        LongInt(DataPtr^) := 0;
    end else
      efLong2Str(efEditSt, LongInt(DataPtr^));
  end;

  procedure TransferWord;
  var
    L : LongInt;
  begin
    if TransferFlag = otf_GetData then begin
      if efStr2Long(efEditSt, L) then
        Word(DataPtr^) := Word(L)
      else
        Word(DataPtr^) := 0;
    end else
      efLong2Str(efEditSt, Word(DataPtr^));
  end;

  procedure TransferInteger;
  var
    L : LongInt;
  begin
    if TransferFlag = otf_GetData then begin
      if efStr2Long(efEditSt, L) then
        SmallInt(DataPtr^) := SmallInt(L)
      else
        SmallInt(DataPtr^) := 0;
    end else
      efLong2Str(efEditSt, SmallInt(DataPtr^));
  end;

  procedure TransferByte;
  var
    L : LongInt;
  begin
    if TransferFlag = otf_GetData then begin
      if efStr2Long(efEditSt, L) then
        Byte(DataPtr^) := Byte(L)
      else
        Byte(DataPtr^) := 0;
    end else
      efLong2Str(efEditSt, Byte(DataPtr^));
  end;

  procedure TransferShortInt;
  var
    L : LongInt;
  begin
    if TransferFlag = otf_GetData then begin
      if efStr2Long(efEditSt, L) then
        ShortInt(DataPtr^) := ShortInt(L)
      else
        ShortInt(DataPtr^) := 0;
    end else
      efLong2Str(efEditSt, ShortInt(DataPtr^));
  end;

  procedure TransferReal;
  label
    UseExp;
  var
    Code : Integer;
    I    : Cardinal;
    R    : Real;
  begin
    if TransferFlag = otf_GetData then begin
      StrCopy(S, efEditSt);
      FixRealPrim(S, IntlSupport.DecimalChar);                         {!!.16}
      Val(PAnsiChar(@S[0]), R, Code);
      if Code <> 0 then
        R := 0;
      Real(DataPtr^) := R;
    end else begin
      {try to use regular notation}
      R := Real(DataPtr^);
      if StrScan(efPicture, pmScientific) <> nil then
        goto UseExp;
      Str(R:0:DecimalPlaces, S);

      {trim trailing 0's if appropriate}
      if StrScan(S, pmDecimalPt) <> nil  then
        TrimTrailingZerosPChar(S);

      {does it fit?}
      if StrLen(S) > MaxLength then begin
        {won't fit--use scientific notation}
  UseExp:
        if (DecimalPlaces <> 0) and (9+DecimalPlaces < MaxLength) then
          Str(R:9+DecimalPlaces, S)
        else
          Str(R:MaxLength, S);
        TrimAllSpacesPChar(S);
        TrimEmbeddedZerosPChar(S);
      end;

      {convert decimal point}
      if StrChPos(S, pmDecimalPt, I) then
        S[I] := IntlSupport.DecimalChar;

      StrLCopy(efEditSt, S, MaxLength);
    end;
  end;

  procedure TransferExtended;
  label
    UseExp;
  var
    Code : Integer;
    I    : Cardinal;
    E    : Extended;
  begin
    if TransferFlag = otf_GetData then begin
      StrCopy(S, efEditSt);
      FixRealPrim(S, IntlSupport.DecimalChar);                         {!!.16}
      Val(S, E, Code);
      if Code <> 0 then
        E := 0;
      Extended(DataPtr^) := E;
    end else begin
      {try to use regular notation}
      E := Extended(DataPtr^);
      if StrScan(efPicture, pmScientific) <> nil then
        goto UseExp;
      Str(E:0:DecimalPlaces, S);

      {trim trailing 0's if appropriate}
      if StrScan(S, pmDecimalPt) <> nil  then
        TrimTrailingZerosPChar(S);

      {does it fit?}
      if StrLen(S) > MaxLength then begin
        {won't fit--use scientific notation}
  UseExp:
        if (DecimalPlaces <> 0) and (9+DecimalPlaces < MaxLength) then
          Str(E:9+DecimalPlaces, S)
        else
          Str(E:MaxLength, S);
        TrimAllSpacesPChar(S);
        TrimEmbeddedZerosPChar(S);
      end;

      {convert decimal point}
      if StrChPos(S, pmDecimalPt, I) then
        S[I] := IntlSupport.DecimalChar;

      StrLCopy(efEditSt, S, MaxLength);
    end;
  end;

  procedure TransferDouble;
  label
    UseExp;
  var
    Code : Integer;
    I    : Cardinal;
    D    : Double;
  begin
    if TransferFlag = otf_GetData then begin
      StrCopy(S, efEditSt);
      FixRealPrim(S, IntlSupport.DecimalChar);                         {!!.16}
      Val(PAnsiChar(@S[0]), D, Code);
      if Code <> 0 then
        D := 0;
      Double(DataPtr^) := D;
    end else begin
      {try to use regular notation}
      D := Double(DataPtr^);
      if StrScan(efPicture, pmScientific) <> nil then
        goto UseExp;
      Str(D:0:DecimalPlaces, S);

      {trim trailing 0's if appropriate}
      if StrScan(S, pmDecimalPt) <> nil  then
        TrimTrailingZerosPChar(S);

      {does it fit?}
      if StrLen(S) > MaxLength then begin
        {won't fit--use scientific notation}
  UseExp:
        if (DecimalPlaces <> 0) and (9+DecimalPlaces < MaxLength) then
          Str(D:9+DecimalPlaces, S)
        else
          Str(D:MaxLength, S);
        TrimAllSpacesPChar(S);
        TrimEmbeddedZerosPChar(S);
      end;

      {convert decimal point}
      if StrChPos(S, pmDecimalPt, I) then
        S[I] := IntlSupport.DecimalChar;

      StrLCopy(efEditSt, S, MaxLength);
    end;
  end;

  procedure TransferSingle;
  label
    UseExp;
  var
    Code : Integer;
    I    : Cardinal;
    G    : Single;
  begin
    if TransferFlag = otf_GetData then begin
      StrCopy(S, efEditSt);
      FixRealPrim(S, IntlSupport.DecimalChar);                         {!!.16}
      Val(S, G, Code);
      if Code <> 0 then
        G := 0;
      Single(DataPtr^) := G;
    end else begin
      {try to use regular notation}
      G := Single(DataPtr^);
      if StrScan(efPicture, pmScientific) <> nil then
        goto UseExp;
      Str(G:0:DecimalPlaces, S);

      {trim trailing 0's if appropriate}
      if StrScan(S, pmDecimalPt) <> nil  then
        TrimTrailingZerosPChar(S);

      {does it fit?}
      if StrLen(S) > MaxLength then begin
        {won't fit--use scientific notation}
  UseExp:
        if (DecimalPlaces <> 0) and (9+DecimalPlaces < MaxLength) then
          Str(G:9+DecimalPlaces, S)
        else
          Str(G:MaxLength, S);
        TrimAllSpacesPChar(S);
        TrimEmbeddedZerosPChar(S);
      end;

      {convert decimal point}
      if StrChPos(S, pmDecimalPt, I) then
        S[I] := IntlSupport.DecimalChar;

      StrLCopy(efEditSt, S, MaxLength);
    end;
  end;

  procedure TransferComp;
    {-transfer data to or from Comp fields}
  label
    UseExp;
  var
    Code : Integer;
    C    : Comp;
  begin
    if TransferFlag = otf_GetData then begin
      StrCopy(S, efEditSt);
      FixRealPrim(S, IntlSupport.DecimalChar);                         {!!.16}
      Val(PAnsiChar(@S[0]), C, Code);
      if Code <> 0 then
        C := 0;
      Comp(DataPtr^) := C;
    end else begin
      {try to use regular notation}
      C := Comp(DataPtr^);
      if StrScan(efPicture, pmScientific) <> nil then
        goto UseExp;
      Str(C:0:DecimalPlaces, S);

      {trim trailing 0's if appropriate}
      if StrScan(S, pmDecimalPt) <> nil  then
        TrimTrailingZerosPChar(S);

      {does it fit?}
      if StrLen(S) > MaxLength then begin
        {won't fit--use scientific notation}
  UseExp:
        Str(C:MaxLength, S);
        TrimAllSpacesPChar(S);
        TrimEmbeddedZerosPChar(S);
      end;
      StrLCopy(efEditSt, S, MaxLength);
    end;
  end;

begin  {transfer}
  {!!.13} {added}
  if DataPtr = nil then begin
    Result := 0;
    Exit;
  end;

  case FSimpleDataType of
    sftString   : TransferString;
    sftChar     : TransferChar;
    sftBoolean  : TransferBoolean;
    sftYesNo    : TransferYesNo;
    sftLongInt  : TransferLongInt;
    sftWord     : TransferWord;
    sftInteger  : TransferInteger;
    sftByte     : TransferByte;
    sftShortInt : TransferShortInt;
    sftReal     : TransferReal;
    sftExtended : TransferExtended;
    sftDouble   : TransferDouble;
    sftSingle   : TransferSingle;
    sftComp     : TransferComp;
  else
    raise EOvcException.Create(GetOrphStr(SCInvalidParamValue));
  end;

  Result := inherited efTransfer(DataPtr, TransferFlag);
end;

function  TOvcCustomSimpleField.efValidateField : Word;
  {-validate contents of field; result is error code or 0}
var
  S : TEditString;

  procedure ValidateString;
  var
    L : Word;
  begin
    if sefGettingValue in sefOptions then
      Exit;

    if TrimBlanks then
      if sefHaveFocus in sefOptions then begin
        L := StrLen(efEditSt);
        TrimAllSpacesPChar(efEditSt);
        if StrLen(efEditSt) <> L then
          Invalidate;
      end;
  end;

  procedure ValidateChar;
  begin
    if (efRangeLo.rtChar <> efRangeHi.rtChar) and
      ((efEditSt[0] < efRangeLo.rtChar) or (efEditSt[0] > efRangeHi.rtChar)) then
      Result := oeRangeError;
  end;

  procedure ValidateBoolean;
  begin
    if (UpCaseChar(efEditSt[0]) <> IntlSupport.TrueChar) and
       (UpCaseChar(efEditSt[0]) <> IntlSupport.FalseChar) then
      Result := oeRangeError;
  end;

  procedure ValidateYesNo;
  begin
    if (UpCaseChar(efEditSt[0]) <> IntlSupport.YesChar) and
       (UpCaseChar(efEditSt[0]) <> IntlSupport.NoChar) then
      Result := oeRangeError;
  end;

  procedure ValidateLongInt;
  var
    L : LongInt;
  begin
    if not efStr2Long(efEditSt, L) then
      Result := oeInvalidNumber
    else if (L < efRangeLo.rtLong) or (L > efRangeHi.rtLong) then
      Result := oeRangeError
    else begin
      if sefHaveFocus in sefOptions then
        if not (sefGettingValue in sefOptions) then begin
          efTransfer(@L, otf_SetData);
          Invalidate;
        end;
    end;
  end;

  procedure ValidateWord;
  var
    L : LongInt;
  begin
    if not efStr2Long(efEditSt, L) then
      Result := oeInvalidNumber
    else if (L < efRangeLo.rtLong) or (L > efRangeHi.rtLong) then
      Result := oeRangeError
    else begin
      if sefHaveFocus in sefOptions then
        if not (sefGettingValue in sefOptions) then begin
          efTransfer(@L, otf_SetData);
          Invalidate;
        end;
    end;
  end;

  procedure ValidateInteger;
  var
    L : LongInt;
    I : Integer;
  begin
    if not efStr2Long(efEditSt, L) then
      Result := oeInvalidNumber
    else if (L < efRangeLo.rtLong) or (L > efRangeHi.rtLong) then
      Result := oeRangeError
    else begin
      if sefHaveFocus in sefOptions then
        if not (sefGettingValue in sefOptions) then begin
          I := L;
          efTransfer(@I, otf_SetData);
          Invalidate;
        end;
    end;
  end;

  procedure ValidateByte;
  var
    L : LongInt;
    B : Byte;
  begin
    if not efStr2Long(efEditSt, L) then
      Result := oeInvalidNumber
    else if (L < efRangeLo.rtLong) or (L > efRangeHi.rtLong) then
      Result := oeRangeError
    else begin
      if sefHaveFocus in sefOptions then
        if not (sefGettingValue in sefOptions) then begin
          B := L;
          efTransfer(@B, otf_SetData);
          Invalidate;
        end;
    end;
  end;

  procedure ValidateShortInt;
  var
    L  : LongInt;
    Si : ShortInt;
  begin
    if not efStr2Long(efEditSt, L) then
      Result := oeInvalidNumber
    else if (L < efRangeLo.rtLong) or (L > efRangeHi.rtLong) then
      Result := oeRangeError
    else begin
      if sefHaveFocus in sefOptions then
        if not (sefGettingValue in sefOptions) then begin
          Si := L;
          efTransfer(@Si, otf_SetData);
          Invalidate;
        end;
    end;
  end;

  procedure ValidateReal;
  var
    R    : Real;
    Code : Integer;
  begin
    {convert efEditSt to a real}
    StrLCopy(S, efEditSt, 80);
    FixRealPrim(S, IntlSupport.DecimalChar);                           {!!.16}
    Val(S, R, Code);

    {format OK?}
    if Code <> 0 then
      Result := oeInvalidNumber
    else if (R < efRangeLo.rtReal) or (R > efRangeHi.rtReal) then
      Result := oeRangeError
    else begin
      if sefHaveFocus in sefOptions then
        if not (sefGettingValue in sefOptions) then begin
          efTransfer(@R, otf_SetData);
          Invalidate;
        end;
    end;
  end;

  procedure ValidateExtended;
  var
    E    : Extended;
    Code : Integer;
  begin
    {convert efEditSt to an extended}
    StrLCopy(S, efEditSt, 80);
    FixRealPrim(S, IntlSupport.DecimalChar);                           {!!.16}
    Val(S, E, Code);
    if Code <> 0 then
      Result := oeInvalidNumber
    else if (E < efRangeLo.rtExt) or (E > efRangeHi.rtExt) then
      Result := oeRangeError
    else begin
      if sefHaveFocus in sefOptions then
        if not (sefGettingValue in sefOptions) then begin
          efTransfer(@E, otf_SetData);
          Invalidate;
        end;
    end;
  end;

  procedure ValidateDouble;
  var
    E    : Extended;
    D    : Double;
    Code : Integer;
  begin
    {convert efEditSt to an extended}
    StrLCopy(S, efEditSt, 80);
    FixRealPrim(S, IntlSupport.DecimalChar);                           {!!.16}
    Val(S, E, Code);
    if Code <> 0 then
      Result := oeInvalidNumber
    else if (E < efRangeLo.rtExt) or (E > efRangeHi.rtExt) then
      Result := oeRangeError
    else begin
      if sefHaveFocus in sefOptions then
        if not (sefGettingValue in sefOptions) then begin
          D := E;
          efTransfer(@D, otf_SetData);
          Invalidate;
        end;
    end;
  end;

  procedure ValidateSingle;
  var
    E    : Extended;
    Si   : Single;
    Code : Integer;
  begin
    {convert efEditSt to an extended}
    StrLCopy(S, efEditSt, 80);
    FixRealPrim(S, IntlSupport.DecimalChar);                           {!!.16}
    Val(S, E, Code);
    if Code <> 0 then
      Result := oeInvalidNumber
    else if (E < efRangeLo.rtExt) or (E > efRangeHi.rtExt) then
      Result := oeRangeError
    else begin
      if sefHaveFocus in sefOptions then
        if not (sefGettingValue in sefOptions) then begin
          Si := E;
          efTransfer(@Si, otf_SetData);
          Invalidate;
        end;
    end;
  end;

  procedure ValidateComp;
  var
    E    : Extended;
    C    : Comp;
    Code : Integer;
  begin
    {convert efEditSt to an extended}
    StrLCopy(S, efEditSt, 80);
    FixRealPrim(S, IntlSupport.DecimalChar);                           {!!.16}
    Val(S, C, Code);
    E := C;
    if Code <> 0 then
      Result := oeInvalidNumber
    else if (E < efRangeLo.rtExt) or (E > efRangeHi.rtExt) then
      Result := oeRangeError
    else begin
      if sefHaveFocus in sefOptions then
        if not (sefGettingValue in sefOptions) then begin
          efTransfer(@C, otf_SetData);
          Invalidate;
        end;
    end;
  end;

begin
  Result := 0;
  case FSimpleDataType of
    sftString   : ValidateString;
    sftChar     : ValidateChar;
    sftBoolean  : ValidateBoolean;
    sftYesNo    : ValidateYesNo;
    sftLongInt  : ValidateLongInt;
    sftWord     : ValidateWord;
    sftInteger  : ValidateInteger;
    sftByte     : ValidateByte;
    sftShortInt : ValidateShortInt;
    sftReal     : ValidateReal;
    sftExtended : ValidateExtended;
    sftDouble   : ValidateDouble;
    sftSingle   : ValidateSingle;
    sftComp     : ValidateComp;
  end;

  if not (sefUserValidating in sefOptions) then begin
    {user may retrieve data from field. flag that we are doing}
    {user validation to avoid calling this routine recursively}
    Include(sefOptions, sefUserValidating);
    DoOnUserValidation(Result);
    Exclude(sefOptions, sefUserValidating);
  end;
end;

procedure TOvcCustomSimpleField.sfSetDataType(Value : TSimpleDataType);
  {-set the data type for this field}
begin
  if FSimpleDataType <> Value then begin
    FSimpleDataType := Value;
    efDataType := sfGetDataType(FSimpleDataType);
    CaretToEnd := sfDefCaretToEnd;
    InsertPushes := sfDefInsertPushes;
    efSetDefaultRange(efDataType);

    {set defaults for this field type}
    sfResetFieldProperties(FSimpleDataType);
    if HandleAllocated then begin
      {don't save data through create window}
      efSaveData := False;
      RecreateWnd;
    end;
  end;
end;

procedure TOvcCustomSimpleField.sfSetPictureMask(Value: AnsiChar);
  {-set the picture mask}
var
  Buf : array[0..1] of AnsiChar;
begin
  if FPictureMask <> Value then begin
    if Value in SimplePictureChars then begin
      FPictureMask := Value;
      if csDesigning in ComponentState then begin
        efPicture[0] := Value;
        efPicture[1] := #0;
        Repaint;
      end else begin
        Buf[0] := Value;
        Buf[1] := #0;
        efChangeMask(Buf);
        RecreateWnd;
      end;
    end else
      raise EInvalidPictureMask.Create(Value);
  end;
end;

function TOvcCustomSimpleField.sfGetDataType(Value : TSimpleDataType) : Byte;
  {-return a Byte value representing the type of this field}
begin
  case Value of
    sftString    : Result := fidSimpleString;
    sftChar      : Result := fidSimpleChar;
    sftBoolean   : Result := fidSimpleBoolean;
    sftYesNo     : Result := fidSimpleYesNo;
    sftLongInt   : Result := fidSimpleLongInt;
    sftWord      : Result := fidSimpleWord;
    sftInteger   : Result := fidSimpleInteger;
    sftByte      : Result := fidSimpleByte;
    sftShortInt  : Result := fidSimpleShortInt;
    sftReal      : Result := fidSimpleReal;
    sftExtended  : Result := fidSimpleExtended;
    sftDouble    : Result := fidSimpleDouble;
    sftSingle    : Result := fidSimpleSingle;
    sftComp      : Result := fidSimpleComp;
  else
    raise EOvcException.Create(GetOrphStr(SCInvalidParamValue));
  end;
end;

{!!.10} {revised}
procedure TOvcCustomSimpleField.sfResetFieldProperties(FT : TSimpleDataType);
  {-reset field properties based on current setings}

  procedure Update(Len: Word; Mask: AnsiChar);
  begin
    MaxLength := Len;
    FPictureMask := Mask;
    efPicture[0] := Mask;
    efPicture[1] := #0;
    DecimalPlaces := 0;
  end;

begin
  case FT of
    sftString    : Update(15, pmAnyChar);
    sftBoolean   : Update(1, pmTrueFalse);
    sftYesNo     : Update(1, pmYesNo);
    sftChar      : Update(1, pmAnyChar);
    sftLongInt   : Update(8, pmWhole);
    sftWord      : Update(5, pmPositive);
    sftInteger   : Update(5, pmWhole);
    sftByte      : Update(3, pmPositive);
    sftShortInt  : Update(4, pmWhole);
    sftReal      : Update(14, pmDecimal);
    sftExtended  : Update(14, pmDecimal);
    sftDouble    : Update(14, pmDecimal);
    sftSingle    : Update(14, pmDecimal);
    sftComp      : Update(14, pmWhole);
  else
    raise EOvcException.Create(GetOrphStr(SCInvalidParamValue));
  end;
end;

procedure TOvcCustomSimpleField.sfSetDefaultRanges;
  {-set default range values based on the field type}
begin
  case FSimpleDataType of
    sftChar, sftBoolean, sftYesNo :
      if efRangeLo.rtChar = efRangeHi.rtChar then
        efSetDefaultRange(efDataType);
    sftLongInt, sftWord, sftInteger, sftByte, sftShortInt :
      if efRangeLo.rtLong = efRangeHi.rtLong then
        efSetDefaultRange(efDataType);
    sftReal :
      if efRangeLo.rtReal = efRangeHi.rtReal then
        efSetDefaultRange(efDataType);
    sftExtended, sftDouble, sftSingle, sftComp :
      if efRangeLo.rtExt = efRangeHi.rtExt then
        efSetDefaultRange(efDataType);
  else
    efSetDefaultRange(efDataType);
  end;
end;



end.