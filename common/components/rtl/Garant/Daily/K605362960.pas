unit K605362960;
 {* [RequestLink:605362960] }

// ������: "w:\common\components\rtl\Garant\Daily\K605362960.pas"
// ���������: "TestCase"
// ������� ������: "K605362960" MUID: (55E43F0500A2)
// ��� ����: "TK605362960"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , DeleteCharTest
 , evCustomEditorWindow
 , l3Variant
;

type
 TK605362960 = class(TDeleteCharTest)
  {* [RequestLink:605362960] }
  protected
   procedure Navigate(aText: TevCustomEditorWindow;
    const anOp: Il3OpPack); override;
    {* ������������� ������ ��� ��������� }
   function CharCount: Integer; override;
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK605362960
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evOp
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

procedure TK605362960.Navigate(aText: TevCustomEditorWindow;
 const anOp: Il3OpPack);
 {* ������������� ������ ��� ��������� }
//#UC START# *4C4FE56300FB_55E43F0500A2_var*
//#UC END# *4C4FE56300FB_55E43F0500A2_var*
begin
//#UC START# *4C4FE56300FB_55E43F0500A2_impl*
 inherited;
 with aText do
 begin
  Check(MoveLeafCursor(ev_ocTopLeft, false));
 end;//with aText
//#UC END# *4C4FE56300FB_55E43F0500A2_impl*
end;//TK605362960.Navigate

function TK605362960.CharCount: Integer;
//#UC START# *4DF781CB0217_55E43F0500A2_var*
//#UC END# *4DF781CB0217_55E43F0500A2_var*
begin
//#UC START# *4DF781CB0217_55E43F0500A2_impl*
 Result := 81;
//#UC END# *4DF781CB0217_55E43F0500A2_impl*
end;//TK605362960.CharCount

function TK605362960.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Unicode';
end;//TK605362960.GetFolder

function TK605362960.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '55E43F0500A2';
end;//TK605362960.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK605362960.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
