unit StagePrim_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/StagePrim_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdNative::StagePrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега StagePrim .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

function k2_attrUser: Integer;

function k2_typStagePrim: StagePrimTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_StagePrim : StagePrimTag = nil;

// start class StagePrimTag

function k2_typStagePrim: StagePrimTag;
begin
 if (g_StagePrim = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_StagePrim := TevdNativeSchema(Tk2TypeTable.GetInstance).t_StagePrim;
 end;//g_StagePrim = nil
 Result := g_StagePrim;
end;
var
 g_k2_attrUser: Integer = -1;

function k2_attrUser: Integer;
begin
 if (g_k2_attrUser = -1) then
  g_k2_attrUser :=  Tk2Attributes.Instance.CheckIDByName('User');
 Result := g_k2_attrUser;
end;


end.