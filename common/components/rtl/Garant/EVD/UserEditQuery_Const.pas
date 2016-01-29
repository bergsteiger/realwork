unit UserEditQuery_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/UserEditQuery_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::UserEditQuery
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега UserEditQuery .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrID: Integer;

function k2_attrIsGroup: Integer;

function k2_typUserEditQuery: UserEditQueryTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_UserEditQuery : UserEditQueryTag = nil;

// start class UserEditQueryTag

function k2_typUserEditQuery: UserEditQueryTag;
begin
 if (g_UserEditQuery = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_UserEditQuery := TevdTasksSchema(Tk2TypeTable.GetInstance).t_UserEditQuery;
 end;//g_UserEditQuery = nil
 Result := g_UserEditQuery;
end;
var
 g_k2_attrID: Integer = -1;

function k2_attrID: Integer;
begin
 if (g_k2_attrID = -1) then
  g_k2_attrID :=  Tk2Attributes.Instance.CheckIDByName('ID');
 Result := g_k2_attrID;
end;

var
 g_k2_attrIsGroup: Integer = -1;

function k2_attrIsGroup: Integer;
begin
 if (g_k2_attrIsGroup = -1) then
  g_k2_attrIsGroup :=  Tk2Attributes.Instance.CheckIDByName('IsGroup');
 Result := g_k2_attrIsGroup;
end;


end.