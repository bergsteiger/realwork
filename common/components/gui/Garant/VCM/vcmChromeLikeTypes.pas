unit vcmChromeLikeTypes;

// Модуль: "w:\common\components\gui\Garant\VCM\vcmChromeLikeTypes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "vcmChromeLikeTypes" MUID: (537D82F10098)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Menus
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 IvcmMenuHolder = interface
  ['{06E8AA85-09B4-4185-839F-66D5F1138AA0}']
  function Get_MainMenu: TMenuItem;
  property MainMenu: TMenuItem
   read Get_MainMenu;
 end;//IvcmMenuHolder
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
