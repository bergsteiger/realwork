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
{*                    OVCPF.PAS 2.17                     *}
{*     Copyright 1995-98 (c) TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcPF;
  {-Picture field component}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, Controls, Forms, Graphics, Menus, Messages, SysUtils,
  OvcBase, OvcCaret, OvcColor, OvcConst, OvcCmd,
  OvcData, OvcEf, OvcExcpt, OvcMisc, OvcPb, OvcStr, STDate;

type
  {picture field types}
  TPictureDataType   = (
    pftString, pftChar, pftBoolean, pftYesNo, pftLongInt,
    pftWord, pftInteger, pftByte, pftShortInt, pftReal, pftExtended,
    pftDouble, pftSingle, pftComp, pftDate, pftTime);

const
  pfDefCaretToEnd      = True;
  pfDefInitDateTime    = False;
  pfDefInsertPushes    = True;
  pfDefPictureDataType = pftString;
  pfDefPictureMask     = 'XXXXXXXXXXXXXXX';
  pfDefParentColor     = False;
  pfDefTabStop         = True;


type
  TOvcCustomPictureField = class(TOvcPictureBase)
  {.Z+}
  protected {private}
    {property instance variables}
    FInitDateTime     : Boolean;
    FPictureDataType  : TPictureDataType;
    FPictureMask      : string;

    {property methods}
    procedure SetInitDateTime(Value : Boolean);
      {-set the InitDateTime property}

    {internal methods}
    function pfGetDataType(Value : TPictureDataType) : Byte;
      {-return a Byte value representing the type of this field}
    procedure pfResetFieldProperties(FT : TPictureDataType);
      {-reset field properties}
    procedure pfSetDefaultRanges;
      {-set default range values based on the field type}

  protected
    procedure CreateParams(var Params : TCreateParams);
      override;
    procedure CreateWnd;
      override;

    procedure efEdit(var Msg : TMessage; Cmd : Word);
      override;
      {-process the specified editing command}
    procedure efIncDecValue(Wrap : Boolean; Delta : Double);
      override;
      {-increment field by Delta}
    function efTransfer(DataPtr : Pointer; TransferFlag : Word) : Word;
      override;
      {-transfer data to/from the entry fields}

    {virtual property methods}
    procedure pfSetDataType(Value : TPictureDataType);
      virtual;
      {-set the data type for this field}
    procedure pfSetPictureMask(const Value : string);
      virtual;
      {-set the picture mask}
    procedure SetAsString(const Value : string);
      {-sets the field value to a String Value}
      override;

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
    property DataType : TPictureDataType
      read FPictureDataType
      write pfSetDataType
      default pfDefPictureDataType;

    property InitDateTime : Boolean
      read FInitDateTime
      write SetInitDateTime
      default pfDefInitDateTime;

    property PictureMask : string
      read FPictureMask
      write pfSetPictureMask;

  published
  end;

  TOvcPictureField = class(TOvcCustomPictureField)
  published
    {inherited properties}
    property DataType;            {needs to load before most other properties}
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
    property Controller;
    property ControlCharColor;
    property Ctl3D;
    property DecimalPlaces;
    property DisabledColors;                                           {!!.12}
    property DragCursor;
    property DragMode;
    property Enabled;
    property Epoch;
    property ErrorColors;
    property Font;
    property ForceInsert;
    property ForceOvertype;
    property HighlightColors;
    property InitDateTime;
    property InputRequired;
    property InsertPushes;
    property MaxLength;
    property PadChar;
    property ParentColor default pfDefParentColor;
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
    property RightJustify;
    property ShowHint;
    property SoftValidation;
    property StripLiterals;
    property TabOrder;
    property TabStop default pfDefTabStop;
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


{*** TOvcCustomPictureField ***}

procedure TOvcCustomPictureField.Assign(Source : TPersistent);
var
  PF : TOvcCustomPictureField absolute Source;
begin
  if (Source <> nil) and (Source is TOvcCustomPictureField) then begin
    DataType             := PF.DataType;
    AutoAdvanceChar      := PF.AutoAdvanceChar;
    AutoAdvanceLeftRight := PF.AutoAdvanceLeftRight;
    AutoAdvanceUpDown    := PF.AutoAdvanceUpDown;
    AutoSelect           := PF.AutoSelect;
    AutoSize             := PF.AutoSize;
    BeepOnError          := PF.BeepOnError;
    BorderStyle          := PF.BorderStyle;
    CaretToEnd           := PF.CaretToEnd;
    Color                := PF.Color;
    ControlCharColor     := PF.ControlCharColor;
    DecimalPlaces        := PF.DecimalPlaces;
    Epoch                := PF.Epoch;
    ErrorColors.Assign(PF.ErrorColors);
    ForceInsert          := PF.ForceInsert;
    ForceOvertype        := PF.ForceOvertype;
    HighlightColors.Assign(PF.HighlightColors);
    InitDateTime         := PF.InitDateTime;
    InputRequired        := PF.InputRequired;
    InsertPushes         := PF.InsertPushes;
    MaxLength            := PF.MaxLength;
    PadChar              := PF.PadChar;
    PasswordChar         := PF.PasswordChar;
    PasswordMode         := PF.PasswordMode;
    PictureMask          := PF.PictureMask;
    RangeHi              := PF.RangeHi;
    RangeLo              := PF.RangeLo;
    ReadOnly             := PF.ReadOnly;
    RightJustify         := PF.RightJustify;
    SoftValidation       := PF.SoftValidation;
    StripLiterals        := PF.StripLiterals;
    TextMargin           := PF.TextMargin;
    TrimBlanks           := PF.TrimBlanks;
    Uninitialized        := PF.Uninitialized;
    ZeroDisplay          := PF.ZeroDisplay;
    ZeroDisplayValue     := PF.ZeroDisplayValue;
  end else
    inherited Assign(Source);
end;

constructor TOvcCustomPictureField.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FInitDateTime    := pfDefInitDateTime;
  FPictureDataType := pfDefPictureDataType;
  FPictureMask     := pfDefPictureMask;

  efFieldClass     := fcPicture;
  efDataType       := pfGetDataType(FPictureDataType);
end;

procedure TOvcCustomPictureField.CreateParams(var Params: TCreateParams);
begin
  {get current picture string}
  StrPLCopy(efPicture, FPictureMask, MaxPicture);
  inherited CreateParams(Params);

  pfSelPos := 0;

  {set efMaxLen based on picture mask}
  if MaxLength < StrLen(efPicture) then
    MaxLength := StrLen(efPicture);
end;

procedure TOvcCustomPictureField.CreateWnd;
var
  P : array[0..MaxEditLen+1] of Byte;
begin
  {save field data}
  if efSaveData then
    efTransfer(@P, otf_GetData);

  inherited CreateWnd;

  {try to optimize InitPictureFlags}
  pbOptimizeInitPictureFlags;

  pfSetDefaultRanges;
  efSetInitialValue;

  {set initial field value}
  if not efSaveData and FInitDateTime then begin
    if DataType = pftDate then
      AsStDate := CurrentDate;                                         {!!.01}
    if DataType = pftTime then
      AsStTime := CurrentTime;                                         {!!.01}
  end;

  {if we saved the field data, restore it}
  if efSaveData then
    efTransfer(@P, otf_SetData);

  {set save data flag}
  efSaveData := True;
end;

procedure TOvcCustomPictureField.efEdit(var Msg : TMessage; Cmd : Word);
  {-process the specified editing command}

  procedure EditPicture(var Msg : TMessage; Cmd : Word);
    {-process the specified editing command}
  label
    ExitPoint;
  var
    DotPos      : Cardinal;
    SaveSelPos  : Integer;
    SaveHPos    : Word;
    StLen       : Word;
    StBgn       : Word;
    StEnd       : Word;
    HTemp       : Word;
    MF          : ShortInt;
    Literal     : Boolean;
    HaveSel     : Boolean;
    SelExtended : Boolean;
    Found       : Boolean;
    Ch          : AnsiChar;

    procedure RePadPrim(Start, Stop : Word);
      {-pad from Start to Stop with blanks}
    var
      I : Word;
    begin
      for I := Start to Stop do
        if not pbIsLiteral(I) then
          efEditSt[I] := ' ';
    end;

    procedure RePad;
      {-pad to the end of the string with blanks}
    begin
      RepadPrim(efHPos, StEnd);
      StLen := pbCalcLength;
    end;

    function StartOfSubField : Word;
      {-find the start of the current subfield}
    begin
      Result := efHPos;
      while (Result > StBgn) and not pbIsLiteral(Result - 1) do
        Dec(Result);
    end;

    function EndOfSubField : Word;
      {-find the end of the current subfield}
    begin
      Result := efHPos;
      while (Result < StEnd) and not pbIsLiteral(Result + 1) do
        Inc(Result);
    end;

    function CharIsOK : Boolean;
      {-return true if Ch can be added to the string}
    var
      PicChar : AnsiChar;
      PrevCh  : AnsiChar;
      I       : Word;
    begin
      if efIsNumericType then
        if Ch = IntlSupport.DecimalChar then
          Ch := pmDecimalPt
        else if Ch = pmDecimalPt then
          Ch := #0;
      if (Ch < ' ') and not Literal then begin
        Result := False;
        Exit;
      end;
      I := efHPos;
      PicChar := efNthMaskChar(I);
      case PicChar of
        pmComma, pmFloatDollar :
          PicChar := efNthMaskChar(StEnd);
      end;
      if efHPos = StartOfSubField then
        PrevCh := ' '
      else
        PrevCh := efEditSt[efHPos-1];
      Result := efCharOK(PicChar, Ch, PrevCh, True);
      if efIsNumericType and (Ch = pmDecimalPt) then
        Ch := IntlSupport.DecimalChar;
    end;

    function CheckAutoAdvance(SP : Integer) : Boolean;
      {-see if we need to auto-advance to next/previous field}
    begin
      Result := False;
      if (SP < StBgn) and AutoAdvanceLeftRight then begin
        efMoveFocusToPrevField;
        Result := True;
      end else if (SP > StEnd) then
        if (Cmd = ccChar) and AutoAdvanceChar then begin
          efMoveFocusToNextField;
          Result := True;
        end else if (Cmd <> ccChar) and AutoAdvanceLeftRight then begin
          efMoveFocusToNextField;
          Result := True;
        end;
    end;

    procedure DeleteChar;
      {-delete char at efEditSt[efHPos]}
    begin
      StrStDeletePrim(efEditSt, efHPos, 1);
      StrChInsertPrim(efEditSt, ' ', EndOfSubField);
      StLen := pbCalcLength;
    end;

    procedure DeleteWord;
      {-delete the word to the right of the caret}
    var
      I, J, Delta : Word;
    begin
      {delete all of the current word, if any}
      J := EndOfSubField;
      I := efHPos;
      while (I <= J) and (efEditSt[I] <> ' ') do
        Inc(I);

      {delete any spaces prior to the next word, if any}
      while (I <= J) and (efEditSt[I] = ' ') do
        Inc(I);
      Delta := I-efHPos;
      if Delta > 0 then begin
        StrStDeletePrim(efEditSt, efHPos, Delta);
        StrInsertChars(efEditSt, ' ', J-Pred(Delta), Delta);
        MF := 10;
      end;
    end;

    procedure WordRight;
      {-caret right one word}
    var
      I : Word;
    begin
      if (efHPos < StLen) then begin
        if (efEditSt[efHPos] <> ' ') then
          Inc(efHPos);
        I := EndOfSubField;
        while (efHPos <= I) and (efEditSt[efHPos] <> ' ') do
          Inc(efHPos);
        while (efHPos <= I) and (efEditSt[efHPos] = ' ') do
          Inc(efHPos);

        if efHPos >= StEnd then
          efHPos := StLen
        else
          while pbIsLiteral(efHPos) do
            Inc(efHPos);
      end else begin
        efHPos := EndOfSubField+1;
        if (efHPos >= StEnd) then begin
          CheckAutoAdvance(efHPos);
          Dec(efHPos);
        end else
          while (efHPos <= StEnd) and pbIsLiteral(efHPos) do
            Inc(efHPos);
      end;
    end;

    procedure WordLeft;
      {-caret left one word}
    var
      I : Word;
    begin
      if (efHPos = StBgn) then
        CheckAutoAdvance(-1)
      else begin
        Dec(efHPos);
        while pbIsLiteral(efHPos) do
          Dec(efHPos);

        I := StartOfSubField;
        while (efHPos >= I) and ((efHPos+1 > StLen) or (efEditSt[efHPos] = ' ')) do
          Dec(efHPos);
        while (efHPos >= I) and (efEditSt[efHPos] <> ' ') do
          Dec(efHPos);
        Inc(efHPos);
      end;
    end;

    procedure DeleteToEnd;
      {-delete from caret to end of subfield}
    var
      I, Delta : Word;
    begin
      I := EndOfSubField;
      if efHPos = I then
        Exit;

      Delta := Succ(I-efHPos);
      StrStDeletePrim(efEditSt, efHPos, Delta);
      StrInsertChars(efEditSt, ' ', efHPos, Delta);
      MF := 10;
    end;

    procedure DeleteToBegin;
      {-delete from beginning of subfield to the caret}
    var
      I, J, Delta : Word;
    begin
      I := StartOfSubField;
      if efHPos = I then
        Exit;

      J := EndOfSubField;
      Delta := efHPos-I;
      StrStDeletePrim(efEditSt, I, Delta);
      if Succ(J-Delta) >= LongInt(StrLen(efEditSt)) then begin         {!!.D4}
        StrCat(efEditSt, ' ');
        if Delta > 1 then
          StrInsertChars(efEditSt, ' ', Succ(J-Delta), Delta-1);
      end else
        StrInsertChars(efEditSt, ' ', Succ(J-Delta), Delta);
      efHPos := I;
      MF := 10;
    end;

    procedure CaretLeft;
      {-move caret back one position}
    begin
      Dec(efHPos);
      while pbIsLiteral(efHPos) do
        Dec(efHPos);
    end;

    procedure CaretRight;
      {-advance caret one position}
    begin
      Inc(efHPos);
      while (efHPos <= StEnd) and pbIsLiteral(efHPos) do
        Inc(efHPos);
    end;

    procedure InsertChar(Beep : Boolean);
      {-insert Ch at efEditSt[efHPos]}
    begin
      if not InsertPushes then
        if efEditSt[EndOfSubField] <> ' ' then begin
          if Beep then
            efConditionalBeep;
          Exit;
        end;

      if not pbIsLiteral(efHPos+1) then begin
        StrStDeletePrim(efEditSt, EndOfSubField, 1);
        StrChInsertPrim(efEditSt, Ch, efHPos);
      end else
        efEditSt[efHPos] := Ch;
      MF := 10;
      CaretRight;
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
      if efSelStart = SaveSelPos then
        efSelStart := pfSelPos
      else
        efSelEnd := pfSelPos;
      FixSelValues;
    end;

    procedure DeleteSel;
    var
      I, J, Delta : Word;
    begin
      if (efSelEnd < StBgn) or (efSelStart > StEnd) then
        Exit;

      {delete the selection}
      RepadPrim(efSelStart, efSelEnd-1);
      efHPos := efSelEnd;
      while pbIsLiteral(efHPos) do
        Dec(efHPos);
      I := StartOfSubField;
      if I > efSelStart then
        DeleteToBegin
      else if efSelStart < efHPos then begin
        J := EndOfSubField;
        Delta := efHPos-efSelStart;
        StrStDeletePrim(efEditSt, efSelStart, Delta);
        StrInsertChars(efEditSt, ' ', J-Pred(Delta), Delta);
      end;

      {recalc length}
      StLen := pbCalcLength;

      {reposition caret}
      efHPos := efSelStart;
      if efHPos < StBgn then
        efHPos := StBgn
      else while pbIsLiteral(efHPos) do
        Inc(efHPos);
      efSelStart := efHPos;
      efSelEnd := efHPos;
      pfSelPos := efHPos;
      MF := 10;
    end;

    procedure PastePrim(P : PChar);
    var
      I, J  : Integer;
      IsNum : Boolean;

      function Nth(N : Integer) : AnsiChar;
      var
        Ch : AnsiChar;
      begin
        Ch := efNthMaskChar(N);
        case Ch of
          pmComma, pmFloatDollar :
            Result := efNthMaskChar(StEnd);
          Subst1..Subst8 :
            Result := UserData.SubstChars[Ch];
          else
            Result := Ch;
        end;
      end;

      function IsLit(N, I : Integer) : Boolean;
      begin
        Result := ((N < pfSemiLits) and (P[I] = ' ')) or
                   (pbIsLiteral(N) and (P[I] = Nth(J)));
      end;

    begin
      I := 0;
      J := efSelStart;
      if HaveSel then
        DeleteSel;
      while (P[I] <> #0) and IsLit(J, I) do begin
        Inc(I);
        Inc(J);
      end;
      IsNum := efIsNumericType or pbIsNumber;
      while (P[I] <> #0) and (efHPos <= StEnd) do begin
        Ch := P[I];
        if IsNum and (Ch = ' ') then
          Ch := #0;
        if Found then
          if Ch = IntlSupport.DecimalChar then
            if efHPos > LongInt(DotPos) then                           {!!.D4}
              Ch := #0
            else begin
              pbFixNumber(DotPos, StBgn, StEnd, True, False);
              efHPos := DotPos + 1;
              Ch := #0;
            end
          else if Ch = pmDecimalPt then
            Ch := #0;

        J := efHPos;
        if efCharOK(Nth(efHPos), Ch, #255, True) then
          InsertChar(False);
        Inc(I);
        Inc(J);
        while (P[I] <> #0) and pbIsLiteral(J) and (P[I] = Nth(J)) do begin
          Inc(I);
          Inc(J);
        end;
      end;
    end;

    procedure ExtSelWordLeft(var Sel : Integer);
    begin
      while (Sel > 0) and (efEditSt[Sel] = ' ') do
        Dec(Sel);
      while (Sel > 0) and (efEditSt[Sel-1] <> ' ') do
        Dec(Sel);
    end;

    procedure ExtSelWordRight(var Sel : Integer);
    begin
      while (Sel < MaxLength) and (efEditSt[Sel] <> ' ') do
        Inc(Sel);
      while (Sel < MaxLength) and (efEditSt[Sel] = ' ') do
        Inc(Sel);
    end;

    procedure SyncCaret(Bias : Integer);
    begin
      efHPos := pfSelPos;
      if efHPos < StBgn then
        efHPos := StBgn
      else if efHPos > StEnd then
        efHPos := StEnd+1
      else while pbIsLiteral(efHPos) do
        Inc(efHPos, Bias);
    end;

    procedure NextSubField;
      {-move caret right to the next subfield}
    var
      I : Word;
    begin
      if (efHPos < StLen) then begin
        I := EndOfSubField;
        while efHPos <= I do
          Inc(efHPos);
        if efHPos >= StEnd then
          efHPos := StLen
        else
          while pbIsLiteral(efHPos) do
            Inc(efHPos);
      end else begin
        efHPos := EndOfSubField+1;
        if (efHPos >= StEnd) then begin
          CheckAutoAdvance(efHPos);
          Dec(efHPos);
        end else
          while (efHPos <= StEnd) and pbIsLiteral(efHPos) do
            Inc(efHPos);
      end;
    end;

    procedure CompleteDateSubField;
    var
      CompleteAll : Boolean;
      S           : Word;
      E           : Word;
      P           : TeditString;
    begin
      {if field is completely highlighted, supply complete date}
      CompleteAll := False;
      if HaveSel then begin
        if (efSelStart = 0) and (efSelEnd = MaxLength) then
          CompleteAll := True
        else begin
          {move to start of selection}
          efHPos := efSelStart;
          while pbIsLiteral(efHPos) do
            Inc(efHPos);
          if efHPos < StBgn then
            efHPos := StBgn
        end;
      end;

      {get current date string}
      IntlSupport.DateToDatePChar(P, efPicture, CurrentDate, False);

      if CompleteAll then begin
        StrCopy(efEditSt, P);
        efCaretToEnd;
      end else begin
        {get position within the field}
        S := StartOfSubField;
        E := EndOfSubField;
        StrStDeletePrim(efEditSt, S, E-S+1);
        P[E+1] := #0;
        StrStInsertPrim(efEditSt, @P[S], S);
      end;
      {reclac length}
      StLen := pbCalcLength;

      NextSubField;
      MF := 10;
    end;

    procedure CompleteTimeSubField;
    var
      CompleteAll : Boolean;
      S           : Word;
      E           : Word;
      P           : TEditString;
    begin
      {if field is completely highlighted, supply complete time}
      CompleteAll := False;
      if HaveSel then begin
        if (efSelStart = 0) and (efSelEnd = MaxLength) then
          CompleteAll := True
        else begin
          {move to start of selection}
          efHPos := efSelStart;
          while pbIsLiteral(efHPos) do
            Inc(efHPos);
          if efHPos < StBgn then
            efHPos := StBgn
        end;
      end;

      {get current time string}
      IntlSupport.TimeToTimePChar(P, efPicture, CurrentTime, False);

      if CompleteAll then begin
        StrCopy(efEditSt, P);
        efCaretToEnd;
      end else begin
        {get position within the field}
        S := StartOfSubField;
        E := EndOfSubField;
        StrStDeletePrim(efEditSt, S, E-S+1);
        P[S+(E-S+1)] := #0;
        StrStInsertPrim(efEditSt, @P[S], S);
      end;

      {reclac length}
      StLen := pbCalcLength;

      NextSubField;
      MF := 10;
    end;

  begin
    HaveSel := efSelStart <> efSelEnd;
    MF := Ord(HaveSel);
    SaveSelPos := pfSelPos;
    SaveHPos := efHPos;
    SelExtended := False;

    case Cmd of
      ccAccept : ;
      ccCtrlChar :
        Include(sefOptions, sefLiteral);
    else
      if not (sefFixSemiLits in sefOptions) then begin
        pbRemoveSemiLits;
        if sefFixSemiLits in sefOptions then
          Invalidate;
      end;
      if Cmd <> ccChar then
        Exclude(sefOptions, sefLiteral);
    end;

    StBgn := efEditBegin;
    StEnd := efEditEnd;
    StLen := pbCalcLength;

    {get position of decimal point, if any}
    Found := StrChPos(efPicture, pmDecimalPt, DotPos);
    if DotPos > StEnd then
      Found := False;

    Exclude(sefOptions, sefCharOK);
    case Cmd of
      ccChar :
        begin
          Ch := AnsiChar(Lo(Msg.wParam));
          Literal := sefLiteral in sefOptions;
          Exclude(sefOptions, sefLiteral);
          if not (sefAcceptChar in sefOptions) then
            Exit
          else begin
            Exclude(sefOptions, sefAcceptChar);
            if HaveSel and CharIsOk then
              DeleteSel;
            if Found and (Ch = IntlSupport.DecimalChar) then begin
              pbFixNumber(DotPos, StBgn, StEnd, True, False);
              Inc(MF);
              efHPos := DotPos + 1;
            end else if efHPos <= StEnd then
              if not CharIsOK then
                efConditionalBeep
              else begin
                if sefInsert in sefOptions then
                  {insert mode}
                  InsertChar(True)
                else begin
                  {overtype mode}
                  efEditSt[efHPos] := Ch;
                  CaretRight;
                  MF := 10;
                end;
                CheckAutoAdvance(efHPos);
              end
            else
              if not CheckAutoAdvance(efHPos) then
                efConditionalBeep;
          end;
        end;
      ccMouse :
        begin
          pfSelPos := efGetMousePos(SmallInt(Msg.lParamLo));

          {drag highlight initially if shift key is being pressed}
          if (GetKeyState(vk_Shift) < 0) then begin
            SelExtended := True;
            if HaveSel then begin
              if pfSelPos > efSelStart then
                efSelEnd := pfSelPos
              else
                efSelStart := pfSelPos;
            end else begin
              efSelStart := SaveHPos;
              efSelEnd := pfSelPos;
            end;
            FixSelValues;
            if pfSelPos < SaveSelPos then
              SyncCaret(+1)
            else
              SyncCaret(-1);
          end else begin
            efSelStart := pfSelPos;
            efSelEnd := pfSelPos;
            SyncCaret(+1);

            {if the caret was placed past the end of the field,
             move it to last position containing data}
            HTemp := pbCalcLength;
            while (HTemp < StEnd) and pbIsLiteral(HTemp) do
              Inc(HTemp);
            if HTemp < efHPos then
              efHPos := HTemp;

            efPositionCaret(False);
          end;
        end;
      ccMouseMove :
        begin
          pfSelPos := efGetMousePos(SmallInt(Msg.lParamLo));
          UpdateSel;
          if pfSelPos < SaveSelPos then
            SyncCaret(+1)
          else
            SyncCaret(-1);

          {if caret was placed past the end of the field,
           move it to last position containing data}
          if (efSelStart = efSelEnd) then begin
            HTemp := pbCalcLength;
            while (HTemp < StEnd) and pbIsLiteral(HTemp) do
              Inc(HTemp);
            if HTemp < efHPos then
              efHPos := HTemp;
          end;

        end;
      ccDblClk :
        begin
          {if floating point field, select all}                        {!!.15}
          if (efDataType mod fcpDivisor) in                            {!!.15}
             [fsubReal, fsubExtended, fsubDouble, fsubSingle] then     {!!.15}
            SetSelection(0, MaxEditLen)                                {!!.15}
          else begin                                                   {!!.15}
            efSelStart := efGetMousePos(SmallInt(Msg.lParamLo));
            if efSelStart >= MaxLength then
              efSelStart := MaxLength-1;
            efSelEnd := efSelStart;
            ExtSelWordLeft(efSelStart);
            ExtSelWordRight(efSelEnd);
          end;                                                         {!!.15}
          pfSelPos := efSelEnd;
          SyncCaret(-1);
        end;
      ccLeft :
        if efHPos > StBgn then
          CaretLeft
        else
          CheckAutoAdvance(-1);
      ccRight :
        if efHPos <= StEnd then
          CaretRight
        else
          CheckAutoAdvance(StEnd+1);
      ccUp :
        if AutoAdvanceUpDown then
          efMoveFocusToPrevField
        else if ArrowIncDec and not ReadOnly then              {!!.10}{!!.14}
          IncreaseValue(True, 1)                                      {!!.10}
        else if efHPos > StBgn then
          CaretLeft
        else
          CheckAutoAdvance(-1);
      ccDown :
        if AutoAdvanceUpDown then
          efMoveFocusToNextField
        else if ArrowIncDec and not ReadOnly then              {!!.10}{!!.14}
          DecreaseValue(True, 1)                                      {!!.10}
        else if efHPos <= StEnd then
          CaretRight
        else
          CheckAutoAdvance(StEnd+1);
      ccWordLeft :
        WordLeft;
      ccWordRight :
        WordRight;
      ccHome :
        efHPos := StBgn;
      ccEnd :
        efCaretToEnd;
      ccExtendLeft :
        if pfSelPos > 0 then begin
          Dec(pfSelPos);
          SyncCaret(+1);
          UpdateSel;
        end else
          MF := -1;
      ccExtendRight :
        if pfSelPos < MaxLength then begin
          Inc(pfSelPos);
          SyncCaret(-1);
          UpdateSel;
        end else
          MF := -1;
      ccExtendHome :
        begin
          pfSelPos := 0;
          efHPos := StBgn;
          UpdateSel;
        end;
      ccExtendEnd :
        begin
          efCaretToEnd;
          pfSelPos := MaxLength+1;
          UpdateSel;
        end;
      ccExtWordLeft :
        if pfSelPos > 0 then begin
          Dec(pfSelPos);
          ExtSelWordLeft(pfSelPos);
          UpdateSel;
          SyncCaret(+1);
        end else
          MF := -1;
      ccExtWordRight :
        if pfSelPos < MaxLength then begin
          Inc(pfSelPos);
          ExtSelWordRight(pfSelPos);
          UpdateSel;
          SyncCaret(-1);
        end else
          MF := -1;
      ccCut :
        if HaveSel then
          DeleteSel;
      ccCopy : {} ;
      ccPaste :
        PastePrim(PChar(Msg.lParam));
      ccBack :
        if HaveSel then
          DeleteSel
        else if efHPos > StBgn then begin
          Dec(efHPos);
          while pbIsLiteral(efHPos) do
            Dec(efHPos);
          if efHPos < StLen then begin
            DeleteChar;
            MF := 10;
          end;
        end;
      ccDel :
        if HaveSel then
          DeleteSel
        else if efHPos < StLen then begin
          DeleteChar;
          MF := 10;
        end;
      ccDelWord :
        if HaveSel then
          DeleteSel
        else if efHPos < StLen then
          DeleteWord;
      ccDelLine :
        begin
          efCaretToStart;
          Repad;
          MF := 10;
        end;
      ccDelEol :
        DeleteToEnd;
      ccDelBol :
        DeleteToBegin;
      ccIns :
        begin
          if sefInsert in sefOptions then
            Exclude(sefOptions, sefInsert)
          else
            Include(sefOptions, sefInsert);
          efCaret.InsertMode := (sefInsert in sefOptions);
        end;
      ccRestore :
        begin
          Restore;
          Exclude(sefOptions, sefFixSemiLits);
        end;
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
      ccCompleteDate :
        if DataType = pftDate then
          CompleteDateSubField;
      ccCompleteTime :
        if DataType = pftTime then
          CompleteTimeSubField;
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
      pfSelPos := efHPos;
    end;

ExitPoint:
    {see if we need to fix a number}
    if Found then begin
      if (SaveHPos < LongInt(DotPos)) and (efHPos > LongInt(DotPos)) then begin{!!.D4}
        pbFixNumber(DotPos, StBgn, StEnd, True, False);
        Inc(MF);
      end else if (SaveHPos > LongInt(DotPos)) and (efHPos < LongInt(DotPos)) then begin{!!.D4}
        pbFixNumber(DotPos, StBgn, StEnd, False, True);
        Inc(MF);
      end;
    end;

    if efPositionCaret(True) then
      Inc(MF);
    if MF >= 10 then
      efFieldModified;
    if MF > 0 then
      Invalidate;
  end;

  procedure EditChar(var Msg : TMessage; Cmd : Word);
  label
    ExitPoint;
  var
    Ch         : AnsiChar;
    Literal    : Boolean;
    StBgn      : Word;
    SaveSelPos : Integer;
    MF         : ShortInt;

    function CharIsOK : Boolean;
      {-return true if Ch can be added to the string}
    begin
      if (Ch < ' ') and not Literal then
        Result := False
      else
        Result := efCharOK(efNthMaskChar(StBgn), Ch, ' ', True);
    end;

    function CheckAutoAdvance(SP : Integer) : Boolean;
      {-see if we need to auto-advance to next/previous field}
    begin
      Result := False;
      if (SP < StBgn) and AutoAdvanceLeftRight then begin
        efMoveFocusToPrevField;
        Result := True;
      end else if (SP > StBgn) then
        if (Cmd = ccChar) and AutoAdvanceChar then begin
          efMoveFocusToNextField;
          Result := True;
        end else if (Cmd <> ccChar) and AutoAdvanceLeftRight then begin
          efMoveFocusToNextField;
          Result := True;
        end;
    end;

    procedure UpdateSel;
    var
      I : Integer;
    begin
      if efSelStart = SaveSelPos then
        efSelStart := pfSelPos
      else
        efSelEnd := pfSelPos;
      if efSelStart > efSelEnd then begin
        I := efSelStart;
        efSelStart := efSelEnd;
        efSelEnd := I;
      end;
    end;

    procedure PastePrim(P : PChar);
    begin
      if (StrLen(P) = MaxLength) and (P^ = efEditSt[0]) then
        Inc(P, StBgn);
      while P^ <> #0 do begin
        Ch := P^;
        if efCharOK(efNthMaskChar(StBgn), Ch, #255, True) then begin
          efEditSt[StBgn] := Ch;
          MF := 10;
          Exit;
        end;
        Inc(P);
      end;
    end;

  begin
    MF := Ord(efSelStart <> efSelEnd);
    SaveSelPos := pfSelPos;
    StBgn := efEditBegin;

    case Cmd of
      ccAccept : ;
      ccCtrlChar :
        Include(sefOptions, sefLiteral);
    else
      efHPos := StBgn;
      if Cmd <> ccChar then
        Exclude(sefOptions, sefLiteral);
    end;

    Exclude(sefOptions, sefCharOK);
    case Cmd of
      ccChar :
        begin
          Ch := AnsiChar(Lo(Msg.wParam));
          Literal := sefLiteral in sefOptions;
          if sefAcceptChar in sefOptions then
            if CharIsOK then begin
              efEditSt[StBgn] := Ch;
              CheckAutoAdvance(StBgn+1);
              MF := 10;
            end else
              efConditionalBeep;
          Exclude(sefOptions, sefAcceptChar);
          Exclude(sefOptions, sefLiteral);
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
      ccExtendLeft :
        if pfSelPos > 0 then begin
          Dec(pfSelPos);
          UpdateSel;
        end else
          MF := -1;
      ccExtendRight :
        if pfSelPos < MaxLength then begin
          Inc(pfSelPos);
          UpdateSel;
        end else
          MF := -1;
      ccExtendHome, ccExtWordLeft :
        begin
          pfSelPos := 0;
          UpdateSel;
        end;
      ccExtendEnd, ccExtWordRight :
        begin
          pfSelPos := MaxLength+1;
          UpdateSel;
        end;
      ccPaste :
        PastePrim(PChar(Msg.lParam));
      ccRestore :
        Restore;
      ccAccept :
        begin
          Include(sefOptions, sefCharOK);
          Include(sefOptions, sefAcceptChar);
          Exit;
        end;
      ccMouseMove :
        begin
          pfSelPos := efGetMousePos(SmallInt(Msg.lParamLo));
          UpdateSel;
        end;
      ccDblClk :
        begin
          SetSelection(0, MaxEditLen);
          Inc(MF);
        end;
      ccDec :
        DecreaseValue(True, 1);
      ccInc :
        IncreaseValue(True, 1);
      ccCtrlChar, ccSuppress, ccPartial :
        goto ExitPoint;
      ccMouse, ccDel : ;
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
    else
      efSelStart := efHPos;
      efSelEnd := efHPos;
      pfSelPos := efHPos;
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
  case FPictureDataType of
    pftString,
    pftLongInt,
    pftWord,
    pftInteger,
    pftByte,
    pftShortInt,
    pftReal,
    pftExtended,
    pftDouble,
    pftSingle,
    pftComp,
    pftDate,
    pftTime :
      EditPicture(Msg, Cmd);
    pftChar,
    pftBoolean,
    pftYesNo :
      EditChar(Msg, Cmd);
  end;
end;

procedure TOvcCustomPictureField.efIncDecValue(Wrap : Boolean; Delta : Double);
  {-increment field by Delta}
var
  Code : Integer;
  S    : TEditString;

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
    pbStripPicture(S, efEditSt);
    C := S[0];

    {get mask character}
    MC := efNthMaskChar(efEditBegin);

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
    pbRemoveSemiLits;
    efPerformRepaint(True);
  end;

  procedure IncDecValueBoolean;
  var
    Ch : AnsiChar;
    B  : Boolean;
  begin
    pbStripPicture(S, efEditSt);

    Ch := UpCaseChar(S[0]);
    if Ch = IntlSupport.TrueChar then
      Ch := IntlSupport.FalseChar
    else
      Ch := IntlSupport.TrueChar;
    B := Ch = IntlSupport.TrueChar;

    efTransfer(@B, otf_SetData);
    pbRemoveSemiLits;
    efPerformRepaint(True);
  end;

  procedure IncDecValueYesNo;
  var
    Ch : AnsiChar;
    B  : Boolean;
  begin
    pbStripPicture(S, efEditSt);

    Ch := UpCaseChar(S[0]);
    if Ch = IntlSupport.YesChar then
      Ch := IntlSupport.NoChar
    else
      Ch := IntlSupport.YesChar;
    B := Ch = IntlSupport.YesChar;

    efTransfer(@B, otf_SetData);
    pbRemoveSemiLits;
    efPerformRepaint(True);
  end;

  procedure IncDecValueLongInt;
  var
    L : LongInt;
  begin
    pbStripPicture(S, efEditSt);

    if efStr2Long(S, L) then begin
      if (Delta < 0) and (L <= efRangeLo.rtLong) then
        if Wrap then
          L := efRangeHi.rtLong
        else
          Exit
      else if (Delta > 0) and (L >= efRangeHi.rtLong) then
        if Wrap then
          L := efRangeLo.rtLong
        else
          Exit
      else
        Inc(L, Trunc(Delta));

      {!!.11}
      {insure valid value}
      if L < efRangeLo.rtLong then
        L := efRangeLo.rtLong;
      if L > efRangeHi.rtLong then
        L := efRangeHi.rtLong;

      efTransfer(@L, otf_SetData);
      pbRemoveSemiLits;
      efPerformRepaint(True);
    end;
  end;

  procedure IncDecValueReal;
  var
    Re : Real;
  begin
    {convert efEditSt to a real}
    pbStripPicture(S, efEditSt);

    FixRealPrim(S, pmDecimalPt);                                       {!!.16}
    Val(S, Re, Code);
    if Code = 0 then begin
      if (Delta < 0) and (Re <= efRangeLo.rtReal) then
        if Wrap then
          Re := efRangeHi.rtReal
        else
          Exit
      else if (Delta > 0) and (Re >= efRangeHi.rtReal) then
        if Wrap then
          Re := efRangeLo.rtReal
        else
          Exit
      else
        Re := Re + Delta;

      {!!.11}
      {insure valid value}
      if Re < efRangeLo.rtReal then
        Re := efRangeLo.rtReal;
      if Re > efRangeHi.rtReal then
        Re := efRangeHi.rtReal;

      efTransfer(@Re, otf_SetData);
      pbRemoveSemiLits;
      efPerformRepaint(True);
    end;
  end;

  procedure IncDecValueExtended;
  var
    Ex : Extended;
  begin
    {convert efEditSt to an real}
    pbStripPicture(S, efEditSt);

    FixRealPrim(S, pmDecimalPt);                                       {!!.16}
    Val(S, Ex, Code);
    if Code = 0 then begin
      if (Delta < 0) and (Ex <= efRangeLo.rtExt) then
        if Wrap then
          Ex := efRangeHi.rtExt
        else
          Exit
      else if (Delta > 0) and (Ex >= efRangeHi.rtExt) then
        if Wrap then
          Ex := efRangeLo.rtExt
        else
          Exit
      else
        Ex := Ex + Delta;

      {!!.11}
      {insure valid value}
      if Ex < efRangeLo.rtExt then
        Ex := efRangeLo.rtExt;
      if Ex > efRangeHi.rtExt then
        Ex := efRangeHi.rtExt;

      efTransfer(@Ex, otf_SetData);
      pbRemoveSemiLits;
      efPerformRepaint(True);
    end;
  end;

  procedure IncDecValueDouble;
  var
    Db : Double;
  begin
    {convert efEditSt to an real}
    pbStripPicture(S, efEditSt);

    FixRealPrim(S, pmDecimalPt);                                       {!!.16}
    Val(S, Db, Code);
    if Code = 0 then begin
      if (Delta < 0) and (Db <= efRangeLo.rtExt) then
        if Wrap then
          Db := efRangeHi.rtExt
        else
          Exit
      else if (Delta > 0) and (Db >= efRangeHi.rtExt) then
        if Wrap then
          Db := efRangeLo.rtExt
        else
          Exit
      else
        Db := Db + Delta;

      {!!.11}
      {insure valid value}
      if Db < efRangeLo.rtExt then
        Db := efRangeLo.rtExt;
      if Db > efRangeHi.rtExt then
        Db := efRangeHi.rtExt;

      efTransfer(@Db, otf_SetData);
      pbRemoveSemiLits;
      efPerformRepaint(True);
    end;
  end;

  procedure IncDecValueSingle;
  var
    Si : Single;
  begin
    {convert efEditSt to an real}
    pbStripPicture(S, efEditSt);

    FixRealPrim(S, pmDecimalPt);                                       {!!.16}
    Val(S, Si, Code);
    if Code = 0 then begin
      if (Delta < 0) and (Si <= efRangeLo.rtExt) then
        if Wrap then
          Si := efRangeHi.rtExt
        else
          Exit
      else if (Delta > 0) and (Si >= efRangeHi.rtExt) then
        if Wrap then
          Si := efRangeLo.rtExt
        else
          Exit
      else
        Si := Si + Delta;

      {!!.11}
      {insure valid value}
      if Si < efRangeLo.rtExt then
        Si := efRangeLo.rtExt;
      if Si > efRangeHi.rtExt then
        Si := efRangeHi.rtExt;

      efTransfer(@Si, otf_SetData);
      pbRemoveSemiLits;
      efPerformRepaint(True);
    end;
  end;

  procedure IncDecValueComp;
  var
    Co : Comp;
  begin
    {convert efEditSt to an real}
    pbStripPicture(S, efEditSt);

    FixRealPrim(S, pmDecimalPt);                                       {!!.16}
    Val(S, Co, Code);
    if Code = 0 then begin
      if (Delta < 0) and (Co <= efRangeLo.rtExt) then
        if Wrap then
          Co := efRangeHi.rtExt
        else
          Exit
      else if (Delta > 0) and (Co >= efRangeHi.rtExt) then
        if Wrap then
          Co := efRangeLo.rtExt
        else
          Exit
      else
        Co := Co + Delta;

      {!!.11}
      {insure valid value}
      if Co < efRangeLo.rtExt then
        Co := efRangeLo.rtExt;
      if Co > efRangeHi.rtExt then
        Co := efRangeHi.rtExt;

      efTransfer(@Co, otf_SetData);
      pbRemoveSemiLits;
      efPerformRepaint(True);
    end;
  end;

  procedure IncDecValueDate;
  var
    DV, Min, Max  : TStDate;
    D, M, Y       : Integer;
    Dd, Md, Yd    : Integer;
    Dmn, Mmn, Ymn : Integer;
    Dmx, Mmx, Ymx : Integer;
    C             : AnsiChar;
    P             : Word;
  begin
    {convert string to day/month/year}
    DV := IntlSupport.DatePCharToDate(efPicture, efEditSt, efGetEpoch);
    if DV = BadDate then
      Exit;

    {convert to DMY}
    StDateToDMY(DV, D, M, Y);

    {find out which subfield we're in}
    P := efHPos;
    if pbIsLiteral(P) then
      Dec(P);
    C := efPicture[P];

    {get valid range}
    Min := efRangeLo.rtDate;
    Max := efRangeHi.rtDate;
    if (Max = MinDate) then begin
      Min := MinDate;
      Max := MaxDate;
    end;

    {get min/max years}
    StDateToDMY(Min, Dmn, Mmn, Ymn);
    StDateToDMY(Max, Dmx, Mmx, Ymx);

    {increment the subfield}
    Dd := 0;
    Md := 0;
    Yd := 0;
    case C of
      pmMonthName, pmMonthNameU, pmMonth, pmMonthU :
        Md := Trunc(Delta);
      pmDay, pmDayU :
        Dd := Trunc(Delta);
      pmYear :
        Yd := Trunc(Delta);
    end;
    if Dd <> 0 then
      Inc(DV, Dd)
    else
      DV := IncDateTrunc(DV, Md, Yd);

    if DV < Min then
      if Wrap then begin
        if Dd <> 0 then
          DV := Max
        else if Md <> 0 then begin
          repeat
            DV := DMYtoStDate(D, Mmx, Ymx, efGetEpoch);
            Dec(D);
          until DV <> BadDate;
          while DV > Max do
            DV := IncDateTrunc(DV, -1, 0);
        end else begin
          repeat
            DV := DMYtoStDate(D, M, Ymx, efGetEpoch);
            Dec(D);
          until DV <> BadDate;
          while DV > Max do
            DV := IncDateTrunc(DV, 0, -1);
        end;
      end else
        Exit
    else if DV > Max then
      if Wrap then begin
        if Dd <> 0 then
          DV := Min
        else if Md <> 0 then begin
          repeat
            DV := DMYtoStDate(D, Mmn, Ymn, efGetEpoch);
            Dec(D);
          until DV <> BadDate;
          while DV < Min do
            DV := IncDateTrunc(DV, 1, 0);
        end else begin
          repeat
            DV := DMYtoStDate(D, M, Ymn, efGetEpoch);
            Dec(D);
          until DV <> BadDate;
          while DV < Min do
            DV := IncDateTrunc(DV, 0, 1);
        end;
      end else
        Exit;

    IntlSupport.DateToDatePChar(efEditSt, efPicture, DV, False);
    pbRemoveSemiLits;
    SetSelection(0, MaxEditLen);
    efPerformRepaint(True);
  end;

  procedure IncDecValueTime;
  var
    T, SaveT   : TStTime;
    Min, Max   : TStTime;
    Hd, Md, Sd : Integer;
    C          : AnsiChar;
    P          : Word;
    Dabs       : Integer;
  begin
    {convert string to day/month/year}
    T := IntlSupport.TimePCharToTime(efPicture, efEditSt);
    if T = BadTime then
      Exit;

    {find out which subfield we're in}
    P := efHPos;
    if pbIsLiteral(P) then
      Dec(P);
    C := efPicture[P];

    {get valid range}
    Min := efRangeLo.rtTime;
    Max := efRangeHi.rtTime;
    if (Max = MinTime) then begin
      Min := MinTime;
      Max := MaxTime;
    end;

    {increment/decrement the subfield}
    Hd := 0;
    Md := 0;
    Sd := 0;
    Dabs := Abs(Trunc(Delta));
    case C of
      pmHour, pmHourU :
        Hd := Dabs;
      pmMinute, pmMinuteU :
        Md := Dabs;
      pmSecond, pmSecondU :
        Sd := Dabs;
      pmAmPm :
        Hd := 12*DAbs;
    end;

    SaveT := T;
    if Delta < 0 then begin
      T := DecTime(T, Hd, Md, Sd);
      if (T > SaveT) or (T < Min) then
        if not Wrap then
          Exit;
    end else begin
      T := IncTime(T, Hd, Md, Sd);
      if (T < SaveT) or (T > Max) then
        if not Wrap then
          Exit;
    end;
    IntlSupport.TimeToTimePChar(efEditSt, efPicture, T, False);
    SetSelection(0, MaxEditLen);
    pbRemoveSemiLits;
    efPerformRepaint(True);
  end;

begin
  if not (sefHaveFocus in sefOptions) then
    Exit;

  case FPictureDataType of
    pftString    : {not supported for this field type};
    pftChar      : IncDecValueChar;
    pftBoolean   : IncDecValueBoolean;
    pftYesNo     : IncDecValueYesNo;
    pftLongInt,
    pftWord,
    pftInteger,
    pftByte,
    pftShortInt  : IncDecValueLongInt;
    pftReal      : IncDecValueReal;
    pftExtended  : IncDecValueExtended;
    pftDouble    : IncDecValueDouble;
    pftSingle    : IncDecValueSingle;
    pftComp      : IncDecValueComp;
    pftDate      : IncDecValueDate;
    pftTime      : IncDecValueTime;
  end;
  efPositionCaret(False);
end;

function TOvcCustomPictureField.efTransfer(DataPtr : Pointer; TransferFlag : Word) : Word;
  {-transfer data to/from the entry fields}
var
  P      : PChar absolute DataPtr;
  SP     : ^ShortString absolute DataPtr;
  Code   : Integer;
  Width  : Word;
  Places : Word;

  procedure TransferString;
    {-transfer data to/from string type entry fields}
  var
    A : TEditString;
  begin
    if TransferFlag = otf_GetData then begin
      if TrimBlanks and efFieldIsEmpty then
        SP^ := ''
      else begin
        {get copy of the edit string}
        if StripLiterals then
          pbStripLiterals(A, efEditSt)
        else
          StrCopy(A, efEditSt);

        {trim leading and trailing blanks}
        if TrimBlanks then
          TrimAllSpacesPChar(A);

        SP^ := StrPas(A);
      end;
    end else if Length(SP^) <> MaxLength then begin
      if ShortString(DataPtr^) = '' then
        efEditSt[0] := #0
      else
        StrPLCopy(efEditSt, SP^, MaxLength);
      pbMergePicture(efEditSt, efEditSt);
    end else
      StrPLCopy(efEditSt, SP^, MaxLength);
  end;

  procedure TransferChar;
    {-transfer data to or from the character fields}
  var
    S : TEditString;
  begin
    if TransferFlag = otf_GetData then begin
      pbStripPicture(S, efEditSt);

      AnsiChar(DataPtr^) := S[0];
    end else begin
      S[0] := AnsiChar(DataPtr^);
      S[1] := #0;
      pbMergePicture(efEditSt, S);
    end;
  end;

  procedure TransferBoolean;
    {-transfer data to or from boolean fields}
  var
    S : TEditString;
  begin
    if TransferFlag = otf_GetData then begin
      pbStripPicture(S, efEditSt);

      Boolean(DataPtr^) := (UpCaseChar(S[0]) = IntlSupport.TrueChar);
    end else begin
      if Boolean(DataPtr^) then
        S[0] := IntlSupport.TrueChar
      else
        S[0] := IntlSupport.FalseChar;
      S[1] := #0;
      pbMergePicture(efEditSt, S);
    end;
  end;

  procedure TransferYesNo;
    {-transfer data to or from YesNo fields}
  var
    S : TEditString;
  begin
    if TransferFlag = otf_GetData then begin
      pbStripPicture(S, efEditSt);

      Boolean(DataPtr^) := (UpCaseChar(S[0]) = IntlSupport.YesChar);
    end else begin
      if Boolean(DataPtr^) then
        S[0] := IntlSupport.YesChar
      else
        S[0] := IntlSupport.NoChar;
      S[1] := #0;
      pbMergePicture(efEditSt, S);
    end;
  end;

  procedure TransferLongInt;
    {-transfer data to or from LongInt fields}
  var
    S : TEditString;
  begin
    if TransferFlag = otf_GetData then begin
      pbStripPicture(S, efEditSt);

      if not efStr2Long(S, LongInt(DataPtr^)) then
        LongInt(DataPtr^) := 0;
    end else begin
      efLong2Str(S, LongInt(DataPtr^));
      pbMergePicture(efEditSt, S);
    end;
  end;

  procedure TransferWord;
    {-transfer data to or from Word fields}
  var
    L : LongInt;
    S : TEditString;
  begin
    if TransferFlag = otf_GetData then begin
      pbStripPicture(S, efEditSt);

      if efStr2Long(S, L) then
        Word(DataPtr^) := L
      else
        Word(DataPtr^) := 0;
    end else begin
      efLong2Str(S, Word(DataPtr^));
      pbMergePicture(efEditSt, S);
    end;
  end;

  procedure TransferInteger;
    {-transfer data to or from Integer fields}
  var
    L : LongInt;
    S : TEditString;
  begin
    if TransferFlag = otf_GetData then begin
      pbStripPicture(S, efEditSt);

      if efStr2Long(S, L) then
        SmallInt(DataPtr^) := L
      else
        SmallInt(DataPtr^) := 0;
    end else begin
      efLong2Str(S, SmallInt(DataPtr^));
      pbMergePicture(efEditSt, S);
    end;
  end;

  procedure TransferByte;
    {-transfer data to or from Byte fields}
  var
    L : LongInt;
    S : TEditString;
  begin
    if TransferFlag = otf_GetData then begin
      pbStripPicture(S, efEditSt);

      if efStr2Long(S, L) then
        Byte(DataPtr^) := L
      else
        Byte(DataPtr^) := 0;
    end else begin
      efLong2Str(S, Byte(DataPtr^));
      pbMergePicture(efEditSt, S);
    end;
  end;

  procedure TransferShortInt;
    {-transfer data to or from ShortInt fields}
  var
    L : LongInt;
    S : TEditString;
  begin
    if TransferFlag = otf_GetData then begin
      pbStripPicture(S, efEditSt);

      if efStr2Long(S, L) then
        ShortInt(DataPtr^) := L
      else
        ShortInt(DataPtr^) := 0;
    end else begin
      efLong2Str(S, ShortInt(DataPtr^));
      pbMergePicture(efEditSt, S);
    end;
  end;

  procedure TransferReal;
    {-transfer data to or from Real fields}
  var
    R : Real;
    S : TEditString;
  begin
    if TransferFlag = otf_GetData then begin
      pbStripPicture(S, efEditSt);

      FixRealPrim(S, pmDecimalPt);                                     {!!.16}
      Val(S, R, Code);
      if Code <> 0 then
        R := 0;
      Real(DataPtr^) := R;
    end else begin
      pbCalcWidthAndPlaces(Width, Places);
      Str(Real(DataPtr^):Width:Places, S);
      if DecimalPlaces <> 0 then
        TrimTrailingZerosPChar(S)
      else
        TrimAllSpacesPChar(S);
      pbMergePicture(efEditSt, S);
    end;
  end;

  procedure TransferExtended;
    {-transfer data to or from Extended fields}
  var
    E : Extended;
    S : TEditString;
  begin
    if TransferFlag = otf_GetData then begin
      pbStripPicture(S, efEditSt);

      FixRealPrim(S, pmDecimalPt);                                     {!!.16}
      Val(S, E, Code);
      if Code <> 0 then
        E := 0;
      Extended(DataPtr^) := E;
    end else begin
      pbCalcWidthAndPlaces(Width, Places);
      Str(Extended(DataPtr^):Width:Places, S);
      if DecimalPlaces <> 0 then
        TrimTrailingZerosPChar(S)
      else
        TrimAllSpacesPChar(S);
      pbMergePicture(efEditSt, S);
    end;
  end;

  procedure TransferDouble;
    {-transfer data to or from Double fields}
  var
    D : Double;
    S : TEditString;
  begin
    if TransferFlag = otf_GetData then begin
      pbStripPicture(S, efEditSt);

      FixRealPrim(S, pmDecimalPt);                                     {!!.16}
      Val(S, D, Code);
      if Code <> 0 then
        D := 0;
      Double(DataPtr^) := D;
    end else begin
      pbCalcWidthAndPlaces(Width, Places);
      Str(Double(DataPtr^):Width:Places, S);
      if DecimalPlaces <> 0 then
        TrimTrailingZerosPChar(S)
      else
        TrimAllSpacesPChar(S);
      pbMergePicture(efEditSt, S);
    end;
  end;

  procedure TransferSingle;
    {-transfer data to or from Single fields}
  var
    Si : Single;
    S  : TEditString;
  begin
    if TransferFlag = otf_GetData then begin
      pbStripPicture(S, efEditSt);

      FixRealPrim(S, pmDecimalPt);                                     {!!.16}
      Val(S, Si, Code);
      if Code <> 0 then
        Si := 0;
      Single(DataPtr^) := Si;
    end else begin
      pbCalcWidthAndPlaces(Width, Places);
      Str(Single(DataPtr^):Width:Places, S);
      if DecimalPlaces <> 0 then
        TrimTrailingZerosPChar(S)
      else
        TrimAllSpacesPChar(S);
      pbMergePicture(efEditSt, S);
    end;
  end;

  procedure TransferComp;
    {-transfer data to or from Comp fields}
  var
    C : Comp;
    S : TEditString;
  begin
    if TransferFlag = otf_GetData then begin
      pbStripPicture(S, efEditSt);

      FixRealPrim(S, pmDecimalPt);                                     {!!.16}
      Val(S, C, Code);
      if Code <> 0 then
        C := 0;
      Comp(DataPtr^) := C;
    end else begin
      pbCalcWidthAndPlaces(Width, Places);
      Str(Comp(DataPtr^):Width:Places, S);
      if DecimalPlaces <> 0 then
        TrimTrailingZerosPChar(S)
      else
        TrimAllSpacesPChar(S);
      pbMergePicture(efEditSt, S);
    end;
  end;

  procedure TransferDate;
    {-transfer data to or from Date fields}
  var
    E       : Integer;
    D, M, Y : Integer;
    Dt      : TStDate;
  begin
    if TransferFlag = otf_GetData then
      TStDate(DataPtr^) := IntlSupport.DatePCharToDate(efPicture, efEditSt,
        efGetEpoch)
    else begin
      Dt := TStDate(DataPtr^);
      {if mask is using a two digit year--test for valid year assignments}
      if (Dt <> BadDate) and (StrPos(efPicture, 'yyyy') = nil) then begin
        E := efGetEpoch;
        StDateToDMY(Dt, D, M, Y);
        {if the year is outside of the epoch range; error}
        if (Y < E) or (Y > E+99) then
          if (Dt = 0) or (Dt = DateTimeToStDate(0)) then
            TStDate(DataPtr^) := BadDate
          else
            raise EInvalidDateForMask.Create;
      end;
      IntlSupport.DateToDatePChar(efEditSt, efPicture, TStDate(DataPtr^), False);
    end;
  end;

  procedure TransferTime;
    {-transfer data to or from Time fields}
  begin
    if TransferFlag = otf_GetData then
      TStTime(DataPtr^) := IntlSupport.TimePCharToTime(efPicture, efEditSt)
    else
      IntlSupport.TimeToTimePChar(efEditSt, efPicture, TStTime(DataPtr^), False);
  end;

begin  {transfer}
  {!!.13} {added}
  if DataPtr = nil then begin
    Result := 0;
    Exit;
  end;

  case FPictureDataType of
    pftString   : TransferString;
    pftChar     : TransferChar;
    pftBoolean  : TransferBoolean;
    pftYesNo    : TransferYesNo;
    pftLongInt  : TransferLongInt;
    pftWord     : TransferWord;
    pftInteger  : TransferInteger;
    pftByte     : TransferByte;
    pftShortInt : TransferShortInt;
    pftReal     : TransferReal;
    pftExtended : TransferExtended;
    pftDouble   : TransferDouble;
    pftSingle   : TransferSingle;
    pftComp     : TransferComp;
    pftDate     : TransferDate;
    pfTTime     : TransferTime;
  end;
  Result := inherited efTransfer(DataPtr, TransferFlag);
end;

function TOvcCustomPictureField.efValidateField : Word;
  {-validate contents of field; result is error code or 0}
var
  L1, L2  : Word;
  Code    : Integer;
  S       : TEditString;

  procedure ValidateString;
  begin
    if sefGettingValue in sefOptions then
      Exit;

    if TrimBlanks then
      if sefHaveFocus in sefOptions then begin
        L1 := StrLen(efEditSt);
        TrimAllSpacesPChar(efEditSt);
        L2 := StrLen(efEditSt);
        pbMergePicture(efEditSt, efEditSt);
        if L1 <> L2 then
          Invalidate;
      end;
  end;

  procedure ValidateChar;
  begin
    pbStripPicture(S, efEditSt);

    if (efRangeLo.rtChar <> efRangeHi.rtChar) and
       ((S[0] < efRangeLo.rtChar) or (S[0] > efRangeHi.rtChar)) then
      Result := oeRangeError;
  end;

  procedure ValidateBoolean;
  begin
    pbStripPicture(S, efEditSt);

    if (UpCaseChar(S[0]) <> IntlSupport.TrueChar) and
       (UpCaseChar(S[0]) <> IntlSupport.FalseChar) then
      Result := oeRangeError;
  end;

  procedure ValidateYesNo;
  begin
    pbStripPicture(S, efEditSt);

    if (UpCaseChar(S[0]) <> IntlSupport.YesChar) and
       (UpCaseChar(S[0]) <> IntlSupport.NoChar) then
      Result := oeRangeError;
  end;

  procedure ValidateLongInt;
  var
    L : LongInt;
  begin
    pbStripPicture(S, efEditSt);

    if not efStr2Long(S, L) then
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
    W : Word;
  begin
    pbStripPicture(S, efEditSt);

    if not efStr2Long(S, L) then
      Result := oeInvalidNumber
    else if (L < efRangeLo.rtLong) or (L > efRangeHi.rtLong) then
      Result := oeRangeError
    else begin
      if sefHaveFocus in sefOptions then
        if not (sefGettingValue in sefOptions) then begin
          W := L;
          efTransfer(@W, otf_SetData);
          Invalidate;
        end;
    end;
  end;

  procedure ValidateInteger;
  var
    L : LongInt;
    I : Integer;
  begin
    pbStripPicture(S, efEditSt);

    if not efStr2Long(S, L) then
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
    pbStripPicture(S, efEditSt);

    if not efStr2Long(S, L) then
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
    pbStripPicture(S, efEditSt);

    if not efStr2Long(S, L) then
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
    R  : Real;
  begin
    {convert efEditSt to a real}
    pbStripPicture(S, efEditSt);

    FixRealPrim(S, pmDecimalPt);                                       {!!.16}
    Val(S, R, Code);
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
    E : Extended;
  begin
    {convert efEditSt to an extended}
    pbStripPicture(S, efEditSt);

    FixRealPrim(S, pmDecimalPt);                                       {!!.16}
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
    E : Extended;
    D : Double;
  begin
    {convert efEditSt to an extended}
    pbStripPicture(S, efEditSt);

    FixRealPrim(S, pmDecimalPt);                                       {!!.16}
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
    E  : Extended;
    Sg : Single;
  begin
    {convert efEditSt to an extended}
    pbStripPicture(S, efEditSt);

    FixRealPrim(S, pmDecimalPt);                                       {!!.16}
    Val(S, E, Code);
    if Code <> 0 then
      Result := oeInvalidNumber
    else if (E < efRangeLo.rtExt) or (E > efRangeHi.rtExt) then
      Result := oeRangeError
    else begin
      if sefHaveFocus in sefOptions then
        if not (sefGettingValue in sefOptions) then begin
          Sg := E;
          efTransfer(@Sg, otf_SetData);
          Invalidate;
        end;
    end;
  end;

  procedure ValidateComp;
  var
    E : Extended;
    C : Comp;
  begin
    {convert efEditSt to an comp}
    pbStripPicture(S, efEditSt);

    FixRealPrim(S, pmDecimalPt);                                       {!!.16}
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

  procedure ValidateDate;
  var
    D : TStDate;
  begin
    {allow blank date fields}
    if IntlSupport.DatePCharIsBlank(efPicture, efEditSt) then
      Exit;

    {convert efEditSt to a date}
    D := IntlSupport.DatePCharToDate(efPicture, efEditSt, efGetEpoch);
    if D = BadDate then
      Result := oeInvalidDate
    else if (efRangeHi.rtDate <> MinDate) and
            ((D < efRangeLo.rtDate) or (D > efRangeHi.rtDate)) then
      Result := oeRangeError
    else begin
      if sefHaveFocus in sefOptions then
        if not (sefGettingValue in sefOptions) then begin
          efTransfer(@D, otf_SetData);
          Invalidate;
        end;
    end;
  end;

  procedure ValidateTime;
  var
    T   : TStTime;
    H   : Integer;
    M   : Integer;
    Sec : Integer;
  begin
    {allow blank time fields}
    if not IntlSupport.TimePCharToHMS(efPicture, efEditSt, H, M, Sec) then
      if (H = -1) and (M = -1) and ((Sec = -1) or (Sec = 0)) then
        Exit;

    T := IntlSupport.TimePCharToTime(efPicture, efEditSt);
    if T = BadTime then
      Result := oeInvalidTime
    else if (efRangeHi.rtTime <> MinTime) and
            ((T < efRangeLo.rtTime) or (T > efRangeHi.rtTime)) then
      Result := oeRangeError
    else begin
      if sefHaveFocus in sefOptions then
        if not (sefGettingValue in sefOptions) then begin
          efTransfer(@T, otf_SetData);
          Invalidate;
        end;
    end;
  end;

begin
  Result := 0;
  case FPictureDataType of
    pftString   : ValidateString;
    pftChar     : ValidateChar;
    pftBoolean  : ValidateBoolean;
    pftYesNo    : ValidateYesNo;
    pftLongInt  : ValidateLongInt;
    pftWord     : ValidateWord;
    pftInteger  : ValidateInteger;
    pftByte     : ValidateByte;
    pftShortInt : ValidateShortInt;
    pftReal     : ValidateReal;
    pftExtended : ValidateExtended;
    pftDouble   : ValidateDouble;
    pftSingle   : ValidateSingle;
    pftComp     : ValidateComp;
    pftDate     : ValidateDate;
    pftTime     : ValidateTime;
  end;

  if not (sefUserValidating in sefOptions) then begin
    {user may retrieve data from field. flag that we are doing}
    {user validation to avoid calling this routine recursively}
    Include(sefOptions, sefUserValidating);
    DoOnUserValidation(Result);
    Exclude(sefOptions, sefUserValidating);
  end;
end;

function TOvcCustomPictureField.pfGetDataType(Value : TPictureDataType) : Byte;
  {-return a Byte value representing the type of this field}
begin
  case Value of
    pftString    : Result := fidPictureString;
    pftChar      : Result := fidPictureChar;
    pftBoolean   : Result := fidPictureBoolean;
    pftYesNo     : Result := fidPictureYesNo;
    pftLongInt   : Result := fidPictureLongInt;
    pftWord      : Result := fidPictureWord;
    pftInteger   : Result := fidPictureInteger;
    pftByte      : Result := fidPictureByte;
    pftShortInt  : Result := fidPictureShortInt;
    pftReal      : Result := fidPictureReal;
    pftExtended  : Result := fidPictureExtended;
    pftDouble    : Result := fidPictureDouble;
    pftSingle    : Result := fidPictureSingle;
    pftComp      : Result := fidPictureComp;
    pftDate      : Result := fidPictureDate;
    pftTime      : Result := fidPictureTime;
  else
    raise EOvcException.Create(GetOrphStr(SCInvalidParamValue));
  end;
end;

{!!.10} {revised}
procedure TOvcCustomPictureField.pfResetFieldProperties(FT : TPictureDataType);
  {-reset field properties based on current setings}
var
  FC  : Boolean;
  M   : string;

  procedure Update(const Mask : string);
  begin
    PictureMask := Mask;
    MaxLength := Length(Mask);
    DecimalPlaces := 0;
  end;

begin
  case FT of
    pftString    : Update('XXXXXXXXXXXXXXX');
    pftBoolean   : Update('B');
    pftYesNo     : Update('Y');
    pftChar      : Update('X');
    pftLongInt   : Update('iiiiiiiiii');
    pftWord      : Update('99999');
    pftInteger   : Update('iiiiii');
    pftByte      : Update('999');
    pftShortInt  : Update('iiii');
    pftReal      : Update('##########');
    pftExtended  : Update('##########');
    pftDouble    : Update('##########');
    pftSingle    : Update('##########');
    pftComp      : Update('iiiiiiiiii');
    pftDate      : begin
                     FC := Pos('yyyy', ShortDateFormat) > 0;
                     M := IntlSupport.InternationalDate(FC);
                     Update(M);
                   end;
    pftTime      : begin
                     M := IntlSupport.InternationalTime(False);
                     Update(M);
                   end;
  else
    raise EOvcException.Create(GetOrphStr(SCInvalidParamValue));
  end;
end;

procedure TOvcCustomPictureField.pfSetDataType(Value : TPictureDataType);
  {-set the data type for this field}
begin
  if FPictureDataType <> Value then begin
    FPictureDataType := Value;
    efDataType := pfGetDataType(FPictureDataType);
    CaretToEnd := pfDefCaretToEnd;
    InsertPushes := pfDefInsertPushes;
    efSetDefaultRange(efDataType);

    {set defaults for this field type}
    pfResetFieldProperties(FPictureDataType);
    if HandleAllocated then begin
      {don't save data through create window}
      efSaveData := False;
      RecreateWnd;
    end;
  end;
end;

procedure TOvcCustomPictureField.pfSetPictureMask(const Value : string);
  {-set the picture mask}
var
  Buf : TPictureMask;
begin
  if (FPictureMask <> Value) and (Value <> '') then begin

    {test for blatantly invalid masks}
    if csDesigning in ComponentState then begin
      {check for "." in fields not editing floating data types}
      if not ((efDataType mod fcpDivisor) in [fsubReal, fsubExtended, fsubDouble, fsubSingle]) then
        if Pos(pmDecimalPt, Value) > 0 then
          raise EInvalidPictureMask.Create(Value);
    end;

    FPictureMask := Value;
    if csDesigning in ComponentState then begin
      StrPLCopy(efPicture, FPictureMask, MaxPicture);
      efPicLen := StrLen(efPicture);
      if not (csLoading in ComponentState) then
        MaxLength := StrLen(efPicture);
      pbOptimizeInitPictureFlags;
      efInitializeDataSize;
    end else begin
      StrPLCopy(Buf, FPictureMask, MaxPicture);
      efChangeMask(Buf);
    end;
    RecreateWnd;
  end;
end;

procedure TOvcCustomPictureField.pfSetDefaultRanges;
  {-set default range values based on the field type}
begin
  case FPictureDataType of
    pftChar, pftBoolean, pftYesNo :
      if efRangeLo.rtChar = efRangeHi.rtChar then
        efSetDefaultRange(efDataType);
    pftLongInt, pftWord, pftInteger, pftByte, pftShortInt :
      if efRangeLo.rtLong = efRangeHi.rtLong then
        efSetDefaultRange(efDataType);
    pftReal :
      if efRangeLo.rtReal = efRangeHi.rtReal then
        efSetDefaultRange(efDataType);
    pftExtended, pftDouble, pftSingle, pftComp :
      if efRangeLo.rtExt = efRangeHi.rtExt then
        efSetDefaultRange(efDataType);
    pftDate :
      if efRangeLo.rtDate = efRangeHi.rtDate then
        efSetDefaultRange(efDataType);
    pftTime :
      if efRangeLo.rtTime = efRangeHi.rtTime then
        efSetDefaultRange(efDataType);
  else
    efSetDefaultRange(efDataType);
  end;
end;

procedure TOvcCustomPictureField.SetAsString(const Value : string);
  {-sets the field value to a String Value}
var
  R    : TRangeType;
  fSub : Byte;
begin
  if sefUserValidating in sefOptions then
    Exit;

  fSub := (efDataType mod fcpDivisor);
  if fSub in [fsubDate, fsubTime] then begin
    {convert dates and times using current picture mask}
    if fSub = fsubDate then begin
      if Length(Value) <> Length(FPictureMask) then
        R.rtDate := BadDate
      else
        R.rtDate := FIntlSup.DateStringToDate(PictureMask, Value, efGetEpoch);
      SetValue(R);
    end else if fSub = fsubTime then begin
      if Length(Value) <> Length(FPictureMask) then
        R.rtTime := BadTime
      else
        R.rtTime := FIntlSup.TimeStringToTime(PictureMask, Value);
      SetValue(R);
    end;
  end else
    inherited SetAsString(Value);
end;

procedure TOvcCustomPictureField.SetInitDateTime(Value : Boolean);
  {-set the InitDateTime property}
begin
  FInitDateTime := Value;
  if csLoading in ComponentState then
    Exit;

  {initialize field value}
  if FInitDateTime then begin
    if DataType = pftDate then
      AsStDate := CurrentDate;                                         {!!.01}
    if DataType = pftTime then
      AsStTime := CurrentTime;                                         {!!.01}
  end else if (DataType = pftDate) or (DataType = pftTime) then
    efSetInitialValue;
end;



end.