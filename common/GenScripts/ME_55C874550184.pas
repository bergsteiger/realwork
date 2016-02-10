unit vcmTabbedMenuWordsPack;

// Модуль: "w:\common\components\gui\Garant\VCM\vcmTabbedMenuWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

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
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 //#UC START# *710C3389FF5Dpubl*
 //#UC END# *710C3389FF5Dpubl*
 end;//TvcmTabbedMenuWordsPackResNameGetter

 TvcmBaseMenuForChromeLikeFriend = {abstract} class(TvcmBaseMenuForChromeLike)
  {* Друг для TvcmBaseMenuForChromeLike }
 end;//TvcmBaseMenuForChromeLikeFriend

 TkwPopMenuForChromeLikeActive = {final} class(TtfwClassLike)
  {* Слово скрипта pop:MenuForChromeLike:Active
*Тип результата:* TvcmBaseMenuForChromeLike
*Пример:*
[code]
OBJECT VAR l_TvcmBaseMenuForChromeLike
 aMenuForChromeLike pop:MenuForChromeLike:Active >>> l_TvcmBaseMenuForChromeLike
[code]  }
  private
   function Active(const aCtx: TtfwContext;
    aMenuForChromeLike: TvcmBaseMenuForChromeLike): TvcmBaseMenuForChromeLike;
    {* Реализация слова скрипта pop:MenuForChromeLike:Active }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopMenuForChromeLikeActive

 TkwPopMenuForChromeLikeHovered = {final} class(TtfwClassLike)
  {* Слово скрипта pop:MenuForChromeLike:Hovered
*Тип результата:* TMenuItem
*Пример:*
[code]
OBJECT VAR l_TMenuItem
 aMenuForChromeLike pop:MenuForChromeLike:Hovered >>> l_TMenuItem
[code]  }
  private
   function Hovered(const aCtx: TtfwContext;
    aMenuForChromeLike: TvcmBaseMenuForChromeLike): TMenuItem;
    {* Реализация слова скрипта pop:MenuForChromeLike:Hovered }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopMenuForChromeLikeHovered

 TkwPopMenuForChromeLikeMenuItem = {final} class(TtfwClassLike)
  {* Слово скрипта pop:MenuForChromeLike:MenuItem
*Тип результата:* TMenuItem
*Пример:*
[code]
OBJECT VAR l_TMenuItem
 aMenuForChromeLike pop:MenuForChromeLike:MenuItem >>> l_TMenuItem
[code]  }
  private
   function MenuItem(const aCtx: TtfwContext;
    aMenuForChromeLike: TvcmBaseMenuForChromeLike): TMenuItem;
    {* Реализация слова скрипта pop:MenuForChromeLike:MenuItem }
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
 {* Реализация слова скрипта pop:MenuForChromeLike:Active }
//#UC START# *996A05E3E097_0E751338C548_var*
//#UC END# *996A05E3E097_0E751338C548_var*
begin
//#UC START# *996A05E3E097_0E751338C548_impl*
 Result := TvcmBaseMenuForChromeLikeFriend(aMenuForChromeLike).CurrentOpenedSubmenu;
//#UC END# *996A05E3E097_0E751338C548_impl*
end;//TkwPopMenuForChromeLikeActive.Active

procedure TkwPopMenuForChromeLikeActive.DoDoIt(const aCtx: TtfwContext);
var l_aMenuForChromeLike: TvcmBaseMenuForChromeLike;
begin
 try
  l_aMenuForChromeLike := TvcmBaseMenuForChromeLike(aCtx.rEngine.PopObjAs(TvcmBaseMenuForChromeLike));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMenuForChromeLike: TvcmBaseMenuForChromeLike : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Active(aCtx, l_aMenuForChromeLike));
end;//TkwPopMenuForChromeLikeActive.DoDoIt

class function TkwPopMenuForChromeLikeActive.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:MenuForChromeLike:Active';
end;//TkwPopMenuForChromeLikeActive.GetWordNameForRegister

function TkwPopMenuForChromeLikeActive.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvcmBaseMenuForChromeLike);
end;//TkwPopMenuForChromeLikeActive.GetResultTypeInfo

function TkwPopMenuForChromeLikeActive.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopMenuForChromeLikeActive.GetAllParamsCount

function TkwPopMenuForChromeLikeActive.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvcmBaseMenuForChromeLike)]);
end;//TkwPopMenuForChromeLikeActive.ParamsTypes

