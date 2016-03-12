unit K619321401;
 {* [Requestlink:619321401] }

// ������: "w:\common\components\rtl\Garant\Daily\K619321401.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoHTMLWithExternalHyperlinks
;

type
 TK619321401 = class(TEVDtoHTMLWithExternalHyperlinks)
  {* [Requestlink:619321401] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK619321401
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK619321401.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK619321401.GetFolder

function TK619321401.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56D930C90328';
end;//TK619321401.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK619321401.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
