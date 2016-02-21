unit kwCompiledWordWorkerWordRunner;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordWorkerWordRunner.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwCompiledWordWorker
 , tfwScriptingInterfaces
 , tfwWordRefList
 , tfwTypeInfo
;

type
 RkwCompiledWordWorkerWordRunner = class of TkwCompiledWordWorkerWordRunner;

 TkwCompiledWordWorkerWordRunner = class(TkwCompiledWordWorker)
  private
   f_LeftWordRefs: TtfwWordRefList;
   f_WordToRun: TtfwWord;
    {* ���� ��� �������� WordToRun }
   f_Caller: TtfwWord;
    {* ���� ��� �������� Caller }
  private
   procedure DoCode(const aCtx: TtfwContext);
   function ReturnsRef(const aCtx: TtfwContext): Boolean;
  protected
   procedure pm_SetWordToRun(aValue: TtfwWord);
   procedure PushState(const aCtx: TtfwContext);
   procedure PushWordToWork(const aCtx: TtfwContext);
   procedure DoDoIt(const aCtx: TtfwContext); override;
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   function pm_GetResultTypeInfo(const aCtx: TtfwContext): TtfwWordInfo; override;
  public
   function IsImmediate(const aCtx: TtfwContext): Boolean; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function LeftWordRefParamsCount(const aCtx: TtfwContext): Integer; override;
   procedure AddLeftWordRefValue(const aCtx: TtfwContext;
    aValue: TtfwWord); override;
   function GetLeftWordRefValue(const aCtx: TtfwContext;
    anIndex: Integer): TtfwWord; override;
   function LeftWordRefValuesCount(const aCtx: TtfwContext): Integer; override;
   function GetRef(const aCtx: TtfwContext): TtfwWord; override;
   procedure SetValue(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
  public
   property WordToRun: TtfwWord
    read f_WordToRun
    write pm_SetWordToRun;
   property Caller: TtfwWord
    read f_Caller
    write f_Caller;
 end;//TkwCompiledWordWorkerWordRunner
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , kwRuntimeWordWithCode
 , tfwClassRef
;

procedure TkwCompiledWordWorkerWordRunner.pm_SetWordToRun(aValue: TtfwWord);
//#UC START# *4F219F4E03CB_4F2198430108set_var*
//#UC END# *4F219F4E03CB_4F2198430108set_var*
begin
//#UC START# *4F219F4E03CB_4F2198430108set_impl*
 aValue.SetRefTo(f_WordToRun);
//#UC END# *4F219F4E03CB_4F2198430108set_impl*
end;//TkwCompiledWordWorkerWordRunner.pm_SetWordToRun

procedure TkwCompiledWordWorkerWordRunner.PushState(const aCtx: TtfwContext);
//#UC START# *4F3FF6C20122_4F2198430108_var*
//#UC END# *4F3FF6C20122_4F2198430108_var*
begin
//#UC START# *4F3FF6C20122_4F2198430108_impl*
 if WordToRun.ResultTypeInfo[aCtx].Has(tfw_wmCaller) then
  aCtx.rEngine.PushObj(Caller);
 PushWordToWork(aCtx);
//#UC END# *4F3FF6C20122_4F2198430108_impl*
end;//TkwCompiledWordWorkerWordRunner.PushState

procedure TkwCompiledWordWorkerWordRunner.PushWordToWork(const aCtx: TtfwContext);
//#UC START# *4F414A1A0247_4F2198430108_var*
var
 l_RightParamsCount : Integer;
 l_Index : Integer;
//#UC END# *4F414A1A0247_4F2198430108_var*
begin
//#UC START# *4F414A1A0247_4F2198430108_impl*
 if (f_LeftWordRefs <> nil) then
  for l_Index := 0 to Pred(f_LeftWordRefs.Count) do
   aCtx.rEngine.PushObj(f_LeftWordRefs.Items[l_Index]);

 l_RightParamsCount := WordToRun.RightParamsCount(aCtx);
 if (l_RightParamsCount = 1) then
  aCtx.rEngine.PushObj(WordToWork)
 else
 begin
  for l_Index := 0 to Pred(l_RightParamsCount) do
   aCtx.rEngine.PushObj((WordToWork As TkwRuntimeWordWithCode).Code[l_Index]);
 end;//l_RightParamsCount = 1
//#UC END# *4F414A1A0247_4F2198430108_impl*
end;//TkwCompiledWordWorkerWordRunner.PushWordToWork

procedure TkwCompiledWordWorkerWordRunner.DoCode(const aCtx: TtfwContext);
//#UC START# *558C303A01A1_4F2198430108_var*
//#UC END# *558C303A01A1_4F2198430108_var*
begin
//#UC START# *558C303A01A1_4F2198430108_impl*
 PushState(aCtx);
 // - ����� ��������� ������ � ����� �� ����
 WordToRun.DoIt(aCtx);
 // - ��������� ���������� ����������� �����
//#UC END# *558C303A01A1_4F2198430108_impl*
end;//TkwCompiledWordWorkerWordRunner.DoCode

function TkwCompiledWordWorkerWordRunner.ReturnsRef(const aCtx: TtfwContext): Boolean;
//#UC START# *558C30D10043_4F2198430108_var*
//#UC END# *558C30D10043_4F2198430108_var*
begin
//#UC START# *558C30D10043_4F2198430108_impl*
 Result := f_WordToRun.ResultTypeInfo[aCtx].Has(tfw_wmLeftWordRef);
//#UC END# *558C30D10043_4F2198430108_impl*
end;//TkwCompiledWordWorkerWordRunner.ReturnsRef

procedure TkwCompiledWordWorkerWordRunner.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F2198430108_var*
//#UC END# *4DAEEDE10285_4F2198430108_var*
begin
//#UC START# *4DAEEDE10285_4F2198430108_impl*
 if ReturnsRef(aCtx) then
  GetRef(aCtx).DoIt(aCtx)
 else
  DoCode(aCtx);
//#UC END# *4DAEEDE10285_4F2198430108_impl*
end;//TkwCompiledWordWorkerWordRunner.DoDoIt

procedure TkwCompiledWordWorkerWordRunner.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_4F2198430108_var*
//#UC END# *479731C50290_4F2198430108_var*
begin
//#UC START# *479731C50290_4F2198430108_impl*
 FreeAndNil(f_WordToRun);
 FreeAndNil(f_LeftWordRefs);
 inherited;
//#UC END# *479731C50290_4F2198430108_impl*
end;//TkwCompiledWordWorkerWordRunner.Cleanup

function TkwCompiledWordWorkerWordRunner.IsImmediate(const aCtx: TtfwContext): Boolean;
//#UC START# *4DB6D7F70155_4F2198430108_var*
//#UC END# *4DB6D7F70155_4F2198430108_var*
begin
//#UC START# *4DB6D7F70155_4F2198430108_impl*
 Result := f_WordToRun.ResultTypeInfo[aCtx].Has(tfw_wmImmediate);
//#UC END# *4DB6D7F70155_4F2198430108_impl*
end;//TkwCompiledWordWorkerWordRunner.IsImmediate

function TkwCompiledWordWorkerWordRunner.pm_GetResultTypeInfo(const aCtx: TtfwContext): TtfwWordInfo;
//#UC START# *52CFC11603C8_4F2198430108get_var*
//#UC END# *52CFC11603C8_4F2198430108get_var*
begin
//#UC START# *52CFC11603C8_4F2198430108get_impl*
 Result := f_WordToRun.ResultTypeInfo[aCtx];
(* if ReturnsRef(aCtx) then
  Result := inherited pm_GetResultTypeInfo(aCtx)
 else
  Result := f_WordToRun.ResultTypeInfo[aCtx];*)
//#UC END# *52CFC11603C8_4F2198430108get_impl*
end;//TkwCompiledWordWorkerWordRunner.pm_GetResultTypeInfo

procedure TkwCompiledWordWorkerWordRunner.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_4F2198430108_var*
//#UC END# *52D00B00031A_4F2198430108_var*
begin
//#UC START# *52D00B00031A_4F2198430108_impl*
 if ReturnsRef(aCtx) then
  GetRef(aCtx).SetValuePrim(aValue, aCtx)
 else
  RunnerAssert(false, '���� ���������� ��������� �������� ���������', aCtx);
//#UC END# *52D00B00031A_4F2198430108_impl*
end;//TkwCompiledWordWorkerWordRunner.SetValuePrim

function TkwCompiledWordWorkerWordRunner.LeftWordRefParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *53E4914101D2_4F2198430108_var*
//#UC END# *53E4914101D2_4F2198430108_var*
begin
//#UC START# *53E4914101D2_4F2198430108_impl*
 Result := WordToRun.LeftWordRefParamsCount(aCtx);
//#UC END# *53E4914101D2_4F2198430108_impl*
end;//TkwCompiledWordWorkerWordRunner.LeftWordRefParamsCount

procedure TkwCompiledWordWorkerWordRunner.AddLeftWordRefValue(const aCtx: TtfwContext;
 aValue: TtfwWord);
//#UC START# *53E49B2F01E4_4F2198430108_var*
//#UC END# *53E49B2F01E4_4F2198430108_var*
begin
//#UC START# *53E49B2F01E4_4F2198430108_impl*
 if (f_LeftWordRefs = nil) then
  f_LeftWordRefs := TtfwWordRefList.Create;
 f_LeftWordRefs.Insert(0, aValue);
//#UC END# *53E49B2F01E4_4F2198430108_impl*
end;//TkwCompiledWordWorkerWordRunner.AddLeftWordRefValue

function TkwCompiledWordWorkerWordRunner.GetLeftWordRefValue(const aCtx: TtfwContext;
 anIndex: Integer): TtfwWord;
//#UC START# *53E4A3C100AB_4F2198430108_var*
//#UC END# *53E4A3C100AB_4F2198430108_var*
begin
//#UC START# *53E4A3C100AB_4F2198430108_impl*
 CompilerAssert(f_LeftWordRefs <> nil, '���� �������� ��� ����� ���������� �� ������', aCtx);
 CompilerAssert((anIndex >= 0) AND (anIndex < f_LeftWordRefs.Count), '���� �������� ��� ������ ��������� �� ������, ��� ������� ' + IntToStr(anIndex), aCtx);
 Result := f_LeftWordRefs.Items[anIndex];
//#UC END# *53E4A3C100AB_4F2198430108_impl*
end;//TkwCompiledWordWorkerWordRunner.GetLeftWordRefValue

function TkwCompiledWordWorkerWordRunner.LeftWordRefValuesCount(const aCtx: TtfwContext): Integer;
//#UC START# *53E4A96A0085_4F2198430108_var*
//#UC END# *53E4A96A0085_4F2198430108_var*
begin
//#UC START# *53E4A96A0085_4F2198430108_impl*
 if (f_LeftWordRefs = nil) then
  Result := 0
 else
  Result := f_LeftWordRefs.Count; 
//#UC END# *53E4A96A0085_4F2198430108_impl*
end;//TkwCompiledWordWorkerWordRunner.LeftWordRefValuesCount

function TkwCompiledWordWorkerWordRunner.GetRef(const aCtx: TtfwContext): TtfwWord;
//#UC START# *558D2BCA0324_4F2198430108_var*
//#UC END# *558D2BCA0324_4F2198430108_var*
begin
//#UC START# *558D2BCA0324_4F2198430108_impl*
 if ReturnsRef(aCtx) then
 begin
  DoCode(aCtx);
  Result := aCtx.rEngine.PopObj As TtfwWord;
  Result := Result.GetRef(aCtx);
 end//ReturnsRef(aCtx)
 else
 begin
  Result := Self;
  //RunnerError('�������� ������ ���������� ������', aCtx);
 end;//ReturnsRef(aCtx)
//#UC END# *558D2BCA0324_4F2198430108_impl*
end;//TkwCompiledWordWorkerWordRunner.GetRef

procedure TkwCompiledWordWorkerWordRunner.SetValue(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *56096688024A_4F2198430108_var*
//#UC END# *56096688024A_4F2198430108_var*
begin
//#UC START# *56096688024A_4F2198430108_impl*
 if ReturnsRef(aCtx) then
  GetRef(aCtx).SetValue(aValue, aCtx)
 else
  RunnerAssert(false, '���� ���������� ��������� �������� ���������', aCtx);
//#UC END# *56096688024A_4F2198430108_impl*
end;//TkwCompiledWordWorkerWordRunner.SetValue

initialization
 TkwCompiledWordWorkerWordRunner.RegisterClass;
 {* ����������� TkwCompiledWordWorkerWordRunner }
{$IfEnd} // NOT Defined(NoScripts)

end.
