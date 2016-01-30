unit K613289134;
 {* [Requestlink:613289134] }

// ������: "w:\common\components\rtl\Garant\Daily\K613289134.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK613289134 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:613289134] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK613289134
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK613289134.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK613289134.GetFolder

function TK613289134.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5666B29D02C3';
end;//TK613289134.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK613289134.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
