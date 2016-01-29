unit deTips;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DayTips"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/DayTips/deTips.pas"
// Начат: 08.12.2009 18:37
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Интерфейсные элементы::DayTips::DayTips::DayTips::TdeTips
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
  deCommonDiction,
  DocumentUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TdeTips = class(TdeCommonDiction)
 protected
 // overridden protected methods
   function DefaultDocType: TDocumentType; override;
 end;//TdeTips
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TdeTips

function TdeTips.DefaultDocType: TDocumentType;
//#UC START# *4B1E714A0125_49254B6F0325_var*
//#UC END# *4B1E714A0125_49254B6F0325_var*
begin
//#UC START# *4B1E714A0125_49254B6F0325_impl*
 Result := DT_TIP;
//#UC END# *4B1E714A0125_49254B6F0325_impl*
end;//TdeTips.DefaultDocType

{$IfEnd} //not Admin AND not Monitorings

end.