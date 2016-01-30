unit K569230238_EVD2EVD;
 {* [RequestLink:569230238] }

// ������: "w:\common\components\rtl\Garant\Daily\K569230238_EVD2EVD.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDWriterTest
;

type
 TK569230238_EVD2EVD = class(TEVDtoEVDWriterTest)
  {* [RequestLink:569230238] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK569230238_EVD2EVD
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK569230238_EVD2EVD.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK569230238_EVD2EVD.GetFolder

function TK569230238_EVD2EVD.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5492DC8502F9';
end;//TK569230238_EVD2EVD.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK569230238_EVD2EVD.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
