unit K624692225_1;
 {* http://mdp.garant.ru/pages/viewpage.action?pageId=624692225&focusedCommentId=624709697#comment-624709697 }

// ������: "w:\common\components\rtl\Garant\Daily\K624692225_1.pas"
// ���������: "TestCase"
// ������� ������: "K624692225_1" MUID: (576904C80038)
// ��� ����: "TK624692225_1"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDFull
;

type
 TK624692225_1 = class(THTMLtoEVDFull)
  {* http://mdp.garant.ru/pages/viewpage.action?pageId=624692225&focusedCommentId=624709697#comment-624709697 }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK624692225_1
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *576904C80038impl_uses*
 //#UC END# *576904C80038impl_uses*
;

function TK624692225_1.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '8.0';
end;//TK624692225_1.GetFolder

function TK624692225_1.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '576904C80038';
end;//TK624692225_1.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK624692225_1.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
