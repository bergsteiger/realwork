{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcDBTreeReg;

interface
{$I dc.inc}
{$I dcDBTree.inc}
uses
  Classes, dbgrids, db {$IFDEF USEBDE},dbtables{$ENDIF}
  ,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  dcconsts, dcsystem, dcdbtree, dcGen, dcGenReg;

{$IFDEF WITHPARAMS}
type
  TDCParamEdit = class(TClassProperty)
  public
    function  GetValue : string; override;
    function  GetAttributes : TPropertyAttributes; override;
    procedure Edit; override;
  end;

  TParamPropName= class(TCollPropName)
  public
    function Component : TPersistent; override;
    function GetClass:TClass;override;
  end;
{$ENDIF}

procedure Register;

implementation

uses
  dctreeed;

type
  TDSFieldProperty = class(TStringProperty)
  public
    function GetDatasource: TDataSource; virtual;
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure GetValueList(List: TStrings);virtual;
  end;

  TDBTreeFieldProperty = class(TDSFieldProperty)
  public
    function GetDatasource:TDataSource; override;
  end;

  TDBListFieldProperty = class(TDSFieldProperty)
  public
    function GetDatasource:TDataSource; override;
  end;

  TDBGridColumnProperty = class(TDSFieldProperty)
  public
    function GetDatasource:TDataSource; override;
  end;


  TDSIntFieldProperty = class(TDSFieldProperty)
    procedure GetValueList(List: TStrings);override;
  end;

  TDBTreeIntFieldProperty = class(TDSIntFieldProperty)
  public
    function GetDatasource:TDataSource; override;
  end;

  TDBListIntFieldProperty = class(TDSIntFieldProperty)
  public
    function GetDatasource:TDataSource; override;
  end;

  TDCGrid= class(TCustomDbGrid);


{$IFDEF WITHPARAMS}

{---------TDCParamEdit-------------------------------------------------}

function  TDCParamEdit.GetValue : string;
begin
  result := '(TParams)'; //don't resource
end;
{------------------------------------------------------------------}

function  TDCParamEdit.GetAttributes : TPropertyAttributes;
begin
  result := [paReadOnly,paDialog];
end;
{------------------------------------------------------------------}

procedure TDCParamEdit.Edit;
var
  Source:TDCParamSource;
  AExists:boolean;
  F:TTreeEditForm;
begin
  F:= GetTreeForm(GetComponent(0),'Params',Aexists);  //don't resource
  if not AExists then
  begin
    Source:=TDCParamSource.Create(F);
    Source.Link:=TComponent(GetComponent(0));
    Source.PropName:='Params'; //don't resource
    SetSource(F,Source);
  end
  else
    F.Show;
end;

{---------TParamPropName---------------------------------------------------}

function TParamPropName.Component : TPersistent;
begin
  result:= TDCParamSource(GetComponent(0)).Link;
end;

{------------------------------------------------------------------}

function TParamPropName.GetClass:TClass;
begin
  result:=TParams;
end;

{$ENDIF}

{---------------TFieldProperty.-----------------------------------}

function TDsFieldProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

{------------------------------------------------------------------}

procedure TDsFieldProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

{------------------------------------------------------------------}

procedure TDsFieldProperty.GetValueList(List: TStrings);
var
  Ds : TDataSource ;
begin
  Ds := GetDataSource;
  if (Ds <> nil) and (Ds.DataSet <> nil) then
      Ds.DataSet.GetFieldNames(List);
end;

{------------------------------------------------------------------}

function TDsFieldProperty.GetDatasource:TDataSource;
begin
  result := TDCDataSetSource(GetComponent(0)).DataSource;
end;

{------------------------------------------------------------------}

procedure TDSIntFieldProperty.GetValueList(List: TStrings);
var
  Ds : TDataSource ;
  i:integer;
begin
  Ds := GetDataSource;
  if (Ds <> nil) and (Ds.DataSet <> nil) then
    with Ds.DataSet.FieldDefs do
    begin
      Update;
      for i:= 0 to Count -1 do
        if  Items[i].FieldClass.InheritsFrom(TIntegerField) then
          List.Add(Items[i].Name);
    end;

end;

{------------------------------------------------------------------}

function TDBTreeFieldProperty.GetDatasource:TDataSource;
begin
  result := TDCDBTreeView(GetComponent(0)).DataSource;
end;

{------------------------------------------------------------------}

function TDBListFieldProperty.GetDatasource:TDataSource;
begin
  result := TDCDBListView(GetComponent(0)).DataSource;
end;

{------------------------------------------------------------------}

type
  TMColumn = class(TColumn);

function TDBGridColumnProperty.GetDatasource:TDataSource;
begin
  result := TDCGrid(TMColumn(GetComponent(0)).GetGrid).DataSource;
end;

{------------------------------------------------------------------}

function TDBTreeIntFieldProperty.GetDatasource:TDataSource;
begin
  result := TDCDBTreeView(GetComponent(0)).DataSource;
end;

{------------------------------------------------------------------}

function TDBListIntFieldProperty.GetDatasource:TDataSource;
begin
  result := TDCDBListView(GetComponent(0)).DataSource;
end;

{------------------------------------------------------------------}

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(string),TDCDataSetSource,'DisplayField',TDsFieldProperty);
  RegisterPropertyEditor(TypeInfo(string),TDCDataSetSource,'RootIndexField',TDSIntFieldProperty);
  RegisterPropertyEditor(TypeInfo(string),TDCDataSetSource,'ObjectIndexField',TDSIntFieldProperty);
  RegisterPropertyEditor(TypeInfo(string),TDCDataSetSource,'ImageIndexField',TDSIntFieldProperty);
  RegisterPropertyEditor(TypeInfo(string),TDCDataSetSource,'SelectedIndexField',TDSIntFieldProperty);
  RegisterPropertyEditor(TypeInfo(string),TDCDataSetSource,'StateIndexField',TDSIntFieldProperty);

  RegisterPropertyEditor(TypeInfo(string),TDCDBTreeView,'DisplayField',TDBTreeFieldProperty);
  RegisterPropertyEditor(TypeInfo(string),TDCDBTreeView,'RootIndexField',TDBTreeIntFieldProperty);
  RegisterPropertyEditor(TypeInfo(string),TDCDBTreeView,'ObjectIndexField',TDBTreeIntFieldProperty);
  RegisterPropertyEditor(TypeInfo(string),TDCDBTreeView,'ImageIndexField',TDBTreeIntFieldProperty);
  RegisterPropertyEditor(TypeInfo(string),TDCDBTreeView,'SelectedIndexField',TDBTreeIntFieldProperty);
  RegisterPropertyEditor(TypeInfo(string),TDCDBTreeView,'StateIndexField',TDBTreeIntFieldProperty);

  RegisterPropertyEditor(TypeInfo(string),TDCDBListView,'DisplayField',TDBListFieldProperty);
  RegisterPropertyEditor(TypeInfo(string),TDCDBListView,'RootIndexField',TDBListIntFieldProperty);
  RegisterPropertyEditor(TypeInfo(string),TDCDBListView,'ObjectIndexField',TDBListIntFieldProperty);
  RegisterPropertyEditor(TypeInfo(string),TDCDBListView,'ImageIndexField',TDBListIntFieldProperty);
  RegisterPropertyEditor(TypeInfo(string),TDCDBListView,'SelectedIndexField',TDBListIntFieldProperty);
  RegisterPropertyEditor(TypeInfo(string),TDCDBListView,'StateIndexField',TDBListIntFieldProperty);

  {$IFDEF WITHPARAMS}
  RegisterPropertyEditor(TypeInfo(string),TDCParamSource,'PropName',TParamPropName);
  RegisterPropertyEditor(TypeInfo(TPersistent),TDCParamSource,'',TComponentProperty);
  {$ENDIF}

  RegisterComponents(SPalDreamTree,[
  {$IFDEF WITHPARAMS}
    TDCParamSource,
  {$ENDIF}
    TDCFieldSource,TDCGridSource,TDCDataSetSource
  ]);

  RegisterComponents(SPalDreamTree,[TDCDBTreeView,TDCDBListView]);
