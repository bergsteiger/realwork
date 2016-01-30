unit OfficeLikeAppInterfaces;

// Модуль: "w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLikeAppInterfaces.pas"
// Стереотип: "Interfaces"

{$Include sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmInterfaces
;

type
 InsWindow = interface
  {* интерфейс окна. Для работы с окнами системы }
  ['{8F95EBB5-E396-4AF3-9A6A-EFD0684A20C9}']
  function Get_Form: IvcmEntityForm;
  property Form: IvcmEntityForm
   read Get_Form;
 end;//InsWindow
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
