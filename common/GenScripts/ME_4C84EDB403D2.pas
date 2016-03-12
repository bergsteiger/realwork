unit PostingOrder_Strange_Controls;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PostingOrder_Strange_Controls.pas"
// ���������: "VCMControls"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 // PostingToolBar

 // SearchSupport

 Op_SearchSupport_ActivatePostingsListForm = class
  {* ����� ��� ������ �������� SearchSupport.ActivatePostingsListForm }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� SearchSupport.ActivatePostingsListForm � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� SearchSupport.ActivatePostingsListForm � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� SearchSupport.ActivatePostingsListForm � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� SearchSupport.ActivatePostingsListForm � ���������� }
   class procedure Broadcast;
    {* ����� �������� SearchSupport.ActivatePostingsListForm � ���� ������������������ ��������� }
 end;//Op_SearchSupport_ActivatePostingsListForm
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;

class function Op_SearchSupport_ActivatePostingsListForm.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� SearchSupport.ActivatePostingsListForm � �������� }
//#UC START# *E1F684CF5C8A_9E2277079C07_var*
//#UC END# *E1F684CF5C8A_9E2277079C07_var*
begin
//#UC START# *E1F684CF5C8A_9E2277079C07_impl*
 !!! Needs to be implemented !!!
//#UC END# *E1F684CF5C8A_9E2277079C07_impl*
end;//Op_SearchSupport_ActivatePostingsListForm.Call

class function Op_SearchSupport_ActivatePostingsListForm.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� SearchSupport.ActivatePostingsListForm � ��������� }
//#UC START# *123644BDE6DB_9E2277079C07_var*
//#UC END# *123644BDE6DB_9E2277079C07_var*
begin
//#UC START# *123644BDE6DB_9E2277079C07_impl*
 !!! Needs to be implemented !!!
//#UC END# *123644BDE6DB_9E2277079C07_impl*
end;//Op_SearchSupport_ActivatePostingsListForm.Call

class function Op_SearchSupport_ActivatePostingsListForm.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� SearchSupport.ActivatePostingsListForm � ����� }
//#UC START# *223144433231_9E2277079C07_var*
//#UC END# *223144433231_9E2277079C07_var*
begin
//#UC START# *223144433231_9E2277079C07_impl*
 !!! Needs to be implemented !!!
//#UC END# *223144433231_9E2277079C07_impl*
end;//Op_SearchSupport_ActivatePostingsListForm.Call

class function Op_SearchSupport_ActivatePostingsListForm.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� SearchSupport.ActivatePostingsListForm � ���������� }
//#UC START# *8F536004C8EF_9E2277079C07_var*
//#UC END# *8F536004C8EF_9E2277079C07_var*
begin
//#UC START# *8F536004C8EF_9E2277079C07_impl*
 !!! Needs to be implemented !!!
//#UC END# *8F536004C8EF_9E2277079C07_impl*
end;//Op_SearchSupport_ActivatePostingsListForm.Call

class procedure Op_SearchSupport_ActivatePostingsListForm.Broadcast;
 {* ����� �������� SearchSupport.ActivatePostingsListForm � ���� ������������������ ��������� }
//#UC START# *0335CE99735E_9E2277079C07_var*
//#UC END# *0335CE99735E_9E2277079C07_var*
begin
//#UC START# *0335CE99735E_9E2277079C07_impl*
 !!! Needs to be implemented !!!
//#UC END# *0335CE99735E_9E2277079C07_impl*
end;//Op_SearchSupport_ActivatePostingsListForm.Broadcast
{$IfEnd} // NOT Defined(Admin)

end.
