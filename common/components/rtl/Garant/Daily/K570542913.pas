unit K570542913;
 {* [RequestLink:570542913] }

// ������: "w:\common\components\rtl\Garant\Daily\K570542913.pas"
// ���������: "TestCase"
// ������� ������: "K570542913" MUID: (54A292720306)
// ��� ����: "TK570542913"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK570542913 = class(THTMLtoEVDTest)
  {* [RequestLink:570542913] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK570542913
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK570542913.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK570542913.GetFolder

function TK570542913.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '54A292720306';
end;//TK570542913.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK570542913.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
