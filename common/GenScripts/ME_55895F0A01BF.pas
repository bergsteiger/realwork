unit KeyWordPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\KeyWordPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "KeyWordPack" MUID: (55895F0A01BF)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwScriptingInterfaces
 , l3Interfaces
 , tfwDictionary
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwClassLike
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
 , tfwScriptEngineExInterfaces
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopKeyWordSetWord = {final} class(TtfwClassLike)
  {* Слово скрипта pop:KeyWord:SetWord }
  private
   procedure SetWord(const aCtx: TtfwContext;
    aKeyWord: TtfwKeyWord;
    aWord: TtfwWord);
    {* Реализация слова скрипта pop:KeyWord:SetWord }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopKeyWordSetWord

 TkwPopKeyWordWord = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:KeyWord:Word }
  private
   function Word(const aCtx: TtfwContext;
    aKeyWord: TtfwKeyWord): TtfwWord;
    {* Реализация слова скрипта pop:KeyWord:Word }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopKeyWordWord

 TkwPopKeyWordName = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:KeyWord:Name }
  private
   function Name(const aCtx: TtfwContext;
    aKeyWord: TtfwKeyWord): Il3CString;
    {* Реализация слова скрипта pop:KeyWord:Name }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopKeyWordName

 TkwPopKeyWordDictionary = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:KeyWord:Dictionary }
  private
   function Dictionary(const aCtx: TtfwContext;
    aKeyWord: TtfwKeyWord): TtfwDictionary;
    {* Реализация слова скрипта pop:KeyWord:Dictionary }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopKeyWordDictionary

procedure TkwPopKeyWordSetWord.SetWord(const aCtx: TtfwContext;
 aKeyWord: TtfwKeyWord;
 aWord: TtfwWord);
 {* Реализация слова скрипта pop:KeyWord:SetWord }
//#UC START# *5673CF480040_5673CF480040_4DAEF23D00EE_Word_var*
var
 l_Key : TtfwKeyWord;
//#UC END# *5673CF480040_5673CF480040_4DAEF23D00EE_Word_var*
begin
//#UC START# *5673CF480040_5673CF480040_4DAEF23D00EE_Word_impl*
 l_Key := aWord.Key As TtfwKeyWord;
 aKeyWord.SetWord(aCtx, aWord);
 if (l_Key <> nil) then
  aWord.Key := l_Key;
//#UC END# *5673CF480040_5673CF480040_4DAEF23D00EE_Word_impl*
end;//TkwPopKeyWordSetWord.SetWord

class function TkwPopKeyWordSetWord.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:KeyWord:SetWord';
end;//TkwPopKeyWordSetWord.GetWordNameForRegister

function TkwPopKeyWordSetWord.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopKeyWordSetWord.GetResultTypeInfo

function TkwPopKeyWordSetWord.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopKeyWordSetWord.GetAllParamsCount

function TkwPopKeyWordSetWord.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwKeyWord), TypeInfo(TtfwWord)]);
end;//TkwPopKeyWordSetWord.ParamsTypes

procedure TkwPopKeyWordSetWord.DoDoIt(const aCtx: TtfwContext);
var l_aKeyWord: TtfwKeyWord;
var l_aWord: TtfwWord;
begin
 try
  l_aKeyWord := TtfwKeyWord(aCtx.rEngine.PopObjAs(TtfwKeyWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aKeyWord: TtfwKeyWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SetWord(aCtx, l_aKeyWord, l_aWord);
end;//TkwPopKeyWordSetWord.DoDoIt

function TkwPopKeyWordWord.Word(const aCtx: TtfwContext;
 aKeyWord: TtfwKeyWord): TtfwWord;
 {* Реализация слова скрипта pop:KeyWord:Word }
begin
 Result := aKeyWord.Word;
end;//TkwPopKeyWordWord.Word

class function TkwPopKeyWordWord.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:KeyWord:Word';
end;//TkwPopKeyWordWord.GetWordNameForRegister

function TkwPopKeyWordWord.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwWord);
end;//TkwPopKeyWordWord.GetResultTypeInfo

function TkwPopKeyWordWord.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopKeyWordWord.GetAllParamsCount

function TkwPopKeyWordWord.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwKeyWord)]);
end;//TkwPopKeyWordWord.ParamsTypes

procedure TkwPopKeyWordWord.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Word', aCtx);
end;//TkwPopKeyWordWord.SetValuePrim

