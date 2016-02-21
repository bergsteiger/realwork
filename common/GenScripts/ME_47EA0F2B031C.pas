unit sdsDrugList;
 {* БОС Список лекарственных препаратов. }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Drug\sdsDrugList.pas"
// Стереотип: "UseCaseControllerImp"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , MedicInterfaces
 , PrimPrimListInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , l3TreeInterfaces
 , DocumentAndListInterfaces
 , l3Interfaces
 , DocumentInterfaces
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
 , l3NotifyPtrList
 , nsTypes
 , nevBase
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _SetDataType_ = IdDrugList;
 _InitDataType_ = IdeList;
 _SetType_ = IsdsDrugList;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Drug\sdsBaseDrugDocument.imp.pas}
 _nsListWarningGenerator_Parent_ = _sdsBaseDrugDocument_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\PrimListControllers\nsListWarningGenerator.imp.pas}
 TsdsDrugList = class(_nsListWarningGenerator_, IsdsDrugList, IucpFilters, IucpNodeForPositioningHolder, InsWarningGenerator, IsdsListPrim, IsdsListNameHolder)
  {* БОС Список лекарственных препаратов. }
  private
   f_dsBaloonWarning: IvcmViewAreaControllerRef;
    {* Поле для области вывода dsBaloonWarning }
  protected
   procedure ChangeSynchroForm(aSynchroForm: TDrugList_SynchroView_Areas);
    {* Переключает форму синхронного просмотра }
   function As_IucpFilters: IucpFilters;
    {* Метод приведения нашего интерфейса к IucpFilters }
   function As_IucpNodeForPositioningHolder: IucpNodeForPositioningHolder;
    {* Метод приведения нашего интерфейса к IucpNodeForPositioningHolder }
   function As_InsWarningGenerator: InsWarningGenerator;
    {* Метод приведения нашего интерфейса к InsWarningGenerator }
   function As_IsdsListPrim: IsdsListPrim;
    {* Метод приведения нашего интерфейса к IsdsListPrim }
   function As_IsdsListNameHolder: IsdsListNameHolder;
    {* Метод приведения нашего интерфейса к IsdsListNameHolder }
   function pm_GetIsDocumentActive: Boolean;
   {$If NOT Defined(NoVCM)}
   function MakeData: _SetDataType_; override;
    {* Данные сборки. }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure UpdateListInfo;
    {* - обновить информацию о списке. }
   procedure Open;
    {* открыть форму фильтры }
   function pm_GetNodeForPositioning: Il3SimpleNode;
   procedure ReleaseNodeForPositioning;
    {* - освободить узел для позиционирования. }
   function BaseDocumentClass: IdsBaseDocument; override;
   function Get_dsListPrim: IdsList;
   function pm_GetdsBaloonWarning: IdsWarning;
   function pm_GetdsDrugList: IdsDrugList;
   function pm_GetdsSynchroView: IdsDrugListSynchroView;
   function pm_GetdsFilters: IdsFilters;
   function pm_GetdsListInfo: IdsListInfo;
   function pm_GetShortListName: Il3CString;
   function pm_GetListName: Il3CString;
   procedure OpenDocument;
    {* Открывает ViewArea "Собственно документ" }
   procedure OpenDrugInternationalNameSynonims;
    {* Открывает ViewArea "Бизнес объект "Синонимы по международному названию"" }
   function pm_GetIsAttributesActive: Boolean;
   function pm_GetIsDrugInternationalNameSynonimsActive: Boolean;
   procedure OpenAttributes;
    {* Открывает ViewArea "атрибуты документа" }
   {$If NOT Defined(NoVCM)}
   procedure DataExchange; override;
    {* - вызывается после получения данных инициализации. }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure DoOpenAttributes; override;
    {* - атрибуты. }
   procedure DoOpenDrugInternationalNameSynonims; override;
    {* - открыть синонимы по международному названию. }
   function NeedMakeDSAttributes: Boolean; override;
    {* - необходимость создания БОФ атрибутов. }
   function NeedMakeDsDrugInternationalNameSynonims: Boolean; override;
    {* - нужно ли создавать БОФ синонимов по международному названию. }
   procedure ClearAllDS; override;
   {$If NOT Defined(NoVCM)}
   procedure ClearAreas; override;
    {* Очищает ссылки на области ввода }
   {$IfEnd} // NOT Defined(NoVCM)
   function NeedMakeDocument: Boolean; override;
    {* Определяет - нужно ли создавать область ввода для документа }
   {$If NOT Defined(NoVCM)}
   function DoGetFormSetImageIndex: Integer; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TsdsDrugList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , dsDrugList
 , SysUtils
 , dsDrugListSynchroView
 , dDrugList
 , deList
 , dsFilters
 , dsMainDrugList
 , afwFacade
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , nsConst
 , dsListInfo
 , bsUtils
 , dsDrugListDocument
 , dsWarning
 , nsTabbedInterfaceTypes
 , l3Types
 , DynamicDocListUnit
 , DynamicTreeUnit
 , l3Utils
 , dsAttributes
 , deDocInfo
 , Windows
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
 , Document_Const
 , DataAdapter
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , nsDocumentWarningGenerator
 , BaloonWarningUserTypes_remListModified_UserType
 , UnderControlInterfaces
 , nsListWarningGenerator
