unit KeyWordPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\KeyWordPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwScriptingInterfaces
 , l3Interfaces
 , tfwDictionary
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
 , tfwScriptEngineExInterfaces
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopKeyWordSetWord = {final} class(TtfwClassLike)
  {* Слово скрипта pop:KeyWord:SetWord
*Пример:*
[code]
 aWord aKeyWord pop:KeyWord:SetWord
[code]  }
  private
   procedure SetWord(const aCtx: TtfwContext;
    aKeyWord: TtfwKeyWord;
    aWord: TtfwWord);
    {* Реализация слова скрипта pop:KeyWord:SetWord }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopKeyWordSetWord

 TkwPopKeyWordWord = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:KeyWord:Word
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 aKeyWord pop:KeyWord:Word >>> l_TtfwWord
[code]  }
  private
   function Word(const aCtx: TtfwContext;
    aKeyWord: TtfwKeyWord): TtfwWord;
    {* Реализация слова скрипта pop:KeyWord:Word }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopKeyWordWord

 TkwPopKeyWordName = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:KeyWord:Name
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aKeyWord pop:KeyWord:Name >>> l_Il3CString
[code]  }
  private
   function Name(const aCtx: TtfwContext;
    aKeyWord: TtfwKeyWord): Il3CString;
    {* Реализация слова скрипта pop:KeyWord:Name }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopKeyWordName

 TkwPopKeyWordDictionary = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:KeyWord:Dictionary
*Тип результата:* TtfwDictionary
*Пример:*
[code]
OBJECT VAR l_TtfwDictionary
 aKeyWord pop:KeyWord:Dictionary >>> l_TtfwDictionary
[code]  }
  private
   function Dictionary(const aCtx: TtfwContext;
    aKeyWord: TtfwKeyWord): TtfwDictionary;
    {* Реализация слова скрипта pop:KeyWord:Dictionary }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopKeyWordDictionary

procedure TkwPopKeyWordSetWord.SetWord(const aCtx: TtfwContext;
 aKeyWord: TtfwKeyWord;
 aWord: TtfwWord);
 {* Реализация слова скрипта pop:KeyWord:SetWord }
//#UC START# *D7C9A8EDA8B8_DA7B06A59C14_var*
var
 l_Key : TtfwKeyWord;
//#UC END# *D7C9A8EDA8B8_DA7B06A59C14_var*
begin
//#UC START# *D7C9A8EDA8B8_DA7B06A59C14_impl*
 l_Key := aWord.Key As TtfwKeyWord;
 aKeyWord.SetWord(aCtx, aWord);
 if (l_Key <> nil) then
  aWord.Key := l_Key;
//#UC END# *D7C9A8EDA8B8_DA7B06A59C14_impl*
end;//TkwPopKeyWordSetWord.SetWord

procedure TkwPopKeyWordSetWord.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DA7B06A59C14_var*
//#UC END# *4DAEEDE10285_DA7B06A59C14_var*
begin
//#UC START# *4DAEEDE10285_DA7B06A59C14_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DA7B06A59C14_impl*
end;//TkwPopKeyWordSetWord.DoDoIt

class function TkwPopKeyWordSetWord.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:KeyWord:SetWord';
end;//TkwPopKeyWordSetWord.GetWordNameForRegister

function TkwPopKeyWordSetWord.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwPopKeyWordSetWord.GetResultTypeInfo

function TkwPopKeyWordSetWord.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopKeyWordSetWord.GetAllParamsCount

function TkwPopKeyWordSetWord.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_DA7B06A59C14_var*
//#UC END# *5617F4D00243_DA7B06A59C14_var*
begin
//#UC START# *5617F4D00243_DA7B06A59C14_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_DA7B06A59C14_impl*
end;//TkwPopKeyWordSetWord.ParamsTypes

function TkwPopKeyWordWord.Word(const aCtx: TtfwContext;
 aKeyWord: TtfwKeyWord): TtfwWord;
 {* Реализация слова скрипта pop:KeyWord:Word }
//#UC START# *A55E297B02BE_909E3EF864CC_var*
//#UC END# *A55E297B02BE_909E3EF864CC_var*
begin
//#UC START# *A55E297B02BE_909E3EF864CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *A55E297B02BE_909E3EF864CC_impl*
end;//TkwPopKeyWordWord.Word

procedure TkwPopKeyWordWord.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_909E3EF864CC_var*
//#UC END# *4DAEEDE10285_909E3EF864CC_var*
begin
//#UC START# *4DAEEDE10285_909E3EF864CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_909E3EF864CC_impl*
end;//TkwPopKeyWordWord.DoDoIt

class function TkwPopKeyWordWord.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:KeyWord:Word';
end;//TkwPopKeyWordWord.GetWordNameForRegister

