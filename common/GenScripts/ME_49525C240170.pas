unit vcmContainerForm;

interface

uses
 l3IntfUses
 , vcmContainerFormModelPart
 , vcmInterfaces
 , vcmFormSetRefList
 , vcmAggregateRefList
 , Classes
 , vcmExternalInterfaces
 , vcmUserControls
;

type
 TvcmInsertMode = (
  {* –ежим добавлени€ формы. }
  vcm_imAllow
   {* –азрешение добавлени€ формы в текущий контейнер }
  , vcm_imDisable
   {* «апрет добавлени€ формы в текущий контейнер }
  , vcm_imToParent
   {* ѕеренаправление операции добавлени€ формы в родительскую форму }
 );//TvcmInsertMode
 
 TvcmInsertFormEvent = procedure(const aForm: IvcmEntityForm;
  var aMode: TvcmInsertMode) of object;
 
 TvcmAfterInsertFormEvent = procedure(const aForm: IvcmEntityForm) of object;
 
 TvcmAfterRemoveFormEvent = procedure of object;
 
 TvcmOnNeedUpdateTab = procedure(aSender: TObject;
  const aForm: IvcmEntityForm) of object;
 
 TvcmContainerForm = class(TvcmContainerFormModelPart, IvcmContainer)
  function AcceptForm(const aForm: IvcmEntityForm;
   aControl: TComponent): Boolean;
  procedure ChildDataSourceChanged(const aChild: IvcmEntityForm;
   const anOld: IvcmFormDataSource;
   const aNew: IvcmFormDataSource); overload;
   {* вызываетс€ при изменении источника данных вложенной формы. }
  function GetNeedSetFocusToMainObjectFormOnRefresh: Boolean;
   {* Ќадо ли передвигать фокус в главную форму при изменении сборки }
  procedure SetTabCaption(const aTabCaption: IvcmCString); overload;
  procedure DoInitFromPrevContainer(const aContainer: IvcmContainer;
   aForClone: Boolean);
  function InsertForm(const aForm: IvcmEntityForm): Boolean; overload;
  procedure RestoreControlSize;
  procedure RegForm(const aForm: IvcmEntityForm);
  procedure UnregForm(const aForm: IvcmEntityForm);
  function InsertForm(const aForm: IvcmEntityForm): Boolean; overload;
   {* вставл€ет форму в контейнер }
  function EntityFormIterator: IvcmEntityFormIterator;
   {* итератор форм контейнера }
  function HasForm(const aName: TvcmFormID;
   aZoneType: TvcmZoneType;
   aRecursive: Boolean;
   theForm: PIvcmEntityForm;
   aUserType: TvcmUserType;
   aGUID: PGUID;
   aSubUserType: TvcmUserType): Boolean; overload;
   {* провер€ет есть ли в контейнере така€ форма }
  function HasForm(aZoneType: TvcmZoneType;
   aRecursive: Boolean;
   theForm: PIvcmEntityForm;
   aUserType: TvcmUserType;
   aGUID: PGUID;
   aSubUserType: TvcmUserType): Boolean; overload;
   {* провер€ет есть ли в контейнере така€ форма }
  function Operation(const anOp: TvcmOPID;
   const aParams: IvcmExecuteParams): Boolean; overload;
   {* ¬ыполнение операции по имени сущности }
  function Operation(const anOp: TvcmOPID;
   const aParams: IvcmTestParams): Boolean; overload;
   {* ¬ыполнение операции по имени сущности }
  function Operation(const anOp: TvcmOPID;
   aMode: TvcmOperationMode): Boolean; overload;
   {* ¬ыполнение операции по имени сущности }
  function IsNull: Boolean;
  procedure FormStyle(const aForm: IvcmEntityForm;
   const aStyle: IvcmFormStyle);
   {* определим стиль формы }
  procedure SetFocusToMainObjectForm;
   {* устанавливаем фокус в самую вложенную форму указанной зоны }
  procedure ChildDataSourceChanged(const aChild: IvcmEntityForm;
   const anOld: IvcmFormDataSource;
   const aNew: IvcmFormDataSource); overload;
   {* вызываетс€ при изменении источника данных вложенной формы }
  function NativeMainForm: IvcmContainer;
  function AsForm: IvcmEntityForm;
  function NeedSetFocusToMainObjectFormOnRefresh: Boolean;
   {* Ќадо ли передвигать фокус в главную форму при изменении сборки }
  procedure SetTabCaption(const aTabCaption: IvcmCString); overload;
  procedure InitFromPrevContainer(const aPrevContainer: IvcmContainer;
   aClone: Boolean);
  function FormSetIterator: IvcmFormSetIterator;
  function AggregateIterator: IvcmAggregateIterator;
 end;//TvcmContainerForm
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
;

end.
