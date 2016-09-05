unit K601206322;
 {* [Requestlnk:601206322] }

// ������: "w:\common\components\rtl\Garant\Daily\K601206322.pas"
// ���������: "TestCase"
// ������� ������: "K601206322" MUID: (557ECAB103A9)
// ��� ����: "TK601206322"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK601206322 = class(TRTFtoEVDWriterTest)
  {* [Requestlnk:601206322] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK601206322
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *557ECAB103A9impl_uses*
 //#UC END# *557ECAB103A9impl_uses*
;

function TK601206322.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK601206322.GetFolder

function TK601206322.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '557ECAB103A9';
end;//TK601206322.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK601206322.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
