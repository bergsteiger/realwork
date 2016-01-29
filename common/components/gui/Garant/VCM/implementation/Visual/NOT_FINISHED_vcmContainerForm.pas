unit NOT_FINISHED_vcmContainerForm;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/NOT_FINISHED_vcmContainerForm.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Visual::Visual::TvcmContainerForm
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmExternalInterfaces,
  vcmInterfaces,
  Classes,
  vcmContainerFormModelPart,
  vcmFormSetRefList,
  vcmAggregateRefList,
  vcmUserControls
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TvcmInsertMode = (
  {* Режим добавления формы. }
   vcm_imAllow // Разрешение добавления формы в текущий контейнер
 , vcm_imDisable // Запрет добавления формы в текущий контейнер
 , vcm_imToParent // Перенаправление операции добавления формы в родительскую форму
 );//TvcmInsertMode

 TvcmInsertFormEvent = procedure (const aForm: IvcmEntityForm;
  var aMode: TvcmInsertMode) of object;

 TvcmAfterInsertFormEvent = procedure (const aForm: IvcmEntityForm) of object;

 TvcmAfterRemoveFormEvent = 

 TvcmOnNeedUpdateTab = procedure (aSender: TObject;
  const aForm: IvcmEntityForm) of object;

 TvcmContainerForm = class(TvcmContainerFormModelPart, IvcmContainer)
 private
 // private fields
   f_FormSets : TvcmFormSetRefList;
   f_Aggregates : TvcmAggregateRefList;
 protected
 // realized methods
   procedure RegForm(const aForm: IvcmEntityForm);
   procedure UnregForm(const aForm: IvcmEntityForm);
   function InsertForm(const aForm: IvcmEntityForm): Boolean;
     {* вставляет форму в контейнер }
   function pm_GetEntityFormIterator: IvcmEntityFormIterator;
   function HasForm(const aName: TvcmFormID;
    aZoneType: TvcmZoneType = vcm_ztAny;
    aRecursive: Boolean = true;
    theForm: PIvcmEntityForm = nil;
    aUserType: TvcmUserType = vcm_utAny;
    aGUID: PGUID = nil;
    aSubUserType: TvcmUserType = vcm_utAny): Boolean; overload; 
     {* проверяет есть ли в контейнере такая форма }
   function HasForm(aZoneType: TvcmZoneType = vcm_ztAny;
    aRecursive: Boolean = true;
    theForm: PIvcmEntityForm = nil;
    aUserType: TvcmUserType = vcm_utAny;
    aGUID: PGUID = nil;
    aSubUserType: TvcmUserType = vcm_utAny): Boolean; overload; 
     {* проверяет есть ли в контейнере такая форма }
   function Operation(const anOp: TvcmOPID;
    const aParams: IvcmExecuteParams): Boolean; overload; 
     {* Выполнение операции по имени сущности }
   function Operation(const anOp: TvcmOPID;
    const aParams: IvcmTestParams): Boolean; overload; 
     {* Выполнение операции по имени сущности }
   function Operation(const anOp: TvcmOPID;
    aMode: TvcmOperationMode = vcm_omExecute): Boolean; overload; 
     {* Выполнение операции по имени сущности }
   function IsNull: Boolean;
   procedure FormStyle(const aForm: IvcmEntityForm;
    const aStyle: IvcmFormStyle);
     {* определим стиль формы }
   procedure SetFocusToMainObjectForm;
     {* устанавливаем фокус в самую вложенную форму указанной зоны }
   procedure ChildDataSourceChanged(const aChild: IvcmEntityForm;
    const anOld: IvcmFormDataSource;
    const aNew: IvcmFormDataSource);
     {* вызывается при изменении источника данных вложенной формы }
   function Get_NativeMainForm: IvcmContainer;
   function Get_AsForm: IvcmEntityForm;
   function NeedSetFocusToMainObjectFormOnRefresh: Boolean;
     {* Надо ли передвигать фокус в главную форму при изменении сборки }
   procedure SetTabCaption(const aTabCaption: IvcmCString);
   procedure InitFromPrevContainer(const aPrevContainer: IvcmContainer;
     aClone: Boolean);
   function pm_GetFormSetIterator: IvcmFormSetIterator;
   function pm_GetAggregateIterator: IvcmAggregateIterator;
 protected
 // protected methods
   procedure ChildDataSourceChanged(const aChild: IvcmEntityForm;
     const anOld: IvcmFormDataSource;
     const aNew: IvcmFormDataSource); virtual;
     {* вызывается при изменении источника данных вложенной формы. }
   function GetNeedSetFocusToMainObjectFormOnRefresh: Boolean; virtual;
     {* Надо ли передвигать фокус в главную форму при изменении сборки }
   procedure SetTabCaption(const aTabCaption: IvcmCString); virtual;
   procedure DoInitFromPrevContainer(const aContainer: IvcmContainer;
     aForClone: Boolean); virtual;
   function InsertForm(const aForm: IvcmEntityForm): Boolean; virtual;
   procedure RestoreControlSize; virtual;
 public
 // public methods
   function AcceptForm(const aForm: IvcmEntityForm;
     aControl: TComponent): Boolean; virtual;
 end;//TvcmContainerForm
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

