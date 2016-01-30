unit K235050021;
 {* [$235050021] }

// ������: "w:\common\components\rtl\Garant\Daily\K235050021.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , CommentAndScrollTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK235050021 = class(TCommentAndScrollTest)
  {* [$235050021] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK235050021
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK235050021.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK235050021.GetFolder

function TK235050021.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C9CA79402E3';
end;//TK235050021.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235050021.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
