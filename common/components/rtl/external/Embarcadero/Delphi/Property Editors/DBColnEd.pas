{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit DBColnEd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ColnEdit, Menus, ComCtrls, StdCtrls, ExtCtrls, DB, ActnList, ImgList, ToolWin;

type
  TDBGridColumnsEditor = class(TCollectionEditor)
    AddAllFields1: TMenuItem;
    Restoredefaults1: TMenuItem;
    AddAllFieldsCmd: TAction;
    RestoreDefaultsCmd: TAction;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    N1: TMenuItem;
    procedure AddAllFieldsClick(Sender: TObject);
    procedure RestoreDefaultsClick(Sender: TObject);
    procedure AddAllFieldsCmdUpdate(Sender: TObject);
    procedure RestoreDefaultsCmdUpdate(Sender: TObject);
    procedure ListView1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
  protected
    function CanAdd(Index: Integer): Boolean; override;
  public
    function GetDataSource: TDatasource;
  end;

implementation

{$IFDEF LINUX}
uses TypInfo, QDBGrids, DsnDBCst;
{$ENDIF}

{$IFDEF MSWINDOWS}
uses TypInfo, DBGrids, DsnDBCst;
{$ENDIF}

{$R *.dfm}

function TDBGridColumnsEditor.GetDataSource;
var
  PropInfo: PPropInfo;
begin
  Result := nil;
  if Component = nil then Exit;
  PropInfo := TypInfo.GetPropInfo(Component.ClassInfo, 'DataSource');
  if (PropInfo <> nil) and (PropInfo^.PropType^.Kind = tkClass) then
    Result := TObject(GetOrdProp(Component, PropInfo)) as TDataSource;
end;

procedure TDBGridColumnsEditor.AddAllFieldsClick(Sender: TObject);
var
  Result, I: Integer;
  DataSource: TDataSource;
begin
  Result := idYes;
  if (Collection.Count > 0) and
    ((Collection as TDBGridColumns).State = csCustomized) then
    Result := MessageDlg(sDeleteColumnsQuestion, mtConfirmation, mbYesNoCancel, 0);

  LockState;
  try
    case Result of
      idCancel: Exit;
      idYes: (Collection as TDBGridColumns).RebuildColumns;
      idNo:
        begin
          Datasource := GetDataSource;
          if (DataSource <> nil) and (DataSource.DataSet <> nil) then
            with Datasource.Dataset do
            begin
              Collection.BeginUpdate;
              try
                for I := 0 to FieldList.Count-1 do
                  (Collection as TDBGridColumns).Add.FieldName := FieldList[I].FullName;
              finally
                Collection.EndUpdate;
              end;
            end;
        end;
    end;
  finally
    UnlockState;
    UpdateListbox;
    SetSelection;
    Designer.Modified;
  end;
end;

procedure TDBGridColumnsEditor.RestoreDefaultsClick(Sender: TObject);
var
  I: Integer;
begin
  Collection.BeginUpdate;
  try
    for I := 0 to Collection.Count-1 do
      if ListView1.Items[I].Selected then
        (Collection as TDBGridColumns)[I].RestoreDefaults;
  finally
    Collection.EndUpdate;
    UpdateListbox;
    Designer.Modified;
  end;
end;

procedure TDBGridColumnsEditor.AddAllFieldsCmdUpdate(Sender: TObject);
var
  Datasource: TDataSource;
begin
  inherited;
  DataSource := GetDataSource;
  AddAllFieldsCmd.Enabled := (Datasource <> nil) and (Datasource.Dataset <> nil)
    and (Datasource.Dataset.FieldCount > 0);
end;

procedure TDBGridColumnsEditor.RestoreDefaultsCmdUpdate(Sender: TObject);
begin
  inherited;
  RestoreDefaultsCmd.Enabled := (Collection <> nil) and
    ((Collection as TDBGridColumns).State = csCustomized);
end;

function TDBGridColumnsEditor.CanAdd(Index: Integer): Boolean;
begin
  Result := (Collection <> nil) and ((Collection as TDBGridColumns).State = csCustomized);
end;

procedure TDBGridColumnsEditor.ListView1DragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  Item: TListItem;
  Col: TColumn;
  FirstSelected: Boolean;
  ParentField: TField;
  I: Integer;
begin
  inherited;
  if not Accept then Exit;
  // All selected columns must have the same parent field or no field to be dragged
  // as a group
  FirstSelected := True;
  ParentField := nil;
  for I := 0 to Listview1.Items.Count - 1 do
    if Listview1.Items[I].Selected then
    begin
      Col := (Collection as TDBGridColumns)[I];
      if (Col.Field <> nil) then
        if FirstSelected then
        begin
          ParentField := Col.Field.ParentField;
          FirstSelected := False;
        end
        else
          if Col.Field.ParentField <> ParentField then
          begin
            Accept := False;
            Exit;
          end;
    end;
  // Require that the drop target have the same parent field as the source
  Item := Listview1.GetItemAt(X,Y);
  if Item <> nil then
  begin
    Col := (Collection as TDBGridColumns)[Item.Index];
    Accept := (Item <> nil) and
      ((Col.Field = nil) or (Col.Field.ParentField = ParentField));
  end;
end;

end.
