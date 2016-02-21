unit EVDtoBothNSRCWriterTest;
 {* ���� ������ � NSRC+ � NSRC }

// ������: "w:\common\components\rtl\Garant\Daily\EVDtoBothNSRCWriterTest.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCPlusWriterTest
;

type
 TEVDtoBothNSRCWriterTest = {abstract} class(TEVDtoNSRCPlusWriterTest)
  {* ���� ������ � NSRC+ � NSRC }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
  public
   procedure ToOldNSRC;
 end;//TEVDtoBothNSRCWriterTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TEVDtoBothNSRCWriterTest.ToOldNSRC;
//#UC START# *4B8543040166_4B8542C302E3_var*
//#UC END# *4B8543040166_4B8542C302E3_var*
begin
//#UC START# *4B8543040166_4B8542C302E3_impl*
 EVDtoNSRC(KPage + '.evd', false);
//#UC END# *4B8543040166_4B8542C302E3_impl*
end;//TEVDtoBothNSRCWriterTest.ToOldNSRC

function TEVDtoBothNSRCWriterTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'NSRCTests';
end;//TEVDtoBothNSRCWriterTest.GetFolder

function TEVDtoBothNSRCWriterTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4B8542C302E3';
end;//TEVDtoBothNSRCWriterTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
