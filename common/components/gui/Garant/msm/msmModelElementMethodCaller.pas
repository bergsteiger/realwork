unit msmModelElementMethodCaller;

// Модуль: "w:\common\components\gui\Garant\msm\msmModelElementMethodCaller.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmModelElementMethodCaller" MUID: (57AA00BD022E)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , tfwTypeInfo
 {$IfEnd} // NOT Defined(NoScripts)
 , l3Interfaces
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TtfwStackValuesArray = array of TtfwStackValue;

 TmsmModelElementMethodCaller = class
  protected
   class function ScriptName(const aMethodName: AnsiString): Il3CString;
  public
   class function Call(aWord: TtfwWord;
    const aMethodName: AnsiString): TtfwStackValue; overload;
   class function CallAndGetObj(aWord: TtfwWord;
    const aMethodName: AnsiString): TObject;
   class function CallAndGetString(aWord: TtfwWord;
    const aMethodName: AnsiString): Il3CString;
   class function CallAndGetList(aWord: TtfwWord;
    const aMethodName: AnsiString): ItfwValueList; overload;
   class function CallAndGetInt(aWord: TtfwWord;
    const aMethodName: AnsiString): Integer;
   class function CallAndGetBool(aWord: TtfwWord;
    const aMethodName: AnsiString): Boolean;
   class function RawCall(aWord: TtfwWord;
    const aMethodName: AnsiString): TtfwStackValue;
   class procedure CallProc(const aMethodName: AnsiString);
   class function Call(const aParameters: array of TtfwStackValue;
    const aMethodName: AnsiString): TtfwStackValue; overload;
   class procedure CallSetter(aWord: TtfwWord;
    const aMethodName: AnsiString;
    const aValue: TtfwStackValue);
   class procedure CallIntSetter(aWord: TtfwWord;
    const aMethodName: AnsiString;
    aValue: Integer);
   class function CallAndGetList(const aParameters: array of TtfwStackValue;
    const aMethodName: AnsiString): ItfwArray; overload;
 end;//TmsmModelElementMethodCaller

implementation

uses
 l3ImplUses
 , msmScriptCaller
 {$If NOT Defined(NoScripts)}
 , tfwValueList
 {$IfEnd} // NOT Defined(NoScripts)
 , msmModelElementMethodValueCache
 {$If Defined(seThreadSafe)}
 , msmModelLoadingThread
 {$IfEnd} // Defined(seThreadSafe)
 , msmWordsByName
 , msmChangedElements
 {$If NOT Defined(NoScripts)}
 , msmModelElementMethodCallerPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwScriptEngine
 {$IfEnd} // NOT Defined(NoScripts)
 {$If Defined(seCacheDict) AND NOT Defined(NoScripts)}
 , tfwMainDictionaryCache
 {$IfEnd} // Defined(seCacheDict) AND NOT Defined(NoScripts)
 //#UC START# *57AA00BD022Eimpl_uses*
 , SysUtils
 , StrUtils
 , Controls
 , Forms
 , l3Types
 , l3String
 , l3FileUtils
 , l3Stream
 , msmModelElementMethodValueList
 , tfwMainDictionary
 , kwRuntimeWordWithCode
 , kwForwardDeclarationHolder
 //#UC END# *57AA00BD022Eimpl_uses*
;

type
 TmsmModelElementMethodScriptCaller = {final} class(TmsmScriptCaller)
  private
   f_Parameters: TtfwValueList;
   f_ResultValue: TtfwStackValue;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoScriptDone(const aCtx: TtfwContext); override;
   procedure DoScriptWillRun(const aCtx: TtfwContext); override;
   procedure ClearFields; override;
  public
   constructor Create(const aParameters: array of TtfwStackValue); reintroduce;
  public
   property Parameters: TtfwValueList
    read f_Parameters;
   property ResultValue: TtfwStackValue
    read f_ResultValue;
 end;//TmsmModelElementMethodScriptCaller

