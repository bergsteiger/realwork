unit LegalDomain_DocumentNotifications_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LegalDomain_DocumentNotifications_Controls.pas"
// Стереотип: "VCMControls"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 // Comment

 Op_Comment_Changed = class
  {* Класс для вызова операции Comment.Changed }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции Comment.Changed у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции Comment.Changed у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции Comment.Changed у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции Comment.Changed у контейнера }
   class procedure Broadcast;
    {* Вызов операции Comment.Changed у всех зарегистрированных сущностей }
 end;//Op_Comment_Changed

implementation

uses
 l3ImplUses
;

class function Op_Comment_Changed.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции Comment.Changed у сущности }
//#UC START# *17D827C515B4_4CF941D32C80_var*
//#UC END# *17D827C515B4_4CF941D32C80_var*
begin
//#UC START# *17D827C515B4_4CF941D32C80_impl*
 !!! Needs to be implemented !!!
//#UC END# *17D827C515B4_4CF941D32C80_impl*
end;//Op_Comment_Changed.Call

class function Op_Comment_Changed.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции Comment.Changed у агрегации }
//#UC START# *4817E7B4A004_4CF941D32C80_var*
//#UC END# *4817E7B4A004_4CF941D32C80_var*
begin
//#UC START# *4817E7B4A004_4CF941D32C80_impl*
 !!! Needs to be implemented !!!
//#UC END# *4817E7B4A004_4CF941D32C80_impl*
end;//Op_Comment_Changed.Call

class function Op_Comment_Changed.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции Comment.Changed у формы }
//#UC START# *4ADAC3E354AB_4CF941D32C80_var*
//#UC END# *4ADAC3E354AB_4CF941D32C80_var*
begin
//#UC START# *4ADAC3E354AB_4CF941D32C80_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ADAC3E354AB_4CF941D32C80_impl*
end;//Op_Comment_Changed.Call

class function Op_Comment_Changed.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции Comment.Changed у контейнера }
//#UC START# *FEB78DFB4BFA_4CF941D32C80_var*
//#UC END# *FEB78DFB4BFA_4CF941D32C80_var*
begin
//#UC START# *FEB78DFB4BFA_4CF941D32C80_impl*
 !!! Needs to be implemented !!!
//#UC END# *FEB78DFB4BFA_4CF941D32C80_impl*
end;//Op_Comment_Changed.Call

class procedure Op_Comment_Changed.Broadcast;
 {* Вызов операции Comment.Changed у всех зарегистрированных сущностей }
//#UC START# *F8509C861974_4CF941D32C80_var*
//#UC END# *F8509C861974_4CF941D32C80_var*
begin
//#UC START# *F8509C861974_4CF941D32C80_impl*
 !!! Needs to be implemented !!!
//#UC END# *F8509C861974_4CF941D32C80_impl*
end;//Op_Comment_Changed.Broadcast

end.
