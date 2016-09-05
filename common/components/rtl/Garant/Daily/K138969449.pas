unit K138969449;
 {* [Requestlink:138969449] }

// ������: "w:\common\components\rtl\Garant\Daily\K138969449.pas"
// ���������: "TestCase"
// ������� ������: "K138969449" MUID: (562F5F4703A6)
// ��� ����: "TK138969449"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK138969449 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:138969449] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK138969449
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *562F5F4703A6impl_uses*
 //#UC END# *562F5F4703A6impl_uses*
;

function TK138969449.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK138969449.GetFolder

function TK138969449.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '562F5F4703A6';
end;//TK138969449.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK138969449.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
