unit K538566131;
 {* [Requestlink:538566131] }

// ������: "w:\common\components\rtl\Garant\Daily\K538566131.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK538566131 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:538566131] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK538566131
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK538566131.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK538566131.GetFolder

function TK538566131.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '53884E8203BE';
end;//TK538566131.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK538566131.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
