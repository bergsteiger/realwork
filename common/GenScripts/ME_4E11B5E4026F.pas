unit K272662869;
 {* [$272662869] }

// ������: "w:\common\components\rtl\Garant\Daily\K272662869.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HorzMergeCells
;

type
 TK272662869 = class(THorzMergeCells)
  {* [$272662869] }
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
 end;//TK272662869
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

function TK272662869.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK272662869.GetFolder

procedure TK272662869.GetSelectParam(out aStartRow: Integer;
 out aStartCell: Integer;
 out aFinishRow: Integer;
 out aFinishCell: Integer);
 {* �������� "����������" ����� ���������. }
//#UC START# *4CC81D4101AC_4E11B5E4026F_var*
//#UC END# *4CC81D4101AC_4E11B5E4026F_var*
begin
//#UC START# *4CC81D4101AC_4E11B5E4026F_impl*
 aStartRow := 0;
 aStartCell := 0;
 aFinishRow := 2;
 aFinishCell := 2;
//#UC END# *4CC81D4101AC_4E11B5E4026F_impl*
end;//TK272662869.GetSelectParam

function TK272662869.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4E11B5E4026F';
end;//TK272662869.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK272662869.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
