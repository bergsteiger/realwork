unit dList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "List"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/List/dList.pas"
// Начат: 12.07.2006
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Работа с документом и списком документов::WorkWithList::List::List::TdList
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
  DynamicDocListUnit,
  l3TreeInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  WorkWithListInterfaces,
  ExternalObjectUnit,
  l3Types,
  bsTypes,
  bsInterfaces,
  DocumentAndListInterfaces,
  DocInfoInterfaces,
  BaseDocumentWithAttributesInterfaces,
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
 _IvcmRealData_ = IdList;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dDocInfo.imp.pas}
 TdList = class(_dDocInfo_, IdList)
 private
 // private fields
   f_UseDataProducer : Boolean;
   f_List : IDynList;
   f_DisableAutoOpenAnnotation : Boolean;
   f_dsFiltersRef : IvcmFormDataSourceRef;
    {* Поле для свойства dsFiltersRef}
   f_dsListInfoRef : IvcmFormDataSourceRef;
    {* Поле для свойства dsListInfoRef}
   f_List_SynchroView_Form : TList_SynchroView_Areas;
    {* Поле для свойства List_SynchroView_Form}
   f_NodeForPositioning : Il3SimpleNode;
    {* Поле для свойства NodeForPositioning}
   f_dsListRef : IvcmFormDataSourceRef;
    {* Поле для свойства dsListRef}
   f_Default_List_SynchroView_Form : TList_SynchroView_Areas;
    {* Поле для свойства Default_List_SynchroView_Form}
   f_dsSynchroViewRef : IvcmFormDataSourceRef;
    {* Поле для свойства dsSynchroViewRef}
 protected
 // realized methods
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
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // overridden public methods
   {$If not defined(NoVCM)}
   constructor Create; override;
   {$IfEnd} //not NoVCM
 public
 // public methods
   class function Make: IdList; reintroduce;
 end;//TdList
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  afwFacade,
  nsConst
  {$If not defined(NoVCM)}
  ,
  vcmFormDataSourceRef
  {$IfEnd} //not NoVCM
  ,
  bsUserCRListInfo,
  SysUtils,
  l3Utils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdList;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dDocInfo.imp.pas}

// start class TdList

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
end;

function TdList.pm_GetDsFiltersRef: IvcmFormDataSourceRef;
 {-}
begin
 Result := vcmCheckAndMake(f_dsFiltersRef, vcm_nmYes);
end;//TdList.pm_GetDsFiltersRef

function TdList.pm_GetDsListInfoRef: IvcmFormDataSourceRef;
 {-}
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
 {-}
begin
 Result := f_List_SynchroView_Form;
end;//TdList.pm_GetListSynchroViewForm

procedure TdList.pm_SetListSynchroViewForm(aValue: TList_SynchroView_Areas);
 {-}
begin
 f_List_SynchroView_Form := aValue;
end;//TdList.pm_SetListSynchroViewForm

function TdList.pm_GetNodeForPositioning: Il3SimpleNode;
 {-}
begin
 Result := f_NodeForPositioning;
end;//TdList.pm_GetNodeForPositioning

procedure TdList.pm_SetNodeForPositioning(const aValue: Il3SimpleNode);
 {-}
begin
 f_NodeForPositioning := aValue;
end;//TdList.pm_SetNodeForPositioning

function TdList.pm_GetDsListRef: IvcmFormDataSourceRef;
 {-}
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
 {-}
begin
 Result := vcmCheckAndMake(f_dsSynchroViewRef);
end;//TdList.pm_GetDsSynchroViewRef

procedure TdList.Cleanup;
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

{$If not defined(NoVCM)}
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
{$IfEnd} //not NoVCM

procedure TdList.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_List := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_dsFiltersRef := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_dsListInfoRef := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_NodeForPositioning := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_dsListRef := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_dsSynchroViewRef := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TdList.ClearFields

{$IfEnd} //not Admin AND not Monitorings

end.