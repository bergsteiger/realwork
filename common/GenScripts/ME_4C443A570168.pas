unit PrimTreeAttributeSelectOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimTreeAttributeSelectOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimTreeAttributeSelect_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Text_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , SearchLite_Strange_Controls
 , Classes
;

type
 TPrimTreeAttributeSelectOptionsForm = class(TPrimTreeAttributeSelectForm)
  protected
   function EntitiesenSelectionGetTarget(aControl: TComponent;
    aX: Integer;
    aY: Integer;
    out theTarget: IUnknown): Boolean;
  public
   {$If NOT Defined(NoVCM)}
   procedure Delete; override;
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Copy; override;
    {* Копировать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Cut; override;
    {* Вырезать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure FindContext; override;
    {* Поиск }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure FindNext; override;
    {* Найти далее }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Paste; override;
    {* Вставка }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Undo; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Redo; override;
    {* Возврат }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure SelectAll; override;
    {* Выделить всё }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Deselect; override;
    {* Снять выделение }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure FindPrev; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Ok; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure LogicOr; override;
   procedure LogicAnd; override;
   procedure LogicNot; override;
   {$If NOT Defined(NoVCM)}
   procedure ExpandAll; override;
    {* Развернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure CollapseAll; override;
    {* Свернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure LogicOrShortcut; override;
   procedure DropSelection; override;
   {$If NOT Defined(NoVCM)}
   procedure Ok; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   constructor Create(AOwner: TComponent); override;
   procedure FindFirstSelected; override;
 end;//TPrimTreeAttributeSelectOptionsForm

implementation

uses
 l3ImplUses
 , DynamicTreeUnit
 , SysUtils
 , SearchDomainInterfaces
 , nsLogicOperationToFlags
 {$If NOT Defined(NoVCM)}
 , vcmBaseOperationsCollectionItem
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , PrimTreeAttributeSelect_astFirstLevel_UserType
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

function TPrimTreeAttributeSelectOptionsForm.EntitiesenSelectionGetTarget(aControl: TComponent;
 aX: Integer;
 aY: Integer;
 out theTarget: IUnknown): Boolean;
//#UC START# *4F88607901F5_4C443A570168_var*
//#UC END# *4F88607901F5_4C443A570168_var*
begin
//#UC START# *4F88607901F5_4C443A570168_impl*
 // Это нужно для того, чтобы в логических операциях вызывались OnContextTest
 Result := True;
 // Отдавать нужно обязательно так, поэтому что IInterface может умереть не
 // зависимо от IvcmEntityForm
 theTarget := (Self.as_IvcmEntityForm);
//#UC END# *4F88607901F5_4C443A570168_impl*
end;//TPrimTreeAttributeSelectOptionsForm.EntitiesenSelectionGetTarget

{$If NOT Defined(NoVCM)}
procedure TPrimTreeAttributeSelectOptionsForm.Delete;
 {* Удалить }
//#UC START# *494F89C30197_4C443A570168_var*
//#UC END# *494F89C30197_4C443A570168_var*
begin
//#UC START# *494F89C30197_4C443A570168_impl*
 !!! Needs to be implemented !!!
//#UC END# *494F89C30197_4C443A570168_impl*
end;//TPrimTreeAttributeSelectOptionsForm.Delete
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimTreeAttributeSelectOptionsForm.Copy;
 {* Копировать }
//#UC START# *4951284902BD_4C443A570168_var*
//#UC END# *4951284902BD_4C443A570168_var*
begin
//#UC START# *4951284902BD_4C443A570168_impl*
 !!! Needs to be implemented !!!
//#UC END# *4951284902BD_4C443A570168_impl*
end;//TPrimTreeAttributeSelectOptionsForm.Copy
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimTreeAttributeSelectOptionsForm.Cut;
 {* Вырезать }
//#UC START# *4951285702E1_4C443A570168_var*
//#UC END# *4951285702E1_4C443A570168_var*
begin
//#UC START# *4951285702E1_4C443A570168_impl*
 !!! Needs to be implemented !!!
//#UC END# *4951285702E1_4C443A570168_impl*
end;//TPrimTreeAttributeSelectOptionsForm.Cut
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimTreeAttributeSelectOptionsForm.FindContext;
 {* Поиск }
//#UC START# *49512B5D0009_4C443A570168_var*
//#UC END# *49512B5D0009_4C443A570168_var*
begin
//#UC START# *49512B5D0009_4C443A570168_impl*
 !!! Needs to be implemented !!!
//#UC END# *49512B5D0009_4C443A570168_impl*
end;//TPrimTreeAttributeSelectOptionsForm.FindContext
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimTreeAttributeSelectOptionsForm.FindNext;
 {* Найти далее }
//#UC START# *495130C40123_4C443A570168_var*
//#UC END# *495130C40123_4C443A570168_var*
begin
//#UC START# *495130C40123_4C443A570168_impl*
 !!! Needs to be implemented !!!
//#UC END# *495130C40123_4C443A570168_impl*
end;//TPrimTreeAttributeSelectOptionsForm.FindNext
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimTreeAttributeSelectOptionsForm.Paste;
 {* Вставка }
//#UC START# *49EDFA3701B0_4C443A570168_var*
//#UC END# *49EDFA3701B0_4C443A570168_var*
begin
//#UC START# *49EDFA3701B0_4C443A570168_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EDFA3701B0_4C443A570168_impl*
end;//TPrimTreeAttributeSelectOptionsForm.Paste
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimTreeAttributeSelectOptionsForm.Undo;
 {* Отмена }
//#UC START# *49EDFCA2006D_4C443A570168_var*
//#UC END# *49EDFCA2006D_4C443A570168_var*
begin
//#UC START# *49EDFCA2006D_4C443A570168_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EDFCA2006D_4C443A570168_impl*
end;//TPrimTreeAttributeSelectOptionsForm.Undo
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimTreeAttributeSelectOptionsForm.Redo;
 {* Возврат }
//#UC START# *49EDFCB100BC_4C443A570168_var*
//#UC END# *49EDFCB100BC_4C443A570168_var*
begin
//#UC START# *49EDFCB100BC_4C443A570168_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EDFCB100BC_4C443A570168_impl*
end;//TPrimTreeAttributeSelectOptionsForm.Redo
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimTreeAttributeSelectOptionsForm.SelectAll;
 {* Выделить всё }
//#UC START# *49EE01AA02BE_4C443A570168_var*
//#UC END# *49EE01AA02BE_4C443A570168_var*
begin
//#UC START# *49EE01AA02BE_4C443A570168_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EE01AA02BE_4C443A570168_impl*
end;//TPrimTreeAttributeSelectOptionsForm.SelectAll
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimTreeAttributeSelectOptionsForm.Deselect;
 {* Снять выделение }
//#UC START# *49EE01BC022E_4C443A570168_var*
//#UC END# *49EE01BC022E_4C443A570168_var*
begin
//#UC START# *49EE01BC022E_4C443A570168_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EE01BC022E_4C443A570168_impl*
end;//TPrimTreeAttributeSelectOptionsForm.Deselect
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimTreeAttributeSelectOptionsForm.FindPrev;
//#UC START# *49FEDE4703B8_4C443A570168_var*
//#UC END# *49FEDE4703B8_4C443A570168_var*
begin
//#UC START# *49FEDE4703B8_4C443A570168_impl*
 !!! Needs to be implemented !!!
//#UC END# *49FEDE4703B8_4C443A570168_impl*
end;//TPrimTreeAttributeSelectOptionsForm.FindPrev
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimTreeAttributeSelectOptionsForm.Ok;
 {* OK }
//#UC START# *4A97EBE702F8_4C443A570168_var*
//#UC END# *4A97EBE702F8_4C443A570168_var*
begin
//#UC START# *4A97EBE702F8_4C443A570168_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A97EBE702F8_4C443A570168_impl*
end;//TPrimTreeAttributeSelectOptionsForm.Ok
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimTreeAttributeSelectOptionsForm.LogicOr;
//#UC START# *4AFAFB4602D9_4C443A570168_var*
//#UC END# *4AFAFB4602D9_4C443A570168_var*
begin
//#UC START# *4AFAFB4602D9_4C443A570168_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AFAFB4602D9_4C443A570168_impl*
end;//TPrimTreeAttributeSelectOptionsForm.LogicOr

procedure TPrimTreeAttributeSelectOptionsForm.LogicAnd;
//#UC START# *4AFAFB5800B9_4C443A570168_var*
//#UC END# *4AFAFB5800B9_4C443A570168_var*
begin
//#UC START# *4AFAFB5800B9_4C443A570168_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AFAFB5800B9_4C443A570168_impl*
end;//TPrimTreeAttributeSelectOptionsForm.LogicAnd

procedure TPrimTreeAttributeSelectOptionsForm.LogicNot;
//#UC START# *4AFAFB7002B5_4C443A570168_var*
//#UC END# *4AFAFB7002B5_4C443A570168_var*
begin
//#UC START# *4AFAFB7002B5_4C443A570168_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AFAFB7002B5_4C443A570168_impl*
end;//TPrimTreeAttributeSelectOptionsForm.LogicNot

{$If NOT Defined(NoVCM)}
procedure TPrimTreeAttributeSelectOptionsForm.ExpandAll;
 {* Развернуть все }
//#UC START# *4BDAF7880236_4C443A570168_var*
//#UC END# *4BDAF7880236_4C443A570168_var*
begin
//#UC START# *4BDAF7880236_4C443A570168_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDAF7880236_4C443A570168_impl*
end;//TPrimTreeAttributeSelectOptionsForm.ExpandAll
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimTreeAttributeSelectOptionsForm.CollapseAll;
 {* Свернуть все }
//#UC START# *4BDAF7A2005C_4C443A570168_var*
//#UC END# *4BDAF7A2005C_4C443A570168_var*
begin
//#UC START# *4BDAF7A2005C_4C443A570168_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDAF7A2005C_4C443A570168_impl*
end;//TPrimTreeAttributeSelectOptionsForm.CollapseAll
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimTreeAttributeSelectOptionsForm.LogicOrShortcut;
//#UC START# *4C44444E0066_4C443A570168_var*
//#UC END# *4C44444E0066_4C443A570168_var*
begin
//#UC START# *4C44444E0066_4C443A570168_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C44444E0066_4C443A570168_impl*
end;//TPrimTreeAttributeSelectOptionsForm.LogicOrShortcut

procedure TPrimTreeAttributeSelectOptionsForm.DropSelection;
//#UC START# *4C4445300216_4C443A570168_var*
//#UC END# *4C4445300216_4C443A570168_var*
begin
//#UC START# *4C4445300216_4C443A570168_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C4445300216_4C443A570168_impl*
end;//TPrimTreeAttributeSelectOptionsForm.DropSelection

{$If NOT Defined(NoVCM)}
procedure TPrimTreeAttributeSelectOptionsForm.Ok;
 {* OK }
//#UC START# *4C762A1501FC_4C443A570168_var*
//#UC END# *4C762A1501FC_4C443A570168_var*
begin
//#UC START# *4C762A1501FC_4C443A570168_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762A1501FC_4C443A570168_impl*
end;//TPrimTreeAttributeSelectOptionsForm.Ok
{$IfEnd} // NOT Defined(NoVCM)

constructor TPrimTreeAttributeSelectOptionsForm.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4C443A570168_var*
//#UC END# *47D1602000C6_4C443A570168_var*
begin
//#UC START# *47D1602000C6_4C443A570168_impl*
 inherited;
{$If defined(Monitorings) or defined(Admin)}
  with dmStdRes.MenuManager.GetItemByName('enEdit') do
  begin
   with TvcmBaseOperationsCollectionItem(Operations.FindItemByName('opFindContext')) do
    Options := Options - [vcm_ooShowInMainMenu];
   with TvcmBaseOperationsCollectionItem(Operations.FindItemByName('opFindNext')) do
    Options := Options - [vcm_ooShowInMainMenu];
   with TvcmBaseOperationsCollectionItem(Operations.FindItemByName('opFindPrev')) do
    Options := Options - [vcm_ooShowInMainMenu];
  end;
{$IfEnd defined(Monitorings) or defined(Admin)}

//#UC END# *47D1602000C6_4C443A570168_impl*
end;//TPrimTreeAttributeSelectOptionsForm.Create

procedure TPrimTreeAttributeSelectOptionsForm.FindFirstSelected;
//#UC START# *4C2B1B9100B5_4C443A570168_var*
//#UC END# *4C2B1B9100B5_4C443A570168_var*
begin
//#UC START# *4C2B1B9100B5_4C443A570168_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C2B1B9100B5_4C443A570168_impl*
end;//TPrimTreeAttributeSelectOptionsForm.FindFirstSelected

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimTreeAttributeSelectOptionsForm);
 {* Регистрация PrimTreeAttributeSelectOptions }
{$IfEnd} // NOT Defined(NoScripts)

end.
