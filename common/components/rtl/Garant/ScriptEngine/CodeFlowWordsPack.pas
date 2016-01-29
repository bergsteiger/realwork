unit CodeFlowWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine"
// ������: "CodeFlowWordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi Low Level::ScriptEngine::CodeFlowWords::CodeFlowWordsPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwScriptingInterfaces,
  tfwWordWorkerEx
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  seModalSupport,
  l3AFWExceptions,
  seThreadSupport,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 TkwMODAL = {final scriptword} class(TtfwWordWorkerEx)
  {* ����� ������� MODAL
*������:*
[code]
 aBeforeModal MODAL aWord
[code]  }
 private
 // private methods
   procedure MODAL(const aCtx: TtfwContext;
    aWord: TtfwWord;
    aBeforeModal: TtfwWord);
     {* ���������� ����� ������� MODAL }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function RightParamsCount(const aCtx: TtfwContext): Integer; override;
   procedure DoRun(const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMODAL

// start class TkwMODAL

procedure TkwMODAL.MODAL(const aCtx: TtfwContext;
  aWord: TtfwWord;
  aBeforeModal: TtfwWord);
//#UC START# *D14B34278240_05ABA7975E25_var*
var
 l_Count : Integer;
//#UC END# *D14B34278240_05ABA7975E25_var*
begin
//#UC START# *D14B34278240_05ABA7975E25_impl*
 l_Count := seAddModalWorker(aWord, aCtx);
 try
  try
   aBeforeModal.DoIt(aCtx);
  except
(*   {$If defined(nsTest)}
   on El3TryEnterModalState do
    Exit;
   {$Else}*)
   // - ���������������, �.�. ��������� - ����� � ������ ��� ���������� ������
   raise;
(*   {$IfEnd} //nsTest*)
  end;//try..except
 finally
  RunnerAssert(seIsValidModalWorkersCount(l_Count), '������ �� ���������� ��� ���������� ����', aCtx);
 end;//try..finally
//#UC END# *D14B34278240_05ABA7975E25_impl*
end;//TkwMODAL.MODAL

class function TkwMODAL.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'MODAL';
end;//TkwMODAL.GetWordNameForRegister

function TkwMODAL.RightParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwMODAL.RightParamsCount

procedure TkwMODAL.DoRun(const aCtx: TtfwContext);
 {-}
var
 l_aWord : TtfwWord;
 l_aBeforeModal : TtfwWord;
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
  l_aBeforeModal := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord, true));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aBeforeModal: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 MODAL(aCtx, l_aWord, l_aBeforeModal);
end;//TkwMODAL.DoRun

function TkwMODAL.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwMODAL.GetResultTypeInfo

function TkwMODAL.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwMODAL.GetAllParamsCount

function TkwMODAL.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord), TypeInfo(TtfwWord)]);
end;//TkwMODAL.ParamsTypes

type
 TkwTHREAD = {final scriptword} class(TtfwWordWorkerEx)
  {* ����� ������� THREAD
*������:*
[code]
 THREAD aWord
[code]  }
 private
 // private methods
   procedure THREAD(const aCtx: TtfwContext;
    aWord: TtfwWord);
     {* ���������� ����� ������� THREAD }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function RightParamsCount(const aCtx: TtfwContext): Integer; override;
   procedure DoRun(const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTHREAD

// start class TkwTHREAD

procedure TkwTHREAD.THREAD(const aCtx: TtfwContext;
  aWord: TtfwWord);
//#UC START# *A56425D1C72F_44C318D8896A_var*
//#UC END# *A56425D1C72F_44C318D8896A_var*
begin
//#UC START# *A56425D1C72F_44C318D8896A_impl*
 TseWorkThreadList.Instance.AddAndResumeThread(aCtx, aWord);
//#UC END# *A56425D1C72F_44C318D8896A_impl*
end;//TkwTHREAD.THREAD

class function TkwTHREAD.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'THREAD';
end;//TkwTHREAD.GetWordNameForRegister

function TkwTHREAD.RightParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwTHREAD.RightParamsCount

procedure TkwTHREAD.DoRun(const aCtx: TtfwContext);
 {-}
var
 l_aWord : TtfwWord;
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
 THREAD(aCtx, l_aWord);
end;//TkwTHREAD.DoRun

function TkwTHREAD.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwTHREAD.GetResultTypeInfo

function TkwTHREAD.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwTHREAD.GetAllParamsCount

function TkwTHREAD.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwTHREAD.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� MODAL
 TkwMODAL.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� THREAD
 TkwTHREAD.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwWord
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
{$IfEnd} //not NoScripts

end.