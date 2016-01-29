unit StatusBarButtonWords;

interface

uses
 l3IntfUses
 , nscStatusBarButton
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;

implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopStatusBarButtonIsDown = class(TtfwClassLike)
  {* ����� ������� pop:StatusBarButton:IsDown
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aStatusBarButton pop:StatusBarButton:IsDown >>> l_Boolean
[code]  }
  function IsDown(const aCtx: TtfwContext;
   aStatusBarButton: TnscStatusBarButton): Boolean;
   {* ���������� ����� ������� pop:StatusBarButton:IsDown }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopStatusBarButtonIsDown
 
end.
