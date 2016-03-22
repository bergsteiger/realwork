unit K599800930;
 {* [Requestlink:599800930] }

// ������: "w:\common\components\rtl\Garant\Daily\K599800930.pas"
// ���������: "TestCase"
// ������� ������: "K599800930" MUID: (5559ED00003A)
// ��� ����: "TK599800930"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK599800930 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:599800930] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK599800930
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK599800930.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK599800930.GetFolder

function TK599800930.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5559ED00003A';
end;//TK599800930.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK599800930.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
