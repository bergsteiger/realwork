unit vcmFormDataSource;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/vcmFormDataSource.pas"
// Начат: 12.11.2008 21:30
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM::Implementation::TvcmFormDataSource
//
// "Бизнес объект формы". Для поддержки старого нетипизированного подхода
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
  vcmControllers,
  vcmInterfaces,
  vcmExternalInterfaces,
  vcmLocalInterfaces,
  l3ProtoObjectWithCOMQI,
  l3Interfaces,
  l3NotifyPtrList
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 _InitDataType_ = IUnknown;
 _FormDataSourceType_ = IvcmViewAreaController;
 {$Include ..\implementation\vcmFormDataSource.imp.pas}
 TvcmFormDataSource = class(_vcmFormDataSource_)
  {* "Бизнес объект формы". Для поддержки старого нетипизированного подхода }
 end;//TvcmFormDataSource
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3InterfacesMisc,
  SysUtils,
  l3Base
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

type _Instance_R_ = TvcmFormDataSource;

{$Include ..\implementation\vcmFormDataSource.imp.pas}


{$IfEnd} //not NoVCM
end.