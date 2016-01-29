unit Cloak_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/Cloak_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::Cloak
//
// Схлопывающаяся группа параграфов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Cloak - "Схлопывающаяся группа параграфов".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idCloak = 47;

function k2_typCloak: CloakTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Cloak : CloakTag = nil;

// start class CloakTag

function k2_typCloak: CloakTag;
begin
 if (g_Cloak = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Cloak := TevNativeSchema(Tk2TypeTable.GetInstance).t_Cloak;
 end;//g_Cloak = nil
 Result := g_Cloak;
end;

end.