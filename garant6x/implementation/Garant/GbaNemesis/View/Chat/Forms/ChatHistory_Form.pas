unit ChatHistory_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: �������� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Chat/Forms/ChatHistory_Form.pas"
// �����: 2009/07/28 06:34:54
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 ���������� ��������::Chat::View::Chat::BaseChat::ChatHistory
//
// ������� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  BaseHistoryWindow_Form
  {$If defined(Nemesis)}
  ,
  nscChatMemo
  {$IfEnd} //Nemesis
  ,
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
const
    { ChatHistoryIDs }
   fm_ChatHistoryForm : TvcmFormDescriptor = (rFormID : (rName : 'ChatHistoryForm'; rID : 0); rFactory : nil);
    { ������������� ����� TChatHistoryForm }

type
 ChatHistoryFormDef = interface(IUnknown)
  {* ������������� ����� ChatHistory }
   ['{5B6E40C6-04D1-47E4-B97A-0C7AB1B3D1F9}']
 end;//ChatHistoryFormDef

  TChatHistoryForm = {final form} class(TBaseHistoryWindowForm, ChatHistoryFormDef)
   {* ������� ��������� }
  Entities : TvcmEntities;
  end;//TChatHistoryForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$R *.DFM}

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  ChatHistoryKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ChatHistory
 TtfwClassRef.Register(TChatHistoryForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// ����������� ������� ����� ChatHistory
 fm_ChatHistoryForm.SetFactory(TChatHistoryForm.Make);
{$IfEnd} //not Admin AND not Monitorings

end.