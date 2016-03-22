unit ColumnAlignHorisontallyTest;
 {* ������������ ������ � ������� ������������. }

// ������: "w:\common\components\rtl\Garant\Daily\ColumnAlignHorisontallyTest.pas"
// ���������: "TestCase"
// ������� ������: "TColumnAlignHorisontallyTest" MUID: (4C3C2BE800AF)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , TableToolsTest
 , evEditorInterfaces
;

type
 TColumnAlignHorisontallyTest = {abstract} class(TTableToolsTest)
  {* ������������ ������ � ������� ������������. }
  protected
   {$If NOT Defined(NoVCM)}
   procedure ApplyTools(const aRange: IedRange); override;
    {* ������� ���������� ��� ������� }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TColumnAlignHorisontallyTest
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
procedure TColumnAlignHorisontallyTest.ApplyTools(const aRange: IedRange);
 {* ������� ���������� ��� ������� }
//#UC START# *4C345B580083_4C3C2BE800AF_var*
//#UC END# *4C345B580083_4C3C2BE800AF_var*
begin
//#UC START# *4C345B580083_4C3C2BE800AF_impl*
 aRange.TextParagraph.Formatting.HorizontalAligment := ed_halLeft; 
//#UC END# *4C345B580083_4C3C2BE800AF_impl*
end;//TColumnAlignHorisontallyTest.ApplyTools
{$IfEnd} // NOT Defined(NoVCM)

function TColumnAlignHorisontallyTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TColumnAlignHorisontallyTest.GetFolder

function TColumnAlignHorisontallyTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C3C2BE800AF';
end;//TColumnAlignHorisontallyTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
