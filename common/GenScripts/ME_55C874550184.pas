unit vcmTabbedMenuWordsPack;

// ������: "w:\common\components\gui\Garant\VCM\vcmTabbedMenuWordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 {$If NOT Defined(NoVGScene)}
 , vcmBaseMenuForChromeLike
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVCL)}
 , Menus
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 //#UC START# *710C3389FF5Dci*
 //#UC END# *710C3389FF5Dci*
 //#UC START# *710C3389FF5Dcit*
 //#UC END# *710C3389FF5Dcit*
 TvcmTabbedMenuWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
  public
   class function ResName: AnsiString; override;
 //#UC START# *710C3389FF5Dpubl*
 //#UC END# *710C3389FF5Dpubl*
 end;//TvcmTabbedMenuWordsPackResNameGetter

 TvcmBaseMenuForChromeLikeFriend = {abstract} class(TvcmBaseMenuForChromeLike)
  {* ���� ��� TvcmBaseMenuForChromeLike }
 end;//TvcmBaseMenuForChromeLikeFriend

 TkwPopMenuForChromeLikeActive = {final} class(TtfwClassLike)
  {* ����� ������� pop:MenuForChromeLike:Active
*��� ����������:* TvcmBaseMenuForChromeLike
*������:*
[code]
OBJECT VAR l_TvcmBaseMenuForChromeLike
 aMenuForChromeLike pop:MenuForChromeLike:Active >>> l_TvcmBaseMenuForChromeLike
[code]  }
  private
   function Active(const aCtx: TtfwContext;
    aMenuForChromeLike: TvcmBaseMenuForChromeLike): TvcmBaseMenuForChromeLike;
    {* ���������� ����� ������� pop:MenuForChromeLike:Active }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopMenuForChromeLikeActive

 TkwPopMenuForChromeLikeHovered = {final} class(TtfwClassLike)
  {* ����� ������� pop:MenuForChromeLike:Hovered
*��� ����������:* TMenuItem
*������:*
[code]
OBJECT VAR l_TMenuItem
 aMenuForChromeLike pop:MenuForChromeLike:Hovered >>> l_TMenuItem
[code]  }
  private
   function Hovered(const aCtx: TtfwContext;
    aMenuForChromeLike: TvcmBaseMenuForChromeLike): TMenuItem;
    {* ���������� ����� ������� pop:MenuForChromeLike:Hovered }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopMenuForChromeLikeHovered

 TkwPopMenuForChromeLikeMenuItem = {final} class(TtfwClassLike)
  {* ����� ������� pop:MenuForChromeLike:MenuItem
*��� ����������:* TMenuItem
*������:*
[code]
OBJECT VAR l_TMenuItem
 aMenuForChromeLike pop:MenuForChromeLike:MenuItem >>> l_TMenuItem
[code]  }
  private
   function MenuItem(const aCtx: TtfwContext;
    aMenuForChromeLike: TvcmBaseMenuForChromeLike): TMenuItem;
    {* ���������� ����� ������� pop:MenuForChromeLike:MenuItem }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopMenuForChromeLikeMenuItem

class function TvcmTabbedMenuWordsPackResNameGetter.ResName: AnsiString;
begin
  Result := 'vcmTabbedMenuWordsPack';
end;//TvcmTabbedMenuWordsPackResNameGetter.ResName

 {$R vcmTabbedMenuWordsPack.res}

function TkwPopMenuForChromeLikeActive.Active(const aCtx: TtfwContext;
 aMenuForChromeLike: TvcmBaseMenuForChromeLike): TvcmBaseMenuForChromeLike;
 {* ���������� ����� ������� pop:MenuForChromeLike:Active }
//#UC START# *996A05E3E097_0E751338C548_var*
//#UC END# *996A05E3E097_0E751338C548_var*
begin
//#UC START# *996A05E3E097_0E751338C548_impl*
 Result := TvcmBaseMenuForChromeLikeFriend(aMenuForChromeLike).CurrentOpenedSubmenu;
//#UC END# *996A05E3E097_0E751338C548_impl*
end;//TkwPopMenuForChromeLikeActive.Active

procedure TkwPopMenuForChromeLikeActive.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0E751338C548_var*
//#UC END# *4DAEEDE10285_0E751338C548_var*
begin
//#UC START# *4DAEEDE10285_0E751338C548_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0E751338C548_impl*
end;//TkwPopMenuForChromeLikeActive.DoDoIt

class function TkwPopMenuForChromeLikeActive.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:MenuForChromeLike:Active';
end;//TkwPopMenuForChromeLikeActive.GetWordNameForRegister

function TkwPopMenuForChromeLikeActive.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_0E751338C548_var*
//#UC END# *551544E2001A_0E751338C548_var*
begin
//#UC START# *551544E2001A_0E751338C548_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_0E751338C548_impl*
end;//TkwPopMenuForChromeLikeActive.GetResultTypeInfo

function TkwPopMenuForChromeLikeActive.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopMenuForChromeLikeActive.GetAllParamsCount

