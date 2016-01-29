unit TreeAttribute_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/LiteSearch/Forms/TreeAttribute_Form.pas"
// �����: 19.01.2009 14:34
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 ������� ����������� ���������� �������::SearchLite::View::LiteSearch::TreeAttribute
//
// ����� ������ ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  l3TreeInterfaces,
  SearchInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  vcmExternalInterfaces {a},
  vcmInterfaces {a}
  ;

type
 TTreeAttributeForm = {abstract form} class(TvcmEntityForm, IbsCurrentChangedListener)
  {* ����� ������ ��������� }
 public
 // realized methods
   procedure Process(const aNode: Il3SimpleNode);
     {* ���������� ������� }
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
     {* ��������� �������� ������. ��� ���������� � �������� }
   {$IfEnd} //not NoVCM
 protected
 // protected methods
   procedure CurrentChangedNotification(const aNode: Il3SimpleNode); virtual; abstract;
 end;//TTreeAttributeForm

 TvcmEntityFormRef = TTreeAttributeForm;

implementation

uses
  nsUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

// start class TTreeAttributeForm

procedure TTreeAttributeForm.Process(const aNode: Il3SimpleNode);
//#UC START# *49590D4802EE_4974652502DA_var*
//#UC END# *49590D4802EE_4974652502DA_var*
begin
//#UC START# *49590D4802EE_4974652502DA_impl*
 CurrentChangedNotification(aNode);
//#UC END# *49590D4802EE_4974652502DA_impl*
end;//TTreeAttributeForm.Process

{$If not defined(NoVCM)}
procedure TTreeAttributeForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
  const aNew: IvcmViewAreaController);
//#UC START# *497469C90140_4974652502DA_var*
//#UC END# *497469C90140_4974652502DA_var*
begin
//#UC START# *497469C90140_4974652502DA_impl*
 if (anOld <> nil) then
  anOld.Unsubscribe(IbsCurrentChangedListener(Self));
 if (aNew <> nil) then
  aNew.Subscribe(IbsCurrentChangedListener(Self));
//#UC END# *497469C90140_4974652502DA_impl*
end;//TTreeAttributeForm.NotifyDataSourceChanged
{$IfEnd} //not NoVCM

initialization
{$If not defined(NoScripts)}
// ����������� TreeAttribute
 TtfwClassRef.Register(TTreeAttributeForm);
{$IfEnd} //not NoScripts

end.