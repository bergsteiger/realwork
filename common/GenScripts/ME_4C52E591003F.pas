unit Inpharm_Strange_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm_Strange_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "Strange" MUID: (4C52E591003F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 en_MedicListSynchroView = 'MedicListSynchroView';
 en_capMedicListSynchroView = 'Синхронный просмотр ИНФАРМ';
 op_OpenDocument = 'OpenDocument';
 op_capOpenDocument = 'Текст документа';
 op_OpenList = 'OpenList';
 op_capOpenList = 'Список препаратов';
 op_OpenAttributesForm = 'OpenAttributesForm';
 op_capOpenAttributesForm = '';
 en_MedicFirmList = 'MedicFirmList';
 en_capMedicFirmList = '';
 op_CountryFilter = 'CountryFilter';
 op_capCountryFilter = '';

var opcode_MedicListSynchroView_OpenDocument: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_MedicListSynchroView_OpenDocument_Drug: TvcmOperationStateIndex = (rID : -1);
 {* Синхронный просмотр ИНФАРМ -> Текст документа <-> Описание препарата }
var st_user_MedicListSynchroView_OpenDocument_MedicFirm: TvcmOperationStateIndex = (rID : -1);
 {* Синхронный просмотр ИНФАРМ -> Текст документа <-> Описание фирмы }
var opcode_MedicListSynchroView_OpenList: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_MedicListSynchroView_OpenList_Drug: TvcmOperationStateIndex = (rID : -1);
 {* Синхронный просмотр ИНФАРМ -> Список препаратов <-> Препараты-синонимы }
var st_user_MedicListSynchroView_OpenList_MedicFirm: TvcmOperationStateIndex = (rID : -1);
 {* Синхронный просмотр ИНФАРМ -> Список препаратов <-> Производимые препараты }
var opcode_MedicListSynchroView_OpenAttributesForm: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_MedicFirmList_CountryFilter: TvcmOPID = (rEnID : -1; rOpID : -1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmOperationStatesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
;

initialization
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_MedicListSynchroView, op_OpenDocument, en_capMedicListSynchroView, op_capOpenDocument, False, False, opcode_MedicListSynchroView_OpenDocument)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('Drug', st_user_MedicListSynchroView_OpenDocument_Drug))^ do
  begin
   rCaption := 'Описание препарата';
  end;
  with AddState(TvcmOperationStateForRegister_C('MedicFirm', st_user_MedicListSynchroView_OpenDocument_MedicFirm))^ do
  begin
   rCaption := 'Описание фирмы';
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_MedicListSynchroView, op_OpenList, en_capMedicListSynchroView, op_capOpenList, False, False, opcode_MedicListSynchroView_OpenList)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('Drug', st_user_MedicListSynchroView_OpenList_Drug))^ do
  begin
   rCaption := 'Препараты-синонимы';
   rHint := 'Список препаратов-синонимов по международному названию';
   rImageIndex := 181;
  end;
  with AddState(TvcmOperationStateForRegister_C('MedicFirm', st_user_MedicListSynchroView_OpenList_MedicFirm))^ do
  begin
   rCaption := 'Производимые препараты';
   rHint := 'Список производимых препаратов';
   rImageIndex := 183;
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_MedicListSynchroView, op_OpenDocument, en_capMedicListSynchroView, op_capOpenDocument, False, False, opcode_MedicListSynchroView_OpenDocument)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_MedicListSynchroView, op_OpenAttributesForm, en_capMedicListSynchroView, op_capOpenAttributesForm, False, False, opcode_MedicListSynchroView_OpenAttributesForm)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_MedicListSynchroView, op_OpenList, en_capMedicListSynchroView, op_capOpenList, False, False, opcode_MedicListSynchroView_OpenList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_MedicFirmList, op_CountryFilter, en_capMedicFirmList, op_capCountryFilter, False, False, opcode_MedicFirmList_CountryFilter)) do
 begin
 end;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
