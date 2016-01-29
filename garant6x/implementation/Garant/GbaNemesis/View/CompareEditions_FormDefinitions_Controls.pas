unit CompareEditions_FormDefinitions_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/CompareEditions_FormDefinitions_Controls.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Пользовательские сервисы::CompareEditions::View::FormDefinitions
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  tfwString
  {$IfEnd} //not NoScripts
  ,
  vcmExternalInterfaces {a}
  ;

const
   { LeftEditionIDs }
  fm_LeftEditionForm : TvcmFormDescriptor = (rFormID : (rName : 'LeftEditionForm'; rID : 0); rFactory : nil);
   { Идентификатор формы TLeftEditionForm }

type
 LeftEditionFormDef = interface(IUnknown)
   ['{A9A78553-D6D6-41FE-8759-46E9B97592B8}']
 end;//LeftEditionFormDef

const
   { RightEditionIDs }
  fm_RightEditionForm : TvcmFormDescriptor = (rFormID : (rName : 'RightEditionForm'; rID : 0); rFactory : nil);
   { Идентификатор формы TRightEditionForm }

type
 RightEditionFormDef = interface(IUnknown)
   ['{8C64309E-56E0-427B-B77E-E76372E73FA7}']
 end;//RightEditionFormDef

const
   { EditionsContainerIDs }
  fm_EditionsContainerForm : TvcmFormDescriptor = (rFormID : (rName : 'EditionsContainerForm'; rID : 0); rFactory : nil);
   { Идентификатор формы TEditionsContainerForm }

type
 EditionsContainerFormDef = interface(IUnknown)
   ['{9E38EC35-34E1-49E2-B2C9-6D12062610C7}']
 end;//EditionsContainerFormDef
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

type
 Tkw_Form_LeftEdition_ID = {final scriptword} class(TtfwString)
  {* Слово словаря для идентификатора формы LeftEdition
----
*Пример использования*:
[code]
'aControl' форма::LeftEdition TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_LeftEdition_ID
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_Form_LeftEdition_ID

class function Tkw_Form_LeftEdition_ID.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::LeftEdition';
end;//Tkw_Form_LeftEdition_ID.GetWordNameForRegister

function Tkw_Form_LeftEdition_ID.GetString: AnsiString;
 {-}
begin
 Result := 'LeftEditionForm';
end;//Tkw_Form_LeftEdition_ID.GetString

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

type
 Tkw_Form_RightEdition_ID = {final scriptword} class(TtfwString)
  {* Слово словаря для идентификатора формы RightEdition
----
*Пример использования*:
[code]
'aControl' форма::RightEdition TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_RightEdition_ID
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_Form_RightEdition_ID

class function Tkw_Form_RightEdition_ID.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::RightEdition';
end;//Tkw_Form_RightEdition_ID.GetWordNameForRegister

function Tkw_Form_RightEdition_ID.GetString: AnsiString;
 {-}
begin
 Result := 'RightEditionForm';
end;//Tkw_Form_RightEdition_ID.GetString

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

type
 Tkw_Form_EditionsContainer_ID = {final scriptword} class(TtfwString)
  {* Слово словаря для идентификатора формы EditionsContainer
----
*Пример использования*:
[code]
'aControl' форма::EditionsContainer TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_EditionsContainer_ID
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_Form_EditionsContainer_ID

class function Tkw_Form_EditionsContainer_ID.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::EditionsContainer';
end;//Tkw_Form_EditionsContainer_ID.GetWordNameForRegister

function Tkw_Form_EditionsContainer_ID.GetString: AnsiString;
 {-}
begin
 Result := 'EditionsContainerForm';
end;//Tkw_Form_EditionsContainer_ID.GetString

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings


initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_LeftEdition_ID
 Tkw_Form_LeftEdition_ID.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_RightEdition_ID
 Tkw_Form_RightEdition_ID.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_EditionsContainer_ID
 Tkw_Form_EditionsContainer_ID.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.