unit K219119831;
 {* [RequestLink:219119831] }

// ������: "w:\common\components\rtl\Garant\Daily\K219119831.pas"
// ���������: "TestCase"
// ������� ������: "K219119831" MUID: (4C1B2A4701FC)
// ��� ����: "TK219119831"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDWriterTest
;

type
 TK219119831 = class(TEVDtoEVDWriterTest)
  {* [RequestLink:219119831] }
  protected
   function UseFullEVDReader: Boolean; override;
    {* ������������ �� ������ evdReader (� ������� ������ ����) }
   function DisableParserLog: Boolean; override;
    {* ��������� ������� �������� � ��� }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK219119831
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK219119831.UseFullEVDReader: Boolean;
 {* ������������ �� ������ evdReader (� ������� ������ ����) }
//#UC START# *4C1B2B0203A2_4C1B2A4701FC_var*
//#UC END# *4C1B2B0203A2_4C1B2A4701FC_var*
begin
//#UC START# *4C1B2B0203A2_4C1B2A4701FC_impl*
 Result := true;
//#UC END# *4C1B2B0203A2_4C1B2A4701FC_impl*
end;//TK219119831.UseFullEVDReader

function TK219119831.DisableParserLog: Boolean;
 {* ��������� ������� �������� � ��� }
//#UC START# *4C1B47BA03AC_4C1B2A4701FC_var*
//#UC END# *4C1B47BA03AC_4C1B2A4701FC_var*
begin
//#UC START# *4C1B47BA03AC_4C1B2A4701FC_impl*
 Result := true;
//#UC END# *4C1B47BA03AC_4C1B2A4701FC_impl*
end;//TK219119831.DisableParserLog

function TK219119831.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK219119831.GetFolder

function TK219119831.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C1B2A4701FC';
end;//TK219119831.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK219119831.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
