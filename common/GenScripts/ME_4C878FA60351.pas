unit PrimContentsOptions_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimContentsOptions_Form.pas"
// ���������: "VCMForm"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimContents_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Text_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_F1Specific_Controls
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimContentsOptionsForm = class(TPrimContentsForm)
  protected
   {$If NOT Defined(NoVCM)}
   procedure EntitiesInited; override;
    {* ���������� ����� ���� ��� ��� �������� ���������������� }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   {$If NOT Defined(NoVCM)}
   procedure Cut; override;
    {* �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Print; override;
    {* ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure PrintDialog; override;
    {* ������... }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure PrintPreview; override;
    {* ��������������� �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ToMSWord; override;
    {* ������� � Word }
   {$If NOT Defined(NoVCM)}
   procedure Paste; override;
    {* ������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure SelectAll; override;
    {* �������� �� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Deselect; override;
    {* ����� ��������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure CollapseAll; override;
    {* �������� ��� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Wrap; override;
    {* ������� �� ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Copy; override;
    {* ���������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Delete; override;
    {* ������� }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure GetCorrespondentList; override;
   procedure GetRespondentList; override;
   procedure GetTypedCorrespondentList; override;
   procedure GetTypedRespondentList; override;
   procedure AddBookmark; override;
    {* ���������� �������� �� �������� }
   procedure ToMSWord; override;
   procedure PrintDialog; override;
   procedure Copy; override;
   procedure Print; override;
 end;//TPrimContentsOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , afwFacade
 , nevTools
 , nsExternalObjectPrim
 , l3Stream
 , k2CustomFileGenerator
 , l3BaseStream
 , l3Interfaces
 , nsTypes
 , nsToMSWordOp
 , nsTrialSupport
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , l3String
 , nsFolders
 , l3Types
 , evdTypes
 , DocumentUnit
 , k2TagGen
 , nsExternalObjectModelPart
 {$If NOT Defined(NoVCM)}
 , vcmRepOperationsCollectionItem
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
procedure TPrimContentsOptionsForm.Cut;
 {* �������� }
//#UC START# *4951285702E1_4C878FA60351_var*
//#UC END# *4951285702E1_4C878FA60351_var*
begin
//#UC START# *4951285702E1_4C878FA60351_impl*
 !!! Needs to be implemented !!!
//#UC END# *4951285702E1_4C878FA60351_impl*
end;//TPrimContentsOptionsForm.Cut
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimContentsOptionsForm.Print;
 {* ������ }
//#UC START# *49521D8E0295_4C878FA60351_var*
//#UC END# *49521D8E0295_4C878FA60351_var*
begin
//#UC START# *49521D8E0295_4C878FA60351_impl*
 !!! Needs to be implemented !!!
//#UC END# *49521D8E0295_4C878FA60351_impl*
end;//TPrimContentsOptionsForm.Print
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimContentsOptionsForm.PrintDialog;
 {* ������... }
//#UC START# *495220DE0298_4C878FA60351_var*
//#UC END# *495220DE0298_4C878FA60351_var*
begin
//#UC START# *495220DE0298_4C878FA60351_impl*
 !!! Needs to be implemented !!!
//#UC END# *495220DE0298_4C878FA60351_impl*
end;//TPrimContentsOptionsForm.PrintDialog
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimContentsOptionsForm.PrintPreview;
 {* ��������������� �������� }
//#UC START# *495220F2033A_4C878FA60351_var*
//#UC END# *495220F2033A_4C878FA60351_var*
begin
//#UC START# *495220F2033A_4C878FA60351_impl*
 !!! Needs to be implemented !!!
//#UC END# *495220F2033A_4C878FA60351_impl*
end;//TPrimContentsOptionsForm.PrintPreview
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimContentsOptionsForm.ToMSWord;
 {* ������� � Word }
//#UC START# *495238EB0160_4C878FA60351_var*
//#UC END# *495238EB0160_4C878FA60351_var*
begin
//#UC START# *495238EB0160_4C878FA60351_impl*
 !!! Needs to be implemented !!!
//#UC END# *495238EB0160_4C878FA60351_impl*
end;//TPrimContentsOptionsForm.ToMSWord

{$If NOT Defined(NoVCM)}
procedure TPrimContentsOptionsForm.Paste;
 {* ������� }
//#UC START# *49EDFA3701B0_4C878FA60351_var*
//#UC END# *49EDFA3701B0_4C878FA60351_var*
begin
//#UC START# *49EDFA3701B0_4C878FA60351_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EDFA3701B0_4C878FA60351_impl*
end;//TPrimContentsOptionsForm.Paste
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimContentsOptionsForm.SelectAll;
 {* �������� �� }
//#UC START# *49EE01AA02BE_4C878FA60351_var*
//#UC END# *49EE01AA02BE_4C878FA60351_var*
begin
//#UC START# *49EE01AA02BE_4C878FA60351_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EE01AA02BE_4C878FA60351_impl*
end;//TPrimContentsOptionsForm.SelectAll
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimContentsOptionsForm.Deselect;
 {* ����� ��������� }
//#UC START# *49EE01BC022E_4C878FA60351_var*
//#UC END# *49EE01BC022E_4C878FA60351_var*
begin
//#UC START# *49EE01BC022E_4C878FA60351_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EE01BC022E_4C878FA60351_impl*
end;//TPrimContentsOptionsForm.Deselect
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimContentsOptionsForm.CollapseAll;
 {* �������� ��� }
//#UC START# *4BDAF7A2005C_4C878FA60351_var*
//#UC END# *4BDAF7A2005C_4C878FA60351_var*
begin
//#UC START# *4BDAF7A2005C_4C878FA60351_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDAF7A2005C_4C878FA60351_impl*
end;//TPrimContentsOptionsForm.CollapseAll
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimContentsOptionsForm.Wrap;
 {* ������� �� ������ }
//#UC START# *4BDAF7B803CF_4C878FA60351_var*
//#UC END# *4BDAF7B803CF_4C878FA60351_var*
begin
//#UC START# *4BDAF7B803CF_4C878FA60351_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDAF7B803CF_4C878FA60351_impl*
end;//TPrimContentsOptionsForm.Wrap
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimContentsOptionsForm.Copy;
 {* ���������� }
//#UC START# *4C7D0C7B0185_4C878FA60351_var*
//#UC END# *4C7D0C7B0185_4C878FA60351_var*
begin
//#UC START# *4C7D0C7B0185_4C878FA60351_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D0C7B0185_4C878FA60351_impl*
end;//TPrimContentsOptionsForm.Copy
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimContentsOptionsForm.Delete;
 {* ������� }
//#UC START# *4C7D0CC90052_4C878FA60351_var*
//#UC END# *4C7D0CC90052_4C878FA60351_var*
begin
//#UC START# *4C7D0CC90052_4C878FA60351_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D0CC90052_4C878FA60351_impl*
end;//TPrimContentsOptionsForm.Delete
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimContentsOptionsForm.EntitiesInited;
 {* ���������� ����� ���� ��� ��� �������� ���������������� }
//#UC START# *4AE1948900DE_4C878FA60351_var*
//#UC END# *4AE1948900DE_4C878FA60351_var*
begin
//#UC START# *4AE1948900DE_4C878FA60351_impl*
 Entities.Entities.CheckEntityForControl(en_Edit).Controls.PublishEntity(lstBookmarks, nil);
 Entities.Entities.CheckEntityForControl(en_Edit).Controls.PublishEntity(lstComments, nil);
 inherited;
//#UC END# *4AE1948900DE_4C878FA60351_impl*
end;//TPrimContentsOptionsForm.EntitiesInited
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimContentsOptionsForm.GetCorrespondentList;
//#UC START# *4C2AEDB3003B_4C878FA60351_var*
//#UC END# *4C2AEDB3003B_4C878FA60351_var*
begin
//#UC START# *4C2AEDB3003B_4C878FA60351_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C2AEDB3003B_4C878FA60351_impl*
end;//TPrimContentsOptionsForm.GetCorrespondentList

procedure TPrimContentsOptionsForm.GetRespondentList;
//#UC START# *4C2AEDC503CC_4C878FA60351_var*
//#UC END# *4C2AEDC503CC_4C878FA60351_var*
begin
//#UC START# *4C2AEDC503CC_4C878FA60351_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C2AEDC503CC_4C878FA60351_impl*
end;//TPrimContentsOptionsForm.GetRespondentList

procedure TPrimContentsOptionsForm.GetTypedCorrespondentList;
//#UC START# *4C2AEDDA0335_4C878FA60351_var*
//#UC END# *4C2AEDDA0335_4C878FA60351_var*
begin
//#UC START# *4C2AEDDA0335_4C878FA60351_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C2AEDDA0335_4C878FA60351_impl*
end;//TPrimContentsOptionsForm.GetTypedCorrespondentList

procedure TPrimContentsOptionsForm.GetTypedRespondentList;
//#UC START# *4C2AEDE7028C_4C878FA60351_var*
//#UC END# *4C2AEDE7028C_4C878FA60351_var*
begin
//#UC START# *4C2AEDE7028C_4C878FA60351_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C2AEDE7028C_4C878FA60351_impl*
end;//TPrimContentsOptionsForm.GetTypedRespondentList

procedure TPrimContentsOptionsForm.AddBookmark;
 {* ���������� �������� �� �������� }
//#UC START# *4C3B1AEA0127_4C878FA60351_var*
//#UC END# *4C3B1AEA0127_4C878FA60351_var*
begin
//#UC START# *4C3B1AEA0127_4C878FA60351_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B1AEA0127_4C878FA60351_impl*
end;//TPrimContentsOptionsForm.AddBookmark

procedure TPrimContentsOptionsForm.ToMSWord;
//#UC START# *4C3B1AFB0270_4C878FA60351_var*
//#UC END# *4C3B1AFB0270_4C878FA60351_var*
begin
//#UC START# *4C3B1AFB0270_4C878FA60351_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B1AFB0270_4C878FA60351_impl*
end;//TPrimContentsOptionsForm.ToMSWord

procedure TPrimContentsOptionsForm.PrintDialog;
//#UC START# *4C3B1B0F0237_4C878FA60351_var*
//#UC END# *4C3B1B0F0237_4C878FA60351_var*
begin
//#UC START# *4C3B1B0F0237_4C878FA60351_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B1B0F0237_4C878FA60351_impl*
end;//TPrimContentsOptionsForm.PrintDialog

procedure TPrimContentsOptionsForm.Copy;
//#UC START# *4C3B1B1D003C_4C878FA60351_var*
//#UC END# *4C3B1B1D003C_4C878FA60351_var*
begin
//#UC START# *4C3B1B1D003C_4C878FA60351_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B1B1D003C_4C878FA60351_impl*
end;//TPrimContentsOptionsForm.Copy

procedure TPrimContentsOptionsForm.Print;
//#UC START# *4C3B241401AA_4C878FA60351_var*
//#UC END# *4C3B241401AA_4C878FA60351_var*
begin
//#UC START# *4C3B241401AA_4C878FA60351_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B241401AA_4C878FA60351_impl*
end;//TPrimContentsOptionsForm.Print

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimContentsOptionsForm);
 {* ����������� PrimContentsOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
