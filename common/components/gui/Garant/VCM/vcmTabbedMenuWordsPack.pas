unit vcmTabbedMenuWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/vcmTabbedMenuWordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> Shared Delphi::VCM$Visual::TabsWords::vcmTabbedMenuWordsPack
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VCM\vcmDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Menus
  {$IfEnd} //not NoVCL
  ,
  tfwScriptingInterfaces
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmBaseMenuForChromeLike
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  ,
  tfwAxiomaticsResNameGetter,
  tfwClassLike
  ;

{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM

implementation

{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM)}
uses
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
//#UC START# *710C3389FF5Dci*
//#UC END# *710C3389FF5Dci*
//#UC START# *710C3389FF5Dcit*
//#UC END# *710C3389FF5Dcit*
 TvcmTabbedMenuWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
 public
 // realized methods
   class function ResName: AnsiString; override;
//#UC START# *710C3389FF5Dpubl*
//#UC END# *710C3389FF5Dpubl*
 end;//TvcmTabbedMenuWordsPackResNameGetter

// start class TvcmTabbedMenuWordsPackResNameGetter

class function TvcmTabbedMenuWordsPackResNameGetter.ResName: AnsiString;
 {-}
begin
 Result := 'vcmTabbedMenuWordsPack';
end;//TvcmTabbedMenuWordsPackResNameGetter.ResName

 {$R vcmTabbedMenuWordsPack.res}

type
 TvcmBaseMenuForChromeLikeFriend = {abstract} class(TvcmBaseMenuForChromeLike)
  {* Друг для TvcmBaseMenuForChromeLike }
 end;//TvcmBaseMenuForChromeLikeFriend

 TkwPopMenuForChromeLikeActive = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:MenuForChromeLike:Active
*Тип результата:* TvcmBaseMenuForChromeLike
*Пример:*
[code]
OBJECT VAR l_TvcmBaseMenuForChromeLike
 aMenuForChromeLike pop:MenuForChromeLike:Active >>> l_TvcmBaseMenuForChromeLike
[code]  }
 private
 // private methods
   function Active(const aCtx: TtfwContext;
    aMenuForChromeLike: TvcmBaseMenuForChromeLike): TvcmBaseMenuForChromeLike;
     {* Реализация слова скрипта pop:MenuForChromeLike:Active }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopMenuForChromeLikeActive

// start class TkwPopMenuForChromeLikeActive

function TkwPopMenuForChromeLikeActive.Active(const aCtx: TtfwContext;
  aMenuForChromeLike: TvcmBaseMenuForChromeLike): TvcmBaseMenuForChromeLike;
//#UC START# *996A05E3E097_0E751338C548_var*
//#UC END# *996A05E3E097_0E751338C548_var*
begin
//#UC START# *996A05E3E097_0E751338C548_impl*
 Result := TvcmBaseMenuForChromeLikeFriend(aMenuForChromeLike).CurrentOpenedSubmenu;
//#UC END# *996A05E3E097_0E751338C548_impl*
end;//TkwPopMenuForChromeLikeActive.Active

procedure TkwPopMenuForChromeLikeActive.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMenuForChromeLike : TvcmBaseMenuForChromeLike;
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
 aCtx.rEngine.PushObj((Active(aCtx, l_aMenuForChromeLike)));
end;//TkwPopMenuForChromeLikeActive.DoDoIt

class function TkwPopMenuForChromeLikeActive.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:MenuForChromeLike:Active';
end;//TkwPopMenuForChromeLikeActive.GetWordNameForRegister

function TkwPopMenuForChromeLikeActive.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvcmBaseMenuForChromeLike);
end;//TkwPopMenuForChromeLikeActive.GetResultTypeInfo

function TkwPopMenuForChromeLikeActive.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopMenuForChromeLikeActive.GetAllParamsCount

function TkwPopMenuForChromeLikeActive.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvcmBaseMenuForChromeLike)]);
end;//TkwPopMenuForChromeLikeActive.ParamsTypes

type
 TkwPopMenuForChromeLikeHovered = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:MenuForChromeLike:Hovered
*Тип результата:* TMenuItem
*Пример:*
[code]
OBJECT VAR l_TMenuItem
 aMenuForChromeLike pop:MenuForChromeLike:Hovered >>> l_TMenuItem
[code]  }
 private
 // private methods
   function Hovered(const aCtx: TtfwContext;
    aMenuForChromeLike: TvcmBaseMenuForChromeLike): TMenuItem;
     {* Реализация слова скрипта pop:MenuForChromeLike:Hovered }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopMenuForChromeLikeHovered

// start class TkwPopMenuForChromeLikeHovered

