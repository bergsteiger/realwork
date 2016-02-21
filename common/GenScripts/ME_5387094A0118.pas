unit K538561126;
 {* [Requestlink:538561126] }

// ������: "w:\common\components\rtl\Garant\Daily\K538561126.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK538561126 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:538561126] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK538561126
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK538561126.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK538561126.GetFolder

function TK538561126.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5387094A0118';
end;//TK538561126.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK538561126.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
