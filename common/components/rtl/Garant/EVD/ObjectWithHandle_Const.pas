unit ObjectWithHandle_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/ObjectWithHandle_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdNative::ObjectWithHandle
//
// Объект с идентификатором
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега ObjectWithHandle - "Объект с идентификатором".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

function k2_attrHandle: Integer;

function k2_typObjectWithHandle: ObjectWithHandleTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_ObjectWithHandle : ObjectWithHandleTag = nil;

// start class ObjectWithHandleTag

function k2_typObjectWithHandle: ObjectWithHandleTag;
begin
 if (g_ObjectWithHandle = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_ObjectWithHandle := TevdNativeSchema(Tk2TypeTable.GetInstance).t_ObjectWithHandle;
 end;//g_ObjectWithHandle = nil
 Result := g_ObjectWithHandle;
end;
var
 g_k2_attrHandle: Integer = -1;

function k2_attrHandle: Integer;
begin
 if (g_k2_attrHandle = -1) then
  g_k2_attrHandle :=  Tk2Attributes.Instance.CheckIDByName('Handle');
 Result := g_k2_attrHandle;
end;


end.