unit K565008782;
 {* [Requestlink:565008782] }

// ������: "w:\common\components\rtl\Garant\Daily\K565008782.pas"
// ���������: "TestCase"
// ������� ������: "K565008782" MUID: (54182CF10045)
// ��� ����: "TK565008782"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK565008782 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:565008782] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK565008782
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *54182CF10045impl_uses*
 //#UC END# *54182CF10045impl_uses*
;

function TK565008782.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK565008782.GetFolder

function TK565008782.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '54182CF10045';
end;//TK565008782.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK565008782.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
