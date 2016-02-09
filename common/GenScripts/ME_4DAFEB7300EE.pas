unit K263750307;
 {* [$263750307] }

// ������: "w:\common\components\rtl\Garant\Daily\K263750307.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , InsertFormulaTest
;

type
 TK263750307 = class(TInsertFormulaTest)
  {* [$263750307] }
  protected
   function GetFormulaText: AnsiString; override;
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK263750307
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

function TK263750307.GetFormulaText: AnsiString;
//#UC START# *4DAFEAFC033F_4DAFEB7300EE_var*
//#UC END# *4DAFEAFC033F_4DAFEB7300EE_var*
begin
//#UC START# *4DAFEAFC033F_4DAFEB7300EE_impl*
 Result := '';
//#UC END# *4DAFEAFC033F_4DAFEB7300EE_impl*
end;//TK263750307.GetFormulaText

function TK263750307.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK263750307.GetFolder

function TK263750307.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4DAFEB7300EE';
end;//TK263750307.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK263750307.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
