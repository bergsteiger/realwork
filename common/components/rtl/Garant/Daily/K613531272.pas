unit K613531272;
 {* [Requestlink:613531272] }

// ������: "w:\common\components\rtl\Garant\Daily\K613531272.pas"
// ���������: "TestCase"
// ������� ������: "K613531272" MUID: (566FE6760020)
// ��� ����: "TK613531272"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK613531272 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:613531272] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK613531272
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *566FE6760020impl_uses*
 //#UC END# *566FE6760020impl_uses*
;

function TK613531272.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK613531272.GetFolder

function TK613531272.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '566FE6760020';
end;//TK613531272.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK613531272.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
