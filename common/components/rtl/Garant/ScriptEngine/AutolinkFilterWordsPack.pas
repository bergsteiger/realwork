unit AutolinkFilterWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\AutolinkFilterWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "AutolinkFilterWordsPack" MUID: (552CF9C50052)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If Defined(Archi) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(Archi) AND NOT Defined(NoScripts)

implementation

{$If Defined(Archi) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwGlobalKeyWord
 , l3Variant
 , tfwScriptingInterfaces
 , TypInfo
 , l3AutolinkService
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *552CF9C50052impl_uses*
 //#UC END# *552CF9C50052impl_uses*
;

type
 TkwFilterAutolinkFilter = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта filter:AutolinkFilter }
  private
   function filter_AutolinkFilter(const aCtx: TtfwContext): Ik2TagGenerator;
    {* Реализация слова скрипта filter:AutolinkFilter }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFilterAutolinkFilter

 TkwFilterCleanAutolinkFilter = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта filter:CleanAutolinkFilter }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFilterCleanAutolinkFilter

function TkwFilterAutolinkFilter.filter_AutolinkFilter(const aCtx: TtfwContext): Ik2TagGenerator;
 {* Реализация слова скрипта filter:AutolinkFilter }
//#UC START# *552BE03C03E2_552BE03C03E2_Word_var*
//#UC END# *552BE03C03E2_552BE03C03E2_Word_var*
begin
//#UC START# *552BE03C03E2_552BE03C03E2_Word_impl*
 Result := Tl3AutolinkService.Instance.GetAutolinkFilter;
//#UC END# *552BE03C03E2_552BE03C03E2_Word_impl*
end;//TkwFilterAutolinkFilter.filter_AutolinkFilter

class function TkwFilterAutolinkFilter.GetWordNameForRegister: AnsiString;
begin
 Result := 'filter:AutolinkFilter';
end;//TkwFilterAutolinkFilter.GetWordNameForRegister

function TkwFilterAutolinkFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Ik2TagGenerator);
end;//TkwFilterAutolinkFilter.GetResultTypeInfo

function TkwFilterAutolinkFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwFilterAutolinkFilter.GetAllParamsCount

function TkwFilterAutolinkFilter.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwFilterAutolinkFilter.ParamsTypes

procedure TkwFilterAutolinkFilter.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushIntf(filter_AutolinkFilter(aCtx), TypeInfo(Ik2TagGenerator));
end;//TkwFilterAutolinkFilter.DoDoIt

class function TkwFilterCleanAutolinkFilter.GetWordNameForRegister: AnsiString;
begin
 Result := 'filter:CleanAutolinkFilter';
end;//TkwFilterCleanAutolinkFilter.GetWordNameForRegister

function TkwFilterCleanAutolinkFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwFilterCleanAutolinkFilter.GetResultTypeInfo

function TkwFilterCleanAutolinkFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwFilterCleanAutolinkFilter.GetAllParamsCount

function TkwFilterCleanAutolinkFilter.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwFilterCleanAutolinkFilter.ParamsTypes

procedure TkwFilterCleanAutolinkFilter.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_552BE009014C_Word_var*
//#UC END# *4DAEEDE10285_552BE009014C_Word_var*
begin
//#UC START# *4DAEEDE10285_552BE009014C_Word_impl*
 Tl3AutolinkService.Instance.CleanAutolinkFilter;
//#UC END# *4DAEEDE10285_552BE009014C_Word_impl*
end;//TkwFilterCleanAutolinkFilter.DoDoIt

initialization
 TkwFilterAutolinkFilter.RegisterInEngine;
 {* Регистрация filter_AutolinkFilter }
 TkwFilterCleanAutolinkFilter.RegisterInEngine;
 {* Регистрация filter_CleanAutolinkFilter }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ik2TagGenerator));
 {* Регистрация типа Ik2TagGenerator }
{$IfEnd} // Defined(Archi) AND NOT Defined(NoScripts)

end.
