unit K254944075;
 {* [RequestLink:254944075] }

// ������: "w:\common\components\rtl\Garant\Daily\K254944075.pas"
// ���������: "TestCase"
// ������� ������: "K254944075" MUID: (4D6BE7A702E7)
// ��� ����: "TK254944075"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , WikiToEVDWriterTest
;

type
 TK254944075 = class(TWikiToEVDWriterTest)
  {* [RequestLink:254944075] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK254944075
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK254944075.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7 Lulin';
end;//TK254944075.GetFolder

function TK254944075.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D6BE7A702E7';
end;//TK254944075.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK254944075.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
