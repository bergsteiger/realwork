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
 //#UC START# *55C874550184impl_uses*
 //#UC END# *55C874550184impl_uses*
;

{$If NOT Defined(NoVGScene)}
type
 TvcmBaseMenuForChromeLikeFriend = {abstract} class(TvcmBaseMenuForChromeLike)
  {* Друг к классу TvcmBaseMenuForChromeLike }
 end;//TvcmBaseMenuForChromeLikeFriend
{$IfEnd} // NOT Defined(NoVGScene)

type
 TkwPopMenuForChromeLikeActive = {final} class(TtfwClassLike)
  {* Слово скрипта pop:MenuForChromeLike:Active }
  private
   function Active(const aCtx: TtfwContext;
    aMenuForChromeLike: TvcmBaseMenuForChromeLike): TvcmBaseMenuForChromeLike;
    {* Реализация слова скрипта pop:MenuForChromeLike:Active }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
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
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
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
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopMenuForChromeLikeMenuItem

 TvcmTabbedMenuWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TvcmTabbedMenuWordsPackResNameGetter

{$If NOT Defined(NoVGScene)}
{$IfEnd} // NOT Defined(NoVGScene)
function TkwPopMenuForChromeLikeActive.Active(const aCtx: TtfwContext;
 aMenuForChromeLike: TvcmBaseMenuForChromeLike): TvcmBaseMenuForChromeLike;
 {* Реализация слова скрипта pop:MenuForChromeLike:Active }
//#UC START# *55C8753A0311_55C8753A0311_545C51CB0171_Word_var*
//#UC END# *55C8753A0311_55C8753A0311_545C51CB0171_Word_var*
begin
//#UC START# *55C8753A0311_55C8753A0311_545C51CB0171_Word_impl*
 Result := TvcmBaseMenuForChromeLikeFriend(aMenuForChromeLike).CurrentOpenedSubmenu;
//#UC END# *55C8753A0311_55C8753A0311_545C51CB0171_Word_impl*
end;//TkwPopMenuForChromeLikeActive.Active

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

function TkwPopMenuForChromeLikeHovered.Hovered(const aCtx: TtfwContext;
 aMenuForChromeLike: TvcmBaseMenuForChromeLike): TMenuItem;
 {* Реализация слова скрипта pop:MenuForChromeLike:Hovered }
//#UC START# *55C8756402D3_55C8756402D3_545C51CB0171_Word_var*
//#UC END# *55C8756402D3_55C8756402D3_545C51CB0171_Word_var*
begin
//#UC START# *55C8756402D3_55C8756402D3_545C51CB0171_Word_impl*
 Result := TvcmBaseMenuForChromeLikeFriend(aMenuForChromeLike).HoveredItem.rItem;
//#UC END# *55C8756402D3_55C8756402D3_545C51CB0171_Word_impl*
end;//TkwPopMenuForChromeLikeHovered.Hovered

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

function TkwPopMenuForChromeLikeMenuItem.MenuItem(const aCtx: TtfwContext;
 aMenuForChromeLike: TvcmBaseMenuForChromeLike): TMenuItem;
 {* Реализация слова скрипта pop:MenuForChromeLike:MenuItem }
//#UC START# *55C8992400F6_55C8992400F6_545C51CB0171_Word_var*
//#UC END# *55C8992400F6_55C8992400F6_545C51CB0171_Word_var*
begin
//#UC START# *55C8992400F6_55C8992400F6_545C51CB0171_Word_impl*
 Result := aMenuForChromeLike.MenuItem;
//#UC END# *55C8992400F6_55C8992400F6_545C51CB0171_Word_impl*
end;//TkwPopMenuForChromeLikeMenuItem.MenuItem

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
