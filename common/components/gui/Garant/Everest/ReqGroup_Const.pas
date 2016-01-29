unit ReqGroup_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/ReqGroup_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::ReqGroup
//
// Группа реквизитов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега ReqGroup - "Группа реквизитов".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idReqGroup = 55;

function k2_attrChecked: Integer;

function k2_typReqGroup: ReqGroupTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_ReqGroup : ReqGroupTag = nil;

// start class ReqGroupTag

function k2_typReqGroup: ReqGroupTag;
begin
 if (g_ReqGroup = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_ReqGroup := TevNativeSchema(Tk2TypeTable.GetInstance).t_ReqGroup;
 end;//g_ReqGroup = nil
 Result := g_ReqGroup;
end;
var
 g_k2_attrChecked: Integer = -1;

function k2_attrChecked: Integer;
begin
 if (g_k2_attrChecked = -1) then
  g_k2_attrChecked :=  Tk2Attributes.Instance.CheckIDByName('Checked');
 Result := g_k2_attrChecked;
end;


end.