unit Participant_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/Participant_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::Participant
//
// Участник
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Participant - "Участник".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idParticipant = 90;

function k2_attrType: Integer;

function k2_attrName: Integer;

function k2_typParticipant: ParticipantTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Participant : ParticipantTag = nil;

// start class ParticipantTag

function k2_typParticipant: ParticipantTag;
begin
 if (g_Participant = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Participant := TevNativeSchema(Tk2TypeTable.GetInstance).t_Participant;
 end;//g_Participant = nil
 Result := g_Participant;
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
 g_k2_attrName: Integer = -1;

function k2_attrName: Integer;
begin
 if (g_k2_attrName = -1) then
  g_k2_attrName :=  Tk2Attributes.Instance.CheckIDByName('Name');
 Result := g_k2_attrName;
end;


end.