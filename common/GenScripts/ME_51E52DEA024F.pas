unit K466752657;
 {* [Requestlink:466752657] }

// ������: "w:\archi\source\projects\Archi\Tests\K466752657.pas"
// ���������: "TestCase"
// ������� ������: "K466752657" MUID: (51E52DEA024F)
// ��� ����: "TK466752657"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , ArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TK466752657 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:466752657] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK466752657
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK466752657.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'FilterTests';
end;//TK466752657.GetFolder

function TK466752657.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '51E52DEA024F';
end;//TK466752657.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK466752657.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
