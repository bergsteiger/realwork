unit K615114722;
 {* [RequestLink:615114722] }

// ������: "w:\common\components\rtl\Garant\Daily\K615114722.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK615114722 = {final} class(TRTFtoEVDWriterTest)
  {* [RequestLink:615114722] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
   function TreatExceptionAsSuccess: Boolean; override;
 end;//TK615114722
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK615114722.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK615114722.GetFolder

function TK615114722.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56949CAA003C';
end;//TK615114722.GetModelElementGUID

function TK615114722.TreatExceptionAsSuccess: Boolean;
//#UC START# *51406117007F_56949CAA003C_var*
//#UC END# *51406117007F_56949CAA003C_var*
begin
//#UC START# *51406117007F_56949CAA003C_impl*
 Result := True;
//#UC END# *51406117007F_56949CAA003C_impl*
end;//TK615114722.TreatExceptionAsSuccess

initialization
 TestFramework.RegisterTest(TK615114722.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
