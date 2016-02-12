unit ScrollUpAndDownAndCheckShapes;
 {* ��������� ����, ����� ����� � ��������� �����������. }

// ������: "w:\common\components\rtl\Garant\Daily\ScrollUpAndDownAndCheckShapes.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , DrawTest
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _CursorMover_Parent_ = TDrawTest;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}
 _ScrollSupport_Parent_ = _CursorMover_;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\ScrollSupport.imp.pas}
 TScrollUpAndDownAndCheckShapes = {abstract} class(_ScrollSupport_)
  {* ��������� ����, ����� ����� � ��������� �����������. }
  protected
   function GetScrollCount(aUp: Boolean): Integer; virtual; abstract;
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   {$If NOT Defined(NoVCM)}
   procedure DoBeforeDrawing(aForm: TPrimTextLoadForm); override;
    {* ���������� �����-������ �������� ����� ����������. }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TScrollUpAndDownAndCheckShapes
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
 , l3InternalInterfaces
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , nevTools
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 , l3Base
;

{$If not Declared(_FormClass_)}type _FormClass_ = TPrimTextLoadForm;{$IfEnd}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\ScrollSupport.imp.pas}

function TScrollUpAndDownAndCheckShapes.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TScrollUpAndDownAndCheckShapes.GetFolder

{$If NOT Defined(NoVCM)}
procedure TScrollUpAndDownAndCheckShapes.DoBeforeDrawing(aForm: TPrimTextLoadForm);
 {* ���������� �����-������ �������� ����� ����������. }
//#UC START# *4CAC45AE011E_4D9AE118015C_var*
var
 l_Count: Integer;
//#UC END# *4CAC45AE011E_4D9AE118015C_var*
begin
//#UC START# *4CAC45AE011E_4D9AE118015C_impl*
 l_Count := GetScrollCount(False);
 ScrollByLine(aForm, l_Count, False, False);
 l_Count := GetScrollCount(True);
 ScrollByLine(aForm, l_Count, True, False);
//#UC END# *4CAC45AE011E_4D9AE118015C_impl*
end;//TScrollUpAndDownAndCheckShapes.DoBeforeDrawing
{$IfEnd} // NOT Defined(NoVCM)

function TScrollUpAndDownAndCheckShapes.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D9AE118015C';
end;//TScrollUpAndDownAndCheckShapes.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
