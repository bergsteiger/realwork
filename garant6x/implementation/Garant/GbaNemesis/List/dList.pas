unit dList;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\List\dList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdList" MUID: (493E7BCC01DF)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , WorkWithListInterfaces
 , DynamicDocListUnit
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , l3TreeInterfaces
 , DocInfoInterfaces
 , bsInterfaces
 , l3Types
 , ExternalObjectUnit
 , DocumentAndListInterfaces
 , bsTypes
 , BaseDocumentWithAttributesInterfaces
 , DocumentInterfaces
 , l3ProtoObject
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _IvcmRealData_ = IdList;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dDocInfo.imp.pas}
 TdList = class(_dDocInfo_, IdList)
  private
   f_UseDataProducer: Boolean;
   f_List: IDynList;
   f_DisableAutoOpenAnnotation: Boolean;
   f_dsFiltersRef: IvcmFormDataSourceRef;
    {* Ссылка на "БОС формы фильтры" }
   f_dsListInfoRef: IvcmFormDataSourceRef;
    {* Ссылка на "БОС справка к списку" }
   f_List_SynchroView_Form: TList_SynchroView_Areas;
    {* Форма синхронного просмотра }
   f_NodeForPositioning: Il3SimpleNode;
    {* - значение. }
   f_dsListRef: IvcmFormDataSourceRef;
    {* Ссылка на "БОС формы список" }
   f_Default_List_SynchroView_Form: TList_SynchroView_Areas;
    {* Форма синхронного просмотра по-умолчанию }
   f_dsSynchroViewRef: IvcmFormDataSourceRef;
    {* Ссылка на "БОС синхронного просмотра" }
  protected
   function pm_GetDsFiltersRef: IvcmFormDataSourceRef;
   function pm_GetDsListInfoRef: IvcmFormDataSourceRef;
   function pm_GetList: IDynList;
   procedure pm_SetList(const aValue: IDynList);
   function pm_GetUseDataProducer: Boolean;
   procedure pm_SetUseDataProducer(aValue: Boolean);
   function pm_GetDisableAutoOpenAnnotation: Boolean;
   procedure pm_SetDisableAutoOpenAnnotation(aValue: Boolean);
   function pm_GetListSynchroViewForm: TList_SynchroView_Areas;
   procedure pm_SetListSynchroViewForm(aValue: TList_SynchroView_Areas);
   function pm_GetNodeForPositioning: Il3SimpleNode;
   procedure pm_SetNodeForPositioning(const aValue: Il3SimpleNode);
   function pm_GetDsListRef: IvcmFormDataSourceRef;
   function pm_GetDefaultListSynchroViewForm: TList_SynchroView_Areas;
   function pm_GetDsSynchroViewRef: IvcmFormDataSourceRef;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   class function Make: IdList; reintroduce;
   {$If NOT Defined(NoVCM)}
   constructor Create; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TdList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , afwFacade
 , nsConst
 {$If NOT Defined(NoVCM)}
 , vcmFormDataSourceRef
 {$IfEnd} // NOT Defined(NoVCM)
 , bsUserCRListInfo
 , SysUtils
 , l3Utils
;

type _Instance_R_ = TdList;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dDocInfo.imp.pas}

class function TdList.Make: IdList;
var
 l_Inst : TdList;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TdList.Make

function TdList.pm_GetDsFiltersRef: IvcmFormDataSourceRef;
begin
 Result := vcmCheckAndMake(f_dsFiltersRef, vcm_nmYes);
end;//TdList.pm_GetDsFiltersRef

function TdList.pm_GetDsListInfoRef: IvcmFormDataSourceRef;
begin
 Result := vcmCheckAndMake(f_dsListInfoRef);
end;//TdList.pm_GetDsListInfoRef

function TdList.pm_GetList: IDynList;
//#UC START# *4952880D0314_493E7BCC01DFget_var*
//#UC END# *4952880D0314_493E7BCC01DFget_var*
begin
//#UC START# *4952880D0314_493E7BCC01DFget_impl*
 Result := f_List;
//#UC END# *4952880D0314_493E7BCC01DFget_impl*
end;//TdList.pm_GetList

procedure TdList.pm_SetList(const aValue: IDynList);
//#UC START# *4952880D0314_493E7BCC01DFset_var*
//#UC END# *4952880D0314_493E7BCC01DFset_var*
begin
//#UC START# *4952880D0314_493E7BCC01DFset_impl*
 f_List := aValue;
//#UC END# *4952880D0314_493E7BCC01DFset_impl*
end;//TdList.pm_SetList

function TdList.pm_GetUseDataProducer: Boolean;
//#UC START# *4952886A0188_493E7BCC01DFget_var*
//#UC END# *4952886A0188_493E7BCC01DFget_var*
begin
//#UC START# *4952886A0188_493E7BCC01DFget_impl*
 Result := f_UseDataProducer;
//#UC END# *4952886A0188_493E7BCC01DFget_impl*
end;//TdList.pm_GetUseDataProducer

