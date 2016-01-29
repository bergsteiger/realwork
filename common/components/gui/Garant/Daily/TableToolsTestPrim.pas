unit TableToolsTestPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "TestFormsTest"
// ������: "w:/common/components/gui/Garant/Daily/TableToolsTestPrim.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TTableToolsTestPrim
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  evEditorInterfaces,
  TextViaEditorProcessor,
  PrimTextLoad_Form
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
type
 TTableToolsTestPrim = {abstract} class(TTextViaEditorProcessor)
 protected
 // realized methods
   procedure Process(aForm: TPrimTextLoadForm); override;
     {* ���������� ������� ��������� ������ }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 protected
 // protected methods
   procedure ApplyTools(const aRange: IedRange); virtual; abstract;
     {* ������� ���������� ��� ������� }
   procedure CheckOperation(aForm: TPrimTextLoadForm); virtual; abstract;
     {* �������� ����� ���������� �����������. }
 end;//TTableToolsTestPrim
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  TestFrameWork,
  vcmBase,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}

// start class TTableToolsTestPrim

procedure TTableToolsTestPrim.Process(aForm: TPrimTextLoadForm);
//#UC START# *4BE13147032C_4CE38AD60265_var*
//#UC END# *4BE13147032C_4CE38AD60265_var*
begin
//#UC START# *4BE13147032C_4CE38AD60265_impl*
 ApplyTools(aForm.Text.Range);
 CheckOperation(aForm);
//#UC END# *4BE13147032C_4CE38AD60265_impl*
end;//TTableToolsTestPrim.Process

function TTableToolsTestPrim.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TTableToolsTestPrim.GetFolder

function TTableToolsTestPrim.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CE38AD60265';
end;//TTableToolsTestPrim.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.