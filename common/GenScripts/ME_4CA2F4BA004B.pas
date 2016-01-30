unit K235050248;
 {* [$235050248] }

// ������: "w:\common\components\rtl\Garant\Daily\K235050248.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , CommentInTableAndScrollTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK235050248 = class(TCommentInTableAndScrollTest)
  {* [$235050248] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK235050248
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK235050248.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK235050248.GetFolder

function TK235050248.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CA2F4BA004B';
end;//TK235050248.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235050248.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
