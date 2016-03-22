unit sdsMedicFirmList;
 {* Бизнес объект прецедента список медицинских фирм-производителей }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\sdsMedicFirmList.pas"
// Стереотип: "UseCaseControllerImp"
// Элемент модели: "TsdsMedicFirmList" MUID: (493A658D0181)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , MedicInterfaces
 , DocumentInterfaces
 , DocumentAndListInterfaces
 , BaseDocumentWithAttributesInterfaces
 , DocumentUnit
 , bsTypesNew
 , l3IID
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , l3NotifyPtrList
;

type
 _SetDataType_ = IdMedicFirmList;
 _SetType_ = IsdsMedicFirmList;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Medic\sdsMedicFirmDocument.imp.pas}
 TsdsMedicFirmList = class(_sdsMedicFirmDocument_, IsdsMedicFirmList)
  {* Бизнес объект прецедента список медицинских фирм-производителей }
  protected
   procedure ChangeSynchroForm(aSynchroForm: TMedicFirmList_SynchroView_Areas);
    {* Переключает форму синхронного просмотра }
   {$If NOT Defined(NoVCM)}
   function MakeData: _SetDataType_; override;
    {* Данные сборки. }
   {$IfEnd} // NOT Defined(NoVCM)
   function pm_GetdsFirmList: IdsMedicFirmList;
   function pm_GetdsSynchroView: IdsMedicFirmListSynchroView;
   procedure OpenAttributes;
    {* Открывает ViewArea "атрибуты документа" }
   function pm_GetIsAttributesActive: Boolean;
   function pm_GetIsDocumentActive: Boolean;
   procedure OpenDrugList;
    {* Открывает ViewArea "список производимых препаратов" }
   function pm_GetIsDrugListActive: Boolean;
   procedure OpenDocument;
    {* Открывает ViewArea "Собственно документ" }
   procedure DoOpenAttributes; override;
    {* - атрибуты. }
   function NeedMakeDSAttributes: Boolean; override;
    {* - необходимость создания БОФ атрибутов. }
   {$If NOT Defined(NoVCM)}
   procedure ClearAreas; override;
    {* Очищает ссылки на области ввода }
   {$IfEnd} // NOT Defined(NoVCM)
   function NeedMakeDrugList: Boolean; override;
   function NeedMakeDocument: Boolean; override;
    {* Определяет - нужно ли создавать область ввода для документа }
   {$If NOT Defined(NoVCM)}
   function GetDataForClone: _InitDataType_; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TsdsMedicFirmList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , dMedicFirmList
 , dsMedicFirmList
 , dsMedicFirmSynchroView
 , dsMedicFirmDocument
 , dsDrugList
 , DynamicDocListUnit
 , afwFacade
 , DynamicTreeUnit
 , BaseTypesUnit
 , deList
 , bsUtils
 , dsAttributes
 , l3Types
 , l3Utils
 , deDocInfo
 , Windows
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
;

type _Instance_R_ = TsdsMedicFirmList;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Medic\sdsMedicFirmDocument.imp.pas}

procedure TsdsMedicFirmList.ChangeSynchroForm(aSynchroForm: TMedicFirmList_SynchroView_Areas);
 {* Переключает форму синхронного просмотра }
//#UC START# *2D720EE59BD5_493A658D0181_var*
//#UC END# *2D720EE59BD5_493A658D0181_var*
begin
//#UC START# *2D720EE59BD5_493A658D0181_impl*
 if (aSynchroForm <> SetData.MedicFirmList_SynchroView_Form) then
 begin
  ClearAllDS;
  SetData.MedicFirmList_SynchroView_Form := aSynchroForm;
  Refresh;
 end;//aSynchroForm <> SetData.MedicFirmList_SynchroView_Form
//#UC END# *2D720EE59BD5_493A658D0181_impl*
end;//TsdsMedicFirmList.ChangeSynchroForm

{$If NOT Defined(NoVCM)}
function TsdsMedicFirmList.MakeData: _SetDataType_;
 {* Данные сборки. }