;

type _Instance_R_ = TsdsDrugList;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Drug\sdsBaseDrugDocument.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\PrimListControllers\nsListWarningGenerator.imp.pas}

procedure TsdsDrugList.ChangeSynchroForm(aSynchroForm: TDrugList_SynchroView_Areas);
 {* Переключает форму синхронного просмотра }
//#UC START# *341E87C755C8_47EA0F2B031C_var*
//#UC END# *341E87C755C8_47EA0F2B031C_var*
begin
//#UC START# *341E87C755C8_47EA0F2B031C_impl*
 if (aSynchroForm <> SetData.DrugList_SynchroView_Form) then
 begin
  ClearAllDS;
  SetData.DrugList_SynchroView_Form := aSynchroForm;
  Refresh;
 end;//aSynchroForm <> SetData.DrugList_SynchroView_Form
//#UC END# *341E87C755C8_47EA0F2B031C_impl*
end;//TsdsDrugList.ChangeSynchroForm

function TsdsDrugList.As_IucpFilters: IucpFilters;
 {* Метод приведения нашего интерфейса к IucpFilters }
begin
 Result := Self;
end;//TsdsDrugList.As_IucpFilters

function TsdsDrugList.As_IucpNodeForPositioningHolder: IucpNodeForPositioningHolder;
 {* Метод приведения нашего интерфейса к IucpNodeForPositioningHolder }
begin
 Result := Self;
end;//TsdsDrugList.As_IucpNodeForPositioningHolder

function TsdsDrugList.As_InsWarningGenerator: InsWarningGenerator;
 {* Метод приведения нашего интерфейса к InsWarningGenerator }
begin
 Result := Self;
end;//TsdsDrugList.As_InsWarningGenerator

function TsdsDrugList.As_IsdsListPrim: IsdsListPrim;
 {* Метод приведения нашего интерфейса к IsdsListPrim }
begin
 Result := Self;
end;//TsdsDrugList.As_IsdsListPrim

function TsdsDrugList.As_IsdsListNameHolder: IsdsListNameHolder;
 {* Метод приведения нашего интерфейса к IsdsListNameHolder }
begin
 Result := Self;
end;//TsdsDrugList.As_IsdsListNameHolder

function TsdsDrugList.pm_GetIsDocumentActive: Boolean;
//#UC START# *41B49128CE19_47EA0F2B031Cget_var*
//#UC END# *41B49128CE19_47EA0F2B031Cget_var*
begin
//#UC START# *41B49128CE19_47EA0F2B031Cget_impl*
 Result := SetData.DrugList_SynchroView_Form = sva_DrugList_SynchroView_Document;
