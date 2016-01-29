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
{*                  OVCREGTB.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$IFDEF Win32}
  {$IFNDEF VER93}                                                      {!!.16}
    {$R OVCREGTB.R32}
  {$ENDIF}
{$ELSE}
  {$R OVCREGTB.R16}
{$ENDIF}


unit OvcRegTb;
  {-Registration unit for the Orpheus table components}

{$I l3Define.inc }

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes,
  {$IfDef Delphi6}
  DesignIntf,
  DesignEditors,
  {$Else  Delphi6}
  DsgnIntf,
  {$EndIf Delphi6}
  Forms, SysUtils;


procedure Register;


implementation

uses
  OvcData, OvcFnPE,
  OvcSFPE, OvcPFPE, OvcNFPE, OvcTCPE,
  //OvcWebP0,  {turbopower web component editor class}
  OvcTCell,
  OvcTable,
  OvcTbPE1,
  OvcTbPE2,
  OvcTbRws, OvcTbCls,
  OvcTCEdt,
  OvcTCHdr,
  OvcTCBmp,
  OvcTCGly,
  OvcTCBox,
  OvcTCSim,
  OvcTCPic,
  OvcTCNum,
  OvcTCCBx,
  OvcTCIco,
  OvcTCDT,   {V}
  OvcVer;


{$I OVCTABS.INC}  {constant declarations for Delphi palette tab names}

type
  {component editor for the table}
  TOvcTableEditor = class(TDefaultEditor)
  public
    procedure ExecuteVerb(Index : Integer);
      override;
    function GetVerb(Index : Integer) : AnsiString;
      override;
    function GetVerbCount : Integer;
      override;
  end;

{*** TOvcTableEditor ***}

const
  TableVerbs : array[0..1{3}] of PAnsiChar =
    ('Columns Editor', 'Rows Editor'{, WebText, MailText});

procedure TOvcTableEditor.ExecuteVerb(Index : Integer);
var
  Table : TOvcTable;
  C     : TColEditor;
  R     : TOvcRowEditor;
begin
  Table := TOvcTable(Component);
  if Index = 0 then begin
    C := TColEditor.Create(Application);
    try
      C.Editor := Self;
      C.SetCols(TOvcTableColumns(Table.Columns));
      C.ShowModal;
      Designer.Modified;
    finally
      C.Free;
    end;
  end else if Index = 1 then begin
    R := TOvcRowEditor.Create(Application);
    try
      R.SetRows(TOvcTableRows(Table.Rows));
      R.ShowModal;
      Designer.Modified;
    finally
      R.Free;
    end;
  end {else if Index = 2 then
    ShellWebCall
  else if Index = 3 then
    ShellMailCall};
end;

function TOvcTableEditor.GetVerb(Index : Integer) : AnsiString;
begin
  Result := StrPas(TableVerbs[Index]);
end;

function TOvcTableEditor.GetVerbCount : Integer;
begin
  Result := High(TableVerbs) + 1;
end;


{*** component registration ***}

procedure Register;
begin
  RegisterPropertyEditor(
    TypeInfo(TOvcTableRows), TOvcTable, '', TOvcTableRowProperty);

  RegisterPropertyEditor(
    TypeInfo(TOvcTableColumns), TOvcTable, '', TOvcTableColumnProperty);

  {register component editor for the table}
  RegisterComponentEditor(TOvcTable, TOvcTableEditor);

  {register property editors for the cell entry fields}
  RegisterPropertyEditor(
    TypeInfo(Char), TOvcTCSimpleField, 'PictureMask', TSimpleMaskProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcTCPictureField, 'PictureMask', TPictureMaskProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcTCNumericField, 'PictureMask', TNumericMaskProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcTCSimpleField, 'RangeHi', OvcTCPE.TTCRangeProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcTCSimpleField, 'RangeLo', OvcTCPE.TTCRangeProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcTCPictureField, 'RangeHi', OvcTCPE.TTCRangeProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcTCPictureField, 'RangeLo', OvcTCPE.TTCRangeProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcTCNumericField, 'RangeHi', OvcTCPE.TTCRangeProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcTCNumericField, 'RangeLo', OvcTCPE.TTCRangeProperty);

  {register component editors for the turbopower web}
//  RegisterComponentEditor(TOvcBaseTableCell, TOvcWebEditor);

  {!!.13}
  {register property editor for version property}
  RegisterPropertyEditor(
    TypeInfo(string), TOvcBaseTableCell, 'Version', TOvcVersionProperty);

  RegisterComponents(OrpheusTableTabName,
    [TOvcTable,
     TOvcTCColHead,
     TOvcTCRowHead,
     TOvcTCString,
     TOvcTCSimpleField,
     TOvcTCPictureField,
     TOvcTCNumericField,
     TOvcTCMemo,
     TOvcTCCheckBox,
     TOvcTCComboBox,
     TOvcTCBitMap,
     TOvcTCGlyph,
     TOvcTCDate,  {V}
     TOvcTCIcon]);
end;

end.