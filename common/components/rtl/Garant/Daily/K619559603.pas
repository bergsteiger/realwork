unit K619559603;
 {* [Requestlink:619559603] }

// ������: "w:\common\components\rtl\Garant\Daily\K619559603.pas"
// ���������: "TestCase"
// ������� ������: "K619559603" MUID: (56E01A9F0388)
// ��� ����: "TK619559603"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK619559603 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:619559603] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK619559603
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK619559603.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK619559603.GetFolder

function TK619559603.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56E01A9F0388';
end;//TK619559603.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK619559603.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
