unit k2Int64_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/K2/k2Int64_Const.pas"
// Начат: 17.07.1998 16:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::K2::Standard::k2Native::Int64
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Int64 .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Base {a},
  k2Native_Schema
  ;

function k2_attrDocID: Integer;

function k2_attrSubID: Integer;

function k2_typInt64: Int64Tag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Int64 : Int64Tag = nil;

// start class Int64Tag

function k2_typInt64: Int64Tag;
begin
 if (g_Int64 = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is Tk2NativeSchema);
  g_Int64 := Tk2NativeSchema(Tk2TypeTable.GetInstance).t_Int64;
 end;//g_Int64 = nil
 Result := g_Int64;
end;
var
 g_k2_attrDocID: Integer = -1;

function k2_attrDocID: Integer;
begin
 if (g_k2_attrDocID = -1) then
  g_k2_attrDocID :=  Tk2Attributes.Instance.CheckIDByName('DocID');
 Result := g_k2_attrDocID;
end;

var
 g_k2_attrSubID: Integer = -1;

function k2_attrSubID: Integer;
begin
 if (g_k2_attrSubID = -1) then
  g_k2_attrSubID :=  Tk2Attributes.Instance.CheckIDByName('SubID');
 Result := g_k2_attrSubID;
end;


end.