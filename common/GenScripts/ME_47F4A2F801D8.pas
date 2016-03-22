unit sdsDrugDocument;
 {* Базовый для списка препаратов и описания препаратов. }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Drug\sdsDrugDocument.pas"
// Стереотип: "UseCaseControllerImp"
// Элемент модели: "TsdsDrugDocument" MUID: (47F4A2F801D8)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , MedicInterfaces
 , DocumentInterfaces
 , DocumentAndListInterfaces
 , WorkWithDocumentInterfaces
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
 , afwInterfaces
 , nevTools
;

type
 _SetDataType_ = IdDrugDocument;
 _InitDataType_ = IdeDocInfo;
 _SetType_ = IsdsDrugDocument;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Drug\sdsBaseDrugDocument.imp.pas}
 _afwApplicationDataUpdate_Parent_ = _sdsBaseDrugDocument_;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}
 _nsOpenContents_Parent_ = _afwApplicationDataUpdate_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\nsOpenContents.imp.pas}
 TsdsDrugDocument = class(_nsOpenContents_, IsdsDrugDocument, IucpDocumentWithContents)
  {* Базовый для списка препаратов и описания препаратов. }
  protected
   function As_IucpDocumentWithContents: IucpDocumentWithContents;
    {* Метод приведения нашего интерфейса к IucpDocumentWithContents }
   {$If NOT Defined(NoVCM)}
   function MakeData: _SetDataType_; override;
    {* Данные сборки. }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure OpenDrugInternationalNameSynonims;
    {* Открыть список синонимов по международному названию. }
   function BaseDocumentClass: IdsBaseDocument; override;
   function pm_GetdsContents: IdsBaseContents;
   procedure FinishDataUpdate; override;
   {$If NOT Defined(NoVCM)}
   procedure DataExchange; override;
    {* - вызывается после получения данных инициализации. }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearAllDS; override;
   {$If NOT Defined(NoVCM)}
   procedure ClearAreas; override;
    {* Очищает ссылки на области ввода }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure FillState; override;
 end;//TsdsDrugDocument
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , dsBaseContents
 , dsDrugDocument
 , dDrugDocument
 , SysUtils
 , l3Types
 , DynamicDocListUnit
 , DynamicTreeUnit
 , dsDrugList
 , l3Utils
 , bsUtils
 , deList
 , afwFacade
 , dsAttributes
 , deDocInfo
 , Windows
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
;

type _Instance_R_ = TsdsDrugDocument;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Drug\sdsBaseDrugDocument.imp.pas}

{$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\nsOpenContents.imp.pas}

function TsdsDrugDocument.As_IucpDocumentWithContents: IucpDocumentWithContents;
 {* Метод приведения нашего интерфейса к IucpDocumentWithContents }
begin
 Result := Self;
end;//TsdsDrugDocument.As_IucpDocumentWithContents

{$If NOT Defined(NoVCM)}
function TsdsDrugDocument.MakeData: _SetDataType_;
 {* Данные сборки. }
//#UC START# *47F3778403D9_47F4A2F801D8_var*
//#UC END# *47F3778403D9_47F4A2F801D8_var*
begin
//#UC START# *47F3778403D9_47F4A2F801D8_impl*
 Result := TdDrugDocument.Make;
//#UC END# *47F3778403D9_47F4A2F801D8_impl*
end;//TsdsDrugDocument.MakeData
{$IfEnd} // NOT Defined(NoVCM)

procedure TsdsDrugDocument.OpenDrugInternationalNameSynonims;
 {* Открыть список синонимов по международному названию. }
//#UC START# *47FDF09F0290_47F4A2F801D8_var*
//#UC END# *47FDF09F0290_47F4A2F801D8_var*
begin
//#UC START# *47FDF09F0290_47F4A2F801D8_impl*
 DoOpenDrugInternationalNameSynonims;
