unit K619724818_1;
 {* [Requestlink:619724818]. http://mdp.garant.ru/pages/viewpage.action?pageId=619724818&focusedCommentId=619740598#comment-619740598 }

// ������: "w:\common\components\rtl\Garant\Daily\K619724818_1.pas"
// ���������: "TestCase"
// ������� ������: "K619724818_1" MUID: (56E8FB640031)
// ��� ����: "TK619724818_1"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDFull
;

type
 TK619724818_1 = class(THTMLtoEVDFull)
  {* [Requestlink:619724818]. http://mdp.garant.ru/pages/viewpage.action?pageId=619724818&focusedCommentId=619740598#comment-619740598 }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK619724818_1
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK619724818_1.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK619724818_1.GetFolder

function TK619724818_1.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56E8FB640031';
end;//TK619724818_1.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK619724818_1.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
