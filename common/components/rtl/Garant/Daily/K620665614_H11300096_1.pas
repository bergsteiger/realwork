unit K620665614_H11300096_1;
 {* [RequestLink:620665614] }

// ������: "w:\common\components\rtl\Garant\Daily\K620665614_H11300096_1.pas"
// ���������: "TestCase"
// ������� ������: "K620665614_H11300096_1" MUID: (56FA6D2A03A6)
// ��� ����: "TK620665614_H11300096_1"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK620665614_H11300096_1 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:620665614] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK620665614_H11300096_1
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK620665614_H11300096_1.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'CrossSegments';
end;//TK620665614_H11300096_1.GetFolder

function TK620665614_H11300096_1.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56FA6D2A03A6';
end;//TK620665614_H11300096_1.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK620665614_H11300096_1.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
