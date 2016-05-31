unit TreeAttribute_Form;
 {* ����� ������ ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\TreeAttribute_Form.pas"
// ���������: "VCMForm"
// ������� ������: "TreeAttribute" MUID: (4974652502DA)
// ��� ����: "TTreeAttributeForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , SearchInterfaces
 , l3TreeInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TTreeAttributeForm = {abstract} class({$If NOT Defined(NoVCM)}
 TvcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , IbsCurrentChangedListener)
  {* ����� ������ ��������� }
  protected
   procedure CurrentChangedNotification(const aNode: Il3SimpleNode); virtual; abstract;
   {$If NOT Defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
    {* ��������� �������� ������. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure Process(const aNode: Il3SimpleNode);
    {* ���������� ������� }
 end;//TTreeAttributeForm

implementation

uses
 l3ImplUses
 , nsUtils
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4974652502DAimpl_uses*
 //#UC END# *4974652502DAimpl_uses*
;

{$If NOT Defined(NoVCM)}
procedure TTreeAttributeForm.Process(const aNode: Il3SimpleNode);
 {* ���������� ������� }
//#UC START# *49590D4802EE_4974652502DA_var*
//#UC END# *49590D4802EE_4974652502DA_var*
begin
//#UC START# *49590D4802EE_4974652502DA_impl*
 CurrentChangedNotification(aNode);
//#UC END# *49590D4802EE_4974652502DA_impl*
end;//TTreeAttributeForm.Process

procedure TTreeAttributeForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* ��������� �������� ������. ��� ���������� � �������� }
//#UC START# *497469C90140_4974652502DA_var*
//#UC END# *497469C90140_4974652502DA_var*
begin
//#UC START# *497469C90140_4974652502DA_impl*
 if (anOld <> nil) then
  anOld.Unsubscribe(IbsCurrentChangedListener(Self));
 if (aNew <> nil) then
  aNew.Subscribe(IbsCurrentChangedListener(Self));
//#UC END# *497469C90140_4974652502DA_impl*
end;//TTreeAttributeForm.NotifyDataSourceChanged

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TTreeAttributeForm);
 {* ����������� TreeAttribute }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
