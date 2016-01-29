unit EditablePart_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/EditablePart_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::EditablePart
//
// http://mdp.garant.ru/pages/viewpage.action?pageId=280859697
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега EditablePart - "http://mdp.garant.ru/pages/viewpage.action?pageId=280859697".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idEditablePart = 139;

function k2_attrModified: Integer;

function k2_typEditablePart: EditablePartTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_EditablePart : EditablePartTag = nil;

// start class EditablePartTag

function k2_typEditablePart: EditablePartTag;
begin
 if (g_EditablePart = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_EditablePart := TevNativeSchema(Tk2TypeTable.GetInstance).t_EditablePart;
 end;//g_EditablePart = nil
 Result := g_EditablePart;
end;
var
 g_k2_attrModified: Integer = -1;

function k2_attrModified: Integer;
begin
 if (g_k2_attrModified = -1) then
  g_k2_attrModified :=  Tk2Attributes.Instance.CheckIDByName('Modified');
 Result := g_k2_attrModified;
end;


end.