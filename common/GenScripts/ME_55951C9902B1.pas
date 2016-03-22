unit K602943932;
 {* [Requestlink:602943932] }

// ������: "w:\common\components\rtl\Garant\Daily\K602943932.pas"
// ���������: "TestCase"
// ������� ������: "K602943932" MUID: (55951C9902B1)
// ��� ����: "TK602943932"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK602943932 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:602943932] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK602943932
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK602943932.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK602943932.GetFolder

function TK602943932.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '55951C9902B1';
end;//TK602943932.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK602943932.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
