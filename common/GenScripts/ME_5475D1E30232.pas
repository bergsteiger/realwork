unit l3ProcessMessagesManager;

interface

uses
 l3IntfUses
 , l3SimpleObject
 , l3LongintList
 , Windows
;

type
 Tl3ProcessMessagesManager = class(Tl3SimpleObject)
  {* Список окон, которым надо обрабатывать сообщения в длинных процессах.
Используется в случаях, когда afw.ProcessMessages приводит к проблемам. }
  procedure Subscribe(aHandle: THandle);
  procedure Unsubscribe(aHandle: THandle);
  procedure ProcessMessages(wMsgFilterMin: LongWord;
   wMsgFilterMax: LongWord;
   wRemoveMsg: LongWord);
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//Tl3ProcessMessagesManager
 
implementation

uses
 l3ImplUses
 , Forms
;

end.
