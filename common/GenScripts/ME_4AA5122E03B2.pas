unit moAdmin;
 {* Администрирование пользователей }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moAdmin.pas"
// Стереотип: "VCMUseCaseRealization"
// Элемент модели: "Admin" MUID: (4AA5122E03B2)
// Имя типа: "Tmo_Admin"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , Admin_Module
;

type
 Tmo_Admin = {final} class(TAdminModule)
  {* Администрирование пользователей }
 end;//Tmo_Admin
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(Admin)

end.