constructor TmsmModelElementMethodScriptCaller.Create(const aParameters: array of TtfwStackValue);
//#UC START# *57AA03740168_57A9FEF503A3_var*
var
 l_Index : Integer;
//#UC END# *57AA03740168_57A9FEF503A3_var*
begin
//#UC START# *57AA03740168_57A9FEF503A3_impl*
 inherited Create;
 f_Parameters := TtfwValueList.Create;
 for l_Index := Low(aParameters) to High(aParameters) do
  f_Parameters.Add(aParameters[l_Index]);
//#UC END# *57AA03740168_57A9FEF503A3_impl*
end;//TmsmModelElementMethodScriptCaller.Create

procedure TmsmModelElementMethodScriptCaller.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57A9FEF503A3_var*
//#UC END# *479731C50290_57A9FEF503A3_var*
begin
//#UC START# *479731C50290_57A9FEF503A3_impl*
 FreeAndNil(f_Parameters);
 Finalize(f_ResultValue);
 inherited;
//#UC END# *479731C50290_57A9FEF503A3_impl*
end;//TmsmModelElementMethodScriptCaller.Cleanup

procedure TmsmModelElementMethodScriptCaller.DoScriptDone(const aCtx: TtfwContext);
//#UC START# *57A9E4F203B5_57A9FEF503A3_var*
//#UC END# *57A9E4F203B5_57A9FEF503A3_var*
begin
//#UC START# *57A9E4F203B5_57A9FEF503A3_impl*
 inherited;
 if (aCtx.rEngine.ValuesCount > 0) then
  f_ResultValue := aCtx.rEngine.Pop
 else
  f_ResultValue := TtfwStackValue_E;
//#UC END# *57A9E4F203B5_57A9FEF503A3_impl*
end;//TmsmModelElementMethodScriptCaller.DoScriptDone

procedure TmsmModelElementMethodScriptCaller.DoScriptWillRun(const aCtx: TtfwContext);
//#UC START# *57A9FED102C4_57A9FEF503A3_var*
var
 l_Index : Integer;
//#UC END# *57A9FED102C4_57A9FEF503A3_var*
begin
//#UC START# *57A9FED102C4_57A9FEF503A3_impl*
 inherited;
 if (f_Parameters <> nil) then
  for l_Index := 0 to Pred(f_Parameters.Count) do
    aCtx.rEngine.Push(f_Parameters[l_Index]);
//#UC END# *57A9FED102C4_57A9FEF503A3_impl*
end;//TmsmModelElementMethodScriptCaller.DoScriptWillRun

procedure TmsmModelElementMethodScriptCaller.ClearFields;
begin
 Finalize(f_ResultValue);
 inherited;
end;//TmsmModelElementMethodScriptCaller.ClearFields

class function TmsmModelElementMethodCaller.Call(aWord: TtfwWord;
 const aMethodName: AnsiString): TtfwStackValue;
//#UC START# *57AA00EB01D8_57AA00BD022E_var*
var
 l_Cursor: TCursor;
 l_V : TmsmModelElementMethodValue;
 l_Index : Integer;
 l_MethodName: Il3CString;
//#UC END# *57AA00EB01D8_57AA00BD022E_var*
begin
//#UC START# *57AA00EB01D8_57AA00BD022E_impl*
 l_MethodName := TtfwCStringFactory.C('.' + aMethodName);
 l_V := TmsmModelElementMethodValue_C(aWord, l_MethodName);
 with TmsmModelElementMethodValueCache.Instance do
 begin
  Lock;
  try
   if FindData(l_V, l_Index) then
   begin
    Result := Items[l_Index].rValue;
    Exit;
   end;//FindData(l_V, l_Index)
  finally
   Unlock;
  end;//try..finally
  l_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
   {$IfDef seThreadSafe}
   //TmsmModelLoadingThread.CreateManaged(aWord, 'LoadLevel');
   {$EndIf seThreadSafe}
   Result := RawCall(aWord, aMethodName);
   l_V.rValue := Result;
   Add(l_V);
   {$IfDef seThreadSafe}
   //TmsmModelLoadingThread.CreateManaged(aWord, 'LoadLevel');
   {$EndIf seThreadSafe}
  finally
   Screen.Cursor := l_Cursor;
  end;//Screen.Cursor := crHourGlass;
 end;//with TmsmModelElementMethodValueCache.Instance
