unit StatusBarWords;

interface

uses
 l3IntfUses
 , nscStatusBar
 , Controls
 , tfwAxiomaticsResNameGetter
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
 TStatusBarWordsResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
  function ResName: AnsiString;
 end;//TStatusBarWordsResNameGetter
 
 TkwStatusBarOrderedControl = class(TtfwClassLike)
  {* ����� ������� StatusBar:OrderedControl
*��� ����������:* TControl
*������:*
[code]
OBJECT VAR l_TControl
 anIndex aStatusBar StatusBar:OrderedControl >>> l_TControl
[code]  }
  function OrderedControl(const aCtx: TtfwContext;
   aStatusBar: TnscStatusBar;
   anIndex: Integer): TControl;
   {* ���������� ����� ������� StatusBar:OrderedControl }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStatusBarOrderedControl
 
 TkwStatusBarOrderedControlsCount = class(TtfwClassLike)
  {* ����� ������� StatusBar:OrderedControlsCount
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aStatusBar StatusBar:OrderedControlsCount >>> l_Integer
[code]  }
  function OrderedControlsCount(const aCtx: TtfwContext;
   aStatusBar: TnscStatusBar): Integer;
   {* ���������� ����� ������� StatusBar:OrderedControlsCount }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStatusBarOrderedControlsCount
 
 TkwStatusBarOrderIndex = class(TtfwClassLike)
  {* ����� ������� StatusBar:OrderIndex
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aControl aStatusBar StatusBar:OrderIndex >>> l_Integer
[code]  }
  function OrderIndex(const aCtx: TtfwContext;
   aStatusBar: TnscStatusBar;
   aControl: TControl): Integer;
   {* ���������� ����� ������� StatusBar:OrderIndex }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStatusBarOrderIndex
 
end.
