unit K217685978;
 {* [RequestLink:217685978] }

// ������: "w:\common\components\rtl\Garant\Daily\K217685978.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , TextMetricsTest
;

type
 TK217685978 = class(TTextMetricsTest)
  {* [RequestLink:217685978] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK217685978
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK217685978.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK217685978.GetFolder

function TK217685978.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D08CA0D02B6';
end;//TK217685978.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK217685978.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
