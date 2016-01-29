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
{*                  OVCREGDB.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$IFDEF Win32}
  {$IFNDEF VER93}                                                      {!!.16}
    {$R OVCREGDB.R32}
  {$ENDIF}
{$ELSE}
  {$R OVCREGDB.R16}
{$ENDIF}

unit OvcRegDb;
  {-Registration unit for the basic Orpheus components}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, DsgnIntf, Forms, SysUtils;

procedure Register;

implementation

uses
  OvcVer, OvcFnPE,
  OvcData,
  OvcDbEd,   {data aware editor}
  OvcEfPE,   {range property editor}
  OvcSfPE,   {simple mask property editor form}
  OvcPfPE,   {picture mask property editor form}
  OvcNfPE,   {numeric mask property editor}
  OvcWebP0,  {turbopower web componenteditor class}
  OvcDbSF,   {data aware simple field}
  OvcDbPF,   {data aware picture field}
  OvcDbNF,   {data aware numeric field}
  OvcDbAE,   {data aware array editors}
  OvcDbAE0,  {dbae range property editor form}
  OvcDbAE1,  {simple picture mask property editor}
  OvcDbAE2,  {picture picture mask property editor}
  OvcDbAE3,  {numeric picture mask property editor}
  OvcDbTbl,  {data aware table}
  OvcDbTb0,  {data aware table columns editor}
  OvcTbCls,  {table columns}
  OvcDbCal,  {data aware calendar}
  OvcDbPLb,  {db picture label}
  OvcDbDLb,  {db display label}
  OvcDbCl,   {db column list component}
  OvcDbISE,  {db incremental search edit component}
  OvcDbIdx;  {db index selection component}


{$I OVCTABS.INC}  {constant declarations for Delphi palette tab names}

type
  {component editor for the table}
  TOvcDbTableEditor = class(TDefaultEditor)
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
  DbTableVerbs : array[0..2] of PAnsiChar =
    ('Columns Editor', WebText, MailText);

procedure TOvcDbTableEditor.ExecuteVerb(Index : Integer);
var
  Table : TOvcDbTable;
  C     : TfrmDbColEditor;
begin
  Table := TOvcDbTable(Component);
  if Index = 0 then begin
    C := TfrmDbColEditor.Create(Application);
    try
      C.Editor := Self;
      C.SetCols(TOvcTableColumns(Table.Columns));
      C.ShowModal;
      Designer.Modified;
    finally
      C.Free;
    end;
  end else if Index = 1 then
    ShellWebCall
  else if Index = 2 then
    ShellMailCall;
end;

function TOvcDbTableEditor.GetVerb(Index : Integer) : AnsiString;
begin
  Result := StrPas(DbTableVerbs[Index]);
end;

function TOvcDbTableEditor.GetVerbCount : Integer;
begin
  Result := High(DbTableVerbs) + 1;
end;


{*** component registration ***}

procedure Register;
begin
  {register property editors for the data aware entry fields}
  RegisterPropertyEditor(
    TypeInfo(Char), TOvcDbSimpleField, 'PictureMask',
    TSimpleMaskProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcDbPictureField, 'PictureMask',
    TPictureMaskProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcDbNumericField, 'PictureMask',
    TNumericMaskProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcDbSimpleArrayEditor, 'PictureMask',
    OvcDbAe1.TDbAeSimpleMaskProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcDbPictureArrayEditor, 'PictureMask',
    TDbAePictureMaskProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcDbNumericArrayEditor, 'PictureMask',
    TDbAeNumericMaskProperty);

  RegisterPropertyEditor(
    TypeInfo(string), TOvcDbSimpleField, 'RangeHi',
    OvcEfPe.TEfRangeProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcDbSimpleField, 'RangeLo',
    OvcEfPe.TEfRangeProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcDbPictureField, 'RangeHi',
    OvcEfPe.TEfRangeProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcDbPictureField, 'RangeLo',
    OvcEfPe.TEfRangeProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcDbNumericField, 'RangeHi',
    OvcEfPe.TEfRangeProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcDbNumericField, 'RangeLo',
    OvcEfPe.TEfRangeProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcDbSimpleArrayEditor, 'RangeHi',
    OvcDbAE0.TDbAeRangeProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcDbSimpleArrayEditor, 'RangeLo',
    OvcDbAE0.TDbAeRangeProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcDbPictureArrayEditor, 'RangeHi',
    OvcDbAE0.TDbAeRangeProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcDbPictureArrayEditor, 'RangeLo',
    OvcDbAE0.TDbAeRangeProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcDbNumericArrayEditor, 'RangeHi',
    OvcDbAE0.TDbAeRangeProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcDbNumericArrayEditor, 'RangeLo',
    OvcDbAE0.TDbAeRangeProperty);
  RegisterPropertyEditor(
    TypeInfo(TOvcTableColumns), TOvcDbTable, '', TOvcDbTableColumnProperty);

  {register component editor for the table}
  RegisterComponentEditor(TOvcDbTable, TOvcDbTableEditor);

  {register component editors for the turbopower web}
  RegisterComponentEditor(TOvcDbSearchEdit, TOvcWebEditor);
  RegisterComponentEditor(TOvcDbIndexSelect, TOvcWebEditor);

  {!!.13}
  {register property editor for version property}
  RegisterPropertyEditor(
    TypeInfo(string), TOvcDbIndexSelect, 'Version', TOvcVersionProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcDbSearchEdit, 'Version', TOvcVersionProperty);

  {register DB components}
  RegisterComponents(OrpheusDataAwareTabName,
    [
     TOvcDbSimpleField,
     TOvcDbPictureField,
     TOvcDbNumericField,
     TOvcDbSimpleArrayEditor,
     TOvcDbPictureArrayEditor,
     TOvcDbNumericArrayEditor,
     TOvcDbTable,
     TOvcDbEditor,
     TOvcDbColumnList,
     TOvcDbSearchEdit,
     TOvcDbIndexSelect,
     TOvcDbCalendar,
     TOvcDbPictureLabel,
     TOvcDbDisplayLabel
    ]);
end;

end.