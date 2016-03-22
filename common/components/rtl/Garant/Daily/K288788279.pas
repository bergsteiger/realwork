unit K288788279;
 {* [RequestLink:288788279] }

// ������: "w:\common\components\rtl\Garant\Daily\K288788279.pas"
// ���������: "TestCase"
// ������� ������: "K288788279" MUID: (4E847F620320)
// ��� ����: "TK288788279"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK288788279 = class(THTMLtoEVDTest)
  {* [RequestLink:288788279] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK288788279
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK288788279.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7 Lulin';
end;//TK288788279.GetFolder

function TK288788279.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4E847F620320';
end;//TK288788279.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK288788279.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
