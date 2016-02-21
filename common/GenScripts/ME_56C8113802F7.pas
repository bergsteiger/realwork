unit K618269589;
 {* [Requestlink:618269589] }

// ������: "w:\common\components\rtl\Garant\Daily\K618269589.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK618269589 = class(THTMLtoEVDTest)
  {* [Requestlink:618269589] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK618269589
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK618269589.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK618269589.GetFolder

function TK618269589.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56C8113802F7';
end;//TK618269589.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK618269589.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
