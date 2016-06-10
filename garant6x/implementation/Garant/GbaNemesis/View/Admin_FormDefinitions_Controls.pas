unit Admin_FormDefinitions_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin_FormDefinitions_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "FormDefinitions" MUID: (4FFBFDCA01DE)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_cfAdminForm: TvcmFormDescriptor = (rFormID : (rName : 'cfAdminForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TcfAdminForm }
 fm_efGroupList: TvcmFormDescriptor = (rFormID : (rName : 'efGroupList'; rID : 0); rFactory : nil);
  {* Идентификатор формы TefGroupList }
 fm_efUserList: TvcmFormDescriptor = (rFormID : (rName : 'efUserList'; rID : 0); rFactory : nil);
  {* Идентификатор формы TefUserList }
 fm_efUserProperty: TvcmFormDescriptor = (rFormID : (rName : 'efUserProperty'; rID : 0); rFactory : nil);
  {* Идентификатор формы TefUserProperty }

type
 AdminFormFormDef = interface
  ['{7E787B8C-F566-443C-9C95-6711D628B038}']
 end;//AdminFormFormDef

 GroupListFormDef = interface
  ['{427E23A9-B9FD-4256-8312-ED9653D862C6}']
 end;//GroupListFormDef

 UserListFormDef = interface
  ['{CCC79038-4B92-428C-ADD7-D68C5BCE408C}']
 end;//UserListFormDef

 UserPropertyFormDef = interface
  ['{5FCF4F0A-B828-487D-9E35-8D8643E02C6C}']
 end;//UserPropertyFormDef
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(Admin)

end.
