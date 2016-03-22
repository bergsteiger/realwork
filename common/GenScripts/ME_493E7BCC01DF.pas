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
    {* Поле для свойства dsFiltersRef }
   f_dsListInfoRef: IvcmFormDataSourceRef;
    {* Поле для свойства dsListInfoRef }
   f_List_SynchroView_Form: TList_SynchroView_Areas;
    {* Поле для свойства List_SynchroView_Form }
   f_NodeForPositioning: Il3SimpleNode;
    {* Поле для свойства NodeForPositioning }
   f_dsListRef: IvcmFormDataSourceRef;
    {* Поле для свойства dsListRef }
   f_Default_List_SynchroView_Form: TList_SynchroView_Areas;
    {* Поле для свойства Default_List_SynchroView_Form }
   f_dsSynchroViewRef: IvcmFormDataSourceRef;
    {* Поле для свойства dsSynchroViewRef }
  protected
   function pm_GetdsFiltersRef: IvcmFormDataSourceRef;
   function pm_GetdsListInfoRef: IvcmFormDataSourceRef;
   function pm_GetList: IDynList;
   procedure pm_SetList(const aValue: IDynList);
   function pm_GetUseDataProducer: Boolean;
   procedure pm_SetUseDataProducer(aValue: Boolean);
   function pm_GetDisableAutoOpenAnnotation: Boolean;
   procedure pm_SetDisableAutoOpenAnnotation(aValue: Boolean);
   function pm_GetList_SynchroView_Form: TList_SynchroView_Areas;
   procedure pm_SetList_SynchroView_Form(aValue: TList_SynchroView_Areas);
   function pm_GetNodeForPositioning: Il3SimpleNode;
   procedure pm_SetNodeForPositioning(const aValue: Il3SimpleNode);
   function pm_GetdsListRef: IvcmFormDataSourceRef;
   function pm_GetDefault_List_SynchroView_Form: TList_SynchroView_Areas;
   function pm_GetdsSynchroViewRef: IvcmFormDataSourceRef;
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

function TdList.pm_GetdsFiltersRef: IvcmFormDataSourceRef;
//#UC START# *3BB05EEE7B14_493E7BCC01DFget_var*
//#UC END# *3BB05EEE7B14_493E7BCC01DFget_var*
begin
//#UC START# *3BB05EEE7B14_493E7BCC01DFget_impl*
 !!! Needs to be implemented !!!
//#UC END# *3BB05EEE7B14_493E7BCC01DFget_impl*
end;//TdList.pm_GetdsFiltersRef

function TdList.pm_GetdsListInfoRef: IvcmFormDataSourceRef;
//#UC START# *47EBA76A13BA_493E7BCC01DFget_var*
//#UC END# *47EBA76A13BA_493E7BCC01DFget_var*
begin
//#UC START# *47EBA76A13BA_493E7BCC01DFget_impl*
 !!! Needs to be implemented !!!
//#UC END# *47EBA76A13BA_493E7BCC01DFget_impl*
end;//TdList.pm_GetdsListInfoRef

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

function TdList.pm_GetList_SynchroView_Form: TList_SynchroView_Areas;
//#UC START# *65ED98924AAC_493E7BCC01DFget_var*
//#UC END# *65ED98924AAC_493E7BCC01DFget_var*
begin
//#UC START# *65ED98924AAC_493E7BCC01DFget_impl*
 !!! Needs to be implemented !!!
//#UC END# *65ED98924AAC_493E7BCC01DFget_impl*
end;//TdList.pm_GetList_SynchroView_Form

procedure TdList.pm_SetList_SynchroView_Form(aValue: TList_SynchroView_Areas);
//#UC START# *65ED98924AAC_493E7BCC01DFset_var*
//#UC END# *65ED98924AAC_493E7BCC01DFset_var*
begin
//#UC START# *65ED98924AAC_493E7BCC01DFset_impl*
 !!! Needs to be implemented !!!
//#UC END# *65ED98924AAC_493E7BCC01DFset_impl*
end;//TdList.pm_SetList_SynchroView_Form

function TdList.pm_GetNodeForPositioning: Il3SimpleNode;
//#UC START# *6F3C9A2D31F6_493E7BCC01DFget_var*
//#UC END# *6F3C9A2D31F6_493E7BCC01DFget_var*
begin
//#UC START# *6F3C9A2D31F6_493E7BCC01DFget_impl*
 !!! Needs to be implemented !!!
//#UC END# *6F3C9A2D31F6_493E7BCC01DFget_impl*
end;//TdList.pm_GetNodeForPositioning

procedure TdList.pm_SetNodeForPositioning(const aValue: Il3SimpleNode);
//#UC START# *6F3C9A2D31F6_493E7BCC01DFset_var*
//#UC END# *6F3C9A2D31F6_493E7BCC01DFset_var*
begin
//#UC START# *6F3C9A2D31F6_493E7BCC01DFset_impl*
 !!! Needs to be implemented !!!
//#UC END# *6F3C9A2D31F6_493E7BCC01DFset_impl*
end;//TdList.pm_SetNodeForPositioning

function TdList.pm_GetdsListRef: IvcmFormDataSourceRef;
//#UC START# *922B5C5C2DAF_493E7BCC01DFget_var*
//#UC END# *922B5C5C2DAF_493E7BCC01DFget_var*
begin
//#UC START# *922B5C5C2DAF_493E7BCC01DFget_impl*
 !!! Needs to be implemented !!!
//#UC END# *922B5C5C2DAF_493E7BCC01DFget_impl*
end;//TdList.pm_GetdsListRef

function TdList.pm_GetDefault_List_SynchroView_Form: TList_SynchroView_Areas;
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
end;//TdList.pm_GetDefault_List_SynchroView_Form

function TdList.pm_GetdsSynchroViewRef: IvcmFormDataSourceRef;
//#UC START# *DADD420A546C_493E7BCC01DFget_var*
//#UC END# *DADD420A546C_493E7BCC01DFget_var*
begin
//#UC START# *DADD420A546C_493E7BCC01DFget_impl*
 !!! Needs to be implemented !!!
//#UC END# *DADD420A546C_493E7BCC01DFget_impl*
end;//TdList.pm_GetdsSynchroViewRef

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
