unit tfwDictionaryExWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryExWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwDictionaryEx
 , l3Interfaces
 , tfwScriptingInterfaces
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwDictionaryDataIteratorPrim
 , tfwExportedDictionariesIterator
 , tfwUsedDictionariesIterator
 , l3DateSt
 {$If Defined(seCacheDict)}
 , tfwMainDictionaryCache
 {$IfEnd} // Defined(seCacheDict)
 {$If Defined(seCacheDict)}
 , tfwDictionaryCache
 {$IfEnd} // Defined(seCacheDict)
 , tfwMainDictionary
 , tfwMembersIterator
 , tfwDictionaryWordsPack
 , tfwScriptEngineExInterfaces
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 //#UC START# *EDB2EC981E9Aci*
 //#UC END# *EDB2EC981E9Aci*
 //#UC START# *EDB2EC981E9Acit*
 //#UC END# *EDB2EC981E9Acit*
 TtfwDictionaryExWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 //#UC START# *EDB2EC981E9Apubl*
 //#UC END# *EDB2EC981E9Apubl*
 end;//TtfwDictionaryExWordsPackResNameGetter

 TkwPopDictionaryExFileName = {final} class(TtfwClassLike)
  {* Слово скрипта pop:DictionaryEx:FileName
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aDictionaryEx pop:DictionaryEx:FileName >>> l_Il3CString
[code]  }
  private
   function FileName(const aCtx: TtfwContext;
    aDictionaryEx: TtfwDictionaryEx): Il3CString;
    {* Реализация слова скрипта pop:DictionaryEx:FileName }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopDictionaryExFileName

 TkwPopDictionaryExUsedDictionaries = {final} class(TtfwClassLike)
  {* Слово скрипта pop:DictionaryEx:UsedDictionaries
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 aDictionaryEx pop:DictionaryEx:UsedDictionaries >>> l_ItfwValueList
[code]  }
  private
   function UsedDictionaries(const aCtx: TtfwContext;
    aDictionaryEx: TtfwDictionaryEx): ItfwValueList;
    {* Реализация слова скрипта pop:DictionaryEx:UsedDictionaries }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopDictionaryExUsedDictionaries

 TkwPopDictionaryExExportedDictionaries = {final} class(TtfwClassLike)
  {* Слово скрипта pop:DictionaryEx:ExportedDictionaries
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 aDictionaryEx pop:DictionaryEx:ExportedDictionaries >>> l_ItfwValueList
[code]  }
  private
   function ExportedDictionaries(const aCtx: TtfwContext;
    aDictionaryEx: TtfwDictionaryEx): ItfwValueList;
    {* Реализация слова скрипта pop:DictionaryEx:ExportedDictionaries }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopDictionaryExExportedDictionaries

 TkwPopDictionaryExExportDictionary = {final} class(TtfwClassLike)
  {* Слово скрипта pop:DictionaryEx:ExportDictionary
*Пример:*
[code]
 aDictionary aDictionaryEx pop:DictionaryEx:ExportDictionary
[code]  }
  private
   procedure ExportDictionary(const aCtx: TtfwContext;
    aDictionaryEx: TtfwDictionaryEx;
    aDictionary: TtfwDictionaryEx);
    {* Реализация слова скрипта pop:DictionaryEx:ExportDictionary }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopDictionaryExExportDictionary

 TkwPopDictionaryExUseDictionary = {final} class(TtfwClassLike)
  {* Слово скрипта pop:DictionaryEx:UseDictionary
*Пример:*
[code]
 aDictionary aDictionaryEx pop:DictionaryEx:UseDictionary
[code]  }
  private
   procedure UseDictionary(const aCtx: TtfwContext;
    aDictionaryEx: TtfwDictionaryEx;
    aDictionary: TtfwDictionaryEx);
    {* Реализация слова скрипта pop:DictionaryEx:UseDictionary }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopDictionaryExUseDictionary

 TkwPopDictionaryExFileDateTime = {final} class(TtfwClassLike)
  {* Слово скрипта pop:DictionaryEx:FileDateTime
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aDictionaryEx pop:DictionaryEx:FileDateTime >>> l_String
[code]  }
  private
   function FileDateTime(const aCtx: TtfwContext;
    aDictionaryEx: TtfwDictionaryEx): AnsiString;
    {* Реализация слова скрипта pop:DictionaryEx:FileDateTime }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopDictionaryExFileDateTime

 TkwPopDictionaryExRemoveFromCache = {final} class(TtfwClassLike)
  {* Слово скрипта pop:DictionaryEx:RemoveFromCache
[panel]Удаляет словарь из кешей скомпилированных словарей[panel]
*Пример:*
[code]
 aDictionaryEx pop:DictionaryEx:RemoveFromCache
[code]  }
  private
   procedure RemoveFromCache(const aCtx: TtfwContext;
    aDictionaryEx: TtfwDictionaryEx);
    {* Реализация слова скрипта pop:DictionaryEx:RemoveFromCache }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopDictionaryExRemoveFromCache

