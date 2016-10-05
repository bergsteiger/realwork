unit msmWordsIndexPack;

// Модуль: "w:\common\components\gui\Garant\msm\msmWordsIndexPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "msmWordsIndexPack" MUID: (57E511340388)

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
 , msmWordsByUserNameIndex
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *57E511340388impl_uses*
 , l3String
 //#UC END# *57E511340388impl_uses*
;

type
 TkwMsmAddWordToIndex = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта msm:AddWordToIndex }
  private
   procedure msm_AddWordToIndex(const aCtx: TtfwContext;
    aWord: TtfwWord;
    const aName: Il3CString);
    {* Реализация слова скрипта msm:AddWordToIndex }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMsmAddWordToIndex

procedure TkwMsmAddWordToIndex.msm_AddWordToIndex(const aCtx: TtfwContext;
 aWord: TtfwWord;
 const aName: Il3CString);
 {* Реализация слова скрипта msm:AddWordToIndex }
//#UC START# *57E511610278_57E511610278_Word_var*
//#UC END# *57E511610278_57E511610278_Word_var*
begin
//#UC START# *57E511610278_57E511610278_Word_impl*
 if not l3IsNil(aName) then
  TmsmWordsByUserNameIndex.Instance.Add(aName, aWord);
//#UC END# *57E511610278_57E511610278_Word_impl*
end;//TkwMsmAddWordToIndex.msm_AddWordToIndex

class function TkwMsmAddWordToIndex.GetWordNameForRegister: AnsiString;
begin
 Result := 'msm:AddWordToIndex';
end;//TkwMsmAddWordToIndex.GetWordNameForRegister

function TkwMsmAddWordToIndex.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwMsmAddWordToIndex.GetResultTypeInfo

function TkwMsmAddWordToIndex.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwMsmAddWordToIndex.GetAllParamsCount

function TkwMsmAddWordToIndex.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord), @tfw_tiString]);
end;//TkwMsmAddWordToIndex.ParamsTypes

procedure TkwMsmAddWordToIndex.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
var l_aName: Il3CString;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
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
 msm_AddWordToIndex(aCtx, l_aWord, l_aName);
end;//TkwMsmAddWordToIndex.DoDoIt

initialization
 TkwMsmAddWordToIndex.RegisterInEngine;
 {* Регистрация msm_AddWordToIndex }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* Регистрация типа TtfwWord }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
{$IfEnd} // NOT Defined(NoScripts)

end.
