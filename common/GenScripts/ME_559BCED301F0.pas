unit ItfwKeywordFinderWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ItfwKeywordFinderWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "ItfwKeywordFinderWordsPack" MUID: (559BCED301F0)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwScriptingInterfaces
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwClassLike
 , l3Interfaces
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopKeywordFinderKeywordByName = {final} class(TtfwClassLike)
  {* Слово скрипта pop:KeywordFinder:KeywordByName }
  private
   function KeywordByName(const aCtx: TtfwContext;
    aKeywordFinder: TtfwKeywordFinder;
    const aName: Il3CString): TtfwKeyWord;
    {* Реализация слова скрипта pop:KeywordFinder:KeywordByName }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopKeywordFinderKeywordByName

 TkwPopKeywordFinderParentFinder = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:KeywordFinder:ParentFinder }
  private
   function ParentFinder(const aCtx: TtfwContext;
    aKeywordFinder: TtfwKeywordFinder): TtfwKeywordFinder;
    {* Реализация слова скрипта pop:KeywordFinder:ParentFinder }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopKeywordFinderParentFinder

function TkwPopKeywordFinderKeywordByName.KeywordByName(const aCtx: TtfwContext;
 aKeywordFinder: TtfwKeywordFinder;
 const aName: Il3CString): TtfwKeyWord;
 {* Реализация слова скрипта pop:KeywordFinder:KeywordByName }
//#UC START# *559BCEFC0315_559BCEFC0315_559D5D4400D3_Word_var*
//#UC END# *559BCEFC0315_559BCEFC0315_559D5D4400D3_Word_var*
begin
//#UC START# *559BCEFC0315_559BCEFC0315_559D5D4400D3_Word_impl*
 Result := TtfwKeyWord(aKeywordFinder.KeywordByName(aName));
//#UC END# *559BCEFC0315_559BCEFC0315_559D5D4400D3_Word_impl*
end;//TkwPopKeywordFinderKeywordByName.KeywordByName

class function TkwPopKeywordFinderKeywordByName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:KeywordFinder:KeywordByName';
end;//TkwPopKeywordFinderKeywordByName.GetWordNameForRegister

function TkwPopKeywordFinderKeywordByName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwKeyWord);
end;//TkwPopKeywordFinderKeywordByName.GetResultTypeInfo

function TkwPopKeywordFinderKeywordByName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopKeywordFinderKeywordByName.GetAllParamsCount

function TkwPopKeywordFinderKeywordByName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwKeywordFinder), @tfw_tiString]);
end;//TkwPopKeywordFinderKeywordByName.ParamsTypes

procedure TkwPopKeywordFinderKeywordByName.DoDoIt(const aCtx: TtfwContext);
var l_aKeywordFinder: TtfwKeywordFinder;
var l_aName: Il3CString;
begin
 try
  l_aKeywordFinder := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aKeywordFinder: TtfwKeywordFinder : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(KeywordByName(aCtx, l_aKeywordFinder, l_aName));
end;//TkwPopKeywordFinderKeywordByName.DoDoIt

function TkwPopKeywordFinderParentFinder.ParentFinder(const aCtx: TtfwContext;
 aKeywordFinder: TtfwKeywordFinder): TtfwKeywordFinder;
 {* Реализация слова скрипта pop:KeywordFinder:ParentFinder }
//#UC START# *559BCF500182_559BCF500182_559D5D4400D3_Word_var*
//#UC END# *559BCF500182_559BCF500182_559D5D4400D3_Word_var*
begin
//#UC START# *559BCF500182_559BCF500182_559D5D4400D3_Word_impl*
 !!! Needs to be implemented !!!
//#UC END# *559BCF500182_559BCF500182_559D5D4400D3_Word_impl*
end;//TkwPopKeywordFinderParentFinder.ParentFinder

class function TkwPopKeywordFinderParentFinder.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:KeywordFinder:ParentFinder';
end;//TkwPopKeywordFinderParentFinder.GetWordNameForRegister

function TkwPopKeywordFinderParentFinder.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwKeywordFinder);
end;//TkwPopKeywordFinderParentFinder.GetResultTypeInfo

function TkwPopKeywordFinderParentFinder.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopKeywordFinderParentFinder.GetAllParamsCount

function TkwPopKeywordFinderParentFinder.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwKeywordFinder)]);
end;//TkwPopKeywordFinderParentFinder.ParamsTypes

procedure TkwPopKeywordFinderParentFinder.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ParentFinder', aCtx);
end;//TkwPopKeywordFinderParentFinder.SetValuePrim

procedure TkwPopKeywordFinderParentFinder.DoDoIt(const aCtx: TtfwContext);
var l_aKeywordFinder: TtfwKeywordFinder;
begin
 try
  l_aKeywordFinder := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aKeywordFinder: TtfwKeywordFinder : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ParentFinder(aCtx, l_aKeywordFinder));
end;//TkwPopKeywordFinderParentFinder.DoDoIt

initialization
 TkwPopKeywordFinderKeywordByName.RegisterInEngine;
 {* Регистрация pop_KeywordFinder_KeywordByName }
 TkwPopKeywordFinderParentFinder.RegisterInEngine;
 {* Регистрация pop_KeywordFinder_ParentFinder }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwKeywordFinder));
 {* Регистрация типа TtfwKeywordFinder }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwKeyWord));
 {* Регистрация типа TtfwKeyWord }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
{$IfEnd} // NOT Defined(NoScripts)

end.