//#UC END# *41B49128CE19_47EA0F2B031Cget_impl*
end;//TsdsDrugList.pm_GetIsDocumentActive

{$If NOT Defined(NoVCM)}
function TsdsDrugList.MakeData: _SetDataType_;
 {* Данные сборки. }
//#UC START# *47F3778403D9_47EA0F2B031C_var*
//#UC END# *47F3778403D9_47EA0F2B031C_var*
begin
//#UC START# *47F3778403D9_47EA0F2B031C_impl*
 Result := TdDrugList.Make;
 with Result do
 begin
  dsFiltersRef.NeedMake := vcm_nmYes;
  dsDrugInternationalNameSynonimsRef.NeedMake := vcm_nmYes;
 end;//with Result
//#UC END# *47F3778403D9_47EA0F2B031C_impl*
end;//TsdsDrugList.MakeData
{$IfEnd} // NOT Defined(NoVCM)

procedure TsdsDrugList.UpdateListInfo;
 {* - обновить информацию о списке. }
//#UC START# *47F4BF4E0397_47EA0F2B031C_var*
//#UC END# *47F4BF4E0397_47EA0F2B031C_var*
begin
//#UC START# *47F4BF4E0397_47EA0F2B031C_impl*
 SetData.dsListInfoRef.Clear;
 Refresh;
//#UC END# *47F4BF4E0397_47EA0F2B031C_impl*
end;//TsdsDrugList.UpdateListInfo

procedure TsdsDrugList.Open;
 {* открыть форму фильтры }
//#UC START# *47FB2086026D_47EA0F2B031C_var*
//#UC END# *47FB2086026D_47EA0F2B031C_var*
begin
//#UC START# *47FB2086026D_47EA0F2B031C_impl*
 SetData.dsFiltersRef.NeedMake := vcm_nmForce;
 Refresh; 
//#UC END# *47FB2086026D_47EA0F2B031C_impl*
end;//TsdsDrugList.Open

function TsdsDrugList.pm_GetNodeForPositioning: Il3SimpleNode;
//#UC START# *47FF2155021A_47EA0F2B031Cget_var*
//#UC END# *47FF2155021A_47EA0F2B031Cget_var*
begin
//#UC START# *47FF2155021A_47EA0F2B031Cget_impl*
 Result := SetData.NodeForPositioning;
//#UC END# *47FF2155021A_47EA0F2B031Cget_impl*
end;//TsdsDrugList.pm_GetNodeForPositioning

procedure TsdsDrugList.ReleaseNodeForPositioning;
 {* - освободить узел для позиционирования. }
//#UC START# *47FF44850384_47EA0F2B031C_var*
//#UC END# *47FF44850384_47EA0F2B031C_var*
begin
//#UC START# *47FF44850384_47EA0F2B031C_impl*
 SetData.NodeForPositioning := nil;
//#UC END# *47FF44850384_47EA0F2B031C_impl*
end;//TsdsDrugList.ReleaseNodeForPositioning

function TsdsDrugList.BaseDocumentClass: IdsBaseDocument;
//#UC START# *4925B1EC0100_47EA0F2B031C_var*
//#UC END# *4925B1EC0100_47EA0F2B031C_var*
begin
//#UC START# *4925B1EC0100_47EA0F2B031C_impl*
 Result := TdsDrugListDocument.Make(Self, DocumentData);
//#UC END# *4925B1EC0100_47EA0F2B031C_impl*
end;//TsdsDrugList.BaseDocumentClass

function TsdsDrugList.Get_dsListPrim: IdsList;
//#UC START# *49AE664F006B_47EA0F2B031Cget_var*
//#UC END# *49AE664F006B_47EA0F2B031Cget_var*
begin
//#UC START# *49AE664F006B_47EA0F2B031Cget_impl*
 Result := pm_GetDsDrugList;
//#UC END# *49AE664F006B_47EA0F2B031Cget_impl*
end;//TsdsDrugList.Get_dsListPrim

