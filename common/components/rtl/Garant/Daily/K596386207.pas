unit K596386207;
 {* [Requestlink:596386207] }

// ������: "w:\common\components\rtl\Garant\Daily\K596386207.pas"
// ���������: "TestCase"
// ������� ������: "K596386207" MUID: (55277CB702C8)
// ��� ����: "TK596386207"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK596386207 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:596386207] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK596386207
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *55277CB702C8impl_uses*
 //#UC END# *55277CB702C8impl_uses*
;

function TK596386207.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK596386207.GetFolder

function TK596386207.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '55277CB702C8';
end;//TK596386207.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK596386207.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