class function TtfwDictionaryExWordsPackResNameGetter.ResName: AnsiString;
begin
  Result := 'tfwDictionaryExWordsPack';
end;//TtfwDictionaryExWordsPackResNameGetter.ResName

 {$R tfwDictionaryExWordsPack.res}

function TkwPopDictionaryExFileName.FileName(const aCtx: TtfwContext;
 aDictionaryEx: TtfwDictionaryEx): Il3CString;
 {* Реализация слова скрипта pop:DictionaryEx:FileName }
//#UC START# *770C15F2EC2C_06E8451D9B30_var*
//#UC END# *770C15F2EC2C_06E8451D9B30_var*
begin
//#UC START# *770C15F2EC2C_06E8451D9B30_impl*
 Result := aDictionaryEx.FileName;
//#UC END# *770C15F2EC2C_06E8451D9B30_impl*
end;//TkwPopDictionaryExFileName.FileName

procedure TkwPopDictionaryExFileName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_06E8451D9B30_var*
//#UC END# *4DAEEDE10285_06E8451D9B30_var*
begin
//#UC START# *4DAEEDE10285_06E8451D9B30_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_06E8451D9B30_impl*
end;//TkwPopDictionaryExFileName.DoDoIt

class function TkwPopDictionaryExFileName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:DictionaryEx:FileName';
end;//TkwPopDictionaryExFileName.GetWordNameForRegister

function TkwPopDictionaryExFileName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopDictionaryExFileName.GetResultTypeInfo

function TkwPopDictionaryExFileName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopDictionaryExFileName.GetAllParamsCount

function TkwPopDictionaryExFileName.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_06E8451D9B30_var*
//#UC END# *5617F4D00243_06E8451D9B30_var*
begin
//#UC START# *5617F4D00243_06E8451D9B30_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_06E8451D9B30_impl*
end;//TkwPopDictionaryExFileName.ParamsTypes

function TkwPopDictionaryExUsedDictionaries.UsedDictionaries(const aCtx: TtfwContext;
 aDictionaryEx: TtfwDictionaryEx): ItfwValueList;
 {* Реализация слова скрипта pop:DictionaryEx:UsedDictionaries }
//#UC START# *2350C9F61A78_B94C35EBE3DE_var*
//#UC END# *2350C9F61A78_B94C35EBE3DE_var*
begin
//#UC START# *2350C9F61A78_B94C35EBE3DE_impl*
 Result := TtfwUsedDictionariesIterator.Make(aDictionaryEx);
//#UC END# *2350C9F61A78_B94C35EBE3DE_impl*
end;//TkwPopDictionaryExUsedDictionaries.UsedDictionaries

procedure TkwPopDictionaryExUsedDictionaries.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B94C35EBE3DE_var*
//#UC END# *4DAEEDE10285_B94C35EBE3DE_var*
begin
//#UC START# *4DAEEDE10285_B94C35EBE3DE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B94C35EBE3DE_impl*
end;//TkwPopDictionaryExUsedDictionaries.DoDoIt

