unit K252524393;
 {* [$252524393] }

// ������: "w:\common\components\rtl\Garant\Daily\K252524393.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ScrollAndCheckCursorTest
;

type
 TK252524393 = class(TScrollAndCheckCursorTest)
  {* [$252524393] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK252524393
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK252524393.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK252524393.GetFolder

function TK252524393.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D6B868900CC';
end;//TK252524393.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK252524393.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