function TsdsDrugList.pm_GetdsBaloonWarning: IdsWarning;
//#UC START# *4DC185B80232_47EA0F2B031Cget_var*
//#UC END# *4DC185B80232_47EA0F2B031Cget_var*
begin
//#UC START# *4DC185B80232_47EA0F2B031Cget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DC185B80232_47EA0F2B031Cget_impl*
end;//TsdsDrugList.pm_GetdsBaloonWarning

function TsdsDrugList.pm_GetdsDrugList: IdsDrugList;
//#UC START# *500D3D75005B_47EA0F2B031Cget_var*
//#UC END# *500D3D75005B_47EA0F2B031Cget_var*
begin
//#UC START# *500D3D75005B_47EA0F2B031Cget_impl*
 !!! Needs to be implemented !!!
//#UC END# *500D3D75005B_47EA0F2B031Cget_impl*
end;//TsdsDrugList.pm_GetdsDrugList

function TsdsDrugList.pm_GetdsSynchroView: IdsDrugListSynchroView;
//#UC START# *500D3E3500FF_47EA0F2B031Cget_var*
//#UC END# *500D3E3500FF_47EA0F2B031Cget_var*
begin
//#UC START# *500D3E3500FF_47EA0F2B031Cget_impl*
 !!! Needs to be implemented !!!
//#UC END# *500D3E3500FF_47EA0F2B031Cget_impl*
end;//TsdsDrugList.pm_GetdsSynchroView

function TsdsDrugList.pm_GetdsFilters: IdsFilters;
//#UC START# *500D3E780156_47EA0F2B031Cget_var*
//#UC END# *500D3E780156_47EA0F2B031Cget_var*
begin
//#UC START# *500D3E780156_47EA0F2B031Cget_impl*
 !!! Needs to be implemented !!!
//#UC END# *500D3E780156_47EA0F2B031Cget_impl*
end;//TsdsDrugList.pm_GetdsFilters

function TsdsDrugList.pm_GetdsListInfo: IdsListInfo;
//#UC START# *500D3EB1023F_47EA0F2B031Cget_var*
//#UC END# *500D3EB1023F_47EA0F2B031Cget_var*
begin
//#UC START# *500D3EB1023F_47EA0F2B031Cget_impl*
 !!! Needs to be implemented !!!
//#UC END# *500D3EB1023F_47EA0F2B031Cget_impl*
end;//TsdsDrugList.pm_GetdsListInfo

function TsdsDrugList.pm_GetShortListName: Il3CString;
//#UC START# *501806DE0323_47EA0F2B031Cget_var*
//#UC END# *501806DE0323_47EA0F2B031Cget_var*
begin
//#UC START# *501806DE0323_47EA0F2B031Cget_impl*
 Result := nil;
//#UC END# *501806DE0323_47EA0F2B031Cget_impl*
end;//TsdsDrugList.pm_GetShortListName

function TsdsDrugList.pm_GetListName: Il3CString;
//#UC START# *50180BA801C2_47EA0F2B031Cget_var*
//#UC END# *50180BA801C2_47EA0F2B031Cget_var*
begin
//#UC START# *50180BA801C2_47EA0F2B031Cget_impl*
 Result := nil;
//#UC END# *50180BA801C2_47EA0F2B031Cget_impl*
end;//TsdsDrugList.pm_GetListName

procedure TsdsDrugList.OpenDocument;
 {* Открывает ViewArea "Собственно документ" }
//#UC START# *5D78745D5001_47EA0F2B031C_var*
//#UC END# *5D78745D5001_47EA0F2B031C_var*
begin
//#UC START# *5D78745D5001_47EA0F2B031C_impl*
 SetData.dsDocumentRef.SetIfNeedMakeNo(vcm_nmForce);
 ChangeSynchroForm(sva_DrugList_SynchroView_Document);
//#UC END# *5D78745D5001_47EA0F2B031C_impl*
end;//TsdsDrugList.OpenDocument

procedure TsdsDrugList.OpenDrugInternationalNameSynonims;
 {* Открывает ViewArea "Бизнес объект "Синонимы по международному названию"" }
