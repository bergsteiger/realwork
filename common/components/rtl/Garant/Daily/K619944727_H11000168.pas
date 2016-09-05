unit K619944727_H11000168;
 {* [RequestLink:619944727] }

// ������: "w:\common\components\rtl\Garant\Daily\K619944727_H11000168.pas"
// ���������: "TestCase"
// ������� ������: "K619944727_H11000168" MUID: (56E951DD0223)
// ��� ����: "TK619944727_H11000168"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK619944727_H11000168 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:619944727] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK619944727_H11000168
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *56E951DD0223impl_uses*
 //#UC END# *56E951DD0223impl_uses*
;

function TK619944727_H11000168.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'CrossSegments';
end;//TK619944727_H11000168.GetFolder

function TK619944727_H11000168.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56E951DD0223';
end;//TK619944727_H11000168.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK619944727_H11000168.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
