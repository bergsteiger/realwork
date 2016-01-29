unit PresentationInterfaces;

interface

uses
 l3IntfUses
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
  procedure OnDate(aDate: RtlDateTime);
   {* включить на дату }
  procedure OnCurrentRedaction;
   {* включить с начала действия текущей редакции }
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
  procedure GotoActualRedaction;
   {* выключить и перейти в актуальную редакцию }
  procedure StayInCurrentRedaction;
   {* выключить и остаться в текущей редакции }
  procedure ChangeDate(aDate: RtlDateTime);
   {* изменить }
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
  procedure CorrectHeight(var aHeight: Integer);
   {* корректирует при необходимости высоту дочерней зоны }
 end;//InsMainFormChildZoneManager
 
implementation

uses
 l3ImplUses
;

end.
