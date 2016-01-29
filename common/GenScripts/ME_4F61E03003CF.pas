unit npNavigatorList;

interface

uses
 l3IntfUses
 , npNavigatorListCBT
 , l3Interfaces
 , l3Core
 , Windows
;

type
 TnpNavigatorList = class(TnpNavigatorListCBT, Il3WndProcListener, Il3GetMessageListener)
  {* ������ ����������� ��������� � ����������. ������ ������������ ��� �������� ��������� }
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  procedure GetMessageListenerNotify(Code: Integer;
   aWParam: WPARAM;
   Msg: PMsg;
   var theResult: Tl3HookProcResult);
  procedure WndProcListenerNotify(Msg: PCWPStruct;
   var theResult: Tl3HookProcResult);
 end;//TnpNavigatorList
 
implementation

uses
 l3ImplUses
 , l3ListenersManager
 , Messages
;

end.
