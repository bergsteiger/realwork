unit SearchLite_FormDefinitions_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\SearchLite_FormDefinitions_Controls.pas"
// Стереотип: "VCMControls"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwString
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 fm_efTreeAttributeSelect: TvcmFormDescriptor = (rFormID : (rName : 'efTreeAttributeSelect'; rID : 0); rFactory : nil);
  {* Идентификатор формы TefTreeAttributeSelect }

const
 fm_enSelectedAttributes: TvcmFormDescriptor = (rFormID : (rName : 'enSelectedAttributes'; rID : 0); rFactory : nil);
  {* Идентификатор формы TenSelectedAttributes }

const
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

type
 {$If NOT Defined(NoScripts)}
 Tkw_Form_TreeAttributeSelect_ID = {final} class(TtfwString)
  {* Слово словаря для идентификатора формы TreeAttributeSelect
----
*Пример использования*:
[code]
'aControl' форма::TreeAttributeSelect TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_TreeAttributeSelect_ID
 {$IfEnd} // NOT Defined(NoScripts)

 {$If NOT Defined(NoScripts)}
 Tkw_Form_SelectedAttributes_ID = {final} class(TtfwString)
  {* Слово словаря для идентификатора формы SelectedAttributes
----
*Пример использования*:
[code]
'aControl' форма::SelectedAttributes TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_SelectedAttributes_ID
 {$IfEnd} // NOT Defined(NoScripts)

 {$If NOT Defined(NoScripts)}
 Tkw_Form_AttributeSelect_ID = {final} class(TtfwString)
  {* Слово словаря для идентификатора формы AttributeSelect
----
*Пример использования*:
[code]
'aControl' форма::AttributeSelect TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_AttributeSelect_ID
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_TreeAttributeSelect_ID.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::TreeAttributeSelect';
end;//Tkw_Form_TreeAttributeSelect_ID.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_Form_TreeAttributeSelect_ID.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_4B75BABFB57D_var*
//#UC END# *4DDFD2EA0116_4B75BABFB57D_var*
begin
//#UC START# *4DDFD2EA0116_4B75BABFB57D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_4B75BABFB57D_impl*
end;//Tkw_Form_TreeAttributeSelect_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_SelectedAttributes_ID.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::SelectedAttributes';
end;//Tkw_Form_SelectedAttributes_ID.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_Form_SelectedAttributes_ID.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_5E03387D0255_var*
//#UC END# *4DDFD2EA0116_5E03387D0255_var*
begin
//#UC START# *4DDFD2EA0116_5E03387D0255_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_5E03387D0255_impl*
end;//Tkw_Form_SelectedAttributes_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_AttributeSelect_ID.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::AttributeSelect';
end;//Tkw_Form_AttributeSelect_ID.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_Form_AttributeSelect_ID.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_49CBE92ABADB_var*
//#UC END# *4DDFD2EA0116_49CBE92ABADB_var*
begin
//#UC START# *4DDFD2EA0116_49CBE92ABADB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_49CBE92ABADB_impl*
end;//Tkw_Form_AttributeSelect_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_Form_TreeAttributeSelect_ID.RegisterInEngine;
 {* Регистрация Tkw_Form_TreeAttributeSelect_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_SelectedAttributes_ID.RegisterInEngine;
 {* Регистрация Tkw_Form_SelectedAttributes_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_AttributeSelect_ID.RegisterInEngine;
 {* Регистрация Tkw_Form_AttributeSelect_ID }
{$IfEnd} // NOT Defined(NoScripts)

end.
