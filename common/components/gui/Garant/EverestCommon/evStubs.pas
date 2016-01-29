unit evStubs;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EverestCommon"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/EverestCommon/NOT_FINISHED_evStubs.pas"
// Начат: 03.06.2009 11:09
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::EverestCommon::evFacade::evStubs
//
// Процедуры для формирования заглушек локальных процедур
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include evDefine.inc}

interface

uses                  
  nevTools,
  evInternalInterfaces
  ;

function  evL2SubA(Action: Pointer): InevSubList_Iterate_Action;
  {* - делает заглушку для локальной процедуры. }

implementation

uses
  l3Base
  ;

function  evL2SubA(Action: Pointer): InevSubList_Iterate_Action;
  {* - делает заглушку для локальной процедуры. }
  register;
  {-}
asm
          jmp  l3LocalStub
end;{asm}

end.