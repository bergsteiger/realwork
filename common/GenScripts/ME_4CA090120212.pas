unit QFLikeTextLoad_Form;
 {* ����� ��� ������ � �� }

// ������: "w:\common\components\gui\Garant\Daily\Forms\QFLikeTextLoad_Form.pas"
// ���������: "VCMForm"

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , PrimTextLoad_Form
 , evQueryCardInt
 , evTextSource
 , evQueryCardEditor
 , evCustomTextSource
 , evCustomEditor
 , vcmInterfaces
;

const
 fm_QFLikeTextLoadForm: TvcmFormDescriptor = (rFormID : (rName : 'QFLikeTextLoadForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TQFLikeTextLoadForm }

type
 QFLikeTextLoadFormDef = interface
  {* ������������� ����� QFLikeTextLoad }
  ['{41C944FD-8129-43F8-89E8-75E7D231D870}']
 end;//QFLikeTextLoadFormDef

 TQFLikeTextLoadForm = {final} class(TPrimTextLoadForm, QFLikeTextLoadFormDef)
  {* ����� ��� ������ � �� }
  private
   f_QueryCard: IevQueryCard;
   f_TextSource: TevTextSource;
    {* ���� ��� �������� TextSource }
   f_Text: TevQueryCardEditor;
    {* ���� ��� �������� Text }
  protected
   function pm_GetTextSource: TevCustomTextSource; override;
   function pm_GetText: TevCustomEditor; override;
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   procedure InitControls; override;
    {* ��������� ������������� ���������. ��� ���������� � �������� }
  public
   procedure AfterLoad; override;
  public
   property TextSource: TevTextSource
    read f_TextSource;
   property Text: TevQueryCardEditor
    read f_Text;
 end;//TQFLikeTextLoadForm
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3StringIDEx
 , evQueryDocumentContainer
 , evControlContainerEX
 , nevTools
 , l3InterfacesMisc
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , QFLikeTextLoadKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ������������ ������ ut_QFLikeTextLoadLocalConstants }
 str_ut_QFLikeTextLoadCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_QFLikeTextLoadCaption'; rValue : '����� ��� ������ � ��');
  {* ��������� ����������������� ���� "����� ��� ������ � ��" }

function TQFLikeTextLoadForm.pm_GetTextSource: TevCustomTextSource;
//#UC START# *4C9B21D20187_4CA090120212get_var*
//#UC END# *4C9B21D20187_4CA090120212get_var*
begin
//#UC START# *4C9B21D20187_4CA090120212get_impl*
 Result := TextSource;
//#UC END# *4C9B21D20187_4CA090120212get_impl*
end;//TQFLikeTextLoadForm.pm_GetTextSource

function TQFLikeTextLoadForm.pm_GetText: TevCustomEditor;
//#UC START# *4C9B21E400A4_4CA090120212get_var*
//#UC END# *4C9B21E400A4_4CA090120212get_var*
begin
//#UC START# *4C9B21E400A4_4CA090120212get_impl*
 Result := Text;
//#UC END# *4C9B21E400A4_4CA090120212get_impl*
end;//TQFLikeTextLoadForm.pm_GetText

procedure TQFLikeTextLoadForm.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_4CA090120212_var*
//#UC END# *479731C50290_4CA090120212_var*
begin
//#UC START# *479731C50290_4CA090120212_impl*
 inherited;
 f_QueryCard := nil;
//#UC END# *479731C50290_4CA090120212_impl*
end;//TQFLikeTextLoadForm.Cleanup

procedure TQFLikeTextLoadForm.InitControls;
 {* ��������� ������������� ���������. ��� ���������� � �������� }
//#UC START# *4A8E8F2E0195_4CA090120212_var*
//#UC END# *4A8E8F2E0195_4CA090120212_var*
begin
//#UC START# *4A8E8F2E0195_4CA090120212_impl*
 inherited;
 f_TextSource.DocumentContainer := TevQueryDocumentContainer.Make;
//#UC END# *4A8E8F2E0195_4CA090120212_impl*
end;//TQFLikeTextLoadForm.InitControls

procedure TQFLikeTextLoadForm.AfterLoad;
//#UC START# *4F15435202B5_4CA090120212_var*
var
 l_Cont: InevQueryDocumentContainer;
//#UC END# *4F15435202B5_4CA090120212_var*
begin
//#UC START# *4F15435202B5_4CA090120212_impl*
 f_QueryCard := TevControlContainerEX.Make;
 if l3IOk(f_TextSource.DocumentContainer.QueryInterface(InevQueryDocumentContainer, l_Cont)) then
  f_QueryCard.LinkView(l_Cont);
//#UC END# *4F15435202B5_4CA090120212_impl*
end;//TQFLikeTextLoadForm.AfterLoad

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TQFLikeTextLoadForm);
 {* ����������� QFLikeTextLoad }
{$IfEnd} // NOT Defined(NoScripts)
 fm_QFLikeTextLoadForm.SetFactory(TQFLikeTextLoadForm.Make);
 {* ����������� ������� ����� QFLikeTextLoad }
 str_ut_QFLikeTextLoadCaption.Init;
 {* ������������� str_ut_QFLikeTextLoadCaption }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
