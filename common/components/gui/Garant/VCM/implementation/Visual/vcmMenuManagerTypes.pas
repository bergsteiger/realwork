unit vcmMenuManagerTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/vcmMenuManagerTypes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VCM$Visual::Visual::vcmMenuManagerTypes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmMenus
  ;

type
 IvcmMenuItemClickListener = interface(IUnknown)
   ['{3174E619-23DB-4925-8BD5-426D327F9D84}']
   procedure NotifyMenuItemClicked(anItem: TvcmMenuItem);
 end;//IvcmMenuItemClickListener
 PvcmMenuItemClickListener = ^IvcmMenuItemClickListener;

{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
{$IfEnd} //not NoVCM
end.