//#UC START# *47F3778403D9_493A658D0181_var*
//#UC END# *47F3778403D9_493A658D0181_var*
begin
//#UC START# *47F3778403D9_493A658D0181_impl*
 Result := TdMedicFirmList.Make;
 Result.dsFirmListRef.NeedMake := vcm_nmYes;
 Result.dsSynchroViewRef.NeedMake := vcm_nmYes;
//#UC END# *47F3778403D9_493A658D0181_impl*
end;//TsdsMedicFirmList.MakeData
{$IfEnd} // NOT Defined(NoVCM)

function TsdsMedicFirmList.pm_GetdsFirmList: IdsMedicFirmList;
//#UC START# *500D3DC401D9_493A658D0181get_var*
//#UC END# *500D3DC401D9_493A658D0181get_var*
begin
//#UC START# *500D3DC401D9_493A658D0181get_impl*
 !!! Needs to be implemented !!!
//#UC END# *500D3DC401D9_493A658D0181get_impl*
end;//TsdsMedicFirmList.pm_GetdsFirmList

function TsdsMedicFirmList.pm_GetdsSynchroView: IdsMedicFirmListSynchroView;
//#UC START# *500D3E05033F_493A658D0181get_var*
//#UC END# *500D3E05033F_493A658D0181get_var*
begin
//#UC START# *500D3E05033F_493A658D0181get_impl*
 !!! Needs to be implemented !!!
//#UC END# *500D3E05033F_493A658D0181get_impl*
end;//TsdsMedicFirmList.pm_GetdsSynchroView

procedure TsdsMedicFirmList.OpenAttributes;
 {* Открывает ViewArea "атрибуты документа" }
//#UC START# *547039B70620_493A658D0181_var*
//#UC END# *547039B70620_493A658D0181_var*
begin
//#UC START# *547039B70620_493A658D0181_impl*
 inherited OpenAttributes;
//#UC END# *547039B70620_493A658D0181_impl*
end;//TsdsMedicFirmList.OpenAttributes

function TsdsMedicFirmList.pm_GetIsAttributesActive: Boolean;
//#UC START# *5D132F53CBB1_493A658D0181get_var*
//#UC END# *5D132F53CBB1_493A658D0181get_var*
begin
//#UC START# *5D132F53CBB1_493A658D0181get_impl*
 Result := SetData.MedicFirmList_SynchroView_Form = sva_MedicFirmList_SynchroView_Attributes;
//#UC END# *5D132F53CBB1_493A658D0181get_impl*
end;//TsdsMedicFirmList.pm_GetIsAttributesActive

function TsdsMedicFirmList.pm_GetIsDocumentActive: Boolean;
//#UC START# *A5A4F8CABF20_493A658D0181get_var*
//#UC END# *A5A4F8CABF20_493A658D0181get_var*
begin
//#UC START# *A5A4F8CABF20_493A658D0181get_impl*
 Result := SetData.MedicFirmList_SynchroView_Form = sva_MedicFirmList_SynchroView_Document;
//#UC END# *A5A4F8CABF20_493A658D0181get_impl*
end;//TsdsMedicFirmList.pm_GetIsDocumentActive

procedure TsdsMedicFirmList.OpenDrugList;
 {* Открывает ViewArea "список производимых препаратов" }
//#UC START# *BF9026B194BB_493A658D0181_var*
//#UC END# *BF9026B194BB_493A658D0181_var*
begin
//#UC START# *BF9026B194BB_493A658D0181_impl*
 SetData.dsDrugListRef.SetIfNeedMakeNo(vcm_nmForce);
 ChangeSynchroForm(sva_MedicFirmList_SynchroView_DrugList);
//#UC END# *BF9026B194BB_493A658D0181_impl*
end;//TsdsMedicFirmList.OpenDrugList

function TsdsMedicFirmList.pm_GetIsDrugListActive: Boolean;
//#UC START# *C88FE4927F04_493A658D0181get_var*
//#UC END# *C88FE4927F04_493A658D0181get_var*
begin
//#UC START# *C88FE4927F04_493A658D0181get_impl*
 Result := SetData.MedicFirmList_SynchroView_Form = sva_MedicFirmList_SynchroView_DrugList;
//#UC END# *C88FE4927F04_493A658D0181get_impl*
end;//TsdsMedicFirmList.pm_GetIsDrugListActive

