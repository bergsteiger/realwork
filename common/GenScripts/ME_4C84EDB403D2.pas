unit PostingOrder_Strange_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PostingOrder_Strange_Controls.pas"
// Стереотип: "VCMControls"

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
  {* Класс для вызова операции SearchSupport.ActivatePostingsListForm }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции SearchSupport.ActivatePostingsListForm у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции SearchSupport.ActivatePostingsListForm у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции SearchSupport.ActivatePostingsListForm у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции SearchSupport.ActivatePostingsListForm у контейнера }
   class procedure Broadcast;
    {* Вызов операции SearchSupport.ActivatePostingsListForm у всех зарегистрированных сущностей }
 end;//Op_SearchSupport_ActivatePostingsListForm
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;

class function Op_SearchSupport_ActivatePostingsListForm.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции SearchSupport.ActivatePostingsListForm у сущности }
//#UC START# *E1F684CF5C8A_9E2277079C07_var*
//#UC END# *E1F684CF5C8A_9E2277079C07_var*
begin
//#UC START# *E1F684CF5C8A_9E2277079C07_impl*
 !!! Needs to be implemented !!!
//#UC END# *E1F684CF5C8A_9E2277079C07_impl*
end;//Op_SearchSupport_ActivatePostingsListForm.Call

class function Op_SearchSupport_ActivatePostingsListForm.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции SearchSupport.ActivatePostingsListForm у агрегации }
//#UC START# *123644BDE6DB_9E2277079C07_var*
//#UC END# *123644BDE6DB_9E2277079C07_var*
begin
//#UC START# *123644BDE6DB_9E2277079C07_impl*
 !!! Needs to be implemented !!!
//#UC END# *123644BDE6DB_9E2277079C07_impl*
end;//Op_SearchSupport_ActivatePostingsListForm.Call

class function Op_SearchSupport_ActivatePostingsListForm.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции SearchSupport.ActivatePostingsListForm у формы }
//#UC START# *223144433231_9E2277079C07_var*
//#UC END# *223144433231_9E2277079C07_var*
begin
//#UC START# *223144433231_9E2277079C07_impl*
 !!! Needs to be implemented !!!
//#UC END# *223144433231_9E2277079C07_impl*
end;//Op_SearchSupport_ActivatePostingsListForm.Call

class function Op_SearchSupport_ActivatePostingsListForm.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции SearchSupport.ActivatePostingsListForm у контейнера }
//#UC START# *8F536004C8EF_9E2277079C07_var*
//#UC END# *8F536004C8EF_9E2277079C07_var*
begin
//#UC START# *8F536004C8EF_9E2277079C07_impl*
 !!! Needs to be implemented !!!
//#UC END# *8F536004C8EF_9E2277079C07_impl*
end;//Op_SearchSupport_ActivatePostingsListForm.Call

class procedure Op_SearchSupport_ActivatePostingsListForm.Broadcast;
 {* Вызов операции SearchSupport.ActivatePostingsListForm у всех зарегистрированных сущностей }
//#UC START# *0335CE99735E_9E2277079C07_var*
//#UC END# *0335CE99735E_9E2277079C07_var*
begin
//#UC START# *0335CE99735E_9E2277079C07_impl*
 !!! Needs to be implemented !!!
//#UC END# *0335CE99735E_9E2277079C07_impl*
end;//Op_SearchSupport_ActivatePostingsListForm.Broadcast
{$IfEnd} // NOT Defined(Admin)

end.
