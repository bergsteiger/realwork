unit K235058873;
 {* [$235058873] }

// ������: "w:\common\components\rtl\Garant\Daily\K235058873.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCPlusWriterTest
;

type
 TK235058873 = class(TEVDtoNSRCPlusWriterTest)
  {* [$235058873] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK235058873
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK235058873.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK235058873.GetFolder

function TK235058873.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CA2DC560112';
end;//TK235058873.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235058873.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
