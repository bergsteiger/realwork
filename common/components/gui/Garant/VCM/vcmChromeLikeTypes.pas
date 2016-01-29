unit vcmChromeLikeTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Модуль: "w:/common/components/gui/Garant/VCM/vcmChromeLikeTypes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VCM::vcmChromeLikeSupport::vcmChromeLikeTypes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Menus
  {$IfEnd} //not NoVCL
  
  ;

type
 IvcmMenuHolder = interface(IUnknown)
   ['{06E8AA85-09B4-4185-839F-66D5F1138AA0}']
   function Get_MainMenu: TMenuItem;
   property MainMenu: TMenuItem
     read Get_MainMenu;
 end;//IvcmMenuHolder
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
{$IfEnd} //not NoVCM
end.