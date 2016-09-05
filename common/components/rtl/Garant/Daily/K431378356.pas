unit K431378356;
 {* [Requestlink:431378356] }

// ������: "w:\common\components\rtl\Garant\Daily\K431378356.pas"
// ���������: "TestCase"
// ������� ������: "K431378356" MUID: (5138525E0267)
// ��� ����: "TK431378356"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK431378356 = class(TEVDtoBothNSRCWriterTest)
  {* [Requestlink:431378356] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK431378356
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5138525E0267impl_uses*
 //#UC END# *5138525E0267impl_uses*
;

function TK431378356.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.8';
end;//TK431378356.GetFolder

function TK431378356.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5138525E0267';
end;//TK431378356.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK431378356.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
