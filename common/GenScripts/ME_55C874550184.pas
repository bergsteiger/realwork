unit vcmTabbedMenuWordsPack;

// Модуль: "w:\common\components\gui\Garant\VCM\vcmTabbedMenuWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "vcmTabbedMenuWordsPack" MUID: (55C874550184)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 {$If NOT Defined(NoVGScene)}
 , vcmBaseMenuForChromeLike
 {$IfEnd} // NOT Defined(NoVGScene)
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 {$If NOT Defined(NoVCL)}
 , Menus
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwAxiomaticsResNameGetter
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopMenuForChromeLikeActive = {final} class(TtfwClassLike)
  {* Слово скрипта pop:MenuForChromeLike:Active }
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
  {* Слово скрипта pop:MenuForChromeLike:Hovered }
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
  {* Слово скрипта pop:MenuForChromeLike:MenuItem }
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

{$If NOT Defined(NoVGScene)}
 TvcmBaseMenuForChromeLikeFriend = {abstract} class(TvcmBaseMenuForChromeLike)
  {* Друг к классу TvcmBaseMenuForChromeLike }
 end;//TvcmBaseMenuForChromeLikeFriend
{$IfEnd} // NOT Defined(NoVGScene)

 TvcmTabbedMenuWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TvcmTabbedMenuWordsPackResNameGetter

function TkwPopMenuForChromeLikeActive.Active(const aCtx: TtfwContext;
 aMenuForChromeLike: TvcmBaseMenuForChromeLike): TvcmBaseMenuForChromeLike;
 {* Реализация слова скрипта pop:MenuForChromeLike:Active }
//#UC START# *55C8753A0311_0E751338C548_var*
//#UC END# *55C8753A0311_0E751338C548_var*
begin
//#UC START# *55C8753A0311_0E751338C548_impl*
 Result := TvcmBaseMenuForChromeLikeFriend(aMenuForChromeLike).CurrentOpenedSubmenu;
//#UC END# *55C8753A0311_0E751338C548_impl*
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
//#UC START# *55C8756402D3_82B96D3A5D58_var*
//#UC END# *55C8756402D3_82B96D3A5D58_var*
begin
//#UC START# *55C8756402D3_82B96D3A5D58_impl*
 Result := TvcmBaseMenuForChromeLikeFriend(aMenuForChromeLike).HoveredItem.rItem;
//#UC END# *55C8756402D3_82B96D3A5D58_impl*
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
//#UC START# *55C8992400F6_B39FBDC27B79_var*
//#UC END# *55C8992400F6_B39FBDC27B79_var*
begin
//#UC START# *55C8992400F6_B39FBDC27B79_impl*
 Result := aMenuForChromeLike.MenuItem;
//#UC END# *55C8992400F6_B39FBDC27B79_impl*
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

{$If NOT Defined(NoVGScene)}
{$IfEnd} // NOT Defined(NoVGScene)
class function TvcmTabbedMenuWordsPackResNameGetter.ResName: AnsiString;
begin
 Result := 'vcmTabbedMenuWordsPack';
end;//TvcmTabbedMenuWordsPackResNameGetter.ResName

 {$R vcmTabbedMenuWordsPack.res}

initialization
 TkwPopMenuForChromeLikeActive.RegisterInEngine;
 {* Регистрация pop_MenuForChromeLike_Active }
 TkwPopMenuForChromeLikeHovered.RegisterInEngine;
 {* Регистрация pop_MenuForChromeLike_Hovered }
 TkwPopMenuForChromeLikeMenuItem.RegisterInEngine;
 {* Регистрация pop_MenuForChromeLike_MenuItem }
 TvcmTabbedMenuWordsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvcmBaseMenuForChromeLike));
 {* Регистрация типа TvcmBaseMenuForChromeLike }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TMenuItem));
 {* Регистрация типа TMenuItem }
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoTabs)

end.
