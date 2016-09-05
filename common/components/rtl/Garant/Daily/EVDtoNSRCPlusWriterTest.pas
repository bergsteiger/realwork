unit EVDtoNSRCPlusWriterTest;
 {* ���� ������ � NSRC+ }

// ������: "w:\common\components\rtl\Garant\Daily\EVDtoNSRCPlusWriterTest.pas"
// ���������: "TestCase"
// ������� ������: "TEVDtoNSRCPlusWriterTest" MUID: (4B853E7501DF)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCWriterTest
;

type
 TEVDtoNSRCPlusWriterTest = {abstract} class(TEVDtoNSRCWriterTest)
  {* ���� ������ � NSRC+ }
  protected
   function IsNSRCPlus: Boolean; override;
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TEVDtoNSRCPlusWriterTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4B853E7501DFimpl_uses*
 //#UC END# *4B853E7501DFimpl_uses*
;

function TEVDtoNSRCPlusWriterTest.IsNSRCPlus: Boolean;
//#UC START# *4B8545CC03D2_4B853E7501DF_var*
//#UC END# *4B8545CC03D2_4B853E7501DF_var*
begin
//#UC START# *4B8545CC03D2_4B853E7501DF_impl*
 Result := true;
//#UC END# *4B8545CC03D2_4B853E7501DF_impl*
end;//TEVDtoNSRCPlusWriterTest.IsNSRCPlus

function TEVDtoNSRCPlusWriterTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'NSRCTests';
end;//TEVDtoNSRCPlusWriterTest.GetFolder

function TEVDtoNSRCPlusWriterTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4B853E7501DF';
end;//TEVDtoNSRCPlusWriterTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
