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

const
 fm_RightEditionForm: TvcmFormDescriptor = (rFormID : (rName : 'RightEditionForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TRightEditionForm }

const
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
 {$If NOT Defined(NoScripts)}
 , tfwString
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_LeftEdition_ID = {final} class(TtfwString)
  {* Слово словаря для идентификатора формы LeftEdition
----
*Пример использования*:
[code]
'aControl' форма::LeftEdition TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_LeftEdition_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_RightEdition_ID = {final} class(TtfwString)
  {* Слово словаря для идентификатора формы RightEdition
----
*Пример использования*:
[code]
'aControl' форма::RightEdition TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_RightEdition_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_EditionsContainer_ID = {final} class(TtfwString)
  {* Слово словаря для идентификатора формы EditionsContainer
----
*Пример использования*:
[code]
'aControl' форма::EditionsContainer TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_EditionsContainer_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_LeftEdition_ID.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::LeftEdition';
end;//Tkw_Form_LeftEdition_ID.GetWordNameForRegister

function Tkw_Form_LeftEdition_ID.GetString: AnsiString;
begin
 Result := 'LeftEditionForm';
end;//Tkw_Form_LeftEdition_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_RightEdition_ID.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::RightEdition';
end;//Tkw_Form_RightEdition_ID.GetWordNameForRegister

function Tkw_Form_RightEdition_ID.GetString: AnsiString;
begin
 Result := 'RightEditionForm';
end;//Tkw_Form_RightEdition_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_EditionsContainer_ID.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::EditionsContainer';
end;//Tkw_Form_EditionsContainer_ID.GetWordNameForRegister

function Tkw_Form_EditionsContainer_ID.GetString: AnsiString;
begin
 Result := 'EditionsContainerForm';
end;//Tkw_Form_EditionsContainer_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_Form_LeftEdition_ID.RegisterInEngine;
 {* Регистрация Tkw_Form_LeftEdition_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_RightEdition_ID.RegisterInEngine;
 {* Регистрация Tkw_Form_RightEdition_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_EditionsContainer_ID.RegisterInEngine;
 {* Регистрация Tkw_Form_EditionsContainer_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
