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
{*                  OVCEFPE.PAS 2.17                     *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcEfPe;
  {-Property editor for the entry fields}

{$I l3Define.inc }

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, Graphics, Forms, Controls, Buttons, 
  {$IfDef Delphi6}
  DesignIntf,
  DesignEditors,
  {$Else  Delphi6}
  DsgnIntf,
  {$EndIf Delphi6}
  StdCtrls, ExtCtrls,
  OvcBase, OvcData, OvcEF, OvcHelp, OvcNF, OvcPB, OvcPF,
  OvcSF, OvcStr;

type
  TOvcfrmEfRange = class(TForm)
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    btnHelp: TBitBtn;
    lblRange: TLabel;
    lblLower: TLabel;
    lblUpper: TLabel;
    pfRange: TOvcPictureField;
    DefaultController: TOvcController;
    sfRange: TOvcSimpleField;
    Bevel: TBevel;
    procedure btnHelpClick(Sender: TObject);
  protected
    { Private declarations }
    TR : TOvcSimpleField;
  public
    { Public declarations }
  end;

type
  {local class to allow access to protected data}
  TLocalEF = class(TOvcBaseEntryField);

type
  {property editor for ranges}
  TEfRangeProperty = class(TStringProperty)
  public
    function GetAttributes : TPropertyAttributes;
      override;
    function GetValue : AnsiString;
      override;
    procedure Edit;
      override;
  end;

implementation

{$R *.DFM}

uses
  OvcConst, OvcIntl, SysUtils;


{*** TEfRangeProperty ***}

function TEfRangeProperty.GetAttributes: TPropertyAttributes;
begin
  case TLocalEF(GetComponent(0)).efDataType mod fcpDivisor of
    fSubString,
    fsubBoolean,
    fsubYesNo    : Result := [paDialog, paReadOnly]
  else
    Result := [paDialog];
  end;
end;

function TEfRangeProperty.GetValue : AnsiString;
begin
  {return string that is displayed in the object inspector}
  case TLocalEF(GetComponent(0)).efDataType mod fcpDivisor of
    fSubString,
    fsubBoolean,
    fsubYesNo    : Result := '(None)';
  else
    Result := inherited GetValue;
  end;
end;

procedure TEfRangeProperty.Edit;
var
  RangePE  : TOvcfrmEfRange;
  EF       : TLocalEf;
  Field    : TOvcBaseEntryField;
  pfDT     : TPictureDataType;
  sfDT     : TSimpleDataType;
  R        : TRangeType;
  PropName : string;

  procedure ChangeFromRange(var Data; DataType : Byte);
    {-alter how data is stored based on the field data type}
  begin
    case DataType mod fcpDivisor of
      fsubChar     : {no change needed};
      fsubLongInt  : {no change needed};
      fsubWord     : Word(Data) := TRangeType(Data).rtLong;
      fsubInteger  : SmallInt(Data) := TRangeType(Data).rtLong;
      fsubByte     : Byte(Data) := TRangeType(Data).rtLong;
      fsubShortInt : ShortInt(Data) := TRangeType(Data).rtLong;
      fsubReal     : {no change needed};
      fsubExtended : {no change needed};
      fsubDouble   : Double(Data) := TRangeType(Data).rtExt;
      fsubSingle   : Single(Data) := TRangeType(Data).rtExt;
      fsubComp     : Comp(Data) := TRangeType(Data).rtExt;
      fsubDate     : {no change needed};
      fsubTime     : {no change needed};
    end;
  end;

  procedure ChangeToRange(var Data; DataType : Byte);
    {-alter how data is stored based on the field data type}
  begin
    case DataType mod fcpDivisor of
      fsubChar     : {no change needed};
      fsubLongInt  : {no change needed};
      fsubWord     : TRangeType(Data).rtLong := Word(Data);
      fsubInteger  : TRangeType(Data).rtLong := SmallInt(Data);
      fsubByte     : TRangeType(Data).rtLong := Byte(Data);
      fsubShortInt : TRangeType(Data).rtLong := ShortInt(Data);
      fsubReal     : {no change needed};
      fsubExtended : {no change needed};
      fsubDouble   : TRangeType(Data).rtDbl := Double(Data);           {!!.13}
      fsubSingle   : TRangeType(Data).rtSgl := Single(Data);           {!!.13}
      fsubComp     : TRangeType(Data).rtComp := Comp(Data);            {!!.13}
      fsubDate     : {no change needed};
      fsubTime     : {no change needed};
    end;
  end;

  function GetDecimalPlaces(EF : TLocalEF) : Byte;
  var
    I      : Word;
    DotPos : Cardinal;
  begin
    if not StrChPos(EF.efPicture, pmDecimalPt, DotPos) then
      Result := EF.DecimalPlaces
    else begin
      Result := 0;
      for I := DotPos+1 to EF.MaxLength-1 do
        if EF.efNthMaskChar(I) in PictureChars then
          Inc(Result)
        else
          Break;
    end;
  end;

begin
  RangePE := TOvcfrmEfRange.Create(Application);
  try
    with RangePE do begin
      EF := TLocalEF(GetComponent(0));

      {initialize to unused data types}
      sfDT := sftString;
      pfDT := pftString;

      {set our edit field to the fields data type}
      case EF.efDataType mod fcpDivisor of
        fsubChar     : sfDT := sftChar;
        fsubLongInt  : sfDT := sftLongInt;
        fsubWord     : sfDT := sftWord;
        fsubInteger  : sfDT := sftInteger;
        fsubByte     : sfDT := sftByte;
        fsubShortInt : sfDT := sftShortInt;
        fsubReal     : sfDT := sftReal;
        fsubExtended : sfDT := sftExtended;
        fsubDouble   : sfDT := sftDouble;
        fsubSingle   : sfDT := sftSingle;
        fsubComp     : sfDT := sftComp;
        fsubDate     : pfDT := pftDate;
        fsubTime     : pfDT := pftTime;
      else
        {don't allow editing ranges for string, boolean, or yesno fields}
        raise Exception.Create(GetOrphStr(SCRangeNotSupported));
      end;

      if pfDT in [pftDate, pftTime] then begin
        pfRange.HandleNeeded;
        pfRange.DataType := pfDT;
        pfRange.Visible := True;
        if pfDT = pftDate then
          pfRange.PictureMask := OvcIntlSup.InternationalDate(True)
        else
          pfRange.PictureMask := OvcIntlSup.InternationalTime(False);
        pfRange.MaxLength := Length(pfRange.PictureMask);
        Field := pfRange
      end else begin
        sfRange.HandleNeeded;
        sfRange.DataType := sfDT;
        sfRange.Visible := True;
        sfRange.DecimalPlaces := GetDecimalPlaces(EF);
        sfRange.MaxLength := EF.MaxLength;
        Field := sfRange;
      end;

      lblLower.Caption := Field.RangeLo;
      lblUpper.Caption := Field.RangeHi;

      {set default value based on current field range value}
      PropName := GetName;
      if CompareText(PropName, 'RangeHi') = 0 then
        R := EF.efRangeHi
      else
        R := EF.efRangeLo;

      ChangeFromRange(R, EF.efDataType);
      Field.SetValue(R);

      {show the form}
      ShowModal;
      if ModalResult = idOK then begin
        {transfer values}
        Field.GetValue(R);
        ChangeToRange(R, EF.efDataType);
        if CompareText(PropName, 'RangeHi') = 0 then
          EF.SetRangeHi(R)
        else
          EF.SetRangeLo(R);
        Modified;
      end;
    end;
  finally
    RangePE.Free;
  end;
end;


{*** TfrmRange ***}

procedure TOvcfrmEfRange.btnHelpClick(Sender: TObject);
begin
  ShowHelpContext(hcEntryFieldRange);
end;

end.