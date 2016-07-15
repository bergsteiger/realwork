unit CompareEditions_FormDefinitions_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\CompareEditions_FormDefinitions_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "FormDefinitions" MUID: (4FFC670F012B)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
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
 fm_LeftEditionForm: TvcmFormDescriptor = (rFormID : (rName : 'LeftEditionForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TLeftEditionForm }
 fm_RightEditionForm: TvcmFormDescriptor = (rFormID : (rName : 'RightEditionForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TRightEditionForm }
 fm_EditionsContainerForm: TvcmFormDescriptor = (rFormID : (rName : 'EditionsContainerForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TEditionsContainerForm }

type
 LeftEditionFormDef = interface
  ['{A9A78553-D6D6-41FE-8759-46E9B97592B8}']
 end;//LeftEditionFormDef

 RightEditionFormDef = interface
  ['{8C64309E-56E0-427B-B77E-E76372E73FA7}']
 end;//RightEditionFormDef

 EditionsContainerFormDef = interface
  ['{9E38EC35-34E1-49E2-B2C9-6D12062610C7}']
 end;//EditionsContainerFormDef
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmOperationStatesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
;

initialization
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