//#UC START# *7680D04D575B_47EA0F2B031C_var*
//#UC END# *7680D04D575B_47EA0F2B031C_var*
begin
//#UC START# *7680D04D575B_47EA0F2B031C_impl*
 DoOpenDrugInternationalNameSynonims;
//#UC END# *7680D04D575B_47EA0F2B031C_impl*
end;//TsdsDrugList.OpenDrugInternationalNameSynonims

function TsdsDrugList.pm_GetIsAttributesActive: Boolean;
//#UC START# *7ECE38CEFE6F_47EA0F2B031Cget_var*
//#UC END# *7ECE38CEFE6F_47EA0F2B031Cget_var*
begin
//#UC START# *7ECE38CEFE6F_47EA0F2B031Cget_impl*
 Result := SetData.DrugList_SynchroView_Form = sva_DrugList_SynchroView_Attributes;
//#UC END# *7ECE38CEFE6F_47EA0F2B031Cget_impl*
end;//TsdsDrugList.pm_GetIsAttributesActive

function TsdsDrugList.pm_GetIsDrugInternationalNameSynonimsActive: Boolean;
//#UC START# *862011C4CE04_47EA0F2B031Cget_var*
//#UC END# *862011C4CE04_47EA0F2B031Cget_var*
begin
//#UC START# *862011C4CE04_47EA0F2B031Cget_impl*
 Result := SetData.DrugList_SynchroView_Form = sva_DrugList_SynchroView_DrugInternationalNameSynonims;
//#UC END# *862011C4CE04_47EA0F2B031Cget_impl*
end;//TsdsDrugList.pm_GetIsDrugInternationalNameSynonimsActive

procedure TsdsDrugList.OpenAttributes;
 {* Открывает ViewArea "атрибуты документа" }
//#UC START# *ECBE8DB2214F_47EA0F2B031C_var*
//#UC END# *ECBE8DB2214F_47EA0F2B031C_var*
begin
//#UC START# *ECBE8DB2214F_47EA0F2B031C_impl*
 inherited OpenAttributes;
//#UC END# *ECBE8DB2214F_47EA0F2B031C_impl*
end;//TsdsDrugList.OpenAttributes

{$If NOT Defined(NoVCM)}
procedure TsdsDrugList.DataExchange;
 {* - вызывается после получения данных инициализации. }
//#UC START# *47F37DF001FE_47EA0F2B031C_var*
var
 l_List: IdeList;
//#UC END# *47F37DF001FE_47EA0F2B031C_var*
begin
//#UC START# *47F37DF001FE_47EA0F2B031C_impl*
 l_List := InitialUseCaseData;
  with SetData do
  begin
   List := l_List.List;
   NodeForPositioning := l_List.NodeForPositioning;
  end;//with SetData do
//#UC END# *47F37DF001FE_47EA0F2B031C_impl*
end;//TsdsDrugList.DataExchange
{$IfEnd} // NOT Defined(NoVCM)

procedure TsdsDrugList.DoOpenAttributes;
 {* - атрибуты. }
//#UC START# *47FDDACC0101_47EA0F2B031C_var*
//#UC END# *47FDDACC0101_47EA0F2B031C_var*
begin
//#UC START# *47FDDACC0101_47EA0F2B031C_impl*
 SetData.dsAttributesRef.SetIfNeedMakeNo(vcm_nmForce);
 ChangeSynchroForm(sva_DrugList_SynchroView_Attributes);
//#UC END# *47FDDACC0101_47EA0F2B031C_impl*
end;//TsdsDrugList.DoOpenAttributes

procedure TsdsDrugList.DoOpenDrugInternationalNameSynonims;
 {* - открыть синонимы по международному названию. }
//#UC START# *47FDDD500143_47EA0F2B031C_var*
//#UC END# *47FDDD500143_47EA0F2B031C_var*
begin
//#UC START# *47FDDD500143_47EA0F2B031C_impl*
 SetData.dsDrugInternationalNameSynonimsRef.SetIfNeedMakeNo(vcm_nmForce);
 ChangeSynchroForm(sva_DrugList_SynchroView_DrugInternationalNameSynonims);
