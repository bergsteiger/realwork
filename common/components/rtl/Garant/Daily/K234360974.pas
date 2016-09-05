unit K234360974;
 {* [RequestLink:234360974]. }

// ������: "w:\common\components\rtl\Garant\Daily\K234360974.pas"
// ���������: "TestCase"
// ������� ������: "K234360974" MUID: (4C920E240280)
// ��� ����: "TK234360974"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , MoveSubTest
;

type
 TK234360974 = class(TMoveSubTest)
  {* [RequestLink:234360974]. }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK234360974
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
 //#UC START# *4C920E240280impl_uses*
 //#UC END# *4C920E240280impl_uses*
;

function TK234360974.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK234360974.GetFolder

function TK234360974.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C920E240280';
end;//TK234360974.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK234360974.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
