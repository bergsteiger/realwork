unit msmModelElementMethodCallerTranslatePack;

// Модуль: "w:\common\components\gui\Garant\msm\msmModelElementMethodCallerTranslatePack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "msmModelElementMethodCallerTranslatePack" MUID: (57EE79280327)

{$Include w:\common\components\msm.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwGlobalKeyWord
 , tfwScriptingInterfaces
 , l3Interfaces
 , TypInfo
 , msmModelElementMethodCaller
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *57EE79280327impl_uses*
 //#UC END# *57EE79280327impl_uses*
;

type
 TkwMsmDictionaryByFile = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта msm:DictionaryByFile }
  private
   function msm_DictionaryByFile(const aCtx: TtfwContext;
    const aFileName: Il3CString): TObject;
    {* Реализация слова скрипта msm:DictionaryByFile }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMsmDictionaryByFile

function TkwMsmDictionaryByFile.msm_DictionaryByFile(const aCtx: TtfwContext;
 const aFileName: Il3CString): TObject;
 {* Реализация слова скрипта msm:DictionaryByFile }
//#UC START# *57EE7B510228_57EE7B510228_Word_var*
//#UC END# *57EE7B510228_57EE7B510228_Word_var*
begin
//#UC START# *57EE7B510228_57EE7B510228_Word_impl*
 Result := 
  TmsmModelElementMethodCaller.Call(
   [TtfwStackValue_C(aFileName)],
   'DictionaryByName').AsObject;
//#UC END# *57EE7B510228_57EE7B510228_Word_impl*
end;//TkwMsmDictionaryByFile.msm_DictionaryByFile

class function TkwMsmDictionaryByFile.GetWordNameForRegister: AnsiString;
begin
 Result := 'msm:DictionaryByFile';
end;//TkwMsmDictionaryByFile.GetWordNameForRegister

function TkwMsmDictionaryByFile.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TObject);
end;//TkwMsmDictionaryByFile.GetResultTypeInfo

function TkwMsmDictionaryByFile.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMsmDictionaryByFile.GetAllParamsCount

function TkwMsmDictionaryByFile.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwMsmDictionaryByFile.ParamsTypes

procedure TkwMsmDictionaryByFile.DoDoIt(const aCtx: TtfwContext);
var l_aFileName: Il3CString;
begin
 try
  l_aFileName := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFileName: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(msm_DictionaryByFile(aCtx, l_aFileName));
end;//TkwMsmDictionaryByFile.DoDoIt

initialization
 TkwMsmDictionaryByFile.RegisterInEngine;
 {* Регистрация msm_DictionaryByFile }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TObject));
 {* Регистрация типа TObject }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
{$IfEnd} // NOT Defined(NoScripts)

end.
