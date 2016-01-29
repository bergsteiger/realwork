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
  {* ����� ���������� �����. }
  vcm_imAllow
   {* ���������� ���������� ����� � ������� ��������� }
  , vcm_imDisable
   {* ������ ���������� ����� � ������� ��������� }
  , vcm_imToParent
   {* ��������������� �������� ���������� ����� � ������������ ����� }
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
   {* ���������� ��� ��������� ��������� ������ ��������� �����. }
  function GetNeedSetFocusToMainObjectFormOnRefresh: Boolean;
   {* ���� �� ����������� ����� � ������� ����� ��� ��������� ������ }
  procedure SetTabCaption(const aTabCaption: IvcmCString); overload;
  procedure DoInitFromPrevContainer(const aContainer: IvcmContainer;
   aForClone: Boolean);
  function InsertForm(const aForm: IvcmEntityForm): Boolean; overload;
  procedure RestoreControlSize;
  procedure RegForm(const aForm: IvcmEntityForm);
  procedure UnregForm(const aForm: IvcmEntityForm);
  function InsertForm(const aForm: IvcmEntityForm): Boolean; overload;
   {* ��������� ����� � ��������� }
  function EntityFormIterator: IvcmEntityFormIterator;
   {* �������� ���� ���������� }
  function HasForm(const aName: TvcmFormID;
   aZoneType: TvcmZoneType;
   aRecursive: Boolean;
   theForm: PIvcmEntityForm;
   aUserType: TvcmUserType;
   aGUID: PGUID;
   aSubUserType: TvcmUserType): Boolean; overload;
   {* ��������� ���� �� � ���������� ����� ����� }
  function HasForm(aZoneType: TvcmZoneType;
   aRecursive: Boolean;
   theForm: PIvcmEntityForm;
   aUserType: TvcmUserType;
   aGUID: PGUID;
   aSubUserType: TvcmUserType): Boolean; overload;
   {* ��������� ���� �� � ���������� ����� ����� }
  function Operation(const anOp: TvcmOPID;
   const aParams: IvcmExecuteParams): Boolean; overload;
   {* ���������� �������� �� ����� �������� }
  function Operation(const anOp: TvcmOPID;
   const aParams: IvcmTestParams): Boolean; overload;
   {* ���������� �������� �� ����� �������� }
  function Operation(const anOp: TvcmOPID;
   aMode: TvcmOperationMode): Boolean; overload;
   {* ���������� �������� �� ����� �������� }
  function IsNull: Boolean;
  procedure FormStyle(const aForm: IvcmEntityForm;
   const aStyle: IvcmFormStyle);
   {* ��������� ����� ����� }
  procedure SetFocusToMainObjectForm;
   {* ������������� ����� � ����� ��������� ����� ��������� ���� }
  procedure ChildDataSourceChanged(const aChild: IvcmEntityForm;
   const anOld: IvcmFormDataSource;
   const aNew: IvcmFormDataSource); overload;
   {* ���������� ��� ��������� ��������� ������ ��������� ����� }
  function NativeMainForm: IvcmContainer;
  function AsForm: IvcmEntityForm;
  function NeedSetFocusToMainObjectFormOnRefresh: Boolean;
   {* ���� �� ����������� ����� � ������� ����� ��� ��������� ������ }
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
