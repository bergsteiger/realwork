unit NSRCtoMemoryTest;
 {* ���� ������ NSRC � ������ }

// ������: "w:\common\components\rtl\Garant\Daily\NSRCtoMemoryTest.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCWriterTest
;

type
 TNSRCtoMemoryTest = {abstract} class(TNSRCWriterTest)
  {* ���� ������ NSRC � ������ }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
  public
   procedure DoIt;
 end;//TNSRCtoMemoryTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TNSRCtoMemoryTest.DoIt;
//#UC START# *4B8547F30147_4B8549760232_var*
//#UC END# *4B8547F30147_4B8549760232_var*
begin
//#UC START# *4B8547F30147_4B8549760232_impl*
 NSRCtoMemory(KPage + '.nsr');
//#UC END# *4B8547F30147_4B8549760232_impl*
end;//TNSRCtoMemoryTest.DoIt

function TNSRCtoMemoryTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'NSRCTests';
end;//TNSRCtoMemoryTest.GetFolder

function TNSRCtoMemoryTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4B8549760232';
end;//TNSRCtoMemoryTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
