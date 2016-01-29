unit bsBase;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1DocumentProcessing"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1DocumentProcessing/bsBase.pas"
// Начат: 12.12.2005 16.48
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::F1DocumentProcessing::BaseDataObject::TbsBase
//
// Базовый класс бизнес слоя
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
  l3ProtoObject,
  l3IID,
  l3Interfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _l3COMQueryInterface_Parent_ = Tl3ProtoObject;
 {$Include w:\common\components\rtl\Garant\L3\l3COMQueryInterface.imp.pas}
 TbsBase = class(_l3COMQueryInterface_)
  {* Базовый класс бизнес слоя }
 end;//TbsBase
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3InterfacesMisc
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

{$Include w:\common\components\rtl\Garant\L3\l3COMQueryInterface.imp.pas}


{$IfEnd} //not Admin AND not Monitorings
end.