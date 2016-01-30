unit K571646843;
 {* [Requestlink:571646843] }

// ������: "w:\common\components\rtl\Garant\Daily\K571646843.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK571646843 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:571646843] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK571646843
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK571646843.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK571646843.GetFolder

function TK571646843.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '54609BED0186';
end;//TK571646843.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK571646843.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
