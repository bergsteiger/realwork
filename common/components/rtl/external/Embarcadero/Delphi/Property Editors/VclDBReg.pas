{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit VclDBReg;

interface

procedure Register;

implementation

uses
  Windows, SysUtils, Classes, System.Actions, Controls, Forms, Mask, TypInfo, DsnDBCst, DB,
  DesignIntf, DesignEditors, DBConsts,
  ColnEdit, ActnList, DBActRes, DBColnEd, DBReg,
  DBCtrls, DBGrids, DBCGrids, DBActns, MaskProp, MaskText, 
  FileCtrl, FldLinks, ActiveX, DBOleCtl, DBOleEdt;

{ TDBImageEditor }

type
  TDBImageEditor = class(TDefaultEditor)
  public
    procedure Copy; override;
  end;

procedure TDBImageEditor.Copy;
begin
  TDBImage(Component).CopyToClipboard;
end;

type
  TDBGridColumnsProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

procedure TDBGridColumnsProperty.Edit;
begin
  ShowCollectionEditorClass(Designer, TDBGridColumnsEditor,
    GetComponent(0) as TComponent, TDBGridColumns(GetOrdValue), GetName);
end;

function TDBGridColumnsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly{$IFDEF LINUX}, paVCL{$ENDIF}];
end;


{ TDBGridEditor }
type
  TDBGridEditor = class(TComponentEditor{$IFDEF LINUX}, IDesignerThreadAffinity{$ENDIF})
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
{$IFDEF LINUX} 
  {IDesignerThreadAffinity}
  function GetThreadAffinity: TThreadAffinity;
{$ENDIF}
  end;

procedure TDBGridEditor.ExecuteVerb(Index: Integer);
begin
  ShowCollectionEditorClass(Designer, TDBGridColumnsEditor, Component,
    (Component as TDBGrid).Columns, 'Columns');
end;

function TDBGridEditor.GetVerb(Index: Integer): string;
begin
  Result := SDBGridColEditor;
end;

function TDBGridEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{$IFDEF LINUX} 
function TDBGridEditor.GetThreadAffinity: TThreadAffinity;
begin
  Result := taWine;
end;
{$ENDIF}

{ TColumnDataFieldEditor }

type
  TColumnDataFieldProperty = class(TDBStringProperty)
    procedure GetValueList(List: TStrings); override;
  end;

procedure TColumnDataFieldProperty.GetValueList(List: TStrings);
var
  Grid: TCustomDBGrid;
  DataSource: TDataSource;
begin
  Grid := (GetComponent(0) as DBGrids.TColumn).Grid;
  if (Grid = nil) then Exit;
  DataSource := GetObjectProp(Grid, 'DataSource') as TDataSource;
  if (DataSource <> nil) and (DataSource.DataSet <> nil) then
    DataSource.DataSet.GetFieldNames(List);
end;

{ Registration }

resourcestring
  sDataset = 'Dataset';

procedure Register;
begin
  RegisterComponents(srDControls, [TDBGrid, TDBNavigator, TDBText,
    TDBEdit, TDBMemo, TDBImage, TDBListBox, TDBComboBox, TDBCheckBox,
    TDBRadioGroup, TDBLookupListBox, TDBLookupComboBox,
    TDBRichEdit]);
  RegisterComponents(srDControls, [TDBCtrlGrid]);
  RegisterNonActiveX([TDataSource, TCustomDBGrid, TDBNavigator, TDBText,
    TDBEdit, TDBMemo, TDBImage, TDBListBox, TDBComboBox, TDBCheckBox,
    TDBRadioGroup, TDBLookupListBox, TDBLookupComboBox, TDBRichEdit,
    TDBLookupControl], axrIncludeDescendants);
  RegisterNonActiveX([TDBCtrlGrid], axrIncludeDescendants);
  RegisterPropertyEditor(TypeInfo(TDBGridColumns), TCustomDBGrid, '', TDBGridColumnsProperty);
  RegisterPropertyEditor(TypeInfo(string), TDBText, 'DataField', TDataFieldAggProperty);
  RegisterPropertyEditor(TypeInfo(string), TDBEdit, 'DataField', TDataFieldAggProperty);
  RegisterPropertyEditor(TypeInfo(string), TDBLookupControl, 'KeyField', TListFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TDBLookupControl, 'ListField', TListFieldProperty);
  RegisterPropertyEditor(TypeInfo(TDataBindings), TDBOleControl, 'DataBindings', TDataBindProperty);
  RegisterPropertyEditor(TypeInfo(string), TField, 'EditMask', TMaskProperty);
  RegisterPropertyEditor(TypeInfo(string), TColumn, 'FieldName', TColumnDataFieldProperty);

  RegisterComponentEditor(TDBOleControl, TDataBindEditor);
  RegisterComponentEditor(TDBImage, TDBImageEditor);
  RegisterComponentEditor(TDBGrid, TDBGridEditor);

  { DataSet action registration }
  RegisterActions(sDataset, [TDataSetFirst, TDataSetPrior, TDataSetNext,
    TDataSetLast, TDataSetInsert, TDataSetDelete, TDataSetEdit, TDataSetPost,
    TDataSetCancel, TDataSetRefresh], TStandardDatasetActions);

  { Property Category registration }
  RegisterPropertiesInCategory(sDatabaseCategoryName,
    ['SQL*', 'Filter*', 'OnFilter*', 'RequestLive',
     TypeInfo(TDataSet), TypeInfo(TDataSource),
     TypeInfo(TParams), TypeInfo(TDBGridColumns),
     TypeInfo(TCheckConstraints), TypeInfo(TDataBindings)]);
  RegisterPropertyInCategory(sDatabaseCategoryName, TColumn, 'FieldName');
  RegisterPropertiesInCategory(sDatabaseCategoryName, TWinControl,
    ['LookupField', 'LookupDisplay']);
  RegisterPropertiesInCategory(sDatabaseCategoryName, TDBLookupControl,
    ['*Field', '*FieldIndex']);

  { Localizable properties }
  RegisterPropertiesInCategory(sLocalizableCategoryName, TField,
    ['DisplayFormat', 'DisplayLabel', 'DisplayValues', 'EditFormat', 'ConstraintErrorMessage']); { Do not localize }
  RegisterPropertiesInCategory(sLocalizableCategoryName, TDBRadioGroup, ['Columns']);  { Do not localize }
  RegisterPropertiesInCategory(sLocalizableCategoryName, TDBCheckBox, ['ValueChecked', 'ValueUnchecked']); { Do not localize }
  RegisterPropertiesInCategory(sLocalizableCategoryName, TColumn, ['Picklist']); { Do not localize }
  RegisterPropertiesInCategory(sLocalizableCategoryName, { by TypeInfo }
    [TypeInfo(TCheckConstraints),
     TypeInfo(TColumnTitle)]);
end;

end.
