unit Search_FormDefinitions_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search_FormDefinitions_Controls.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::FormDefinitions
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
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
   { QueryCardIDs }
  fm_enQueryCard : TvcmFormDescriptor = (rFormID : (rName : 'enQueryCard'; rID : 0); rFactory : nil);
   { Идентификатор формы TenQueryCard }

type
 QueryCardFormDef = interface(IUnknown)
   ['{5BDE6F09-5CC9-41E0-9B14-B0F2D62D4D46}']
 end;//QueryCardFormDef

const
   { PreviewFormIDs }
  fm_efPreviewForm : TvcmFormDescriptor = (rFormID : (rName : 'efPreviewForm'; rID : 0); rFactory : nil);
   { Идентификатор формы TefPreviewForm }

type
 PreviewFormDef = interface(IUnknown)
   ['{C817C51B-CC87-4935-94AC-50A78B3E7C66}']
 end;//PreviewFormDef

const
   { SaveLoadIDs }
  fm_cfSaveLoad : TvcmFormDescriptor = (rFormID : (rName : 'cfSaveLoad'; rID : 0); rFactory : nil);
   { Идентификатор формы TcfSaveLoad }

type
 SaveLoadFormDef = interface(IUnknown)
   ['{24C35E19-224B-474C-B34F-32E5FFB04B34}']
 end;//SaveLoadFormDef
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
{$If not defined(Admin) AND not defined(NoScripts)}

type
 Tkw_Form_QueryCard_ID = {final scriptword} class(TtfwString)
  {* Слово словаря для идентификатора формы QueryCard
----
*Пример использования*:
[code]
'aControl' форма::QueryCard TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_QueryCard_ID
{$IfEnd} //not Admin AND not NoScripts

{$If not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_Form_QueryCard_ID

class function Tkw_Form_QueryCard_ID.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::QueryCard';
end;//Tkw_Form_QueryCard_ID.GetWordNameForRegister

function Tkw_Form_QueryCard_ID.GetString: AnsiString;
 {-}
begin
 Result := 'enQueryCard';
end;//Tkw_Form_QueryCard_ID.GetString

{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}

type
 Tkw_Form_Preview_ID = {final scriptword} class(TtfwString)
  {* Слово словаря для идентификатора формы Preview
----
*Пример использования*:
[code]
'aControl' форма::Preview TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Preview_ID
{$IfEnd} //not Admin AND not NoScripts

{$If not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_Form_Preview_ID

class function Tkw_Form_Preview_ID.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::Preview';
end;//Tkw_Form_Preview_ID.GetWordNameForRegister

function Tkw_Form_Preview_ID.GetString: AnsiString;
 {-}
begin
 Result := 'efPreviewForm';
end;//Tkw_Form_Preview_ID.GetString

{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}

type
 Tkw_Form_SaveLoad_ID = {final scriptword} class(TtfwString)
  {* Слово словаря для идентификатора формы SaveLoad
----
*Пример использования*:
[code]
'aControl' форма::SaveLoad TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_SaveLoad_ID
{$IfEnd} //not Admin AND not NoScripts

{$If not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_Form_SaveLoad_ID

class function Tkw_Form_SaveLoad_ID.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::SaveLoad';
end;//Tkw_Form_SaveLoad_ID.GetWordNameForRegister

function Tkw_Form_SaveLoad_ID.GetString: AnsiString;
 {-}
begin
 Result := 'cfSaveLoad';
end;//Tkw_Form_SaveLoad_ID.GetString

{$IfEnd} //not Admin AND not NoScripts
{$IfEnd} //not Admin


initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_Form_QueryCard_ID
 Tkw_Form_QueryCard_ID.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_Form_Preview_ID
 Tkw_Form_Preview_ID.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_Form_SaveLoad_ID
 Tkw_Form_SaveLoad_ID.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts

end.