{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFDEF Win32}
{$H+} {Long strings}
{$ENDIF}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                  OVCDBAE0.PAS 2.17                    *}
{*     Copyright 1995-98 (c) TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcDbAE0;
  {-Range property editor for data-aware array editors}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, Graphics, ExtCtrls, Forms, Controls, Buttons, DsgnIntf,
  StdCtrls, SysUtils,
  OvcBase, OvcConst, OvcData, OvcDbAe, OvcHelp, OvcPb, OvcPf,
  OvcEf, OvcSf, OvcStr;

type
  TOvcfrmDbAeRange = class(TForm)
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    btnHelp: TBitBtn;
    lblRange: TLabel;
    lblLower: TLabel;
    lblUpper: TLabel;
    pfRange: TOvcPictureField;
    DefaultController: TOvcController;
    sfRange: TOvcSimpleField;
    procedure btnHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  {local class to allow access to protected data and methods}
  TLocalAE = class(TOvcBaseDbArrayEditor);
  TLocalEF = class(TOvcDbSimpleCell);

type
  {property editor for ranges}
  TDbAeRangeProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes;
      override;
    function GetValue : string;
      override;
    procedure Edit;
      override;
  end;

implementation

{$R *.DFM}


{*** TDbAeRangeProperty ***}

function TDbAeRangeProperty.GetAttributes: TPropertyAttributes;
begin
  case TLocalEF(TLocalAE(GetComponent(0)).aeCell).efDataType mod fcpDivisor of
    fsubString,
    fsubBoolean,
    fsubYesNo    : Result := [paDialog, paReadOnly]
  else
    Result := [paDialog];
  end;
end;

function TDbAeRangeProperty.GetValue : string;
begin
  {return string that is displayed in the object inspector}
  case TLocalEF(TLocalAE(GetComponent(0)).aeCell).efDataType mod fcpDivisor of
    fsubString,
    fsubBoolean,
    fsubYesNo    : Result := '(None)';
  else
    Result := inherited GetValue;
  end;
end;

procedure TDbAeRangeProperty.Edit;
var
  UsePf    : Boolean;
  RangePE  : TOvcfrmDbAeRange;
  AE       : TLocalAE;
  Field    : TOvcBaseEntryField;
  pfDT     : TPictureDataType;
  sfDT     : TSimpleDataType;
  R        : TRangeType;
  S        : string;
  PropName : string;

  procedure ChangeFromRange(var Data; DataType : Byte);
    {-alter how data is stored based on the field data type}
  begin
    case DataType mod fcpDivisor of
      fsubChar     : {no change needed};
      fsubLongInt  : {no change needed};
      fsubWord     : Word(Data) := TRangeType(Data).rtLong;
      fsubInteger  : Integer(Data) := TRangeType(Data).rtLong;
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
      fsubInteger  : TRangeType(Data).rtLong := Integer(Data);
      fsubByte     : TRangeType(Data).rtLong := Byte(Data);
      fsubShortInt : TRangeType(Data).rtLong := ShortInt(Data);
      fsubReal     : {no change needed};
      fsubExtended : {no change needed};
      fsubDouble   : TRangeType(Data).rtExt := Double(Data);
      fsubSingle   : TRangeType(Data).rtExt := Single(Data);
      fsubComp     : TRangeType(Data).rtExt := Comp(Data);
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
  RangePE := TOvcfrmDbAeRange.Create(Application);
  try
    with RangePE do begin
      AE := TLocalAE(GetComponent(0));

      {initialize to unused data types}
      sfDT := sftString;
      pfDT := pftString;

      {set our edit field to the fields data type}
      case TLocalEF(AE.aeCell).efDataType mod fcpDivisor of
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
        {don't allow editing ranges for string, boolean, yesno fields}
        raise Exception.Create(GetOrphStr(SCRangeNotSupported));
      end;

      UsePF := pfDT in [pftDate, pftTime];
      if UsePF then begin
        pfRange.HandleNeeded;
        pfRange.DataType := pfDT;
        pfRange.Visible := True;
        Field := pfRange
      end else begin
        sfRange.HandleNeeded;
        sfRange.DataType := sfDT;
        sfRange.Visible := True;
        sfRange.DecimalPlaces := GetDecimalPlaces(TLocalEF(AE.aeCell));
        sfRange.MaxLength := AE.aeCell.MaxLength;
        Field := sfRange;
      end;

      lblLower.Caption := Field.RangeLo;
      lblUpper.Caption := Field.RangeHi;

      {set default value based on current field range value}
      PropName := GetName;
      if CompareText(PropName, 'RangeHi') = 0 then
        R := TLocalEF(AE.aeCell).efRangeHi
      else
        R := TLocalEF(AE.aeCell).efRangeLo;

      ChangeFromRange(R, TLocalEF(AE.aeCell).efDataType);
      Field.SetValue(R);

      {show the form}
      ShowModal;
      if ModalResult = idOK then begin
        {transfer values}
        Field.GetValue(R);
        ChangeToRange(R, TLocalEF(AE.aeCell).efDataType);
        if CompareText(PropName, 'RangeHi') = 0 then begin
          {let edit cell convert it to a string}
          AE.aeCell.SetRangeHi(R);
          S := AE.aeCell.RangeHi;
          AE.RangeHi := S;
        end else begin
          {let edit cell convert it to a string}
          AE.aeCell.SetRangeLo(R);
          S := AE.aeCell.RangeLo;
          AE.RangeLo := S;
        end;
        Modified;
      end;
    end;
  finally
    RangePE.Free;
  end;
end;


{*** TfrmRange ***}

procedure TOvcfrmDbAeRange.btnHelpClick(Sender: TObject);
begin
  ShowHelpContext(hcArrayEditorRange);
end;

end.