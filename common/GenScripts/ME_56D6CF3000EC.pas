unit K617776901;
 {* [Requestlink:617776901] }

// ������: "w:\common\components\rtl\Garant\Daily\K617776901.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDFull
;

type
 TK617776901 = class(THTMLtoEVDFull)
  {* [Requestlink:617776901] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
   function TreatExceptionAsSuccess: Boolean; override;
 end;//TK617776901
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK617776901.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK617776901.GetFolder

function TK617776901.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56D6CF3000EC';
end;//TK617776901.GetModelElementGUID

function TK617776901.TreatExceptionAsSuccess: Boolean;
//#UC START# *51406117007F_56D6CF3000EC_var*
//#UC END# *51406117007F_56D6CF3000EC_var*
begin
//#UC START# *51406117007F_56D6CF3000EC_impl*
 Result := True;
//#UC END# *51406117007F_56D6CF3000EC_impl*
end;//TK617776901.TreatExceptionAsSuccess

initialization
 TestFramework.RegisterTest(TK617776901.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
