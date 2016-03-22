unit MergeTablesTest;
 {* ������������ ����������� ������ }

// ������: "w:\common\components\rtl\Garant\Daily\MergeTablesTest.pas"
// ���������: "TestCase"
// ������� ������: "TMergeTablesTest" MUID: (4C3AF74701A6)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , TableToolsTest
 , evEditorInterfaces
;

type
 TMergeTablesTest = {abstract} class(TTableToolsTest)
  {* ������������ ����������� ������ }
  protected
   {$If NOT Defined(NoVCM)}
   procedure ApplyTools(const aRange: IedRange); override;
    {* ������� ���������� ��� ������� }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function NeedSelection: Boolean; override;
    {* ����� �� ����-������ ��������. }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TMergeTablesTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
 {$If Defined(k2ForEditor)}
 , evCursorTools
 {$IfEnd} // Defined(k2ForEditor)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

{$If NOT Defined(NoVCM)}
procedure TMergeTablesTest.ApplyTools(const aRange: IedRange);
 {* ������� ���������� ��� ������� }
//#UC START# *4C345B580083_4C3AF74701A6_var*
//#UC END# *4C345B580083_4C3AF74701A6_var*
begin
//#UC START# *4C345B580083_4C3AF74701A6_impl*
 aRange.Table.Merge(nil);
//#UC END# *4C345B580083_4C3AF74701A6_impl*
end;//TMergeTablesTest.ApplyTools
{$IfEnd} // NOT Defined(NoVCM)

function TMergeTablesTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TMergeTablesTest.GetFolder

function TMergeTablesTest.NeedSelection: Boolean;
 {* ����� �� ����-������ ��������. }
//#UC START# *4CC8189D02DF_4C3AF74701A6_var*
//#UC END# *4CC8189D02DF_4C3AF74701A6_var*
begin
//#UC START# *4CC8189D02DF_4C3AF74701A6_impl*
 Result := False;
//#UC END# *4CC8189D02DF_4C3AF74701A6_impl*
end;//TMergeTablesTest.NeedSelection

function TMergeTablesTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C3AF74701A6';
end;//TMergeTablesTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