procedure TdList.pm_SetUseDataProducer(aValue: Boolean);
//#UC START# *4952886A0188_493E7BCC01DFset_var*
//#UC END# *4952886A0188_493E7BCC01DFset_var*
begin
//#UC START# *4952886A0188_493E7BCC01DFset_impl*
 f_UseDataProducer := aValue;
//#UC END# *4952886A0188_493E7BCC01DFset_impl*
end;//TdList.pm_SetUseDataProducer

function TdList.pm_GetDisableAutoOpenAnnotation: Boolean;
//#UC START# *52FC7A000124_493E7BCC01DFget_var*
//#UC END# *52FC7A000124_493E7BCC01DFget_var*
begin
//#UC START# *52FC7A000124_493E7BCC01DFget_impl*
 Result := f_DisableAutoOpenAnnotation;
//#UC END# *52FC7A000124_493E7BCC01DFget_impl*
end;//TdList.pm_GetDisableAutoOpenAnnotation

procedure TdList.pm_SetDisableAutoOpenAnnotation(aValue: Boolean);
//#UC START# *52FC7A000124_493E7BCC01DFset_var*
//#UC END# *52FC7A000124_493E7BCC01DFset_var*
begin
//#UC START# *52FC7A000124_493E7BCC01DFset_impl*
 f_DisableAutoOpenAnnotation := aValue;
//#UC END# *52FC7A000124_493E7BCC01DFset_impl*
end;//TdList.pm_SetDisableAutoOpenAnnotation

function TdList.pm_GetListSynchroViewForm: TList_SynchroView_Areas;
begin
 Result := f_List_SynchroView_Form;
end;//TdList.pm_GetListSynchroViewForm

procedure TdList.pm_SetListSynchroViewForm(aValue: TList_SynchroView_Areas);
begin
 f_List_SynchroView_Form := aValue;
end;//TdList.pm_SetListSynchroViewForm

function TdList.pm_GetNodeForPositioning: Il3SimpleNode;
begin
 Result := f_NodeForPositioning;
end;//TdList.pm_GetNodeForPositioning

procedure TdList.pm_SetNodeForPositioning(const aValue: Il3SimpleNode);
begin
 f_NodeForPositioning := aValue;
end;//TdList.pm_SetNodeForPositioning

function TdList.pm_GetDsListRef: IvcmFormDataSourceRef;
begin
 Result := vcmCheckAndMake(f_dsListRef);
end;//TdList.pm_GetDsListRef

function TdList.pm_GetDefaultListSynchroViewForm: TList_SynchroView_Areas;
//#UC START# *B7BD6799893F_493E7BCC01DFget_var*
//#UC END# *B7BD6799893F_493E7BCC01DFget_var*
begin
//#UC START# *B7BD6799893F_493E7BCC01DFget_impl*
 if (f_Default_List_SynchroView_Form = sva_List_SynchroView_None) then
  case afw.Settings.LoadBoolean(pi_List_ShowAnnotationByDefault,
    dv_List_ShowAnnotationByDefault) of
   dv_List_ShowAnnotationByDefault:
    f_Default_List_SynchroView_Form := sva_List_SynchroView_Annotation;
   else
    f_Default_List_SynchroView_Form := sva_List_SynchroView_Document;
  end;//case afw.Settings.LoadInteger(
 Result := f_Default_List_SynchroView_Form;
//#UC END# *B7BD6799893F_493E7BCC01DFget_impl*
end;//TdList.pm_GetDefaultListSynchroViewForm

function TdList.pm_GetDsSynchroViewRef: IvcmFormDataSourceRef;
begin
 Result := vcmCheckAndMake(f_dsSynchroViewRef);
end;//TdList.pm_GetDsSynchroViewRef

procedure TdList.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_493E7BCC01DF_var*
//#UC END# *479731C50290_493E7BCC01DF_var*
begin
//#UC START# *479731C50290_493E7BCC01DF_impl*
 f_List_SynchroView_Form := sva_List_SynchroView_None;
 f_Default_List_SynchroView_Form := sva_List_SynchroView_None;
 f_List := nil;
 f_NodeForPositioning := nil;
 inherited;
//#UC END# *479731C50290_493E7BCC01DF_impl*
end;//TdList.Cleanup

{$If NOT Defined(NoVCM)}
constructor TdList.Create;
//#UC START# *4B16B8E3013F_493E7BCC01DF_var*
//#UC END# *4B16B8E3013F_493E7BCC01DF_var*
begin
//#UC START# *4B16B8E3013F_493E7BCC01DF_impl*
 inherited;
 f_List_SynchroView_Form := sva_List_SynchroView_None;
 f_Default_List_SynchroView_Form := sva_List_SynchroView_None;
//#UC END# *4B16B8E3013F_493E7BCC01DF_impl*
end;//TdList.Create
{$IfEnd} // NOT Defined(NoVCM)

procedure TdList.ClearFields;
begin
 f_List := nil;
 f_dsFiltersRef := nil;
 f_dsListInfoRef := nil;
 f_NodeForPositioning := nil;
 f_dsListRef := nil;
 f_dsSynchroViewRef := nil;
 inherited;
end;//TdList.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
