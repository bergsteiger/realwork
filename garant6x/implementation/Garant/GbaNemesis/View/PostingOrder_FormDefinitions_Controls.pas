unit PostingOrder_FormDefinitions_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PostingOrder_FormDefinitions_Controls.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Common For Shell And Monitoring::PostingOrder::View::FormDefinitions
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
   { PostingsListIDs }
  fm_enPostingsList : TvcmFormDescriptor = (rFormID : (rName : 'enPostingsList'; rID : 0); rFactory : nil);
   { Идентификатор формы TenPostingsList }

type
 PostingsListFormDef = interface(IUnknown)
   ['{69D1C6BF-ECE3-4BB1-8DA5-998AB45694C7}']
 end;//PostingsListFormDef
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
{$If not defined(Admin) AND not defined(NoScripts)}

type
 Tkw_Form_PostingsList_ID = {final scriptword} class(TtfwString)
  {* Слово словаря для идентификатора формы PostingsList
----
*Пример использования*:
[code]
'aControl' форма::PostingsList TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_PostingsList_ID
{$IfEnd} //not Admin AND not NoScripts

{$If not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_Form_PostingsList_ID

class function Tkw_Form_PostingsList_ID.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::PostingsList';
end;//Tkw_Form_PostingsList_ID.GetWordNameForRegister

function Tkw_Form_PostingsList_ID.GetString: AnsiString;
 {-}
begin
 Result := 'enPostingsList';
end;//Tkw_Form_PostingsList_ID.GetString

{$IfEnd} //not Admin AND not NoScripts
{$IfEnd} //not Admin


initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_Form_PostingsList_ID
 Tkw_Form_PostingsList_ID.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts

end.