unit NumANDDate_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/NumANDDate_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdNative::NumANDDate
//
// Дата/номер
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега NumANDDate - "Дата/номер".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

const
 k2_idNumANDDate = 82;

function k2_attrHandle: Integer;

function k2_attrNumber: Integer;

function k2_attrComment: Integer;

function k2_attrDocID: Integer;

function k2_attrLinkAddress: Integer;

function k2_typNumANDDate: NumANDDateTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_NumANDDate : NumANDDateTag = nil;

// start class NumANDDateTag

function k2_typNumANDDate: NumANDDateTag;
begin
 if (g_NumANDDate = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_NumANDDate := TevdNativeSchema(Tk2TypeTable.GetInstance).t_NumANDDate;
 end;//g_NumANDDate = nil
 Result := g_NumANDDate;
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
 g_k2_attrNumber: Integer = -1;

function k2_attrNumber: Integer;
begin
 if (g_k2_attrNumber = -1) then
  g_k2_attrNumber :=  Tk2Attributes.Instance.CheckIDByName('Number');
 Result := g_k2_attrNumber;
end;

var
 g_k2_attrComment: Integer = -1;

function k2_attrComment: Integer;
begin
 if (g_k2_attrComment = -1) then
  g_k2_attrComment :=  Tk2Attributes.Instance.CheckIDByName('Comment');
 Result := g_k2_attrComment;
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
 g_k2_attrLinkAddress: Integer = -1;

function k2_attrLinkAddress: Integer;
begin
 if (g_k2_attrLinkAddress = -1) then
  g_k2_attrLinkAddress :=  Tk2Attributes.Instance.CheckIDByName('LinkAddress');
 Result := g_k2_attrLinkAddress;
end;


end.