procedure TkwPopKeyWordWord.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_909E3EF864CC_var*
//#UC END# *52D00B00031A_909E3EF864CC_var*
begin
//#UC START# *52D00B00031A_909E3EF864CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_909E3EF864CC_impl*
end;//TkwPopKeyWordWord.SetValuePrim

function TkwPopKeyWordWord.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwPopKeyWordWord.GetResultTypeInfo

function TkwPopKeyWordWord.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopKeyWordWord.GetAllParamsCount

function TkwPopKeyWordWord.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_909E3EF864CC_var*
//#UC END# *5617F4D00243_909E3EF864CC_var*
begin
//#UC START# *5617F4D00243_909E3EF864CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_909E3EF864CC_impl*
end;//TkwPopKeyWordWord.ParamsTypes

function TkwPopKeyWordName.Name(const aCtx: TtfwContext;
 aKeyWord: TtfwKeyWord): Il3CString;
 {* Реализация слова скрипта pop:KeyWord:Name }
//#UC START# *23CD12DE8461_F4F627A63039_var*
//#UC END# *23CD12DE8461_F4F627A63039_var*
begin
//#UC START# *23CD12DE8461_F4F627A63039_impl*
 Result := aKeyWord.AsCStr;
//#UC END# *23CD12DE8461_F4F627A63039_impl*
end;//TkwPopKeyWordName.Name

procedure TkwPopKeyWordName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F4F627A63039_var*
//#UC END# *4DAEEDE10285_F4F627A63039_var*
begin
//#UC START# *4DAEEDE10285_F4F627A63039_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F4F627A63039_impl*
end;//TkwPopKeyWordName.DoDoIt

class function TkwPopKeyWordName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:KeyWord:Name';
end;//TkwPopKeyWordName.GetWordNameForRegister

procedure TkwPopKeyWordName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_F4F627A63039_var*
//#UC END# *52D00B00031A_F4F627A63039_var*
begin
//#UC START# *52D00B00031A_F4F627A63039_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_F4F627A63039_impl*
end;//TkwPopKeyWordName.SetValuePrim

function TkwPopKeyWordName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwPopKeyWordName.GetResultTypeInfo

function TkwPopKeyWordName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopKeyWordName.GetAllParamsCount

function TkwPopKeyWordName.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F4F627A63039_var*
//#UC END# *5617F4D00243_F4F627A63039_var*
begin
//#UC START# *5617F4D00243_F4F627A63039_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F4F627A63039_impl*
end;//TkwPopKeyWordName.ParamsTypes

function TkwPopKeyWordDictionary.Dictionary(const aCtx: TtfwContext;
 aKeyWord: TtfwKeyWord): TtfwDictionary;
 {* Реализация слова скрипта pop:KeyWord:Dictionary }
//#UC START# *CF988D0FA0BC_668B733FDAFB_var*
//#UC END# *CF988D0FA0BC_668B733FDAFB_var*
begin
//#UC START# *CF988D0FA0BC_668B733FDAFB_impl*
 Result := aKeyWord.Dictionary As TtfwDictionary;
//#UC END# *CF988D0FA0BC_668B733FDAFB_impl*
end;//TkwPopKeyWordDictionary.Dictionary

procedure TkwPopKeyWordDictionary.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_668B733FDAFB_var*
//#UC END# *4DAEEDE10285_668B733FDAFB_var*
begin
//#UC START# *4DAEEDE10285_668B733FDAFB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_668B733FDAFB_impl*
end;//TkwPopKeyWordDictionary.DoDoIt

class function TkwPopKeyWordDictionary.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:KeyWord:Dictionary';
end;//TkwPopKeyWordDictionary.GetWordNameForRegister

procedure TkwPopKeyWordDictionary.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_668B733FDAFB_var*
//#UC END# *52D00B00031A_668B733FDAFB_var*
begin
//#UC START# *52D00B00031A_668B733FDAFB_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_668B733FDAFB_impl*
end;//TkwPopKeyWordDictionary.SetValuePrim

function TkwPopKeyWordDictionary.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwPopKeyWordDictionary.GetResultTypeInfo

function TkwPopKeyWordDictionary.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopKeyWordDictionary.GetAllParamsCount

function TkwPopKeyWordDictionary.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_668B733FDAFB_var*
//#UC END# *5617F4D00243_668B733FDAFB_var*
begin
//#UC START# *5617F4D00243_668B733FDAFB_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_668B733FDAFB_impl*
end;//TkwPopKeyWordDictionary.ParamsTypes

initialization
 TkwPopKeyWordSetWord.RegisterInEngine;
 {* Регистрация pop_KeyWord_SetWord }
 TkwPopKeyWordWord.RegisterInEngine;
 {* Регистрация pop_KeyWord_Word }
 TkwPopKeyWordName.RegisterInEngine;
 {* Регистрация pop_KeyWord_Name }
 TkwPopKeyWordDictionary.RegisterInEngine;
 {* Регистрация pop_KeyWord_Dictionary }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
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
