unit Search_FormDefinitions_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search_FormDefinitions_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "FormDefinitions" MUID: (4BD97FDB031A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
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
 fm_enQueryCard: TvcmFormDescriptor = (rFormID : (rName : 'enQueryCard'; rID : 0); rFactory : nil);
  {* Идентификатор формы TenQueryCard }
 fm_efPreviewForm: TvcmFormDescriptor = (rFormID : (rName : 'efPreviewForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TefPreviewForm }
 fm_cfSaveLoad: TvcmFormDescriptor = (rFormID : (rName : 'cfSaveLoad'; rID : 0); rFactory : nil);
  {* Идентификатор формы TcfSaveLoad }

type
 QueryCardFormDef = interface
  ['{5BDE6F09-5CC9-41E0-9B14-B0F2D62D4D46}']
 end;//QueryCardFormDef

 PreviewFormDef = interface
  ['{C817C51B-CC87-4935-94AC-50A78B3E7C66}']
 end;//PreviewFormDef

 SaveLoadFormDef = interface
  ['{24C35E19-224B-474C-B34F-32E5FFB04B34}']
 end;//SaveLoadFormDef
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin)

end.
