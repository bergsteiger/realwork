unit K234357754;
 {* [$234357754] }

// ������: "w:\common\components\rtl\Garant\Daily\K234357754.pas"
// ���������: "TestCase"
// ������� ������: "K234357754" MUID: (4CE13064009E)
// ��� ����: "TK234357754"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , MergeAndCheckSelectionTest
;

type
 TK234357754 = class(TMergeAndCheckSelectionTest)
  {* [$234357754] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   procedure GetSelectParam(out aStartRow: Integer;
    out aStartCell: Integer;
    out aFinishRow: Integer;
    out aFinishCell: Integer); override;
    {* �������� "����������" ����� ���������. }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK234357754
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , l3Base
 , evOp
 , l3InternalInterfaces
 , evTypes
 , evMsgCode
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
;

function TK234357754.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK234357754.GetFolder

procedure TK234357754.GetSelectParam(out aStartRow: Integer;
 out aStartCell: Integer;
 out aFinishRow: Integer;
 out aFinishCell: Integer);
 {* �������� "����������" ����� ���������. }
//#UC START# *4CC81D4101AC_4CE13064009E_var*
//#UC END# *4CC81D4101AC_4CE13064009E_var*
begin
//#UC START# *4CC81D4101AC_4CE13064009E_impl*
 aStartRow := 0;
 aStartCell := 1;
 aFinishRow := 1;
 aFinishCell := 2;
//#UC END# *4CC81D4101AC_4CE13064009E_impl*
end;//TK234357754.GetSelectParam

function TK234357754.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CE13064009E';
end;//TK234357754.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK234357754.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
