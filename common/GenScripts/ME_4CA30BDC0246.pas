unit K234360788;
 {* [RequestLink:234360788] }

// ������: "w:\common\components\rtl\Garant\Daily\K234360788.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , DeleteCharTest
;

type
 TK234360788 = class(TDeleteCharTest)
  {* [RequestLink:234360788] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK234360788
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK234360788.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK234360788.GetFolder

function TK234360788.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CA30BDC0246';
end;//TK234360788.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK234360788.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
