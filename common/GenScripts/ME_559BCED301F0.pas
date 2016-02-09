unit ItfwKeywordFinderWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ItfwKeywordFinderWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwScriptingInterfaces
 , l3Interfaces
 , tfwClassLike
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopKeywordFinderKeywordByName = {final} class(TtfwClassLike)
  {* Слово скрипта pop:KeywordFinder:KeywordByName
*Тип результата:* TtfwKeyWord
*Пример:*
[code]
OBJECT VAR l_TtfwKeyWord
 aName aKeywordFinder pop:KeywordFinder:KeywordByName >>> l_TtfwKeyWord
[code]  }
  private
   function KeywordByName(const aCtx: TtfwContext;
    aKeywordFinder: TtfwKeywordFinder;
    const aName: Il3CString): TtfwKeyWord;
    {* Реализация слова скрипта pop:KeywordFinder:KeywordByName }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopKeywordFinderKeywordByName

 TkwPopKeywordFinderParentFinder = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:KeywordFinder:ParentFinder
*Тип результата:* TtfwKeywordFinder
*Пример:*
[code]
OBJECT VAR l_TtfwKeywordFinder
 aKeywordFinder pop:KeywordFinder:ParentFinder >>> l_TtfwKeywordFinder
[code]  }
  private
   function ParentFinder(const aCtx: TtfwContext;
    aKeywordFinder: TtfwKeywordFinder): TtfwKeywordFinder;
    {* Реализация слова скрипта pop:KeywordFinder:ParentFinder }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopKeywordFinderParentFinder

function TkwPopKeywordFinderKeywordByName.KeywordByName(const aCtx: TtfwContext;
 aKeywordFinder: TtfwKeywordFinder;
 const aName: Il3CString): TtfwKeyWord;
 {* Реализация слова скрипта pop:KeywordFinder:KeywordByName }
//#UC START# *4BB40DD9D18E_D73628563892_var*
//#UC END# *4BB40DD9D18E_D73628563892_var*
begin
//#UC START# *4BB40DD9D18E_D73628563892_impl*
 Result := TtfwKeyWord(aKeywordFinder.KeywordByName(aName));
//#UC END# *4BB40DD9D18E_D73628563892_impl*
end;//TkwPopKeywordFinderKeywordByName.KeywordByName

procedure TkwPopKeywordFinderKeywordByName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D73628563892_var*
//#UC END# *4DAEEDE10285_D73628563892_var*
begin
//#UC START# *4DAEEDE10285_D73628563892_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D73628563892_impl*
end;//TkwPopKeywordFinderKeywordByName.DoDoIt

class function TkwPopKeywordFinderKeywordByName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:KeywordFinder:KeywordByName';
end;//TkwPopKeywordFinderKeywordByName.GetWordNameForRegister

function TkwPopKeywordFinderKeywordByName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_D73628563892_var*
//#UC END# *551544E2001A_D73628563892_var*
begin
//#UC START# *551544E2001A_D73628563892_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_D73628563892_impl*
end;//TkwPopKeywordFinderKeywordByName.GetResultTypeInfo

function TkwPopKeywordFinderKeywordByName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopKeywordFinderKeywordByName.GetAllParamsCount

function TkwPopKeywordFinderKeywordByName.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_D73628563892_var*
//#UC END# *5617F4D00243_D73628563892_var*
begin
//#UC START# *5617F4D00243_D73628563892_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_D73628563892_impl*
end;//TkwPopKeywordFinderKeywordByName.ParamsTypes

function TkwPopKeywordFinderParentFinder.ParentFinder(const aCtx: TtfwContext;
 aKeywordFinder: TtfwKeywordFinder): TtfwKeywordFinder;
 {* Реализация слова скрипта pop:KeywordFinder:ParentFinder }
//#UC START# *3D8B4028DC71_F60851FE16E3_var*
//#UC END# *3D8B4028DC71_F60851FE16E3_var*
begin
//#UC START# *3D8B4028DC71_F60851FE16E3_impl*
 Result := aKeywordFinder.ParentFinder;
//#UC END# *3D8B4028DC71_F60851FE16E3_impl*
end;//TkwPopKeywordFinderParentFinder.ParentFinder

procedure TkwPopKeywordFinderParentFinder.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F60851FE16E3_var*
//#UC END# *4DAEEDE10285_F60851FE16E3_var*
begin
//#UC START# *4DAEEDE10285_F60851FE16E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F60851FE16E3_impl*
end;//TkwPopKeywordFinderParentFinder.DoDoIt

class function TkwPopKeywordFinderParentFinder.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:KeywordFinder:ParentFinder';
end;//TkwPopKeywordFinderParentFinder.GetWordNameForRegister

procedure TkwPopKeywordFinderParentFinder.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_F60851FE16E3_var*
//#UC END# *52D00B00031A_F60851FE16E3_var*
begin
//#UC START# *52D00B00031A_F60851FE16E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_F60851FE16E3_impl*
end;//TkwPopKeywordFinderParentFinder.SetValuePrim

function TkwPopKeywordFinderParentFinder.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_F60851FE16E3_var*
//#UC END# *551544E2001A_F60851FE16E3_var*
begin
//#UC START# *551544E2001A_F60851FE16E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_F60851FE16E3_impl*
end;//TkwPopKeywordFinderParentFinder.GetResultTypeInfo

function TkwPopKeywordFinderParentFinder.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopKeywordFinderParentFinder.GetAllParamsCount

function TkwPopKeywordFinderParentFinder.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F60851FE16E3_var*
//#UC END# *5617F4D00243_F60851FE16E3_var*
begin
//#UC START# *5617F4D00243_F60851FE16E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F60851FE16E3_impl*
end;//TkwPopKeywordFinderParentFinder.ParamsTypes

initialization
 TkwPopKeywordFinderKeywordByName.RegisterInEngine;
 {* Регистрация pop_KeywordFinder_KeywordByName }
 TkwPopKeywordFinderParentFinder.RegisterInEngine;
 {* Регистрация pop_KeywordFinder_ParentFinder }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwKeywordFinder));
 {* Регистрация типа TtfwKeywordFinder }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwKeyWord));
 {* Регистрация типа TtfwKeyWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
