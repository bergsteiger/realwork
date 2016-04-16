unit K362130404;
 {* [Requestlink:362130404] }

// ������: "w:\archi\source\projects\Archi\Tests\K362130404.pas"
// ���������: "TestCase"
// ������� ������: "TK362130404" MUID: (4FCDBE96036B)

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
 TK362130404 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:362130404] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK362130404
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK362130404.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'OEMTextTests';
end;//TK362130404.GetFolder

function TK362130404.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4FCDBE96036B';
end;//TK362130404.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK362130404.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
