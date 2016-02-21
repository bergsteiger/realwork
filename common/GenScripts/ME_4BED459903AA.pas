unit K210043095;
 {* [RequestLink:210043095] }

// ������: "w:\common\components\rtl\Garant\Daily\K210043095.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCtoEVDTest
;

type
 TK210043095 = class(TNSRCtoEVDTest)
  {* [RequestLink:210043095] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK210043095
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK210043095.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK210043095.GetFolder

function TK210043095.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4BED459903AA';
end;//TK210043095.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK210043095.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