class function TkwPopDictionaryExUsedDictionaries.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:DictionaryEx:UsedDictionaries';
end;//TkwPopDictionaryExUsedDictionaries.GetWordNameForRegister

function TkwPopDictionaryExUsedDictionaries.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwPopDictionaryExUsedDictionaries.GetResultTypeInfo

function TkwPopDictionaryExUsedDictionaries.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopDictionaryExUsedDictionaries.GetAllParamsCount

function TkwPopDictionaryExUsedDictionaries.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_B94C35EBE3DE_var*
//#UC END# *5617F4D00243_B94C35EBE3DE_var*
begin
//#UC START# *5617F4D00243_B94C35EBE3DE_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_B94C35EBE3DE_impl*
end;//TkwPopDictionaryExUsedDictionaries.ParamsTypes

function TkwPopDictionaryExExportedDictionaries.ExportedDictionaries(const aCtx: TtfwContext;
 aDictionaryEx: TtfwDictionaryEx): ItfwValueList;
 {* Реализация слова скрипта pop:DictionaryEx:ExportedDictionaries }
//#UC START# *E6BE6C32473B_6AF5E6295E46_var*
//#UC END# *E6BE6C32473B_6AF5E6295E46_var*
begin
//#UC START# *E6BE6C32473B_6AF5E6295E46_impl*
 Result := TtfwExportedDictionariesIterator.Make(aDictionaryEx);
//#UC END# *E6BE6C32473B_6AF5E6295E46_impl*
end;//TkwPopDictionaryExExportedDictionaries.ExportedDictionaries

procedure TkwPopDictionaryExExportedDictionaries.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6AF5E6295E46_var*
//#UC END# *4DAEEDE10285_6AF5E6295E46_var*
begin
//#UC START# *4DAEEDE10285_6AF5E6295E46_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6AF5E6295E46_impl*
end;//TkwPopDictionaryExExportedDictionaries.DoDoIt

class function TkwPopDictionaryExExportedDictionaries.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:DictionaryEx:ExportedDictionaries';
end;//TkwPopDictionaryExExportedDictionaries.GetWordNameForRegister

function TkwPopDictionaryExExportedDictionaries.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwPopDictionaryExExportedDictionaries.GetResultTypeInfo

function TkwPopDictionaryExExportedDictionaries.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopDictionaryExExportedDictionaries.GetAllParamsCount

function TkwPopDictionaryExExportedDictionaries.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_6AF5E6295E46_var*
//#UC END# *5617F4D00243_6AF5E6295E46_var*
begin
//#UC START# *5617F4D00243_6AF5E6295E46_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_6AF5E6295E46_impl*
end;//TkwPopDictionaryExExportedDictionaries.ParamsTypes

procedure TkwPopDictionaryExExportDictionary.ExportDictionary(const aCtx: TtfwContext;
 aDictionaryEx: TtfwDictionaryEx;
 aDictionary: TtfwDictionaryEx);
 {* Реализация слова скрипта pop:DictionaryEx:ExportDictionary }
//#UC START# *E5F49D0B62DF_4A28BCF78342_var*
//#UC END# *E5F49D0B62DF_4A28BCF78342_var*
begin
//#UC START# *E5F49D0B62DF_4A28BCF78342_impl*
 aDictionaryEx.ExportDictionary(aDictionary);
//#UC END# *E5F49D0B62DF_4A28BCF78342_impl*
end;//TkwPopDictionaryExExportDictionary.ExportDictionary

procedure TkwPopDictionaryExExportDictionary.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4A28BCF78342_var*
//#UC END# *4DAEEDE10285_4A28BCF78342_var*
begin
//#UC START# *4DAEEDE10285_4A28BCF78342_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4A28BCF78342_impl*
end;//TkwPopDictionaryExExportDictionary.DoDoIt