// start class TvcmContainerForm

function TvcmContainerForm.AcceptForm(const aForm: IvcmEntityForm;
  aControl: TComponent): Boolean;
//#UC START# *52F2254D0058_49525C240170_var*
//#UC END# *52F2254D0058_49525C240170_var*
begin
//#UC START# *52F2254D0058_49525C240170_impl*
 !!! Needs to be implemented !!!
//#UC END# *52F2254D0058_49525C240170_impl*
end;//TvcmContainerForm.AcceptForm

procedure TvcmContainerForm.ChildDataSourceChanged(const aChild: IvcmEntityForm;
  const anOld: IvcmFormDataSource;
  const aNew: IvcmFormDataSource);
//#UC START# *53B38B73003D_49525C240170_var*
//#UC END# *53B38B73003D_49525C240170_var*
begin
//#UC START# *53B38B73003D_49525C240170_impl*
 !!! Needs to be implemented !!!
//#UC END# *53B38B73003D_49525C240170_impl*
end;//TvcmContainerForm.ChildDataSourceChanged

function TvcmContainerForm.GetNeedSetFocusToMainObjectFormOnRefresh: Boolean;
//#UC START# *541011910033_49525C240170_var*
//#UC END# *541011910033_49525C240170_var*
begin
//#UC START# *541011910033_49525C240170_impl*
 !!! Needs to be implemented !!!
//#UC END# *541011910033_49525C240170_impl*
end;//TvcmContainerForm.GetNeedSetFocusToMainObjectFormOnRefresh

procedure TvcmContainerForm.SetTabCaption(const aTabCaption: IvcmCString);
//#UC START# *542A6DA20026_49525C240170_var*
//#UC END# *542A6DA20026_49525C240170_var*
begin
//#UC START# *542A6DA20026_49525C240170_impl*
 !!! Needs to be implemented !!!
//#UC END# *542A6DA20026_49525C240170_impl*
end;//TvcmContainerForm.SetTabCaption

procedure TvcmContainerForm.DoInitFromPrevContainer(const aContainer: IvcmContainer;
  aForClone: Boolean);
//#UC START# *54327E120331_49525C240170_var*
//#UC END# *54327E120331_49525C240170_var*
begin
//#UC START# *54327E120331_49525C240170_impl*
 !!! Needs to be implemented !!!
//#UC END# *54327E120331_49525C240170_impl*
end;//TvcmContainerForm.DoInitFromPrevContainer

function TvcmContainerForm.InsertForm(const aForm: IvcmEntityForm): Boolean;
//#UC START# *4AD44CA20001_49525C240170_var*
//#UC END# *4AD44CA20001_49525C240170_var*
begin
//#UC START# *4AD44CA20001_49525C240170_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AD44CA20001_49525C240170_impl*
end;//TvcmContainerForm.InsertForm

procedure TvcmContainerForm.RestoreControlSize;
//#UC START# *4C934E5F0035_49525C240170_var*
//#UC END# *4C934E5F0035_49525C240170_var*
begin
//#UC START# *4C934E5F0035_49525C240170_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C934E5F0035_49525C240170_impl*
end;//TvcmContainerForm.RestoreControlSize

procedure TvcmContainerForm.RegForm(const aForm: IvcmEntityForm);
//#UC START# *499465420011_49525C240170_var*
//#UC END# *499465420011_49525C240170_var*
begin
//#UC START# *499465420011_49525C240170_impl*
 !!! Needs to be implemented !!!
//#UC END# *499465420011_49525C240170_impl*
end;//TvcmContainerForm.RegForm

