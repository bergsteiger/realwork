unit FiltersInterfaces;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Filters\FiltersInterfaces.pas"
// Стереотип: "ControllerInterfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3Interfaces
;

type
 IdsCreateFilter = interface
  ['{0A1955B6-7882-4A4C-919E-F6B89BED5BE2}']
  function Get_Name: Il3CString;
  procedure CreateFilter(const aName: Il3CString);
  procedure RenameFilter(const aName: Il3CString);
  property Name: Il3CString
   read Get_Name;
 end;//IdsCreateFilter
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
