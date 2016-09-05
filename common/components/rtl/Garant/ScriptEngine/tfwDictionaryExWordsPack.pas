unit tfwDictionaryExWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryExWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "tfwDictionaryExWordsPack" MUID: (55AE5A8C035D)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

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
 , tfwDictionaryEx
 , tfwClassLike
 , l3Interfaces
 , tfwScriptingInterfaces
 , TypInfo
 , tfwAxiomaticsResNameGetter
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
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *55AE5A8C035Dimpl_uses*
 //#UC END# *55AE5A8C035Dimpl_uses*
;

type
 TkwPopDictionaryExFileName = {final} class(TtfwClassLike)
  {* Слово скрипта pop:DictionaryEx:FileName }
  private
   function FileName(const aCtx: TtfwContext;
    aDictionaryEx: TtfwDictionaryEx): Il3CString;
    {* Реализация слова скрипта pop:DictionaryEx:FileName }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopDictionaryExFileName

 TkwPopDictionaryExUsedDictionaries = {final} class(TtfwClassLike)
  {* Слово скрипта pop:DictionaryEx:UsedDictionaries }
  private
   function UsedDictionaries(const aCtx: TtfwContext;
    aDictionaryEx: TtfwDictionaryEx): ItfwValueList;
    {* Реализация слова скрипта pop:DictionaryEx:UsedDictionaries }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopDictionaryExUsedDictionaries

 TkwPopDictionaryExExportedDictionaries = {final} class(TtfwClassLike)
  {* Слово скрипта pop:DictionaryEx:ExportedDictionaries }
  private
   function ExportedDictionaries(const aCtx: TtfwContext;
    aDictionaryEx: TtfwDictionaryEx): ItfwValueList;
    {* Реализация слова скрипта pop:DictionaryEx:ExportedDictionaries }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopDictionaryExExportedDictionaries

 TkwPopDictionaryExExportDictionary = {final} class(TtfwClassLike)
  {* Слово скрипта pop:DictionaryEx:ExportDictionary }
  private
   procedure ExportDictionary(const aCtx: TtfwContext;
    aDictionaryEx: TtfwDictionaryEx;
    aDictionary: TtfwDictionaryEx);
    {* Реализация слова скрипта pop:DictionaryEx:ExportDictionary }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopDictionaryExExportDictionary

 TkwPopDictionaryExUseDictionary = {final} class(TtfwClassLike)
  {* Слово скрипта pop:DictionaryEx:UseDictionary }
  private
   procedure UseDictionary(const aCtx: TtfwContext;
    aDictionaryEx: TtfwDictionaryEx;
    aDictionary: TtfwDictionaryEx);
    {* Реализация слова скрипта pop:DictionaryEx:UseDictionary }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopDictionaryExUseDictionary

 TkwPopDictionaryExFileDateTime = {final} class(TtfwClassLike)
  {* Слово скрипта pop:DictionaryEx:FileDateTime }
  private
   function FileDateTime(const aCtx: TtfwContext;
    aDictionaryEx: TtfwDictionaryEx): AnsiString;
    {* Реализация слова скрипта pop:DictionaryEx:FileDateTime }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopDictionaryExFileDateTime

 TkwPopDictionaryExRemoveFromCache = {final} class(TtfwClassLike)
  {* Слово скрипта pop:DictionaryEx:RemoveFromCache }
  private
   procedure RemoveFromCache(const aCtx: TtfwContext;
    aDictionaryEx: TtfwDictionaryEx);
    {* Реализация слова скрипта pop:DictionaryEx:RemoveFromCache }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopDictionaryExRemoveFromCache

 TtfwDictionaryExWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TtfwDictionaryExWordsPackResNameGetter

function TkwPopDictionaryExFileName.FileName(const aCtx: TtfwContext;
 aDictionaryEx: TtfwDictionaryEx): Il3CString;
 {* Реализация слова скрипта pop:DictionaryEx:FileName }
//#UC START# *55AE62910135_55AE62910135_559E8B2E0385_Word_var*
//#UC END# *55AE62910135_55AE62910135_559E8B2E0385_Word_var*
begin
//#UC START# *55AE62910135_55AE62910135_559E8B2E0385_Word_impl*
 if (aDictionaryEx = nil) then
  Result := TtfwCStringFactory.C('')
 else
  Result := aDictionaryEx.FileName;
//#UC END# *55AE62910135_55AE62910135_559E8B2E0385_Word_impl*
end;//TkwPopDictionaryExFileName.FileName

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
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwDictionaryEx)]);
end;//TkwPopDictionaryExFileName.ParamsTypes

procedure TkwPopDictionaryExFileName.DoDoIt(const aCtx: TtfwContext);
var l_aDictionaryEx: TtfwDictionaryEx;
begin
 try
  l_aDictionaryEx := TtfwDictionaryEx(aCtx.rEngine.PopObjAs(TtfwDictionaryEx));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDictionaryEx: TtfwDictionaryEx : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(FileName(aCtx, l_aDictionaryEx));
