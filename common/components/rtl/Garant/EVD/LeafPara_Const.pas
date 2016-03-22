unit LeafPara_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/LeafPara_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdNative::LeafPara
//
// "Листьевой" параграф
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега LeafPara - ""Листьевой" параграф".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

function k2_attrContentsLevel: Integer;

function k2_typLeafPara: LeafParaTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_LeafPara : LeafParaTag = nil;

// start class LeafParaTag

function k2_typLeafPara: LeafParaTag;
begin
 if (g_LeafPara = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_LeafPara := TevdNativeSchema(Tk2TypeTable.GetInstance).t_LeafPara;
 end;//g_LeafPara = nil
 Result := g_LeafPara;
end;
var
 g_k2_attrContentsLevel: Integer = -1;

function k2_attrContentsLevel: Integer;
begin
 if (g_k2_attrContentsLevel = -1) then
  g_k2_attrContentsLevel :=  Tk2Attributes.Instance.CheckIDByName('ContentsLevel');
 Result := g_k2_attrContentsLevel;
end;


end.