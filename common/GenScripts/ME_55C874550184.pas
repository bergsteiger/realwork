unit vcmTabbedMenuWordsPack;

interface

uses
 l3IntfUses
 , vcmBaseMenuForChromeLike
 , Menus
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
 TvcmTabbedMenuWordsPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
  function ResName: AnsiString;
 end;//TvcmTabbedMenuWordsPackResNameGetter
 
 TvcmBaseMenuForChromeLikeFriend = class(TvcmBaseMenuForChromeLike)
  {* ���� ��� TvcmBaseMenuForChromeLike }
 end;//TvcmBaseMenuForChromeLikeFriend
 
 TkwPopMenuForChromeLikeActive = class(TtfwClassLike)
  {* ����� ������� pop:MenuForChromeLike:Active
*��� ����������:* TvcmBaseMenuForChromeLike
*������:*
[code]
OBJECT VAR l_TvcmBaseMenuForChromeLike
 aMenuForChromeLike pop:MenuForChromeLike:Active >>> l_TvcmBaseMenuForChromeLike
[code]  }
  function Active(const aCtx: TtfwContext;
   aMenuForChromeLike: TvcmBaseMenuForChromeLike): TvcmBaseMenuForChromeLike;
   {* ���������� ����� ������� pop:MenuForChromeLike:Active }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopMenuForChromeLikeActive
 
 TkwPopMenuForChromeLikeHovered = class(TtfwClassLike)
  {* ����� ������� pop:MenuForChromeLike:Hovered
*��� ����������:* TMenuItem
*������:*
[code]
OBJECT VAR l_TMenuItem
 aMenuForChromeLike pop:MenuForChromeLike:Hovered >>> l_TMenuItem
[code]  }
  function Hovered(const aCtx: TtfwContext;
   aMenuForChromeLike: TvcmBaseMenuForChromeLike): TMenuItem;
   {* ���������� ����� ������� pop:MenuForChromeLike:Hovered }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopMenuForChromeLikeHovered
 
 TkwPopMenuForChromeLikeMenuItem = class(TtfwClassLike)
  {* ����� ������� pop:MenuForChromeLike:MenuItem
*��� ����������:* TMenuItem
*������:*
[code]
OBJECT VAR l_TMenuItem
 aMenuForChromeLike pop:MenuForChromeLike:MenuItem >>> l_TMenuItem
[code]  }
  function MenuItem(const aCtx: TtfwContext;
   aMenuForChromeLike: TvcmBaseMenuForChromeLike): TMenuItem;
   {* ���������� ����� ������� pop:MenuForChromeLike:MenuItem }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopMenuForChromeLikeMenuItem
 
end.
