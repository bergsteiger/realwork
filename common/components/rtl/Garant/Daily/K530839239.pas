unit K530839239;
 {* [Requestlink:530839239] }

// ������: "w:\common\components\rtl\Garant\Daily\K530839239.pas"
// ���������: "TestCase"
// ������� ������: "K530839239" MUID: (5357965602B8)
// ��� ����: "TK530839239"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK530839239 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:530839239] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK530839239
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK530839239.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK530839239.GetFolder

function TK530839239.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5357965602B8';
end;//TK530839239.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK530839239.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