procedure TkwPopKeyWordWord.DoDoIt(const aCtx: TtfwContext);
var l_aKeyWord: TtfwKeyWord;
begin
 try
  l_aKeyWord := TtfwKeyWord(aCtx.rEngine.PopObjAs(TtfwKeyWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aKeyWord: TtfwKeyWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Word(aCtx, l_aKeyWord));
end;//TkwPopKeyWordWord.DoDoIt

function TkwPopKeyWordName.Name(const aCtx: TtfwContext;
 aKeyWord: TtfwKeyWord): Il3CString;
 {* Реализация слова скрипта pop:KeyWord:Name }
//#UC START# *55895FC003A4_55895FC003A4_4DAEF23D00EE_Word_var*
//#UC END# *55895FC003A4_55895FC003A4_4DAEF23D00EE_Word_var*
begin
//#UC START# *55895FC003A4_55895FC003A4_4DAEF23D00EE_Word_impl*
 Result := aKeyWord.AsCStr;
//#UC END# *55895FC003A4_55895FC003A4_4DAEF23D00EE_Word_impl*
end;//TkwPopKeyWordName.Name

class function TkwPopKeyWordName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:KeyWord:Name';
end;//TkwPopKeyWordName.GetWordNameForRegister

function TkwPopKeyWordName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopKeyWordName.GetResultTypeInfo

function TkwPopKeyWordName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopKeyWordName.GetAllParamsCount

function TkwPopKeyWordName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwKeyWord)]);
end;//TkwPopKeyWordName.ParamsTypes

procedure TkwPopKeyWordName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Name', aCtx);
end;//TkwPopKeyWordName.SetValuePrim

procedure TkwPopKeyWordName.DoDoIt(const aCtx: TtfwContext);
var l_aKeyWord: TtfwKeyWord;
begin
 try
  l_aKeyWord := TtfwKeyWord(aCtx.rEngine.PopObjAs(TtfwKeyWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aKeyWord: TtfwKeyWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(Name(aCtx, l_aKeyWord));
end;//TkwPopKeyWordName.DoDoIt

function TkwPopKeyWordDictionary.Dictionary(const aCtx: TtfwContext;
 aKeyWord: TtfwKeyWord): TtfwDictionary;
 {* Реализация слова скрипта pop:KeyWord:Dictionary }
//#UC START# *55ED650A0047_55ED650A0047_4DAEF23D00EE_Word_var*
//#UC END# *55ED650A0047_55ED650A0047_4DAEF23D00EE_Word_var*
begin
//#UC START# *55ED650A0047_55ED650A0047_4DAEF23D00EE_Word_impl*
 Result := aKeyWord.Dictionary As TtfwDictionary;
//#UC END# *55ED650A0047_55ED650A0047_4DAEF23D00EE_Word_impl*
end;//TkwPopKeyWordDictionary.Dictionary

class function TkwPopKeyWordDictionary.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:KeyWord:Dictionary';
end;//TkwPopKeyWordDictionary.GetWordNameForRegister

function TkwPopKeyWordDictionary.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwDictionary);
end;//TkwPopKeyWordDictionary.GetResultTypeInfo

function TkwPopKeyWordDictionary.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopKeyWordDictionary.GetAllParamsCount

function TkwPopKeyWordDictionary.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwKeyWord)]);
end;//TkwPopKeyWordDictionary.ParamsTypes

procedure TkwPopKeyWordDictionary.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Dictionary', aCtx);
end;//TkwPopKeyWordDictionary.SetValuePrim

procedure TkwPopKeyWordDictionary.DoDoIt(const aCtx: TtfwContext);
var l_aKeyWord: TtfwKeyWord;
begin
 try
  l_aKeyWord := TtfwKeyWord(aCtx.rEngine.PopObjAs(TtfwKeyWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aKeyWord: TtfwKeyWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Dictionary(aCtx, l_aKeyWord));
end;//TkwPopKeyWordDictionary.DoDoIt

initialization
 TkwPopKeyWordSetWord.RegisterInEngine;
 {* Регистрация pop_KeyWord_SetWord }
 TkwPopKeyWordWord.RegisterInEngine;
 {* Регистрация pop_KeyWord_Word }
 TkwPopKeyWordName.RegisterInEngine;
 {* Регистрация pop_KeyWord_Name }
 TkwPopKeyWordDictionary.RegisterInEngine;
 {* Регистрация pop_KeyWord_Dictionary }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwKeyWord));
 {* Регистрация типа TtfwKeyWord }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* Регистрация типа TtfwWord }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwDictionary));
 {* Регистрация типа TtfwDictionary }
{$IfEnd} // NOT Defined(NoScripts)

end.
