unit msmWordsCachePack;

// ������: "w:\common\components\gui\Garant\msm\msmWordsCachePack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "msmWordsCachePack" MUID: (57B2D68E035D)

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
 , msmLostWords
 , msmElementListsService
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
  {* ����� ������� msm:WordFromCache }
  private
   function msm_WordFromCache(const aCtx: TtfwContext;
    const aName: Il3CString): Boolean;
    {* ���������� ����� ������� msm:WordFromCache }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMsmWordFromCache

 TkwMsmWordToCache = {final} class(TtfwGlobalKeyWord)
  {* ����� ������� msm:WordToCache }
  private
   procedure msm_WordToCache(const aCtx: TtfwContext;
    aWord: TtfwWord;
    const aName: Il3CString);
    {* ���������� ����� ������� msm:WordToCache }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMsmWordToCache

 TkwMsmDoCache = {final} class(TtfwGlobalKeyWord)
  {* ����� ������� msm:DoCache }
  private
   procedure msm_DoCache(const aCtx: TtfwContext;
    aLambda: TtfwWord;
    const aDefault: TtfwStackValue;
    const aKey: Il3CString;
    const aCacheWhere: TtfwStackValue);
    {* ���������� ����� ������� msm:DoCache }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMsmDoCache

 TkwMsmDeleteWordCachedValues = {final} class(TtfwGlobalKeyWord)
  {* ����� ������� msm:DeleteWordCachedValues }
  private
   procedure msm_DeleteWordCachedValues(const aCtx: TtfwContext;
    aWord: TtfwWord);
    {* ���������� ����� ������� msm:DeleteWordCachedValues }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMsmDeleteWordCachedValues

 TkwMsmClearCachedValues = {final} class(TtfwGlobalKeyWord)
  {* ����� ������� msm:ClearCachedValues }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMsmClearCachedValues

 TkwMsmRegetViewedLists = {final} class(TtfwGlobalKeyWord)
  {* ����� ������� msm:RegetViewedLists }
  private
   procedure msm_RegetViewedLists(const aCtx: TtfwContext;
    aWord: TtfwWord;
    const aListName: AnsiString);
    {* ���������� ����� ������� msm:RegetViewedLists }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMsmRegetViewedLists

 TkwMsmDeleteWordCachedValue = {final} class(TtfwGlobalKeyWord)
  {* ����� ������� msm:DeleteWordCachedValue }
  private
   procedure msm_DeleteWordCachedValue(const aCtx: TtfwContext;
    aWord: TtfwWord;
    const aName: AnsiString);
    {* ���������� ����� ������� msm:DeleteWordCachedValue }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMsmDeleteWordCachedValue

