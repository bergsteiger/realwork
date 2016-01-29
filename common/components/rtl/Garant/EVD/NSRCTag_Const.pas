unit NSRCTag_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/NSRCTag_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdNative::NSRCTag
//
// Атрибут точки входа
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега NSRCTag - "Атрибут точки входа".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

function k2_attrName: Integer;

function k2_typNSRCTag: NSRCTagTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_NSRCTag : NSRCTagTag = nil;

// start class NSRCTagTag

function k2_typNSRCTag: NSRCTagTag;
begin
 if (g_NSRCTag = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_NSRCTag := TevdNativeSchema(Tk2TypeTable.GetInstance).t_NSRCTag;
 end;//g_NSRCTag = nil
 Result := g_NSRCTag;
end;
var
 g_k2_attrName: Integer = -1;

function k2_attrName: Integer;
begin
 if (g_k2_attrName = -1) then
  g_k2_attrName :=  Tk2Attributes.Instance.CheckIDByName('Name');
 Result := g_k2_attrName;
end;


end.