end;//TkwPopDictionaryExFileName.DoDoIt

function TkwPopDictionaryExUsedDictionaries.UsedDictionaries(const aCtx: TtfwContext;
 aDictionaryEx: TtfwDictionaryEx): ItfwValueList;
 {* Реализация слова скрипта pop:DictionaryEx:UsedDictionaries }
//#UC START# *55AE6569010C_55AE6569010C_559E8B2E0385_Word_var*
//#UC END# *55AE6569010C_55AE6569010C_559E8B2E0385_Word_var*
begin
//#UC START# *55AE6569010C_55AE6569010C_559E8B2E0385_Word_impl*
 Result := TtfwUsedDictionariesIterator.Make(aDictionaryEx);
//#UC END# *55AE6569010C_55AE6569010C_559E8B2E0385_Word_impl*
end;//TkwPopDictionaryExUsedDictionaries.UsedDictionaries

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
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwDictionaryEx)]);
end;//TkwPopDictionaryExUsedDictionaries.ParamsTypes

procedure TkwPopDictionaryExUsedDictionaries.DoDoIt(const aCtx: TtfwContext);
var l_aDictionaryEx: TtfwDictionaryEx;
begin
 try
  l_aDictionaryEx := TtfwDictionaryEx(aCtx.rEngine.PopObjAs(TtfwDictionaryEx));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDictionaryEx: TtfwDictionaryEx : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushList(UsedDictionaries(aCtx, l_aDictionaryEx));
end;//TkwPopDictionaryExUsedDictionaries.DoDoIt

function TkwPopDictionaryExExportedDictionaries.ExportedDictionaries(const aCtx: TtfwContext;
 aDictionaryEx: TtfwDictionaryEx): ItfwValueList;
 {* Реализация слова скрипта pop:DictionaryEx:ExportedDictionaries }
//#UC START# *55AE657A03C8_55AE657A03C8_559E8B2E0385_Word_var*
//#UC END# *55AE657A03C8_55AE657A03C8_559E8B2E0385_Word_var*
begin
//#UC START# *55AE657A03C8_55AE657A03C8_559E8B2E0385_Word_impl*
 Result := TtfwExportedDictionariesIterator.Make(aDictionaryEx);
//#UC END# *55AE657A03C8_55AE657A03C8_559E8B2E0385_Word_impl*
end;//TkwPopDictionaryExExportedDictionaries.ExportedDictionaries

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
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwDictionaryEx)]);
end;//TkwPopDictionaryExExportedDictionaries.ParamsTypes

procedure TkwPopDictionaryExExportedDictionaries.DoDoIt(const aCtx: TtfwContext);
var l_aDictionaryEx: TtfwDictionaryEx;
begin
 try
  l_aDictionaryEx := TtfwDictionaryEx(aCtx.rEngine.PopObjAs(TtfwDictionaryEx));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDictionaryEx: TtfwDictionaryEx : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushList(ExportedDictionaries(aCtx, l_aDictionaryEx));
end;//TkwPopDictionaryExExportedDictionaries.DoDoIt

procedure TkwPopDictionaryExExportDictionary.ExportDictionary(const aCtx: TtfwContext;
 aDictionaryEx: TtfwDictionaryEx;
 aDictionary: TtfwDictionaryEx);
 {* Реализация слова скрипта pop:DictionaryEx:ExportDictionary }
//#UC START# *55AE65FD001D_55AE65FD001D_559E8B2E0385_Word_var*
//#UC END# *55AE65FD001D_55AE65FD001D_559E8B2E0385_Word_var*
begin
//#UC START# *55AE65FD001D_55AE65FD001D_559E8B2E0385_Word_impl*
 aDictionaryEx.ExportDictionary(aDictionary);
//#UC END# *55AE65FD001D_55AE65FD001D_559E8B2E0385_Word_impl*
end;//TkwPopDictionaryExExportDictionary.ExportDictionary

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
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwDictionaryEx), TypeInfo(TtfwDictionaryEx)]);
end;//TkwPopDictionaryExExportDictionary.ParamsTypes

procedure TkwPopDictionaryExExportDictionary.DoDoIt(const aCtx: TtfwContext);
var l_aDictionaryEx: TtfwDictionaryEx;
var l_aDictionary: TtfwDictionaryEx;
begin
 try
  l_aDictionaryEx := TtfwDictionaryEx(aCtx.rEngine.PopObjAs(TtfwDictionaryEx));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDictionaryEx: TtfwDictionaryEx : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aDictionary := TtfwDictionaryEx(aCtx.rEngine.PopObjAs(TtfwDictionaryEx));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDictionary: TtfwDictionaryEx : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 ExportDictionary(aCtx, l_aDictionaryEx, l_aDictionary);
end;//TkwPopDictionaryExExportDictionary.DoDoIt

procedure TkwPopDictionaryExUseDictionary.UseDictionary(const aCtx: TtfwContext;
 aDictionaryEx: TtfwDictionaryEx;
 aDictionary: TtfwDictionaryEx);
 {* Реализация слова скрипта pop:DictionaryEx:UseDictionary }
