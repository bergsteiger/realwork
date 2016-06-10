unit SearchLite_FormDefinitions_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\SearchLite_FormDefinitions_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "FormDefinitions" MUID: (4D80CDE4033D)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

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
 fm_efTreeAttributeSelect: TvcmFormDescriptor = (rFormID : (rName : 'efTreeAttributeSelect'; rID : 0); rFactory : nil);
  {* Идентификатор формы TefTreeAttributeSelect }
 fm_enSelectedAttributes: TvcmFormDescriptor = (rFormID : (rName : 'enSelectedAttributes'; rID : 0); rFactory : nil);
  {* Идентификатор формы TenSelectedAttributes }
 fm_cfAttributeSelect: TvcmFormDescriptor = (rFormID : (rName : 'cfAttributeSelect'; rID : 0); rFactory : nil);
  {* Идентификатор формы TcfAttributeSelect }

type
 TreeAttributeSelectFormDef = interface
  ['{0933678C-206B-4B91-9452-24D754AB76AB}']
 end;//TreeAttributeSelectFormDef

 SelectedAttributesFormDef = interface
  ['{E67C391C-CA9A-40EF-A203-0AC4A633D327}']
 end;//SelectedAttributesFormDef

 AttributeSelectFormDef = interface
  ['{8D3AADC2-E9A4-4383-B8D6-1B1D81711E91}']
 end;//AttributeSelectFormDef

implementation

uses
 l3ImplUses
;

end.
