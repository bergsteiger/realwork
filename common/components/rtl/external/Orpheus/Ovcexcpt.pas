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
{*                  OVCEXCPT.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcExcpt;
  {-Exceptions unit}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, SysUtils,
  OvcData, OvcConst, OvcIntl;

type
  {*** Base Orpheus exeption class ***}
  EOvcException = class(Exception)
  public
    ErrorCode : LongInt;
  end;


  {*** General ***}
  ENoTimersAvailable = class(EOvcException)
  public
    constructor Create;
  end;


  {*** Controller ***}
  EControllerError = class(EOvcException);

  ENoControllerAssigned = class(EControllerError)
  public
    constructor Create;
  end;


  {*** Command Processor ***}
  ECmdProcessorError = class(EOvcException);

  EDuplicateCommand = class(ECmdProcessorError)
  public
    constructor Create;
  end;

  ETableNotFound = class(ECmdProcessorError)
  public
    constructor Create;
  end;


  {*** Entry Fields ***}
  EEntryFieldError = class(EOvcException);

  EInvalidDataType = class(EEntryFieldError)
  public
    constructor Create;
  end;

  EInvalidPictureMask = class(EEntryFieldError)
  public
    constructor Create(Mask : string);
  end;

  EInvalidRangeValue = class(EEntryFieldError)
  public
    constructor Create(DataType : Byte);
  end;

  EInvalidDateForMask = class(EEntryFieldError)
  public
    constructor Create;
  end;


  {*** Editors ***}
  EEditorError = class(EOvcException)
  public
    constructor Create(const Msg : string; Error : LongInt; Dummy : Byte);
  end;

  EInvalidLineOrCol = class(EEditorError)
  public
    constructor Create;
  end;

  EInvalidLineOrPara = class(EEditorError)
  public
    constructor Create;
  end;


  {*** Viewers ***}
  EViewerError = class(EOvcException);

  ERegionTooLarge = class(EViewerError)
  public
    constructor Create;
  end;


  {*** Notebook ***}
  ENotebookError = class(EOvcException);

  EInvalidPageIndex = class(ENotebookError)
  public
    constructor Create;
  end;

  EInvalidTabFont = class(ENotebookError)
  public
    constructor Create;
  end;


  {*** Rotated Label ***}
  ERotatedLabelError = class(EOvcException);

  EInvalidLabelFont = class(ERotatedLabelError)
  public
    constructor Create;
  end;


  {*** Timer Pool ***}
  ETimerPoolError = class(EOvcException);

  EInvalidTriggerHandle = class(ETimerPoolError)
  public
    constructor Create;
  end;


  {*** Virtual Listbox ***}
  EVirtualListboxError = class(EOvcException);

  EOnSelectNotAssigned = class(EVirtualListboxError)
  public
    constructor Create;
  end;

  EOnIsSelectedNotAssigned = class(EVirtualListboxError)
  public
    constructor Create;
  end;


  {*** Sparse Array ***}
  ESparseArrayError = class(EOvcException);

  ESAEAtMaxSize = class(ESparseArrayError);

  ESAEOutOfBounds = class(ESparseArrayError);


  {*** Table controls ***}
  ETableError = class(EOvcException)
  public
    constructor Create(const Msg : string);
    constructor CreateFmt(const Msg : string; const Args : array of const);
    constructor CreateRes(Ident : Word);
    constructor CreateResFmt(Ident : Word; const Args : array of const);
  end;


  {*** Fixed Font ***}
  EFixedFontError = class(EOvcException);

  EInvalidFixedFont = class(EFixedFontError)
  public
    constructor Create;
  end;

  EInvalidFontParam = class(EFixedFontError)
  public
    constructor Create;
  end;


  {*** Alarm ***}
  EAlarmError = class(EOvcException);

  EInvalidAlarmHandle = class(EAlarmError)
  public
    constructor Create;
  end;


implementation


{*** General ***}

constructor ENoTimersAvailable.Create;
begin
  inherited Create(GetOrphStr(SCNoTimersAvail));
end;


{*** Controller ***}

constructor ENoControllerAssigned.Create;
begin
  inherited Create(GetOrphStr(SCNoControllerAssigned));
end;


{*** Command Processor ***}

constructor ETableNotFound.Create;
begin
  inherited Create(GetOrphStr(SCTableNotFound));
end;

constructor EDuplicateCommand.Create;
begin
  inherited Create(GetOrphStr(SCDuplicateCommand));
end;


{*** Entry Fields ***}

constructor EInvalidDataType.Create;
begin
  inherited Create(GetOrphStr(SCInvalidDataType));
end;

constructor EInvalidPictureMask.Create(Mask : string);
begin
  inherited CreateFmt(GetOrphStr(SCInvalidPictureMask), [Mask]);
end;

constructor EInvalidRangeValue.Create(DataType : Byte);
var
  S  : string;
begin
  case DataType of
    fsubLongInt  : inherited CreateFmt(GetOrphStr(SCInvalidRange), [Low(LongInt), High(LongInt)]);
    fsubWord     : inherited CreateFmt(GetOrphStr(SCInvalidRange), [Low(Word), High(Word)]);
    fsubInteger  : inherited CreateFmt(GetOrphStr(SCInvalidRange), [Low(SmallInt), High(SmallInt)]);
    fsubByte     : inherited CreateFmt(GetOrphStr(SCInvalidRange), [Low(Byte), High(Byte)]);
    fsubShortInt : inherited CreateFmt(GetOrphStr(SCInvalidRange), [Low(ShortInt), High(ShortInt)]);
    fsubReal     : inherited Create(GetOrphStr(SCInvalidRealRange));
    fsubExtended : inherited Create(GetOrphStr(SCInvalidExtendedRange));
    fsubDouble   : inherited Create(GetOrphStr(SCInvalidDoubleRange));
    fsubSingle   : inherited Create(GetOrphStr(SCInvalidSingleRange));
    fsubComp     : inherited Create(GetOrphStr(SCInvalidCompRange));
    fsubDate     :
      begin
        S := OvcIntlSup.InternationalDate(True);
        inherited CreateFmt(GetOrphStr(SCInvalidDateRange), [S]);
      end;
    fsubTime     :
      begin
        S := OvcIntlSup.InternationalTime(False);
        inherited CreateFmt(GetOrphStr(SCInvalidTimeRange), [S]);
      end;
  else
    inherited Create(GetOrphStr(SCInvalidRangeValue));
  end;
end;

constructor EInvalidDateForMask.Create;
begin
  inherited Create(GetOrphStr(SCInvalidDateForMask));
end;


{*** Editors ***}

constructor EEditorError.Create(const Msg : string; Error : LongInt; Dummy : Byte);
begin
  ErrorCode := Error;
  inherited Create(Msg);
end;

constructor EInvalidLineOrCol.Create;
begin
  inherited Create(GetOrphStr(SCInvalidLineOrColumn), 0, 0);
end;

constructor EInvalidLineOrPara.Create;
begin
  inherited Create(GetOrphStr(SCInvalidLineOrParaIndex), 0, 0);
end;


{*** Viewers ***}

constructor ERegionTooLarge.Create;
begin
  inherited Create(GetOrphStr(SCRegionTooLarge));
end;


{*** Notebook ***}

constructor EInvalidPageIndex.Create;
begin
  inherited Create(GetOrphStr(SCInvalidPageIndex));
end;

constructor EInvalidTabFont.Create;
begin
  inherited Create(GetOrphStr(SCInvalidTabFont));
end;


{*** Rotated Label ***}

constructor EInvalidLabelFont.Create;
begin
  inherited Create(GetOrphStr(SCInvalidLabelFont));
end;


{*** Timer Pool ***}

constructor EInvalidTriggerHandle.Create;
begin
  inherited Create(GetOrphStr(SCBadTriggerHandle));
end;


{*** Virtual Listbox ***}

constructor EOnSelectNotAssigned.Create;
begin
  inherited Create(GetOrphStr(SCOnSelectNotAssigned));
end;

constructor EOnIsSelectedNotAssigned.Create;
begin
  inherited Create(GetOrphStr(SCOnIsSelectedNotAssigned));
end;


{*** Table control ***}

constructor ETableError.Create(const Msg : string);
begin
  inherited Create(Format(GetOrphStr(SCTableGeneral), [Msg]));
end;

constructor ETableError.CreateFmt(const Msg : string; const Args : array of const);
var
  S : string;
begin
  S := Format(GetOrphStr(ScTableGeneral), [Msg]);
  inherited CreateFmt(S, Args);
end;

constructor ETableError.CreateRes(Ident : Word);
begin
  Create(GetOrphStr(Ident));
end;

constructor ETableError.CreateResFmt(Ident : Word; const Args : array of const);
begin
  CreateFmt(GetOrphStr(Ident), Args);
end;


{*** Fixed Font ***}

constructor EInvalidFixedFont.Create;
begin
  inherited Create(GetOrphStr(SCNonFixedFont));
end;

constructor EInvalidFontParam.Create;
begin
  inherited Create(GetOrphStr(SCInvalidFontParam));
end;


{*** Alarm ***}

constructor EInvalidAlarmHandle.Create;
begin
  inherited Create(GetOrphStr(SCBadAlarmHandle));
end;


end.