procedure TvcmContainerForm.UnregForm(const aForm: IvcmEntityForm);
//#UC START# *4994654F0146_49525C240170_var*
//#UC END# *4994654F0146_49525C240170_var*
begin
//#UC START# *4994654F0146_49525C240170_impl*
 !!! Needs to be implemented !!!
//#UC END# *4994654F0146_49525C240170_impl*
end;//TvcmContainerForm.UnregForm

function TvcmContainerForm.InsertForm(const aForm: IvcmEntityForm): Boolean;
//#UC START# *499465600298_49525C240170_var*
//#UC END# *499465600298_49525C240170_var*
begin
//#UC START# *499465600298_49525C240170_impl*
 !!! Needs to be implemented !!!
//#UC END# *499465600298_49525C240170_impl*
end;//TvcmContainerForm.InsertForm

function TvcmContainerForm.pm_GetEntityFormIterator: IvcmEntityFormIterator;
//#UC START# *4994657202CB_49525C240170get_var*
//#UC END# *4994657202CB_49525C240170get_var*
begin
//#UC START# *4994657202CB_49525C240170get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4994657202CB_49525C240170get_impl*
end;//TvcmContainerForm.pm_GetEntityFormIterator

function TvcmContainerForm.HasForm(const aName: TvcmFormID;
  aZoneType: TvcmZoneType = vcm_ztAny;
  aRecursive: Boolean = true;
  theForm: PIvcmEntityForm = nil;
  aUserType: TvcmUserType = vcm_utAny;
  aGUID: PGUID = nil;
  aSubUserType: TvcmUserType = vcm_utAny): Boolean;
//#UC START# *4995536001FF_49525C240170_var*
//#UC END# *4995536001FF_49525C240170_var*
begin
//#UC START# *4995536001FF_49525C240170_impl*
 !!! Needs to be implemented !!!
//#UC END# *4995536001FF_49525C240170_impl*
end;//TvcmContainerForm.HasForm

function TvcmContainerForm.HasForm(aZoneType: TvcmZoneType = vcm_ztAny;
  aRecursive: Boolean = true;
  theForm: PIvcmEntityForm = nil;
  aUserType: TvcmUserType = vcm_utAny;
  aGUID: PGUID = nil;
  aSubUserType: TvcmUserType = vcm_utAny): Boolean;
//#UC START# *499554390363_49525C240170_var*
//#UC END# *499554390363_49525C240170_var*
begin
//#UC START# *499554390363_49525C240170_impl*
 !!! Needs to be implemented !!!
//#UC END# *499554390363_49525C240170_impl*
end;//TvcmContainerForm.HasForm

function TvcmContainerForm.Operation(const anOp: TvcmOPID;
  const aParams: IvcmExecuteParams): Boolean;
//#UC START# *4995546101E3_49525C240170_var*
//#UC END# *4995546101E3_49525C240170_var*
begin
//#UC START# *4995546101E3_49525C240170_impl*
 !!! Needs to be implemented !!!
//#UC END# *4995546101E3_49525C240170_impl*
end;//TvcmContainerForm.Operation

function TvcmContainerForm.Operation(const anOp: TvcmOPID;
  const aParams: IvcmTestParams): Boolean;
//#UC START# *4995547E019E_49525C240170_var*
//#UC END# *4995547E019E_49525C240170_var*
begin
//#UC START# *4995547E019E_49525C240170_impl*
 !!! Needs to be implemented !!!
//#UC END# *4995547E019E_49525C240170_impl*
end;//TvcmContainerForm.Operation

function TvcmContainerForm.Operation(const anOp: TvcmOPID;
  aMode: TvcmOperationMode = vcm_omExecute): Boolean;
//#UC START# *49955492037E_49525C240170_var*
//#UC END# *49955492037E_49525C240170_var*
begin
//#UC START# *49955492037E_49525C240170_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955492037E_49525C240170_impl*
end;//TvcmContainerForm.Operation

function TvcmContainerForm.IsNull: Boolean;
//#UC START# *499554B80219_49525C240170_var*
//#UC END# *499554B80219_49525C240170_var*
begin
//#UC START# *499554B80219_49525C240170_impl*
 !!! Needs to be implemented !!!
//#UC END# *499554B80219_49525C240170_impl*
end;//TvcmContainerForm.IsNull

procedure TvcmContainerForm.FormStyle(const aForm: IvcmEntityForm;
  const aStyle: IvcmFormStyle);
