unit K177963873;
 {* [$177963873] }

// ������: "w:\common\components\rtl\Garant\Daily\K177963873.pas"
// ���������: "TestCase"
// ������� ������: "K177963873" MUID: (4B7D1EC3002E)
// ��� ����: "TK177963873"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK177963873 = class(TEVDtoBothNSRCWriterTest)
  {* [$177963873] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK177963873
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4B7D1EC3002Eimpl_uses*
 //#UC END# *4B7D1EC3002Eimpl_uses*
;

function TK177963873.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'NSRCTests';
end;//TK177963873.GetFolder

function TK177963873.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4B7D1EC3002E';
end;//TK177963873.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK177963873.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
