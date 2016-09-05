unit K612968853;
 {* [Requestlink:612968853] }

// ������: "w:\common\components\rtl\Garant\Daily\K612968853.pas"
// ���������: "TestCase"
// ������� ������: "K612968853" MUID: (56614EAD032D)
// ��� ����: "TK612968853"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK612968853 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:612968853] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK612968853
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *56614EAD032Dimpl_uses*
 //#UC END# *56614EAD032Dimpl_uses*
;

function TK612968853.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK612968853.GetFolder

function TK612968853.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56614EAD032D';
end;//TK612968853.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK612968853.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
