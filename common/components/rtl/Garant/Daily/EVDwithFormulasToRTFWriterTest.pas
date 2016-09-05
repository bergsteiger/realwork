unit EVDwithFormulasToRTFWriterTest;
 {* ���� �������������� EVD � ��������� � RTF }

// ������: "w:\common\components\rtl\Garant\Daily\EVDwithFormulasToRTFWriterTest.pas"
// ���������: "TestCase"
// ������� ������: "EVDwithFormulasToRTFWriterTest" MUID: (4CA616760108)
// ��� ����: "TEVDwithFormulasToRTFWriterTest"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoRTFWriterTest
;

type
 TEVDwithFormulasToRTFWriterTest = {abstract} class(TEVDtoRTFWriterTest)
  {* ���� �������������� EVD � ��������� � RTF }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   {$If NOT Defined(NotTunedDUnit)}
   function EtalonNeedsComputerName: Boolean; override;
   {$IfEnd} // NOT Defined(NotTunedDUnit)
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TEVDwithFormulasToRTFWriterTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4CA616760108impl_uses*
 //#UC END# *4CA616760108impl_uses*
;

function TEVDwithFormulasToRTFWriterTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'RTF';
end;//TEVDwithFormulasToRTFWriterTest.GetFolder

{$If NOT Defined(NotTunedDUnit)}
function TEVDwithFormulasToRTFWriterTest.EtalonNeedsComputerName: Boolean;
//#UC START# *4CA45DAA01BA_4CA616760108_var*
//#UC END# *4CA45DAA01BA_4CA616760108_var*
begin
//#UC START# *4CA45DAA01BA_4CA616760108_impl*
 Result := true;
//#UC END# *4CA45DAA01BA_4CA616760108_impl*
end;//TEVDwithFormulasToRTFWriterTest.EtalonNeedsComputerName
{$IfEnd} // NOT Defined(NotTunedDUnit)

function TEVDwithFormulasToRTFWriterTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CA616760108';
end;//TEVDwithFormulasToRTFWriterTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
