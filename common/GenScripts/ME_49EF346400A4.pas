unit afwShortcutsHandler.imp;

interface

uses
 l3IntfUses
 , Messages
 , OvcController
;

type
 _afwShortcutsHandler_ = class
  {* ���������� ShortCut'�� }
  function IsHandledShortcut(var Msg: TMessage): Boolean;
   {* ���������� ShortCut'�� }
  function IsSomePopupWasClosed: Boolean;
  procedure WndProc(var Message: TMessage);
   {* ������� ��������� }
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
