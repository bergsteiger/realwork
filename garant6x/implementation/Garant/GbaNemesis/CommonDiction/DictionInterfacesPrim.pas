unit DictionInterfacesPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "CommonDiction"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/CommonDiction/DictionInterfacesPrim.pas"
// Начат: 29.09.2009 20:41
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ControllerInterfaces::Category>> F1 Core::Common::CommonDiction::DictionInterfacesPrim
//
// Базовые интерфейсы для работы с Толковым словарём
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
  DocumentAndListInterfaces,
  vcmInterfaces {a},
  vcmControllers {a}
  ;

type
 IdsDictionDocument = interface(IdsBaseDocument)
  {* Документ толкового словаря }
   ['{CED6AA8A-309F-467B-9C4C-D6444BBAF67D}']
   function pm_GetIsMainDiction: Boolean;
   procedure OpenLiteratureList;
     {* открыть список литературы для толкового словаря }
   property IsMainDiction: Boolean
     read pm_GetIsMainDiction;
     {* толкование является основным, для языка по умолчанию }
 end;//IdsDictionDocument
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

end.