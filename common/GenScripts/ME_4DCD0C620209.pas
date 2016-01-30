unit K265412255;
 {* [$265412255] }

// ������: "w:\common\components\rtl\Garant\Daily\K265412255.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , MergeTablesTest
;

type
 TK265412255 = class(TMergeTablesTest)
  {* [$265412255] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK265412255
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK265412255.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK265412255.GetFolder

function TK265412255.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4DCD0C620209';
end;//TK265412255.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK265412255.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
