unit kwFiltersAndGeneratorsPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwFiltersAndGeneratorsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3Variant
 , l3Interfaces
 , Classes
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , k2EVDReaderService
 , k2EVDWriterService
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 //#UC START# *9EE368A1435Dci*
 //#UC END# *9EE368A1435Dci*
 //#UC START# *9EE368A1435Dcit*
 //#UC END# *9EE368A1435Dcit*
 TkwFiltersAndGeneratorsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
  public
   class function ResName: AnsiString; override;
 //#UC START# *9EE368A1435Dpubl*
 //#UC END# *9EE368A1435Dpubl*
 end;//TkwFiltersAndGeneratorsPackResNameGetter

 TkwGeneratorsExecute = {final} class(TtfwClassLike)
  {* ����� ������� generators:Execute
[panel]���� �� ����� ��� ��� �������� ����� (EVD) � ��������� (��� �������). ����� ������ ����� � ��������� ����� �� ����.[panel]
*������:*
[code]
 aFileName aTagGenerator generators:Execute
[code]  }
  private
   procedure generators_Execute(const aCtx: TtfwContext;
    const aTagGenerator: Ik2TagGenerator;
    const aFileName: AnsiString);
    {* ���������� ����� ������� generators:Execute }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwGeneratorsExecute

 TkwGeneratorsLink = {final} class(TtfwClassLike)
  {* ����� ������� generators:Link
[panel]���� �� ����� ��� ���������� � ������ �� ��� �������. � ���������� �� ����� ������� ���� ��������� (� �������� �������� ������)[panel]
*��� ����������:* Ik2TagGenerator
*������:*
[code]
INTERFACE VAR l_Ik2TagGenerator
 aGenHead aTagGenerator generators:Link >>> l_Ik2TagGenerator
[code]  }
  private
   function generators_Link(const aCtx: TtfwContext;
    const aTagGenerator: Ik2TagGenerator;
    const aGenHead: Ik2TagGenerator): Ik2TagGenerator;
    {* ���������� ����� ������� generators:Link }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwGeneratorsLink

class function TkwFiltersAndGeneratorsPackResNameGetter.ResName: AnsiString;
begin
  Result := 'kwFiltersAndGeneratorsPack';
end;//TkwFiltersAndGeneratorsPackResNameGetter.ResName

 {$R kwFiltersAndGeneratorsPack.res}

procedure TkwGeneratorsExecute.generators_Execute(const aCtx: TtfwContext;
 const aTagGenerator: Ik2TagGenerator;
 const aFileName: AnsiString);
 {* ���������� ����� ������� generators:Execute }
//#UC START# *51B232178794_825779F5AD08_var*
var
 l_Filt: Ik2TagGenerator;
 l_InFN: AnsiString;
 l_OutFN: AnsiString;
 l_Reader: Il3Reader;
 l_Writer: Ik2TagGenerator;
//#UC END# *51B232178794_825779F5AD08_var*
begin
//#UC START# *51B232178794_825779F5AD08_impl*
 l_InFN := aFileName;
 l_OutFN := aCtx.rCaller.ResolveOutputFilePath(l_InFN);
 l_InFN := aCtx.rCaller.ResolveInputFilePath(l_InFN);
 RunnerAssert(FileExists(l_InFN), Format('generators:Execute - ������� ���� (%s) �� ������', [l_InFN]), aCtx);
 l_Reader := Tk2EVDReaderService.Instance.MakeReader(l_InFN, aTagGenerator);
 try
  l_Filt := aTagGenerator;
  while l_Filt.NextGenerator <> nil do
   l_Filt := l_Filt.NextGenerator;
  l_Writer := Tk2EVDWriterService.Instance.MakeWriter(l_OutFN);
  try
   l_Filt.NextGenerator := l_Writer;
   l_Reader.Execute;
  finally
   l_Writer := nil;
  end;//try..finally
 finally
  l_Reader := nil;
 end;//try..finally
//#UC END# *51B232178794_825779F5AD08_impl*
end;//TkwGeneratorsExecute.generators_Execute

