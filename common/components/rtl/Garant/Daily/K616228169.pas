unit K616228169;
 {* [Requestlink:616228169] }

// ������: "w:\common\components\rtl\Garant\Daily\K616228169.pas"
// ���������: "TestCase"
// ������� ������: "K616228169" MUID: (56A9CB5E034A)
// ��� ����: "TK616228169"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWithURL
;

type
 TK616228169 = class(TRTFtoEVDWithURL)
  {* [Requestlink:616228169] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK616228169
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK616228169.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK616228169.GetFolder

function TK616228169.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56A9CB5E034A';
end;//TK616228169.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK616228169.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
