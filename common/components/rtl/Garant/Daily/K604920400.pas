unit K604920400;
 {* [Requestlink:604920400] }

// ������: "w:\common\components\rtl\Garant\Daily\K604920400.pas"
// ���������: "TestCase"
// ������� ������: "K604920400" MUID: (55C36847033E)
// ��� ����: "TK604920400"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK604920400 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:604920400] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK604920400
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *55C36847033Eimpl_uses*
 //#UC END# *55C36847033Eimpl_uses*
;

function TK604920400.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK604920400.GetFolder

function TK604920400.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '55C36847033E';
end;//TK604920400.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK604920400.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
