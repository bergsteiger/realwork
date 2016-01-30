unit MainWindowInterfaces;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\MainWindowControllers\MainWindowInterfaces.pas"
// Стереотип: "ControllerInterfaces"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentAndListInterfaces
 , nsTypes
 , nevBase
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 IsdsMainWindow = interface
  {* Основное окно }
  ['{4BABE209-5CE4-4408-B307-6EF460A071E8}']
  function pm_GetdsBaloonWarning: IdsWarning;
  function As_InsWarningGenerator: InsWarningGenerator;
   {* Метод приведения нашего интерфейса к InsWarningGenerator }
  property dsBaloonWarning: IdsWarning
   read pm_GetdsBaloonWarning;
 end;//IsdsMainWindow
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
