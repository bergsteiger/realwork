unit K362130309;
 {* [RequestLink:362130309] }

// ������: "w:\common\components\rtl\Garant\Daily\K362130309.pas"
// ���������: "TestCase"
// ������� ������: "K362130309" MUID: (4FA0E0470281)
// ��� ����: "TK362130309"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDWriterTest
;

type
 TK362130309 = class(TEVDtoEVDWriterTest)
  {* [RequestLink:362130309] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK362130309
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK362130309.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.8';
end;//TK362130309.GetFolder

function TK362130309.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4FA0E0470281';
end;//TK362130309.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK362130309.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
