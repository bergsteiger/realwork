unit NOT_COMPLETED_FoldersInterfaces;
 {* ���������� ��� ������ � ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Folders\NOT_COMPLETED_FoldersInterfaces.pas"
// ���������: "ControllerInterfaces"
// ������� ������: "FoldersInterfaces" MUID: (492192300095)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3Interfaces
 , l3TreeInterfaces
 , SimpleListInterfaces
 , FoldersDomainInterfaces
 , ConsultationDomainInterfaces
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 IdsFolderElement = interface(IvcmViewAreaController)
  {* ������� ����� }
  ['{548ADA55-9255-4D0E-B131-BEF738D30194}']
  function pm_GetSaveObject: IdeSaveObject;
  property SaveObject: IdeSaveObject
   read pm_GetSaveObject;
   {* ����������� ������ }
 end;//IdsFolderElement

 EdsConsultationInProcess = class(Exception)
  {* ������������ ��������� � �������� ��������� }
 end;//EdsConsultationInProcess

 EdsConsultationSending = class(Exception)
  {* ������������ ������������ � ������ ������������ }
 end;//EdsConsultationSending

 EdsOldRefusalConsultationFormat = class(Exception)
  {* ������������ ��������� �������� ������������ }
 end;//EdsOldRefusalConsultationFormat

 IdsFoldersTree = interface(IvcmViewAreaController)
  {* ������ ����� }
  ['{CC61DE67-AEBA-462A-AF71-619D900AD879}']
  procedure CanBeOpen(const aNode: Il3SimpleNode); { can raise EdsConsultationInProcess, EdsConsultationSending, EdsOldRefusalConsultationFormat }
   {* ����� �� ������� �������.
           ��������� ����������:
             - EdsConsultationInProcess;
             - EdsConsultationSending; }
  function CanBeOpenAsConsultation(const aNode: Il3SimpleNode): Boolean;
   {* ���������� ����������� �������� ������� ��� ��������� }
  function CanGiveMarkOnConsultation(const aNode: Il3SimpleNode): Boolean;
   {* ���������� ����������� ������ �� ������������ }
  function CanDelete(const aNode: Il3SimpleNode): Boolean;
   {* ������ ������� }
  function IsConsultation(const aNode: Il3SimpleNode): Boolean;
   {* ���� �������� ������������� }
  procedure DeleteConsultation(const aNode: Il3SimpleNode);
   {* ������� ������������ }
  function CanImportConsultation(const aNode: Il3SimpleNode): Boolean;
   {* ����� �� ������������� ������������. �������� ������ ���� aNode =
           "��� ������������" }
  procedure ImportConsultation(const aFileName: Tl3WString);
   {* ������������� ������������.
           ����������:
           - EAccessDenied;
           - EInvalidXMLType; }
  function CanExportForIntegration(const aNode: Il3SimpleNode): Boolean;
   {* ����� �� �������������� ���������� ����� �� ������������ }
  procedure ExportForIntegration(const aNode: Il3SimpleNode);
   {* �������������� ������������.
           ����������:
           - EInvalidEntityType; }
  function CanExportToXML(const aNode: Il3SimpleNode): Boolean;
   {* ����� �� �������������� ���� �� ����� }
  procedure ExportToXML(const aNode: Il3SimpleNode;
   const aFileName: Tl3WString);
   {* �������������� ���� �� �����.
           ����������:
           - EAccessDenied;
           - EInvalidEntityType; }
  function CanImportFromXML(const aNode: Il3SimpleNode): Boolean;
   {* ����� �� ������������� ���� � ����� }
  procedure ImportFromXML(const aNode: Il3SimpleNode;
   const aFileName: Tl3WString);
   {* ������������� ���� � �����.
           ����������:
           - EAccessDenied;
           - EInvalidEntityType; }
 end;//IdsFoldersTree

 IdsFolders = interface(IvcmViewAreaController)
  {* ����� }
  ['{5ADA9092-6221-45BE-9FD5-6C946A72ED72}']
 end;//IdsFolders

 IsdsFolders = interface(IvcmUseCaseController)
  {* ��������� ����� }
  ['{DF21D078-F373-4C50-A25C-C43CC69116A5}']
  function pm_GetdsFolders: IdsFolders;
  function pm_GetdsFoldersTree: IdsFoldersTree;
  function pm_GetdsFolderElement: IdsFolderElement;
  property dsFolders: IdsFolders
   read pm_GetdsFolders;
   {* ������ ������ ����� }
  property dsFoldersTree: IdsFoldersTree
   read pm_GetdsFoldersTree;
   {* ������ ������ ������ ����� }
  property dsFolderElement: IdsFolderElement
   read pm_GetdsFolderElement;
   {* ������ ������ ������� ����� }
 end;//IsdsFolders
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(EdsConsultationInProcess));
 {* ����������� ���� EdsConsultationInProcess }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(EdsConsultationSending));
 {* ����������� ���� EdsConsultationSending }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(EdsOldRefusalConsultationFormat));
 {* ����������� ���� EdsOldRefusalConsultationFormat }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
