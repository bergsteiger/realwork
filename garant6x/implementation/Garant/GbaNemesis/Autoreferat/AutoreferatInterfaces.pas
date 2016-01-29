unit AutoreferatInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Autoreferat"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Autoreferat/AutoreferatInterfaces.pas"
// Начат: 27.11.2008 23:40
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ControllerInterfaces::Category>> F1 Пользовательские сервисы::Autoreferat::Autoreferat::AutoreferatInterfaces
//
// Интерфейсы для работы с новостной лентой
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
  SearchInterfaces,
  vcmInterfaces {a},
  vcmControllers {a}
  ;

type
 IdsNewsLine = interface(IvcmViewAreaController)
  {* Новостная лента }
   ['{34D4F64F-ABFB-48BE-B04F-DD609BB32DAB}']
 end;//IdsNewsLine

 IsdsAutoreferat = interface(IsdsBaseDocument)
   ['{22A93E6D-D6A0-4D95-BA27-C6A9CFBBF259}']
   function pm_GetMakeNewsLineFakeDS: IdsNewsLine;
   property MakeNewsLineFakeDS: IdsNewsLine
     read pm_GetMakeNewsLineFakeDS;
     {* Фиктивный бизнес объект новостной ленты }
 end;//IsdsAutoreferat
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

end.