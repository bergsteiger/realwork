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
  {* Слово скрипта pop:RadioButton:Checked
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aRadioButton pop:RadioButton:Checked >>> l_Boolean
[code]  }
  function Checked(const aCtx: TtfwContext;
   aRadioButton: TRadioButton): Boolean;
   {* Реализация слова скрипта pop:RadioButton:Checked }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRadioButtonChecked
 
end.
