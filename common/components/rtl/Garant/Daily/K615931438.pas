unit K615931438;
 {* [Requestlink:615931438]. ������, ��-�� <stab> � ������� �������. ��� �� ����� ��������� ��������, �� ���� ������� ��������� �������. }

// ������: "w:\common\components\rtl\Garant\Daily\K615931438.pas"
// ���������: "TestCase"
// ������� ������: "TK615931438" MUID: (56A85852030C)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK615931438 = class(THTMLtoEVDTest)
  {* [Requestlink:615931438]. ������, ��-�� <stab> � ������� �������. ��� �� ����� ��������� ��������, �� ���� ������� ��������� �������. }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK615931438
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK615931438.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK615931438.GetFolder

function TK615931438.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56A85852030C';
end;//TK615931438.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK615931438.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
