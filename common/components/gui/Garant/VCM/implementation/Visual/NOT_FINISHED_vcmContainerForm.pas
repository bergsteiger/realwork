unit NOT_FINISHED_vcmContainerForm;

// ������: "w:\common\components\gui\Garant\VCM\implementation\Visual\NOT_FINISHED_vcmContainerForm.pas"
// ���������: "SimpleClass"
// ������� ������: "TvcmContainerForm" MUID: (49525C240170)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
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
  private
   f_FormSets: TvcmFormSetRefList;
   f_Aggregates: TvcmAggregateRefList;
  protected
   procedure ChildDataSourceChanged(const aChild: IvcmEntityForm;
    const anOld: IvcmFormDataSource;
    const aNew: IvcmFormDataSource); overload; virtual;
    {* ���������� ��� ��������� ��������� ������ ��������� �����. }
   function GetNeedSetFocusToMainObjectFormOnRefresh: Boolean; virtual;
    {* ���� �� ����������� ����� � ������� ����� ��� ��������� ������ }
   procedure SetTabCaption(const aTabCaption: IvcmCString); overload; virtual;
   procedure DoInitFromPrevContainer(const aContainer: IvcmContainer;
    aForClone: Boolean); virtual;
   function InsertForm(const aForm: IvcmEntityForm): Boolean; overload; virtual;
   procedure RestoreControlSize; virtual;
   procedure RegForm(const aForm: IvcmEntityForm);
   procedure UnregForm(const aForm: IvcmEntityForm);
   function InsertForm(const aForm: IvcmEntityForm): Boolean; overload;
    {* ��������� ����� � ��������� }
   function pm_GetEntityFormIterator: IvcmEntityFormIterator;
   function HasForm(const aName: TvcmFormID;
    aZoneType: TvcmZoneType = vcm_ztAny;
    aRecursive: Boolean = True;
    theForm: PIvcmEntityForm = nil;
    aUserType: TvcmUserType = vcm_utAny;
    aGUID: PGUID = nil;
    aSubUserType: TvcmUserType = vcm_utAny): Boolean; overload;
    {* ��������� ���� �� � ���������� ����� ����� }
   function HasForm(aZoneType: TvcmZoneType = vcm_ztAny;
    aRecursive: Boolean = True;
    theForm: PIvcmEntityForm = nil;
    aUserType: TvcmUserType = vcm_utAny;
    aGUID: PGUID = nil;
    aSubUserType: TvcmUserType = vcm_utAny): Boolean; overload;
    {* ��������� ���� �� � ���������� ����� ����� }
   function Operation(const anOp: TvcmOPID;
    const aParams: IvcmExecuteParams): Boolean; overload;
    {* ���������� �������� �� ����� �������� }
   function Operation(const anOp: TvcmOPID;
    const aParams: IvcmTestParams): Boolean; overload;
    {* ���������� �������� �� ����� �������� }
   function Operation(const anOp: TvcmOPID;
    aMode: TvcmOperationMode = vcmUserControls.vcm_omExecute): Boolean; overload;
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
   function Get_NativeMainForm: IvcmContainer;
   function Get_AsForm: IvcmEntityForm;
   function NeedSetFocusToMainObjectFormOnRefresh: Boolean;
    {* ���� �� ����������� ����� � ������� ����� ��� ��������� ������ }
   procedure SetTabCaption(const aTabCaption: IvcmCString); overload;
   procedure InitFromPrevContainer(const aPrevContainer: IvcmContainer;
    aClone: Boolean);
   function pm_GetFormSetIterator: IvcmFormSetIterator;
   function pm_GetAggregateIterator: IvcmAggregateIterator;
   function IsSame(const aAnother: IvcmContainer): Boolean;
  public
   function AcceptForm(const aForm: IvcmEntityForm;
    aControl: TComponent): Boolean; virtual;
 end;//TvcmContainerForm
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *49525C240170impl_uses*
 //#UC END# *49525C240170impl_uses*
;

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
 {* ���������� ��� ��������� ��������� ������ ��������� �����. }
//#UC START# *53B38B73003D_49525C240170_var*
//#UC END# *53B38B73003D_49525C240170_var*
begin
//#UC START# *53B38B73003D_49525C240170_impl*
 !!! Needs to be implemented !!!
