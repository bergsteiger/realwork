unit vtComboBoxWordsPack;

interface

uses
 l3IntfUses
 , StdCtrls
 , vtComboTree
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;

implementation

uses
 l3ImplUses
 , tfwAxiomaticsResNameGetters
 , vtComboBoxQS
 , l3TreeInterfaces
 , l3Filer
 , l3Types
 , l3Interfaces
 , SysUtils
 , tfwScriptingTypes
 , tfwTypeRegistrator
;

type
 TvtComboBoxWordsPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
  function ResName: AnsiString;
 end;//TvtComboBoxWordsPackResNameGetter
 
 TCustomComboBoxFriend = class(TCustomComboBox)
  {* ���� ��� TCustomComboBox }
 end;//TCustomComboBoxFriend
 
 TkwPopComboBoxDropDown = class(TtfwClassLike)
  {* ����� ������� pop:ComboBox:DropDown
*������:*
[code]
 aValue aComboBox pop:ComboBox:DropDown
[code]  }
  procedure DropDown(const aCtx: TtfwContext;
   aComboBox: TCustomComboBox;
   aValue: Boolean);
   {* ���������� ����� ������� pop:ComboBox:DropDown }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComboBoxDropDown
 
 TkwPopComboBoxGetItemIndex = class(TtfwClassLike)
  {* ����� ������� pop:ComboBox:GetItemIndex
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aComboBox pop:ComboBox:GetItemIndex >>> l_Integer
[code]  }
  function GetItemIndex(const aCtx: TtfwContext;
   aComboBox: TCustomComboBox): Integer;
   {* ���������� ����� ������� pop:ComboBox:GetItemIndex }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComboBoxGetItemIndex
 
 TkwPopComboBoxIndexOf = class(TtfwClassLike)
  {* ����� ������� pop:ComboBox:IndexOf
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aString aComboBox pop:ComboBox:IndexOf >>> l_Integer
[code]  }
  function IndexOf(const aCtx: TtfwContext;
   aComboBox: TCustomComboBox;
   const aString: AnsiString): Integer;
   {* ���������� ����� ������� pop:ComboBox:IndexOf }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComboBoxIndexOf
 
 TkwPopComboBoxSelectItem = class(TtfwClassLike)
  {* ����� ������� pop:ComboBox:SelectItem
*������:*
[code]
 aString aComboBox pop:ComboBox:SelectItem
[code]  }
  procedure SelectItem(const aCtx: TtfwContext;
   aComboBox: TCustomComboBox;
   const aString: AnsiString);
   {* ���������� ����� ������� pop:ComboBox:SelectItem }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComboBoxSelectItem
 
 TkwPopComboBoxSetItemIndex = class(TtfwClassLike)
  {* ����� ������� pop:ComboBox:SetItemIndex
*������:*
[code]
 anIndex aComboBox pop:ComboBox:SetItemIndex
[code]  }
  procedure SetItemIndex(const aCtx: TtfwContext;
   aComboBox: TCustomComboBox;
   anIndex: Integer);
   {* ���������� ����� ������� pop:ComboBox:SetItemIndex }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComboBoxSetItemIndex
 
 TkwPopComboBoxSaveItems = class(TtfwClassLike)
  {* ����� ������� pop:ComboBox:SaveItems
[panel]*������:* ���_�����  ������� pop:ComboBox:SaveItems 
*��������:* ��������� ��� ������ ����������� ������ (�������� ���������� �������) � ���� (�������� ���������� ���_�����)  � ���������� � ��������.
*������:*
[code]
'MyList.cmbx' 'StyleComboBox' byname:control:push pop:ComboBox:SaveItems
[code] 
*���������:* ��������� ���������� ���������� 'StyleComboBox' �  ����  'MyList.cmbx' � ���������� � ��������.[panel]
*������:*
[code]
 aFileName aComboBox pop:ComboBox:SaveItems
[code]  }
  procedure SaveItems(const aCtx: TtfwContext;
   aComboBox: TCustomComboBox;
   const aFileName: AnsiString);
   {* ���������� ����� ������� pop:ComboBox:SaveItems }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComboBoxSaveItems
 
 TkwPopComboTreeDropDown = class(TtfwClassLike)
  {* ����� ������� pop:ComboTree:DropDown
*������:*
[code]
 aValue aComboTree pop:ComboTree:DropDown
[code]  }
  procedure DropDown(const aCtx: TtfwContext;
   aComboTree: TvtComboTree;
   aValue: Boolean);
   {* ���������� ����� ������� pop:ComboTree:DropDown }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComboTreeDropDown
 
 TkwPopComboTreeGetItemIndex = class(TtfwClassLike)
  {* ����� ������� pop:ComboTree:GetItemIndex
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aComboTree pop:ComboTree:GetItemIndex >>> l_Integer
[code]  }
  function GetItemIndex(const aCtx: TtfwContext;
   aComboTree: TvtComboTree): Integer;
   {* ���������� ����� ������� pop:ComboTree:GetItemIndex }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComboTreeGetItemIndex
 
 TkwPopComboTreeIndexOf = class(TtfwClassLike)
  {* ����� ������� pop:ComboTree:IndexOf
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aString aComboTree pop:ComboTree:IndexOf >>> l_Integer
[code]  }
  function IndexOf(const aCtx: TtfwContext;
   aComboTree: TvtComboTree;
   const aString: AnsiString): Integer;
   {* ���������� ����� ������� pop:ComboTree:IndexOf }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComboTreeIndexOf
 
 TkwPopComboTreeSelectItem = class(TtfwClassLike)
  {* ����� ������� pop:ComboTree:SelectItem
*������:*
[code]
 aString aComboTree pop:ComboTree:SelectItem
[code]  }
  procedure SelectItem(const aCtx: TtfwContext;
   aComboTree: TvtComboTree;
   const aString: AnsiString);
   {* ���������� ����� ������� pop:ComboTree:SelectItem }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComboTreeSelectItem
 
 TkwPopComboTreeSetItemIndex = class(TtfwClassLike)
  {* ����� ������� pop:ComboTree:SetItemIndex
*������:*
[code]
 anIndex aComboTree pop:ComboTree:SetItemIndex
[code]  }
  procedure SetItemIndex(const aCtx: TtfwContext;
   aComboTree: TvtComboTree;
   anIndex: Integer);
   {* ���������� ����� ������� pop:ComboTree:SetItemIndex }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComboTreeSetItemIndex
 
 TkwPopComboTreeSaveItems = class(TtfwClassLike)
  {* ����� ������� pop:ComboTree:SaveItems
[panel]*������:* ���_�����  ������� pop:ComboBox:SaveItems 
*��������:* ��������� ��� ������ ����������� ������ (�������� ���������� �������) � ���� (�������� ���������� ���_�����)  � ���������� � ��������.
*������:*
[code]
'MyList.cmbx' 'StyleComboBox' byname:control:push pop:ComboBox:SaveItems
[code] 
*���������:* ��������� ���������� ���������� 'StyleComboBox' �  ����  'MyList.cmbx' � ���������� � ��������.[panel]
*������:*
[code]
 aFileName aComboTree pop:ComboTree:SaveItems
[code]  }
  procedure SaveItems(const aCtx: TtfwContext;
   aComboTree: TvtComboTree;
   const aFileName: AnsiString);
   {* ���������� ����� ������� pop:ComboTree:SaveItems }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComboTreeSaveItems
 
end.
