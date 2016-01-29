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
{*                    OVCPB.PAS 2.17                     *}
{*     Copyright 1995-98 (c) TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcPB;
  {-Base picture field class, Picture and Numeric fields are derived from this}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, Forms, Graphics, Menus, Messages, SysUtils,
  OvcConst, OvcData, OvcExcpt, OvcVer, OvcEf, OvcCmd,
  OvcMisc, OvcStr;

type
  TOvcPictureBase = class(TOvcBaseEntryField)
  {.Z+}
  protected {private}
    pfSemiLits   : Byte;               {# of semi-literals in field}
    pfPicFlags   : TPictureFlags;      {picture flags array}
    pfSelPos     : Integer;            {current position of selection highlight}

    {windows message methods}
    procedure WMSetFocus(var Msg : TWMSetFocus);
      message WM_SETFOCUS;
    procedure WMKillFocus(var Msg : TWMKillFocus);
      message WM_KILLFOCUS;

  protected
    procedure CreateWnd;
      override;

    function efCanClose(DoValidation : Boolean) : Boolean;
      override;
      {-return True if window can be closed}
    procedure efCaretToEnd;
      override;
      {-move the caret to the end of the field}
    procedure efCaretToStart;
      override;
      {-move the caret to the beginning of the field}
    procedure efChangeMask(Mask : PAnsiChar);
      override;
      {-change the picture mask}
    function efEditBegin : Word;
      override;
      {-return offset of first editable position in field}
    function efEditEnd : Word;
      {-return offset of last editable position in field}
    function  efFieldIsEmpty : Boolean;
      override;
      {-return True if the field is empty}
    function efGetDisplayString(Dest : PAnsiChar; Size : Word) : PAnsiChar;
      override;
      {-return the display string in Dest and a pointer as the result}
    procedure efRemoveBadOptions;
      override;
      {-remove inappropriate options for this field and data type}
    procedure efSetCaretPos(Value : Integer);
      override;
      {-set position of caret within the field}

    function  pbCalcLength : Word;
      {-calculate length of efEditSt}
    procedure pbCalcWidthAndPlaces(var Width, Places : Word);
      {-calculate width and decimal places for a numeric field}
    procedure pbFixDecimalPoint(P : PAnsiChar);
      {-fix decimal points for real numbers before merging}
    procedure pbFixNumber(DotPos, StBgn, StEnd : Integer; FirstHalf, SecondHalf : Boolean);
      {-fix the first and/or second half of a numeric field}
    function  pbIsLiteral(N : Word) : Boolean;
      {-return True if N'th mask character is a literal. N is 0-based}
    procedure pbInitPictureFlags;
      {-initialize picture mask flags}
    function  pbIsNumber : Boolean;
      {-return True if field is treated as numeric by MergePicture}
    function  pbIsSemiLiteral(N : Word) : Boolean;
      {-return True if N'th mask character is a semi-literal. N is 0-based}
    procedure pbMergePicture(const Dest, Src : PAnsiChar);
      {-merge Src with efPicture and return result in Dest}
    procedure pbOptimizeInitPictureFlags;
      {-see if we can optimize InitPictureFlags}
    procedure pbRemoveSemiLits;
      virtual;
      {-remove semi-literal mask characters from the edit string}
    procedure pbRestoreSemiLits;
      {-restore semi-literal mask characters in the edit string}
    procedure pbStripLiterals(Dest, Src : PAnsiChar);
      {-strip literal mask characters from source and put result in Dest}
    procedure pbStripPicture(const Dest, Src : PAnsiChar);
      {-strip the mask characters from Src and put result in Dest}

  public
    {interfaced for internal use only--to allow validation}
    {helper routines access to the picture flags array}
    procedure pbGetPictureFlags(var Flags : TPictureFlags);
      {-return an array of the fields picture flags}
    function ValidateContents(ReportError : Boolean) : Word;           {!!.16}
      override;
    function GetStrippedEditString : string;                           {!!.D4}
      override;
      {-return edit string stripped of literals and semi-literals}
    procedure MergeWithPicture(const S : string);                      {!!.D4}
      override;
      {-combines S with the picture mask and updates the edit string}
  {.Z-}
  end;


implementation

uses
  STDate;

{*** TOvcPictureBase ***}

procedure TOvcPictureBase.CreateWnd;
begin
  pbInitPictureFlags;

  inherited CreateWnd;

  {set flags for Real fields and clear DecimalPlaces if decimal point is in mask}
  case efDataType mod fcpDivisor of
    fsubReal, fsubExtended, fsubDouble, fsubSingle, fsubComp :
      begin
        Include(sefOptions, sefRealVar);
        if StrScan(efPicture, pmDecimalPt) <> nil then
          DecimalPlaces := 0;
      end;
  end;
end;

procedure TOvcPictureBase.pbGetPictureFlags(var Flags : TPictureFlags);
  {-return an array of the fields picture flags}
begin
  Flags := pfPicFlags;
end;

function TOvcPictureBase.pbIsLiteral(N : Word) : Boolean;
  {-return True if N'th mask character is a literal. N is 0-based}
begin
  Result := pfPicFlags[N] = pflagLiteral;
end;

function TOvcPictureBase.pbIsSemiLiteral(N : Word) : Boolean;
  {-return True if N'th mask character is a semi-literal. N is 0-based}
begin
  Result := pfPicFlags[N] = pflagSemiLit;
end;

procedure TOvcPictureBase.pbFixNumber(DotPos, StBgn, StEnd : Integer; FirstHalf, SecondHalf : Boolean);
  {-fix the first and/or second half of a numeric field}
var
  I, J, K : Integer;
  SaveHP  : Word;

  function StartOfSubField : Word;
  begin
    Result := efHPos;
    while (Result > StBgn) and not pbIsLiteral(Result - 1) do
      Dec(Result);
  end;

  function EndOfSubField : Word;
  begin
    Result := efHPos;
    while (Result < StEnd) and not pbIsLiteral(Result + 1) do
      Inc(Result);
  end;

begin
  SaveHP := efHPos;

  if FirstHalf then begin
    {bring numbers to left of decimal flush right}
    if DotPos = -1 then
      efHPos := StEnd
    else
      efHPos := DotPos-1;
    K := EndOfSubField;
    J := StartOfSubField;
    I := J;
    while efEditSt[I] = ' ' do
      Inc(I);
    while I <= K do begin
      if efEditSt[I] = ' ' then begin
        StrStDeletePrim(efEditSt, I, 1);
        StrChInsertPrim(efEditSt, ' ', J);
      end;
      Inc(I);
    end;

    {make sure it isn't all blanks to left of decimal}
    if efEditSt[K] = ' ' then
      efEditSt[K] := '0';
  end;

  if (DotPos <> -1) and SecondHalf then begin
    efHPos := DotPos+1;

    {bring numbers to right of decimal flush left}
    J := EndOfSubField;
    if efHPos <= J then begin
      K := J;
      J := StartOfSubField;
      I := K;
      while efEditSt[I] = ' ' do begin
        efEditSt[I] := '0';
        Dec(I);
      end;
      while I >= J do begin
        if efEditSt[I] = ' ' then begin
          StrStDeletePrim(efEditSt, I, 1);
          StrChInsertPrim(efEditSt, '0', K);
        end;
        Dec(I);
      end;
    end;
  end;

  efHPos := SaveHP;
end;

procedure TOvcPictureBase.pbStripLiterals(Dest, Src : PAnsiChar);
  {-strip literal mask characters from source and put result in Dest}
var
  I : Word;
begin
  for I := 0 to MaxLength-1 do begin
    if not pbIsLiteral(I) then begin
      Dest^ := Src^;
      Inc(Dest);
    end;
    Inc(Src);
  end;
  Dest^ := #0;
end;

procedure TOvcPictureBase.pbFixDecimalPoint(P : PAnsiChar);
  {-fix decimal points for real numbers before merging}
var
  PT : PAnsiChar;
begin
  PT := StrScan(P, pmDecimalPt);
  if PT <> nil then
    PT^ := IntlSupport.DecimalChar;
end;

procedure TOvcPictureBase.pbRestoreSemiLits;
  {-restore semi-literal mask characters in the edit string}
begin
  if not (sefFixSemiLits in sefOptions) then
    Exit;

  Exclude(sefOptions, sefFixSemiLits);
  pbStripPicture(efEditSt, efEditSt);
  pbMergePicture(efEditSt, efEditSt);
  Invalidate;
end;

procedure TOvcPictureBase.pbInitPictureFlags;
var
  I : Word;
begin
  if sefNoLiterals in sefOptions then begin
    FillChar(pfPicFlags, MaxLength, pflagFormat);
    pfPicFlags[MaxLength] := pflagLiteral;
  end else begin
    FillChar(pfPicFlags, MaxLength+1, pflagLiteral);
    for I := 0 to MaxLength-1 do
      if efNthMaskChar(I) in PictureChars then
        pfPicFlags[I] := pflagFormat
      else
        case efNthMaskChar(I) of
          pmFloatDollar, pmComma :
            pfPicFlags[I] := pflagSemiLit;
        end;
  end;
end;

function TOvcPictureBase.pbIsNumber : Boolean;
  {-return True if field is treated as numeric by MergePicture}
begin
  Result :=
    (pfSemiLits <> 0) or
    (sefNumeric in sefOptions) or
    (sefHexadecimal in sefOptions) or
    (sefOctal in sefOptions) or
    (sefBinary in sefOptions) or
    (StrScan(efPicture, pmDecimalPt) <> nil) or
    (StrScan(efPicture, pmCurrencyLt) <> nil) or
    (StrScan(efPicture, pmCurrencyRt) <> nil);
end;

function TOvcPictureBase.pbCalcLength : Word;
  {-calculate length of efEditSt}
var
  I : Integer;
begin
  I := efEditEnd;
  while (I >= 0) and ((efEditSt[I] = ' ') or pbIsLiteral(I)) do
    Dec(I);
  Result := I + 1;
end;

function TOvcPictureBase.efGetDisplayString(Dest : PAnsiChar; Size : Word) : PAnsiChar;
  {-return the display string in Dest}
var
  I : Integer;
begin
  Result := inherited efGetDisplayString(Dest, Size);

  if Uninitialized and not (sefHaveFocus in sefOptions) then begin
    FillChar(Dest[0], MaxLength, ' ');
    Dest[MaxLength] := #0;
    Exit;
  end;

  if PasswordMode or (PadChar <> ' ') then begin
    I := MaxLength-1;
    while I >= 0 do begin
      while (I >= 0) and pbIsLiteral(I) do
        Dec(I);

      if efFieldClass <> fcNumeric then
        while (I >= 0) and (not pbIsLiteral(I)) and (Dest[I] = ' ') do begin
          Dest[I] := PadChar;
          Dec(I);
        end;

      while (I >= 0) and (not pbIsLiteral(I)) and (Dest[I] <> ' ') do begin
        if PasswordMode then
          Dest[I] := PasswordChar;
        Dec(I);
      end;

      if efFieldClass = fcNumeric then
        while (I >= 0) and (not pbIsLiteral(I)) and (Dest[I] = ' ') do begin
          Dest[I] := PadChar;
          Dec(I);
        end;
    end;
  end;
end;

{!!.11} {revised}
function TOvcPictureBase.efFieldIsEmpty : Boolean;
  {-return True if the field is empty}
var
  I : Word;
begin
  I := 0;
  Result := True;
  while (I+1 <= MaxLength) and Result do
    if (not pbIsLiteral(I)) and (efEditSt[I] <> ' ') then
      Result := False
    else
      Inc(I);

  (*
  case efDataType mod fcpDivisor of
    fsubDate :
      Result := IntlSupport.DatePCharToDate(efPicture, efEditSt, efGetEpoch) = BadDate;
    fsubTime :
      Result := IntlSupport.TimePCharToTime(efPicture, efEditSt) = BadTime;
  else
    I := 0;
    Result := True;
    while (I+1 <= MaxLength) and Result do
      if (not pbIsLiteral(I)) and (efEditSt[I] <> ' ') then
        Result := False
      else
        Inc(I);
  end;
  *)
end;

procedure TOvcPictureBase.efRemoveBadOptions;
  {-remove inappropriate options for this field and data type}
begin
  if csLoading in ComponentState then
    Exit;

  case efDataType of
    fidPictureString :
      if not (sefNoLiterals in sefOptions) then begin
        RightJustify := False;
        TrimBlanks := False;
      end;
  else
    inherited efRemoveBadOptions;
  end;
end;

procedure TOvcPictureBase.efSetCaretPos(Value : Integer);
  {-set position of caret within the field}
begin
  if not (sefHaveFocus in sefOptions) then
    Exit;

  if Value < efEditBegin then
    efHPos := efEditBegin
  else if Value > efEditEnd then
    efHPos := efEditEnd + 1
  else begin
    while pbIsLiteral(Value) do
      Dec(Value);
    efHPos := Value;
  end;
  efPositionCaret(True);
end;

procedure TOvcPictureBase.efCaretToStart;
  {-move the caret to the beginning of the field}
begin
  efHPos := efEditBegin;
  efHOffset := 0;
end;

procedure TOvcPictureBase.efCaretToEnd;
  {-move the caret to the end of the field}
var
  StEnd : Word;
begin
  efHPos := pbCalcLength;
  StEnd := efEditEnd;
  while (efHPos < StEnd) and pbIsLiteral(efHPos) do
    Inc(efHPos);
end;

function TOvcPictureBase.efEditBegin : Word;
  {-return offset of first editable position in field}
var
  I : Word;
begin
  I := 0;
  while (I < MaxLength-1) and (pfPicFlags[I] = pflagLiteral) do
    Inc(I);
  Result := I + pfSemiLits;
end;

function TOvcPictureBase.efEditEnd : Word;
  {-return offset of last editable position in field}
begin
  Result := MaxLength - 1;
  while (Result > 0) and (pfPicFlags[Result] = pflagLiteral) do
    Dec(Result);
end;

procedure TOvcPictureBase.efChangeMask(Mask : PAnsiChar);
  {-change the picture mask}
var
  I : Cardinal;
begin
  inherited efChangeMask(Mask);

  {disallow 'p' and 'g' in picture fields}
  if efFieldClass <> fcNumeric then begin
    if StrChPos(efPicture, pmNegParens, I) then
      StrChDeletePrim(efPicture, I);
    if StrChPos(efPicture, pmNegHere, I) then
      StrChDeletePrim(efPicture, I);
  end;

  efPicLen := StrLen(efPicture);
  if (MaxLength < efPicLen) or
     ((MaxLength <> efPicLen) and (efFieldClass = fcNumeric)) then begin
    if not (csLoading in ComponentState) then
      MaxLength := efPicLen;
  end;

  {clear the edit string}
  FillChar(efEditSt, MaxEditLen, #0);

  {see if we can optimize InitPictureFlags}
  pbOptimizeInitPictureFlags;
end;

function TOvcPictureBase.GetStrippedEditString : string;
  {-return edit string stripped of literals and semi-literals}
var
  Buf : TEditString;
begin
  {get copy of edit string and limit to MaxEditLen}
  StrLCopy(Buf, efEditSt, MaxEditLen);

  {strip the copy of the edit string}
  pbStripPicture(Buf, Buf);
  Result := StrPas(Buf);
end;

procedure TOvcPictureBase.MergeWithPicture(const S : string);
  {-combines S with the picture mask and updates the edit string}
var
  Buf : TEditString;
begin
  HandleNeeded;                                                        {!!.15}
  StrPCopy(Buf, S);
  pbMergePicture(efEditSt, Buf);
end;

function TOvcPictureBase.efCanClose(DoValidation : Boolean) : Boolean;
  {-return True if window can be closed}
var
  DotPos : Cardinal;
begin
  if efFieldClass = fcPicture then
    if ((sefModified in sefOptions) and (sefHaveFocus in sefOptions)) then
      if StrChPos(efPicture, pmDecimalPt, DotPos) then
        pbFixNumber(DotPos, efEditBegin, efEditEnd, True, True);
  Result := inherited efCanClose(DoValidation);
end;

procedure TOvcPictureBase.pbRemoveSemiLits;
  {-remove semi-literal mask characters from the edit string}
var
  I : Cardinal;
  B : Word;
  E : Word;
  P : Word;
  D : Word;
begin
  if pfSemiLits = 0 then begin
    if (sefHexadecimal in sefOptions) or (sefOctal in sefOptions) or
       (sefBinary in sefOptions) then
      Include(sefOptions, sefFixSemiLits);
    Exit;
  end;

  Include(sefOptions, sefFixSemiLits);

  B := efEditBegin;
  E := efEditEnd;
  P := B - pfSemiLits;

  if StrScan(efPicture, pmFloatDollar) <> nil then begin
    if StrStPos(efEditSt, IntlSupport.CurrencyLtStr, I) then begin
      D := StrLen(IntlSupport.CurrencyLtStr);
      StrStDeletePrim(efEditSt, I, D);
      StrInsertChars(efEditSt, ' ', P, D);
      Inc(P, D);
    end;
  end;

  if StrScan(efPicture, pmComma) <> nil then
    for I := P{B} to E do                                              {!!.12}
      if (efEditSt[I] = IntlSupport.CommaChar) then begin
        StrStDeletePrim(efEditSt, I, 1);
        StrChInsertPrim(efEditSt, ' ', P);
        Inc(P);
      end;
end;

procedure TOvcPictureBase.pbCalcWidthAndPlaces(var Width, Places : Word);
  {-calculate width and decimal places for a numeric field}
var
  I      : Word;
  DotPos : Cardinal;
begin
  pbInitPictureFlags;

  {find position of period and calculate decimal places}
  if not StrChPos(efPicture, pmDecimalPt, DotPos) then
    Places := DecimalPlaces
  else begin
    Places := 0;
    I := DotPos+1;
    while (pfPicFlags[I] = pflagFormat) do begin
      Inc(Places);
      Inc(I);
    end;
  end;

  {calculate width}
  I := 0;
  Width := 0;
  while pbIsLiteral(I) or pbIsSemiLiteral(I) do
    Inc(I);
  while (pfPicFlags[I] = pflagFormat) or (efNthMaskChar(I) = pmComma) do begin
    Inc(Width, Ord(pfPicFlags[I] = pflagFormat));
    Inc(I);
  end;

  {add decimal places and period}
  if (DotPos <> $FFFF) and (Places <> 0) then
    Inc(Width, Places + 1);
end;

procedure TOvcPictureBase.pbOptimizeInitPictureFlags;
  {-see if we can optimize InitPictureFlags}
var
  I : Word;
begin
  pfSemiLits := 0;
  Exclude(sefOptions, sefNoLiterals);
  pbInitPictureFlags;
  Include(sefOptions, sefNoLiterals);
  for I := 0 to MaxLength-1 do
    case pfPicFlags[I] of
      pflagLiteral :
        Exclude(sefOptions, sefNoLiterals);
      pflagSemiLit :
        begin
          Inc(pfSemiLits);
          Exclude(sefOptions, sefNoLiterals);
        end;
    end;

  {if we have literals, turn off TrimBlanks and RightJustify}
  if not (sefNoLiterals in sefOptions) then begin
    TrimBlanks := False;
    RightJustify := False;
  end;
end;

procedure TOvcPictureBase.pbMergePicture(const Dest, Src : PAnsiChar);
  {-merge Src with efPicture and return result in Dest}
var
  SrcLen     : Integer;
  DestLen    : Integer;
  DotPosP    : Cardinal;
  DotPosS    : Cardinal;
  FloatPos   : Integer;
  FP         : Cardinal;
  I          : Cardinal;
  J, K, N    : Integer;
  PicChar    : AnsiChar;
  NeedFloat  : Boolean;
  CurLeftMax : Byte;
  CurLeftLen : Byte;
  IsNum      : Boolean;
  NeedMinus  : Boolean;
  FoundP     : Boolean;
  FoundS     : Boolean;
  CopyOfSrc  : TEditString;

  procedure HandleOtherCases;
  begin
    if NeedFloat then begin
      Dec(CurLeftLen);
      Dest[I] := IntlSupport.CurrencyLtStr[CurLeftLen];
      NeedFloat := CurLeftLen <> 0;
    end else if NeedMinus then begin
      Dest[I] := '-';
      NeedMinus := False;
    end else if (sefHexadecimal in sefOptions) or (sefOctal in sefOptions) or
                (sefBinary in sefOptions) then
      Dest[I] := '0'
    else
      Dest[I] := ' ';
  end;

begin
  {get initial size of Src}
  SrcLen := StrLen(Src);

  if SrcLen = 0 then
    CopyOfSrc[0] := #0
  else
    StrCopy(CopyOfSrc, Src);

  {copy picture mask into Dest}
  StrCopy(Dest, efPicture);

  {mask may be artificially short -- extend with last character of mask}
  if MaxLength > efPicLen then begin
    FillChar(Dest[efPicLen], MaxLength-efPicLen, Dest[efPicLen-1]);
    Dest[MaxLength] := #0;
  end;
  DestLen := MaxLength;

  {get position of decimal point}
  FoundP := StrChPos(efPicture, pmDecimalPt, DotPosP);

  {is it a numeric string?}
  IsNum := pbIsNumber;

  {take care of currency strings}
  if StrChPos(efPicture, pmCurrencyLt, I) then begin
    K := I;
    while (K+1 < DestLen) and (efNthMaskChar(K+1) = pmCurrencyLt) do
      Inc(K);
    J := StrLen(IntlSupport.CurrencyLtStr);
    for N := K downto I do
      if J > 0 then begin
        Dec(J);
        Dest[N] := IntlSupport.CurrencyLtStr[J];
      end else
        Dest[N] := ' ';
  end;

  if StrChPos(efPicture, pmCurrencyRt, I) then begin
    J := 0;
    K := StrLen(IntlSupport.CurrencyRtStr);
    while (LongInt(I+1) <= DestLen) and (efNthMaskChar(I) = pmCurrencyRt) do begin {!!.D4}
      if J < K then begin
        Dest[I] := IntlSupport.CurrencyRtStr[J];
        Inc(J);
      end else
        Dest[I] := ' ';
      Inc(I);
    end;
  end;

  if IsNum then begin
    {we need to fill in the FloatDollar positions too, if any}
    if StrChPos(efPicture, pmFloatDollar, FP) then begin
      FloatPos := FP;
      CurLeftLen := StrLen(IntlSupport.CurrencyLtStr);
      CurLeftMax := 1;
      while efNthMaskChar(FloatPos+1) = pmFloatDollar do begin
        Inc(FloatPos);
        Inc(CurLeftMax);
      end;
      if CurLeftMax < CurLeftLen then
        CurLeftLen := CurLeftMax;
    end else begin
      CurLeftLen := 0;
      FloatPos := -1;
    end;

    {trim leading and trailing blanks}
    TrimAllSpacesPChar(CopyOfSrc);

    {check for a minus sign}
    NeedMinus := (CopyOfSrc[0] = '-');
    if NeedMinus then
      StrStDeletePrim(CopyOfSrc, 0, 1);

    {it's a numeric field--align the decimal points}
    FoundS := StrChPos(CopyOfSrc, pmDecimalPt, DotPosS);

    {see if we need a floating dollar sign}
    SrcLen := StrLen(CopyOfSrc);
    NeedFloat := (SrcLen <> 0) and (CurLeftLen <> 0);

    {if there's no tail, pretend there's a dot beyond the end of CopyOfSrc}
    if not FoundS then
      K := SrcLen
    else
      K := DotPosS;

    {copy the tail of the string}
    if not FoundP then
      I := DestLen
    else
      I := DotPosP+1;
    J := K+1;
    while (J+1 <= SrcLen) and (LongInt(I+1) <= DestLen) and not pbIsLiteral(I) do begin {!!.D4}
      Dest[I] := CopyOfSrc[J];
      Inc(I);
      Inc(J);
    end;

    {pad to end with 0's}
    while (LongInt(I+1) <= DestLen) and not pbIsLiteral(I) do begin    {!!.D4}
      Dest[I] := '0';
      Inc(I);
    end;

    {handle trailing substitution characters}
    while (LongInt(I+1) <= DestLen) and pbIsLiteral(I) do begin        {!!.D4}
      PicChar := efNthMaskChar(I);
      case PicChar of
        Subst1..Subst8 : Dest[I] := UserData.SubstChars[PicChar];
      end;
      Inc(I);
    end;

    {merge the head of the string}
    if not FoundP then
      J := DestLen-1
    else
      J := DotPosP;

    if FoundS then
      SrcLen := DotPosS;

    for I := J downto 0 do begin
      PicChar := efNthMaskChar(I);
      case pfPicFlags[I] of
        pflagFormat,
        pflagSemiLit :
          if PicChar = pmComma then begin
            if (SrcLen <> 0) then begin                                {!!.10}
              if IntlSupport.CommaChar <> #0 then                      {!!.10}
                Dest[I] := IntlSupport.CommaChar                       {!!.10}
              else                                                     {!!.10}
                StrStDeletePrim(Dest, I, 1);                           {!!.10}
            end else
              HandleOtherCases;
          end else if (SrcLen > 0) and (Integer(I) > FloatPos) then begin
            Dec(SrcLen);
            Dest[I] := CopyOfSrc[SrcLen];
          end else
            HandleOtherCases;
        pflagLiteral :
          case PicChar of
            Subst1..Subst8 :
              Dest[I] := UserData.SubstChars[PicChar];
            pmDecimalPt :
              Dest[I] := IntlSupport.DecimalChar;
          end;
      end;
    end;

    {put in a 0 before the dot if necessary}
    if FoundP and (Dest[DotPosP-1] = ' ') then
      Dest[DotPosP-1] := '0';
    end else begin
    {deal with problem w/ reals w/ variable # of places}
    if (sefRealVar in sefOptions) and (SrcLen > DestLen) then
      if StrScan(CopyOfSrc, pmDecimalPt) <> nil then begin
        TrimTrailingZerosPChar(CopyOfSrc);
        SrcLen := StrLen(CopyOfSrc);
      end;

    if RightJustify then begin
      {fill in the characters from CopyOfSrc}
      J := SrcLen-1;
      for I := DestLen-1 downto 0 do begin
        PicChar := efNthMaskChar(I);
        case pfPicFlags[I] of
          pflagLiteral :
            case PicChar of
              Subst1..Subst8 :
                Dest[I] := UserData.SubstChars[PicChar];
            end;
        else
          if (J = -1) then
            Dest[I] := ' '
          else begin
            Dest[I] := CopyOfSrc[J];
            efFixCase(PicChar, AnsiChar(Dest[I]), #255);
            Dec(J);
          end;
        end;
      end;
    end else begin
      {fill in the characters from CopyOfSrc}
      J := 0;
      for I := 0 to DestLen-1 do begin
        PicChar := efNthMaskChar(I);
        case pfPicFlags[I] of
          pflagLiteral :
            case PicChar of
              Subst1..Subst8 :
                Dest[I] := UserData.SubstChars[PicChar];
            end;
        else
          if (J <= SrcLen-1) then begin
            Dest[I] := CopyOfSrc[J];
            efFixCase(PicChar, AnsiChar(Dest[I]), #255);
            Inc(J);
          end else
            Dest[I] := ' ';
        end;
      end;
    end;

    if sefRealVar in sefOptions then
      pbFixDecimalPoint(Dest);
  end;

  Dest[DestLen] := #0;
end;

procedure TOvcPictureBase.pbStripPicture(const Dest, Src : PAnsiChar);
  {-strip the mask characters from Src and put result in Dest}
var
  SLen   : Byte;
  Found  : Boolean;
  P      : PAnsiChar;
  DotPos : Cardinal;
  I      : Integer;
  CLT    : array[0..5] of AnsiChar;
begin
  {this won't work if string isn't the same length as the picture mask}
  if StrLen(Src) <> MaxLength then begin
    if Pointer(Dest) <> Pointer(Src) then
      StrCopy(Dest, Src);
    Exit;
  end;

  {check for fixed decimal point}
  Found := StrChPos(efPicture, pmDecimalPt, DotPos);

  {copy all non-literals from Src into Dest. Note: it's OK if Dest *is* Src}
  SLen := 0;
  for I := 0 to MaxLength-1 do
    if (Found and (I = LongInt(DotPos))) or not pbIsLiteral(I) then begin{!!.D4}
      Inc(SLen);
      Dest[SLen-1] := Src[I];
    end;
  Dest[SLen] := #0;

  {remove floating dollar sign}
  P := StrScan(efPicture, pmFloatDollar);
  if P <> nil then begin
    I := 1;

    {find end  of currency mask}
    while P[1] = pmFloatDollar do begin
      Inc(I);
      Inc(P);
    end;
    StrCopy(CLT, IntlSupport.CurrencyLtStr);
    CLT[I] := #0;
    P := StrPos(Dest, CLT);
    if P <> nil then
      StrStDeletePrim(P, 0, I);
  end;

  {remove commas}
  if (StrScan(efPicture, pmComma) <> nil) and                          {!!.10}
     (IntlSupport.CommaChar <> #0) then                                {!!.10}
    repeat
      P := StrScan(Dest, IntlSupport.CommaChar);
      if P <> nil then
        StrStDeletePrim(P, 0, 1);
    until (P = nil);

  {fix up decimal point}
  if Found then begin
    P := StrScan(Dest, IntlSupport.DecimalChar);
    if P <> nil then
      P^ := pmDecimalPt;
  end;
end;

{!!.16}
function TOvcPictureBase.ValidateContents(ReportError : Boolean) : Word;
var
  DotPos : Cardinal;
begin
  if efFieldClass = fcPicture then
    if sefModified in sefOptions then begin
      if StrChPos(efPicture, pmDecimalPt, DotPos) then
        pbFixNumber(DotPos, efEditBegin, efEditEnd, True, True);
    end;

  Result := inherited ValidateContents(ReportError);
end;

procedure TOvcPictureBase.WMSetFocus(var Msg : TWMSetFocus);
var
  B : Boolean;
begin
  pbInitPictureFlags;
  B := sefRetainPos in sefOptions;
  inherited;
  if not B then
    pfSelPos := efSelEnd;
end;

procedure TOvcPictureBase.WMKillFocus(var Msg : TWMKillFocus);
var
  DotPos : Cardinal;
begin
  if efFieldClass = fcPicture then
    if sefModified in sefOptions then begin
      if StrChPos(efPicture, pmDecimalPt, DotPos) then
        pbFixNumber(DotPos, efEditBegin, efEditEnd, True, True);
    end;

  inherited;

  {are we giving up the focus?}
  if not (sefRetainPos in sefOptions) then begin
    {restore semi-literal characters}
    pbRestoreSemiLits;
  end;
end;

end.