//#UC END# *53B38B73003D_49525C240170_impl*
end;//TvcmContainerForm.ChildDataSourceChanged

function TvcmContainerForm.GetNeedSetFocusToMainObjectFormOnRefresh: Boolean;
 {* ���� �� ����������� ����� � ������� ����� ��� ��������� ������ }
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
 {* ��������� ����� � ��������� }
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
 aRecursive: Boolean = True;
 theForm: PIvcmEntityForm = nil;
 aUserType: TvcmUserType = vcm_utAny;
 aGUID: PGUID = nil;
 aSubUserType: TvcmUserType = vcm_utAny): Boolean;
 {* ��������� ���� �� � ���������� ����� ����� }
//#UC START# *4995536001FF_49525C240170_var*
//#UC END# *4995536001FF_49525C240170_var*
begin
//#UC START# *4995536001FF_49525C240170_impl*
 !!! Needs to be implemented !!!
//#UC END# *4995536001FF_49525C240170_impl*
end;//TvcmContainerForm.HasForm

function TvcmContainerForm.HasForm(aZoneType: TvcmZoneType = vcm_ztAny;
 aRecursive: Boolean = True;
 theForm: PIvcmEntityForm = nil;
 aUserType: TvcmUserType = vcm_utAny;
 aGUID: PGUID = nil;
 aSubUserType: TvcmUserType = vcm_utAny): Boolean;
 {* ��������� ���� �� � ���������� ����� ����� }
//#UC START# *499554390363_49525C240170_var*
//#UC END# *499554390363_49525C240170_var*
begin
//#UC START# *499554390363_49525C240170_impl*
 !!! Needs to be implemented !!!
//#UC END# *499554390363_49525C240170_impl*
end;//TvcmContainerForm.HasForm

function TvcmContainerForm.Operation(const anOp: TvcmOPID;
 const aParams: IvcmExecuteParams): Boolean;
 {* ���������� �������� �� ����� �������� }
//#UC START# *4995546101E3_49525C240170_var*
//#UC END# *4995546101E3_49525C240170_var*
begin
//#UC START# *4995546101E3_49525C240170_impl*
 !!! Needs to be implemented !!!
//#UC END# *4995546101E3_49525C240170_impl*
end;//TvcmContainerForm.Operation

function TvcmContainerForm.Operation(const anOp: TvcmOPID;
 const aParams: IvcmTestParams): Boolean;
 {* ���������� �������� �� ����� �������� }
//#UC START# *4995547E019E_49525C240170_var*
//#UC END# *4995547E019E_49525C240170_var*
begin
//#UC START# *4995547E019E_49525C240170_impl*
 !!! Needs to be implemented !!!
//#UC END# *4995547E019E_49525C240170_impl*
end;//TvcmContainerForm.Operation

function TvcmContainerForm.Operation(const anOp: TvcmOPID;
 aMode: TvcmOperationMode = vcmUserControls.vcm_omExecute): Boolean;
 {* ���������� �������� �� ����� �������� }
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
 {* ��������� ����� ����� }
//#UC START# *499555C701C1_49525C240170_var*
//#UC END# *499555C701C1_49525C240170_var*
begin
//#UC START# *499555C701C1_49525C240170_impl*
 !!! Needs to be implemented !!!
//#UC END# *499555C701C1_49525C240170_impl*
end;//TvcmContainerForm.FormStyle

procedure TvcmContainerForm.SetFocusToMainObjectForm;
 {* ������������� ����� � ����� ��������� ����� ��������� ���� }
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
 {* ���������� ��� ��������� ��������� ������ ��������� ����� }
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
 {* ���� �� ����������� ����� � ������� ����� ��� ��������� ������ }
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

function TvcmContainerForm.IsSame(const aAnother: IvcmContainer): Boolean;
//#UC START# *56792D030305_49525C240170_var*
//#UC END# *56792D030305_49525C240170_var*
begin
//#UC START# *56792D030305_49525C240170_impl*
 !!! Needs to be implemented !!!
//#UC END# *56792D030305_49525C240170_impl*
end;//TvcmContainerForm.IsSame

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmContainerForm);
 {* ����������� TvcmContainerForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
