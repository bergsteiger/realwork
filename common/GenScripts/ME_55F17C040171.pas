unit K606808862;
 {* [Requestlink:606808862] }

// ������: "w:\common\components\rtl\Garant\Daily\K606808862.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK606808862 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:606808862] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK606808862
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK606808862.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK606808862.GetFolder

function TK606808862.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '55F17C040171';
end;//TK606808862.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK606808862.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
