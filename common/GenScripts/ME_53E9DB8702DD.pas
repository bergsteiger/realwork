unit vcmMenuManagerTypes;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMenuManagerTypes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "vcmMenuManagerTypes" MUID: (53E9DB8702DD)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmMenus
;

type
 PvcmMenuItemClickListener = ^IvcmMenuItemClickListener;

 IvcmMenuItemClickListener = interface
  ['{3174E619-23DB-4925-8BD5-426D327F9D84}']
  procedure NotifyMenuItemClicked(anItem: TvcmMenuItem);
 end;//IvcmMenuItemClickListener

 TvcmMenuOption = (
  vcm_moEntitiesInMainMenu
  , vcm_moEntitiesInTopMainMenu
  , vcm_moEntitiesInChildMenu
  , vcm_moEntitesInContextMenu
 );//TvcmMenuOption

 TvcmMenuOptions = set of TvcmMenuOption;

 TvcmToolbarOption = (
  vcm_toModulesInMainToolbar
  , vcm_toEntitiesInMainToolbar
  , vcm_toEntitiesInChildToolbar
 );//TvcmToolbarOption

 TvcmToolbarOptions = set of TvcmToolbarOption;
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
