unit evCustomEditorModelPart;
 {* ����� TevCustomEditor ����������� �� ������ }

// ������: "w:\common\components\gui\Garant\Everest\evCustomEditorModelPart.pas"
// ���������: "GuiControl"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , evMultiSelectEditorWindow
;

type
 TevAllowParaType = (
  {* ����������� ���� ���������� }
  ev_aptTable
  , ev_aptSBS
  , ev_aptPicture
  , ev_aptFormula
  , ev_aptPageBreak
 );//TevAllowParaType

 TevAllowParaTypes = set of TevAllowParaType;
  {* ��������� ����� ����������� ���������� }

 TevCustomEditorModelPart = class(TevMultiSelectEditorWindow)
  {* ����� TevCustomEditor ����������� �� ������ }
  protected
   function pm_GetAllowParaType: TevAllowParaTypes; virtual;
  protected
   property AllowParaType: TevAllowParaTypes
    read pm_GetAllowParaType;
 end;//TevCustomEditorModelPart

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

function TevCustomEditorModelPart.pm_GetAllowParaType: TevAllowParaTypes;
//#UC START# *4B877E7B0330_4B877C5101C1get_var*
//#UC END# *4B877E7B0330_4B877C5101C1get_var*
begin
//#UC START# *4B877E7B0330_4B877C5101C1get_impl*
 Result := [Low(TevAllowParaType) .. High(TevAllowParaType)];
//#UC END# *4B877E7B0330_4B877C5101C1get_impl*
end;//TevCustomEditorModelPart.pm_GetAllowParaType

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TevCustomEditorModelPart);
 {* ����������� TevCustomEditorModelPart }
{$IfEnd} // NOT Defined(NoScripts)

end.
