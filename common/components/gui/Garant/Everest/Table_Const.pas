unit Table_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/Table_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::Table
//
// Таблица
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Table - "Таблица".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idTable = 24;

function k2_attrOldNSRC: Integer;

function k2_attrZoom: Integer;

function k2_attrStyle: Integer;

function k2_typTable: TableTag;

//#UC START# *4857D48E00F4const_intf*
//#UC END# *4857D48E00F4const_intf*

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Table : TableTag = nil;

// start class TableTag

function k2_typTable: TableTag;
begin
 if (g_Table = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Table := TevNativeSchema(Tk2TypeTable.GetInstance).t_Table;
 end;//g_Table = nil
 Result := g_Table;
end;
var
 g_k2_attrOldNSRC: Integer = -1;

function k2_attrOldNSRC: Integer;
begin
 if (g_k2_attrOldNSRC = -1) then
  g_k2_attrOldNSRC :=  Tk2Attributes.Instance.CheckIDByName('OldNSRC');
 Result := g_k2_attrOldNSRC;
end;

var
 g_k2_attrZoom: Integer = -1;

function k2_attrZoom: Integer;
begin
 if (g_k2_attrZoom = -1) then
  g_k2_attrZoom :=  Tk2Attributes.Instance.CheckIDByName('Zoom');
 Result := g_k2_attrZoom;
end;

var
 g_k2_attrStyle: Integer = -1;

function k2_attrStyle: Integer;
begin
 if (g_k2_attrStyle = -1) then
  g_k2_attrStyle :=  Tk2Attributes.Instance.CheckIDByName('Style');
 Result := g_k2_attrStyle;
end;


end.