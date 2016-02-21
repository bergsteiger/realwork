unit LegalDomain_DocumentNotifications_Controls;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\LegalDomain_DocumentNotifications_Controls.pas"
// ���������: "VCMControls"

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
  {* ����� ��� ������ �������� Comment.Changed }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� Comment.Changed � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� Comment.Changed � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� Comment.Changed � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� Comment.Changed � ���������� }
   class procedure Broadcast;
    {* ����� �������� Comment.Changed � ���� ������������������ ��������� }
 end;//Op_Comment_Changed

implementation

uses
 l3ImplUses
;

class function Op_Comment_Changed.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� Comment.Changed � �������� }
//#UC START# *17D827C515B4_4CF941D32C80_var*
//#UC END# *17D827C515B4_4CF941D32C80_var*
begin
//#UC START# *17D827C515B4_4CF941D32C80_impl*
 !!! Needs to be implemented !!!
//#UC END# *17D827C515B4_4CF941D32C80_impl*
end;//Op_Comment_Changed.Call

class function Op_Comment_Changed.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� Comment.Changed � ��������� }
//#UC START# *4817E7B4A004_4CF941D32C80_var*
//#UC END# *4817E7B4A004_4CF941D32C80_var*
begin
//#UC START# *4817E7B4A004_4CF941D32C80_impl*
 !!! Needs to be implemented !!!
//#UC END# *4817E7B4A004_4CF941D32C80_impl*
end;//Op_Comment_Changed.Call

class function Op_Comment_Changed.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� Comment.Changed � ����� }
//#UC START# *4ADAC3E354AB_4CF941D32C80_var*
//#UC END# *4ADAC3E354AB_4CF941D32C80_var*
begin
//#UC START# *4ADAC3E354AB_4CF941D32C80_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ADAC3E354AB_4CF941D32C80_impl*
end;//Op_Comment_Changed.Call

class function Op_Comment_Changed.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� Comment.Changed � ���������� }
//#UC START# *FEB78DFB4BFA_4CF941D32C80_var*
//#UC END# *FEB78DFB4BFA_4CF941D32C80_var*
begin
//#UC START# *FEB78DFB4BFA_4CF941D32C80_impl*
 !!! Needs to be implemented !!!
//#UC END# *FEB78DFB4BFA_4CF941D32C80_impl*
end;//Op_Comment_Changed.Call

class procedure Op_Comment_Changed.Broadcast;
 {* ����� �������� Comment.Changed � ���� ������������������ ��������� }
//#UC START# *F8509C861974_4CF941D32C80_var*
//#UC END# *F8509C861974_4CF941D32C80_var*
begin
//#UC START# *F8509C861974_4CF941D32C80_impl*
 !!! Needs to be implemented !!!
//#UC END# *F8509C861974_4CF941D32C80_impl*
end;//Op_Comment_Changed.Broadcast

end.