function TkwPopMenuForChromeLikeHovered.Hovered(const aCtx: TtfwContext;
 aMenuForChromeLike: TvcmBaseMenuForChromeLike): TMenuItem;
 {* Реализация слова скрипта pop:MenuForChromeLike:Hovered }
//#UC START# *0DAF76B47AA2_82B96D3A5D58_var*
//#UC END# *0DAF76B47AA2_82B96D3A5D58_var*
begin
//#UC START# *0DAF76B47AA2_82B96D3A5D58_impl*
 Result := TvcmBaseMenuForChromeLikeFriend(aMenuForChromeLike).HoveredItem.rItem;
//#UC END# *0DAF76B47AA2_82B96D3A5D58_impl*
end;//TkwPopMenuForChromeLikeHovered.Hovered

procedure TkwPopMenuForChromeLikeHovered.DoDoIt(const aCtx: TtfwContext);
var l_aMenuForChromeLike: TvcmBaseMenuForChromeLike;
begin
 try
  l_aMenuForChromeLike := TvcmBaseMenuForChromeLike(aCtx.rEngine.PopObjAs(TvcmBaseMenuForChromeLike));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMenuForChromeLike: TvcmBaseMenuForChromeLike : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Hovered(aCtx, l_aMenuForChromeLike));
end;//TkwPopMenuForChromeLikeHovered.DoDoIt

class function TkwPopMenuForChromeLikeHovered.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:MenuForChromeLike:Hovered';
end;//TkwPopMenuForChromeLikeHovered.GetWordNameForRegister

function TkwPopMenuForChromeLikeHovered.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TMenuItem);
end;//TkwPopMenuForChromeLikeHovered.GetResultTypeInfo

function TkwPopMenuForChromeLikeHovered.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopMenuForChromeLikeHovered.GetAllParamsCount

function TkwPopMenuForChromeLikeHovered.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvcmBaseMenuForChromeLike)]);
end;//TkwPopMenuForChromeLikeHovered.ParamsTypes

function TkwPopMenuForChromeLikeMenuItem.MenuItem(const aCtx: TtfwContext;
 aMenuForChromeLike: TvcmBaseMenuForChromeLike): TMenuItem;
 {* Реализация слова скрипта pop:MenuForChromeLike:MenuItem }
//#UC START# *62E15A24D84E_B39FBDC27B79_var*
//#UC END# *62E15A24D84E_B39FBDC27B79_var*
begin
//#UC START# *62E15A24D84E_B39FBDC27B79_impl*
 Result := aMenuForChromeLike.MenuItem;
//#UC END# *62E15A24D84E_B39FBDC27B79_impl*
end;//TkwPopMenuForChromeLikeMenuItem.MenuItem

procedure TkwPopMenuForChromeLikeMenuItem.DoDoIt(const aCtx: TtfwContext);
var l_aMenuForChromeLike: TvcmBaseMenuForChromeLike;
begin
 try
  l_aMenuForChromeLike := TvcmBaseMenuForChromeLike(aCtx.rEngine.PopObjAs(TvcmBaseMenuForChromeLike));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMenuForChromeLike: TvcmBaseMenuForChromeLike : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(MenuItem(aCtx, l_aMenuForChromeLike));
end;//TkwPopMenuForChromeLikeMenuItem.DoDoIt

class function TkwPopMenuForChromeLikeMenuItem.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:MenuForChromeLike:MenuItem';
end;//TkwPopMenuForChromeLikeMenuItem.GetWordNameForRegister

function TkwPopMenuForChromeLikeMenuItem.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TMenuItem);
end;//TkwPopMenuForChromeLikeMenuItem.GetResultTypeInfo

function TkwPopMenuForChromeLikeMenuItem.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopMenuForChromeLikeMenuItem.GetAllParamsCount

function TkwPopMenuForChromeLikeMenuItem.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvcmBaseMenuForChromeLike)]);
end;//TkwPopMenuForChromeLikeMenuItem.ParamsTypes

initialization
 TvcmTabbedMenuWordsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TkwPopMenuForChromeLikeActive.RegisterInEngine;
 {* Регистрация pop_MenuForChromeLike_Active }
 TkwPopMenuForChromeLikeHovered.RegisterInEngine;
 {* Регистрация pop_MenuForChromeLike_Hovered }
 TkwPopMenuForChromeLikeMenuItem.RegisterInEngine;
 {* Регистрация pop_MenuForChromeLike_MenuItem }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvcmBaseMenuForChromeLike));
 {* Регистрация типа TvcmBaseMenuForChromeLike }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TMenuItem));
 {* Регистрация типа TMenuItem }
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoTabs)

end.
