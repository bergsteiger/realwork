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
  {* ����� ������� pop:CheckListBox:GetChecked
[panel]anIndex aCheckBoxList pop:CheckListBox:GetChecked
anIndex - ������ CheckBox'�
aCheckBoxList  - �������
���������� True, ���� ������� ������� � False - ���� ���.[panel]
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 anIndex aCheckListBox pop:CheckListBox:GetChecked >>> l_Boolean
[code]  }
  function GetChecked(const aCtx: TtfwContext;
   aCheckListBox: TCheckListBox;
   anIndex: Integer): Boolean;
   {* ���������� ����� ������� pop:CheckListBox:GetChecked }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopCheckListBoxGetChecked
 
 TkwPopCheckListBoxSetChecked = class(TtfwClassLike)
  {* ����� ������� pop:CheckListBox:SetChecked
[panel]aValue anIndex aCheckBoxList pop:CheckListBox:SetChecked
anIndex - ������ CheckBox'�
aCheckBoxList  - �������
�������� �������, ���� aValue = True � ���������� �������, ���� aValue = False[panel]
*������:*
[code]
 aValue anIndex aCheckListBox pop:CheckListBox:SetChecked
[code]  }
  procedure SetChecked(const aCtx: TtfwContext;
   aCheckListBox: TCheckListBox;
   anIndex: Integer;
   aValue: Boolean);
   {* ���������� ����� ������� pop:CheckListBox:SetChecked }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopCheckListBoxSetChecked
 
 TkwPopCheckListBoxUncheckAll = class(TtfwClassLike)
  {* ����� ������� pop:CheckListBox:UncheckAll
[panel]aCheckBoxList pop:CheckListBox:UncheckAll
��������� ������� � ���� ������� ��������.[panel]
*������:*
[code]
 aCheckListBox pop:CheckListBox:UncheckAll
[code]  }
  procedure UncheckAll(const aCtx: TtfwContext;
   aCheckListBox: TCheckListBox);
   {* ���������� ����� ������� pop:CheckListBox:UncheckAll }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopCheckListBoxUncheckAll
 
end.
