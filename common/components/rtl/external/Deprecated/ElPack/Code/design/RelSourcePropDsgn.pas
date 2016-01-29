{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{   Copyright (c) 2002, Elizabeth Krivonos,          }
{                       Alexander Hramov             }
{                                                    }
{====================================================}
{$include elpack2.inc}
{$ifdef ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$else}
{$ifdef LINUX}
{$I ../ElPack.inc}
{$else}
{$I ..\ElPack.inc}
{$endif}
{$endif}

(*

Version History

*)

unit RelSourcePropDsgn;

interface

uses
{$ifndef CLX_USED}
  Windows,
  Messages,
  Graphics,
  Controls,
  DBCtrls,
  Dialogs,
{$else}
  QGraphics,
  QControls,
  QDialogs,
{$endif}
  SysUtils,
  Classes,
  Db,
  TypInfo,
  {$ifdef VCL_6_USED}
  DesignEditors,
  DesignConst,
  DesignIntf,
  {$else}
  DsgnIntf,
  {$endif}
  ElDBConst,
  ElDBTree;


type
// TElFieldProperty

  TElDataFieldProperty = class(TStringProperty)
    function GetAttributes : TPropertyAttributes; override;
    procedure GetValues( Proc : TGetStrProc ) ; override;
    procedure SetValue(const Value: string); override;
  end;

{$IFDEF RUCOMMENTS}
// редакторы св-в  для RelationItem
{$ENDIF}

  TElMasterFieldProperty = class(TStringProperty)
    function GetAttributes : TPropertyAttributes; override;
    procedure GetValues( Proc : TGetStrProc ) ; override;
    procedure SetValue(const Value: string); override;
    function GetValue: string; override;
  end;

  TElDetailFieldProperty = class(TStringProperty)
    function GetAttributes : TPropertyAttributes; override;
    procedure GetValues( Proc : TGetStrProc ) ; override;
    procedure SetValue(const Value: string); override;
  end;

  TElDetailDisplayFieldProperty = class(TStringProperty)
    function GetAttributes : TPropertyAttributes; override;
    procedure GetValues( Proc : TGetStrProc ) ; override;
    procedure SetValue(const Value: string); override;
  end;



implementation

{$IFDEF RUCOMMENTS}
// редакторы св-в для RelationItem
{$ENDIF}

function TElMasterFieldProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paValueList];
end;

procedure TElMasterFieldProperty.GetValues( Proc : TGetStrProc ) ;
var i : integer;
begin
  if (TElRelationsItem(GetComponent(0)).MasterDataSet<>nil) then
    for i := 0 to TElRelationsItem(GetComponent(0)).MasterDataSet.FieldCount-1 do
      begin
        Proc(TElRelationsItem(GetComponent(0)).MasterDataSet.Fields[i].FieldName);
      end;
end;

function TElMasterFieldProperty.GetValue: string;
begin
  Result := GetStrValue;
end;

{$IFDEF RUCOMMENTS}
// следим за корректными связками MasterField-DetailField при несовпадении типа
// предупреждаем пользователя о возможных проблемах.
//   карательные меры не применяем т.к. при построении будем пытаться привести их к одному типу
{$ENDIF}
procedure TElMasterFieldProperty.SetValue(const Value: string);
var m,d : TFieldType;
begin
  if (TElRelationsItem(GetComponent(0)).DetailDataSet<>nil)  and (TElRelationsItem(GetComponent(0)).DetailField<>'') then
    begin
      m := TElRelationsItem(GetComponent(0)).MasterDataSet.FieldByName(Value).DataType;
      d := TElRelationsItem(GetComponent(0)).DetailDataSet.FieldByName(TElRelationsItem(GetComponent(0)).DetailField).DataType;
      if m <> d then ShowMessage(SMasterDetailIncompatible);
    end;
  inherited SetValue(value);
//  (TElRelationsItem(GetComponent(0)).Collection as TElRelations).ElRelDataSource.NotifyLinks(elSetModify,0);
end;

function TElDetailFieldProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paValueList];
end;

procedure TElDetailFieldProperty.GetValues( Proc : TGetStrProc ) ;
var i : integer;
begin
  if TElRelationsItem(GetComponent(0)).DetailDataSet<>nil then
    for i := 0 to TElRelationsItem(GetComponent(0)).DetailDataSet.FieldCount-1 do
      begin
        Proc(TElRelationsItem(GetComponent(0)).DetailDataSet.Fields[i].FieldName);
      end;
end;

{$IFDEF RUCOMMENTS}
// следим за корректными связками MasterField-DetailField при несовпадении типа
// предупреждаем пользователя о возможных проблемах.
//   карательные меры не применяем т.к. при построении будем пытаться привести их к одному типу
{$ENDIF}
procedure TElDetailFieldProperty.SetValue(const Value: string);
var m,d : TFieldType;
begin
  if (TElRelationsItem(GetComponent(0)).MasterDataSet<>nil)  and (TElRelationsItem(GetComponent(0)).MasterField<>'') then
    begin
      m := TElRelationsItem(GetComponent(0)).MasterDataSet.FieldByName(TElRelationsItem(GetComponent(0)).MasterField).DataType;
      d := TElRelationsItem(GetComponent(0)).DetailDataSet.FieldByName(Value).DataType;
      if m <> d then ShowMessage(SMasterDetailIncompatible);
    end;
  inherited SetValue(value);
//  (TElRelationsItem(GetComponent(0)).Collection as TElRelations).ElRelDataSource.NotifyLinks(elSetModify,0);
end;

function TElDetailDisplayFieldProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paValueList];
end;

procedure TElDetailDisplayFieldProperty.SetValue(const Value: string) ;
begin
  inherited SetValue(value);
//  (TElRelationsItem(GetComponent(0)).Collection as TElRelations).ElRelDataSource.NotifyLinks(elSetModify,0);
end;

procedure TElDetailDisplayFieldProperty.GetValues( Proc : TGetStrProc ) ;
var i : integer;
begin
  if TElRelationsItem(GetComponent(0)).DetailDataSet<>nil then
    for i := 0 to TElRelationsItem(GetComponent(0)).DetailDataSet.FieldCount-1 do
      begin
        Proc(TElRelationsItem(GetComponent(0)).DetailDataSet.Fields[i].FieldName);
      end;
end;
// TElDataFieldProperty

function TElDataFieldProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paValueList];
end;

procedure TElDataFieldProperty.GetValues( Proc : TGetStrProc ) ;
var i : integer;
begin
  if TElRelDataSource(GetComponent(0)).DataSet<>nil then
    for i := 0 to TElRelDataSource(GetComponent(0)).DataSet.FieldCount-1 do
      begin
        Proc(TElRelDataSource(GetComponent(0)).DataSet.Fields[i].FieldName);
      end;
end;

procedure TElDataFieldProperty.SetValue(const Value: string);
begin
  inherited SetValue(Value);
//  TElRelDataSource(GetComponent(0)).NotifyLinks(elSetModify,0);
end;

end.
