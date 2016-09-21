unit msmWordsCachePack;

// Модуль: "w:\common\components\gui\Garant\msm\msmWordsCachePack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "msmWordsCachePack" MUID: (57B2D68E035D)

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
 , msmWordsCache
 , msmModelElementMethodValueCache
 , msmChangedElements
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *57B2D68E035Dimpl_uses*
 , l3String
 , WordsRTTIPack
 , msmModelElementMethodValueList
 //#UC END# *57B2D68E035Dimpl_uses*
;

type
 TkwMsmWordFromCache = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта msm:WordFromCache }
  private
   function msm_WordFromCache(const aCtx: TtfwContext;
    const aName: Il3CString): Boolean;
    {* Реализация слова скрипта msm:WordFromCache }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMsmWordFromCache

 TkwMsmWordToCache = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта msm:WordToCache }
  private
   procedure msm_WordToCache(const aCtx: TtfwContext;
    aWord: TtfwWord;
    const aName: Il3CString);
    {* Реализация слова скрипта msm:WordToCache }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMsmWordToCache

 TkwMsmDoCache = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта msm:DoCache }
  private
   procedure msm_DoCache(const aCtx: TtfwContext;
    aLambda: TtfwWord;
    const aDefault: TtfwStackValue;
    const aKey: Il3CString;
    const aCacheWhere: TtfwStackValue);
    {* Реализация слова скрипта msm:DoCache }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMsmDoCache

 TkwMsmAddChangedElement = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта msm:AddChangedElement }
  private
   procedure msm_AddChangedElement(const aCtx: TtfwContext;
    aWord: TtfwWord);
    {* Реализация слова скрипта msm:AddChangedElement }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMsmAddChangedElement

function TkwMsmWordFromCache.msm_WordFromCache(const aCtx: TtfwContext;
 const aName: Il3CString): Boolean;
 {* Реализация слова скрипта msm:WordFromCache }
//#UC START# *57B2D71E02B8_57B2D71E02B8_Word_var*
var
 l_Index: Integer;
//#UC END# *57B2D71E02B8_57B2D71E02B8_Word_var*
begin
//#UC START# *57B2D71E02B8_57B2D71E02B8_Word_impl*
 with TmsmWordsCache.Instance do
 begin
  Lock;
  try
   Result := FindData(aName, l_Index);
   if Result then
    aCtx.rEngine.PushObj(Items[l_Index]);
  finally
   Unlock;
  end;//try..finally
 end;//with TmsmWordsCache.Instance
//#UC END# *57B2D71E02B8_57B2D71E02B8_Word_impl*
end;//TkwMsmWordFromCache.msm_WordFromCache

class function TkwMsmWordFromCache.GetWordNameForRegister: AnsiString;
begin
 Result := 'msm:WordFromCache';
end;//TkwMsmWordFromCache.GetWordNameForRegister

function TkwMsmWordFromCache.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwMsmWordFromCache.GetResultTypeInfo

function TkwMsmWordFromCache.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMsmWordFromCache.GetAllParamsCount

function TkwMsmWordFromCache.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwMsmWordFromCache.ParamsTypes

procedure TkwMsmWordFromCache.DoDoIt(const aCtx: TtfwContext);
var l_aName: Il3CString;
begin
 try
  l_aName := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(msm_WordFromCache(aCtx, l_aName));
end;//TkwMsmWordFromCache.DoDoIt

procedure TkwMsmWordToCache.msm_WordToCache(const aCtx: TtfwContext;
 aWord: TtfwWord;
 const aName: Il3CString);
 {* Реализация слова скрипта msm:WordToCache }
//#UC START# *57B2D7420034_57B2D7420034_Word_var*
//#UC END# *57B2D7420034_57B2D7420034_Word_var*
begin
//#UC START# *57B2D7420034_57B2D7420034_Word_impl*
 if (aWord <> nil) then
 begin
  Assert(l3Same(aName, aWord.Key.AsCStr));
  TmsmWordsCache.Instance.Add(aWord);
 end;//aWord <> nil
//#UC END# *57B2D7420034_57B2D7420034_Word_impl*
end;//TkwMsmWordToCache.msm_WordToCache

class function TkwMsmWordToCache.GetWordNameForRegister: AnsiString;
begin
 Result := 'msm:WordToCache';
end;//TkwMsmWordToCache.GetWordNameForRegister

function TkwMsmWordToCache.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwMsmWordToCache.GetResultTypeInfo

function TkwMsmWordToCache.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwMsmWordToCache.GetAllParamsCount

function TkwMsmWordToCache.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord), @tfw_tiString]);
end;//TkwMsmWordToCache.ParamsTypes

procedure TkwMsmWordToCache.DoDoIt(const aCtx: TtfwContext);
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
 msm_WordToCache(aCtx, l_aWord, l_aName);
end;//TkwMsmWordToCache.DoDoIt

procedure TkwMsmDoCache.msm_DoCache(const aCtx: TtfwContext;
 aLambda: TtfwWord;
 const aDefault: TtfwStackValue;
 const aKey: Il3CString;
 const aCacheWhere: TtfwStackValue);
 {* Реализация слова скрипта msm:DoCache }
