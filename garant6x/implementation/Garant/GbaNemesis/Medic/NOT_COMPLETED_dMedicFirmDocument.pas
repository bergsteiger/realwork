unit NOT_COMPLETED_dMedicFirmDocument;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\NOT_COMPLETED_dMedicFirmDocument.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdMedicFirmDocument" MUID: (4B2217FA02BD)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , MedicInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , BaseDocumentWithAttributesInterfaces
 , l3Types
 , DocumentAndListInterfaces
 , DocumentInterfaces
 , l3ProtoObject
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _IvcmRealData_ = IdMedicFirmDocument;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Medic\dMedicFirmDocument.imp.pas}
 TdMedicFirmDocument = class(_dMedicFirmDocument_)
  public
   class function Make: IdMedicFirmDocument; reintroduce;
 end;//TdMedicFirmDocument
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmFormDataSourceRef
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 , l3Utils
;

type _Instance_R_ = TdMedicFirmDocument;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Medic\dMedicFirmDocument.imp.pas}

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
end;//TdMedicFirmDocument.Make
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
