unit MenuWordsPack;

interface

uses
 l3IntfUses
 , Menus
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
;

implementation

uses
 l3ImplUses
 , Controls
 , Forms
 , l3ScreenService
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TMenuWordsPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
  function ResName: AnsiString;
 end;//TMenuWordsPackResNameGetter
 
 TMenuItemFriend = class(TMenuItem)
  {* ���� ��� TMenuItem }
 end;//TMenuItemFriend
 
 TkwMenuItemClick = class(TtfwClassLike)
  {* ����� ������� menuitem:Click
*������:*
[code]
 aMenuItem menuitem:Click
[code]  }
  procedure Click(const aCtx: TtfwContext;
   aMenuItem: TMenuItem);
   {* ���������� ����� ������� menuitem:Click }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMenuItemClick
 
 TkwMenuItemGetItem = class(TtfwClassLike)
  {* ����� ������� menuitem:GetItem
*��� ����������:* TMenuItem
*������:*
[code]
OBJECT VAR l_TMenuItem
 anIndex aMenuItem menuitem:GetItem >>> l_TMenuItem
[code]  }
  function GetItem(const aCtx: TtfwContext;
   aMenuItem: TMenuItem;
   anIndex: Integer): TMenuItem;
   {* ���������� ����� ������� menuitem:GetItem }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMenuItemGetItem
 
 TkwMenuItemGetMenuHeight = class(TtfwClassLike)
  {* ����� ������� menuitem:GetMenuHeight
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aMenuItem menuitem:GetMenuHeight >>> l_Integer
[code]  }
  function GetMenuHeight(const aCtx: TtfwContext;
   aMenuItem: TMenuItem): Integer;
   {* ���������� ����� ������� menuitem:GetMenuHeight }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMenuItemGetMenuHeight
 
 TkwMenuItemCaption = class(TtfwPropertyLike)
  {* ����� ������� menuitem:GetCaption
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aMenuItem menuitem:GetCaption >>> l_String
[code]  }
  function Caption(const aCtx: TtfwContext;
   aMenuItem: TMenuItem): AnsiString;
   {* ���������� ����� ������� menuitem:GetCaption }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMenuItemCaption
 
 TkwMenuItemCount = class(TtfwPropertyLike)
  {* ����� ������� menuitem:GetCount
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aMenuItem menuitem:GetCount >>> l_Integer
[code]  }
  function Count(const aCtx: TtfwContext;
   aMenuItem: TMenuItem): Integer;
   {* ���������� ����� ������� menuitem:GetCount }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMenuItemCount
 
 TkwMenuItemEnabled = class(TtfwPropertyLike)
  {* ����� ������� menuitem:IsEnabled
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aMenuItem menuitem:IsEnabled >>> l_Boolean
[code]  }
  function Enabled(const aCtx: TtfwContext;
   aMenuItem: TMenuItem): Boolean;
   {* ���������� ����� ������� menuitem:IsEnabled }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMenuItemEnabled
 
 TkwMenuItemVisible = class(TtfwPropertyLike)
  {* ����� ������� menuitem:IsVisible
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aMenuItem menuitem:IsVisible >>> l_Boolean
[code]  }
  function Visible(const aCtx: TtfwContext;
   aMenuItem: TMenuItem): Boolean;
   {* ���������� ����� ������� menuitem:IsVisible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMenuItemVisible
 
end.