//#UC START# *55AE661B00DA_55AE661B00DA_559E8B2E0385_Word_var*
//#UC END# *55AE661B00DA_55AE661B00DA_559E8B2E0385_Word_var*
begin
//#UC START# *55AE661B00DA_55AE661B00DA_559E8B2E0385_Word_impl*
 aDictionaryEx.UseDictionary(aDictionary);
//#UC END# *55AE661B00DA_55AE661B00DA_559E8B2E0385_Word_impl*
end;//TkwPopDictionaryExUseDictionary.UseDictionary

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
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwDictionaryEx), TypeInfo(TtfwDictionaryEx)]);
end;//TkwPopDictionaryExUseDictionary.ParamsTypes

procedure TkwPopDictionaryExUseDictionary.DoDoIt(const aCtx: TtfwContext);
var l_aDictionaryEx: TtfwDictionaryEx;
var l_aDictionary: TtfwDictionaryEx;
begin
 try
  l_aDictionaryEx := TtfwDictionaryEx(aCtx.rEngine.PopObjAs(TtfwDictionaryEx));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDictionaryEx: TtfwDictionaryEx : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aDictionary := TtfwDictionaryEx(aCtx.rEngine.PopObjAs(TtfwDictionaryEx));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDictionary: TtfwDictionaryEx : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 UseDictionary(aCtx, l_aDictionaryEx, l_aDictionary);
end;//TkwPopDictionaryExUseDictionary.DoDoIt

function TkwPopDictionaryExFileDateTime.FileDateTime(const aCtx: TtfwContext;
 aDictionaryEx: TtfwDictionaryEx): AnsiString;
 {* Реализация слова скрипта pop:DictionaryEx:FileDateTime }
//#UC START# *55AE66560055_55AE66560055_559E8B2E0385_Word_var*
//#UC END# *55AE66560055_55AE66560055_559E8B2E0385_Word_var*
begin
//#UC START# *55AE66560055_55AE66560055_559E8B2E0385_Word_impl*
 Result := l3DateTimeToStr(aDictionaryEx.FileDateTime);
//#UC END# *55AE66560055_55AE66560055_559E8B2E0385_Word_impl*
end;//TkwPopDictionaryExFileDateTime.FileDateTime

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
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwDictionaryEx)]);
end;//TkwPopDictionaryExFileDateTime.ParamsTypes

procedure TkwPopDictionaryExFileDateTime.DoDoIt(const aCtx: TtfwContext);
var l_aDictionaryEx: TtfwDictionaryEx;
begin
 try
  l_aDictionaryEx := TtfwDictionaryEx(aCtx.rEngine.PopObjAs(TtfwDictionaryEx));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDictionaryEx: TtfwDictionaryEx : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(FileDateTime(aCtx, l_aDictionaryEx));
end;//TkwPopDictionaryExFileDateTime.DoDoIt

procedure TkwPopDictionaryExRemoveFromCache.RemoveFromCache(const aCtx: TtfwContext;
 aDictionaryEx: TtfwDictionaryEx);
 {* Реализация слова скрипта pop:DictionaryEx:RemoveFromCache }
//#UC START# *55AE84FA0076_55AE84FA0076_559E8B2E0385_Word_var*
{$IfDef seCacheDict}
var
 l_D : TtfwDictionaryEx;
{$EndIf seCacheDict}
//#UC END# *55AE84FA0076_55AE84FA0076_559E8B2E0385_Word_var*
begin
//#UC START# *55AE84FA0076_55AE84FA0076_559E8B2E0385_Word_impl*
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
//#UC END# *55AE84FA0076_55AE84FA0076_559E8B2E0385_Word_impl*
end;//TkwPopDictionaryExRemoveFromCache.RemoveFromCache

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
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwDictionaryEx)]);
end;//TkwPopDictionaryExRemoveFromCache.ParamsTypes

procedure TkwPopDictionaryExRemoveFromCache.DoDoIt(const aCtx: TtfwContext);
var l_aDictionaryEx: TtfwDictionaryEx;
begin
 try
  l_aDictionaryEx := TtfwDictionaryEx(aCtx.rEngine.PopObjAs(TtfwDictionaryEx));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDictionaryEx: TtfwDictionaryEx : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 RemoveFromCache(aCtx, l_aDictionaryEx);
end;//TkwPopDictionaryExRemoveFromCache.DoDoIt

class function TtfwDictionaryExWordsPackResNameGetter.ResName: AnsiString;
begin
 Result := 'tfwDictionaryExWordsPack';
end;//TtfwDictionaryExWordsPackResNameGetter.ResName

{$R tfwDictionaryExWordsPack.res}

initialization
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
 TtfwDictionaryExWordsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwDictionaryEx));
 {* Регистрация типа TtfwDictionaryEx }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwValueList));
 {* Регистрация типа ItfwValueList }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
{$IfEnd} // NOT Defined(NoScripts)

end.
