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
{*                    OVCEF.PAS 2.17                     *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcEF;
  {-Base entry field class}

{$I l3Delphi.inc }  

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  {$IfDef Delphi6}
  Variants,
  {$EndIf Delphi6}
  Classes, ClipBrd, Controls, Forms, Graphics, Menus, Messages, SysUtils,
  OvcBase, OvcCaret, OvcColor, OvcConst, OvcCmd,
  OvcData, OvcExcpt, OvcIntl, OvcMisc, OvcStr,
  OvcUser, OvcVer, STDate;

const
  efDefArrowIncDec       = False;                                      {!!.10}
  efDefAutoAdvanceChar   = False;
  efDefAutoAdvanceLR     = False;
  efDefAutoAdvanceUD     = False;
  efDefAutoSelect        = True;
  efDefAutoSize          = True;
  efDefBeepOnError       = True;
  efDefBorderStyle       = bsSingle;
  efDefCaretToEnd        = True;
  efDefCtrlColor         = clRed;
  efDefDecimalPlaces     = 0;
  efDefDisabledBack      = clWindow;                                   {!!.12}
  efDefDisabledText      = clGrayText;                                 {!!.12}
  efDefErrorBack         = clRed;
  efDefErrorText         = clBlack;
  efDefForceInsert       = False;
  efDefForceOvertype     = False;
  efDefHeight            = 25;
  efDefHighlightBack     = clHighlight;
  efDefHighlightText     = clHighlightText;
  efDefInputRequired     = False;
  efDefInsertPushes      = True;
  efDefMaxLength         = 15;
  efDefParentColor       = False;
  efDefPasswordChar      = '*';
  efDefPasswordMode      = False;
  efDefReadOnly          = False;
  efDefRightAlign        = False;                                      {!!.10}
  efDefRightJustify      = False;
  efDefSoftValidation    = False;
  efDefStripLiterals     = False;
  efDefTabStop           = True;
  efDefTextMargin        = 2;
  efDefTrimBlanks        = True;
  efDefUninitialized     = False;
  efDefWidth             = 130;
  efDefZeroDisplay       = zdShow;
  efDefZeroDisplayValue  = 0;

type
  {user validation event}
  TUserValidationEvent =
    procedure(Sender : TObject; var ErrorCode : Word)
    of object;
  TValidationErrorEvent =
    procedure(Sender : TObject; ErrorCode : Word; ErrorMsg : AnsiString)
    of object;

  {abstract entry field class}
  TOvcBaseEntryField = class(TOvcBase)
  {.Z+}
  protected {private}
    {property instance variables}
    FArrowIncDec       : Boolean;      {U/D cursor movement performs inc/dec} {!!.10}
    FAutoAdvanceChar   : Boolean;      {focus moves to next field after last character entered}
    FAutoAdvanceLR     : Boolean;      {L/R cursor movement at field ends moves focus to next/prev control}
    FAutoAdvanceUD     : Boolean;      {U/D cursor movement moves focus to next/prev control}
    FAutoSelect        : Boolean;      {select all text when gets focus}
    FAutoSize          : Boolean;      {size control when font changes}
    FBeepOnError       : Boolean;      {MessageBeep is called for error conditions}
    FBorderStyle       : TBorderStyle; {border around the edit field}
    FCaretToEnd        : Boolean;      {caret is placed at end of AnsiString}
    FCtrlColor         : TColor;       {control character foreground color}
    FDecimalPlaces     : Byte;         {max decimal places, if no '.' in Picture}
    FDisabledColors    : TOvcColors;   {colors for disabled fields}    {!!.12}
    FEpoch             : Integer;      {combined epoch year and cenury}
    FErrorColors       : TOvcColors;   {colors for invalid fields}
    FHighlightColors   : TOvcColors;   {background and text highlight colors}
    FInputRequired     : Boolean;      {field cannot be left empty by the user}
    FInsertPushes      : Boolean;      {inserted chars push ending chars off}
    FIntlSup           : TOvcIntlSup;  {international support object}
    FForceInsert       : Boolean;      {forces insert mode while editing}
    FForceOvertype     : Boolean;      {forces overtype mode while editing}
    FLastError         : Word;         {result of last validation}
    FMaxLength         : Word;         {maximum length of AnsiString}
    FPadChar           : AnsiChar;     {character used to pad end of AnsiString}
    FPasswordChar      : AnsiChar;     {character used in password mode}
    FPasswordMode      : Boolean;      {use password mode}
    FReadOnly          : Boolean;      {prevents field editing}
    FRightAlign        : Boolean;      {true to right-align text}      {!!.10}
    FRightJustify      : Boolean;      {display text right-justified}
    FSoftValidation    : Boolean;      {errors detected are not reported, just flagged}
    FStripLiterals     : Boolean;      {remove literals from returned AnsiString}
    FTextMargin        : Integer;      {indent from left (right)}
    FTrimBlanks        : Boolean;      {remove leading and trailing blanks if not listerals}
    FUninitialized     : Boolean;      {the field isblanked out completely except when it has the focus}
    FUserData          : TOvcUserData; {field mask and data object}
    FZeroDisplay       : TZeroDisplay; {true to display an empty field}
    FZeroDisplayValue  : Double;       {value used by ZeroDisplay logic}

    {event variables}
    FOnChange          : TNotifyEvent;
    FOnError           : TValidationErrorEvent;
    FOnUserCommand     : TUserCommandEvent;
    FOnUserValidation  : TUserValidationEvent;

    {internal variables}
    efCaret            : TOvcCaretPair; {our carets}
    efDataSize         : Word;          {size of data type being edited}
    efDataType         : Byte;          {code indicating field type}
    efEditSt           : TEditString;   {the edit AnsiString}
    efFieldClass       : Byte;          {fcSimple, fcPicture, or fcNumeric}
    efHOffset          : Integer;       {horizontal scrolling offset}
    efHPos             : Integer;       {current position in field (column)}
    efPicLen           : Word;          {length of picture mask}
    efPicture          : TPictureMask;  {picture mask}
    efRangeHi          : TRangeType;    {high range for the field}
    efRangeLo          : TRangeType;    {low range for the field}
    efRightAlignActive : Boolean;       {true if right-align is in use}{!!.10}
    efSaveData         : Boolean;       {save data during create window}
    efSaveEdit         : PAnsiChar;     {saved copy of edit AnsiString}
    efSelStart         : Integer;       {start of highlighted selection}
    efSelEnd           : Integer;       {end of highlighted selection}
    efTopMargin        : Integer;       {margin above text}
    sefOptions         : TsefOptionSet; {secondary field options}

    {property methods}
    function GetAsBoolean : Boolean;
      {-return the field value as a Boolean value}
    function GetAsCents : LongInt;
      {-return the field value as a LongInt representing pennies}
    function GetAsExtended : Extended;
      {-return the field value as an Extended}
    function GetAsFloat : Double;
      {-return the field value as a Double}
    function GetAsInteger : Longint;
      {-return the field value as a LongInt}
    function GetAsDateTime : TDateTime;
      {-return the field value as a Delphi DateTime value}
    function GetAsStDate : TStDate;
      {-return the field value as a Orpheus Date value}
    function GetAsStTime : TStTime;
      {-return the field value as a Orpheus Time value}
    function GetAsString : AnsiString;
      {-return the field value as a AnsiString}
    {$IFDEF Win32}
    function GetAsVariant : Variant;
      {return the field value as a Variant}
    {$ENDIF}
    function GetCurrentPos : Integer;
      {-return position of the caret within the field}
    function GetDataSize : Word;
      {-return the size of the data for this field}
    function GetDisplayString : AnsiString;
      {-return the display AnsiString}
    function GetEditString : AnsiString;
      {-return the edit AnsiString}
    function GetEverModified : Boolean;
      {-return true if this field has ever been modified}
    function GetInsCaretType : TOvcCaret;
      {-return the current caret type}
    function GetInsertMode : Boolean;
      {-return the controller's insert mode state}
    function GetModified : Boolean;
      {-return true if this field is modified}
    function GetOvrCaretType : TOvcCaret;
      {-return the current caret type}
    function GetRangeHiStr : AnsiString;
      {-get the high field range as AnsiString value}
    function GetRangeLoStr : AnsiString;
      {-get the low field range as AnsiString value}
    function GetSelLength : Integer;
      {-return the length of the currently selected text}
    function GetSelStart : Integer;
      {-return the starting position of the selection, if any}
    function GetSelText : AnsiString;
      {-return the currently selected text}
    procedure SetArrowIncDec(Value : Boolean);
      {-set the ArrowIncDec option}
    procedure SetAsBoolean(Value : Boolean);
      {-set the field value to a Boolean value}
    procedure SetAsCents(Value : LongInt);
      {-set the field value given a LongInt value representing pennies}
    procedure SetAsDateTime(Value : TDateTime);
      {-set the field value to a Delphi DateTime value}
    procedure SetAsExtended(Value : Extended);
      {-set the field value to an Extended value}
    procedure SetAsFloat(Value : Double);
      {-set the field value to a Double value}
    procedure SetAsInteger(Value : Longint);
      {-set the field value to a LongInt value}
    procedure SetAsStDate(Value : TStDate);
      {-set the field value to a Orpheus Date value}
    procedure SetAsStTime(Value : TStTime);
      {-set the field value to a Orpheus Time value}
    {$IFDEF Win32}
    procedure SetAsVariant(Value : Variant);
      {-set the field value to a Variant value}
    {$ENDIF}
    procedure SetAutoAdvanceChar(Value : Boolean);
      {-set the AutoAdvanceChar option}
    procedure SetAutoAdvanceLeftRight(Value : Boolean);
      {-set the AutoAdvanceLeftRight option}
    procedure SetAutoAdvanceUpDown(Value : Boolean);
      {-set the AutoAdvanceUD option}
    procedure SetAutoSelect(Value : Boolean);
      {-set the auto select setting on or off}
    procedure SetAutoSize(Value : Boolean);
      reintroduce;
      {-set the auto font adjust on or off}
    procedure SetBorderStyle(Value : TBorderStyle);
      {-set the type of border to use}
    procedure SetCaretToEnd(Value : Boolean);
      {-set the CaretToEnd option}
    procedure SetDecimalPlaces(Value : Byte);
      {-set the number of decimal places for the edit field}
    procedure SetEpoch(Value : Integer);
      {-set the epoch value}
    procedure SetEverModified(Value : Boolean);
      {-set the EverModified flag}
    procedure SetForceInsert(Value : Boolean);
      {-set the force insert option}
    procedure SetForceOvertype(Value : Boolean);
      {-set the force overtype option}
    procedure SetInputRequired(Value : Boolean);
      {-sets the InpurRequired option}
    procedure SetInsCaretType(const Value : TOvcCaret);
      {-set the type of caret to use}
    procedure SetInsertMode(Value : Boolean);
      {-changes the field's insert mode}
    procedure SetInsertPushes(Value : Boolean);
      {-set the InsertPushes option}
    procedure SetIntlSupport(Value : TOvcIntlSup);
      {-set the international support object this field will use}
    procedure SetMaxLength(Value : Word);
      {-set the maximum length of the edit field}
    procedure SetModified(Value : Boolean);
      {-set the modified flag}
    procedure SetOvrCaretType(const Value : TOvcCaret);
      {-set the type of caret to use}
    procedure SetPadChar(Value : AnsiChar);
      {-set the character used to pad the end of the edit AnsiString}
    procedure SetPasswordChar(Value : AnsiChar);
      {-set the character used to mask password entry}
    procedure SetPasswordMode(Value : Boolean);
      {-set use of password mode}
    procedure SetRangeLoStr(const Value : AnsiString);
      {-set the low field range from a AnsiString value}
    procedure SetRangeHiStr(const Value : AnsiString);
      {-set the high field range from a AnsiString value}
    procedure SetReadOnly(Value : Boolean);
      {-set the read only option}
    procedure SetRightAlign(Value : Boolean);                          {!!.10}
      {-set the right align option}
    procedure SetRightJustify(Value : Boolean);
      {-set the right justify option}
    procedure SetSelLength(Value : Integer);
      {-set the extent of the selected text}
    procedure SetSelStart(Value : Integer);
      {-set the starting position of the selection}
    procedure SetSelText(const Value : AnsiString);                        {!!.13}
      {-replace selected text with Value}
    procedure SetSoftValidation(Value : Boolean);
      {-sets the SoftValidation option}
    procedure SetStripLiterals(Value : Boolean);
      {-set the strip literals option}
    procedure SetTextMargin(Value : Integer);
      {-set the text margin}
    procedure SetTrimBlanks(Value : Boolean);
      {-set the trim blanks option}
    procedure SetUninitialized(Value : Boolean);
      {-sets the Uninitialized option}
    procedure SetUserData(Value : TOvcUserData);
      {-sets user-defined mask data object}
    procedure SetZeroDisplay(Value : TZeroDisplay);
      {-set flag that determines if ZeroDisplayValue is hidden}
    procedure SetZeroDisplayValue(Value : Double);
      {-set value used by ZeroDisplay logic}

    {internal methods}
    procedure efCalcTopMargin;
      {-determines the top text margin}
    procedure efColorChanged(AColor : TObject);
      {-highlight or error color change-repaint}
    function efGetEpoch : Integer;
      {-return field's or controller's epoch value}
    function efGetTextExtent(S : PAnsiChar; Len : Integer) : Word;         {!!.10}
      {-return the display width of text passed in S}
    procedure efInitializeDataSize;
      {-set the data size for this fiedl type}
    function  efIsSibling(HW : hWnd) : Boolean;
      {-is the window HW one of our siblings}
    procedure efMoveFocus(C : TWinControl);
      {-ask the controller to move the focus to the specified control}
    procedure efPerformEdit(var Msg : TMessage; Cmd : Word);
      {-primitive routine to process the specified editing command}
    procedure efPerformPreEditNotify(C : TWinControl);
      {-pre-edit notification to parent form}
    procedure efPerformPostEditNotify(C : TWinControl);
      {-post-edit notification to parent form}
    procedure efReadRangeHi(Stream : TStream);
      {-called to read the high range from the stream}
    procedure efReadRangeLo(Stream : TStream);
      {-called to read the low range from the stream}
    function efTransferPrim(DataPtr : Pointer; TransferFlag : Word) : Word;
      {-primitive routine to reset for new data in field}
    procedure efWriteRangeHi(Stream : TStream);
      {-called to store the high range on the stream}
    procedure efWriteRangeLo(Stream : TStream);
      {-called to store the low range on the stream}

    {VCL control methods}
    procedure CMCtl3DChanged(var Msg : TMessage);                      {!!.01}
      message CM_CTL3DCHANGED;
    procedure CMDialogChar(var Msg : TCMDialogChar);
      message CM_DIALOGCHAR;
    procedure CMEnabledChanged(var Msg : TMessage);
      message CM_ENABLEDCHANGED;
    procedure CMFontChanged(var Msg : TMessage);
      message CM_FONTCHANGED;

    {private message response methods}
    procedure OMGetDataSize(var Msg : TMessage);
      message om_GetDataSize;
    procedure OMReportError(var Msg : TOMReportError);
      message om_ReportError;

    {windows message response methods}
    procedure WMChar(var Msg : TWMChar);
      message WM_CHAR;
    procedure WMClear(var Msg : TWMClear);
      message WM_CLEAR;
    procedure WMCopy(var Msg : TWMCopy);
      message WM_COPY;
    procedure WMCut(var Msg : TWMCut);
      message WM_CUT;
    procedure WMEraseBkGnd(var Msg : TWMEraseBkGnd);
      message WM_ERASEBKGND;
    procedure WMGetDlgCode(var Msg : TWMGetDlgCode);
      message WM_GETDLGCODE;
    procedure WMKeyDown(var Msg : TWMKeyDown);
      message WM_KEYDOWN;
    procedure WMKillFocus(var Msg : TWMKillFocus);
      message WM_KILLFOCUS;
    procedure WMLButtonDblClk(var Msg : TWMLButtonDblClk);
      message WM_LBUTTONDBLCLK;
    procedure WMLButtonDown(var Msg : TWMLButtonDown);
      message WM_LBUTTONDOWN;
    procedure WMMouseActivate(var Msg : TWMMouseActivate);
      message WM_MOUSEACTIVATE;
    procedure WMMouseMove(var Msg : TWMMouseMove);
      message WM_MOUSEMOVE;
    procedure WMPaste(var Msg : TWMPaste);
      message WM_PASTE;
    procedure WMRButtonUp(var Msg : TWMRButtonDown);                   {!!.13}
      message WM_RBUTTONUP;
    procedure WMSetFocus(var Msg : TWMSetFocus);
      message WM_SETFOCUS;
    procedure WMSetFont(var Msg : TWMSetFont);
      message WM_SETFONT;
    procedure WMSetText(var Msg : TWMSetText);
      message WM_SETTEXT;
    procedure WMSize(var Msg : TWMSize);
      message WM_SIZE;
    procedure WMSysKeyDown(var Msg : TWMSysKeyDown);
      message WM_SYSKEYDOWN;

    {edit control message methods}
    procedure EMGetModify(var Msg : TMessage);
      message EM_GETMODIFY;
    procedure EMGetSel(var Msg : TMessage);
      message EM_GETSEL;
    procedure EMSetModify(var Msg : TMessage);
      message EM_SETMODIFY;
    procedure EMSetSel(var Msg : TMessage);
      message EM_SETSEL;

  protected
    {VCL methods}
    procedure CreateParams(var Params : TCreateParams);
      override;
    procedure CreateWnd;
      override;
    procedure DefineProperties(Filer : TFiler);
      override;
    procedure Paint;
      override;

    {dynamic event wrappers}
    procedure DoOnChange;
      dynamic;
      {-perform notification of a change}
    procedure DoOnError(ErrorCode : Word; ErrorMsg : AnsiString);
      dynamic;
      {-perform notification of an error}
    procedure DoOnUserCommand(Command : Word);
      dynamic;
      {-perform notification of a user command}
    procedure DoOnUserValidation(var ErrorCode : Word);
      dynamic;
      {-perform call to user validation event handler}

    {!!.13} {added next six methods}
    procedure DoRestoreClick(Sender : TObject);
      dynamic;
    procedure DoCutClick(Sender : TObject);
      dynamic;
    procedure DoCopyClick(Sender : TObject);
      dynamic;
    procedure DoPasteClick(Sender : TObject);
      dynamic;
    procedure DoDeleteClick(Sender : TObject);
      dynamic;
    procedure DoSelectAllClick(Sender : TObject);
      dynamic;

    procedure efAdjustSize;
      dynamic;
      {-adjust the size of the control based on the current font}
    function efCanClose(DoValidation : Boolean) : Boolean;
      virtual;
      {-returns true if the field contents are valid}
    procedure efCaretToEnd;
      virtual;
      {-move the caret to the end of the field}
    procedure efCaretToStart;
      virtual;
      {-move the caret to the beginning of the field}
    procedure efChangeMask(Mask : PAnsiChar);
      dynamic;
      {-change the picture mask}
    function  efCharOK(PicChar : AnsiChar; var Ch : AnsiChar;
                     PrevCh : AnsiChar; Fix : Boolean) : Boolean;
      {-return True if Ch is in character set corresponding to PicChar}
    procedure efConditionalBeep;
      {-beep if pefBeepOnError option is active}
    procedure efCopyPrim;
      {-Primitive clipboard copy method}
    function efBinStr2Long(St : PAnsiChar; var L : LongInt) : Boolean;
      {-convert a binary AnsiString to a longint}
    function efCalcDataSize(St : PAnsiChar; MaxLen : Word) : Word;
      {-calculate data size of a AnsiString field with literal stripping option on}
    procedure efEdit(var Msg : TMessage; Cmd : Word);
      virtual; abstract;
      {-process the specified editing command}
    function  efEditBegin : Word;
      virtual;
      {-return offset of first editable position in field}
    function  efFieldIsEmpty : Boolean;
      virtual;
      {-return True if the field is empty}
    procedure efFieldModified;
      {-mark the field as modified; tell parent form it changed}
    procedure efFindCtrlChars(P : PAnsiChar; var ChCnt, CtCnt : Integer);
      {-find control caracters and return normal and control char counts}
    procedure efFixCase(PicChar : AnsiChar; var Ch : AnsiChar; PrevCh : AnsiChar);
      {-fix the case of Ch based on PicChar}
    function efGetDisplayString(Dest : PAnsiChar; Size : Word) : PAnsiChar;
      virtual;
      {-return the display AnsiString in Dest and a pointer as the result}
    function  efGetMousePos(MPos : Integer) : Integer;
      {-get the position of a mouse click}
    procedure efGetSampleDisplayData(T : PAnsiChar);
      dynamic;
      {-return sample data for the current field type}
    procedure efIncDecValue(Wrap : Boolean; Delta : Double);
      dynamic; abstract;
      {-increment field by Delta}
    function  efIsNumericType : Boolean;
      {-return True if field is of a numeric type}
    function  efIsReadOnly : Boolean;
      virtual;
      {-return True if field is read-only}
    procedure efLong2Str(P : PAnsiChar; L : LongInt);
      {-convert a longint to a AnsiString}
    procedure efMapControlChars(Dest, Src : PAnsiChar);
      {-copy from Src to Dest, mapping control characters to alph in process}
    procedure efMoveFocusToNextField;
      dynamic;
      {-give next field the focus}
    procedure efMoveFocusToPrevField;
      dynamic;
      {-give previous field the focus}
    function  efNthMaskChar(N : Word) : AnsiChar;
      {-return the N'th character in the picture mask. N is 0-based}
    function efOctStr2Long(St : PAnsiChar; var L : LongInt) : Boolean;
      {-convert an octal AnsiString to a longint}
    procedure efPaintPrim(DC : hDC; CR : TRect; Offset : Integer);
      {-primitive routine to draw the entry field control}
    procedure efPerformRepaint(Modified : Boolean);
      {-flag the field as modified and redraw it}
    function  efPositionCaret(Adjust : Boolean) : Boolean;
      {-position the editing caret}
    function efRangeToStRange(const Value : TRangeType) : AnsiString;
      {-returns the range as a AnsiString}
    function efStRangeToRange(const Value : AnsiString; var R : TRangeType) : Boolean;
      {-converts a AnsiString range to a RangeType}
    procedure efRemoveBadOptions;
      virtual;
      {-remove inappropriate options for this field and data type}
    procedure efResetCaret;
      virtual;
      {-move the caret to the beginning or end of the field, as appropriate}
    procedure efSaveEditString;
      {-save a copy of the edit AnsiString}
    procedure efSetDefaultRange(FT : Byte);
      {-set the default range for the given field type}
    procedure efSetInitialValue;
      {-set the initial value of the field}
    function efStr2Long(P : PAnsiChar; var L : LongInt) : Boolean;
      {-convert a AnsiString to a longint}
    function efTransfer(DataPtr : Pointer; TransferFlag : Word) : Word;
      virtual;
      {-transfer data to/from the entry fields}
    function efValidateField : Word;
      virtual; abstract;
      {-validate contents of field; result is error code or 0}

    {virtual property methods}
    procedure efSetCaretPos(Value : Integer);
      virtual;
      {-set position of the caret within the field}
    procedure SetAsString(const Value : AnsiString);
      virtual;
      {-sets the field value to a AnsiString Value}
    procedure SetName(const Value : TComponentName);
      override;
      {-catch when component name is changed}

  public
    constructor Create(AOwner : TComponent);
      override;
    destructor  Destroy;
      override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight : Integer);       {!!.D4}
      override;
  {.Z-}

    procedure ClearContents;
      {-clear the contents of the entry field}
    procedure ClearSelection;
      {-erase the highlighted text}
    procedure CopyToClipboard;
      {-copies the highlighted text to the clipboard}
    procedure CutToClipboard;
      dynamic;
      {-performs a CopyToClipboard then deletes the highlighted text from the field}
    procedure DecreaseValue(Wrap : Boolean; Delta : Double);
      {-decrease the value of the field by Delta, wrapping if enabled}
    procedure Deselect;
      {-unhighlight any highlighted text}
    function FieldIsEmpty : Boolean;
      {-return True if the field is completely empty}
    function GetStrippedEditString : AnsiString;
      dynamic;
      {-return edit AnsiString stripped of literals and semi-literals}
    function GetValue(var Data) : Word;
      {-returns the current field value in Data. Result is 0 or error code}
    procedure IncreaseValue(Wrap : Boolean; Delta : Double);
      {-increase the value of the field by Delta, wrapping if enabled}
    function IsValid : Boolean;
      {-returns true if the field is not marked as invalid}
    procedure MergeWithPicture(const S : AnsiString);
      dynamic;
      {-combines S with the picture mask and updates the edit AnsiString}
    procedure MoveCaret(Delta : Integer);
      {-moves the caret to the right or left Value positions}
    procedure MoveCaretToEnd;
      {-move the caret to the end of the field}
    procedure MoveCaretToStart;
      {-move the caret to the beginning of the field}
    procedure PasteFromClipboard;
      dynamic;
      {-places the text content of the clipboard into the field}
    procedure ProcessCommand(Cmd, CharCode : Word);
      {-process the specified command}
    procedure ResetCaret;
      {-move the caret to the beginning or end of the field, as appropriate}
    procedure Restore;
      dynamic;
      {-restore the previous contents of the field}
    procedure SelectAll;
      {-selects the current edit text}
    procedure SetInitialValue;
      {-resets the field value to its initial value}
    procedure SetRangeHi(const Value : TRangeType);
      {-set the high range for this field}
    procedure SetRangeLo(const Value : TRangeType);
      {-set the low range for this field}
    procedure SetSelection(Start, Stop : Word);
      {-mark offsets Start..Stop as selected}
    procedure SetValue(const Data);
      {-changes the field's value to the value in Data}
    function ValidateContents(ReportError : Boolean) : Word;
      dynamic;                                                         {!!.16}
      {-performs field validation, returns error code, and conditionally reports error}
    function ValidateSelf : Boolean;
      {-performs field validation, returns true if no errors, and reports error}

    {public properties}
    property AsBoolean : Boolean
      read GetAsBoolean
      write SetAsBoolean;

    property AsCents : LongInt
      read GetAsCents
      write SetAsCents;

    property AsDateTime : TDateTime
      read GetAsDateTime
      write SetAsDateTime;

    property AsExtended : Extended
      read GetAsExtended
      write SetAsExtended;

    property AsFloat : Double
      read GetAsFloat
      write SetAsFloat;

    property AsInteger : Longint
      read GetAsInteger
      write SetAsInteger;

    property AsOvcDate : TOvcDate
      read GetAsStDate
      write SetAsStDate;

    property AsOvcTime : TOvcTime
      read GetAsStTime
      write SetAsStTime;

    property AsString : AnsiString
      read GetAsString
      write SetAsString;

    {$IFDEF Win32}
    property AsVariant : Variant
      read GetAsVariant
      write SetAsVariant;
    {$ENDIF}

    property AsStDate : TStDate
      read GetAsStDate
      write SetAsStDate;

    property AsStTime : TStTime
      read GetAsStTime
      write SetAsStTime;

    property Font;
    property Canvas;
    property Color;

    property CurrentPos : Integer
      read GetCurrentPos
      write efSetCaretPos;

    property DataSize : Word
      read GetDataSize;

    property DisplayString : AnsiString
      read GetDisplayString;

    property EditString : AnsiString
      read GetEditString;

    property Epoch : Integer
      read FEpoch
      write SetEpoch;

    property EverModified : Boolean
      read GetEverModified
      write SetEverModified;

  {.Z+}
    property InsertMode : Boolean
      read GetInsertMode
      write SetInsertMode;
  {.Z-}

    property IntlSupport : TOvcIntlSup
      read FIntlSup
      write SetIntlSupport;

    property LastError : Word
      read FLastError;

    property Modified : Boolean
      read GetModified
      write SetModified;

    property SelectionLength : Integer
      read GetSelLength
      write SetSelLength;

    property SelectionStart : Integer
      read GetSelStart
      write SetSelStart;

    property SelectedText : AnsiString
      read GetSelText                                                  {!!.13}
      write SetSelText;                                                {!!.13}

    property Text : AnsiString
      read GetAsString
      write SetAsString;

    property UserData :  TOvcUserData
      read FUserData
      write SetUserData;

    {publishable properties}
    property ArrowIncDec : Boolean
      read FArrowIncDec
      write SetArrowIncDec
      default efDefArrowIncDec;

    property AutoAdvanceChar : Boolean
      read FAutoAdvanceChar
      write SetAutoAdvanceChar
      default efDefAutoAdvanceChar;

    property AutoAdvanceLeftRight : Boolean
      read FAutoAdvanceLR
      write SetAutoAdvanceLeftRight
      default efDefAutoAdvanceLR;

    property AutoAdvanceUpDown : Boolean                               {!!.10}
      read FAutoAdvanceUD
      write SetAutoAdvanceUpDown
      default efDefAutoAdvanceUD;

    property AutoSelect : Boolean
      read FAutoSelect
      write SetAutoSelect
      default efDefAutoSelect;

    property AutoSize : Boolean
      read FAutoSize
      write SetAutoSize
      default efDefAutoSize;

    property BeepOnError : Boolean
      read FBeepOnError
      write FBeepOnError
      default efDefBeepOnError;

    property BorderStyle : TBorderStyle
      read FBorderStyle
      write SetBorderStyle
      default efDefBorderStyle;

    property CaretIns : TOvcCaret
      read GetInsCaretType
      write SetInsCaretType;

    property CaretOvr : TOvcCaret
      read GetOvrCaretType
      write SetOvrCaretType;

    property CaretToEnd : Boolean
      read FCaretToEnd
      write SetCaretToEnd
      default efDefCaretToEnd;

    property ControlCharColor : TColor
      read FCtrlColor
      write FCtrlColor
      default efDefCtrlColor;

    property DecimalPlaces : Byte
      read FDecimalPlaces
      write SetDecimalPlaces
      default efDefDecimalPlaces;

    property DisabledColors : TOvcColors                               {!!.12}
      read FDisabledColors
      write FDisabledColors;

    property ErrorColors : TOvcColors
      read FErrorColors
      write FErrorColors;

    property ForceInsert : Boolean
      read FForceInsert
      write SetForceInsert
      default efDefForceInsert;

    property ForceOvertype : Boolean
      read FForceOvertype
      write SetForceOvertype
      default efDefForceOvertype;

    property HighlightColors : TOvcColors
      read FHighlightColors
      write FHighlightColors;

    property InputRequired : Boolean
      read FInputRequired
      write SetInputRequired
      default efDefInputRequired;

    property InsertPushes : Boolean
      read FInsertPushes
      write SetInsertPushes
      default efDefInsertPushes;

    property MaxLength : Word
      read FMaxLength
      write SetMaxLength;

    property PadChar : AnsiChar
      read FPadChar
      write SetPadChar
      default DefPadChar;

    property PasswordChar : AnsiChar
      read FPasswordChar
      write SetPasswordChar
      default efDefPasswordChar;

    property PasswordMode : Boolean
      read FPasswordMode
      write SetPasswordMode
      default efDefPasswordMode;

    property RangeHi : AnsiString
      read GetRangeHiStr
      write SetRangeHiStr
      stored False;

    property RangeLo : AnsiString
      read GetRangeLoStr
      write SetRangeLoStr
      stored False;

    property ReadOnly : Boolean
      read FReadOnly
      write SetReadOnly
      default efDefReadOnly;

    property RightAlign : Boolean                                      {!!.10}
      read FRightAlign
      write SetRightAlign
      default efDefRightAlign;

    property RightJustify : Boolean
      read FRightJustify
      write SetRightJustify
      default efDefRightJustify;

    property SoftValidation : Boolean
      read FSoftValidation
      write SetSoftValidation
      default efDefSoftValidation;

    property StripLiterals : Boolean
      read FStripLiterals
      write SetStripLiterals
      default efDefStripLiterals;

    property TextMargin : Integer
      read FTextMargin
      write SetTextMargin
      default efDefTextMargin;

    property TrimBlanks : Boolean
      read FTrimBlanks
      write SetTrimBlanks
      default efDefTrimBlanks;

    property Uninitialized : Boolean
      read FUninitialized
      write SetUninitialized
      default efDefUninitialized;

    property ZeroDisplay : TZeroDisplay
      read FZeroDisplay
      write SetZeroDisplay
      default efDefZeroDisplay;

    property ZeroDisplayValue : Double
      read FZeroDisplayValue
      write SetZeroDisplayValue;

    {events}
    property OnChange : TNotifyEvent
      read FOnChange
      write FOnChange;

    property OnError : TValidationErrorEvent
      read FOnError
      write FOnError;

    property OnUserCommand : TUserCommandEvent
      read FOnUserCommand
      write FOnUserCommand;

    property OnUserValidation : TUserValidationEvent
      read FOnUserValidation
      write FOnUserValidation;
  published
  end;


implementation

{$IFDEF TRIALRUN}
uses OrTrial;
{$I ORTRIALF.INC}
{$ENDIF}


{*** TOvcBaseEntryField ***}

procedure TOvcBaseEntryField.ClearContents;
  {-erases the contents of the edit field}
var
  RO     : Boolean;
begin
  if HandleAllocated then begin
    RO := FReadOnly;  {store current read only state}
    FReadOnly := False;

    {set the updating flag so OnChange doesn't get fired}
    Include(sefOptions, sefUpdating);
    SetWindowText(Handle, '');
    Exclude(sefOptions, sefUpdating);
    FReadOnly := RO;  {restore previous state}
  end;
end;

procedure TOvcBaseEntryField.ClearSelection;
  {-erases the selected text}
begin
  if HandleAllocated then
    Perform(WM_CLEAR, 0, 0);
end;

{!!.01} {added}
procedure TOvcBaseEntryField.CMCtl3DChanged(var Msg : TMessage);
begin
  if (csLoading in ComponentState) then
    Exit;

  if not HandleAllocated then
    Exit;

  {$IFDEF Win32}
  if NewStyleControls and (FBorderStyle = bsSingle) then begin
    RecreateWnd;
    efAdjustSize;
  end;
  {$ENDIF}

  efCalcTopMargin;

  inherited;
end;

procedure TOvcBaseEntryField.CMDialogChar(var Msg : TCMDialogChar);
begin
  {see if this is an Alt-Backspace key sequence (Alt flag is bit 29}
  if (Msg.CharCode = VK_BACK) and (HiWord(Msg.KeyData) and $2000 <> 0) then
    {don't pass it on as a dialog character since we use it as}
    {the restore command by default}
    Msg.Result := 1;

  inherited;
end;

procedure TOvcBaseEntryField.CMEnabledChanged(var Msg : TMessage);
begin
  inherited;

  Repaint;
end;

procedure TOvcBaseEntryField.CMFontChanged(var Msg : TMessage);
begin
  inherited;

  if (csLoading in ComponentState) then
    Exit;

  if not HandleAllocated then
    Exit;

  {efCalcTopMargin;}                                                   {!!.01}
  efAdjustSize; {adjust height based on font}
  efCalcTopMargin;                                                     {!!.01}

  if GetFocus = Handle then
    efPositionCaret(False);  {adjust caret for new font}
end;

procedure TOvcBaseEntryField.CopyToClipboard;
  {-copies the selected text to the clipboard}
begin
  if HandleAllocated then
    Perform(WM_COPY, 0, 0);
end;

constructor TOvcBaseEntryField.Create(AOwner : TComponent);
const
  CStyle = [csClickEvents, csCaptureMouse, csOpaque];                  {!!.01}
begin
  inherited Create(AOwner);

  {!!.01} {revised}
  {$IFDEF Win32}
  if NewStyleControls then
    ControlStyle := ControlStyle + CStyle
  else
    ControlStyle := ControlStyle + CStyle + [csFramed];
  {$ELSE}
    ControlStyle := ControlStyle + CStyle + [csFramed];
  {$ENDIF}

  Cursor             := crIBeam;
  Height             := efDefHeight;
  TabStop            := efDefTabStop;
  ParentColor        := efDefParentColor;
  Width              := efDefWidth;

  {defaults}
  FArrowIncDec       := efDefArrowIncDec;                            {!!.10}
  FAutoAdvanceChar   := efDefAutoAdvanceChar;
  FAutoAdvanceLR     := efDefAutoAdvanceLR;
  FAutoAdvanceUD     := efDefAutoAdvanceUD;
  FBeepOnError       := efDefBeepOnError;
  FAutoSelect        := efDefAutoSelect;
  FAutoSize          := efDefAutoSize;
  FBorderStyle       := efDefBorderStyle;
  FCaretToEnd        := efDefCaretToEnd;
  FCtrlColor         := efDefCtrlColor;
  FDecimalPlaces     := efDefDecimalPlaces;
  FInputRequired     := efDefInputRequired;
  FInsertPushes      := efDefInsertPushes;
  FForceInsert       := efDefForceInsert;
  FForceOvertype     := efDefForceOvertype;
  FMaxLength         := efDefMaxLength;
  FPadChar           := DefPadChar;
  FPasswordChar      := efDefPasswordChar;
  FPasswordMode      := efDefPasswordMode;
  FReadOnly          := efDefReadOnly;
  FRightAlign        := efDefRightAlign;                               {!!.10}
  FRightJustify      := efDefRightJustify;
  FSoftValidation    := efDefSoftValidation;
  FStripLiterals     := efDefStripLiterals;
  FTextMargin        := efDefTextMargin;
  FTrimBlanks        := efDefTrimBlanks;
  FUninitialized     := efDefUninitialized;
  FZeroDisplay       := efDefZeroDisplay;
  FZeroDisplayValue  := efDefZeroDisplayValue;

  efRangeLo          := BlankRange;
  efRangeHi          := BlankRange;

  {default picture and field settings}
  efPicture[0]       := 'X';
  efPicture[1]       := #0;
  efPicLen           := 1;
  efFieldClass       := fcSimple;
  efDataType         := fidSimpleString;

  {assign default user data object}
  FUserData          := OvcUserData;

  {assign default international support object}
  FIntlSup           := OvcIntlSup;

  {create the caret class}
  efCaret := TOvcCaretPair.Create(Self);

  {init edit and save edit strings}
  FillChar(efEditSt, MaxEditLen, #0);
  efSaveEdit := nil;

  {create colors objects and assign defaults}
  FDisabledColors := TOvcColors.Create(efDefDisabledText, efDefDisabledBack); {!!.12}
  FErrorColors := TOvcColors.Create(efDefErrorText, efDefErrorBack);
  FHighlightColors := TOvcColors.Create(efDefHighlightText, efDefHighlightBack);

  {assign color change notification methods}
  FDisabledColors.OnColorChange := efColorChanged;                     {!!.12}
  FErrorColors.OnColorChange := efColorChanged;
  FHighlightColors.OnColorChange := efColorChanged;

  efCalcTopMargin;
end;

procedure TOvcBaseEntryField.CreateParams(var Params : TCreateParams);
begin
  inherited CreateParams(Params);

  Params.Style := LongInt(Params.Style) or BorderStyles[FBorderStyle]; {!!.D4}

  {!!.01} {added}
  {$IFDEF Win32}
  if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then begin
    Params.Style := Params.Style and not WS_BORDER;
    Params.ExStyle := Params.ExStyle or WS_EX_CLIENTEDGE;
  end;
  {$ENDIF}

  {set picture length and check MaxLength}
  efPicLen := StrLen(efPicture);
  if FMaxLength = 0 then
    FMaxLength := efPicLen;

  {reset secondary options}
  sefOptions := sefDefOptions;
end;

procedure TOvcBaseEntryField.CreateWnd;
begin
  inherited CreateWnd;

  efHOffset    := 0;
  efHPos       := 0;
  efSelStart   := 0;
  efSelEnd     := 0;

  {set efDataSize for this field type}
  efInitializeDataSize;

  {if input is required then these fields must also be uninitialized}
  if InputRequired then
    case efDataType mod fcpDivisor of
      fsubChar, fsubBoolean, fsubYesNo, fsubLongInt,
      fsubWord, fsubInteger, fsubByte, fsubShortInt,
      fsubReal, fsubExtended, fsubDouble, fsubSingle,
      fsubComp : Uninitialized := True;
    end;

  {is it a hex, binary, octal, and/or numeric field?}
  if StrScan(efPicture, pmHexadecimal) <> nil then
    Include(sefOptions, sefHexadecimal)
  else
    Exclude(sefOptions, sefHexadecimal);

  if StrScan(efPicture, pmBinary) <> nil then
    Include(sefOptions, sefBinary)
  else
    Exclude(sefOptions, sefBinary);

  if StrScan(efPicture, pmOctal) <> nil then
    Include(sefOptions, sefOctal)
  else
    Exclude(sefOptions, sefOctal);

  if efFieldClass = fcNumeric then
    Include(sefOptions, sefNumeric)
  else
    Exclude(sefOptions, sefNumeric);

  {assume no literals in mask}
  Include(sefOptions, sefNoLiterals);

  {reject bad options}
  efRemoveBadOptions;

  {set canvas font to selected font}
  Canvas.Font := Font;

  efAdjustSize; {adjust height based on font}
  efCalcTopMargin;                                                     {!!.01}

  efRightAlignActive := FRightAlign;                                   {!!.10}
end;

procedure TOvcBaseEntryField.CutToClipboard;
  {-erases the selected text and places it in the clipboard}
begin
  if HandleAllocated then
    Perform(WM_CUT, 0, 0);
end;

procedure TOvcBaseEntryField.DefineProperties(Filer : TFiler);
var
  Save : Boolean;
begin
  inherited DefineProperties(Filer);

  Save := not (efDataType mod fcpDivisor in [fsubString, fsubBoolean, fsubYesNo]);

  Filer.DefineBinaryProperty('RangeHigh', efReadRangeHi, efWriteRangeHi, Save);
  Filer.DefineBinaryProperty('RangeLow', efReadRangeLo, efWriteRangeLo, Save);
end;

procedure TOvcBaseEntryField.DecreaseValue(Wrap : Boolean; Delta : Double);
  {-decrease the value of the field by Delta, wrapping if enabled}
begin
  SendMessage(Handle, WM_SETREDRAW, 0, 0);
  efIncDecValue(Wrap, -Delta);
  SetSelection(0, 0);
  SendMessage(Handle, WM_SETREDRAW, 1, 0);
  Refresh;
end;

procedure TOvcBaseEntryField.Deselect;
  {-unhighlight any highlighted text}
begin
  SetSelection(0, 0);
end;

destructor TOvcBaseEntryField.Destroy;
var                                                                    {!!.16}
  PF : TCustomForm;                                                    {!!.16}
begin
  if Focused then begin                                                {!!.16}
    PF := GetParentForm(Self);                                         {!!.16}
    PF.DefocusControl(Self, True);                                     {!!.16}
  end;                                                                 {!!.16}

  {dispose of the  caret object}
  efCaret.Free;

  {dispose of the color objects}
  FDisabledColors.Free;                                                {!!.12}
  FErrorColors.Free;
  FHighlightColors.Free;

  {dispose of the saved edit AnsiString}
  if efSaveEdit <> nil then
    StrDispose(efSaveEdit);

  inherited Destroy;
end;

procedure TOvcBaseEntryField.DoOnChange;
  {-perform notification of a change}
begin
  if Assigned(FOnChange) and not (sefUpdating in sefOptions) then
    FOnChange(Self);
end;

procedure TOvcBaseEntryField.DoOnError(ErrorCode : Word; ErrorMsg : AnsiString);
begin
  if Assigned(FOnError) then
    FOnError(Self, ErrorCode, ErrorMsg)
  else
    Controller.DoOnError(Self, ErrorCode, ErrorMsg);
end;

procedure TOvcBaseEntryField.DoOnUserCommand(Command : Word);
  {-perform notification of a user command}
begin
  if Assigned(FOnUserCommand) then
    FOnUserCommand(Self, Command);
end;

procedure TOvcBaseEntryField.DoOnUserValidation(var ErrorCode : Word);
  {-perform call to user validation event handler}
begin
  if Assigned(FOnUserValidation) then
    if not (sefNoUserValidate in sefOptions) then                      {!!.01}
      FOnUserValidation(Self, ErrorCode);
end;

{!!.13} {Added}
procedure TOvcBaseEntryField.DoRestoreClick(Sender : TObject);
begin
  Restore;
  efPositionCaret(True);
end;

{!!.13} {Added}
procedure TOvcBaseEntryField.DoCutClick(Sender : TObject);
begin
  CutToClipboard
end;

{!!.13} {Added}
procedure TOvcBaseEntryField.DoCopyClick(Sender : TObject);
begin
  CopyToClipboard;
end;

{!!.13} {Added}
procedure TOvcBaseEntryField.DoPasteClick(Sender : TObject);
begin
  PasteFromClipboard;
end;

{!!.13} {Added}
procedure TOvcBaseEntryField.DoDeleteClick(Sender : TObject);
begin
  ClearSelection;
end;

{!!.13} {Added}
procedure TOvcBaseEntryField.DoSelectAllClick(Sender : TObject);
begin
  SelectAll;
end;

procedure TOvcBaseEntryField.efAdjustSize;
  {-adjust the height of the control based on the current font}
var
  DC         : hDC;
  SaveFont   : hFont;
  I          : Integer;
  SysMetrics : TTextMetric;
  Metrics    : TTextMetric;
begin
  if not FAutoSize then
    Exit;

  DC := GetDC(0);
  try
    GetTextMetrics(DC, SysMetrics);
    SaveFont := SelectObject(DC, Font.Handle);
    GetTextMetrics(DC, Metrics);
    SelectObject(DC, SaveFont);
  finally
    ReleaseDC(0, DC);
  end;

  {!!.01} {revised}
  if NewStyleControls then begin
    {$IFDEF Win32}
    if Ctl3D then
      I := 8
    else
      I := 6;
    {$ELSE}
      I := 6;
    {$ENDIF}
    I := GetSystemMetrics(SM_CYBORDER) * I;
  end else begin
    I := SysMetrics.tmHeight;
    if I > Metrics.tmHeight then
      I := Metrics.tmHeight;
    I := I div 4 + GetSystemMetrics(SM_CYBORDER) * 4;
  end;

  Height := Metrics.tmHeight + I;

  {SetBounds may have turn this off, turn it back on}
  if not FAutoSize then
    FAutoSize := True;
end;

function TOvcBaseEntryField.efBinStr2Long(St : PAnsiChar; var L : LongInt) : Boolean;
  {-convert a binary AnsiString to a longint}
var
  BitNum  : Word;
  Len     : Word;
  LT      : LongInt;
begin
  Result := False;
  Len := StrLen(St);
  BitNum := 0;
  LT := 0;
  while Len > 0 do begin
    Dec(Len);
    case St[Len] of
      '0' : {OK};
      '1' : if BitNum > 31 then
              Exit
            else
              Inc(LT, LongInt(1) shl BitNum);
      else  Exit;
    end;
    Inc(BitNum);
  end;
  L := LT;
  Result := True;
end;

function TOvcBaseEntryField.efCalcDataSize(St : PAnsiChar; MaxLen : Word) : Word;
  {-calculate data size of a AnsiString field with literal stripping option on}
var
  I, L : Word;
begin
  I := 0;
  L := StrLen(St);
  while St^ <> #0 do begin
    if (St^ in PictureChars) then
      Inc(I)
    else case St^ of
      pmFloatDollar, pmComma : Inc(I);
    end;
    Inc(St);
  end;
  Result := I+(MaxLen-L)+1;
end;

function TOvcBaseEntryField.efCanClose(DoValidation : Boolean) : Boolean;
var
  SoftV  : Boolean;
begin
  Result := True;

  {don't do any of this if we're hidden or not enabled}
  if (not Visible) or (not Enabled) then
    Exit;

  HandleNeeded;

  {clear error flag}
  FLastError := 0;

  {check for empty/uninitialized required field}
  if InputRequired and not efIsReadOnly then
    if efFieldIsEmpty or (Uninitialized and not (sefModified in sefOptions)) then
      FLastError := oeRequiredField;

  {ask the validation routine if there's an error}
  if FLastError = 0 then begin
    Include(sefOptions, sefValidating);
    FLastError := efValidateField;
    Exclude(sefOptions, sefValidating);
  end;

  if efHPos > LongInt(StrLen(efEditSt)) then                           {!!.D4}
    efHPos := LongInt(StrLen(efEditSt));                               {!!.D4}

  if FLastError = 0 then
    Exclude(sefOptions, sefInvalid)
  else begin
    if DoValidation and SoftValidation then begin
      Include(sefOptions, sefInvalid);
      Result := True;  {say we can close, error is in FLastError}
      Exit;
    end else begin
      if SoftValidation then
        Include(sefOptions, sefInvalid);

      {set flag to indicate that an error is pending}
      Include(sefOptions, sefErrorPending);

      {keep the caret where it is if we have the focus}
      if sefHaveFocus in sefOptions then
        Include(sefOptions, sefRetainPos);

      {force soft validation on}
      SoftV := SoftValidation;
      FSoftValidation := True;
      try
        {ask the parent form to give us back the focus}
        efMoveFocus(Self);

        {report the error}
        if not Controller.ErrorPending then
          PostMessage(Handle, om_ReportError, FLastError, 0);

        {set controller's error pending flag}
        Controller.ErrorPending := True;
      finally
        {restore old options}
        FSoftValidation := SoftV;
      end;
    end;
  end;

  Result := FLastError = 0;
end;

procedure TOvcBaseEntryField.efCaretToEnd;
  {-move the caret to the end of the field}
begin
  efHPos := StrLen(efEditSt);
end;

procedure TOvcBaseEntryField.efCaretToStart;
  {-move the caret to the beginning of the field}
begin
  efHPos := 0;
  efHOffset := 0;
end;

procedure TOvcBaseEntryField.efChangeMask(Mask : PAnsiChar);
  {-change the picture mask}
var
  Buf : array[0..MaxEditLen] of Byte;
begin
  if (Mask <> nil) and (Mask^ <> #0) then begin
    if csLoading in ComponentState then begin
      {change the mask}
      StrLCopy(efPicture, Mask, MaxPicture);
      efPicLen := StrLen(efPicture);
    end else begin
      {save the current field value in tmp buffer}
      efTransfer(@Buf, otf_GetData);

      {change the mask}
      StrLCopy(efPicture, Mask, MaxPicture);
      efPicLen := StrLen(efPicture);

      {reset the field to its former value}
      efTransfer(@Buf, otf_SetData);
    end;
  end;
end;

function TOvcBaseEntryField.efCharOK(PicChar : AnsiChar; var Ch : AnsiChar;
                            PrevCh : AnsiChar; Fix : Boolean) : Boolean;
  {-return True if Ch is in character set corresponding to PicChar}
begin
  if Ch = #0 then begin
    Result := False;
    Exit;
  end;

  if Fix then
    efFixCase(PicChar, Ch, PrevCh);

  {assume it's OK}
  Result := True;

  case PicChar of
    pmAnyChar, pmForceUpper, pmForceLower, pmForceMixed :
      ;
    pmMonthName, pmMonthNameU, pmAlpha, pmUpperAlpha, pmLowerAlpha :
      Result := Ch in AlphaCharSet;
    pmDecimal :
      Result := Ch in RealCharSet;
    pmWhole :
      Result := (Ch = '-') or (Ch in IntegerCharSet);
    pmMonth, pmMonthU, pmDay, pmDayU, pmYear,
    pmHour, pmHourU, pmSecond, pmSecondU,
    pmPositive :
      Result := Ch in IntegerCharSet;
    pmHexadecimal :
      case Ch of
        'A'..'F' : ;
      else
        Result := Ch in IntegerCharSet;
      end;
    pmOctal :
      case Ch of
        '0'..'7', ' ' : ;
      else
        Result := False;
      end;
    pmBinary :
      case Ch of
        '0', '1', ' ' : ;
      else
        Result := False;
      end;
    pmAmPm : {};
    pmTrueFalse :
      Result := (Ch = FIntlSup.TrueChar) or (Ch = FIntlSup.FalseChar);
    pmYesNo :
      Result := (Ch = FIntlSup.YesChar) or (Ch = FIntlSup.NoChar);
    pmScientific :
      case Ch of
        '+', 'E' : ;
        else
          Result := Ch in RealCharSet;
      end;
    pmUser1..pmUser8 :
      Result := Ch in UserData.UserCharSet[PicChar];
  end;
end;

procedure TOvcBaseEntryField.efConditionalBeep;
  {-beep if BeepOnError option is on}
begin
  if BeepOnError then
    MessageBeep(0);
end;

procedure TOvcBaseEntryField.efCopyPrim;
var
  Size : Word;
  H    : THandle;
  GP   : PAnsiChar;
  I    : Word;
  T    : TEditString;

begin
  Size := efSelEnd-efSelStart;
  if Size > 0 then begin
    {allocate global memory block}
    H := GlobalAlloc(GHND, Size+1);
    if H = 0 then
      Exit;

    {copy selected text to global memory block}
    GP := GlobalLock(H);
    efGetDisplayString(T, MaxEditLen);
    StrStCopy(GP, T, efSelStart, Size);

    {remove control characters}
    for I := efSelStart to efSelEnd-1 do
      case efEditSt[I] of
        #1..#31 : GP[I-efSelStart] := efEditSt[I];
      end;

    GlobalUnlock(H);

    {give the handle to the clipboard}
    Clipboard.SetAsHandle(CF_TEXT, H);
  end;
end;

function TOvcBaseEntryField.efEditBegin : Word;
  {-return offset of first editable position in field}
begin
  Result := 0;
end;

function TOvcBaseEntryField.efFieldIsEmpty : Boolean;
  {-return True if the field is empty}
var
  P : PAnsiChar;
begin
  P := efEditSt;
  while P^ = ' ' do
    Inc(P);
  Result := (P^ = #0);
end;

procedure TOvcBaseEntryField.efFieldModified;
  {-mark the field as modified; call notify event}
begin
  Include(sefOptions, sefModified);
  Include(sefOptions, sefEverModified);
  DoOnChange;
end;

{$IFDEF Win32}
{!!.15} {revised}
procedure TOvcBaseEntryField.efFindCtrlChars(P : PAnsiChar; var ChCnt, CtCnt : Integer);
  {-find control caracters and return normal and control char counts}
const
  Space = ' ';
var
  I : Integer;
begin
  ChCnt := 0;
  CtCnt := 0;
  I := 0;
  {count "normal" characters}
  while (I < LongInt(StrLen(P))) and (P[I] >= Space) do begin          {!!.D4}
    Inc(ChCnt);
    Inc(I);
  end;
  {count "control" characters}
  while (I < LongInt(StrLen(P))) and (P[I] < Space) do begin           {!!.D4}
    Inc(CtCnt);
    Inc(I);
  end;
end;

{$ELSE}

procedure TOvcBaseEntryField.efFindCtrlChars(P : PAnsiChar; var ChCnt, CtCnt : Integer); assembler;
  {-find control caracters and return normal and control char counts}
asm
  push ds       {save DS}
  lds si,P      {DS:SI = P}
  xor bx,bx     {char count = 0}
  xor cx,cx     {ctrl count = 0}
  cld           {go forward}
@1:
  lodsb         {next char in AL}
  cmp al,' '    {is it a ctrl char?}
  jb @3         {if so, go to next loop}
  inc bx        {increment character count}
  jmp @1        {get next character}
@2:
  cmp al,' '    {is it a ctrl char?}
  jae @4        {if not, done}
@3:
  or al,al      {is it a null?}
  jz @4         {if so, done}
  inc cx        {increment ctrl count}
  lodsb         {next char in AL}
  jmp @2        {repeat second loop}
@4:
  lds si,ChCnt  {ChCnt = BX}
  mov [si],bx
  lds si,CtCnt  {CtCnt = CX}
  mov [si],cx
  pop ds        {restore DS}
end;
{$ENDIF}

procedure TOvcBaseEntryField.efFixCase(PicChar : AnsiChar; var Ch : AnsiChar; PrevCh : AnsiChar);
  {-fix the case of Ch based on PicChar}
begin
  case PicChar of
    pmMonthNameU, pmForceUpper, pmUpperAlpha, pmTrueFalse,
    pmYesNo, pmScientific, pmHexadecimal :
      Ch := UpCaseChar(Ch);
    pmForceLower, pmLowerAlpha :
      Ch := LoCaseChar(Ch);
    pmForceMixed :
      case PrevCh of
        ' ', '-' :
          Ch := UpCaseChar(Ch);
      end;
    pmAmPm : ;
    pmUser1..pmUser8 :
      case UserData.ForceCase[PicChar] of
        mcUpperCase :
          Ch := UpCaseChar(Ch);
        mcLowerCase :
          Ch := LoCaseChar(Ch);
        mcMixedCase :
          case PrevCh of
            ' ', '-' :
              Ch := UpCaseChar(Ch);
          end;
      end;
  end;
end;

function TOvcBaseEntryField.efGetDisplayString(Dest : PAnsiChar; Size : Word) : PAnsiChar;
  {-return the display AnsiString in Dest and a pointer as the result}
var
  Len   : Word;
  Value : Double;
  Code  : Integer;
  S     : AnsiString;
begin
  FillChar(Dest^, Size, #0);
  efMapControlChars(Dest, efEditSt);

  {see if zero values should be displayed}
  if efIsNumericType and not (sefHaveFocus in sefOptions) then begin
    if (ZeroDisplay = zdHide) or
       ((ZeroDisplay = zdHideUntilModified) and not EverModified) then begin
      S := Trim(GetStrippedEditString);
      Val(S, Value, Code);
      if (Value = ZeroDisplayValue) and (Code = 0) then begin
        Len := StrLen(Dest);
        if Len > 0 then
          FillChar(Dest^, Len, ' ');
      end;
    end;
  end;

  Result := Dest;
end;

{!!.10} {revised to support RightAlign}
function TOvcBaseEntryField.efGetMousePos(MPos : Integer) : Integer;
  {-get the position of a mouse click}
var
  I       : Integer;
  Len     : Integer;
  Ex      : Integer;
  Pos     : Integer;
  S       : PAnsiChar;
  Metrics : TTextMetric;
  TmpSt   : TEditString;
  Done    : Boolean;
  SLen    : Integer;
  X       : Integer;                                                   {!!.13}
begin
  if (MPos < 0) and (efHOffset > 0) then begin
    GetTextMetrics(Canvas.Handle, Metrics);
    I := (Abs(MPos)+Metrics.tmAveCharWidth) div Metrics.tmAveCharWidth;
    Dec(efHOffset, I);
    if efHOffset < 0 then
      efHOffset := 0;
  end;

  {get a copy of the display AnsiString}
  efGetDisplayString(TmpSt, MaxEditLen);
  Len := StrLen(TmpSt);

  if efHOffset > Len then
    I := Len
  else
    I := efHOffset;
  S := @TmpSt[I];

  if efRightAlignActive then begin
    MPos := ClientWidth-FTextMargin-1-MPos;
    Pos := Len + 1;
    I := 0;
  end else begin
    MPos := MPos - TextMargin+1;                                       {!!.13}
    Pos := 0;
  end;

  repeat
    if efRightAlignActive then begin
      Dec(Pos);
      S := @TmpSt[Pos-1];
      SLen := Len - Pos + 1;
    end else begin
      Inc(Pos);
      SLen := Pos;
    end;
    Ex := efGetTextExtent(S, SLen);
    X := (efGetTextExtent(@S[SLen-1], 1) div 2);                       {!!.13}
    if efRightAlignActive then
      Done := (Ex+X > MPos) or (I+Pos < 1)                             {!!.13}
    else
      Done := (Ex-X > MPos) or (I+Pos > Len);                          {!!.13}
  until Done;

  Result := I+(Pos-1);
  if Result < 0 then
    Result := 0;

  if efRightAlignActive then
    if MPos < 1 then
      Result := I+Pos;
end;

procedure TOvcBaseEntryField.efGetSampleDisplayData(T : PAnsiChar);
  {-return sample data for the current field type}
var
  Buf : TEditString;
  I   : Integer;
begin
  {return the picture mask for the sample display data}
  StrLCopy(Buf, efPicture, MaxLength);
  if efFieldClass = fcSimple then begin
    for I := 1 to MaxLength-1 do
      Buf[I] := Buf[I-1];
    Buf[MaxLength] := #0;
  end;
  StrLCopy(T, Buf, MaxLength);
end;

{!!.10} {added}
function TOvcBaseEntryField.efGetTextExtent(S : PAnsiChar; Len : Integer) : Word;
{$IFDEF Win32}
var
  Size : TSize;
{$ENDIF}
begin
  {$IFDEF Win32}
  GetTextExtentPoint32A(Canvas.Handle, S, Len, Size);
  Result := Size.cX;
  {$ELSE}
  Result := LoWord(GetTextExtent(Canvas.Handle, S, Len));
  {$ENDIF}
end;

{!!.01} {revised}
procedure TOvcBaseEntryField.efCalcTopMargin;
begin
  if HandleAllocated then
    efTopMargin := GetTopTextMargin(Font, BorderStyle, Height, Ctl3D)
  else
    efTopMargin := 0;
end;

procedure TOvcBaseEntryField.efColorChanged(AColor : TObject);
  {-highlight or error color change-repaint}
begin
  Repaint;
end;

function TOvcBaseEntryField.efGetEpoch : Integer;
  {-return field's or controller's epoch value}
begin
  Result := FEpoch;
  if (Result = 0) and ControllerAssigned then
    Result := Controller.Epoch;
end;

procedure TOvcBaseEntryField.efInitializeDataSize;
  {-initialize data size}
begin
  case efDataType mod fcpDivisor of
    fsubString   :
      begin
        efDataSize := MaxLength+1;
        {handle special data size cases}
        if efDataType = fidPictureString then
            if StripLiterals then
              efDataSize := efCalcDataSize(efPicture, MaxLength);
      end;

    fsubChar     : efDataSize := SizeOf(AnsiChar);
    fsubBoolean  : efDataSize := SizeOf(Boolean);
    fsubYesNo    : efDataSize := SizeOf(Boolean);
    fsubLongInt  : efDataSize := SizeOf(LongInt);
    fsubWord     : efDataSize := SizeOf(Word);
    fsubInteger  : efDataSize := SizeOf(SmallInt);
    fsubByte     : efDataSize := SizeOf(Byte);
    fsubShortInt : efDataSize := SizeOf(ShortInt);
    fsubReal     : efDataSize := SizeOf(Real);
    fsubExtended : efDataSize := SizeOf(Extended);
    fsubDouble   : efDataSize := SizeOf(Double);
    fsubSingle   : efDataSize := SizeOf(Single);
    fsubComp     : efDataSize := SizeOf(Comp);
    fsubDate     : efDataSize := SizeOf(TStDate);
    fsubTime     : efDataSize := SizeOf(TStTime);
  else
    efDataSize := 0;
  end;
end;

function TOvcBaseEntryField.efIsNumericType : Boolean;
  {-return True if field is of a numeric type}
begin
  case efDataType mod fcpDivisor of
    fsubLongInt, fsubWord, fsubInteger, fsubByte,
    fsubShortInt, fsubReal, fsubExtended, fsubDouble,
    fsubSingle, fsubComp :
      Result := True;
    else
      Result := False;
  end;
end;

function  TOvcBaseEntryField.efIsReadOnly : Boolean;
  {-return True if field is read-only}
begin
  Result := ReadOnly;
end;

function TOvcBaseEntryField.efIsSibling(HW : hWnd) : Boolean;
  {-is the window HW one of our siblings}
var
  C : TWinControl;
  H : hWnd;
begin
  Result := False;
  if HW = 0 then                                                       {!!.13}
    Exit;                                                              {!!.13}

  C := FindControl(HW);

  {see if this window is a child of one of our siblings}
  if not Assigned(C) then begin
    H := GetParent(HW);
    if H > 0 then
      C := FindControl(H);
  end;

  if Assigned(C) then
    if GetParentForm(C) = GetParentForm(Self) then
      Result := True;

  {$IFNDEF Win32}                                                      {!!.14}
  {under Delphi 1.0, if a menu is invoked using a }                    {!!.14}
  {hot key, focus is moved to the form - go figure}                    {!!.14}
  if C = GetParentForm(Self) then                                      {!!.14}
    Result := False;                                                   {!!.14}
  {$ENDIF}                                                             {!!.14}
end;

procedure TOvcBaseEntryField.efLong2Str(P : PAnsiChar; L : LongInt);
  {-convert a longint to a AnsiString}
var
  W  : Word;
  S  : array[0..32] of AnsiChar;
  St : String[32];
begin
  W := efDataSize * 2;
  if sefHexadecimal in sefOptions then begin
    HexLPChar(S, L);
    if W < 8 then
      StrStDeletePrim(S, 0, 8-W);
  end else if sefOctal in sefOptions then begin
    OctalLPChar(S, L);
    if W < 8 then
      StrStDeletePrim(S, 0, 12-(W*2));
  end else if sefBinary in sefOptions then begin
    BinaryLPChar(S, L);
    if W < 8 then
      StrStDeletePrim(S, 0, 32-(W*4));
  end else if L = 0 then begin
    S[0] := '0';
    S[1] := #0;
  end else begin
    Str(L, St);
    StrPCopy(S, St);
  end;
  StrCopy(P, S);
end;

{$IFDEF Win32}
procedure TOvcBaseEntryField.efMapControlChars(Dest, Src : PAnsiChar);
  {-copy from Src to Dest, mapping control characters to alpha in process}
var
  I : Integer;
begin
  StrCopy(Dest, Src);
  for I := 0 to StrLen(Dest)-1 do
    if Dest[I] < ' ' then
      Dest[I] := AnsiChar(Byte(Dest[I])+64);
end;

{$ELSE}

procedure TOvcBaseEntryField.efMapControlChars(Dest, Src : PAnsiChar); assembler;
  {-copy from Src to Dest, mapping control characters to alpha in process}
asm
  push ds           {save ds}
  lds si,Src        {DS:SI = Src}
  les di,Dest       {ES:DI = Dest}
  mov ah,' '        {ah = space}
  cld               {go forward}
@1:
  lodsb             {get the next char}
  stosb             {store the character}
  cmp al,ah         {is it a control char?}
  jae @1            {if not, get the next}
  or al,al          {is it 0?}
  jz @2             {if so, done}
  add al,64         {convert to ASCII equivalent}
  mov es:[di-1],al  {change the character}
  jmp @1            {get next char}
@2:
  pop ds            {restore ds}
end;
{$ENDIF}

procedure TOvcBaseEntryField.efMoveFocus(C : TWinControl);
  {-ask the controller to move the focus to the specified control}
begin
  PostMessage(Controller.Handle, om_SetFocus, 0, LongInt(C));
end;

procedure TOvcBaseEntryField.efMoveFocusToNextField;
  {-give next field the focus}
var
  PF : TForm;
begin
  PF := TForm(GetParentForm(Self));
  if not Assigned(PF) then
    Exit;

  PostMessage(PF.Handle, WM_NEXTDLGCTL, 0, 0);
end;

procedure TOvcBaseEntryField.efMoveFocusToPrevField;
  {-give previous field the focus}
var
  PF : TForm;
begin
  PF := TForm(GetParentForm(Self));
  if not Assigned(PF) then
    Exit;

  PostMessage(PF.Handle, WM_NEXTDLGCTL, 1, 0);
end;

function TOvcBaseEntryField.efNthMaskChar(N : Word) : AnsiChar;
  {-return the N'th character in the picture mask. N is 0-based}
begin
  if N >= efPicLen then
    Result := efPicture[efPicLen-1]
  else
    Result := efPicture[N];
end;

function TOvcBaseEntryField.efOctStr2Long(St : PAnsiChar; var L : LongInt) : Boolean;
  {-convert an octal AnsiString to a longint}
var
  I  : Word;
begin
  Result := True;
  L := 0;
  for I := 0 to StrLen(St)-1 do begin
    {are we going to loose any of the top 3 bits}
    if (L and $E0000000) <> 0 then
      Result := False;
    L := L shl 3;
    L := L or (Ord(St[I]) - Ord('0'));
  end;
end;

procedure TOvcBaseEntryField.efPaintPrim(DC : hDC; CR : TRect; Offset : Integer);
  {-primitive routine to draw the entry field control}
var
  X, Y      : Integer;
  ChCnt     : Integer;
  CtCnt     : Integer;
  HStart    : Integer;
  HEnd      : Integer;
  OldBKMode : Integer;
  RTC, HTC  : LongInt;
  RBC, HBC  : LongInt;
  CtlClr    : LongInt;
  SA, SD    : PAnsiChar;
  T         : TEditString;

  procedure Display(Count : Word; TC, BC : LongInt);
  begin
    if (Count <> 0) and (X < CR.Right) then begin
      SetTextColor(DC, TC);
      SetBkColor(DC, BC);
      ExtTextOut(DC, X, Y, ETO_CLIPPED, @CR, SD, Count, nil);
    end;

    if (Count <> 0) then begin
      {adjust X coordinate}
      Inc(X, efGetTextExtent(SD, Count));                              {!!.10}

      {advance AnsiString pointers}
      Inc(SD, Count);
      Inc(SA, Count);

      {adjust highlight indices}
      Dec(HStart, Count);
      if HStart < 0 then
        HStart := 0;
      Dec(HEnd, Count);
      if HEnd <= HStart then
        HEnd := 0;
    end;
  end;

  procedure DisplayPrim(Count : Word; TC, HC : LongInt);
  var
    SubCnt : Word;
    Buf    : TEditString;
  begin
    if (Count > 0) and (efFieldClass = fcNumeric) then begin
      StrCopy(Buf, SD);

      {remove leading and trailing spaces}
      TrimAllSpacesPChar(Buf);
      SubCnt := StrLen(Buf);
      if HStart < HEnd then begin
        SetTextColor(DC, HTC);
        SetBkColor(DC, HBC)
      end else begin
        SetTextColor(DC, RTC);
        SetBkColor(DC, RBC);
      end;

      {set right alignment}
      SetTextAlign(DC, TA_RIGHT);


      {paint the text right aligned}
      {ExtTextOut(DC, CR.Right-FTextMargin, Y, ETO_CLIPPED,}           {!!.01}
                 {@CR, Buf, SubCnt, nil);}                             {!!.01}
      ExtTextOut(DC, X, Y, ETO_CLIPPED, @CR, Buf, SubCnt, nil);        {!!.01}
      Exit;
    end;

    if (HStart = 0) and (HEnd > 0) then begin
      SubCnt := HEnd-HStart;
      if SubCnt > Count then
        SubCnt := Count;

      {highlighted chars}
      OldBKMode := SetBkMode(DC, OPAQUE);
      Display(SubCnt, HC, HBC);
      SetBkMode(DC, OldBkMode);
    end else begin
      if HStart > 0 then begin
        SubCnt := HStart;
        if SubCnt > Count then
          SubCnt := Count;
      end else
        SubCnt := Count;
      Display(SubCnt, TC, RBC);
    end;

    {do we need to recurse?}
    Dec(Count, SubCnt);
    if Count > 0 then
      DisplayPrim(Count, TC, HC);
  end;

{!!.10} {revised to support RightAlign}
begin
  {select the font into our painting DC}
  SelectObject(DC, Font.Handle);
  SetBkColor(DC, Graphics.ColorToRGB(Color));
  SetTextColor(DC, Graphics.ColorToRGB(Font.Color));

  {display samples of appropriate data while designing}
  if csDesigning in ComponentState then begin
    efGetSampleDisplayData(T);
    SD := @T[0];
  end else begin
    {get the display version of the AnsiString}
    efGetDisplayString(T, MaxEditLen);
    SD := @T[Offset];
  end;

  {point to the starting point of the AnsiString}
  SA := @efEditSt[Offset];

  {determine highlighted portion of the AnsiString}
  if not (sefHaveFocus in sefOptions) then begin
    HStart := 0;
    HEnd := 0;
  end else begin
    HStart := efSelStart-Offset;
    HEnd := efSelEnd-Offset;
    if HStart < 0 then
      HStart := 0;
    if HEnd <= HStart then
      HEnd := 0;
  end;

  {get text colors to use}
  if IsValid then begin
    RTC := GetTextColor(DC);
    RBC := GetBkColor(DC);
  end else begin
    RTC := Graphics.ColorToRGB(FErrorColors.TextColor);
    RBC := Graphics.ColorToRGB(FErrorColors.BackColor);
  end;

  {fill in the background}
  if not Enabled then                                                  {!!.12}
    Canvas.Brush.Color := FDisabledColors.BackColor                    {!!.12}
  else if IsValid then                                                 {!!.12}
    Canvas.Brush.Color := Color
  else
    Canvas.Brush.Color := FErrorColors.BackColor;

  OldBkMode := SetBkMode(DC, TRANSPARENT);
  FillRect(DC, CR, Canvas.Brush.Handle);
  SetBkMode(DC, OldBkMode);

  if csDesigning in ComponentState then begin
    {no highlights if we're designing}
    HStart := 0;
    HEnd := 0;
  end else if not Enabled then begin
    {no highlights}
    HStart := 0;
    HEnd := 0;
    {RTC := GetSysColor(COLOR_GRAYTEXT);}                              {!!.12}
    {try to insure text and background colors are different}
    {if RTC = RBC then}                                                {!!.12}
      {RTC := GetTextColor(DC);}                                       {!!.12}

    RTC := Graphics.ColorToRGB(FDisabledColors.TextColor);             {!!.12}
    RBC := Graphics.ColorToRGB(FDisabledColors.BackColor);             {!!.12}
  end;

  if csDesigning in ComponentState then begin
    ChCnt := StrLen(T);
    CtCnt := 0;
  end else
    {count characters (use actual AnsiString, SA, not display AnsiString, SD)}
    efFindCtrlChars(SA, ChCnt, CtCnt);

  {X := TextMargin;}                                                   {!!.01}
  if (efFieldClass = fcNumeric) then                                   {!!.01}
    X := ClientWidth-TextMargin-1                               {!!.01}{!!.10}
  else begin
    efRightAlignActive := FRightAlign;
    if efRightAlignActive then begin
      X := efGetTextExtent(SD, StrLen(SD));
      if X >= ClientWidth-TextMargin-1 then begin
        efRightAlignActive := False;
        {the display AnsiString doesn't fit in the client area, so display it left aligned}
        X := TextMargin-1;
      end else
        X := ClientWidth-X-TextMargin-1;
    end else
      X := TextMargin-1;                                               {!!.01}
  end;

  Y := efTopMargin;

  {convert TColor values to RGB values}
  CtlClr := Graphics.ColorToRGB(FCtrlColor);
  HTC := Graphics.ColorToRGB(FHighlightColors.TextColor);
  HBC := Graphics.ColorToRGB(FHighlightColors.BackColor);

  {display loop}
  while (ChCnt or CtCnt) <> 0 do begin
    {display regular characters}
    if ChCnt > 0 then
      DisplayPrim(ChCnt, RTC, HTC);

    {display control characters}
    if CtCnt > 0 then
      DisplayPrim(CtCnt, CtlClr, CtlClr);

    {check for more characters}
    if CtCnt = 0 then
      ChCnt := 0
    else
      efFindCtrlChars(SA, ChCnt, CtCnt);
  end;
end;

procedure TOvcBaseEntryField.efPerformEdit(var Msg : TMessage; Cmd : Word);
  {-process the specified editing command if appropriate}
begin
  HandleNeeded;
  if not HandleAllocated then
    Exit;

  {the null character implies that the this key should be}
  {ignored. the only way for the null character to get here}
  {is by changing a key after it has been entered , probably}
  {in a key preview event handler}
  if (Cmd = ccChar) and (AnsiChar(Lo(Msg.wParam)) = #0) then
    Exit;

  {filter out commands that are inappropriate in read-only mode}
  if efIsReadOnly then begin
    case Cmd of
      ccChar, ccCtrlChar, ccRestore, ccBack, ccDel, ccDelEol,
      ccDelBol, ccDelLine, ccDelWord, {ccIns,} ccCut, ccPaste,         {!!.14}
      ccInc, ccDec :
        begin
          efConditionalBeep;
          Exit;
        end;
    end;
  end;

  {do user command notification for user commands}                     {!!.13}
  if Cmd >= ccUserFirst then begin                                     {!!.13}
    DoOnUserCommand(Cmd);                                              {!!.13}
    Cmd := ccSuppress;                                                 {!!.13}
  end;                                                                 {!!.13}

  {allow descendant classes to perform edit processing}
  efEdit(Msg, Cmd);

  {do user command notification for user commands}
  {if Cmd >= ccUserFirst then }                                        {!!.13}
  {  DoOnUserCommand(Cmd);    }                                        {!!.13}
end;

procedure TOvcBaseEntryField.efPerformRepaint(Modified : Boolean);
  {-flag the field as modified and redraw it}
begin
  if Modified then
    efFieldModified;
  Refresh;
end;

procedure TOvcBaseEntryField.efPerformPreEditNotify(C : TWinControl);
  {-pre-edit notification to parent form}
begin
  Controller.DoOnPreEdit(Self, C);
end;

procedure TOvcBaseEntryField.efPerformPostEditNotify(C : TWinControl);
  {-post-edit notification to parent form}
begin
  Controller.DoOnPostEdit(Self, C);
end;

{!!.10} {revised to support RightAlign}
function TOvcBaseEntryField.efPositionCaret(Adjust : Boolean) : Boolean;
  {-position the editing caret}
var
  Delta    : Word;
  S        : PAnsiChar;
  OK       : Boolean;
  Metrics  : TTextMetric;
  CW       : Integer;
  Pos      : TPoint;
  T        : TEditString;
  SLen     : Integer;
begin
  Result := False;
  if not (sefHaveFocus in sefOptions) then
    Exit;

  if Adjust then begin
  {when a character is entered that erases the existing text,
   efHPos may be 1 greater than EditBegin because of the
   entered character}
    if ((efHPos = efEditBegin) or (efHPos = efEditBegin+1)) and
       (efHOffset <> 0) then begin
      efHOffset := 0;
      Result := True;
    end else if (efHPos < efHOffset) then begin
      efHOffset := efHPos;
      Result := True;
    end;
  end;

  efGetDisplayString(T, MaxEditLen);

  efRightAlignActive := FRightAlign;
  if efRightAlignActive then begin
    Delta := efGetTextExtent(T, StrLen(T));
    if Delta >= ClientWidth-FTextMargin-1 then begin
      {the display AnsiString doesn't fit in the client area, it is displayed left aligned}
      efRightAlignActive := False;
    end else begin
      efRightAlignActive := True;
      efHOffset := 0;
    end;
  end;

  repeat
    if not efRightAlignActive then begin
      S := @T[efHOffset];
    end else begin
      S := @T[efHPos];
    end;

    SLen := StrLen(S);
    if (efHPos = efHOffset) and not efRightAlignActive then
      Delta := 0
    else begin
      if not efRightAlignActive then
        Delta := efGetTextExtent(S, efHPos-efHOffset)
      else
        Delta := efGetTextExtent(S, SLen);
    end;

    OK := (Delta < ClientWidth-FTextMargin-1) or
          (sefNumeric in sefOptions) or not Adjust;
    if not OK then begin
      if efHOffset >= efHPos then
        OK := True
      else begin
        Inc(efHOffset);
        Result := True;
      end;
    end;
  until OK;

  {get metrics for current font}
  GetTextMetrics(Canvas.Handle, Metrics);

  {get character width}
  CW := efGetTextExtent(@T[efHPos], 1);

  {set caret cell height and width}
  efCaret.CellHeight := Metrics.tmHeight;
  efCaret.CellWidth := CW;

  {adjust caret position if using a wide cursor}
  if (efCaret.CaretType.Shape in [csBlock, csHalfBlock, csHorzLine]) or
     (efCaret.CaretType.CaretWidth > 4) then
    if efRightAlignActive then
      Dec(Delta)
    else
      Inc(Delta);

  {set caret position}
  if (efFieldClass = fcNumeric) then
    Pos.X := ClientWidth-FTextMargin-1                                 {!!.10}
  else
    if efRightAlignActive then begin
      Pos.X := ClientWidth - Succ(Delta) - FTextMargin - 1;            {!!.11}
    end else
      Pos.X := Succ(Delta)+FTextMargin - 3;                            {!!.11}

  Pos.Y := efTopMargin;
  if Pos.Y < 0 then                                                    {!!.01}
    Pos.Y := 0;                                                        {!!.01}

  efCaret.Position := Pos;
end;

function TOvcBaseEntryField.efRangeToStRange(const Value : TRangeType) : AnsiString;
  {-returns the range as a AnsiString}
var
  D        : Byte;
  Ex       : Extended;
  Buf      : TEditString;
  DateMask : String[MaxDateLen];
  TimeMask : String[MaxDateLen];

  function GetDecimalPlaces : Byte;
  var
    I      : Cardinal;
    DotPos : Cardinal;
  begin
    if not StrChPos(efPicture, pmDecimalPt, DotPos) then
      Result := DecimalPlaces
    else begin
      Result := 0;
      for I := DotPos+1 to MaxLength-1 do
        if efNthMaskChar(I) in PictureChars then
          Inc(Result)
        else
          Break;
    end;
  end;

  function ExtendedToString(E : Extended; DP : Byte) : AnsiString;
  label
    UseScientificNotation;
  var
    I : Cardinal;
    S : TEditString;
  begin
    if StrScan(efPicture, pmScientific) <> nil then
      goto UseScientificNotation;

    {try to use regular notation}
    Str(E:0:DP, S);

    {trim trailing 0's if appropriate}
    if StrScan(S, pmDecimalPt) <> nil  then
      TrimTrailingZerosPChar(S);

    {does it fit?}
    if StrLen(S) > MaxLength then begin
      {won't fit--use scientific notation}
  UseScientificNotation:
      if (DP > 0) and (9+DP < MaxLength) then
        Str(E:9+DP, S)
      else
        Str(E:MaxLength, S);
      TrimAllSpacesPChar(S);
      TrimEmbeddedZerosPChar(S);
    end;

    {convert decimal point}
    if StrChPos(S, pmDecimalPt, I) then
      S[I] := IntlSupport.DecimalChar;
    Result := StrPas(S);
  end;

begin
  Result := '';
  D := GetDecimalPlaces;
  case efDataType mod fcpDivisor of
    fsubString : {};
    fsubBoolean, fsubYesNo : {};
    fsubChar :
      if Value.rtChar <= ' ' then begin
        Str(Ord(Value.rtChar), Result);
        Result := '#' + Result;
      end else
         Result := Value.rtChar;
    fsubLongInt, fsubInteger, fsubShortInt, fsubWord, fsubByte :
      begin
        efLong2Str(Buf, Value.rtLong);
        Result := StrPas(Buf);
      end;
    fsubReal :
      begin
        Ex := Value.rtReal;
        Result := ExtendedToString(Ex, D);
      end;
    fsubExtended, fsubDouble, fsubSingle, fsubComp :
      Result := ExtendedToString(Value.rtExt, D);
    fsubDate :
      begin
        DateMask := OvcIntlSup.InternationalDate(True);
        if Value.rtDate = BadDate then
          Result := ''
        else
          Result := OvcIntlSup.DateToDateString(DateMask, Value.rtDate, False);
      end;
    fsubTime      :
      begin
        TimeMask := OvcIntlSup.InternationalTime(False);
        if Value.rtTime = BadTime then
          Result := ''
        else
          Result := OvcIntlSup.TimeToTimeString(TimeMask, Value.rtTime, False);
      end;
  end;
end;

procedure TOvcBaseEntryField.efRemoveBadOptions;
  {-remove inappropriate options for this field and data type}
begin
  if csLoading in ComponentState then
    Exit;

  case efFieldClass of
    fcSimple :
      case efDataType mod fcpDivisor of
        fsubString :
          begin
            FRightJustify := False;
            FStripLiterals := False;
          end;
        fsubChar, fsubBoolean, fsubYesNo :
          begin
            FCaretToEnd := False;
            FInsertPushes := False;
            FForceInsert := False;
            FForceOvertype := False;
            FTrimBlanks := False;
            FRightJustify := False;
            FStripLiterals := False;
          end;
        fsubLongInt, fsubWord, fsubInteger, fsubByte,
        fsubShortInt, fsubReal, fsubExtended, fsubDouble,
        fsubSingle, fsubComp :
          begin
            FTrimBlanks := False;
            FRightJustify := False;
            FStripLiterals := False;
          end;
      end;
    fcPicture :
      case efDataType mod fcpDivisor of
        fsubString : {};
        fsubChar, fsubBoolean, fsubYesNo :
          begin
            FCaretToEnd := False;
            FInsertPushes := False;
            FForceInsert := False;
            FForceOvertype := False;
            FTrimBlanks := False;
            FRightJustify := False;
            FStripLiterals := False;
          end;
        fsubLongInt, fsubWord, fsubInteger, fsubByte,
        fsubShortInt, fsubReal, fsubExtended, fsubDouble,
        fsubSingle, fsubComp :
          begin
            FTrimBlanks := False;
            FStripLiterals := False;
          end;
        fsubDate, fsubTime :
          begin
            FTrimBlanks := False;
            FRightJustify := False;
            FStripLiterals := False;
          end;
      end;
    fcNumeric :
      begin
        FCaretToEnd := False;
        FForceInsert := False;
        FForceOvertype := False;
        FInsertPushes := False;
        FTrimBlanks := False;
        FRightJustify := False;
        FStripLiterals := False;
        FRightAlign := False;                                          {!!.10}
      end;
  end;

  {if input is required then these fields must also be uninitialized}
  if (csDesigning in ComponentState) and InputRequired then
    case efDataType mod fcpDivisor of
      fsubChar, fsubBoolean, fsubYesNo, fsubLongInt,
      fsubWord, fsubInteger, fsubByte, fsubShortInt,
      fsubReal, fsubExtended, fsubDouble, fsubSingle,
      fsubComp : FUninitialized := True;
    end;
end;

procedure TOvcBaseEntryField.efResetCaret;
  {-move the caret to the beginning or end of the field, as appropriate}
begin
  if FCaretToEnd then
    efCaretToEnd
  else
    efCaretToStart;
end;

procedure TOvcBaseEntryField.efSaveEditString;
  {-save a copy of the edit AnsiString}
begin
  if (efSaveEdit = nil) or (StrLen(efEditSt) <> StrLen(efSaveEdit)) then begin
    if efSaveEdit <> nil then
      StrDispose(efSaveEdit);
    efSaveEdit := StrNew(efEditSt);
  end else
    StrCopy(efSaveEdit, efEditSt);
end;

procedure TOvcBaseEntryField.efSetCaretPos(Value : Integer);
  {-set position of caret within the field}
begin
  if not (sefHaveFocus in sefOptions) then
    Exit;

  if Value < 0 then
      efHPos := 0
  else if Value > LongInt(StrLen(efEditSt)) then                       {!!.D4}
    efHPos := StrLen(efEditSt)+1
  else
    efHPos := Value;
  efPositionCaret(True);
end;

procedure TOvcBaseEntryField.efSetDefaultRange(FT : Byte);
  {-set the default range for the given field type FT}
begin
  efRangeLo := BlankRange;
  efRangeHi := BlankRange;
  case FT mod fcpDivisor of
    fsubString : {};
    fsubBoolean, fsubYesNo : {};
    fsubChar :
      begin
        efRangeLo.rtChar := #32;
        efRangeHi.rtChar := #32;
      end;
    fsubLongInt :
      begin
        efRangeLo.rtLong := Low(LongInt); {80000000}
        efRangeHi.rtLong := High(LongInt); {7FFFFFFF}
      end;
    fsubWord :
      begin
        efRangeLo.rtLong := Low(Word); {0}
        efRangeHi.rtLong := High(Word); {65535}
      end;
    fsubInteger :
      begin
        efRangeLo.rtLong := Low(SmallInt); {-32768}
        efRangeHi.rtLong := High(SmallInt); {+32767}
      end;
    fsubByte :
      begin
        efRangeLo.rtLong := Low(Byte); {0}
        efRangeHi.rtLong := High(Byte); {255}
      end;
    fsubShortInt :
      begin
        efRangeLo.rtLong := Low(ShortInt); {-128}
        efRangeHi.rtLong := High(ShortInt); {127}
      end;
    fsubReal :
      begin
        efRangeLo.rtReal := -1.7e+38;
        efRangeHi.rtReal := +1.7e+38;
      end;
    fsubExtended :
      begin
        efRangeLo.rtExt := -1.1e+4932;
        efRangeHi.rtExt := +1.1e+4932;
      end;
    fsubDouble :
      begin
        efRangeLo.rtExt := -1.7e+308;
        efRangeHi.rtExt := +1.7e+308;
      end;
    fsubSingle :
      begin
        efRangeLo.rtExt := -3.4e+38;
        efRangeHi.rtExt := +3.4e+38;
      end;
    fsubComp :
      begin
        efRangeLo.rtExt := -9.2e+18;
        efRangeHi.rtExt := +9.2e+18;
      end;
    fsubDate :
      begin
        efRangeLo.rtDate := MinDate;
        efRangeHi.rtDate := MaxDate;
      end;
    fsubTime :
      begin
        efRangeLo.rtTime := MinTime;
        efRangeHi.rtTime := MaxTime;
      end;
  end;
end;

procedure TOvcBaseEntryField.efSetInitialValue;
  {-set the initial value of the field}
var
  R   : TRangeType;
  FST : Byte;
begin
  if csDesigning in ComponentState then
    Exit;

  R := BlankRange;
  FST := efDataType mod fcpDivisor;
  case FST of
    fsubChar :
      if (' ' >= efRangeLo.rtChar) and (' ' <= efRangeHi.rtChar) then
        R.rtChar := ' '
      else
        R.rtChar := efRangeLo.rtChar;
    fsubLongInt, fsubWord, fsubInteger, fsubByte, fsubShortInt :
      if (0 < efRangeLo.rtLong) or (0 > efRangeHi.rtLong) then
        R.rtLong := efRangeLo.rtLong;
    fsubReal :
      if (0 < efRangeLo.rtReal) or (0 > efRangeHi.rtReal) then
        R.rtReal := efRangeLo.rtReal;
    fsubExtended, fsubDouble, fsubSingle, fsubComp :
      if (0 < efRangeLo.rtExt) or (0 > efRangeHi.rtExt) then
        case FST of
          fsubExtended : R.rtExt  := efRangeLo.rtExt;
          fsubDouble   : R.rtDbl  := efRangeLo.rtExt;
          fsubSingle   : R.rtSgl  := efRangeLo.rtExt;
          fsubComp     : R.rtComp := efRangeLo.rtExt;
        end;
    fsubDate : R.rtDate := BadDate;
    fsubTime : R.rtTime := BadTime;
  end;
  efTransfer(@R, otf_SetData);
end;

procedure TOvcBaseEntryField.SetName(const Value : TComponentName);
begin
  inherited SetName(Value);

  Repaint;
end;

procedure TOvcBaseEntryField.SetSelection(Start, Stop : Word);
  {-mark offsets Start..Stop as selected}
var
  Len : Word;
begin
  if Start <= Stop then begin
    Len := StrLen(efEditSt);

    if Start > Len then
      Start := Len;
    if Stop > Len then
      Stop := Len;

    {all or nothing for numeric fields}
    if (efFieldClass = fcNumeric) then
      if (Start <> Stop) then begin
        Start := 0;
        Stop := MaxEditLen;
      end;

    efSelStart := Start;
    efSelEnd := Stop;
  end;
end;

function TOvcBaseEntryField.efStr2Long(P : PAnsiChar; var L : LongInt) : Boolean;
  {-convert a AnsiString to a long integer}
var
  S : TEditString;
begin
  Result := True;
  StrCopy(S, P);
  TrimAllSpacesPChar(S);

  {treat an empty AnsiString as 0}
  if StrLen(S) = 0 then begin
    L := 0;
    Exit;
  end;

  if sefBinary in sefOptions then
    Result := efBinStr2Long(S, L)
  else if sefOctal in sefOptions then
    Result := efOctStr2Long(S, L)
  else begin
    if (sefHexadecimal in sefOptions) and (S[0] <> #0) then
      if StrPos(S, '$') = nil then
        StrChInsertPrim(S, '$', 0);

    {check for special value the Val() doesn't handle correctly}
    if StrComp(S, '-2147483648') = 0 then
      L := LongInt($80000000)                                          {!!.D4}
    else
      Result := StrToLongPChar(S, L);
  end;
end;

function TOvcBaseEntryField.efStRangeToRange(const Value : AnsiString; var R : TRangeType) : Boolean;
  {-converts a AnsiString range to a RangeType}
var
  I        : Integer;
  Code     : Integer;
  fSub     : Byte;
  Buf      : TEditString;
  DateMask : String[MaxDateLen];
  TimeMask : String[MaxDateLen];
begin
  Code := 0;  {assume success}
  R := BlankRange;
  fSub := efDataType mod fcpDivisor;
  case fSub of
    fsubString : {};
    fsubBoolean, fsubYesNo : {};
    fsubChar :
      if Value = '' then
        R.rtChar := #32
      else if Value[1] = '#' then begin
        Val(Copy(Value, 2, 3), I, Code);
        if Code = 0 then
          R.rtChar := AnsiChar(I)
        else begin
          Code := 0;
          R.rtChar := #32;
        end;
      end else
        R.rtChar := Value[1];
    fsubLongInt, fsubWord, fsubInteger, fsubByte, fsubShortInt :
      begin
        StrPCopy(Buf, Value);
        if not efStr2Long(Buf, R.rtLong) then
          Code := 1
        else if (fSub = fsubWord) and
          ((R.rtLong < Low(Word)) or (R.rtLong > High(Word))) then
          Code := 1
        else if (fSub = fsubInteger) and
          ((R.rtLong < Low(SmallInt)) or (R.rtLong > High(SmallInt))) then
          Code := 1
        else if (fSub = fsubByte) and
          ((R.rtLong < Low(Byte)) or (R.rtLong > High(Byte))) then
          Code := 1
        else if (fSub = fsubShortInt) and
          ((R.rtLong < Low(ShortInt)) or (R.rtLong > High(ShortInt))) then
          Code := 1;
      end;
    fsubReal :
      if Value = '' then
        R.rtReal := 0
      else
        Val(Value, R.rtReal, Code);
    fsubExtended, fsubDouble, fsubSingle, fsubComp :
      begin
        if Value = '' then
          R.rtExt := 0
        else
          Val(Value, R.rtExt, Code);
        if (Code = 0) then begin
          if (fSub = fsubDouble) and ((R.rtExt < -1.7e+308) or (R.rtExt > +1.7e+308)) then
            Code := 1
          else if (fSub = fsubSingle) and ((R.rtExt < -3.4e+38) or (R.rtExt > +3.4e+38)) then
            Code := 1
          else if (fSub = fsubComp) and ((R.rtExt < -9.2e+18) or (R.rtExt > +9.2e+18)) then
            Code := 1;
        end;
      end;
    fsubDate :
      begin
        DateMask := OvcIntlSup.InternationalDate(True);
        if Length(Value) <> Length(DateMask) then
          R.rtDate := BadDate
        else
          R.rtDate := OvcIntlSup.DateStringToDate(DateMask, Value, efGetEpoch);
        if R.rtDate = BadDate then
          Code := 1;
      end;
    fsubTime :
      begin
        TimeMask := OvcIntlSup.InternationalTime(False);
        if Length(Value) <> Length(TimeMask) then
          R.rtTime := BadTime
        else
          R.rtTime := OvcIntlSup.TimeStringToTime(TimeMask, Value);
        if R.rtTime = BadTime then
          Code := 1;
      end;
  end;
  Result := Code = 0;
end;

procedure TOvcBaseEntryField.efReadRangeHi(Stream : TStream);
  {-called to read the high range from the stream}
begin
  Stream.Read(efRangeHi, SizeOf(TRangeType));
end;

procedure TOvcBaseEntryField.efReadRangeLo(Stream : TStream);
  {-called to read the low range from the stream}
begin
  Stream.Read(efRangeLo, SizeOf(TRangeType));
end;

function TOvcBaseEntryField.efTransfer(DataPtr : Pointer; TransferFlag : Word) : Word;
  {-transfer data to or from the field}
begin
  if (TransferFlag <> otf_SizeData) and not (csDesigning in ComponentState) then
    Result := efTransferPrim(DataPtr, TransferFlag)
  else
    Result := efDataSize;
  {descendant classes will do the actual transfering of data}
end;

function TOvcBaseEntryField.efTransferPrim(DataPtr : Pointer; TransferFlag : Word) : Word;
  {-reset for new data in field}
begin
  Result := efDataSize;
  if TransferFlag = otf_SetData then begin
    if not (sefValidating in sefOptions) then begin
      Exclude(sefOptions, sefRetainPos);
      if sefHaveFocus in sefOptions then begin
        efResetCaret;
        efPositionCaret(True);

        {if we are doing a transfer due to a GetValue}
        {validation, don't reset selection}
        if not (sefGettingValue in sefOptions) then
          SetSelection(0, MaxEditLen);
      end else
        Exclude(sefOptions, sefInvalid);

      {clear modified flags}
      Exclude(sefOptions, sefModified);
      Exclude(sefOptions, sefEverModified);

      Invalidate;
    end;
  end;
end;

procedure TOvcBaseEntryField.efWriteRangeHi(Stream : TStream);
  {-called to store the high range on the stream}
begin
  Stream.Write(efRangeHi, SizeOf(TRangeType));
end;

procedure TOvcBaseEntryField.efWriteRangeLo(Stream : TStream);
  {-called to store the low range on the stream}
begin
  Stream.Write(efRangeLo, SizeOf(TRangeType));
end;

procedure TOvcBaseEntryField.EMGetModify(var Msg : TMessage);
begin
  Msg.Result := 0;
  if sefModified in sefOptions then
    Msg.Result := 1;
end;

procedure TOvcBaseEntryField.EMGetSel(var Msg : TMessage);
begin
  {!!.12} {added}
  {$IFDEF Win32}
  {for Win32, return this info in Msg as well as in Result}
  with Msg do begin
    if LPDWORD(wParam) <> nil then
      LPDWORD(wParam)^ := efSelStart;
    if LPDWORD(lParam) <> nil then
      LPDWORD(lParam)^ := efSelEnd;
  end;
  {$ENDIF}

  Msg.Result := MakeLong(efSelStart, efSelEnd);
end;

procedure TOvcBaseEntryField.EMSetModify(var Msg : TMessage);
begin
  if Msg.wParam > 0 then begin
    Include(sefOptions, sefModified);
    Include(sefOptions, sefEverModified);
  end else
    Exclude(sefOptions, sefModified);
end;

procedure TOvcBaseEntryField.EMSetSel(var Msg : TMessage);
begin
  with Msg do begin
    if lParamLo = $FFFF then
      SetSelection(0, 0)
    else if (lParamLo = 0) and (lParamHi = $FFFF) then
      SetSelection(0, MaxEditLen)
    else if lParamHi >= lParamLo then
      SetSelection(lParamLo, lParamHi);
  end;
  Invalidate;
end;

function TOvcBaseEntryField.GetAsBoolean : Boolean;
  {-returns the field value as a Boolean Value}
begin
  Result := False;
  if (efDataType mod fcpDivisor) in [fsubBoolean, fsubYesNo] then
    FLastError := GetValue(Result)
  else
    raise EInvalidDataType.Create;
end;

function TOvcBaseEntryField.GetAsCents : LongInt;
  {-returns the field value as a LongInt Value representing pennies}
const
  C = 100.0;
var
  Re : Real;
  Db : Double;
  Si : Single;
  Ex : Extended;
begin
  Result := 0;
  case (efDataType mod fcpDivisor) of
    fsubReal     :
      begin
        FLastError := GetValue(Re);
        if FLastError = 0 then
          Result := Round(Re * C);
      end;
    fsubDouble   :
      begin
        FLastError := GetValue(Db);
        if FLastError = 0 then
          Result := Round(Db * C);
      end;
    fsubSingle   :
      begin
        FLastError := GetValue(Si);
        if FLastError = 0 then
          Result := Round(Si * C);
      end;
    fsubExtended :
      begin
        FLastError := GetValue(Ex);
        if FLastError = 0 then
          Result := Round(Ex * C);
      end;
  else
    raise EInvalidDataType.Create;
  end;
end;

function TOvcBaseEntryField.GetAsDateTime : TDateTime;
  {-returns the field value as a Delphi DateTime Value}
var
  D   : TStDate;
  T   : TStTime;
begin
  case (efDataType mod fcpDivisor) of
    fsubDate :
      begin
        FLastError := GetValue(D);
        if FLastError <> 0 then
          Result := 0
        else
          Result := StDateToDateTime(D);
      end;
    fsubTime :
      begin
        FLastError := GetValue(T);
        if FLastError <> 0 then
          Result := 0
        else
          Result := StTimeToDateTime(T);
      end;
  else
    raise EInvalidDataType.Create;
  end;
end;

function TOvcBaseEntryField.GetAsExtended : Extended;
  {-returns the field value as an Extended Value}
var
  Ex  : Extended;
  Co  : Comp absolute Ex;
  {!!.01} {added double single and real types}
  Db  : Double;
  Sg  : Single absolute Db;
  Re  : Real absolute Db;
  {!!.01} {added integer types}
  Li  : Longint;
  Wo  : Word absolute Li;
  It  : SmallInt absolute Li;
  By  : Byte absolute Li;
  Si  : ShortInt absolute Li;
begin
  Result := 0;
  case efDataType mod fcpDivisor of
    fsubExtended   :
      begin
        FLastError := GetValue(Ex);
        if FLastError = 0 then
          Result := Ex;
      end;
    fsubComp :
      begin
        FLastError := GetValue(Co);
        if FLastError = 0 then
          Result := Co;
      end;
    {!!.01} {added double single and real types}
    fsubReal   :
      begin
        FLastError := GetValue(Re);
        if FLastError = 0 then
          Result := Re;
      end;
    fsubDouble :
      begin
        FLastError := GetValue(Db);
        if FLastError = 0 then
          Result := Db;
      end;
    fsubSingle :
      begin
        FLastError := GetValue(Sg);
        if FLastError = 0 then
          Result := Sg;
      end;
    {!!.01} {added integer types}
    fsubLongInt   :
      begin
        FLastError := GetValue(Li);
        if FLastError = 0 then
          Result := Li;
      end;
    fsubWord :
      begin
        FLastError := GetValue(Wo);
        if FLastError = 0 then
          Result := Wo;
      end;
    fsubInteger :
      begin
        FLastError := GetValue(It);
        if FLastError = 0 then
          Result := It;
      end;
    fsubByte :
      begin
        FLastError := GetValue(By);
        if FLastError = 0 then
          Result := By;
      end;
    fsubShortInt :
      begin
        FLastError := GetValue(Si);
        if FLastError = 0 then
          Result := Si;
      end;
  else
    raise EInvalidDataType.Create;
  end;
end;

function TOvcBaseEntryField.GetAsFloat : Double;
  {-returns the field value as a Double Value}
var
  Db  : Double;
  Sg  : Single absolute Db;
  Re  : Real absolute Db;
  Ex  : Extended;
  Co  : Comp absolute Ex;
  {!!.01} {added integer types}
  Li  : LongInt;
  Wo  : Word absolute Li;
  It  : SmallInt absolute Li;
  By  : Byte absolute Li;
  Si  : ShortInt absolute Li;
begin
  Result := 0;
  case efDataType mod fcpDivisor of
    fsubReal   :
      begin
        FLastError := GetValue(Re);
        if FLastError = 0 then
          Result := Re;
      end;
    fsubDouble :
      begin
        FLastError := GetValue(Db);
        if FLastError = 0 then
          Result := Db;
      end;
    fsubSingle :
      begin
        FLastError := GetValue(Sg);
        if FLastError = 0 then
          Result := Sg;
      end;
    fsubExtended   :
      begin
        FLastError := GetValue(Ex);
        if FLastError = 0 then
          Result := Ex;
      end;
    fsubComp :
      begin
        FLastError := GetValue(Co);
        if FLastError = 0 then
          Result := Co;
      end;
    {!!.01} {added integer types}
    fsubLongInt   :
      begin
        FLastError := GetValue(Li);
        if FLastError = 0 then
          Result := Li;
      end;
    fsubWord :
      begin
        FLastError := GetValue(Wo);
        if FLastError = 0 then
          Result := Wo;
      end;
    fsubInteger :
      begin
        FLastError := GetValue(It);
        if FLastError = 0 then
          Result := It;
      end;
    fsubByte :
      begin
        FLastError := GetValue(By);
        if FLastError = 0 then
          Result := By;
      end;
    fsubShortInt :
      begin
        FLastError := GetValue(Si);
        if FLastError = 0 then
          Result := Si;
      end;
  else
    raise EInvalidDataType.Create;
  end;
end;

function TOvcBaseEntryField.GetAsInteger : Longint;
  {-returns the field value as a LongInt Value}
var
  Li  : Longint;
  Wo  : Word absolute Li;
  It  : SmallInt absolute Li;
  By  : Byte absolute Li;
  Si  : ShortInt absolute Li;
begin
  Result := 0;
  case efDataType mod fcpDivisor of
    fsubLongInt   :
      begin
        FLastError := GetValue(Li);
        if FLastError = 0 then
          Result := Li;
      end;
    fsubWord :
      begin
        FLastError := GetValue(Wo);
        if FLastError = 0 then
          Result := Wo;
      end;
    fsubInteger :
      begin
        FLastError := GetValue(It);
        if FLastError = 0 then
          Result := It;
      end;
    fsubByte :
      begin
        FLastError := GetValue(By);
        if FLastError = 0 then
          Result := By;
      end;
    fsubShortInt :
      begin
        FLastError := GetValue(Si);
        if FLastError = 0 then
          Result := Si;
      end;
  else
    raise EInvalidDataType.Create;
  end;
end;

function TOvcBaseEntryField.GetAsString : AnsiString;
  {-return the field value as a AnsiString value}
var
  Buf : TEditString;
  S   : String[MaxEditLen];
begin
  Result := '';
  if (efDataType mod fcpDivisor) = fsubString then begin
    FLastError := GetValue(S);
    if FLastError = 0 then
      Result := S;
  end else begin
    StrCopy(Buf, efEditSt);
    if TrimBlanks then
      TrimAllSpacesPChar(Buf);
    Result := StrPas(Buf);
    FLastError := 0;
  end;
end;

{$IFDEF Win32}
function TOvcBaseEntryField.GetAsVariant : Variant;
  {return the field value as a Variant value}
begin
  case efDataType mod fcpDivisor of
    fsubBoolean  : Result := GetAsBoolean;
    fsubYesNo    : Result := GetAsBoolean;
    fsubLongInt  : Result := GetAsInteger;
    fsubWord     : Result := GetAsInteger;
    fsubInteger  : Result := GetAsInteger;
    fsubByte     : Result := GetAsInteger;
    fsubShortInt : Result := GetAsInteger;
    fsubReal     : Result := GetAsFloat;
    fsubDouble   : Result := GetAsFloat;
    fsubSingle   : Result := GetAsFloat;
    fsubExtended : Result := GetAsExtended;
    fsubComp     : Result := GetAsExtended;
  else
    Result := GetAsString;
  end;
end;
{$ENDIF}

function TOvcBaseEntryField.GetAsStDate : TStDate;
  {-returns the field value as a Date Value}
begin
  if (efDataType mod fcpDivisor) = fsubDate  then begin
    FLastError := GetValue(Result);
    if FLastError <> 0 then
      Result := BadDate;
  end else
    raise EInvalidDataType.Create;
end;

function TOvcBaseEntryField.GetAsStTime : TStTime;
  {-returns the field value as a Time Value}
begin
  if (efDataType mod fcpDivisor) = fsubTime then begin
    FLastError := GetValue(Result);
    if FLastError <> 0 then
      Result := BadTime;
  end else
    raise EInvalidDataType.Create;
end;

function TOvcBaseEntryField.GetCurrentPos : Integer;
  {-get position of the caret within the field}
begin
  if sefHaveFocus in sefOptions then
    Result := efHPos
  else
    Result := -1;
end;

function TOvcBaseEntryField.GetDataSize : Word;
  {-return the size of the data for this field}
begin
  if efDataSize = 0 then
    efInitializeDataSize;
  Result := efDataSize;
end;

function TOvcBaseEntryField.GetDisplayString : AnsiString;
  {-return the display AnsiString}
var
  Buf : TEditString;
begin
  efGetDisplayString(Buf, MaxEditLen);
  Result := StrPas(Buf);
end;

function TOvcBaseEntryField.GetEditString : AnsiString;
  {-return a AnsiString containing the edit text}
var
  Buf : TEditString;
begin
  StrLCopy(Buf, efEditSt, MaxEditLen);
  Result := StrPas(Buf);
end;

function TOvcBaseEntryField.GetEverModified : Boolean;
  {-return true if this field has ever been modified}
begin
  Result := (sefEverModified in sefOptions) or (sefModified in sefOptions);
end;

function TOvcBaseEntryField.GetInsCaretType : TOvcCaret;
  {-return the current caret type}
begin
  Result := efCaret.InsCaretType;
end;

function TOvcBaseEntryField.GetInsertMode : Boolean;
  {-return the controller's insert mode state}
begin
  if ControllerAssigned then
    Result := Controller.InsertMode
  else
    Result := sefInsert in sefOptions;
end;

function TOvcBaseEntryField.GetModified : Boolean;
  {-return true if this field is modified}
begin
  Result := sefModified in sefOptions;
end;

function TOvcBaseEntryField.GetOvrCaretType : TOvcCaret;
  {-return the current caret type}
begin
  Result := efCaret.OvrCaretType;
end;

function TOvcBaseEntryField.GetRangeHiStr : AnsiString;
  {-get the high field range as AnsiString value}
begin
  Result := efRangeToStRange(efRangeHi);
end;

function TOvcBaseEntryField.GetRangeLoStr : AnsiString;
  {-get the low field range as AnsiString value}
begin
  Result := efRangeToStRange(efRangeLo);
end;

function TOvcBaseEntryField.GetSelLength : Integer;
  {-return the length of the currently selected text}
begin
  Result := efSelEnd - efSelStart;
end;

function TOvcBaseEntryField.GetSelStart : Integer;
  {-return the starting position of the selection, if any}
begin
  Result := efSelStart;
end;

function TOvcBaseEntryField.GetSelText : AnsiString;
  {-return the currently selected text}
var
  Len : Integer;
begin
  Result := '';
  Len := efSelEnd - efSelStart;
  if Len > 0 then begin
    {limit length to max edit length}
    if Len > MaxEditLen then
      Len := MaxEditLen;
    {StrLCopy(@Result[1], @efEditSt[efSelStart], Len);}                {!!.14}
    {$IFDEF Win32}
    SetLength(Result, Len);
    {$ELSE}
    Result[0] := AnsiChar(Len);
    {$ENDIF}
    StrLCopy(PAnsiChar(@Result[1]), @efEditSt[efSelStart], Len);                  {!!.14}
  end;
end;

function TOvcBaseEntryField.FieldIsEmpty : Boolean;
  {-return True if the field is completely empty}
begin
  HandleNeeded;
  Result := efFieldIsEmpty;
end;

function TOvcBaseEntryField.GetStrippedEditString : AnsiString;
  {-return edit AnsiString stripped of literals and semi-literals}
begin
  Result := GetEditString;
end;

function TOvcBaseEntryField.GetValue(var Data) : Word;
  {-returns the current field value in Data. Result is 0 or error code}
begin
  {flag to inform validate and transfer}
  {methods that we are retrieving a value}
  Include(sefOptions, sefGettingValue);
  try
    Result := efValidateField;
    if Result <> 0 then
      Exit;

    case efDataType mod fcpDivisor of
      fsubString   : efTransfer(@ShortString(Data), otf_GetData);
      fsubChar     : efTransfer(@AnsiChar(Data), otf_GetData);
      fsubBoolean  : efTransfer(@Boolean(Data),  otf_GetData);
      fsubYesNo    : efTransfer(@Boolean(Data),  otf_GetData);
      fsubLongInt  : efTransfer(@LongInt(Data),  otf_GetData);
      fsubWord     : efTransfer(@Word(Data),     otf_GetData);
      fsubInteger  : efTransfer(@SmallInt(Data), otf_GetData);
      fsubByte     : efTransfer(@Byte(Data),     otf_GetData);
      fsubShortInt : efTransfer(@ShortInt(Data), otf_GetData);
      fsubReal     : efTransfer(@Real(Data),     otf_GetData);
      fsubExtended : efTransfer(@Extended(Data), otf_GetData);
      fsubDouble   : efTransfer(@Double(Data),   otf_GetData);
      fsubSingle   : efTransfer(@Single(Data),   otf_GetData);
      fsubComp     : efTransfer(@Comp(Data),     otf_GetData);
      fsubDate     : efTransfer(@TStDate(Data),  otf_GetData);
      fsubTime     : efTransfer(@TStTime(Data),  otf_GetData);
    else
      raise EOvcException.Create(GetOrphStr(SCInvalidParamValue));
    end;
  finally
    Exclude(sefOptions, sefGettingValue);
  end;
end;

procedure TOvcBaseEntryField.IncreaseValue(Wrap : Boolean; Delta : Double);
  {-increase the value of the field by Delta, wrapping if enabled}
begin
  SendMessage(Handle, WM_SETREDRAW, 0, 0);
  efIncDecValue(Wrap, +Delta);
  SetSelection(0, 0);
  SendMessage(Handle, WM_SETREDRAW, 1, 0);
  Refresh;
end;

function TOvcBaseEntryField.IsValid : Boolean;
  {-returns true if the field is not marked as invalid}
begin
  Result := not (sefInvalid in sefOptions);
end;

procedure TOvcBaseEntryField.MergeWithPicture(const S : AnsiString);
  {-combines S with the picture mask and updates the edit AnsiString}
begin
  HandleNeeded;                                                        {!!.15}
  StrPLCopy(efEditSt, S, MaxLength);
end;

procedure TOvcBaseEntryField.MoveCaret(Delta : Integer);
  {-moves the caret to the right or left Value positions}
var
  I   : Integer;
  Msg : TMessage;
begin
  if not (sefHaveFocus in sefOptions) then
    Exit;

  FillChar(Msg, SizeOf(Msg), 0);
  if Delta > 0 then begin
    for I := 1 to Delta do
      efPerformEdit(Msg, ccRight)
  end else if Delta < 0 then begin
    for I := 1 to Abs(Delta) do
      efPerformEdit(Msg, ccLeft)
  end;
end;

procedure TOvcBaseEntryField.MoveCaretToEnd;
  {-move the caret to the end of the field}
begin
  efCaretToEnd;
end;

procedure TOvcBaseEntryField.MoveCaretToStart;
  {-move the caret to the beginning of the field}
begin
  efCaretToStart;
end;

procedure TOvcBaseEntryField.OMGetDataSize(var Msg : TMessage);
  {-return the fields data size}
begin
  Msg.Result := DataSize;
end;

procedure TOvcBaseEntryField.OMReportError(var Msg : TOMReportError);
  {-report the error}
var
  P : AnsiString;
begin
  if Msg.Error = 0 then
    Exit;

  case Msg.Error of
    oeRangeError    : P := GetOrphStr(SCRangeError);
    oeInvalidNumber : P := GetOrphStr(SCInvalidNumber);
    oeRequiredField : P := GetOrphStr(SCRequiredField);
    oeInvalidDate   : P := GetOrphStr(SCInvalidDate);
    oeInvalidTime   : P := GetOrphStr(SCInvalidTime);
    oeBlanksInField : P := GetOrphStr(SCBlanksInField);
    oePartialEntry  : P := GetOrphStr(SCPartialEntry);
  else
    if Msg.Error >= oeCustomError then
      P := Controller.ErrorText
    else
      P := GetOrphStr(SCDefaultEntryErrorText);
  end;

  {update the error text}
  if P <> Controller.ErrorText then
    Controller.ErrorText := P;

  {do error notification}
  DoOnError(Msg.Error, P);
end;

procedure TOvcBaseEntryField.Paint;
  {-draw the entry field control}
var
  hCBM  : hBitmap;
  MemDC : hDC;
  CR    : TRect;
begin
  inherited Paint;

  {get dimensions of client area}
  {CR := ClientRect;}                                                  {!!.01}
  CR.Top := 0; CR.Left := 0;                                           {!!.01}
  CR.Right := Width; CR.Bottom := Height;                              {!!.01}

  {create a compatible display context and bitmap}
  MemDC := CreateCompatibleDC(Canvas.Handle);
  hCBM := CreateCompatibleBitmap(Canvas.Handle, CR.Right, CR.Bottom);
  SelectObject(MemDC, hCBM);
  SetMapMode(MemDC, GetMapMode(Canvas.Handle));

  {set text alignment}
  SetTextAlign(MemDC, TA_LEFT or TA_TOP);

  {call our paint routine}
  efPaintPrim(MemDC, CR, efHOffset);

  {copy everything to the original display context}
  BitBlt(Canvas.Handle, 0, 0, CR.Right, CR.Bottom, MemDC, 0, 0, SrcCopy);

  {dispose of the bitmap and the extra display context}
  DeleteDC(MemDC);
  DeleteObject(hCBM);
end;

procedure TOvcBaseEntryField.PasteFromClipboard;
  {-pastes the contents of the clipboard in the edit field}
begin
  if HandleAllocated then
    Perform(WM_PASTE, 0, 0);
end;

procedure TOvcBaseEntryField.ProcessCommand(Cmd, CharCode : Word);
  {-process the specified command}
var
  Msg : TMessage;
begin
  FillChar(Msg, SizeOf(Msg), #0);
  Msg.wParam := CharCode;
  efPerformEdit(Msg, Cmd);
end;

procedure TOvcBaseEntryField.ResetCaret;
  {-move the caret to the beginning or end of the field, as appropriate}
begin
  efResetCaret;
end;

procedure TOvcBaseEntryField.Restore;
  {-restore the previous contents of the field}
begin
  if efSaveEdit = nil then
    Exit;

  StrCopy(efEditSt, efSaveEdit);
  efResetCaret;
  SetSelection(0, MaxEditLen);

  {clear modified flag}
  Exclude(sefOptions, sefModified);
  Repaint;
  DoOnChange;
end;

procedure TOvcBaseEntryField.SelectAll;
  {-selects the entire contents of the edit field}
begin
  if HandleAllocated then
    Perform(EM_SETSEL, 1, LongInt($FFFF0000));                         {!!.D4}
end;

{!!.10} {added}
procedure TOvcBaseEntryField.SetArrowIncDec(Value : Boolean);
  {-set the ArrowIncDec option}
begin
  if Value <> FArrowIncDec then begin
    FArrowIncDec := Value;
    if FArrowIncDec then
      FAutoAdvanceUD := False;
  end;
end;

procedure TOvcBaseEntryField.SetAsBoolean(Value : Boolean);
  {-sets the field value to a Boolean Value}
begin
  if (efDataType mod fcpDivisor) in [fsubBoolean, fsubYesNo] then
    SetValue(Value)
  else
    raise EInvalidDataType.Create;
end;

procedure TOvcBaseEntryField.SetAsCents(Value : LongInt);
  {-sets the field value given a LongInt Value representing pennies}
const
  C = 100.0;
var
  Re : Real;
  Db : Double;
  Si : Single;
  Ex : Extended;
begin
  case efDataType mod fcpDivisor of
    fsubReal     :
      begin
        Re := Value / C;
        SetValue(Re);
      end;
    fsubDouble   :
      begin
        Db := Value / C;
        SetValue(Db);
      end;
    fsubSingle   :
      begin
        Si := Value / C;
        SetValue(Si);
      end;
    fsubExtended :
      begin
        Ex := Value / C;
        SetValue(Ex);
      end;
  else
    raise EInvalidDataType.Create;
  end;
end;

{!!.10} {revised}
procedure TOvcBaseEntryField.SetAsDateTime(Value : TDateTime);
  {-sets the field value to a Delphi DateTime value}
var
  D     : TStDate;
  T     : TStTime;
  Day,
  Month,
  Year  : Word;
  Hour,
  Min,
  Sec,
  MSec  : Word;
begin
  case (efDataType mod fcpDivisor) of
    fsubDate :
      begin
        {$IFDEF Win32}
        {$IFDEF ZeroDateAsNull}
        if Value = 0 then
          Value := BadDate;
        {$ENDIF}
        DecodeDate(Value, Year, Month, Day);
        D := DMYToStDate(Day, Month, Year, efGetEpoch);
        if D = DateTimeToStDate(BadDate) then
          D := BadDate;
        {$ELSE}
        if Value = BadDate then
          D := BadDate
        else begin
          DecodeDate(Value, Year, Month, Day);
          D := DMYToStDate(Day, Month, Year, efGetEpoch);
        end;
        {$ENDIF}
        SetValue(D);
      end;
    fsubTime :
      begin
        {$IFDEF Win32}
        DecodeTime(Value, Hour, Min, Sec, MSec);
        T := HMSToStTime(Hour, Min, Sec);
        if (T <> 0) and (T = DateTimeToStTime(BadTime)) then           {!!.12}
          T := BadTime;
        {$ELSE}
        if Value = BadTime then
          T := BadTime
        else begin
          DecodeTime(Value, Hour, Min, Sec, MSec);
          T := HMSToStTime(Hour, Min, Sec);
        end;
        {$ENDIF}
        SetValue(T);
      end;
  else
    raise EInvalidDataType.Create;
  end;
end;

procedure TOvcBaseEntryField.SetAsExtended(Value : Extended);
  {-sets the field value to an Extended Value}
var
  Co  : Comp;
begin
  case efDataType mod fcpDivisor of
    fsubExtended   :
        SetValue(Value);
    fsubComp :
      begin
        Co := Trunc(Value);
        SetValue(Co);
      end;
  else
    raise EInvalidDataType.Create;
  end;
end;

procedure TOvcBaseEntryField.SetAsFloat(Value : Double);
  {-sets the field value to a Double Value}
var
  Sg  : Single;
  Re  : Real;
  Co  : Comp;
  Ex  : Extended;
begin
  case efDataType mod fcpDivisor of
    fsubReal   :
      begin
        Re := Value;
        SetValue(Re);
      end;
    fsubDouble :
        SetValue(Value);
    fsubSingle :
      begin
        Sg := Value;
        SetValue(Sg);
      end;
    fsubExtended   :
      begin
        Ex := Value;
        SetValue(Ex);
      end;
    fsubComp :
      begin
        Co := Trunc(Value);
        SetValue(Co);
      end;
  else
    raise EInvalidDataType.Create;
  end;
end;

procedure TOvcBaseEntryField.SetAsInteger(Value : Longint);
  {-sets the field value to a LongInt Value}
var
  Wo  : Word;
  It  : SmallInt absolute Wo;
  By  : Byte absolute Wo;
  Si  : ShortInt absolute Wo;
begin
  case efDataType mod fcpDivisor of
    fsubLongInt   :
        SetValue(Value);
    fsubWord :
      begin
        Wo := LOWORD(Value);
        SetValue(Wo);
      end;
    fsubInteger :
      begin
        It := SmallInt(LOWORD(Value));
        SetValue(It);
      end;
    fsubByte :
      begin
        By := Lo(LOWORD(Value));
        SetValue(By);
      end;
    fsubShortInt :
      begin
        Si := ShortInt(Lo(LOWORD(Value)));
        SetValue(Si);
      end;
  else
    raise EInvalidDataType.Create;
  end;
end;

procedure TOvcBaseEntryField.SetAsString(const Value : AnsiString);
  {-sets the field value to a AnsiString Value}
var
  R    : TRangeType;
  fSub : Byte;
  B    : Boolean;
  Ch   : AnsiChar;
  S    : String[MaxEditLen];
begin
  if sefUserValidating in sefOptions then
    Exit;

  fSub := (efDataType mod fcpDivisor);
  if fSub = fsubString then begin
    S := Value;
    SetValue(S)
  end else if fSub in [fsubBoolean, fsubYesNo] then begin
    B := False;
    if Length(Value) > 0 then begin
      Ch := UpCaseChar(Value[1]);
      B := (Ch = FIntlSup.TrueChar) or (Ch = FIntlSup.YesChar);
    end;
    SetValue(B);
  end else begin
    {use range conversion routines to process AnsiString assignment}
    if efStRangeToRange(Value, R) then begin
      case (efDataType mod fcpDivisor) of
        {assign result to proper sub-field in range type var}
        fsubWord     : R.rtWord := R.rtLong;
        fsubInteger  : R.rtInt := R.rtLong;
        fsubByte     : R.rtByte := R.rtLong;
        fsubShortInt : R.rtSht := R.rtLong;
        fsubDouble   : R.rtDbl := R.rtExt;
        fsubSingle   : R.rtSgl := R.rtExt;
        fsubComp     : R.rtComp := R.rtExt;
      end;
      SetValue(R);
    end else
      raise EEntryFieldError.Create(GetOrphStr(SCInvalidNumber));
  end;
end;

{$IFDEF Win32}
procedure TOvcBaseEntryField.SetAsVariant(Value : Variant);
  {-sets the field value to a Variant value}
var
  fSub : Byte;
begin
  {what data type is this field}
  fSub := efDataType mod fcpDivisor;

  case VarType(Value) of
    varSmallInt,
    varInteger  :
      case fSub of
        fsubByte,
        fsubShortInt,
        fsubWord,
        fsubInteger,
        fsubLongInt : SetAsInteger(Value);
      else
        {try to convert it into a AnsiString}
        SetAsString(VarAsType(Value, varString));
      end;
    varSingle,
    varDouble,
    varCurrency :
      case fSub of
        fsubReal,
        fsubDouble,
        fsubSingle,
        fsubExtended,
        fsubComp : SetAsFloat(Value);
      else
        {try to convert it into a AnsiString}
        SetAsString(VarAsType(Value, varString));
      end;
    varDate     :
      if fSub = fsubDate then
        SetAsDateTime(Value)
      else
        {try to convert it into a AnsiString}
        SetAsString(VarAsType(Value, varString));
    varBoolean  :
      if fSub in [fsubBoolean, fsubYesNo] then
        SetAsBoolean(Value)
      else
        {try to convert it into a AnsiString}
        SetAsString(VarAsType(Value, varString));
    varString   : SetAsString(Value);
  end;
end;
{$ENDIF}

procedure TOvcBaseEntryField.SetAsStDate(Value : TStDate);
  {-sets the field value to a Date Value}
begin
  if (efDataType mod fcpDivisor) = fsubDate then
    SetValue(Value)
  else
    raise EInvalidDataType.Create;
end;

procedure TOvcBaseEntryField.SetAsStTime(Value : TStTime);
  {-sets the field value to a Time Value}
begin
  if efDataType mod fcpDivisor = fsubTime then
    SetValue(Value)
  else
    raise EInvalidDataType.Create;
end;

procedure TOvcBaseEntryField.SetAutoAdvanceChar(Value : Boolean);
  {-sets the AutoAdvanceChar option}
begin
  if Value <> FAutoAdvanceChar then begin
    FAutoAdvanceChar := Value;
    efRemoveBadOptions;
  end;
end;

procedure TOvcBaseEntryField.SetAutoAdvanceLeftRight(Value : Boolean);
  {-sets the AutoAdvanceLeftRight option}
begin
  if Value <> FAutoAdvanceLR then begin
    FAutoAdvanceLR := Value;
    efRemoveBadOptions;
  end;
end;

{!!.10} {added}
procedure TOvcBaseEntryField.SetAutoAdvanceUpDown(Value : Boolean);
  {-set the AutoAdvanceUD option}
begin
  if Value <> FAutoAdvanceUD then begin
    FAutoAdvanceUD := Value;
    if FAutoAdvanceUD then
      FArrowIncDec := False;
  end;
end;

procedure TOvcBaseEntryField.SetAutoSelect(Value : Boolean);
  {-set the AutoSelect option}
begin
  if Value <> FAutoSelect then
    FAutoSelect := Value;
end;

procedure TOvcBaseEntryField.SetAutoSize(Value : Boolean);
  {-set the AutoSize option}
begin
  if Value <> FAutoSize then begin
    FAutoSize := Value;

    if not (csLoading in ComponentState) then                          {!!.01}
      efAdjustSize; {adjust height based on font}
  end;
end;

procedure TOvcBaseEntryField.SetBorderStyle(Value : TBorderStyle);
  {-set the type of border to use}
begin
  if FBorderStyle <> Value then begin
    FBorderStyle := Value;
    {if FBorderStyle = bsNone then}                                    {!!.01}
    {  Ctl3D := False;}                                                {!!.01}
    RecreateWnd;
  end;
end;

procedure TOvcBaseEntryField.SetBounds(ALeft, ATop, AWidth, AHeight : Integer);
begin
  if FAutoSize and (AHeight <> Height) and
     not (csLoading in ComponentState) then
    FAutoSize := False;

  inherited SetBounds(ALeft, ATop, AWidth, AHeight);

  efCalcTopMargin;                                                     {!!.01}

  if HandleAllocated and (GetFocus = Handle) then                      {!!.01}
    efPositionCaret(False);  {adjust caret for new size}               {!!.01}
  Refresh;                                                             {!!.01}
end;

procedure TOvcBaseEntryField.SetCaretToEnd(Value : Boolean);
  {-set the CaretToEnd option}
begin
  if Value <> FCaretToEnd then begin
    FCaretToEnd := Value;
    efRemoveBadOptions;
  end;
end;

procedure TOvcBaseEntryField.SetDecimalPlaces(Value : Byte);
  {-set the number of decimal places for the edit field}
begin
  if Value <> FDecimalPlaces then begin
    FDecimalPlaces := Value;
    RecreateWnd;
  end;
end;

procedure TOvcBaseEntryField.SetEpoch(Value : Integer);
begin
  if Value <> FEpoch then
    if (Value = 0) or ((Value >= MinYear) and (Value <= MaxYear)) then
      FEpoch := Value;
end;

procedure TOvcBaseEntryField.SetEverModified(Value : Boolean);
  {-set the EverModified flag}
begin
  if Value then
    Include(sefOptions, sefEverModified)
  else begin
    Exclude(sefOptions, sefEverModified);

    {clear sefModified also}
    Exclude(sefOptions, sefModified);
  end;
end;

procedure TOvcBaseEntryField.SetInputRequired(Value : Boolean);
  {-sets the InpurRequired option}
begin
  if Value <> FInputRequired then begin
    FInputRequired := Value;
    efRemoveBadOptions;
  end;
end;

procedure TOvcBaseEntryField.SetInsCaretType(const Value : TOvcCaret);
  {-set the type of caret to use}
begin
  if Value <> efCaret.InsCaretType then
    efCaret.InsCaretType := Value;
end;

procedure TOvcBaseEntryField.SetInsertPushes(Value : Boolean);
  {-set the InsertPushes option}
begin
  if Value <> FInsertPushes then begin
    FInsertPushes := Value;
    efRemoveBadOptions;
  end;
end;

procedure TOvcBaseEntryField.SetIntlSupport(Value : TOvcIntlSup);
  {-set the international support object this field will use}
begin
  if Assigned(Value) then
    FIntlSup := Value
  else
    FIntlSup := OvcIntlSup;
end;

procedure TOvcBaseEntryField.SetForceInsert(Value : Boolean);
  {-set the force insert option}
begin
  if Value <> FForceInsert then begin
    FForceInsert := Value;
    if FForceInsert then
      FForceOvertype := False;
    efRemoveBadOptions;
  end;
end;

procedure TOvcBaseEntryField.SetForceOvertype(Value : Boolean);
  {-set the force overtype option}
begin
  if Value <> FForceOvertype then begin
    FForceOvertype := Value;
    if FForceOvertype then
      FForceInsert := False;
    efRemoveBadOptions;
  end;
end;

procedure TOvcBaseEntryField.SetMaxLength(Value : Word);
  {-set the maximum length of the edit field}
begin
  if csLoading in ComponentState then
    FMaxLength := Value
  else if (FMaxLength <> Value) and
          (Value > 0) and
          (Value <= MaxEditLen) and
          (Value >= efPicLen) then begin
    FMaxLength := Value;
    if StrLen(efEditSt) > FMaxLength then
      efEditSt[FMaxLength] := #0;
    {efInitializeDataSize;}                                            {!!.11}
    {Repaint;}                                                         {!!.11}
    RecreateWnd;                                                       {!!.11}
  end;
end;

procedure TOvcBaseEntryField.SetModified(Value : Boolean);
  {-set the modified flag}
begin
  if Value then begin
    Include(sefOptions, sefModified);

    {set sefEverModified also}
    Include(sefOptions, sefEverModified);
  end else
    Exclude(sefOptions, sefModified);
end;

procedure TOvcBaseEntryField.SetOvrCaretType(const Value : TOvcCaret);
  {-set the type of caret to use}
begin
  if Value <> efCaret.OvrCaretType then
    efCaret.OvrCaretType := Value;
end;

procedure TOvcBaseEntryField.SetPadChar(Value : AnsiChar);
  {-set the character used to pad the end of the edit AnsiString}
begin
  if Value <> FPadChar then begin
    FPadChar := Value;
    Refresh;
  end;
end;

procedure TOvcBaseEntryField.SetPasswordChar(Value : AnsiChar);
  {-set the character used to mask password entry}
begin
  if FPasswordChar <> Value then begin
    FPasswordChar := Value;
    if Value = #0 then
      PasswordMode := False;
    Refresh;
  end;
end;

procedure TOvcBaseEntryField.SetPasswordMode(Value : Boolean);
  {-set use of password mode}
begin
  if Value <> FPasswordMode then begin
    FPasswordMode := Value;
    efRemoveBadOptions;
  end;
end;

procedure TOvcBaseEntryField.SetReadOnly(Value : Boolean);
  {-set the read only option}
begin
  if Value <> FReadOnly then begin
    FReadOnly := Value;
    efRemoveBadOptions;
  end;
end;

{!!.10} {added}
procedure TOvcBaseEntryField.SetRightAlign(Value : Boolean);
  {-set the right align option}
begin
  if Value <> FRightAlign then begin
    FRightAlign := Value;
    efPositionCaret(True);                                             {!!.11}
    Refresh;
  end;
end;

procedure TOvcBaseEntryField.SetRightJustify(Value : Boolean);
  {-set the right justify option}
begin
  if Value <> FRightJustify then begin
    FRightJustify := Value;

    {if asking for right justify then set trimblanks for strings}
    if FRightJustify then
      if efDataType mod fcpDivisor = fsubString then
        FTrimBlanks := True;
    efRemoveBadOptions;
    Refresh;
  end;
end;

procedure TOvcBaseEntryField.SetSelLength(Value : Integer);
  {-set the extent of the selected text}
begin
  SetSelection(efSelStart, efSelStart + Value);
  Refresh;
end;

procedure TOvcBaseEntryField.SetInitialValue;
  {-resets the field value to its initial value}
begin
  efSetInitialValue;
end;

procedure TOvcBaseEntryField.SetInsertMode(Value : Boolean);
  {-changes the field's insert mode}
begin
  if Value <> (sefInsert in sefOptions) then begin
    if Value then
      Include(sefOptions, sefInsert)
    else
      Exclude(sefOptions, sefInsert);
    Controller.InsertMode := Value;
    efCaret.InsertMode := Value;
  end;
end;

procedure TOvcBaseEntryField.SetRangeHi(const Value : TRangeType);
  {-set the high range for this field}
begin
  case efDataType mod fcpDivisor of
    fsubLongInt  : efRangeHi.rtLong := Value.rtLong;
    fsubWord     : efRangeHi.rtLong := Value.rtWord;
    fsubInteger  : efRangeHi.rtLong := Value.rtInt;
    fsubByte     : efRangeHi.rtLong := Value.rtByte;
    fsubShortInt : efRangeHi.rtLong := Value.rtSht;
    fsubExtended : efRangeHi.rtExt  := Value.rtExt;
    fsubDouble   : efRangeHi.rtExt  := Value.rtDbl;
    fsubSingle   : efRangeHi.rtExt  := Value.rtSgl;
    fsubComp     : efRangeHi.rtExt  := Value.rtComp;
  else
    efRangeHi := Value;
  end;
end;

procedure TOvcBaseEntryField.SetRangeHiStr(const Value : AnsiString);
  {-set the high field range from a AnsiString value}
var
  R : TRangeType;
begin
  R := efRangeHi;
  if not (csLoading in ComponentState) then
    if not efStRangeToRange(Value, R) then
      raise EInvalidRangeValue.Create(efDataType mod fcpDivisor);
  efRangeHi := R;
end;

procedure TOvcBaseEntryField.SetRangeLo(const Value : TRangeType);
  {-set the low range for this field}
begin
  case efDataType mod fcpDivisor of
    fsubLongInt  : efRangeLo.rtLong := Value.rtLong;
    fsubWord     : efRangeLo.rtLong := Value.rtWord;
    fsubInteger  : efRangeLo.rtLong := Value.rtInt;
    fsubByte     : efRangeLo.rtLong := Value.rtByte;
    fsubShortInt : efRangeLo.rtLong := Value.rtSht;
    fsubExtended : efRangeLo.rtExt  := Value.rtExt;
    fsubDouble   : efRangeLo.rtExt  := Value.rtDbl;
    fsubSingle   : efRangeLo.rtExt  := Value.rtSgl;
    fsubComp     : efRangeLo.rtExt  := Value.rtComp;
  else
    efRangeLo := Value;
  end;
end;

procedure TOvcBaseEntryField.SetRangeLoStr(const Value : AnsiString);
  {-set the low field range from a AnsiString value}
var
  R : TRangeType;
begin
  R := efRangeLo;
  if not (csLoading in ComponentState) then
    if not efStRangeToRange(Value, R) then
      raise EInvalidRangeValue.Create(efDataType mod fcpDivisor);
  efRangeLo := R;
end;

procedure TOvcBaseEntryField.SetSelStart(Value : Integer);
  {-set the starting position of the selection}
begin
  SetSelection(Value, Value);
  Refresh;
end;

{!!.13} {added}
procedure TOvcBaseEntryField.SetSelText(const Value : AnsiString);
  {-replace selected text with Value}
var
  Msg : TMessage;
  Buf : array[0..MaxEditLen] of AnsiChar;
begin
  StrPCopy(Buf, Value);
  Msg.lParam := LongInt(@Buf);
  efPerformEdit(Msg, ccPaste);
end;

procedure TOvcBaseEntryField.SetSoftValidation(Value : Boolean);
  {-sets the SoftValidation option}
begin
  if Value <> FSoftValidation then begin
    FSoftValidation := Value;
    efRemoveBadOptions;
  end;
end;

procedure TOvcBaseEntryField.SetStripLiterals(Value : Boolean);
  {-set the strip literals option}
begin
  if Value <> FStripLiterals then begin
    FStripLiterals := Value;
    efRemoveBadOptions;
  end;
end;

procedure TOvcBaseEntryField.SetTextMargin(Value : Integer);
  {-set the text margin}
begin
  if (Value <> FTextMargin) and (Value >= 2) then begin
    FTextMargin := Value;
    Refresh;
  end;
end;

procedure TOvcBaseEntryField.SetTrimBlanks(Value : Boolean);
  {-set the trim blanks option}
begin
  if Value <> FTrimBlanks then begin
    FTrimBlanks := Value;

    {if this is a AnsiString picture field then turn off right justify}
    if not FTrimBlanks then begin
      if efFieldClass = fcPicture then
        if efDataType mod fcpDivisor = fsubString then
          FRightJustify := False;
    end;
    efRemoveBadOptions;
  end;
end;

procedure TOvcBaseEntryField.SetUninitialized(Value : Boolean);
  {-sets the Uninitialized option}
begin
  if Value <> FUninitialized then begin
    FUninitialized := Value;
    efRemoveBadOptions;
  end;
end;

procedure TOvcBaseEntryField.SetUserData(Value : TOvcUserData);
  {-sets pointer to user-defined mask data object}
begin
  if Assigned(Value) then
    FUserData := Value
  else
    FUserData := OvcUserData;
end;

procedure TOvcBaseEntryField.SetValue(const Data);
  {-changes the field value to the value in Data}
begin
  if sefUserValidating in sefOptions then
    Exit;

  HandleNeeded;

  {set the updating flag so OnChange doesn't get fired}
  Include(sefOptions, sefUpdating);
  try
    case efDataType mod fcpDivisor of
      fsubString   : efTransfer(@ShortString(Data), otf_SetData);
      fsubChar     : efTransfer(@AnsiChar(Data), otf_SetData);
      fsubBoolean  : efTransfer(@Boolean(Data),  otf_SetData);
      fsubYesNo    : efTransfer(@Boolean(Data),  otf_SetData);
      fsubLongInt  : efTransfer(@LongInt(Data),  otf_SetData);
      fsubWord     : efTransfer(@Word(Data),     otf_SetData);
      fsubInteger  : efTransfer(@SmallInt(Data), otf_SetData);
      fsubByte     : efTransfer(@Byte(Data),     otf_SetData);
      fsubShortInt : efTransfer(@ShortInt(Data), otf_SetData);
      fsubReal     : efTransfer(@Real(Data),     otf_SetData);
      fsubExtended : efTransfer(@Extended(Data), otf_SetData);
      fsubDouble   : efTransfer(@Double(Data),   otf_SetData);
      fsubSingle   : efTransfer(@Single(Data),   otf_SetData);
      fsubComp     : efTransfer(@Comp(Data),     otf_SetData);
      fsubDate     : efTransfer(@TStDate(Data),  otf_SetData);
      fsubTime     : efTransfer(@TStTime(Data),  otf_SetData);
    else
      raise EOvcException.Create(GetOrphStr(SCInvalidParamValue));
    end;
  finally
    Exclude(sefOptions, sefUpdating);
  end;
end;

procedure TOvcBaseEntryField.SetZeroDisplay(Value : TZeroDisplay);
  {-set flag that determines if zeros are hidden}
begin
  if Value <> FZeroDisplay then begin
    FZeroDisplay := Value;
    Refresh;
  end;
end;

procedure TOvcBaseEntryField.SetZeroDisplayValue(Value : Double);
  {-set value used by ZeroDisplay logic}
begin
  if Value <> FZeroDisplayValue then begin
    FZeroDisplayValue := Value;
    Refresh;
  end;
end;

function TOvcBaseEntryField.ValidateContents(ReportError : Boolean) : Word;
  {-performs field validation, returns error code, and conditionally reports error}
var                                                                    {!!.01}
  WasValid : Boolean;                                                  {!!.01}
begin
  if not Enabled then begin                                            {!!.12}
    Result := 0;                                                       {!!.12}
    Exit;                                                              {!!.12}
  end;                                                                 {!!.12}

  FLastError := 0;

  {record current valid state}
  WasValid := IsValid;                                                 {!!.01}

  {check for empty/uninitialized required field}
  if InputRequired and not efIsReadOnly then
    if efFieldIsEmpty or (Uninitialized and not (sefModified in sefOptions)) then
      FLastError := oeRequiredField;

  {ask the validation routine if there's an error}
  if FLastError = 0 then begin
    Include(sefOptions, sefValidating);
    try
      FLastError := efValidateField;
    finally
      Exclude(sefOptions, sefValidating);
    end;
  end;

  if ReportError and (FLastError <> 0) then
    PostMessage(Handle, om_ReportError, FLastError, 0);

  {update invalid flag}                                                {!!.01}
  if FLastError = 0 then                                               {!!.01}
    Exclude(sefOptions, sefInvalid)                                    {!!.01}
  else if SoftValidation then                                          {!!.01}
    Include(sefOptions, sefInvalid);                                   {!!.01}

  {force field to repaint if valid state has changed}                  {!!.01}
  if WasValid <> IsValid then                                          {!!.01}
    Invalidate;                                                        {!!.01}

  Result := FLastError;
end;

function TOvcBaseEntryField.ValidateSelf : Boolean;
  {-performs field validation, returns true if no errors, and reports error if not using SoftValidation}
begin
  Result := ValidateContents(not SoftValidation) = 0;
end;

procedure TOvcBaseEntryField.WMChar(var Msg : TWMChar);
begin
  inherited;

  if sefCharOk in sefOptions then
    efPerformEdit(TMessage(Msg), ccChar);
end;

procedure TOvcBaseEntryField.WMClear(var Msg : TWMClear);
begin
  efPerformEdit(TMessage(Msg), ccCut);
end;

procedure TOvcBaseEntryField.WMCopy(var Msg : TWMCopy);
begin
  efCopyPrim;
  efPerformEdit(TMessage(Msg), ccCopy);
end;

procedure TOvcBaseEntryField.WMCut(var Msg : TWMCut);
  {-cut currently selected text to the clipboard}
begin
  efCopyPrim;
  efPerformEdit(TMessage(Msg), ccCut);
end;

procedure TOvcBaseEntryField.WMEraseBkGnd(var Msg : TWMEraseBkGnd);
begin
  Msg.Result := 1;  {don't erase background}
end;

procedure TOvcBaseEntryField.WMGetDlgCode(var Msg : TWMGetDlgCode);
begin
  inherited;

  if csDesigning in ComponentState then
    Msg.Result := DLGC_STATIC
  else
    Msg.Result := Msg.Result or DLGC_WANTCHARS or DLGC_WANTARROWS;
end;

procedure TOvcBaseEntryField.WMKeyDown(var Msg : TWMKeyDown);
var
  Cmd : Word;
begin
  inherited;

  if Msg.CharCode = 0 then
    Exit;

  {don't process shift key by itself}                                  {!!.11}
  if Msg.CharCode = VK_SHIFT then                                      {!!.11}
    Exit;                                                              {!!.11}

  {see if this command should be processed by us}
  Cmd := Controller.EntryCommands.Translate(TMessage(Msg), GetTickCount);

  {convert undo to restore since ctrl-Z is mapped to ccUndo by default}
  {and cannot be mapped to more than one command in a command table}
  if Cmd = ccUndo then
    Cmd := ccRestore;

  if Cmd <> ccNone then begin
    if (Cmd <> ccIns) or not (ForceInsert or ForceOvertype) then begin
      case Cmd of
        ccCut   : WMCut(TWMCut(Msg));
        ccCopy  : WMCopy(TWMCopy(Msg));
        ccPaste : WMPaste(TWMPaste(Msg));
      else
        efPerformEdit(TMessage(Msg), Cmd);
      end;
    end;
  end;
end;

procedure TOvcBaseEntryField.WMKillFocus(var Msg : TWMKillFocus);
var
  NewWindow    : HWnd;
  SaveModified : Boolean;                                              {!!.16}
begin
  {where is the focus going?}
  NewWindow := Msg.FocusedWnd;
  if NewWindow = Handle then
    NewWindow := 0
  else if not efIsSibling(NewWindow) then
    NewWindow := 0;

  {retain caret position if focus is moving }
  {to a menu or a component not on this form}
  if (NewWindow = 0) then
    Include(sefOptions, sefRetainPos)
  else
    Exclude(sefOptions, sefRetainPos);

  {destroy caret}
  efCaret.Linked := False;

  {if the mouse if currently captured, release it}
  if MouseCapture then
    MouseCapture := False;

  {perform default processing}
  inherited;

  {set controller's insert mode flag for sibling fields' to access}
  if not (ForceInsert or ForceOvertype) then
    {are we in insert mode}
    Controller.InsertMode := sefInsert in sefOptions;

  {if no error is pending for this control...}
  if not (sefErrorPending in sefOptions) and
     not (sefIgnoreFocus in sefOptions) then begin
    Include(sefOptions, sefValPending);

    {and focus is going to a control...}
    if (NewWindow <> 0) then begin
      if sefModified in sefOptions then
        {clear the unitialized option}
        Uninitialized := False;

      {that isn't a Cancel, Restore, or Help button...}
      if not Controller.IsSpecialButton(Msg.FocusedWnd) then begin
        {then validate this field}
        efCanClose(True {validate});
        if sefErrorPending in sefOptions then
          Include(sefOptions, sefValPending)
        else
          Exclude(sefOptions, sefValPending);
      end else begin                                                   {!!.16}
        {just call validate field and ignore the error, if any}
        {this forces the field to redisplay using the proper format}
        SaveModified := Modified;                                      {!!.16}
        efValidateField;
        Modified := SaveModified;                                      {!!.16}
      end;                                                             {!!.16}
    end;
  end else begin
    {set the validation pending flag on if an error is pending}
    if sefErrorPending in sefOptions then
      Include(sefOptions, sefValPending)
    else
      Exclude(sefOptions, sefValPending);
  end;

  {we no longer have the focus}
  Exclude(sefOptions, sefHaveFocus);

  {if we're not coming back...}
  if (NewWindow <> 0) and not (sefRetainPos in sefOptions) and
                   not (sefIgnoreFocus in sefOptions) then begin
    efPerformPostEditNotify(FindControl(Msg.FocusedWnd));
  end;
  Exclude(sefOptions, sefIgnoreFocus);

  {reset the caret position}
  if not (sefRetainPos in sefOptions) then
    efCaretToStart;

  {redraw the field}
  Refresh;
end;

procedure TOvcBaseEntryField.WMLButtonDblClk(var Msg : TWMLButtonDblClk);
begin
  if sefHaveFocus in sefOptions then
    efPerformEdit(TMessage(Msg), ccDblClk);

  inherited;
end;

procedure TOvcBaseEntryField.WMLButtonDown(var Msg : TWMLButtonDown);
begin
  if not (sefHaveFocus in sefOptions) then begin
    Include(sefOptions, sefNoHighlight);
    SetSelection(0, 0);
    if not Focused then
      SetFocus;
  end;

  inherited;

  if sefHaveFocus in sefOptions then
    efPerformEdit(TMessage(Msg), ccMouse);
end;

procedure TOvcBaseEntryField.WMMouseActivate(var Msg : TWMMouseActivate);
begin
  if csDesigning in ComponentState then
    Exit;

  inherited;
end;

procedure TOvcBaseEntryField.WMMouseMove(var Msg : TWMMouseMove);
begin
  inherited;

  if MouseCapture then
    if GetAsyncKeyState(GetLeftButton) and $8000 <> 0 then
      efPerformEdit(TMessage(Msg), ccMouseMove);
end;

procedure TOvcBaseEntryField.WMPaste(var Msg : TWMPaste);
  {-paste text in the clipboard into the field}
var
  H  : THandle;
begin
  H := Clipboard.GetAsHandle(CF_TEXT);
  if H <> 0 then begin
    TMessage(Msg).lParam := LongInt(GlobalLock(H));
    efPerformEdit(TMessage(Msg), ccPaste);
    GlobalUnlock(H);
  end;
end;

{!!.13} {Added}
procedure TOvcBaseEntryField.WMRButtonUp(var Msg : TWMRButtonDown);
var
  P  : TPoint;
  M  : TPopUpMenu;
  MI : TMenuItem;
begin
  if not (sefHaveFocus in sefOptions) then
    if not Focused and CanFocus then
      SetFocus;

  inherited;
  if PopUpMenu = nil then begin
    M := TPopupMenu.Create(Self);
    try
      MI := TMenuItem.Create(M);
      MI.Caption := GetOrphStr(SCRestoreMI);
      MI.Enabled := Modified;
      MI.OnClick := DoRestoreClick;
      M.Items.Add(MI);

      MI := TMenuItem.Create(M);
      MI.Caption := '-';
      M.Items.Add(MI);

      MI := TMenuItem.Create(M);
      MI.Caption := GetOrphStr(SCCutMI);
      MI.Enabled := (SelectionLength > 0) and not efIsReadOnly;        {!!.14}
      MI.OnClick := DoCutClick;
      M.Items.Add(MI);

      MI := TMenuItem.Create(M);
      MI.Caption := GetOrphStr(SCCopyMI);
      MI.Enabled := SelectionLength > 0;
      MI.OnClick := DoCopyClick;
      M.Items.Add(MI);

      MI := TMenuItem.Create(M);
      MI.Caption := GetOrphStr(SCPasteMI);
      MI.Enabled := not efIsReadOnly and Clipboard.HasFormat(CF_TEXT); {!!.14}
      MI.OnClick := DoPasteClick;
      M.Items.Add(MI);

      MI := TMenuItem.Create(M);
      MI.Caption := GetOrphStr(SCDeleteMI);
      MI.Enabled := (SelectionLength > 0) and not efIsReadOnly;        {!!.14}
      MI.OnClick := DoDeleteClick;
      M.Items.Add(MI);

      MI := TMenuItem.Create(M);
      MI.Caption := '-';
      M.Items.Add(MI);

      MI := TMenuItem.Create(M);
      MI.Caption := GetOrphStr(SCSelectAllMI);
      MI.Enabled := LongInt(StrLen(efEditSt)) > SelectionLength;       {!!.D4}
      MI.OnClick := DoSelectAllClick;
      M.Items.Add(MI);

      P.X := Msg.XPos;
      P.Y := Msg.YPos;
      P := ClientToScreen(P);
      M.PopUp(P.X, P.Y);

      Application.ProcessMessages;
    finally
      M.Free;
    end;
  end;
end;

procedure TOvcBaseEntryField.WMSetFocus(var Msg : TWMSetFocus);
var
  Highlight,
  Ignore,
  FixHOfs,
  ValPending : Boolean;
  PF         : TForm;
  P          : TPoint;
begin
  if csDesigning in ComponentState then
    Exit;

  {we have the focus}
  Include(sefOptions, sefHaveFocus);

  {reset command processor}
  Controller.EntryCommands.ResetCommandProcessor;

  {get validation state}
  ValPending := sefValPending in sefOptions;

  {calling Show forces the parent to do whatever is necessary to}
  {make sure that we are visible. In the case where the entry}
  {field is on a non-visible notebook page that has had its}
  {handle deallocated, this insures that the page is made visible}
  {and that the window handles have been created}

  {if focus is retruning because of an error condition}
  if ValPending then begin

    {tell the control that lost the focus to}
    {cancel any special modes it might be in}
    if Msg.FocusedWnd > 0 then begin
      SendMessage(Msg.FocusedWnd, WM_CANCELMODE, 0, 0);
      GetCursorPos(P);
      {send a fake mouse up message to force release of mouse capture}
      {this is necessary so that the TStringGrid exits highlight mode}
      SendMessage(Msg.FocusedWnd, WM_LBUTTONUP, 0, MakeLong(P.X, P.Y));
    end;

    Show;
    PF := TForm(GetParentForm(Self));
    if Assigned(PF) then
      PF.FocusControl(Self);
  end;

  {get the field's insert mode}
  if not (ForceInsert or ForceOvertype) then
    if Controller.InsertMode then
      Include(sefOptions, sefInsert)
    else
      Exclude(sefOptions, sefInsert);

  if sefRetainPos in sefOptions then begin
    Highlight := False;
    FixHOfs := False;
    Ignore := False;
  end else begin
    Ignore := Controller.ErrorPending and {not us} (FLastError = 0);   {!!.13}
    if not Ignore then begin
      if not ValPending then
        Exclude(sefOptions, sefModified);
      efPerformPreEditNotify(FindControl(Msg.FocusedWnd));
      {save a copy of the current edit AnsiString}
      efSaveEditString;
    end;

    if sefNoHighlight in sefOptions then begin
      Highlight := False;
      FixHOfs := False;
    end else begin
      Highlight := (not Ignore);
      FixHOfs := True;
      efResetCaret;
    end;
  end;

  if Ignore and not SoftValidation then                                {!!.12}
    Include(sefOptions, sefIgnoreFocus)
  else
    Exclude(sefOptions, sefIgnoreFocus);

  Exclude(sefOptions, sefErrorPending);
  Exclude(sefOptions, sefRetainPos);
  Exclude(sefOptions, sefNoHighlight);
  Exclude(sefOptions, sefValPending);

  {clear controller's error pending flag}
  if not Ignore then                                                   {!!.13}
    Controller.ErrorPending := False;

  inherited;

  if ForceInsert then
    Include(sefOptions, sefInsert)
  else if ForceOvertype then
    Exclude(sefOptions, sefInsert);

  efCaret.Linked := True;
  efCaret.Visible := True;
  efCaret.InsertMode := (sefInsert in sefOptions);
  efPositionCaret(FixHOfs);

  if Highlight and FAutoSelect then
    SetSelection(0, MaxEditLen);

  Refresh;
end;

procedure TOvcBaseEntryField.WMSetFont(var Msg : TWMSetFont);
begin
  inherited;

  {inherited WMSetFont sets our font. Set it as our canvas font}
  Canvas.Font := Font;
end;

procedure TOvcBaseEntryField.WMSetText(var Msg : TWMSetText);
begin
  if HandleAllocated then begin
    SetSelection(0, MaxEditLen);
    efPerformEdit(TMessage(Msg), ccPaste);
  end;
end;

procedure TOvcBaseEntryField.WMSize(var Msg : TWMSize);
begin
  inherited;

  Refresh;
end;

procedure TOvcBaseEntryField.WMSysKeyDown(var Msg : TWMSysKeyDown);
var
  Cmd : Word;
begin
  inherited;

  {exit if this is a Tab key or an Alt key by itself}                  {!!.01}
  if (Msg.CharCode = VK_TAB) or (Msg.CharCode = VK_ALT) then           {!!.01}
    Exit;                                                              {!!.01}

  {see if this command should be processed by us}
  Cmd := Controller.EntryCommands.TranslateKey(Msg.CharCode, [ssAlt]); {!!.01}

  {convert undo to restore since ctrl-Z is mapped to ccUndo by default}
  {and cannot be mapped to more than one command in a command table}
  if Cmd = ccUndo then
    Cmd := ccRestore;

  if Cmd <> ccNone then begin
    case Cmd of
      ccCut   : WMCut(TWMCut(Msg));
      ccCopy  : WMCopy(TWMCopy(Msg));
      ccPaste : WMPaste(TWMPaste(Msg));
    else
      efPerformEdit(TMessage(Msg), Cmd);
    end;

    {allow entering of characters using Alt-keypad numbers}
    case Msg.CharCode of
      vk_NumPad0, vk_NumPad1, vk_NumPad2, vk_NumPad3, vk_NumPad4,
      vk_NumPad5, vk_NumPad6, vk_NumPad7, vk_NumPad8, vk_NumPad9:
        begin
          Include(sefOptions, sefCharOk);
          Include(sefOptions, sefAcceptChar);
        end;
    end;
  end;
end;



end.