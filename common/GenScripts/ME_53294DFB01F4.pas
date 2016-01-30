unit K514874360;
 {* [Requestlink:514874360] }

// ������: "w:\archi\source\projects\Everest\Lite\7.0\Express\Tests\K514874360.pas"
// ���������: "TestCase"

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , ArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TK514874360 = class(TArchiInsiderTest)
  {* [Requestlink:514874360] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK514874360
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK514874360.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'FileFormatTests';
end;//TK514874360.GetFolder

function TK514874360.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '53294DFB01F4';
end;//TK514874360.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK514874360.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
