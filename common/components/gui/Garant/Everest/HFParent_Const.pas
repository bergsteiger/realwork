unit HFParent_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/HFParent_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::HFParent
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега HFParent .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

function k2_typHFParent_Type: HFParent_Type_Tag;

function k2_attrType: Integer;
function k2_typHFParent: HFParentTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_HFParent : HFParentTag = nil;

// start class HFParentTag

function k2_typHFParent: HFParentTag;
begin
 if (g_HFParent = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_HFParent := TevNativeSchema(Tk2TypeTable.GetInstance).t_HFParent;
 end;//g_HFParent = nil
 Result := g_HFParent;
end;
var
 g_k2_attrType: Integer = -1;

function k2_attrType: Integer;
begin
 if (g_k2_attrType = -1) then
  g_k2_attrType :=  Tk2Attributes.Instance.CheckIDByName('Type');
 Result := g_k2_attrType;
end;


var
 g_HFParent_Type : HFParent_Type_Tag = nil;

// start class Type

function k2_typHFParent_Type: HFParent_Type_Tag;
begin
 if (g_HFParent_Type = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_HFParent_Type := TevNativeSchema(Tk2TypeTable.GetInstance).t_HFParent_Type;
 end;//g_HFParent = nil
 Result := g_HFParent_Type;
end;


end.