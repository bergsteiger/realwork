unit FiltersInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Filters"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Filters/FiltersInterfaces.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ControllerInterfaces::Category>> F1 Основные прецеденты::Filters::Filters::FiltersInterfaces
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
  l3Interfaces,
  vcmInterfaces {a},
  vcmControllers {a}
  ;

type
 IdsCreateFilter = interface(IvcmViewAreaController)
   ['{0A1955B6-7882-4A4C-919E-F6B89BED5BE2}']
   function Get_Name: Il3CString;
   procedure CreateFilter(const aName: Il3CString);
   procedure RenameFilter(const aName: Il3CString);
   property Name: Il3CString
     read Get_Name;
 end;//IdsCreateFilter
{$IfEnd} //not Admin AND not Monitorings

implementation

end.