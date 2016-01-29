unit DictEntry_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/DictEntry_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::DictEntry
//
// Словарная статья
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега DictEntry - "Словарная статья".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idDictEntry = 49;

function k2_typDictEntry_ShortName: DictEntry_ShortName_Tag;

function k2_attrShortName: Integer;
function k2_typDictEntry: DictEntryTag;

//#UC START# *4857CB7D0340const_intf*
//#UC END# *4857CB7D0340const_intf*

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_DictEntry : DictEntryTag = nil;

// start class DictEntryTag

function k2_typDictEntry: DictEntryTag;
begin
 if (g_DictEntry = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_DictEntry := TevNativeSchema(Tk2TypeTable.GetInstance).t_DictEntry;
 end;//g_DictEntry = nil
 Result := g_DictEntry;
end;
var
 g_k2_attrShortName: Integer = -1;

function k2_attrShortName: Integer;
begin
 if (g_k2_attrShortName = -1) then
  g_k2_attrShortName :=  Tk2Attributes.Instance.CheckIDByName('ShortName');
 Result := g_k2_attrShortName;
end;


var
 g_DictEntry_ShortName : DictEntry_ShortName_Tag = nil;

// start class ShortName

function k2_typDictEntry_ShortName: DictEntry_ShortName_Tag;
begin
 if (g_DictEntry_ShortName = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_DictEntry_ShortName := TevNativeSchema(Tk2TypeTable.GetInstance).t_DictEntry_ShortName;
 end;//g_DictEntry = nil
 Result := g_DictEntry_ShortName;
end;


end.