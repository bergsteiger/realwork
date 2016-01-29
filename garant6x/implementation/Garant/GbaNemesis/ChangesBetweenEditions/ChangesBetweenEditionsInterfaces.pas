unit ChangesBetweenEditionsInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ChangesBetweenEditions$Domain"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/ChangesBetweenEditions/ChangesBetweenEditionsInterfaces.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ControllerInterfaces::Category>> F1 ���������������� �������::ChangesBetweenEditions::ChangesBetweenEditions$Domain::ChangesBetweenEditionsInterfaces
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
  DocumentUnit
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  nevTools,
  DocumentAndListInterfaces,
  DocumentInterfaces,
  vcmControllers {a}
  ;

(*
 MnsEditionsHolder = PureMixIn
   function Get_RightEdition: IDocument;
   function Get_LeftEdition: IDocument;
   property RightEdition: IDocument
     read Get_RightEdition;
     {* ������ �������� }
   property LeftEdition: IDocument
     read Get_LeftEdition;
     {* ����� �������� }
 end;//MnsEditionsHolder
*)

type
 IdsChangesBetweenEditions = interface(IvcmViewAreaController)
   ['{2D74CBC5-124E-4777-A6CA-891E3037761E}']
   function Get_DocumentContainer: InevDocumentContainer;
   property DocumentContainer: InevDocumentContainer
     read Get_DocumentContainer;
  // MdeDocInfoProvider
   function pm_GetDocInfo: IdeDocInfo;
   property DocInfo: IdeDocInfo
     read pm_GetDocInfo;
  // MnsEditionsHolder
   function Get_RightEdition: IDocument;
   function Get_LeftEdition: IDocument;
   property RightEdition: IDocument
     read Get_RightEdition;
     {* ������ �������� }
   property LeftEdition: IDocument
     read Get_LeftEdition;
     {* ����� �������� }
 end;//IdsChangesBetweenEditions

 InsChangesBetweenEditionsInfo = interface(IUnknown)
   ['{66611345-5B71-4A0D-863D-C2903B8296A9}']
   function Get_DiffProvider: IDiffDocDataProvider;
   property DiffProvider: IDiffDocDataProvider
     read Get_DiffProvider;
  // MnsEditionsHolder
   function Get_RightEdition: IDocument;
   function Get_LeftEdition: IDocument;
   property RightEdition: IDocument
     read Get_RightEdition;
     {* ������ �������� }
   property LeftEdition: IDocument
     read Get_LeftEdition;
     {* ����� �������� }
 end;//InsChangesBetweenEditionsInfo

 IsdsChangesBetweenEditionsData = interface(IvcmData)
   ['{840AD10B-834F-49F5-B4BC-521EE38DB3AA}']
   function Get_Info: InsChangesBetweenEditionsInfo;
   property Info: InsChangesBetweenEditionsInfo
     read Get_Info;
 end;//IsdsChangesBetweenEditionsData

 IsdsChangesBetweenEditions = interface(IvcmUseCaseController{, IsdsPrimDocument, IsdsEditionsHolder})
  {* ��������� ��� }
   ['{CEB84047-C17B-48F3-BEA2-191D90F3BBE6}']
   function pm_GetChanges: IdsChangesBetweenEditions;
   property Changes: IdsChangesBetweenEditions
     read pm_GetChanges;
  // ������ �������������� � ����������� �����������
   function As_IsdsPrimDocument: IsdsPrimDocument;
   function As_IsdsEditionsHolder: IsdsEditionsHolder;
 end;//IsdsChangesBetweenEditions
{$IfEnd} //not Admin AND not Monitorings

implementation

end.