unit CheckListBoxWordsPack;

interface

uses
 l3IntfUses
 , CheckLst
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
 TkwPopCheckListBoxGetChecked = class(TtfwClassLike)
  {* Слово скрипта pop:CheckListBox:GetChecked
[panel]anIndex aCheckBoxList pop:CheckListBox:GetChecked
anIndex - индекс CheckBox'а
aCheckBoxList  - контрол
Возвращает True, если элемент помечен и False - если нет.[panel]
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 anIndex aCheckListBox pop:CheckListBox:GetChecked >>> l_Boolean
[code]  }
  function GetChecked(const aCtx: TtfwContext;
   aCheckListBox: TCheckListBox;
   anIndex: Integer): Boolean;
   {* Реализация слова скрипта pop:CheckListBox:GetChecked }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopCheckListBoxGetChecked
 
 TkwPopCheckListBoxSetChecked = class(TtfwClassLike)
  {* Слово скрипта pop:CheckListBox:SetChecked
[panel]aValue anIndex aCheckBoxList pop:CheckListBox:SetChecked
anIndex - индекс CheckBox'а
aCheckBoxList  - контрол
Помечает элемент, если aValue = True и сбрасывает пометку, если aValue = False[panel]
*Пример:*
[code]
 aValue anIndex aCheckListBox pop:CheckListBox:SetChecked
[code]  }
  procedure SetChecked(const aCtx: TtfwContext;
   aCheckListBox: TCheckListBox;
   anIndex: Integer;
   aValue: Boolean);
   {* Реализация слова скрипта pop:CheckListBox:SetChecked }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopCheckListBoxSetChecked
 
 TkwPopCheckListBoxUncheckAll = class(TtfwClassLike)
  {* Слово скрипта pop:CheckListBox:UncheckAll
[panel]aCheckBoxList pop:CheckListBox:UncheckAll
Сбрасыват пометки у всех пунктов контрола.[panel]
*Пример:*
[code]
 aCheckListBox pop:CheckListBox:UncheckAll
[code]  }
  procedure UncheckAll(const aCtx: TtfwContext;
   aCheckListBox: TCheckListBox);
   {* Реализация слова скрипта pop:CheckListBox:UncheckAll }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopCheckListBoxUncheckAll
 
end.