class function TkwPopDictionaryExExportDictionary.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:DictionaryEx:ExportDictionary';
end;//TkwPopDictionaryExExportDictionary.GetWordNameForRegister

function TkwPopDictionaryExExportDictionary.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopDictionaryExExportDictionary.GetResultTypeInfo

function TkwPopDictionaryExExportDictionary.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopDictionaryExExportDictionary.GetAllParamsCount

function TkwPopDictionaryExExportDictionary.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_4A28BCF78342_var*
//#UC END# *5617F4D00243_4A28BCF78342_var*
begin
//#UC START# *5617F4D00243_4A28BCF78342_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_4A28BCF78342_impl*
end;//TkwPopDictionaryExExportDictionary.ParamsTypes

procedure TkwPopDictionaryExUseDictionary.UseDictionary(const aCtx: TtfwContext;
 aDictionaryEx: TtfwDictionaryEx;
 aDictionary: TtfwDictionaryEx);
 {* Реализация слова скрипта pop:DictionaryEx:UseDictionary }
//#UC START# *D222E866EFCD_F63A2FD719D9_var*
//#UC END# *D222E866EFCD_F63A2FD719D9_var*
begin
//#UC START# *D222E866EFCD_F63A2FD719D9_impl*
 aDictionaryEx.UseDictionary(aDictionary);
//#UC END# *D222E866EFCD_F63A2FD719D9_impl*
end;//TkwPopDictionaryExUseDictionary.UseDictionary

procedure TkwPopDictionaryExUseDictionary.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F63A2FD719D9_var*
//#UC END# *4DAEEDE10285_F63A2FD719D9_var*
begin
//#UC START# *4DAEEDE10285_F63A2FD719D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F63A2FD719D9_impl*
end;//TkwPopDictionaryExUseDictionary.DoDoIt

class function TkwPopDictionaryExUseDictionary.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:DictionaryEx:UseDictionary';
end;//TkwPopDictionaryExUseDictionary.GetWordNameForRegister

function TkwPopDictionaryExUseDictionary.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopDictionaryExUseDictionary.GetResultTypeInfo

function TkwPopDictionaryExUseDictionary.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopDictionaryExUseDictionary.GetAllParamsCount

function TkwPopDictionaryExUseDictionary.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F63A2FD719D9_var*
//#UC END# *5617F4D00243_F63A2FD719D9_var*
begin
//#UC START# *5617F4D00243_F63A2FD719D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F63A2FD719D9_impl*
end;//TkwPopDictionaryExUseDictionary.ParamsTypes

function TkwPopDictionaryExFileDateTime.FileDateTime(const aCtx: TtfwContext;
 aDictionaryEx: TtfwDictionaryEx): AnsiString;
 {* Реализация слова скрипта pop:DictionaryEx:FileDateTime }
//#UC START# *9371B1AA3DFC_308455C44800_var*
//#UC END# *9371B1AA3DFC_308455C44800_var*
begin
//#UC START# *9371B1AA3DFC_308455C44800_impl*
 Result := l3DateTimeToStr(aDictionaryEx.FileDateTime);
//#UC END# *9371B1AA3DFC_308455C44800_impl*
end;//TkwPopDictionaryExFileDateTime.FileDateTime

procedure TkwPopDictionaryExFileDateTime.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_308455C44800_var*
//#UC END# *4DAEEDE10285_308455C44800_var*
begin
//#UC START# *4DAEEDE10285_308455C44800_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_308455C44800_impl*
end;//TkwPopDictionaryExFileDateTime.DoDoIt

class function TkwPopDictionaryExFileDateTime.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:DictionaryEx:FileDateTime';
end;//TkwPopDictionaryExFileDateTime.GetWordNameForRegister

function TkwPopDictionaryExFileDateTime.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopDictionaryExFileDateTime.GetResultTypeInfo

function TkwPopDictionaryExFileDateTime.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopDictionaryExFileDateTime.GetAllParamsCount

