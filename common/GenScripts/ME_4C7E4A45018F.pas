unit PrimUnderControlOptions_Form;
 {* На контроле }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\UnderControl\Forms\PrimUnderControlOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimUnderControl_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Text_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , UnderControl_Strange_Controls
 , L10nInterfaces
 , FoldersDomainInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimUnderControlOptionsForm = class(TPrimUnderControlForm)
  {* На контроле }
  private
   f_SortTypeMap: InsIntegerValueMap;
  protected
   function pm_GetUnderControlInfo: InsUnderControlInfo;
   procedure enControlCenterNullListTest(const aParams: IvcmTestParamsPrim);
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
  public
   {$If NOT Defined(NoVCM)}
   procedure Paste; override;
    {* Вставка }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Copy; override;
    {* Копировать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Delete; override;
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Add; override;
   procedure CreateList; override;
   procedure Sort; override;
   procedure ClearAllStatus; override;
   procedure Open; override;
   procedure ClearStatus; override;
   procedure ShowChanges; override;
    {* Показать изменения }
  protected
   property UnderControlInfo: InsUnderControlInfo
    read pm_GetUnderControlInfo;
 end;//TPrimUnderControlOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , eeInterfaces
 , SysUtils
 , nsValueMaps
 , nsValueMapsIDs
 {$If Defined(Nemesis)}
 , eeTreeMisc
 {$IfEnd} // Defined(Nemesis)
 , nsFolders
 , nsOpenUtils
 , nsFolderFilterInfo
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

function TPrimUnderControlOptionsForm.pm_GetUnderControlInfo: InsUnderControlInfo;
//#UC START# *4C7E4FB400A8_4C7E4A45018Fget_var*
//#UC END# *4C7E4FB400A8_4C7E4A45018Fget_var*
begin
//#UC START# *4C7E4FB400A8_4C7E4A45018Fget_impl*
 Supports(UnderControlList.TreeStruct, InsUnderControlInfo, Result);
//#UC END# *4C7E4FB400A8_4C7E4A45018Fget_impl*
end;//TPrimUnderControlOptionsForm.pm_GetUnderControlInfo

procedure TPrimUnderControlOptionsForm.enControlCenterNullListTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7E584D02A3_4C7E4A45018F_var*
//#UC END# *4C7E584D02A3_4C7E4A45018F_var*
begin
//#UC START# *4C7E584D02A3_4C7E4A45018F_impl*
 with aParams do
 begin
  if (UnderControlList.TreeView.Tree.SelectedCount >= 1) then
   Op.Flag[vcm_ofEnabled] := Supports(UnderControlList.TreeView.CurrentNode, InsUnderControlNode)
  else
   Op.Flag[vcm_ofEnabled] := False;
 end;
//#UC END# *4C7E584D02A3_4C7E4A45018F_impl*
end;//TPrimUnderControlOptionsForm.enControlCenterNullListTest

{$If NOT Defined(NoVCM)}
procedure TPrimUnderControlOptionsForm.Paste;
 {* Вставка }
//#UC START# *49EDFA3701B0_4C7E4A45018F_var*
//#UC END# *49EDFA3701B0_4C7E4A45018F_var*
begin
//#UC START# *49EDFA3701B0_4C7E4A45018F_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EDFA3701B0_4C7E4A45018F_impl*
end;//TPrimUnderControlOptionsForm.Paste
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimUnderControlOptionsForm.Copy;
 {* Копировать }
//#UC START# *4C7D0C7B0185_4C7E4A45018F_var*
//#UC END# *4C7D0C7B0185_4C7E4A45018F_var*
begin
//#UC START# *4C7D0C7B0185_4C7E4A45018F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D0C7B0185_4C7E4A45018F_impl*
end;//TPrimUnderControlOptionsForm.Copy
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimUnderControlOptionsForm.Delete;
 {* Удалить }
//#UC START# *4C7D0CC90052_4C7E4A45018F_var*
//#UC END# *4C7D0CC90052_4C7E4A45018F_var*
begin
//#UC START# *4C7D0CC90052_4C7E4A45018F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D0CC90052_4C7E4A45018F_impl*
end;//TPrimUnderControlOptionsForm.Delete
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimUnderControlOptionsForm.Add;
//#UC START# *4C7E4B830292_4C7E4A45018F_var*
//#UC END# *4C7E4B830292_4C7E4A45018F_var*
begin
//#UC START# *4C7E4B830292_4C7E4A45018F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7E4B830292_4C7E4A45018F_impl*
end;//TPrimUnderControlOptionsForm.Add

procedure TPrimUnderControlOptionsForm.CreateList;
//#UC START# *4C7E4BA000A6_4C7E4A45018F_var*
//#UC END# *4C7E4BA000A6_4C7E4A45018F_var*
begin
//#UC START# *4C7E4BA000A6_4C7E4A45018F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7E4BA000A6_4C7E4A45018F_impl*
end;//TPrimUnderControlOptionsForm.CreateList

procedure TPrimUnderControlOptionsForm.Sort;
//#UC START# *4C7E4BB800D4_4C7E4A45018F_var*
//#UC END# *4C7E4BB800D4_4C7E4A45018F_var*
begin
//#UC START# *4C7E4BB800D4_4C7E4A45018F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7E4BB800D4_4C7E4A45018F_impl*
end;//TPrimUnderControlOptionsForm.Sort

procedure TPrimUnderControlOptionsForm.ClearAllStatus;
//#UC START# *4C7E4BD301B7_4C7E4A45018F_var*
//#UC END# *4C7E4BD301B7_4C7E4A45018F_var*
begin
//#UC START# *4C7E4BD301B7_4C7E4A45018F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7E4BD301B7_4C7E4A45018F_impl*
end;//TPrimUnderControlOptionsForm.ClearAllStatus

procedure TPrimUnderControlOptionsForm.Open;
//#UC START# *4C7E4C3001B6_4C7E4A45018F_var*
//#UC END# *4C7E4C3001B6_4C7E4A45018F_var*
begin
//#UC START# *4C7E4C3001B6_4C7E4A45018F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7E4C3001B6_4C7E4A45018F_impl*
end;//TPrimUnderControlOptionsForm.Open

procedure TPrimUnderControlOptionsForm.ClearStatus;
//#UC START# *4C7E4C470330_4C7E4A45018F_var*
//#UC END# *4C7E4C470330_4C7E4A45018F_var*
begin
//#UC START# *4C7E4C470330_4C7E4A45018F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7E4C470330_4C7E4A45018F_impl*
end;//TPrimUnderControlOptionsForm.ClearStatus

{$If NOT Defined(NoVCM)}
procedure TPrimUnderControlOptionsForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4C7E4A45018F_var*
//#UC END# *49803F5503AA_4C7E4A45018F_var*
begin
//#UC START# *49803F5503AA_4C7E4A45018F_impl*
 inherited;
 f_SortTypeMap := nsIntegerMapManager.Map[imap_UnderControlSortType];
//#UC END# *49803F5503AA_4C7E4A45018F_impl*
end;//TPrimUnderControlOptionsForm.DoInit
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimUnderControlOptionsForm.ShowChanges;
 {* Показать изменения }
//#UC START# *4DD1260D02D1_4C7E4A45018F_var*
//#UC END# *4DD1260D02D1_4C7E4A45018F_var*
begin
//#UC START# *4DD1260D02D1_4C7E4A45018F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DD1260D02D1_4C7E4A45018F_impl*
end;//TPrimUnderControlOptionsForm.ShowChanges

procedure TPrimUnderControlOptionsForm.ClearFields;
begin
 f_SortTypeMap := nil;
 inherited;
end;//TPrimUnderControlOptionsForm.ClearFields

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimUnderControlOptionsForm);
 {* Регистрация PrimUnderControlOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