function TkwMsmWordFromCache.msm_WordFromCache(const aCtx: TtfwContext;
 const aName: Il3CString): Boolean;
 {* ���������� ����� ������� msm:WordFromCache }
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
 if not Result then
 begin
  with TmsmLostWords.Instance do
  begin
   Lock;
   try
    Result := FindData(aName, l_Index);
    if Result then
     aCtx.rEngine.PushObj(nil);
   finally
    Unlock;
   end;//try..finally
  end;//with TmsmLostWords.Instance
 end;//not Result 
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
   RunnerError('������ ��� ��������� ��������� aName: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(msm_WordFromCache(aCtx, l_aName));
end;//TkwMsmWordFromCache.DoDoIt

procedure TkwMsmWordToCache.msm_WordToCache(const aCtx: TtfwContext;
 aWord: TtfwWord;
 const aName: Il3CString);
 {* ���������� ����� ������� msm:WordToCache }
//#UC START# *57B2D7420034_57B2D7420034_Word_var*
//#UC END# *57B2D7420034_57B2D7420034_Word_var*
begin
//#UC START# *57B2D7420034_57B2D7420034_Word_impl*
 if (aWord = nil) then
  TmsmLostWords.Instance.Add(aName)
 else
 begin
  Assert(l3Same(aName, aWord.Key.AsCStr));
  TmsmWordsCache.Instance.Add(aWord);
 end;//aWord = nil
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
   RunnerError('������ ��� ��������� ��������� aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aName: Il3CString : ' + E.Message, aCtx);
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
 {* ���������� ����� ������� msm:DoCache }
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
  aLambda.DoIt(aCtx);
  //aCtx.rEngine.Push(aDefault);
  //- ������-�� ��� ���� ����� aLambda.DoIt(aCtx); ��-�������� � DoCache
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
  // - � ��� ��� ���� �� �������� � try..except � ������������ aDefault, ��-�������� � DoCache
  // - ��� ������������� ��������� ������ ���� ����� Ctx:EnterCS/Ctx:LeaveCS
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
   RunnerError('������ ��� ��������� ��������� aLambda: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aDefault := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDefault: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aKey := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aKey: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aCacheWhere := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCacheWhere: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 msm_DoCache(aCtx, l_aLambda, l_aDefault, l_aKey, l_aCacheWhere);
end;//TkwMsmDoCache.DoDoIt

procedure TkwMsmDeleteWordCachedValues.msm_DeleteWordCachedValues(const aCtx: TtfwContext;
 aWord: TtfwWord);
 {* ���������� ����� ������� msm:DeleteWordCachedValues }
//#UC START# *57F67D3000FE_57F67D3000FE_Word_var*
//#UC END# *57F67D3000FE_57F67D3000FE_Word_var*
begin
//#UC START# *57F67D3000FE_57F67D3000FE_Word_impl*
 TmsmModelElementMethodValueCache.Instance.DeleteWordCachedValues(aWord);
//#UC END# *57F67D3000FE_57F67D3000FE_Word_impl*
end;//TkwMsmDeleteWordCachedValues.msm_DeleteWordCachedValues

class function TkwMsmDeleteWordCachedValues.GetWordNameForRegister: AnsiString;
begin
 Result := 'msm:DeleteWordCachedValues';
end;//TkwMsmDeleteWordCachedValues.GetWordNameForRegister

function TkwMsmDeleteWordCachedValues.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwMsmDeleteWordCachedValues.GetResultTypeInfo

function TkwMsmDeleteWordCachedValues.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMsmDeleteWordCachedValues.GetAllParamsCount

function TkwMsmDeleteWordCachedValues.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwMsmDeleteWordCachedValues.ParamsTypes

procedure TkwMsmDeleteWordCachedValues.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 msm_DeleteWordCachedValues(aCtx, l_aWord);
end;//TkwMsmDeleteWordCachedValues.DoDoIt

class function TkwMsmClearCachedValues.GetWordNameForRegister: AnsiString;
begin
 Result := 'msm:ClearCachedValues';
end;//TkwMsmClearCachedValues.GetWordNameForRegister

function TkwMsmClearCachedValues.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwMsmClearCachedValues.GetResultTypeInfo

function TkwMsmClearCachedValues.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwMsmClearCachedValues.GetAllParamsCount

function TkwMsmClearCachedValues.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwMsmClearCachedValues.ParamsTypes

procedure TkwMsmClearCachedValues.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_57FC1BA5030E_Word_var*
//#UC END# *4DAEEDE10285_57FC1BA5030E_Word_var*
begin
//#UC START# *4DAEEDE10285_57FC1BA5030E_Word_impl*
 TmsmModelElementMethodValueCache.Instance.Clear;
//#UC END# *4DAEEDE10285_57FC1BA5030E_Word_impl*
end;//TkwMsmClearCachedValues.DoDoIt

procedure TkwMsmRegetViewedLists.msm_RegetViewedLists(const aCtx: TtfwContext;
 aWord: TtfwWord;
 const aListName: AnsiString);
 {* ���������� ����� ������� msm:RegetViewedLists }
//#UC START# *57FF6B330005_57FF6B330005_Word_var*
//#UC END# *57FF6B330005_57FF6B330005_Word_var*
begin
//#UC START# *57FF6B330005_57FF6B330005_Word_impl*
 TmsmElementListsService.Instance.RegetViewedListsFor(aWord, aListName);
//#UC END# *57FF6B330005_57FF6B330005_Word_impl*
end;//TkwMsmRegetViewedLists.msm_RegetViewedLists

class function TkwMsmRegetViewedLists.GetWordNameForRegister: AnsiString;
begin
 Result := 'msm:RegetViewedLists';
end;//TkwMsmRegetViewedLists.GetWordNameForRegister

function TkwMsmRegetViewedLists.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwMsmRegetViewedLists.GetResultTypeInfo

function TkwMsmRegetViewedLists.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwMsmRegetViewedLists.GetAllParamsCount

function TkwMsmRegetViewedLists.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord), @tfw_tiString]);
end;//TkwMsmRegetViewedLists.ParamsTypes

