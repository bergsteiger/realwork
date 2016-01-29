unit QueryCard_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/QueryCard_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::QueryCard
//
// Новая КЗ
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега QueryCard - "Новая КЗ".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idQueryCard = 129;

function k2_typQueryCard_CardType: QueryCard_CardType_Tag;

function k2_attrCardType: Integer;
function k2_typQueryCard: QueryCardTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_QueryCard : QueryCardTag = nil;

// start class QueryCardTag

function k2_typQueryCard: QueryCardTag;
begin
 if (g_QueryCard = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_QueryCard := TevNativeSchema(Tk2TypeTable.GetInstance).t_QueryCard;
 end;//g_QueryCard = nil
 Result := g_QueryCard;
end;
var
 g_k2_attrCardType: Integer = -1;

function k2_attrCardType: Integer;
begin
 if (g_k2_attrCardType = -1) then
  g_k2_attrCardType :=  Tk2Attributes.Instance.CheckIDByName('CardType');
 Result := g_k2_attrCardType;
end;


var
 g_QueryCard_CardType : QueryCard_CardType_Tag = nil;

// start class CardType

function k2_typQueryCard_CardType: QueryCard_CardType_Tag;
begin
 if (g_QueryCard_CardType = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_QueryCard_CardType := TevNativeSchema(Tk2TypeTable.GetInstance).t_QueryCard_CardType;
 end;//g_QueryCard = nil
 Result := g_QueryCard_CardType;
end;


end.