//#UC END# *47FDDD500143_47EA0F2B031C_impl*
end;//TsdsDrugList.DoOpenDrugInternationalNameSynonims

function TsdsDrugList.NeedMakeDSAttributes: Boolean;
 {* - необходимость создания БОФ атрибутов. }
//#UC START# *47FE03AE0225_47EA0F2B031C_var*
//#UC END# *47FE03AE0225_47EA0F2B031C_var*
begin
//#UC START# *47FE03AE0225_47EA0F2B031C_impl*
 Result := (SetData.DrugList_SynchroView_Form = sva_DrugList_SynchroView_Attributes) AND
           inherited NeedMakeDsAttributes;
//#UC END# *47FE03AE0225_47EA0F2B031C_impl*
end;//TsdsDrugList.NeedMakeDSAttributes

function TsdsDrugList.NeedMakeDsDrugInternationalNameSynonims: Boolean;
 {* - нужно ли создавать БОФ синонимов по международному названию. }
//#UC START# *47FE048E0224_47EA0F2B031C_var*
//#UC END# *47FE048E0224_47EA0F2B031C_var*
begin
//#UC START# *47FE048E0224_47EA0F2B031C_impl*
 Result := (SetData.DrugList_SynchroView_Form = sva_DrugList_SynchroView_DrugInternationalNameSynonims) AND
           inherited NeedMakeDsDrugInternationalNameSynonims;
//#UC END# *47FE048E0224_47EA0F2B031C_impl*
end;//TsdsDrugList.NeedMakeDsDrugInternationalNameSynonims

procedure TsdsDrugList.ClearAllDS;
//#UC START# *4925B7F00156_47EA0F2B031C_var*
//#UC END# *4925B7F00156_47EA0F2B031C_var*
begin
//#UC START# *4925B7F00156_47EA0F2B031C_impl*
 if (f_dsBaloonWarning <> nil) then
  f_dsBaloonWarning.Referred := nil;
 inherited; 
//#UC END# *4925B7F00156_47EA0F2B031C_impl*
end;//TsdsDrugList.ClearAllDS

{$If NOT Defined(NoVCM)}
procedure TsdsDrugList.ClearAreas;
 {* Очищает ссылки на области ввода }
//#UC START# *4938F7E702B7_47EA0F2B031C_var*
//#UC END# *4938F7E702B7_47EA0F2B031C_var*
begin
//#UC START# *4938F7E702B7_47EA0F2B031C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4938F7E702B7_47EA0F2B031C_impl*
end;//TsdsDrugList.ClearAreas
{$IfEnd} // NOT Defined(NoVCM)

function TsdsDrugList.NeedMakeDocument: Boolean;
 {* Определяет - нужно ли создавать область ввода для документа }
//#UC START# *493D1BE601B1_47EA0F2B031C_var*
//#UC END# *493D1BE601B1_47EA0F2B031C_var*
begin
//#UC START# *493D1BE601B1_47EA0F2B031C_impl*
 Result := (SetData.DrugList_SynchroView_Form = sva_DrugList_SynchroView_Document) AND
           inherited NeedMakeDocument;
//#UC END# *493D1BE601B1_47EA0F2B031C_impl*
end;//TsdsDrugList.NeedMakeDocument

{$If NOT Defined(NoVCM)}
function TsdsDrugList.DoGetFormSetImageIndex: Integer;
//#UC START# *53B3BF9C00EF_47EA0F2B031C_var*
//#UC END# *53B3BF9C00EF_47EA0F2B031C_var*
begin
//#UC START# *53B3BF9C00EF_47EA0F2B031C_impl*
 Result := nsTabIconIndex(titList);
//#UC END# *53B3BF9C00EF_47EA0F2B031C_impl*
end;//TsdsDrugList.DoGetFormSetImageIndex
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
