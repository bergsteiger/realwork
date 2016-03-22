unit Check_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/Check_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdNative::Check
//
// Вычитка
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Check - "Вычитка".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

const
 k2_idCheck = 81;

function k2_attrHandle: Integer;

function k2_attrSource: Integer;

function k2_attrComment: Integer;

function k2_typCheck: CheckTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Check : CheckTag = nil;

// start class CheckTag

function k2_typCheck: CheckTag;
begin
 if (g_Check = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_Check := TevdNativeSchema(Tk2TypeTable.GetInstance).t_Check;
 end;//g_Check = nil
 Result := g_Check;
end;
var
 g_k2_attrHandle: Integer = -1;

function k2_attrHandle: Integer;
begin
 if (g_k2_attrHandle = -1) then
  g_k2_attrHandle :=  Tk2Attributes.Instance.CheckIDByName('Handle');
 Result := g_k2_attrHandle;
end;

var
 g_k2_attrSource: Integer = -1;

function k2_attrSource: Integer;
begin
 if (g_k2_attrSource = -1) then
  g_k2_attrSource :=  Tk2Attributes.Instance.CheckIDByName('Source');
 Result := g_k2_attrSource;
end;

var
 g_k2_attrComment: Integer = -1;

function k2_attrComment: Integer;
begin
 if (g_k2_attrComment = -1) then
  g_k2_attrComment :=  Tk2Attributes.Instance.CheckIDByName('Comment');
 Result := g_k2_attrComment;
end;


end.