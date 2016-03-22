unit K519483189;
 {* [Requestlink:519483189] }

// ������: "w:\common\components\rtl\Garant\Daily\K519483189.pas"
// ���������: "TestCase"
// ������� ������: "K519483189" MUID: (5314649702DB)
// ��� ����: "TK519483189"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoRTFRender
;

type
 TK519483189 = class(TEVDtoRTFRender)
  {* [Requestlink:519483189] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
   function NeedEliminateCommentDecorations: Boolean; override;
 end;//TK519483189
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK519483189.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK519483189.GetFolder

function TK519483189.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5314649702DB';
end;//TK519483189.GetModelElementGUID

function TK519483189.NeedEliminateCommentDecorations: Boolean;
//#UC START# *530C91FB00BD_5314649702DB_var*
//#UC END# *530C91FB00BD_5314649702DB_var*
begin
//#UC START# *530C91FB00BD_5314649702DB_impl*
 Result := True;
//#UC END# *530C91FB00BD_5314649702DB_impl*
end;//TK519483189.NeedEliminateCommentDecorations

initialization
 TestFramework.RegisterTest(TK519483189.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
