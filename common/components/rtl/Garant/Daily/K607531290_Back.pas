unit K607531290_Back;
 {* [RequestLink:607531290] }

// ������: "w:\common\components\rtl\Garant\Daily\K607531290_Back.pas"
// ���������: "TestCase"
// ������� ������: "K607531290_Back" MUID: (561E75CD03A7)
// ��� ����: "TK607531290_Back"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCtoEVDTest
;

type
 TK607531290_Back = class(TNSRCtoEVDTest)
  {* [RequestLink:607531290] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK607531290_Back
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *561E75CD03A7impl_uses*
 //#UC END# *561E75CD03A7impl_uses*
;

function TK607531290_Back.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK607531290_Back.GetFolder

function TK607531290_Back.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '561E75CD03A7';
end;//TK607531290_Back.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK607531290_Back.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
