unit RadioGroupWordsPack;

interface

uses
 l3IntfUses
 , ExtCtrls
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
 TkwPopRadioGroupItemIndex = class(TtfwPropertyLike)
  {* ����� ������� pop:RadioGroup:ItemIndex
[panel]������ ��������[panel]
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aRadioGroup pop:RadioGroup:ItemIndex >>> l_Integer
[code]  }
  function ItemIndex(const aCtx: TtfwContext;
   aRadioGroup: TRadioGroup): Integer;
   {* ���������� ����� ������� pop:RadioGroup:ItemIndex }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRadioGroupItemIndex
 
end.
