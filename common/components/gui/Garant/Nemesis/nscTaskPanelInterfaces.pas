unit nscTaskPanelInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Nemesis"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Nemesis/nscTaskPanelInterfaces.pas"
// Начат: 18.02.2009 17:24
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi For F1::Nemesis::nscTaskPanelInterfaces
//
// Интерфейсы для Панели Задач
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Nemesis\nscDefine.inc}

interface

{$If defined(Nemesis)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmTaskPanelInterfaces
  {$IfEnd} //not NoVCM
  
  ;

type
 InscOperationNode = interface(IUnknown)
  {* Узел операции панели задач }
   ['{6B165312-3701-4BB0-A2B2-9E73321E893C}']
   function pm_GetOp: IvcmCustOpsGroupOperation;
   procedure CaptionChanged;
     {* изменилось название операции }
   property Op: IvcmCustOpsGroupOperation
     read pm_GetOp;
 end;//InscOperationNode
{$IfEnd} //Nemesis

implementation

end.