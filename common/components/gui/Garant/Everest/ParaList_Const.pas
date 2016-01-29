unit ParaList_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/ParaList_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::ParaList
//
// Список параграфов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега ParaList - "Список параграфов".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

function k2_typParaList_Orientation: ParaList_Orientation_Tag;

function k2_attrOrientation: Integer;

function k2_attrAllChildrenCount: Integer;

function k2_attrFixedWidth: Integer;

function k2_attrLineSpacing: Integer;
function k2_typParaList: ParaListTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_ParaList : ParaListTag = nil;

// start class ParaListTag

function k2_typParaList: ParaListTag;
begin
 if (g_ParaList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_ParaList := TevNativeSchema(Tk2TypeTable.GetInstance).t_ParaList;
 end;//g_ParaList = nil
 Result := g_ParaList;
end;
var
 g_k2_attrOrientation: Integer = -1;

function k2_attrOrientation: Integer;
begin
 if (g_k2_attrOrientation = -1) then
  g_k2_attrOrientation :=  Tk2Attributes.Instance.CheckIDByName('Orientation');
 Result := g_k2_attrOrientation;
end;

var
 g_k2_attrAllChildrenCount: Integer = -1;

function k2_attrAllChildrenCount: Integer;
begin
 if (g_k2_attrAllChildrenCount = -1) then
  g_k2_attrAllChildrenCount :=  Tk2Attributes.Instance.CheckIDByName('AllChildrenCount');
 Result := g_k2_attrAllChildrenCount;
end;

var
 g_k2_attrFixedWidth: Integer = -1;

function k2_attrFixedWidth: Integer;
begin
 if (g_k2_attrFixedWidth = -1) then
  g_k2_attrFixedWidth :=  Tk2Attributes.Instance.CheckIDByName('FixedWidth');
 Result := g_k2_attrFixedWidth;
end;

var
 g_k2_attrLineSpacing: Integer = -1;

function k2_attrLineSpacing: Integer;
begin
 if (g_k2_attrLineSpacing = -1) then
  g_k2_attrLineSpacing :=  Tk2Attributes.Instance.CheckIDByName('LineSpacing');
 Result := g_k2_attrLineSpacing;
end;


var
 g_ParaList_Orientation : ParaList_Orientation_Tag = nil;

// start class Orientation

function k2_typParaList_Orientation: ParaList_Orientation_Tag;
begin
 if (g_ParaList_Orientation = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_ParaList_Orientation := TevNativeSchema(Tk2TypeTable.GetInstance).t_ParaList_Orientation;
 end;//g_ParaList = nil
 Result := g_ParaList_Orientation;
end;


end.