function TkwPopDictionaryExFileDateTime.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_308455C44800_var*
//#UC END# *5617F4D00243_308455C44800_var*
begin
//#UC START# *5617F4D00243_308455C44800_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_308455C44800_impl*
end;//TkwPopDictionaryExFileDateTime.ParamsTypes

procedure TkwPopDictionaryExRemoveFromCache.RemoveFromCache(const aCtx: TtfwContext;
 aDictionaryEx: TtfwDictionaryEx);
 {* Реализация слова скрипта pop:DictionaryEx:RemoveFromCache }
//#UC START# *E3AF4D2A35E0_B74ACC6F66BC_var*
{$IfDef seCacheDict}
var
 l_D : TtfwDictionaryEx;
{$EndIf seCacheDict}
//#UC END# *E3AF4D2A35E0_B74ACC6F66BC_var*
begin
//#UC START# *E3AF4D2A35E0_B74ACC6F66BC_impl*
 {$IfDef seCacheDict}
 l_D := aDictionaryEx.Use;
 try
  TtfwDictionaryCache.Instance.Remove(l_D);
  if (l_D Is TtfwMainDictionary) then
   TtfwMainDictionaryCache.Instance.Remove(TtfwMainDictionary(l_D));
 finally
  FreeAndNil(l_D);
 end;//try..finally
 {$EndIf seCacheDict}
//#UC END# *E3AF4D2A35E0_B74ACC6F66BC_impl*
end;//TkwPopDictionaryExRemoveFromCache.RemoveFromCache

procedure TkwPopDictionaryExRemoveFromCache.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B74ACC6F66BC_var*
//#UC END# *4DAEEDE10285_B74ACC6F66BC_var*
begin
//#UC START# *4DAEEDE10285_B74ACC6F66BC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B74ACC6F66BC_impl*
end;//TkwPopDictionaryExRemoveFromCache.DoDoIt

class function TkwPopDictionaryExRemoveFromCache.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:DictionaryEx:RemoveFromCache';
end;//TkwPopDictionaryExRemoveFromCache.GetWordNameForRegister

function TkwPopDictionaryExRemoveFromCache.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopDictionaryExRemoveFromCache.GetResultTypeInfo

function TkwPopDictionaryExRemoveFromCache.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopDictionaryExRemoveFromCache.GetAllParamsCount

function TkwPopDictionaryExRemoveFromCache.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_B74ACC6F66BC_var*
//#UC END# *5617F4D00243_B74ACC6F66BC_var*
begin
//#UC START# *5617F4D00243_B74ACC6F66BC_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_B74ACC6F66BC_impl*
end;//TkwPopDictionaryExRemoveFromCache.ParamsTypes

initialization
 TtfwDictionaryExWordsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TkwPopDictionaryExFileName.RegisterInEngine;
 {* Регистрация pop_DictionaryEx_FileName }
 TkwPopDictionaryExUsedDictionaries.RegisterInEngine;
 {* Регистрация pop_DictionaryEx_UsedDictionaries }
 TkwPopDictionaryExExportedDictionaries.RegisterInEngine;
 {* Регистрация pop_DictionaryEx_ExportedDictionaries }
 TkwPopDictionaryExExportDictionary.RegisterInEngine;
 {* Регистрация pop_DictionaryEx_ExportDictionary }
 TkwPopDictionaryExUseDictionary.RegisterInEngine;
 {* Регистрация pop_DictionaryEx_UseDictionary }
 TkwPopDictionaryExFileDateTime.RegisterInEngine;
 {* Регистрация pop_DictionaryEx_FileDateTime }
 TkwPopDictionaryExRemoveFromCache.RegisterInEngine;
 {* Регистрация pop_DictionaryEx_RemoveFromCache }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwDictionaryEx));
 {* Регистрация типа TtfwDictionaryEx }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwValueList));
 {* Регистрация типа ItfwValueList }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа String }
{$IfEnd} // NOT Defined(NoScripts)

end.
