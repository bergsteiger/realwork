unit tb97WordsPack;

interface

uses
 l3IntfUses
 , tb97Ctls
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , tfwTypeInfo
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
 TkwPopTB97ButtonDown = class(TtfwPropertyLike)
  {* ����� ������� pop:TB97Button:Down
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aTB97Button pop:TB97Button:Down >>> l_Boolean
[code]  }
  function Down(const aCtx: TtfwContext;
   aTB97Button: TCustomToolbarButton97): Boolean;
   {* ���������� ����� ������� pop:TB97Button:Down }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTB97ButtonDown
 
end.
