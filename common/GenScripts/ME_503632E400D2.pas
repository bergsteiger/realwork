unit EVDtoXMLWiterTest;

// ������: "w:\common\components\rtl\Garant\Daily\EVDtoXMLWiterTest.pas"
// ���������: "TestCase"
// ������� ������: "EVDtoXMLWiterTest" MUID: (503632E400D2)
// ��� ����: "TEVDtoXMLWiterTest"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , XMLWriterTest
;

type
 TEVDtoXMLWiterTest = {abstract} class(TXMLWriterTest)
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
  published
   procedure DoIt;
 end;//TEVDtoXMLWiterTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TEVDtoXMLWiterTest.DoIt;
//#UC START# *5036347502D4_503632E400D2_var*
//#UC END# *5036347502D4_503632E400D2_var*
begin
//#UC START# *5036347502D4_503632E400D2_impl*
 EVDtoXML(KPage + '.evd');
//#UC END# *5036347502D4_503632E400D2_impl*
end;//TEVDtoXMLWiterTest.DoIt

function TEVDtoXMLWiterTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'XML';
end;//TEVDtoXMLWiterTest.GetFolder

function TEVDtoXMLWiterTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '503632E400D2';
end;//TEVDtoXMLWiterTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