function TkwPopMenuForChromeLikeActive.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_0E751338C548_var*
//#UC END# *5617F4D00243_0E751338C548_var*
begin
//#UC START# *5617F4D00243_0E751338C548_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_0E751338C548_impl*
end;//TkwPopMenuForChromeLikeActive.ParamsTypes

function TkwPopMenuForChromeLikeHovered.Hovered(const aCtx: TtfwContext;
 aMenuForChromeLike: TvcmBaseMenuForChromeLike): TMenuItem;
 {* ���������� ����� ������� pop:MenuForChromeLike:Hovered }
//#UC START# *0DAF76B47AA2_82B96D3A5D58_var*
//#UC END# *0DAF76B47AA2_82B96D3A5D58_var*
begin
//#UC START# *0DAF76B47AA2_82B96D3A5D58_impl*
 Result := TvcmBaseMenuForChromeLikeFriend(aMenuForChromeLike).HoveredItem.rItem;
//#UC END# *0DAF76B47AA2_82B96D3A5D58_impl*
end;//TkwPopMenuForChromeLikeHovered.Hovered

procedure TkwPopMenuForChromeLikeHovered.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_82B96D3A5D58_var*
//#UC END# *4DAEEDE10285_82B96D3A5D58_var*
begin
//#UC START# *4DAEEDE10285_82B96D3A5D58_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_82B96D3A5D58_impl*
end;//TkwPopMenuForChromeLikeHovered.DoDoIt

class function TkwPopMenuForChromeLikeHovered.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:MenuForChromeLike:Hovered';
end;//TkwPopMenuForChromeLikeHovered.GetWordNameForRegister

function TkwPopMenuForChromeLikeHovered.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_82B96D3A5D58_var*
//#UC END# *551544E2001A_82B96D3A5D58_var*
begin
//#UC START# *551544E2001A_82B96D3A5D58_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_82B96D3A5D58_impl*
end;//TkwPopMenuForChromeLikeHovered.GetResultTypeInfo

function TkwPopMenuForChromeLikeHovered.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopMenuForChromeLikeHovered.GetAllParamsCount

function TkwPopMenuForChromeLikeHovered.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_82B96D3A5D58_var*
//#UC END# *5617F4D00243_82B96D3A5D58_var*
begin
//#UC START# *5617F4D00243_82B96D3A5D58_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_82B96D3A5D58_impl*
end;//TkwPopMenuForChromeLikeHovered.ParamsTypes

function TkwPopMenuForChromeLikeMenuItem.MenuItem(const aCtx: TtfwContext;
 aMenuForChromeLike: TvcmBaseMenuForChromeLike): TMenuItem;
 {* ���������� ����� ������� pop:MenuForChromeLike:MenuItem }
//#UC START# *62E15A24D84E_B39FBDC27B79_var*
//#UC END# *62E15A24D84E_B39FBDC27B79_var*
begin
//#UC START# *62E15A24D84E_B39FBDC27B79_impl*
 Result := aMenuForChromeLike.MenuItem;
//#UC END# *62E15A24D84E_B39FBDC27B79_impl*
end;//TkwPopMenuForChromeLikeMenuItem.MenuItem

procedure TkwPopMenuForChromeLikeMenuItem.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B39FBDC27B79_var*
//#UC END# *4DAEEDE10285_B39FBDC27B79_var*
begin
//#UC START# *4DAEEDE10285_B39FBDC27B79_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B39FBDC27B79_impl*
end;//TkwPopMenuForChromeLikeMenuItem.DoDoIt

class function TkwPopMenuForChromeLikeMenuItem.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:MenuForChromeLike:MenuItem';
end;//TkwPopMenuForChromeLikeMenuItem.GetWordNameForRegister

function TkwPopMenuForChromeLikeMenuItem.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_B39FBDC27B79_var*
//#UC END# *551544E2001A_B39FBDC27B79_var*
begin
//#UC START# *551544E2001A_B39FBDC27B79_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_B39FBDC27B79_impl*
end;//TkwPopMenuForChromeLikeMenuItem.GetResultTypeInfo

function TkwPopMenuForChromeLikeMenuItem.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopMenuForChromeLikeMenuItem.GetAllParamsCount

function TkwPopMenuForChromeLikeMenuItem.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_B39FBDC27B79_var*
//#UC END# *5617F4D00243_B39FBDC27B79_var*
begin
//#UC START# *5617F4D00243_B39FBDC27B79_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_B39FBDC27B79_impl*
end;//TkwPopMenuForChromeLikeMenuItem.ParamsTypes

initialization
 TvcmTabbedMenuWordsPackResNameGetter.Register;
 {* ����������� ������������ ����������� }
 TkwPopMenuForChromeLikeActive.RegisterInEngine;
 {* ����������� pop_MenuForChromeLike_Active }
 TkwPopMenuForChromeLikeHovered.RegisterInEngine;
 {* ����������� pop_MenuForChromeLike_Hovered }
 TkwPopMenuForChromeLikeMenuItem.RegisterInEngine;
 {* ����������� pop_MenuForChromeLike_MenuItem }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvcmBaseMenuForChromeLike));
 {* ����������� ���� TvcmBaseMenuForChromeLike }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TMenuItem));
 {* ����������� ���� TMenuItem }
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoTabs)

end.
