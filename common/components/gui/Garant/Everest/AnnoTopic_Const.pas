unit AnnoTopic_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/AnnoTopic_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::AnnoTopic
//
// Аннотация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега AnnoTopic - "Аннотация".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idAnnoTopic = 54;

function k2_typAnnoTopic: AnnoTopicTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_AnnoTopic : AnnoTopicTag = nil;

// start class AnnoTopicTag

function k2_typAnnoTopic: AnnoTopicTag;
begin
 if (g_AnnoTopic = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_AnnoTopic := TevNativeSchema(Tk2TypeTable.GetInstance).t_AnnoTopic;
 end;//g_AnnoTopic = nil
 Result := g_AnnoTopic;
end;

end.