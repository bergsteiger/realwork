unit Search_FormDefinitions_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search_FormDefinitions_Controls.pas"
// Стереотип: "VCMControls"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
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
 fm_enQueryCard: TvcmFormDescriptor = (rFormID : (rName : 'enQueryCard'; rID : 0); rFactory : nil);
  {* Идентификатор формы TenQueryCard }

const
 fm_efPreviewForm: TvcmFormDescriptor = (rFormID : (rName : 'efPreviewForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TefPreviewForm }

const
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

type
 {$If NOT Defined(NoScripts)}
 Tkw_Form_QueryCard_ID = {final} class(TtfwString)
  {* Слово словаря для идентификатора формы QueryCard
----
*Пример использования*:
[code]
'aControl' форма::QueryCard TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_QueryCard_ID
 {$IfEnd} // NOT Defined(NoScripts)

 {$If NOT Defined(NoScripts)}
 Tkw_Form_Preview_ID = {final} class(TtfwString)
  {* Слово словаря для идентификатора формы Preview
----
*Пример использования*:
[code]
'aControl' форма::Preview TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Preview_ID
 {$IfEnd} // NOT Defined(NoScripts)

 {$If NOT Defined(NoScripts)}
 Tkw_Form_SaveLoad_ID = {final} class(TtfwString)
  {* Слово словаря для идентификатора формы SaveLoad
----
*Пример использования*:
[code]
'aControl' форма::SaveLoad TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_SaveLoad_ID
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_QueryCard_ID.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::QueryCard';
end;//Tkw_Form_QueryCard_ID.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_Form_QueryCard_ID.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_9C995D4F8407_var*
//#UC END# *4DDFD2EA0116_9C995D4F8407_var*
begin
//#UC START# *4DDFD2EA0116_9C995D4F8407_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_9C995D4F8407_impl*
end;//Tkw_Form_QueryCard_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_Preview_ID.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::Preview';
end;//Tkw_Form_Preview_ID.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_Form_Preview_ID.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_6334FE49477F_var*
//#UC END# *4DDFD2EA0116_6334FE49477F_var*
begin
//#UC START# *4DDFD2EA0116_6334FE49477F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_6334FE49477F_impl*
end;//Tkw_Form_Preview_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_SaveLoad_ID.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::SaveLoad';
end;//Tkw_Form_SaveLoad_ID.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_Form_SaveLoad_ID.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_863CC8E7A493_var*
//#UC END# *4DDFD2EA0116_863CC8E7A493_var*
begin
//#UC START# *4DDFD2EA0116_863CC8E7A493_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_863CC8E7A493_impl*
end;//Tkw_Form_SaveLoad_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_Form_QueryCard_ID.RegisterInEngine;
 {* Регистрация Tkw_Form_QueryCard_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_Preview_ID.RegisterInEngine;
 {* Регистрация Tkw_Form_Preview_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_SaveLoad_ID.RegisterInEngine;
 {* Регистрация Tkw_Form_SaveLoad_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