//#UC END# *57AA00EB01D8_57AA00BD022E_impl*
end;//TmsmModelElementMethodCaller.Call

class function TmsmModelElementMethodCaller.CallAndGetObj(aWord: TtfwWord;
 const aMethodName: AnsiString): TObject;
//#UC START# *57AAD78202FF_57AA00BD022E_var*
//#UC END# *57AAD78202FF_57AA00BD022E_var*
begin
//#UC START# *57AAD78202FF_57AA00BD022E_impl*
 Result := Call(aWord, aMethodName).AsObject;
//#UC END# *57AAD78202FF_57AA00BD022E_impl*
end;//TmsmModelElementMethodCaller.CallAndGetObj

class function TmsmModelElementMethodCaller.CallAndGetString(aWord: TtfwWord;
 const aMethodName: AnsiString): Il3CString;
//#UC START# *57AAD7AA00E0_57AA00BD022E_var*
//#UC END# *57AAD7AA00E0_57AA00BD022E_var*
begin
//#UC START# *57AAD7AA00E0_57AA00BD022E_impl*
 Result := Call(aWord, aMethodName).AsString;
//#UC END# *57AAD7AA00E0_57AA00BD022E_impl*
end;//TmsmModelElementMethodCaller.CallAndGetString

class function TmsmModelElementMethodCaller.CallAndGetList(aWord: TtfwWord;
 const aMethodName: AnsiString): ItfwValueList;
//#UC START# *57AAD7CA0287_57AA00BD022E_var*
//#UC END# *57AAD7CA0287_57AA00BD022E_var*
begin
//#UC START# *57AAD7CA0287_57AA00BD022E_impl*
 Result := ItfwValueList(Call(aWord, aMethodName).AsIntf);
//#UC END# *57AAD7CA0287_57AA00BD022E_impl*
end;//TmsmModelElementMethodCaller.CallAndGetList

class function TmsmModelElementMethodCaller.CallAndGetInt(aWord: TtfwWord;
 const aMethodName: AnsiString): Integer;
//#UC START# *57AAD7EE01D3_57AA00BD022E_var*
//#UC END# *57AAD7EE01D3_57AA00BD022E_var*
begin
//#UC START# *57AAD7EE01D3_57AA00BD022E_impl*
 Result := Call(aWord, aMethodName).AsInt;
//#UC END# *57AAD7EE01D3_57AA00BD022E_impl*
end;//TmsmModelElementMethodCaller.CallAndGetInt

class function TmsmModelElementMethodCaller.CallAndGetBool(aWord: TtfwWord;
 const aMethodName: AnsiString): Boolean;
//#UC START# *57AAD8130389_57AA00BD022E_var*
//#UC END# *57AAD8130389_57AA00BD022E_var*
begin
//#UC START# *57AAD8130389_57AA00BD022E_impl*
 Result := Call(aWord, aMethodName).AsBoolean;
//#UC END# *57AAD8130389_57AA00BD022E_impl*
end;//TmsmModelElementMethodCaller.CallAndGetBool

class function TmsmModelElementMethodCaller.RawCall(aWord: TtfwWord;
 const aMethodName: AnsiString): TtfwStackValue;
//#UC START# *57C437080131_57AA00BD022E_var*
//#UC END# *57C437080131_57AA00BD022E_var*
begin
//#UC START# *57C437080131_57AA00BD022E_impl*
 Result := Call([TtfwStackValue_C(aWord)], aMethodName);
//#UC END# *57C437080131_57AA00BD022E_impl*
end;//TmsmModelElementMethodCaller.RawCall

class procedure TmsmModelElementMethodCaller.CallProc(const aMethodName: AnsiString);
//#UC START# *57C438C803DC_57AA00BD022E_var*
//#UC END# *57C438C803DC_57AA00BD022E_var*
begin
//#UC START# *57C438C803DC_57AA00BD022E_impl*
 TmsmModelElementMethodCaller.Call([], aMethodName);