procedure TkwMsmRegetViewedLists.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
var l_aListName: AnsiString;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aListName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aListName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 msm_RegetViewedLists(aCtx, l_aWord, l_aListName);
end;//TkwMsmRegetViewedLists.DoDoIt

procedure TkwMsmDeleteWordCachedValue.msm_DeleteWordCachedValue(const aCtx: TtfwContext;
 aWord: TtfwWord;
 const aName: AnsiString);
 {* ���������� ����� ������� msm:DeleteWordCachedValue }
//#UC START# *5807640300C8_5807640300C8_Word_var*
//#UC END# *5807640300C8_5807640300C8_Word_var*
begin
//#UC START# *5807640300C8_5807640300C8_Word_impl*
 TmsmModelElementMethodValueCache.Instance.DeleteWordCachedValue(aWord, aName);
//#UC END# *5807640300C8_5807640300C8_Word_impl*
end;//TkwMsmDeleteWordCachedValue.msm_DeleteWordCachedValue

class function TkwMsmDeleteWordCachedValue.GetWordNameForRegister: AnsiString;
begin
 Result := 'msm:DeleteWordCachedValue';
end;//TkwMsmDeleteWordCachedValue.GetWordNameForRegister

function TkwMsmDeleteWordCachedValue.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwMsmDeleteWordCachedValue.GetResultTypeInfo

function TkwMsmDeleteWordCachedValue.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwMsmDeleteWordCachedValue.GetAllParamsCount

function TkwMsmDeleteWordCachedValue.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord), @tfw_tiString]);
end;//TkwMsmDeleteWordCachedValue.ParamsTypes

procedure TkwMsmDeleteWordCachedValue.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
var l_aName: AnsiString;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 msm_DeleteWordCachedValue(aCtx, l_aWord, l_aName);
end;//TkwMsmDeleteWordCachedValue.DoDoIt

initialization
 TkwMsmWordFromCache.RegisterInEngine;
 {* ����������� msm_WordFromCache }
 TkwMsmWordToCache.RegisterInEngine;
 {* ����������� msm_WordToCache }
 TkwMsmDoCache.RegisterInEngine;
 {* ����������� msm_DoCache }
 TkwMsmDeleteWordCachedValues.RegisterInEngine;
 {* ����������� msm_DeleteWordCachedValues }
 TkwMsmClearCachedValues.RegisterInEngine;
 {* ����������� msm_ClearCachedValues }
 TkwMsmRegetViewedLists.RegisterInEngine;
 {* ����������� msm_RegetViewedLists }
 TkwMsmDeleteWordCachedValue.RegisterInEngine;
 {* ����������� msm_DeleteWordCachedValue }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* ����������� ���� Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* ����������� ���� Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* ����������� ���� TtfwWord }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwStackValue }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* ����������� ���� AnsiString }
{$IfEnd} // NOT Defined(NoScripts)

end.
