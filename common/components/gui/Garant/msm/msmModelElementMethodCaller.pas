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
 TmsmModelElementMethodCaller = class
  public
   class function Call(aWord: TtfwWord;
    const aMethodName: AnsiString): TtfwStackValue;
   class function CallAndGetObj(aWord: TtfwWord;
    const aMethodName: AnsiString): TObject;
   class function CallAndGetString(aWord: TtfwWord;
    const aMethodName: AnsiString): Il3CString;
   class function CallAndGetList(aWord: TtfwWord;
    const aMethodName: AnsiString): ItfwValueList;
   class function CallAndGetInt(aWord: TtfwWord;
    const aMethodName: AnsiString): Integer;
   class function CallAndGetBool(aWord: TtfwWord;
    const aMethodName: AnsiString): Boolean;
   class function RawCall(aWord: TtfwWord;
    const aMethodName: AnsiString): TtfwStackValue;
   class procedure CallProc(const aMethodName: AnsiString);
 end;//TmsmModelElementMethodCaller

implementation

uses
 l3ImplUses
 , msmScriptCaller
 , msmModelElementMethodValueCache
 {$If Defined(seThreadSafe)}
 , msmModelLoadingThread
 {$IfEnd} // Defined(seThreadSafe)
 {$If NOT Defined(NoScripts)}
 , tfwScriptEngine
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57AA00BD022Eimpl_uses*
 , SysUtils
 , Controls
 , Forms
 , l3Types
 , l3FileUtils
 , l3Stream
 , msmModelElementMethodValueList
 //#UC END# *57AA00BD022Eimpl_uses*
;

type
 TmsmModelElementMethodScriptCaller = {final} class(TmsmScriptCaller)
  private
   f_ResultValue: TtfwStackValue;
   f_WordToCall: TtfwWord;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoScriptDone(const aCtx: TtfwContext); override;
   procedure DoScriptWillRun(const aCtx: TtfwContext); override;
   procedure ClearFields; override;
  public
   constructor Create(aWordToCall: TtfwWord); reintroduce;
  public
   property ResultValue: TtfwStackValue
    read f_ResultValue;
   property WordToCall: TtfwWord
    read f_WordToCall;
 end;//TmsmModelElementMethodScriptCaller

constructor TmsmModelElementMethodScriptCaller.Create(aWordToCall: TtfwWord);
//#UC START# *57AA03740168_57A9FEF503A3_var*
//#UC END# *57AA03740168_57A9FEF503A3_var*
begin
//#UC START# *57AA03740168_57A9FEF503A3_impl*
 inherited Create;
 aWordToCall.SetRefTo(f_WordToCall);
//#UC END# *57AA03740168_57A9FEF503A3_impl*
end;//TmsmModelElementMethodScriptCaller.Create

procedure TmsmModelElementMethodScriptCaller.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57A9FEF503A3_var*
//#UC END# *479731C50290_57A9FEF503A3_var*
begin
//#UC START# *479731C50290_57A9FEF503A3_impl*
 FreeAndNil(f_WordToCall);
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
 f_ResultValue := aCtx.rEngine.Pop;
//#UC END# *57A9E4F203B5_57A9FEF503A3_impl*
end;//TmsmModelElementMethodScriptCaller.DoScriptDone

procedure TmsmModelElementMethodScriptCaller.DoScriptWillRun(const aCtx: TtfwContext);
//#UC START# *57A9FED102C4_57A9FEF503A3_var*
//#UC END# *57A9FED102C4_57A9FEF503A3_var*
begin
//#UC START# *57A9FED102C4_57A9FEF503A3_impl*
 inherited;
 aCtx.rEngine.PushObj(f_WordToCall);
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
CONST cQuote = '''';

var
 l_Caller : TmsmModelElementMethodScriptCaller;
 l_S : String;
 l_Path : String;
 l_N : String;
 l_N1 : String;
 l_F : Tl3FileStream;
//#UC END# *57C437080131_57AA00BD022E_var*
begin
//#UC START# *57C437080131_57AA00BD022E_impl*
 l_Caller := TmsmModelElementMethodScriptCaller.Create(aWord);
 try
  l_S :=
   'INCLUDE ' + cQuote + 'arrays.ms.dict' + cQuote + #13#10 +
   'INCLUDE ' + cQuote + 'ElementsRTTI.ms.dict' + cQuote + #13#10 +
   'INCLUDE ' + cQuote + 'msm.ms.dict' + cQuote + #13#10 +
   'INCLUDE ' + cQuote + 'CheckValue.ms.dict' + cQuote + #13#10 +
   '.' + aMethodName + #13#10 +
   'CheckValue'
  ;
  l_Path := 'C:\Temp\Scripts\Stubs\';
  l_N := ConcatDirName(l_Path, aMethodName) + '.stub.script';
  ForceDirectories(l_Path);
  l_N1 := l_N + '.tmp';
  l_F := Tl3FileStream.Create(l_N1, l3_fmWrite);
  try
   l_F.Write(PChar(l_S)^, Length(l_S));
  finally
   FreeAndNil(l_F);
  end;//try..finally
  if not FileExists(l_N) OR
     not l3CompareFiles(l_N1, l_N)
   then
  begin
   l3FileUtils.CopyFile(l_N1, l_N, cmNoBakCopy);
  end;//not FileExists(l_N) 
  TtfwScriptEngine.ScriptFromFile(l_N, l_Caller);
  //TtfwScriptEngine.Script(l_S, l_Caller);
  Result := l_Caller.ResultValue;
 finally
  FreeAndNil(l_Caller);
 end;//try..finally
//#UC END# *57C437080131_57AA00BD022E_impl*
end;//TmsmModelElementMethodCaller.RawCall

class procedure TmsmModelElementMethodCaller.CallProc(const aMethodName: AnsiString);
//#UC START# *57C438C803DC_57AA00BD022E_var*
CONST cQuote = '''';

var
 l_Caller : TmsmScriptCaller;
//#UC END# *57C438C803DC_57AA00BD022E_var*
begin
//#UC START# *57C438C803DC_57AA00BD022E_impl*
 l_Caller := TmsmScriptCaller.Create;
 try
  TtfwScriptEngine.Script(
  'INCLUDE ' + cQuote + 'msm.ms.dict' + cQuote + #13#10 +
  aMethodName + #13#10
  , l_Caller
  );
 finally
  FreeAndNil(l_Caller);
 end;//try..finally
//#UC END# *57C438C803DC_57AA00BD022E_impl*
end;//TmsmModelElementMethodCaller.CallProc

end.
