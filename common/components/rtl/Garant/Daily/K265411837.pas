unit K265411837;
 {* [$265411837] }

// ������: "w:\common\components\rtl\Garant\Daily\K265411837.pas"
// ���������: "TestCase"
// ������� ������: "K265411837" MUID: (4DCA1DB203B7)
// ��� ����: "TK265411837"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HorzMergeCells
;

type
 TK265411837 = class(THorzMergeCells)
  {* [$265411837] }
  protected
   procedure GetSelectParam(out aStartRow: Integer;
    out aStartCell: Integer;
    out aFinishRow: Integer;
    out aFinishCell: Integer); override;
    {* �������� "����������" ����� ���������. }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK265411837
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

procedure TK265411837.GetSelectParam(out aStartRow: Integer;
 out aStartCell: Integer;
 out aFinishRow: Integer;
 out aFinishCell: Integer);
 {* �������� "����������" ����� ���������. }
//#UC START# *4CC81D4101AC_4DCA1DB203B7_var*
//#UC END# *4CC81D4101AC_4DCA1DB203B7_var*
begin
//#UC START# *4CC81D4101AC_4DCA1DB203B7_impl*
 aStartRow := 0;
 aStartCell := 3;
 aFinishRow := 1;
 aFinishCell := 5;
//#UC END# *4CC81D4101AC_4DCA1DB203B7_impl*
end;//TK265411837.GetSelectParam

function TK265411837.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK265411837.GetFolder

function TK265411837.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4DCA1DB203B7';
end;//TK265411837.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK265411837.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