//#UC START# *499555C701C1_49525C240170_var*
//#UC END# *499555C701C1_49525C240170_var*
begin
//#UC START# *499555C701C1_49525C240170_impl*
 !!! Needs to be implemented !!!
//#UC END# *499555C701C1_49525C240170_impl*
end;//TvcmContainerForm.FormStyle

procedure TvcmContainerForm.SetFocusToMainObjectForm;
//#UC START# *499555DC008F_49525C240170_var*
//#UC END# *499555DC008F_49525C240170_var*
begin
//#UC START# *499555DC008F_49525C240170_impl*
 !!! Needs to be implemented !!!
//#UC END# *499555DC008F_49525C240170_impl*
end;//TvcmContainerForm.SetFocusToMainObjectForm

procedure TvcmContainerForm.ChildDataSourceChanged(const aChild: IvcmEntityForm;
  const anOld: IvcmFormDataSource;
  const aNew: IvcmFormDataSource);
//#UC START# *49955603011A_49525C240170_var*
//#UC END# *49955603011A_49525C240170_var*
begin
//#UC START# *49955603011A_49525C240170_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955603011A_49525C240170_impl*
end;//TvcmContainerForm.ChildDataSourceChanged

function TvcmContainerForm.Get_NativeMainForm: IvcmContainer;
//#UC START# *4AB906F6015D_49525C240170get_var*
//#UC END# *4AB906F6015D_49525C240170get_var*
begin
//#UC START# *4AB906F6015D_49525C240170get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AB906F6015D_49525C240170get_impl*
end;//TvcmContainerForm.Get_NativeMainForm

function TvcmContainerForm.Get_AsForm: IvcmEntityForm;
//#UC START# *4AC368490350_49525C240170get_var*
//#UC END# *4AC368490350_49525C240170get_var*
begin
//#UC START# *4AC368490350_49525C240170get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC368490350_49525C240170get_impl*
end;//TvcmContainerForm.Get_AsForm

function TvcmContainerForm.NeedSetFocusToMainObjectFormOnRefresh: Boolean;
//#UC START# *54101156008B_49525C240170_var*
//#UC END# *54101156008B_49525C240170_var*
begin
//#UC START# *54101156008B_49525C240170_impl*
 !!! Needs to be implemented !!!
//#UC END# *54101156008B_49525C240170_impl*
end;//TvcmContainerForm.NeedSetFocusToMainObjectFormOnRefresh

procedure TvcmContainerForm.SetTabCaption(const aTabCaption: IvcmCString);
//#UC START# *542A4C21033B_49525C240170_var*
//#UC END# *542A4C21033B_49525C240170_var*
begin
//#UC START# *542A4C21033B_49525C240170_impl*
 !!! Needs to be implemented !!!
//#UC END# *542A4C21033B_49525C240170_impl*
end;//TvcmContainerForm.SetTabCaption

procedure TvcmContainerForm.InitFromPrevContainer(const aPrevContainer: IvcmContainer;
  aClone: Boolean);
//#UC START# *54327D9E0132_49525C240170_var*
//#UC END# *54327D9E0132_49525C240170_var*
begin
//#UC START# *54327D9E0132_49525C240170_impl*
 !!! Needs to be implemented !!!
//#UC END# *54327D9E0132_49525C240170_impl*
end;//TvcmContainerForm.InitFromPrevContainer

function TvcmContainerForm.pm_GetFormSetIterator: IvcmFormSetIterator;
//#UC START# *55E6B26002B8_49525C240170get_var*
//#UC END# *55E6B26002B8_49525C240170get_var*
begin
//#UC START# *55E6B26002B8_49525C240170get_impl*
 !!! Needs to be implemented !!!
//#UC END# *55E6B26002B8_49525C240170get_impl*
end;//TvcmContainerForm.pm_GetFormSetIterator

function TvcmContainerForm.pm_GetAggregateIterator: IvcmAggregateIterator;
//#UC START# *55E6B272031E_49525C240170get_var*
//#UC END# *55E6B272031E_49525C240170get_var*
begin
//#UC START# *55E6B272031E_49525C240170get_impl*
 !!! Needs to be implemented !!!
//#UC END# *55E6B272031E_49525C240170get_impl*
end;//TvcmContainerForm.pm_GetAggregateIterator

{$IfEnd} //not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация TvcmContainerForm
 TtfwClassRef.Register(TvcmContainerForm);
{$IfEnd} //not NoScripts AND not NoVCM

end.