procedure TsdsMedicFirmList.OpenDocument;
 {* Открывает ViewArea "Собственно документ" }
//#UC START# *E0B72D4BE61F_493A658D0181_var*
//#UC END# *E0B72D4BE61F_493A658D0181_var*
begin
//#UC START# *E0B72D4BE61F_493A658D0181_impl*
 SetData.dsDocumentRef.SetIfNeedMakeNo(vcm_nmForce);
 ChangeSynchroForm(sva_MedicFirmList_SynchroView_Document);
//#UC END# *E0B72D4BE61F_493A658D0181_impl*
end;//TsdsMedicFirmList.OpenDocument

procedure TsdsMedicFirmList.DoOpenAttributes;
 {* - атрибуты. }
//#UC START# *47FDDACC0101_493A658D0181_var*
//#UC END# *47FDDACC0101_493A658D0181_var*
begin
//#UC START# *47FDDACC0101_493A658D0181_impl*
 SetData.dsAttributesRef.SetIfNeedMakeNo(vcm_nmForce);
 ChangeSynchroForm(sva_MedicFirmList_SynchroView_Attributes);
//#UC END# *47FDDACC0101_493A658D0181_impl*
end;//TsdsMedicFirmList.DoOpenAttributes

function TsdsMedicFirmList.NeedMakeDSAttributes: Boolean;
 {* - необходимость создания БОФ атрибутов. }
//#UC START# *47FE03AE0225_493A658D0181_var*
//#UC END# *47FE03AE0225_493A658D0181_var*
begin
//#UC START# *47FE03AE0225_493A658D0181_impl*
 Result := (SetData.MedicFirmList_SynchroView_Form = sva_MedicFirmList_SynchroView_Attributes) AND
           inherited NeedMakeDSAttributes;
//#UC END# *47FE03AE0225_493A658D0181_impl*
end;//TsdsMedicFirmList.NeedMakeDSAttributes

{$If NOT Defined(NoVCM)}
procedure TsdsMedicFirmList.ClearAreas;
 {* Очищает ссылки на области ввода }
//#UC START# *4938F7E702B7_493A658D0181_var*
//#UC END# *4938F7E702B7_493A658D0181_var*
begin
//#UC START# *4938F7E702B7_493A658D0181_impl*
 !!! Needs to be implemented !!!
//#UC END# *4938F7E702B7_493A658D0181_impl*
end;//TsdsMedicFirmList.ClearAreas
{$IfEnd} // NOT Defined(NoVCM)

function TsdsMedicFirmList.NeedMakeDrugList: Boolean;
//#UC START# *493964C6039A_493A658D0181_var*
//#UC END# *493964C6039A_493A658D0181_var*
begin
//#UC START# *493964C6039A_493A658D0181_impl*
 Result := (SetData.MedicFirmList_SynchroView_Form = sva_MedicFirmList_SynchroView_DrugList) and
           inherited NeedMakeDrugList;
//#UC END# *493964C6039A_493A658D0181_impl*
end;//TsdsMedicFirmList.NeedMakeDrugList

function TsdsMedicFirmList.NeedMakeDocument: Boolean;
 {* Определяет - нужно ли создавать область ввода для документа }
//#UC START# *493D1BE601B1_493A658D0181_var*
//#UC END# *493D1BE601B1_493A658D0181_var*
begin
//#UC START# *493D1BE601B1_493A658D0181_impl*
 Result := (SetData.MedicFirmList_SynchroView_Form = sva_MedicFirmList_SynchroView_Document) AND
           inherited NeedMakeDocument;
//#UC END# *493D1BE601B1_493A658D0181_impl*
end;//TsdsMedicFirmList.NeedMakeDocument

{$If NOT Defined(NoVCM)}
function TsdsMedicFirmList.GetDataForClone: _InitDataType_;
//#UC START# *55C1DD070354_493A658D0181_var*
//#UC END# *55C1DD070354_493A658D0181_var*
begin
//#UC START# *55C1DD070354_493A658D0181_impl*
 Result := pm_GetDsFirmList.MakeNewDocInfo;
//#UC END# *55C1DD070354_493A658D0181_impl*
end;//TsdsMedicFirmList.GetDataForClone
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
