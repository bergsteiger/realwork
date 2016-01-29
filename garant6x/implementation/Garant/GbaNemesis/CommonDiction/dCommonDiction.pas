unit dCommonDiction;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "CommonDiction"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/CommonDiction/dCommonDiction.pas"
// Начат: 11.12.2009 12:19
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::CommonDiction::CommonDiction::TdCommonDiction
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
  CommonDictionInterfaces,
  DynamicTreeUnit
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  l3Types,
  BaseDocumentWithAttributesInterfaces,
  DocumentAndListInterfaces,
  DocumentInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObject
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _IvcmRealData_ = IdCommonDiction;
 {$Include ..\CommonDiction\dCommonDiction.imp.pas}
 TdCommonDiction = class(_dCommonDiction_)
 end;//TdCommonDiction
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoVCM)}
  ,
  vcmFormDataSourceRef
  {$IfEnd} //not NoVCM
  ,
  l3Utils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdCommonDiction;

{$Include ..\CommonDiction\dCommonDiction.imp.pas}


{$IfEnd} //not Admin AND not Monitorings
end.