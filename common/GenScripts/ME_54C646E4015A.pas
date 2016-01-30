unit K586173596;
 {* [Requestlink:586173596] }

// ������: "w:\common\components\rtl\Garant\Daily\K586173596.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK586173596 = class(THTMLtoEVDTest)
  {* [Requestlink:586173596] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK586173596
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK586173596.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK586173596.GetFolder

function TK586173596.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '54C646E4015A';
end;//TK586173596.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK586173596.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
