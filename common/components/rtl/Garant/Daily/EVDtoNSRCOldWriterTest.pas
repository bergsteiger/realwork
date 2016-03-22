unit EVDtoNSRCOldWriterTest;

// ������: "w:\common\components\rtl\Garant\Daily\EVDtoNSRCOldWriterTest.pas"
// ���������: "TestCase"
// ������� ������: "TEVDtoNSRCOldWriterTest" MUID: (4B8546940034)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCWriterTest
;

type
 TEVDtoNSRCOldWriterTest = {abstract} class(TEVDtoNSRCWriterTest)
  protected
   function IsNSRCPlus: Boolean; override;
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TEVDtoNSRCOldWriterTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TEVDtoNSRCOldWriterTest.IsNSRCPlus: Boolean;
//#UC START# *4B8545CC03D2_4B8546940034_var*
//#UC END# *4B8545CC03D2_4B8546940034_var*
begin
//#UC START# *4B8545CC03D2_4B8546940034_impl*
 Result := false;
//#UC END# *4B8545CC03D2_4B8546940034_impl*
end;//TEVDtoNSRCOldWriterTest.IsNSRCPlus

function TEVDtoNSRCOldWriterTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'NSRCTests';
end;//TEVDtoNSRCOldWriterTest.GetFolder

function TEVDtoNSRCOldWriterTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4B8546940034';
end;//TEVDtoNSRCOldWriterTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
