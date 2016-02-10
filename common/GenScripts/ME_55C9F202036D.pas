unit ITestWordsPack;

// ������: "w:\common\components\rtl\Garant\DUnit_Script_Support\ITestWordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include dsDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
 , TestFrameWork
 , tfwAxiomaticsResNameGetter
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , TypInfo
 , tfwGlobalKeyWord
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 //#UC START# *5BD9647988E7ci*
 //#UC END# *5BD9647988E7ci*
 //#UC START# *5BD9647988E7cit*
 //#UC END# *5BD9647988E7cit*
 TITestWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
  public
   class function ResName: AnsiString; override;
 //#UC START# *5BD9647988E7publ*
 //#UC END# *5BD9647988E7publ*
 end;//TITestWordsPackResNameGetter

 TkwPopTestName = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:Test:Name
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aTest pop:Test:Name >>> l_String
[code]  }
  private
   function Name(const aCtx: TtfwContext;
    const aTest: ITest): AnsiString;
    {* ���������� ����� ������� pop:Test:Name }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTestName

 TkwPopTestEnabled = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:Test:Enabled
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aTest pop:Test:Enabled >>> l_Boolean
[code]  }
  private
   function Enabled(const aCtx: TtfwContext;
    const aTest: ITest): Boolean;
    {* ���������� ����� ������� pop:Test:Enabled }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTestEnabled

 TkwPopTestSubFolder = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:Test:SubFolder
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aTest pop:Test:SubFolder >>> l_String
[code]  }
  private
   function SubFolder(const aCtx: TtfwContext;
    const aTest: ITest): AnsiString;
    {* ���������� ����� ������� pop:Test:SubFolder }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTestSubFolder

 TkwPopTestHasScriptChildren = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:Test:HasScriptChildren
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aTest pop:Test:HasScriptChildren >>> l_Boolean
[code]  }
  private
   function HasScriptChildren(const aCtx: TtfwContext;
    const aTest: ITest): Boolean;
    {* ���������� ����� ������� pop:Test:HasScriptChildren }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTestHasScriptChildren

 TkwTestShouldStop = {final} class(TtfwGlobalKeyWord)
  {* ����� ������� test:ShouldStop
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 test:ShouldStop >>> l_Boolean
[code]  }
  private
   function test_ShouldStop(const aCtx: TtfwContext): Boolean;
    {* ���������� ����� ������� test:ShouldStop }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTestShouldStop

class function TITestWordsPackResNameGetter.ResName: AnsiString;
begin
  Result := 'ITestWordsPack';
end;//TITestWordsPackResNameGetter.ResName

 {$R ITestWordsPack.res}

function TkwPopTestName.Name(const aCtx: TtfwContext;
 const aTest: ITest): AnsiString;
 {* ���������� ����� ������� pop:Test:Name }
//#UC START# *088392F066BE_E6DE6CAD7EFE_var*
//#UC END# *088392F066BE_E6DE6CAD7EFE_var*
begin
//#UC START# *088392F066BE_E6DE6CAD7EFE_impl*
 !!! Needs to be implemented !!!
//#UC END# *088392F066BE_E6DE6CAD7EFE_impl*
end;//TkwPopTestName.Name

procedure TkwPopTestName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E6DE6CAD7EFE_var*
//#UC END# *4DAEEDE10285_E6DE6CAD7EFE_var*
begin
//#UC START# *4DAEEDE10285_E6DE6CAD7EFE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E6DE6CAD7EFE_impl*
end;//TkwPopTestName.DoDoIt

class function TkwPopTestName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Test:Name';
end;//TkwPopTestName.GetWordNameForRegister

procedure TkwPopTestName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_E6DE6CAD7EFE_var*
//#UC END# *52D00B00031A_E6DE6CAD7EFE_var*
begin
//#UC START# *52D00B00031A_E6DE6CAD7EFE_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_E6DE6CAD7EFE_impl*
end;//TkwPopTestName.SetValuePrim

function TkwPopTestName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopTestName.GetResultTypeInfo

function TkwPopTestName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTestName.GetAllParamsCount

