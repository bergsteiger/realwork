unit RadioButtonWordsPack;

interface

uses
 l3IntfUses
 , StdCtrls
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
 TkwPopRadioButtonChecked = class(TtfwPropertyLike)
  {* ����� ������� pop:RadioButton:Checked
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aRadioButton pop:RadioButton:Checked >>> l_Boolean
[code]  }
  function Checked(const aCtx: TtfwContext;
   aRadioButton: TRadioButton): Boolean;
   {* ���������� ����� ������� pop:RadioButton:Checked }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRadioButtonChecked
 
end.