function TkwPopMenuForChromeLikeHovered.Hovered(const aCtx: TtfwContext;
  aMenuForChromeLike: TvcmBaseMenuForChromeLike): TMenuItem;
//#UC START# *0DAF76B47AA2_82B96D3A5D58_var*
//#UC END# *0DAF76B47AA2_82B96D3A5D58_var*
begin
//#UC START# *0DAF76B47AA2_82B96D3A5D58_impl*
 Result := TvcmBaseMenuForChromeLikeFriend(aMenuForChromeLike).HoveredItem.rItem;
//#UC END# *0DAF76B47AA2_82B96D3A5D58_impl*
end;//TkwPopMenuForChromeLikeHovered.Hovered

procedure TkwPopMenuForChromeLikeHovered.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMenuForChromeLike : TvcmBaseMenuForChromeLike;
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
 aCtx.rEngine.PushObj((Hovered(aCtx, l_aMenuForChromeLike)));
end;//TkwPopMenuForChromeLikeHovered.DoDoIt

class function TkwPopMenuForChromeLikeHovered.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:MenuForChromeLike:Hovered';
end;//TkwPopMenuForChromeLikeHovered.GetWordNameForRegister

function TkwPopMenuForChromeLikeHovered.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TMenuItem);
end;//TkwPopMenuForChromeLikeHovered.GetResultTypeInfo

function TkwPopMenuForChromeLikeHovered.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopMenuForChromeLikeHovered.GetAllParamsCount

function TkwPopMenuForChromeLikeHovered.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvcmBaseMenuForChromeLike)]);
end;//TkwPopMenuForChromeLikeHovered.ParamsTypes

type
 TkwPopMenuForChromeLikeMenuItem = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:MenuForChromeLike:MenuItem
*Тип результата:* TMenuItem
*Пример:*
[code]
OBJECT VAR l_TMenuItem
 aMenuForChromeLike pop:MenuForChromeLike:MenuItem >>> l_TMenuItem
[code]  }
 private
 // private methods
   function MenuItem(const aCtx: TtfwContext;
    aMenuForChromeLike: TvcmBaseMenuForChromeLike): TMenuItem;
     {* Реализация слова скрипта pop:MenuForChromeLike:MenuItem }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopMenuForChromeLikeMenuItem

// start class TkwPopMenuForChromeLikeMenuItem

function TkwPopMenuForChromeLikeMenuItem.MenuItem(const aCtx: TtfwContext;
  aMenuForChromeLike: TvcmBaseMenuForChromeLike): TMenuItem;
//#UC START# *62E15A24D84E_B39FBDC27B79_var*
//#UC END# *62E15A24D84E_B39FBDC27B79_var*
begin
//#UC START# *62E15A24D84E_B39FBDC27B79_impl*
 Result := aMenuForChromeLike.MenuItem;
//#UC END# *62E15A24D84E_B39FBDC27B79_impl*
end;//TkwPopMenuForChromeLikeMenuItem.MenuItem

procedure TkwPopMenuForChromeLikeMenuItem.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMenuForChromeLike : TvcmBaseMenuForChromeLike;
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
 aCtx.rEngine.PushObj((MenuItem(aCtx, l_aMenuForChromeLike)));
end;//TkwPopMenuForChromeLikeMenuItem.DoDoIt

class function TkwPopMenuForChromeLikeMenuItem.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:MenuForChromeLike:MenuItem';
end;//TkwPopMenuForChromeLikeMenuItem.GetWordNameForRegister

function TkwPopMenuForChromeLikeMenuItem.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TMenuItem);
end;//TkwPopMenuForChromeLikeMenuItem.GetResultTypeInfo

function TkwPopMenuForChromeLikeMenuItem.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopMenuForChromeLikeMenuItem.GetAllParamsCount

function TkwPopMenuForChromeLikeMenuItem.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvcmBaseMenuForChromeLike)]);
end;//TkwPopMenuForChromeLikeMenuItem.ParamsTypes
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM)}
// Регистрация скриптованой аксиоматики
 TvcmTabbedMenuWordsPackResNameGetter.Register;
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM)}
// Регистрация pop_MenuForChromeLike_Active
 TkwPopMenuForChromeLikeActive.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM)}
// Регистрация pop_MenuForChromeLike_Hovered
 TkwPopMenuForChromeLikeHovered.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM)}
// Регистрация pop_MenuForChromeLike_MenuItem
 TkwPopMenuForChromeLikeMenuItem.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM)}
// Регистрация типа TvcmBaseMenuForChromeLike
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvcmBaseMenuForChromeLike));
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM)}
// Регистрация типа TMenuItem
 TtfwTypeRegistrator.RegisterType(TypeInfo(TMenuItem));
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM

end.