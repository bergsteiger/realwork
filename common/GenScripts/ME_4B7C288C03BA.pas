unit K177964264;
 {* [$177964264] }

// ������: "w:\common\components\rtl\Garant\Daily\K177964264.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCOldWriterTest
;

type
 TK177964264 = class(TEVDtoNSRCOldWriterTest)
  {* [$177964264] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK177964264
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK177964264.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'NSRCTests';
end;//TK177964264.GetFolder

function TK177964264.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4B7C288C03BA';
end;//TK177964264.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK177964264.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