function TkwPopTestName.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_E6DE6CAD7EFE_var*
//#UC END# *5617F4D00243_E6DE6CAD7EFE_var*
begin
//#UC START# *5617F4D00243_E6DE6CAD7EFE_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_E6DE6CAD7EFE_impl*
end;//TkwPopTestName.ParamsTypes

function TkwPopTestEnabled.Enabled(const aCtx: TtfwContext;
 const aTest: ITest): Boolean;
 {* ���������� ����� ������� pop:Test:Enabled }
//#UC START# *D72537763731_1CEB5B8AA2E5_var*
//#UC END# *D72537763731_1CEB5B8AA2E5_var*
begin
//#UC START# *D72537763731_1CEB5B8AA2E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *D72537763731_1CEB5B8AA2E5_impl*
end;//TkwPopTestEnabled.Enabled

procedure TkwPopTestEnabled.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1CEB5B8AA2E5_var*
//#UC END# *4DAEEDE10285_1CEB5B8AA2E5_var*
begin
//#UC START# *4DAEEDE10285_1CEB5B8AA2E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1CEB5B8AA2E5_impl*
end;//TkwPopTestEnabled.DoDoIt

class function TkwPopTestEnabled.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Test:Enabled';
end;//TkwPopTestEnabled.GetWordNameForRegister

procedure TkwPopTestEnabled.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_1CEB5B8AA2E5_var*
//#UC END# *52D00B00031A_1CEB5B8AA2E5_var*
begin
//#UC START# *52D00B00031A_1CEB5B8AA2E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_1CEB5B8AA2E5_impl*
end;//TkwPopTestEnabled.SetValuePrim

function TkwPopTestEnabled.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopTestEnabled.GetResultTypeInfo

function TkwPopTestEnabled.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTestEnabled.GetAllParamsCount

function TkwPopTestEnabled.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_1CEB5B8AA2E5_var*
//#UC END# *5617F4D00243_1CEB5B8AA2E5_var*
begin
//#UC START# *5617F4D00243_1CEB5B8AA2E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_1CEB5B8AA2E5_impl*
end;//TkwPopTestEnabled.ParamsTypes

function TkwPopTestSubFolder.SubFolder(const aCtx: TtfwContext;
 const aTest: ITest): AnsiString;
 {* ���������� ����� ������� pop:Test:SubFolder }
//#UC START# *DA47640487D6_4638C704D78B_var*
//#UC END# *DA47640487D6_4638C704D78B_var*
begin
//#UC START# *DA47640487D6_4638C704D78B_impl*
 Result := aTest.GetSubFolder;
//#UC END# *DA47640487D6_4638C704D78B_impl*
end;//TkwPopTestSubFolder.SubFolder

procedure TkwPopTestSubFolder.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4638C704D78B_var*
//#UC END# *4DAEEDE10285_4638C704D78B_var*
begin
//#UC START# *4DAEEDE10285_4638C704D78B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4638C704D78B_impl*
end;//TkwPopTestSubFolder.DoDoIt

class function TkwPopTestSubFolder.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Test:SubFolder';
end;//TkwPopTestSubFolder.GetWordNameForRegister

procedure TkwPopTestSubFolder.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_4638C704D78B_var*
//#UC END# *52D00B00031A_4638C704D78B_var*
begin
//#UC START# *52D00B00031A_4638C704D78B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_4638C704D78B_impl*
end;//TkwPopTestSubFolder.SetValuePrim

function TkwPopTestSubFolder.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopTestSubFolder.GetResultTypeInfo

function TkwPopTestSubFolder.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTestSubFolder.GetAllParamsCount

function TkwPopTestSubFolder.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_4638C704D78B_var*
//#UC END# *5617F4D00243_4638C704D78B_var*
begin
//#UC START# *5617F4D00243_4638C704D78B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_4638C704D78B_impl*
end;//TkwPopTestSubFolder.ParamsTypes

function TkwPopTestHasScriptChildren.HasScriptChildren(const aCtx: TtfwContext;
 const aTest: ITest): Boolean;
 {* ���������� ����� ������� pop:Test:HasScriptChildren }
