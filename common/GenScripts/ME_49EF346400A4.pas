unit afwShortcutsHandler.imp;

interface

uses
 l3IntfUses
 , Messages
 , OvcController
;

type
 _afwShortcutsHandler_ = class
  {* Обработчик ShortCut'ов }
  function IsHandledShortcut(var Msg: TMessage): Boolean;
   {* Обработчик ShortCut'ов }
  function IsSomePopupWasClosed: Boolean;
  procedure WndProc(var Message: TMessage);
   {* Оконная процедура }
 end;//_afwShortcutsHandler_
 
implementation

uses
 l3ImplUses
 , Controls
 , Windows
 , Forms
 , OvcConst
;

end.
