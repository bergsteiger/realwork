unit PresentationInterfaces;
 {* Интерфейсы для поддержки представления }

// Модуль: "w:\common\components\gui\Garant\VCM\View\PresentationInterfaces.pas"
// Стереотип: "Interfaces"
// Элемент модели: "PresentationInterfaces" MUID: (49804E310263)

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Core
;

type
 TnsTurnOnTimeMachineOperation = (
  {* Операции используемые при включении машины времени }
  ns_ontmDateOp
  , ns_ontmCurrentRedactionOp
 );//TnsTurnOnTimeMachineOperation

 TnsTurnOnTimeMachineOperations = set of TnsTurnOnTimeMachineOperation;

 InsTurnOnTimeMachine = interface
  {* Включить машину времени }
  ['{B8501E97-66C4-44E4-9B97-17CE6FD2F1CB}']
  function Get_DisableOps: TnsTurnOnTimeMachineOperations;
  procedure OnDate(aDate: RtlDateTime);
   {* включить на дату }
  procedure OnCurrentRedaction;
   {* включить с начала действия текущей редакции }
  property DisableOps: TnsTurnOnTimeMachineOperations
   read Get_DisableOps;
   {* недоступные операции при работе с диалогом }
 end;//InsTurnOnTimeMachine

 TnsTurnOffTimeMachineOperation = (
  {* Операции используемые при выключении машины времени }
  ns_offtmGotoActualRedaction
  , ns_offtmStayInCurrentRedaction
  , ns_offtmChangeDate
 );//TnsTurnOffTimeMachineOperation

 TnsTurnOffTimeMachineOperations = set of TnsTurnOffTimeMachineOperation;

 InsTurnOffTimeMachine = interface
  {* Выключить машину времени }
  ['{FEA19D46-7FA6-4BCD-B6DC-84118A36EDC4}']
  function Get_DisableOps: TnsTurnOffTimeMachineOperations;
  procedure GotoActualRedaction;
   {* выключить и перейти в актуальную редакцию }
  procedure StayInCurrentRedaction;
   {* выключить и остаться в текущей редакции }
  procedure ChangeDate(aDate: RtlDateTime);
   {* изменить }
  property DisableOps: TnsTurnOffTimeMachineOperations
   read Get_DisableOps;
   {* операции недоступные при работе с машиной времени }
 end;//InsTurnOffTimeMachine

 TnsSaveDialogKind = (
  {* Типы диалогов сохранения }
  ns_sdkSimple
   {* Обычный диалог }
  , ns_sdkDocument
   {* Для документа (дополнительный чекбокс "Сохранять выделение" }
  , ns_sdkList
   {* Для списка - Радиогруппа что сохранять (названия, тексты) и пр. см ЦК25445 }
  , ns_sdkListInternal
   {* Для списка - Радиогруппа что сохранять (названия, тексты, номера топиков) и пр. см ЦК25445 }
 );//TnsSaveDialogKind

 TnsSaveDialogListTarget = (
  {* Что сохранять для списка }
  ns_sdlkTitles
   {* Названия документов }
  , ns_sdlkContents
   {* Тексты документов }
  , ns_sdlkIdentifiers
   {* номера топиков }
 );//TnsSaveDialogListTarget

 InsMainFormChildZoneManager = interface
  {* Для управления дочерней зоной главной формой }
  ['{1B9C4E1F-5E93-4CFB-9E0C-034E51A2F1CE}']
  procedure CorrectHeight(var aHeight: Integer);
   {* корректирует при необходимости высоту дочерней зоны }
 end;//InsMainFormChildZoneManager

implementation

uses
 l3ImplUses
;

end.