//#UC START# *DC8D3C4D047E_719F0EEEAFD0_var*
//#UC END# *DC8D3C4D047E_719F0EEEAFD0_var*
begin
//#UC START# *DC8D3C4D047E_719F0EEEAFD0_impl*
 !!! Needs to be implemented !!!
//#UC END# *DC8D3C4D047E_719F0EEEAFD0_impl*
end;//TkwPopTestHasScriptChildren.HasScriptChildren

procedure TkwPopTestHasScriptChildren.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_719F0EEEAFD0_var*
//#UC END# *4DAEEDE10285_719F0EEEAFD0_var*
begin
//#UC START# *4DAEEDE10285_719F0EEEAFD0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_719F0EEEAFD0_impl*
end;//TkwPopTestHasScriptChildren.DoDoIt

class function TkwPopTestHasScriptChildren.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Test:HasScriptChildren';
end;//TkwPopTestHasScriptChildren.GetWordNameForRegister

procedure TkwPopTestHasScriptChildren.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_719F0EEEAFD0_var*
//#UC END# *52D00B00031A_719F0EEEAFD0_var*
begin
//#UC START# *52D00B00031A_719F0EEEAFD0_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_719F0EEEAFD0_impl*
end;//TkwPopTestHasScriptChildren.SetValuePrim

function TkwPopTestHasScriptChildren.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopTestHasScriptChildren.GetResultTypeInfo

function TkwPopTestHasScriptChildren.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTestHasScriptChildren.GetAllParamsCount

function TkwPopTestHasScriptChildren.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_719F0EEEAFD0_var*
//#UC END# *5617F4D00243_719F0EEEAFD0_var*
begin
//#UC START# *5617F4D00243_719F0EEEAFD0_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_719F0EEEAFD0_impl*
end;//TkwPopTestHasScriptChildren.ParamsTypes

function TkwTestShouldStop.test_ShouldStop(const aCtx: TtfwContext): Boolean;
 {* ���������� ����� ������� test:ShouldStop }
//#UC START# *4E0E008C1CF6_AFCC4A8F1DF4_var*
//#UC END# *4E0E008C1CF6_AFCC4A8F1DF4_var*
begin
//#UC START# *4E0E008C1CF6_AFCC4A8F1DF4_impl*
 Result := aCtx.rCaller.ShouldStop;
//#UC END# *4E0E008C1CF6_AFCC4A8F1DF4_impl*
end;//TkwTestShouldStop.test_ShouldStop

procedure TkwTestShouldStop.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_AFCC4A8F1DF4_var*
//#UC END# *4DAEEDE10285_AFCC4A8F1DF4_var*
begin
//#UC START# *4DAEEDE10285_AFCC4A8F1DF4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_AFCC4A8F1DF4_impl*
end;//TkwTestShouldStop.DoDoIt

class function TkwTestShouldStop.GetWordNameForRegister: AnsiString;
begin
 Result := 'test:ShouldStop';
end;//TkwTestShouldStop.GetWordNameForRegister

function TkwTestShouldStop.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwTestShouldStop.GetResultTypeInfo

function TkwTestShouldStop.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwTestShouldStop.GetAllParamsCount

function TkwTestShouldStop.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_AFCC4A8F1DF4_var*
//#UC END# *5617F4D00243_AFCC4A8F1DF4_var*
begin
//#UC START# *5617F4D00243_AFCC4A8F1DF4_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_AFCC4A8F1DF4_impl*
end;//TkwTestShouldStop.ParamsTypes

initialization
 TITestWordsPackResNameGetter.Register;
 {* ����������� ������������ ����������� }
 TkwPopTestName.RegisterInEngine;
 {* ����������� pop_Test_Name }
 TkwPopTestEnabled.RegisterInEngine;
 {* ����������� pop_Test_Enabled }
 TkwPopTestSubFolder.RegisterInEngine;
 {* ����������� pop_Test_SubFolder }
 TkwPopTestHasScriptChildren.RegisterInEngine;
 {* ����������� pop_Test_HasScriptChildren }
 TkwTestShouldStop.RegisterInEngine;
 {* ����������� test_ShouldStop }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ITest));
 {* ����������� ���� ITest }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* ����������� ���� String }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* ����������� ���� Boolean }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
