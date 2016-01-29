unit CommonDictionInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "CommonDiction"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/CommonDiction/CommonDictionInterfaces.pas"
// �����: 20.11.2008 13:40
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ControllerInterfaces::Category>> F1 Core::Common::CommonDiction::CommonDictionInterfaces
//
// ���������� ����������� �������
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
  DynamicTreeUnit,
  l3Interfaces,
  l3TreeInterfaces
  {$If defined(Nemesis)}
  ,
  nscNewInterfaces
  {$IfEnd} //Nemesis
  ,
  DocumentAndListInterfaces,
  TreeInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  QueryCardInterfaces,
  DocumentInterfaces,
  BaseDocumentWithAttributesInterfaces,
  vcmInterfaces {a}
  ;

type
 TnsDictionKind = (
   ns_dkDiction
 , ns_dkMedic
 , ns_dkDayTips
 );//TnsDictionKind

 IbsCommonDictionListener = interface(Il3Notify)
  {* ��������� ������� ������ ������� ����� ������ ������� }
   ['{BA1D839D-E310-4DFA-BC84-B2C940953694}']
   procedure CurrentUpdated;
     {* ������� �������� ���������� }
 end;//IbsCommonDictionListener

 IdeCommonDiction = interface(IdeDocInfo)
  {* ������ ��� ������ ������� }
   ['{10004A7E-6C16-48A3-B843-E8F957F1A586}']
   function pm_GetContext: Il3CString;
   property Context: Il3CString
     read pm_GetContext;
 end;//IdeCommonDiction

 IdCommonDiction = interface(IdBaseDocumentWithAttributes)
   ['{4565D975-8C33-4E37-9E98-2FE4D005DA2F}']
   function pm_GetCurrentNode: INodeBase;
   procedure pm_SetCurrentNode(const aValue: INodeBase);
   function pm_GetDsContentsRef: IvcmFormDataSourceRef;
   property CurrentNode: INodeBase
     read pm_GetCurrentNode
     write pm_SetCurrentNode;
   property dsContentsRef: IvcmFormDataSourceRef
     read pm_GetDsContentsRef;
     {* ������ �� "������ ����������" }
 end;//IdCommonDiction

 IdsChild = interface(IvcmViewAreaController)
   ['{8EAC624A-FE2B-4D81-A453-6F995C5ED785}']
 end;//IdsChild

 IdsCommonDiction = interface(IdsSimpleTree)
  {* ���������� ������� }
   ['{7B742BB0-94F2-4DD7-91B0-68DB3F7CFD1D}']
   function pm_GetContext: Il3CString;
   function Get_ContextFilterState: InscContextFilterState;
   procedure Set_ContextFilterState(const aValue: InscContextFilterState);
   function Get_DictionKind: TnsDictionKind;
   function MakeCurrentIndex(const aTree: Il3SimpleTree): Integer;
     {* �������� ������� ����. �������, ��� ���������� ������������? }
   property Context: Il3CString
     read pm_GetContext;
   property ContextFilterState: InscContextFilterState
     read Get_ContextFilterState
     write Set_ContextFilterState;
   property DictionKind: TnsDictionKind
     read Get_DictionKind;
 end;//IdsCommonDiction

 IsdsCommonDiction = interface(IsdsBaseDocumentWithAttributes)
  {* ���������� ������� }
   ['{DC1DB35E-8793-4D82-87CE-97A2C50A25CF}']
   function pm_GetDsSaveLoad: IdsSaveLoad;
   function pm_GetDsChild: IdsChild;
   function pm_GetDsContents: IdsCommonDiction;
   function pm_GetdsContentsRef: IvcmViewAreaControllerRef;
   function Get_CurrentNode: INodeBase;
   procedure Set_CurrentNode(const aValue: INodeBase);
   function Get_DeCommonDiction: IdeCommonDiction;
   property dsSaveLoad: IdsSaveLoad
     read pm_GetDsSaveLoad;
   property dsChild: IdsChild
     read pm_GetDsChild;
   property dsContents: IdsCommonDiction
     read pm_GetDsContents;
     {* ������ ���������� }
   property dsContentsRef: IvcmViewAreaControllerRef
     read pm_GetdsContentsRef;
     {* ������ �� "������ ����������" }
   property CurrentNode: INodeBase
     read Get_CurrentNode
     write Set_CurrentNode;
   property deCommonDiction: IdeCommonDiction
     read Get_DeCommonDiction;
 end;//IsdsCommonDiction
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

end.