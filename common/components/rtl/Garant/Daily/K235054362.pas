unit K235054362;
 {* [RequestLink:235054362] }

// ������: "w:\common\components\rtl\Garant\Daily\K235054362.pas"
// ���������: "TestCase"
// ������� ������: "K235054362" MUID: (4CA080260199)
// ��� ����: "TK235054362"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCtoEVDTest
;

type
 TK235054362 = class(TNSRCtoEVDTest)
  {* [RequestLink:235054362] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK235054362
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4CA080260199impl_uses*
 //#UC END# *4CA080260199impl_uses*
;

function TK235054362.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK235054362.GetFolder

function TK235054362.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CA080260199';
end;//TK235054362.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235054362.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
