unit K244712164;
 {* [RequestLink:244712164] }

// ������: "w:\common\components\rtl\Garant\Daily\K244712164.pas"
// ���������: "TestCase"
// ������� ������: "K244712164" MUID: (4D11F843033C)
// ��� ����: "TK244712164"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK244712164 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:244712164] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK244712164
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4D11F843033Cimpl_uses*
 //#UC END# *4D11F843033Cimpl_uses*
;

function TK244712164.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK244712164.GetFolder

function TK244712164.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D11F843033C';
end;//TK244712164.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK244712164.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
