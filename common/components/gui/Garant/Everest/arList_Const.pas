unit arList_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/arList_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evArchi::List
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега List .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(Archi)}
uses
  k2Base {a},
  evArchi_Schema
  ;
{$IfEnd} //Archi

{$If defined(Archi)}

const
 k2_idList = 16;

function k2_attrObject: Integer;

function k2_typList: ListTag;

{$IfEnd} //Archi

implementation

{$If defined(Archi)}
uses
  k2Facade {a},
  k2Attributes {a}
  ;
{$IfEnd} //Archi

{$If defined(Archi)}

var
 g_List : ListTag = nil;

// start class ListTag

function k2_typList: ListTag;
begin
 if (g_List = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevArchiSchema);
  g_List := TevArchiSchema(Tk2TypeTable.GetInstance).t_List;
 end;//g_List = nil
 Result := g_List;
end;
var
 g_k2_attrObject: Integer = -1;

function k2_attrObject: Integer;
begin
 if (g_k2_attrObject = -1) then
  g_k2_attrObject :=  Tk2Attributes.Instance.CheckIDByName('Object');
 Result := g_k2_attrObject;
end;

{$IfEnd} //Archi


end.