//#UC END# *57C438C803DC_57AA00BD022E_impl*
end;//TmsmModelElementMethodCaller.CallProc

class function TmsmModelElementMethodCaller.Call(const aParameters: array of TtfwStackValue;
 const aMethodName: AnsiString): TtfwStackValue;
//#UC START# *57CFC420039B_57AA00BD022E_var*
CONST cQuote = '''';

var
 l_Caller : TmsmModelElementMethodScriptCaller;
 l_S : AnsiString;
 l_N : AnsiString;
 l_N1 : AnsiString;
 l_F : Tl3FileStream;
 l_Delim : AnsiString;
 l_Check : AnsiString;
 l_ScriptName : Il3CString;
 l_D : TtfwMainDictionary;
 l_W : TtfwWord;
 l_MethodName : Il3CString;
 l_WasCompiled : Boolean;
//#UC END# *57CFC420039B_57AA00BD022E_var*
begin
//#UC START# *57CFC420039B_57AA00BD022E_impl*
 l_Caller := TmsmModelElementMethodScriptCaller.Create(aParameters);
 try
  l_ScriptName := ScriptName(aMethodName);
  l_N := l3Str(l_ScriptName);
  if (Length(aParameters) > 0) then
  begin
   l_Delim := '.';
  end//aParameter.rType <> tfw_vtVoid
  else
  begin
   l_Delim := '';
  end;//aParameter.rType <> tfw_vtVoid
  l_MethodName := TtfwCStringFactory.C(l_Delim + aMethodName);
  l_WasCompiled := TmsmWordsByName.Instance.Has(l_MethodName);
  if not l_WasCompiled then
  begin
   if true{(Length(aParameters) > 0)} then
   begin
    l_Check := '.CheckValueSafe';
   end//aParameter.rType <> tfw_vtVoid
   else
   begin
    l_Check := '';
   end;//aParameter.rType <> tfw_vtVoid
   l_S :=
    'INCLUDE ' + cQuote + 'msm.ms.dict' + cQuote + #13#10 +
    l_Delim + aMethodName + #13#10 +
    l_Check
   ;
   ForceDirectories(ExtractFilePath(l_N));
   l_N1 := l_N + '.tmp';
   l_F := Tl3FileStream.Create(l_N1, l3_fmWrite);
   try
    l_F.Write(PAnsiChar(l_S)^, Length(l_S));
   finally
    FreeAndNil(l_F);
   end;//try..finally
   if not FileExists(l_N) OR
      not l3CompareFiles(l_N1, l_N)
    then
   begin
    l3FileUtils.CopyFile(l_N1, l_N, cmNoBakCopy);
   end;//not FileExists(l_N)
  end;//not l_WasCompiled
  TtfwScriptEngine.ScriptFromFile(l_N, l_Caller);
  //TtfwScriptEngine.Script(l_S, l_Caller);
  if not l_WasCompiled then
  begin
   if TtfwMainDictionaryCache.Exists then
   begin
    l_D := TtfwMainDictionaryCache.Instance.FindDictionary(l_ScriptName);
    if (l_D <> nil) then
    begin
     if (l_D.CompiledCode <> nil) then
     begin
      Assert(l_D.CompiledCode Is TkwRuntimeWordWithCode);
      l_W := (l_D.CompiledCode As TkwRuntimeWordWithCode).Code[0];
      if (l_W.Key = nil) then
      begin
       if (l_W Is TkwForwardDeclarationHolder) then
       begin
        l_W := TkwForwardDeclarationHolder(l_W).Holded;
        Assert(l_W.Key <> nil);
       end//l_W Is TkwForwardDeclarationHolder 
       else
        Assert(false); 
      end;//l_W.Key = nil
      if (l_W.Key <> nil) then
      begin
       Assert(l_W.Key <> nil);
       with TmsmWordsByName.Instance do
       begin
        Lock;
        try
         if not Has(l_MethodName) then
          Add(l_MethodName, l_W);
        finally
         Unlock;
        end;//try..finally
       end;//TmsmWordsByName.Instance
      end;//l_W.Key <> nil
     end;//l_D.CompiledCode <> nil
    end;//l_D <> nil
   end;//TtfwMainDictionaryCache.Exists
  end;//not l_WasCompiled
  Result := l_Caller.ResultValue;
 finally
  FreeAndNil(l_Caller);
 end;//try..finally
//#UC END# *57CFC420039B_57AA00BD022E_impl*
end;//TmsmModelElementMethodCaller.Call

class function TmsmModelElementMethodCaller.ScriptName(const aMethodName: AnsiString): Il3CString;
//#UC START# *57D66B490028_57AA00BD022E_var*
//#UC END# *57D66B490028_57AA00BD022E_var*
begin
//#UC START# *57D66B490028_57AA00BD022E_impl*
 Result := TmsmModelElementMethodValueCache.ScriptName(TtfwCStringFactory.C(aMethodName));
//#UC END# *57D66B490028_57AA00BD022E_impl*
end;//TmsmModelElementMethodCaller.ScriptName

class procedure TmsmModelElementMethodCaller.CallSetter(aWord: TtfwWord;
 const aMethodName: AnsiString;
 const aValue: TtfwStackValue);
//#UC START# *57D68123004E_57AA00BD022E_var*
var
 l_V : TmsmModelElementMethodValue;
 l_Index : Integer;
 l_MethodName: Il3CString;
//#UC END# *57D68123004E_57AA00BD022E_var*
begin
//#UC START# *57D68123004E_57AA00BD022E_impl*
 l_MethodName := TtfwCStringFactory.C('.' + aMethodName);
 l_V := TmsmModelElementMethodValue_C(aWord, l_MethodName);
 with TmsmModelElementMethodValueCache.Instance do
 begin
  Lock;
  try
   l_V := CheckItem(l_V);
   if FindData(l_V, l_Index) then
    ItemSlot(l_Index).rValue := aValue
   else
   begin
    l_V.rValue := aValue;
    Insert(l_Index, l_V);
   end;//FindData(l_V, l_Index)
   //Call([TtfwStackValue_C(l_V.rWord), TtfwStackValue_C(l_V.rName), aValue], 'SetElementVar');
  finally
   Unlock;
  end;//try..finally
 end;//with TmsmModelElementMethodValueCache.Instance
 Call([TtfwStackValue_C(l_V.rWord), TtfwStackValue_C(l_V.rName), aValue], 'SetElementVar');
 TmsmChangedElements.Instance.Add(l_V.rWord);
//#UC END# *57D68123004E_57AA00BD022E_impl*
end;//TmsmModelElementMethodCaller.CallSetter

class procedure TmsmModelElementMethodCaller.CallIntSetter(aWord: TtfwWord;
 const aMethodName: AnsiString;
 aValue: Integer);
//#UC START# *57D6815802B8_57AA00BD022E_var*
//#UC END# *57D6815802B8_57AA00BD022E_var*
begin
//#UC START# *57D6815802B8_57AA00BD022E_impl*
 CallSetter(aWord, aMethodName, TtfwStackValue_C(aValue));
//#UC END# *57D6815802B8_57AA00BD022E_impl*
end;//TmsmModelElementMethodCaller.CallIntSetter

class function TmsmModelElementMethodCaller.CallAndGetList(const aParameters: array of TtfwStackValue;
 const aMethodName: AnsiString): ItfwArray;
//#UC START# *57F4E39D0252_57AA00BD022E_var*
//#UC END# *57F4E39D0252_57AA00BD022E_var*
begin
//#UC START# *57F4E39D0252_57AA00BD022E_impl*
 Result := ItfwValueList(Call(aParameters, aMethodName).AsIntf);
//#UC END# *57F4E39D0252_57AA00BD022E_impl*
end;//TmsmModelElementMethodCaller.CallAndGetList

end.
