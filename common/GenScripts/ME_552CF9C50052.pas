unit AutolinkFilterWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\AutolinkFilterWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3Variant
 , tfwGlobalKeyWord
 , tfwScriptingInterfaces
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3AutolinkService
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 {$If Defined(Archi)}
 TkwFilterAutolinkFilter = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта filter:AutolinkFilter
[panel]Создаёт на стеке фильтр TddAutolinkFilter (в виде Ik2TagGenerator).[panel]
*Тип результата:* Ik2TagGenerator
*Пример:*
[code]
INTERFACE VAR l_Ik2TagGenerator
 filter:AutolinkFilter >>> l_Ik2TagGenerator
[code]  }
  private
   function filter_AutolinkFilter(const aCtx: TtfwContext): Ik2TagGenerator;
    {* Реализация слова скрипта filter:AutolinkFilter }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFilterAutolinkFilter
 {$IfEnd} // Defined(Archi)

 {$If Defined(Archi)}
 TkwFilterCleanAutolinkFilter = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта filter:CleanAutolinkFilter
[panel]Поскольку TddAutolinkFilter создаётся один на всё приложение, от него нужно отрезать Generator после использования. А иначе цепочка сохранится и будет мешать другим тестам.[panel]
*Пример:*
[code]
 filter:CleanAutolinkFilter
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwFilterCleanAutolinkFilter
 {$IfEnd} // Defined(Archi)

{$If Defined(Archi)}
function TkwFilterAutolinkFilter.filter_AutolinkFilter(const aCtx: TtfwContext): Ik2TagGenerator;
 {* Реализация слова скрипта filter:AutolinkFilter }
//#UC START# *F9D10A107F51_115E7EFB89B4_var*
//#UC END# *F9D10A107F51_115E7EFB89B4_var*
begin
//#UC START# *F9D10A107F51_115E7EFB89B4_impl*
 Result := Tl3AutolinkService.Instance.GetAutolinkFilter;
//#UC END# *F9D10A107F51_115E7EFB89B4_impl*
end;//TkwFilterAutolinkFilter.filter_AutolinkFilter
{$IfEnd} // Defined(Archi)

procedure TkwFilterAutolinkFilter.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_115E7EFB89B4_var*
//#UC END# *4DAEEDE10285_115E7EFB89B4_var*
begin
//#UC START# *4DAEEDE10285_115E7EFB89B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_115E7EFB89B4_impl*
end;//TkwFilterAutolinkFilter.DoDoIt

class function TkwFilterAutolinkFilter.GetWordNameForRegister: AnsiString;
begin
 Result := 'filter:AutolinkFilter';
end;//TkwFilterAutolinkFilter.GetWordNameForRegister

function TkwFilterAutolinkFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwFilterAutolinkFilter.GetResultTypeInfo

function TkwFilterAutolinkFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwFilterAutolinkFilter.GetAllParamsCount

function TkwFilterAutolinkFilter.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_115E7EFB89B4_var*
//#UC END# *5617F4D00243_115E7EFB89B4_var*
begin
//#UC START# *5617F4D00243_115E7EFB89B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_115E7EFB89B4_impl*
end;//TkwFilterAutolinkFilter.ParamsTypes

procedure TkwFilterCleanAutolinkFilter.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_30FF429786F9_var*
//#UC END# *4DAEEDE10285_30FF429786F9_var*
begin
//#UC START# *4DAEEDE10285_30FF429786F9_impl*
 Tl3AutolinkService.Instance.CleanAutolinkFilter;
//#UC END# *4DAEEDE10285_30FF429786F9_impl*
end;//TkwFilterCleanAutolinkFilter.DoDoIt

class function TkwFilterCleanAutolinkFilter.GetWordNameForRegister: AnsiString;
begin
 Result := 'filter:CleanAutolinkFilter';
end;//TkwFilterCleanAutolinkFilter.GetWordNameForRegister

function TkwFilterCleanAutolinkFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwFilterCleanAutolinkFilter.GetResultTypeInfo

function TkwFilterCleanAutolinkFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwFilterCleanAutolinkFilter.GetAllParamsCount

initialization
{$If Defined(Archi)}
 TkwFilterAutolinkFilter.RegisterInEngine;
 {* Регистрация filter_AutolinkFilter }
{$IfEnd} // Defined(Archi)
{$If Defined(Archi)}
 TkwFilterCleanAutolinkFilter.RegisterInEngine;
 {* Регистрация filter_CleanAutolinkFilter }
{$IfEnd} // Defined(Archi)
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ik2TagGenerator));
 {* Регистрация типа Ik2TagGenerator }
{$IfEnd} // NOT Defined(NoScripts)

end.