//#UC START# *57B2DFE201B1_57B2DFE201B1_Word_var*
var
 l_Word : TtfwWord;
 l_V : TmsmModelElementMethodValue;
 l_Index : Integer;
//#UC END# *57B2DFE201B1_57B2DFE201B1_Word_var*
begin
//#UC START# *57B2DFE201B1_57B2DFE201B1_Word_impl*
 Case aCacheWhere.rType of
  tfw_vtIntf:
   l_Word := (aCacheWhere.AsIntf As ItfwWordBox).Boxed As TtfwWord;
  tfw_vtObj:
   l_Word := aCacheWhere.AsObject As TtfwWord;
  else
  begin
   aLambda.DoIt(aCtx);
   Exit;
  end;//else
 end;//Case aCacheWhere.rType

 if (l_Word = nil) OR (l_Word.GetRefForCompare = nil) then
 begin
  aCtx.rEngine.Push(aDefault);
  Exit;
 end;//(l_Word = nil) OR (l_Word.GetRefForCompare)

 l_V := TmsmModelElementMethodValue_C(l_Word, aKey);
 with TmsmModelElementMethodValueCache.Instance do
 begin
  Lock;
  try
   if FindData(l_V, l_Index) then
   begin
    aCtx.rEngine.Push(Items[l_Index].rValue);
    Exit;
   end;//FindData(l_V, l_Index)
  finally
   Unlock;
  end;//try..finally
  aLambda.DoIt(aCtx);
  // - при трансформации элементов внутри надо звать Ctx:EnterCS/Ctx:LeaveCS
  l_V.rValue := aCtx.rEngine.Top^;
  {$IfDef MSM}
(*  if (l_V.rValue.rType = tfw_vtList) then
   if (l_V.rValue.AsIntf <> nil) then
    if ItfwValueList(l_V.rValue.AsIntf).IsView then
     Assert(false);*)
  {$EndIf MSM}
  Add(l_V);
 end;//with TmsmModelElementMethodValueCache.Instance
//#UC END# *57B2DFE201B1_57B2DFE201B1_Word_impl*
end;//TkwMsmDoCache.msm_DoCache

class function TkwMsmDoCache.GetWordNameForRegister: AnsiString;
begin
 Result := 'msm:DoCache';
end;//TkwMsmDoCache.GetWordNameForRegister

function TkwMsmDoCache.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwMsmDoCache.GetResultTypeInfo

function TkwMsmDoCache.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 4;
end;//TkwMsmDoCache.GetAllParamsCount

function TkwMsmDoCache.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord), @tfw_tiStruct, @tfw_tiString, @tfw_tiStruct]);
end;//TkwMsmDoCache.ParamsTypes

procedure TkwMsmDoCache.DoDoIt(const aCtx: TtfwContext);
var l_aLambda: TtfwWord;
var l_aDefault: TtfwStackValue;
var l_aKey: Il3CString;
var l_aCacheWhere: TtfwStackValue;
begin
 try
  l_aLambda := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLambda: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aDefault := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDefault: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aKey := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aKey: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aCacheWhere := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCacheWhere: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 msm_DoCache(aCtx, l_aLambda, l_aDefault, l_aKey, l_aCacheWhere);
end;//TkwMsmDoCache.DoDoIt

procedure TkwMsmAddChangedElement.msm_AddChangedElement(const aCtx: TtfwContext;
 aWord: TtfwWord);
 {* Реализация слова скрипта msm:AddChangedElement }
//#UC START# *57E2AB6700A6_57E2AB6700A6_Word_var*
//#UC END# *57E2AB6700A6_57E2AB6700A6_Word_var*
begin
//#UC START# *57E2AB6700A6_57E2AB6700A6_Word_impl*
 TmsmChangedElements.Instance.Add(aWord);
//#UC END# *57E2AB6700A6_57E2AB6700A6_Word_impl*
end;//TkwMsmAddChangedElement.msm_AddChangedElement

class function TkwMsmAddChangedElement.GetWordNameForRegister: AnsiString;
begin
 Result := 'msm:AddChangedElement';
end;//TkwMsmAddChangedElement.GetWordNameForRegister

function TkwMsmAddChangedElement.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwMsmAddChangedElement.GetResultTypeInfo

function TkwMsmAddChangedElement.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMsmAddChangedElement.GetAllParamsCount

function TkwMsmAddChangedElement.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwMsmAddChangedElement.ParamsTypes

procedure TkwMsmAddChangedElement.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
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
 msm_AddChangedElement(aCtx, l_aWord);
end;//TkwMsmAddChangedElement.DoDoIt

initialization
 TkwMsmWordFromCache.RegisterInEngine;
 {* Регистрация msm_WordFromCache }
 TkwMsmWordToCache.RegisterInEngine;
 {* Регистрация msm_WordToCache }
 TkwMsmDoCache.RegisterInEngine;
 {* Регистрация msm_DoCache }
 TkwMsmAddChangedElement.RegisterInEngine;
 {* Регистрация msm_AddChangedElement }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* Регистрация типа TtfwWord }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwStackValue }
{$IfEnd} // NOT Defined(NoScripts)

end.