//#UC END# *47FDF09F0290_47F4A2F801D8_impl*
end;//TsdsDrugDocument.OpenDrugInternationalNameSynonims

function TsdsDrugDocument.BaseDocumentClass: IdsBaseDocument;
//#UC START# *4925B1EC0100_47F4A2F801D8_var*
//#UC END# *4925B1EC0100_47F4A2F801D8_var*
begin
//#UC START# *4925B1EC0100_47F4A2F801D8_impl*
 Result := TdsDrugDocument.Make(Self, DocumentData);
//#UC END# *4925B1EC0100_47F4A2F801D8_impl*
end;//TsdsDrugDocument.BaseDocumentClass

function TsdsDrugDocument.pm_GetdsContents: IdsBaseContents;
//#UC START# *500CEEBD01CB_47F4A2F801D8get_var*
//#UC END# *500CEEBD01CB_47F4A2F801D8get_var*
begin
//#UC START# *500CEEBD01CB_47F4A2F801D8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *500CEEBD01CB_47F4A2F801D8get_impl*
end;//TsdsDrugDocument.pm_GetdsContents

procedure TsdsDrugDocument.FinishDataUpdate;
//#UC START# *47EA4E9002C6_47F4A2F801D8_var*
//#UC END# *47EA4E9002C6_47F4A2F801D8_var*
begin
//#UC START# *47EA4E9002C6_47F4A2F801D8_impl*
 inherited;
 pm_GetDocInfo.ClearListNode;
 SetData.ResetBooleans; // http://mdp.garant.ru/pages/viewpage.action?pageId=297704301
 ClearAllDS;
 Refresh;
//#UC END# *47EA4E9002C6_47F4A2F801D8_impl*
end;//TsdsDrugDocument.FinishDataUpdate

{$If NOT Defined(NoVCM)}
procedure TsdsDrugDocument.DataExchange;
 {* - вызывается после получения данных инициализации. }
//#UC START# *47F37DF001FE_47F4A2F801D8_var*
//#UC END# *47F37DF001FE_47F4A2F801D8_var*
begin
//#UC START# *47F37DF001FE_47F4A2F801D8_impl*
 ChangeDocument(InitialUseCaseData);
//#UC END# *47F37DF001FE_47F4A2F801D8_impl*
end;//TsdsDrugDocument.DataExchange
{$IfEnd} // NOT Defined(NoVCM)

procedure TsdsDrugDocument.ClearAllDS;
//#UC START# *4925B7F00156_47F4A2F801D8_var*
//#UC END# *4925B7F00156_47F4A2F801D8_var*
begin
//#UC START# *4925B7F00156_47F4A2F801D8_impl*
 inherited;
//#UC END# *4925B7F00156_47F4A2F801D8_impl*
end;//TsdsDrugDocument.ClearAllDS

{$If NOT Defined(NoVCM)}
procedure TsdsDrugDocument.ClearAreas;
 {* Очищает ссылки на области ввода }
//#UC START# *4938F7E702B7_47F4A2F801D8_var*
//#UC END# *4938F7E702B7_47F4A2F801D8_var*
begin
//#UC START# *4938F7E702B7_47F4A2F801D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4938F7E702B7_47F4A2F801D8_impl*
end;//TsdsDrugDocument.ClearAreas
{$IfEnd} // NOT Defined(NoVCM)

procedure TsdsDrugDocument.FillState;
//#UC START# *493D51ED0329_47F4A2F801D8_var*
//#UC END# *493D51ED0329_47F4A2F801D8_var*
begin
//#UC START# *493D51ED0329_47F4A2F801D8_impl*
 inherited;
 if pm_GetHasDrugInternationalNameSynonims then
  SetData.dsDrugInternationalNameSynonimsRef.NeedMake := vcm_nmYes;
//#UC END# *493D51ED0329_47F4A2F801D8_impl*
end;//TsdsDrugDocument.FillState
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
