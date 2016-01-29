unit dMedicFirmDocument;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Medic"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/dMedicFirmDocument.pas"
// Начат: 11.12.2009 12:59
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Встроенные продукты::Inpharm::Medic::Medic::TdMedicFirmDocument
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
  MedicInterfaces
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
 _IvcmRealData_ = IdMedicFirmDocument;
 {$Include ..\Medic\dMedicFirmDocument.imp.pas}
 TdMedicFirmDocument = class(_dMedicFirmDocument_)
 public
 // public methods
   class function Make: IdMedicFirmDocument; reintroduce;
 end;//TdMedicFirmDocument
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmFormDataSourceRef
  {$IfEnd} //not NoVCM
  ,
  SysUtils,
  l3Utils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdMedicFirmDocument;

{$Include ..\Medic\dMedicFirmDocument.imp.pas}

// start class TdMedicFirmDocument

class function TdMedicFirmDocument.Make: IdMedicFirmDocument;
var
 l_Inst : TdMedicFirmDocument;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

{$IfEnd} //not Admin AND not Monitorings

end.