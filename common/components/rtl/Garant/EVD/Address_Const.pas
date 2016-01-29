unit Address_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/Address_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::Address
//
// Адрес
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Address - "Адрес".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

const
 k2_idAddress = 77;

function k2_typAddress_ViewKind: Address_ViewKind_Tag;

function k2_attrDocID: Integer;

function k2_attrSubID: Integer;

function k2_attrType: Integer;

function k2_attrRevision: Integer;

function k2_attrViewKind: Integer;

function k2_attrShortName: Integer;

function k2_attrName: Integer;
function k2_typAddress: AddressTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Address : AddressTag = nil;

// start class AddressTag

function k2_typAddress: AddressTag;
begin
 if (g_Address = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_Address := TevdTasksSchema(Tk2TypeTable.GetInstance).t_Address;
 end;//g_Address = nil
 Result := g_Address;
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

var
 g_k2_attrType: Integer = -1;

function k2_attrType: Integer;
begin
 if (g_k2_attrType = -1) then
  g_k2_attrType :=  Tk2Attributes.Instance.CheckIDByName('Type');
 Result := g_k2_attrType;
end;

var
 g_k2_attrRevision: Integer = -1;

function k2_attrRevision: Integer;
begin
 if (g_k2_attrRevision = -1) then
  g_k2_attrRevision :=  Tk2Attributes.Instance.CheckIDByName('Revision');
 Result := g_k2_attrRevision;
end;

var
 g_k2_attrViewKind: Integer = -1;

function k2_attrViewKind: Integer;
begin
 if (g_k2_attrViewKind = -1) then
  g_k2_attrViewKind :=  Tk2Attributes.Instance.CheckIDByName('ViewKind');
 Result := g_k2_attrViewKind;
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
 g_k2_attrName: Integer = -1;

function k2_attrName: Integer;
begin
 if (g_k2_attrName = -1) then
  g_k2_attrName :=  Tk2Attributes.Instance.CheckIDByName('Name');
 Result := g_k2_attrName;
end;


var
 g_Address_ViewKind : Address_ViewKind_Tag = nil;

// start class ViewKind

function k2_typAddress_ViewKind: Address_ViewKind_Tag;
begin
 if (g_Address_ViewKind = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_Address_ViewKind := TevdTasksSchema(Tk2TypeTable.GetInstance).t_Address_ViewKind;
 end;//g_Address = nil
 Result := g_Address_ViewKind;
end;


end.