end;

{------------------------------------------------------------------}
//BeginSkipConst
procedure _Register;
begin
  RegisterDefaultTreeSource(TDataset,TDCFieldSource,'Fields');
 {$IFNDEF D3}
//  RegisterPropertyEditor(TypeInfo(TDbGridColumns),nil,'',TDBGridCollEdit);
 {$ENDIF}
end;

{------------------------------------------------------------------}

procedure _InstantRegister;
begin
  RegisterComponentAction(SAddFields,TDCFieldSource,AddFields);
  RegisterComponentAction(SAddAllColumns,TDCGridSource,AddAllColumns);
  RegisterComponentAction(SLoadDefValues,TDCGridSource,RestoreDefault);
  RegisterComponentAction(SFieldEditor,TDataset,EditFields);
//  RegisterPropertyEditor(TypeInfo(TDbGridColumns),nil,'',TDBGridCollEdit);
  RegisterPropertyEditor(TypeInfo(string),TColumn,'FieldName',TDBGridColumnProperty); //don't resource
  RegisterDefaultTreeSource(TCustomDBGrid,TDCGridSource,'Columns');
  {$IFDEF USEBDE}
  RegisterTreeSource(TQuery,TDCParamSource,'Params');
  RegisterTreeSource(TStoredProc,TDCParamSource,'Params');

  RegisterVisualProperty(SParamEditor,TQuery,'Params');
  RegisterVisualProperty(SVerbSQLEditor,TQuery,'SQL');
  RegisterVisualProperty(SParamEditor,TStoredProc,'Params');
  {$ENDIF}

  {$IFDEF WITHPARAMS}
  RegisterPropertyEditor(TypeInfo(TParams),nil,'',TDCParamEdit);
  {$ENDIF}
end;

//EndSkipConst

procedure RunRegister;
begin
  RegisterForDelphi(_Register);
  RegisterForInstant(_InstantRegister);
end;

initialization
  RunRegister;
end.