procedure TkwGeneratorsExecute.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_825779F5AD08_var*
//#UC END# *4DAEEDE10285_825779F5AD08_var*
begin
//#UC START# *4DAEEDE10285_825779F5AD08_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_825779F5AD08_impl*
end;//TkwGeneratorsExecute.DoDoIt

class function TkwGeneratorsExecute.GetWordNameForRegister: AnsiString;
begin
 Result := 'generators:Execute';
end;//TkwGeneratorsExecute.GetWordNameForRegister

function TkwGeneratorsExecute.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_825779F5AD08_var*
//#UC END# *551544E2001A_825779F5AD08_var*
begin
//#UC START# *551544E2001A_825779F5AD08_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_825779F5AD08_impl*
end;//TkwGeneratorsExecute.GetResultTypeInfo

function TkwGeneratorsExecute.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_825779F5AD08_var*
//#UC END# *559687E6025A_825779F5AD08_var*
begin
//#UC START# *559687E6025A_825779F5AD08_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_825779F5AD08_impl*
end;//TkwGeneratorsExecute.GetAllParamsCount

function TkwGeneratorsExecute.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_825779F5AD08_var*
//#UC END# *5617F4D00243_825779F5AD08_var*
begin
//#UC START# *5617F4D00243_825779F5AD08_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_825779F5AD08_impl*
end;//TkwGeneratorsExecute.ParamsTypes

function TkwGeneratorsLink.generators_Link(const aCtx: TtfwContext;
 const aTagGenerator: Ik2TagGenerator;
 const aGenHead: Ik2TagGenerator): Ik2TagGenerator;
 {* ���������� ����� ������� generators:Link }
//#UC START# *C44F9D8AB364_E6DB290D23D7_var*
var
 l_GenHead: Ik2TagGenerator;
//#UC END# *C44F9D8AB364_E6DB290D23D7_var*
begin
//#UC START# *C44F9D8AB364_E6DB290D23D7_impl*
 l_GenHead := aGenHead;
 while (l_GenHead.NextGenerator <> nil) do
  l_GenHead := l_GenHead.NextGenerator;
 l_GenHead.NextGenerator := aTagGenerator;
 Result := aGenHead;
//#UC END# *C44F9D8AB364_E6DB290D23D7_impl*
end;//TkwGeneratorsLink.generators_Link

procedure TkwGeneratorsLink.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E6DB290D23D7_var*
//#UC END# *4DAEEDE10285_E6DB290D23D7_var*
begin
//#UC START# *4DAEEDE10285_E6DB290D23D7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E6DB290D23D7_impl*
end;//TkwGeneratorsLink.DoDoIt

class function TkwGeneratorsLink.GetWordNameForRegister: AnsiString;
begin
 Result := 'generators:Link';
end;//TkwGeneratorsLink.GetWordNameForRegister

function TkwGeneratorsLink.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_E6DB290D23D7_var*
//#UC END# *551544E2001A_E6DB290D23D7_var*
begin
//#UC START# *551544E2001A_E6DB290D23D7_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_E6DB290D23D7_impl*
end;//TkwGeneratorsLink.GetResultTypeInfo

function TkwGeneratorsLink.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_E6DB290D23D7_var*
//#UC END# *559687E6025A_E6DB290D23D7_var*
begin
//#UC START# *559687E6025A_E6DB290D23D7_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_E6DB290D23D7_impl*
end;//TkwGeneratorsLink.GetAllParamsCount

function TkwGeneratorsLink.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_E6DB290D23D7_var*
//#UC END# *5617F4D00243_E6DB290D23D7_var*
begin
//#UC START# *5617F4D00243_E6DB290D23D7_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_E6DB290D23D7_impl*
end;//TkwGeneratorsLink.ParamsTypes

initialization
 TkwFiltersAndGeneratorsPackResNameGetter.Register;
 {* ����������� ������������ ����������� }
 TkwGeneratorsExecute.RegisterInEngine;
 {* ����������� generators_Execute }
 TkwGeneratorsLink.RegisterInEngine;
 {* ����������� generators_Link }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ik2TagGenerator));
 {* ����������� ���� Ik2TagGenerator }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* ����������� ���� String }
{$IfEnd} // NOT Defined(NoScripts)

end.
