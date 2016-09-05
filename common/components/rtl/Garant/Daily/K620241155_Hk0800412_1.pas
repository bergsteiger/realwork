unit K620241155_Hk0800412_1;
 {* [RequestLink:620241155] }

// ������: "w:\common\components\rtl\Garant\Daily\K620241155_Hk0800412_1.pas"
// ���������: "TestCase"
// ������� ������: "K620241155_Hk0800412_1" MUID: (56F140290263)
// ��� ����: "TK620241155_Hk0800412_1"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK620241155_Hk0800412_1 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:620241155] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK620241155_Hk0800412_1
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *56F140290263impl_uses*
 //#UC END# *56F140290263impl_uses*
;

function TK620241155_Hk0800412_1.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'CrossSegments';
end;//TK620241155_Hk0800412_1.GetFolder

function TK620241155_Hk0800412_1.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56F140290263';
end;//TK620241155_Hk0800412_1.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK620241155_Hk0800412_1.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
