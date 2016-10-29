unit msmModelElementMethodCallerPack;

// ������: "w:\common\components\gui\Garant\msm\msmModelElementMethodCallerPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "msmModelElementMethodCallerPack" MUID: (580E9BCF034D)

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
 , TypInfo
 , msmModelElementMethodCaller
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *580E9BCF034Dimpl_uses*
 //#UC END# *580E9BCF034Dimpl_uses*
;

type
 TkwMsmCallSetter = {final} class(TtfwGlobalKeyWord)
  {* ����� ������� msm:CallSetter }
  private
   procedure msm_CallSetter(const aCtx: TtfwContext;
    aWord: TtfwWord;
    const aMethodName: AnsiString;
    const aValue: TtfwStackValue);
    {* ���������� ����� ������� msm:CallSetter }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMsmCallSetter

procedure TkwMsmCallSetter.msm_CallSetter(const aCtx: TtfwContext;
 aWord: TtfwWord;
 const aMethodName: AnsiString;
 const aValue: TtfwStackValue);
 {* ���������� ����� ������� msm:CallSetter }
//#UC START# *580E9C0901F9_580E9C0901F9_Word_var*
//#UC END# *580E9C0901F9_580E9C0901F9_Word_var*
begin
//#UC START# *580E9C0901F9_580E9C0901F9_Word_impl*
 TmsmModelElementMethodCaller.CallSetter(aWord, aMethodName, aValue);
//#UC END# *580E9C0901F9_580E9C0901F9_Word_impl*
end;//TkwMsmCallSetter.msm_CallSetter

class function TkwMsmCallSetter.GetWordNameForRegister: AnsiString;
begin
 Result := 'msm:CallSetter';
end;//TkwMsmCallSetter.GetWordNameForRegister

function TkwMsmCallSetter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwMsmCallSetter.GetResultTypeInfo

function TkwMsmCallSetter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwMsmCallSetter.GetAllParamsCount

function TkwMsmCallSetter.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord), @tfw_tiString, @tfw_tiStruct]);
end;//TkwMsmCallSetter.ParamsTypes

procedure TkwMsmCallSetter.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
var l_aMethodName: AnsiString;
var l_aValue: TtfwStackValue;
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
  l_aMethodName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMethodName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aValue: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 msm_CallSetter(aCtx, l_aWord, l_aMethodName, l_aValue);
end;//TkwMsmCallSetter.DoDoIt

initialization
 TkwMsmCallSetter.RegisterInEngine;
 {* ����������� msm_CallSetter }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* ����������� ���� TtfwWord }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* ����������� ���� AnsiString }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwStackValue }
{$IfEnd} // NOT Defined(NoScripts)

end.
