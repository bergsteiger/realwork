unit Document_Strange_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document_Strange_Controls.pas"
// �����: 03.02.2009 19:46
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 ������ � ���������� � ������� ����������::Document::View::Strange
//
// �������� ��������, �� ���������� ���� ����������� �������
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
  DocumentUnit,
  nevBase,
  l3TreeInterfaces,
  bsTypes,
  eeInterfaces,
  DocumentAndListInterfaces,
  DocumentDomainInterfaces,
  Base_Operations_Editions_Controls,
  BaseSearchInterfaces,
  l3CProtoObject,
  F1TagDataProviderInterface
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  vcmExternalInterfaces {a}
  ;

(* Editions = operations
  {* �������� }
   ['{A6F39708-1626-4BB5-81F1-1E0A6833BA8A}']
   query SetCurrent(const aDocument: IDocument);
     {* ���������� ������� }
 end;//Editions*)

(* System = operations
   ['{228E4504-56DD-46D0-A0EE-06EDDEFAFAC4}']
   query TimeMachineStateChange(aStayInCurrentRedaction: Boolean = false);
 end;//System*)

(* Selection = operations
  {* ���������� �������� }
   ['{C93E529A-A41A-4119-AA50-C940BE30C466}']
   operation InsertHyperlink; has states;
     {* ��������� ������... }
      ModifyLink = state
       { �������� ������... }
      end;//ModifyLink
   operation FindInDict;
     {* ����� � �������� ������� }
 end;//Selection*)

(* Contents = operations({, ������ � ����������� ���������})
  {* ��������� ��������� }
   ['{B7472118-E9E6-43B2-80B6-D58C4C8E71B5}']
   query SetCurrent(aSub: Integer);
   query MoveCurrent(aSub: Integer;
    aDown: Boolean);
   query HasUserComments: Boolean;
     {* ���� �� � ���������� ���������������� ����������� }
   query HasBookmarks: Boolean;
     {* ���� �� � ���������� �������� }
   query ToggleContentsVisibility: Boolean;
     {* ����������� ��������� ���������� ���� ����������, ���������� true ���� ������������ ������� }
   query IsContentsVisible: Boolean;
     {* ���������� ��������� ��������� ���������� ���� ���������� }
 end;//Contents*)

(* Warning = operations
   ['{CCF7FF92-3276-4E9C-84C2-20DBD788757B}']
   FormActivate BecomeActive(aSubID: TnsWarningSub);
   FormActivate SwitchActive(aSubID: TnsWarningSub);
 end;//Warning*)

(* Picture = operations
  {* �������� }
   ['{9D36DCF5-F264-4E46-9F7C-1A3AB083D16B}']
   query InitNewContent(const aData: InsLinkedObjectData);
 end;//Picture*)

(* DocumentBlock = operations
  {* ����� ���������� }
   ['{B114218A-54E8-4D4B-8DC8-46F60B119911}']
   operation GetTypedCorrespondentList; has states;
     {* ������ �� �������� (��� ����������) }
      InText = state
       { ������ �� ��������: }
      end;//InText
   operation PrintPreview;
   operation Select;
   operation GetSimilarDocsToBlock;
   operation GetCorrespondentList;
   operation GetRespondentList;
   operation GetTypedCorrespondentList; has states;
   operation GetTypedRespondentList;
   operation ToMSWord;
   operation PrintDialog;
   operation Copy;
   operation Print;
 end;//DocumentBlock*)

(* DocumentBlockHeader = operations
  {* ����� ���������� - ��������� �������� }
   ['{7F25AD43-F525-485B-855E-785FD113AC84}']
   operation UserCR1; has states;
     {* ���������������� ������ �� �������� (������ �� ���������) 1 }
      Corr = state
      end;//Corr
   operation UserCR2; has states;
     {* ���������������� ������ �� �������� (������ �� ���������) 2 }
      Corr = state
      end;//Corr
   operation UserCR1; has states;
   operation UserCR2; has states;
   operation GetTypedCorrespondentList;
   operation AddBookmark;
   operation ToMSWord;
   operation Print;
   operation PrintDialog;
 end;//DocumentBlockHeader*)

(* WarnOnControl = operations
  {* �������������� (�� ��������) }
   ['{CBF9A773-A0D9-4E66-8D27-03086A04BBC1}']
   operation ClearStatusSettings;
     {* ������ ������ ������� "�������" }
   operation ShowChanges;
     {* �������� ��������� }
   operation ClearStatus;
     {* �������� ������ "�������" }
 end;//WarnOnControl*)

(* TasksPanel = operations
   ['{5E52AC48-1B2E-49CB-A8D9-D8DDDD7D90C5}']
   operation TimeMachineOnOff; has states;
     {* �������� ������ ������� � ����������� ����\��������� ������ ������� }
      On = state
       { �������� ������ ������� }
      end;//On
      Off = state
       { ��������� ������ ������� }
      end;//Off
   operation TimeMachineOnOff; has states;
 end;//TasksPanel*)

(* Document = operations
   ['{23F8DB14-4258-48DF-9FF2-203F18C706DF}']
   operation OpenContentsFrmAct; has states;
     {* ��������� ��������� }
      Drug = state
       { ��������� ��������� }
      end;//Drug
   operation OpenContentsFrmAct; has states;
   operation ShowDocumentPicture;
   operation DocumentSynchroOpenWindow;
   operation DocumentSynchroOpenNewWindow;
   operation DictListOpenFrmAct;
   operation GotoBookmark;
   operation LiteratureListForDictionary;
   operation OpenProducedDrugList;
   operation OpenSimilarDrugList;
 end;//Document*)

(* ExternalObject = operations
   ['{700C3A68-66B7-40F3-963F-3EF77064B337}']
   operation Open;
   operation Save;
 end;//ExternalObject*)

(* WarnRedaction = operations
  {* �������������� � ������������ �������� }
   ['{A85A09ED-8903-46CC-A979-8AA4D7DF0AA9}']
   operation ShowInfo; has states;
     {* �������� ����� �������������� }
      Hide = state
       { ������ ����� �������������� }
      end;//Hide
   operation OpenActualRedaction;
 end;//WarnRedaction*)

(* WarnTimeMachine = operations
  {* �������������� ��� ������ ������� }
   ['{050342A8-34BE-4FE9-A55C-D0A8B72BBFCF}']
   operation ShowInfo; has states;
     {* �������� ����� �������������� }
      Hide = state
       { ������ ����� �������������� }
      end;//Hide
   operation TimeMachineOnOffNew; has states;
     {* ��������/��������� ������ ������� }
      MachineOn = state
       { �������� ������ ������� }
      end;//MachineOn
      MachineOff = state
       { ��������� ������ �������/�������� ���� }
      end;//MachineOff
   operation ShowInfo; has states;
   operation TimeMachineOnOffNew; has states;
 end;//WarnTimeMachine*)

(* WarnJuror = operations
  {* �������������� (�����������) }
   ['{8A3231E2-CF2C-429A-B359-92E439BAEB5E}']
   operation ShowInfo; has states;
     {* �������� ����� �������������� }
      Hide = state
       { ������ ����� �������������� }
      end;//Hide
   operation ShowInfo; has states;
 end;//WarnJuror*)

(* BookmarkIcon = operations
   ['{E8B2D510-80F2-4624-9F50-06806F704FDB}']
   operation Delete;
   operation Edit;
 end;//BookmarkIcon*)

(* UserCommentIcon = operations
   ['{38AF5381-38AB-4BE0-95E5-525102599E7F}']
   query HideShow; has states;
     {* ������/�������� }
      GarantHidden = state
       { �������� ����������� ������� }
      end;//GarantHidden
      GarantShown = state
       { ������ ����������� ������� }
      end;//GarantShown
      UserShown = state
       { ������ ��� ����������� }
      end;//UserShown
      UserHidden = state
       { �������� ��� ����������� }
      end;//UserHidden
      Invisible = state
      end;//Invisible
      VersionShown = state
       { ��������� ���������� �� ���������� ��������� }
      end;//VersionShown
      VersionHidden = state
       { �������� ���������� �� ���������� ��������� }
      end;//VersionHidden
   operation Delete;
   query HideShow; has states;
 end;//UserCommentIcon*)

(* UserComment = operations
   ['{7994534C-BC92-4CA4-A4E0-C77195D0FF88}']
   operation Delete;
 end;//UserComment*)

(* Text = operations
   ['{A13F3C44-940B-4DCA-9A43-DFF92D3DB3B2}']
   operation AddUserComment;
   operation DeleteBookmark;
   operation EditBookmark;
   operation AddBookmark;
   operation OpenNewWindow;
 end;//Text*)

(* Warning = operations
   ['{352B6AED-1E26-4ACA-8854-EF2856A24AE6}']
   operation TimeMachineOffAndReset;
   operation ActualRedaction;
   operation TimeMachineOff;
 end;//Warning*)

(* Reminder = operations
   ['{BC8B3991-5087-4957-847F-143FD9708318}']
   operation RemWarnJuror;
   operation RemWarnTimeMachineOn;
   operation RemWarnRedaction;
   operation RemWarnOnControl;
   operation RemWarnIsAbolished;
   operation RemWarnTimeMachineException;
   operation RemWarnPreActive;
   operation RemWarnTimeMachineWarning;
   operation ViewInactualDocument;
 end;//Reminder*)

(* SynchroView = operations
   ['{D8ACB607-BB2A-4FE0-8B33-C28CCC10B6EF}']
   operation ShowText;
   operation Annotation;
   operation ShowAttributes;
   operation ShowRelated;
   operation ShowUserCRList1;
   operation ShowUserCRList2;
   operation SimilarDocuments;
 end;//SynchroView*)

(* Edition = operations
   ['{E42AE9BC-5391-4907-942F-4D52812F16AD}']
   query OpenNewWindow;
   query OpenNewTab;
 end;//Edition*)

(* Attribute = operations
   ['{5D8337D5-03F3-4B8D-987F-383B63FA9296}']
   operation Copy;
 end;//Attribute*)

(* Picture = operations
  {* �������� }
   ['{CD14874B-2C47-4913-AB6C-16479A056B5B}']
   operation Resize;
   operation Enlarge;
   operation Shrink;
   operation ActualSize;
   operation FitInWIndow;
 end;//Picture*)

(* ContentsValidator = operations
  {* http://mdp.garant.ru/pages/viewpage.action?pageId=259891063 }
   ['{9D26D75D-BD06-45F1-8524-F6DFD1BAD211}']
   query IsDocumentAdornmentsChanged(const aNew: InsDocumentAdornments): Boolean;
 end;//ContentsValidator*)

(* DocumentSubPanel = operations
   ['{49B238E9-0746-4A70-BE5E-5439EAD9EF41}']
   query UpdateSubPanel;
 end;//DocumentSubPanel*)

(* Editions = operations({, ������ �� ������� ��������})
  {* �������� }
   ['{C31D32FF-5A65-46FF-B120-A5137D9FE8AA}']
   operation DoCompareEditions;
     {* �������� �������� }
   operation BuildChangedFragments;
     {* ��������� ����� ��������� }
 end;//Editions*)

(* DocumentBlockBookmarks = operations
  {* �������� �� ����� ���������� }
   ['{50BEBB6A-D0B1-437B-9C36-65B24E771603}']
   operation AddBookmark;
     {* ���������� �������� �� �������� }
 end;//DocumentBlockBookmarks*)

(* IntranetSourcePoint = operations
   ['{6C5E377B-7977-4344-B70B-76D8A738CA5F}']
   query GoToIntranet;
 end;//IntranetSourcePoint*)

(* Picture = operations
  {* �������� }
   ['{FC80F24E-8823-45E6-B775-56CD58D12477}']
   operation Open;
     {* ������� � ������� ���� }
   operation OpenNewWindow;
     {* ������� � ����� ���� }
   operation OpenNewTab;
     {* ������� � ����� ������� }
 end;//Picture*)

(* Document = operations
  {* �������� }
   ['{61D6CD4D-213C-4C2C-AE5D-84A2162659CA}']
   FormActivate ChangesButton;
     {* ��������� � ��������� }
 end;//Document*)

(* SubsPanel = operations
  {* ������ ����� }
   ['{2FFF61ED-5A22-4323-B57C-A3E5B8B03D9D}']
   operation CopySubNumber;
     {* ���������� ������� }
 end;//SubsPanel*)

(* BaseSearchPresentationHolder = operations
   ['{B91322F8-958D-4A93-9E2C-456AA6AB0798}']
   query GetBaseSearchPresentation: InsBaseSearchPresentation;
 end;//BaseSearchPresentationHolder*)

(* Text = operations
   ['{8E6C2FF1-E7C5-47CB-9C45-F01F54222A00}']
   operation SelectWord;
   operation SelectPara;
 end;//Text*)

type
 IEditions_SetCurrent_Params = interface(IUnknown)
  {* ��������� ��� �������� Editions.SetCurrent }
   ['{69481C49-8E84-4A41-BAE4-E419D710DF8C}']
   function Get_Document: IDocument;
   property Document: IDocument
     read Get_Document;
     {* undefined }
 end;//IEditions_SetCurrent_Params

 Op_Editions_SetCurrent = class
  {* ����� ��� ������ �������� Editions.SetCurrent }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    const aDocument: IDocument): Boolean; overload; 
     {* ����� �������� Editions.SetCurrent � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aDocument: IDocument): Boolean; overload; 
     {* ����� �������� Editions.SetCurrent � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aDocument: IDocument): Boolean; overload; 
     {* ����� �������� Editions.SetCurrent � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aDocument: IDocument): Boolean; overload; 
     {* ����� �������� Editions.SetCurrent � ���������� }
 end;//Op_Editions_SetCurrent

 ISystem_TimeMachineStateChange_Params = interface(IUnknown)
  {* ��������� ��� �������� System.TimeMachineStateChange }
   ['{F9F5407A-002A-4696-94D1-DAC349ED07AD}']
   function Get_StayInCurrentRedaction: Boolean;
   property StayInCurrentRedaction: Boolean
     read Get_StayInCurrentRedaction;
     {* undefined }
 end;//ISystem_TimeMachineStateChange_Params

 Op_System_TimeMachineStateChange = class
  {* ����� ��� ������ �������� System.TimeMachineStateChange }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    aStayInCurrentRedaction: Boolean = false): Boolean; overload; 
     {* ����� �������� System.TimeMachineStateChange � �������� }
   class function Call(const aTarget: IvcmAggregate;
    aStayInCurrentRedaction: Boolean = false): Boolean; overload; 
     {* ����� �������� System.TimeMachineStateChange � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    aStayInCurrentRedaction: Boolean = false): Boolean; overload; 
     {* ����� �������� System.TimeMachineStateChange � ����� }
   class function Call(const aTarget: IvcmContainer;
    aStayInCurrentRedaction: Boolean = false): Boolean; overload; 
     {* ����� �������� System.TimeMachineStateChange � ���������� }
   class procedure Broadcast(aStayInCurrentRedaction: Boolean = false);
     {* ����� �������� System.TimeMachineStateChange � ���� ������������������ ��������� }
 end;//Op_System_TimeMachineStateChange

 IContents_SetCurrent_Params = interface(IUnknown)
  {* ��������� ��� �������� Contents.SetCurrent }
   ['{63B60DA6-E67A-4D05-8194-8CBFBC186C14}']
   function Get_Sub: Integer;
   property Sub: Integer
     read Get_Sub;
     {* undefined }
 end;//IContents_SetCurrent_Params

 Op_Contents_SetCurrent = class
  {* ����� ��� ������ �������� Contents.SetCurrent }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    aSub: Integer): Boolean; overload; 
     {* ����� �������� Contents.SetCurrent � �������� }
   class function Call(const aTarget: IvcmAggregate;
    aSub: Integer): Boolean; overload; 
     {* ����� �������� Contents.SetCurrent � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    aSub: Integer): Boolean; overload; 
     {* ����� �������� Contents.SetCurrent � ����� }
   class function Call(const aTarget: IvcmContainer;
    aSub: Integer): Boolean; overload; 
     {* ����� �������� Contents.SetCurrent � ���������� }
 end;//Op_Contents_SetCurrent

 IContents_MoveCurrent_Params = interface(IUnknown)
  {* ��������� ��� �������� Contents.MoveCurrent }
   ['{4F7D3966-D37A-4F3F-B435-413523D01CD7}']
   function Get_Sub: Integer;
   function Get_Down: Boolean;
   property Sub: Integer
     read Get_Sub;
     {* undefined }
   property Down: Boolean
     read Get_Down;
     {* undefined }
 end;//IContents_MoveCurrent_Params

 Op_Contents_MoveCurrent = class
  {* ����� ��� ������ �������� Contents.MoveCurrent }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    aSub: Integer;
    aDown: Boolean): Boolean; overload; 
     {* ����� �������� Contents.MoveCurrent � �������� }
   class function Call(const aTarget: IvcmAggregate;
    aSub: Integer;
    aDown: Boolean): Boolean; overload; 
     {* ����� �������� Contents.MoveCurrent � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    aSub: Integer;
    aDown: Boolean): Boolean; overload; 
     {* ����� �������� Contents.MoveCurrent � ����� }
   class function Call(const aTarget: IvcmContainer;
    aSub: Integer;
    aDown: Boolean): Boolean; overload; 
     {* ����� �������� Contents.MoveCurrent � ���������� }
 end;//Op_Contents_MoveCurrent

 IContents_HasUserComments_Params = interface(IUnknown)
  {* ��������� ��� �������� Contents.HasUserComments }
   ['{B5B7276E-4C38-489E-B8EA-335CAA4DF145}']
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   property ResultValue: Boolean
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//IContents_HasUserComments_Params

 Op_Contents_HasUserComments = class
  {* ����� ��� ������ �������� Contents.HasUserComments }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* ����� �������� Contents.HasUserComments � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* ����� �������� Contents.HasUserComments � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* ����� �������� Contents.HasUserComments � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* ����� �������� Contents.HasUserComments � ���������� }
 end;//Op_Contents_HasUserComments

 IContents_HasBookmarks_Params = interface(IUnknown)
  {* ��������� ��� �������� Contents.HasBookmarks }
   ['{70D89AEC-9A94-460E-BDA6-0E43352E7897}']
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   property ResultValue: Boolean
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//IContents_HasBookmarks_Params

 Op_Contents_HasBookmarks = class
  {* ����� ��� ������ �������� Contents.HasBookmarks }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* ����� �������� Contents.HasBookmarks � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* ����� �������� Contents.HasBookmarks � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* ����� �������� Contents.HasBookmarks � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* ����� �������� Contents.HasBookmarks � ���������� }
 end;//Op_Contents_HasBookmarks

 IContents_ToggleContentsVisibility_Params = interface(IUnknown)
  {* ��������� ��� �������� Contents.ToggleContentsVisibility }
   ['{8F5D6186-6988-42D3-8F65-708CD881074F}']
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   property ResultValue: Boolean
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//IContents_ToggleContentsVisibility_Params

 Op_Contents_ToggleContentsVisibility = class
  {* ����� ��� ������ �������� Contents.ToggleContentsVisibility }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* ����� �������� Contents.ToggleContentsVisibility � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* ����� �������� Contents.ToggleContentsVisibility � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* ����� �������� Contents.ToggleContentsVisibility � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* ����� �������� Contents.ToggleContentsVisibility � ���������� }
 end;//Op_Contents_ToggleContentsVisibility

 IContents_IsContentsVisible_Params = interface(IUnknown)
  {* ��������� ��� �������� Contents.IsContentsVisible }
   ['{E1AC8242-4977-4049-9A09-C907355ED7F6}']
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   property ResultValue: Boolean
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//IContents_IsContentsVisible_Params

 Op_Contents_IsContentsVisible = class
  {* ����� ��� ������ �������� Contents.IsContentsVisible }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* ����� �������� Contents.IsContentsVisible � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* ����� �������� Contents.IsContentsVisible � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* ����� �������� Contents.IsContentsVisible � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* ����� �������� Contents.IsContentsVisible � ���������� }
 end;//Op_Contents_IsContentsVisible

 IWarning_BecomeActive_Params = interface(IUnknown)
  {* ��������� ��� �������� Warning.BecomeActive }
   ['{8C5435DC-692B-4F21-8EEF-D2D096386C0E}']
   function Get_SubID: TnsWarningSub;
   property SubID: TnsWarningSub
     read Get_SubID;
     {* undefined }
 end;//IWarning_BecomeActive_Params

 Op_Warning_BecomeActive = class
  {* ����� ��� ������ �������� Warning.BecomeActive }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    aSubID: TnsWarningSub): Boolean; overload; 
     {* ����� �������� Warning.BecomeActive � �������� }
   class function Call(const aTarget: IvcmAggregate;
    aSubID: TnsWarningSub): Boolean; overload; 
     {* ����� �������� Warning.BecomeActive � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    aSubID: TnsWarningSub): Boolean; overload; 
     {* ����� �������� Warning.BecomeActive � ����� }
   class function Call(const aTarget: IvcmContainer;
    aSubID: TnsWarningSub): Boolean; overload; 
     {* ����� �������� Warning.BecomeActive � ���������� }
 end;//Op_Warning_BecomeActive

 IWarning_SwitchActive_Params = interface(IUnknown)
  {* ��������� ��� �������� Warning.SwitchActive }
   ['{FFE6A34D-8019-458E-A0F2-D2A9FFCE4B84}']
   function Get_SubID: TnsWarningSub;
   property SubID: TnsWarningSub
     read Get_SubID;
     {* undefined }
 end;//IWarning_SwitchActive_Params

 Op_Warning_SwitchActive = class
  {* ����� ��� ������ �������� Warning.SwitchActive }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    aSubID: TnsWarningSub): Boolean; overload; 
     {* ����� �������� Warning.SwitchActive � �������� }
   class function Call(const aTarget: IvcmAggregate;
    aSubID: TnsWarningSub): Boolean; overload; 
     {* ����� �������� Warning.SwitchActive � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    aSubID: TnsWarningSub): Boolean; overload; 
     {* ����� �������� Warning.SwitchActive � ����� }
   class function Call(const aTarget: IvcmContainer;
    aSubID: TnsWarningSub): Boolean; overload; 
     {* ����� �������� Warning.SwitchActive � ���������� }
 end;//Op_Warning_SwitchActive

 IPicture_InitNewContent_Params = interface(IUnknown)
  {* ��������� ��� �������� Picture.InitNewContent }
   ['{CE6432BB-C0B5-4CF2-9078-68E5B203981A}']
   function Get_Data: InsLinkedObjectData;
   property Data: InsLinkedObjectData
     read Get_Data;
     {* undefined }
 end;//IPicture_InitNewContent_Params

 Op_Picture_InitNewContent = class
  {* ����� ��� ������ �������� Picture.InitNewContent }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    const aData: InsLinkedObjectData): Boolean; overload; 
     {* ����� �������� Picture.InitNewContent � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aData: InsLinkedObjectData): Boolean; overload; 
     {* ����� �������� Picture.InitNewContent � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aData: InsLinkedObjectData): Boolean; overload; 
     {* ����� �������� Picture.InitNewContent � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aData: InsLinkedObjectData): Boolean; overload; 
     {* ����� �������� Picture.InitNewContent � ���������� }
 end;//Op_Picture_InitNewContent

 IContentsValidator_IsDocumentAdornmentsChanged_Params = interface(IUnknown)
  {* ��������� ��� �������� ContentsValidator.IsDocumentAdornmentsChanged }
   ['{17F041E4-CEDF-4EE2-972C-56865AE8181E}']
   function Get_New: InsDocumentAdornments;
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   property New: InsDocumentAdornments
     read Get_New;
     {* undefined }
   property ResultValue: Boolean
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//IContentsValidator_IsDocumentAdornmentsChanged_Params

 Op_ContentsValidator_IsDocumentAdornmentsChanged = class
  {* ����� ��� ������ �������� ContentsValidator.IsDocumentAdornmentsChanged }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    const aNew: InsDocumentAdornments): Boolean; overload; 
     {* ����� �������� ContentsValidator.IsDocumentAdornmentsChanged � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aNew: InsDocumentAdornments): Boolean; overload; 
     {* ����� �������� ContentsValidator.IsDocumentAdornmentsChanged � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aNew: InsDocumentAdornments): Boolean; overload; 
     {* ����� �������� ContentsValidator.IsDocumentAdornmentsChanged � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aNew: InsDocumentAdornments): Boolean; overload; 
     {* ����� �������� ContentsValidator.IsDocumentAdornmentsChanged � ���������� }
 end;//Op_ContentsValidator_IsDocumentAdornmentsChanged

 Op_DocumentSubPanel_UpdateSubPanel = class
  {* ����� ��� ������ �������� DocumentSubPanel.UpdateSubPanel }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* ����� �������� DocumentSubPanel.UpdateSubPanel � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* ����� �������� DocumentSubPanel.UpdateSubPanel � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* ����� �������� DocumentSubPanel.UpdateSubPanel � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* ����� �������� DocumentSubPanel.UpdateSubPanel � ���������� }
 end;//Op_DocumentSubPanel_UpdateSubPanel

 IBaseSearchPresentationHolder_GetBaseSearchPresentation_Params = interface(IUnknown)
  {* ��������� ��� �������� BaseSearchPresentationHolder.GetBaseSearchPresentation }
   ['{C3E3A909-AA62-47CC-A4BD-7DBFD9851892}']
   function Get_ResultValue: InsBaseSearchPresentation;
   procedure Set_ResultValue(const aValue: InsBaseSearchPresentation);
   property ResultValue: InsBaseSearchPresentation
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//IBaseSearchPresentationHolder_GetBaseSearchPresentation_Params

 Op_BaseSearchPresentationHolder_GetBaseSearchPresentation = class
  {* ����� ��� ������ �������� BaseSearchPresentationHolder.GetBaseSearchPresentation }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): InsBaseSearchPresentation; overload; 
     {* ����� �������� BaseSearchPresentationHolder.GetBaseSearchPresentation � �������� }
   class function Call(const aTarget: IvcmAggregate): InsBaseSearchPresentation; overload; 
     {* ����� �������� BaseSearchPresentationHolder.GetBaseSearchPresentation � ��������� }
   class function Call(const aTarget: IvcmEntityForm): InsBaseSearchPresentation; overload; 
     {* ����� �������� BaseSearchPresentationHolder.GetBaseSearchPresentation � ����� }
   class function Call(const aTarget: IvcmContainer): InsBaseSearchPresentation; overload; 
     {* ����� �������� BaseSearchPresentationHolder.GetBaseSearchPresentation � ���������� }
 end;//Op_BaseSearchPresentationHolder_GetBaseSearchPresentation
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
const
 en_Editions = 'Editions';
 en_capEditions = '��������';
 op_SetCurrent = 'SetCurrent';
 op_capSetCurrent = '���������� �������';
 en_System = 'System';
 en_capSystem = '';
 op_TimeMachineStateChange = 'TimeMachineStateChange';
 op_capTimeMachineStateChange = '';
 en_Selection = 'Selection';
 en_capSelection = '���������� ��������';
 op_InsertHyperlink = 'InsertHyperlink';
 op_capInsertHyperlink = '��������� ������...';
 op_FindInDict = 'FindInDict';
 op_capFindInDict = '����� � �������� �������';
 en_Contents = 'Contents';
 en_capContents = '��������� ���������';
 op_MoveCurrent = 'MoveCurrent';
 op_capMoveCurrent = '';
 op_HasUserComments = 'HasUserComments';
 op_capHasUserComments = '���� �� � ���������� ���������������� �����������';
 op_HasBookmarks = 'HasBookmarks';
 op_capHasBookmarks = '���� �� � ���������� ��������';
 op_ToggleContentsVisibility = 'ToggleContentsVisibility';
 op_capToggleContentsVisibility = '����������� ��������� ���������� ���� ����������, ���������� true ���� ������������ �������';
 op_IsContentsVisible = 'IsContentsVisible';
 op_capIsContentsVisible = '���������� ��������� ��������� ���������� ���� ����������';
 en_Warning = 'Warning';
 en_capWarning = '';
 op_BecomeActive = 'BecomeActive';
 op_capBecomeActive = '';
 op_SwitchActive = 'SwitchActive';
 op_capSwitchActive = '';
 en_Picture = 'Picture';
 en_capPicture = '��������';
 op_InitNewContent = 'InitNewContent';
 op_capInitNewContent = '';
 en_DocumentBlock = 'DocumentBlock';
 en_capDocumentBlock = '����� ����������';
 op_GetTypedCorrespondentList = 'GetTypedCorrespondentList';
 op_capGetTypedCorrespondentList = '������ �� �������� (��� ����������)';
 op_PrintPreview = 'PrintPreview';
 op_capPrintPreview = '';
 op_Select = 'Select';
 op_capSelect = '';
 op_GetSimilarDocsToBlock = 'GetSimilarDocsToBlock';
 op_capGetSimilarDocsToBlock = '';
 op_GetCorrespondentList = 'GetCorrespondentList';
 op_capGetCorrespondentList = '';
 op_GetRespondentList = 'GetRespondentList';
 op_capGetRespondentList = '';
 op_GetTypedRespondentList = 'GetTypedRespondentList';
 op_capGetTypedRespondentList = '';
 op_ToMSWord = 'ToMSWord';
 op_capToMSWord = '';
 op_PrintDialog = 'PrintDialog';
 op_capPrintDialog = '';
 op_Copy = 'Copy';
 op_capCopy = '';
 op_Print = 'Print';
 op_capPrint = '';
 en_DocumentBlockHeader = 'DocumentBlockHeader';
 en_capDocumentBlockHeader = '����� ���������� - ��������� ��������';
 op_UserCR1 = 'UserCR1';
 op_capUserCR1 = '���������������� ������ �� �������� (������ �� ���������) 1';
 op_UserCR2 = 'UserCR2';
 op_capUserCR2 = '���������������� ������ �� �������� (������ �� ���������) 2';
 op_AddBookmark = 'AddBookmark';
 op_capAddBookmark = '';
 en_WarnOnControl = 'WarnOnControl';
 en_capWarnOnControl = '�������������� (�� ��������)';
 op_ClearStatusSettings = 'ClearStatusSettings';
 op_capClearStatusSettings = '������ ������ ������� "�������"';
 op_ShowChanges = 'ShowChanges';
 op_capShowChanges = '�������� ���������';
 op_ClearStatus = 'ClearStatus';
 op_capClearStatus = '�������� ������ "�������"';
 en_TasksPanel = 'TasksPanel';
 en_capTasksPanel = '';
 op_TimeMachineOnOff = 'TimeMachineOnOff';
 op_capTimeMachineOnOff = '�������� ������ ������� � ����������� ����\��������� ������ �������';
 en_Document = 'Document';
 en_capDocument = '';
 op_OpenContentsFrmAct = 'OpenContentsFrmAct';
 op_capOpenContentsFrmAct = '��������� ���������';
 op_ShowDocumentPicture = 'ShowDocumentPicture';
 op_capShowDocumentPicture = '';
 op_DocumentSynchroOpenWindow = 'DocumentSynchroOpenWindow';
 op_capDocumentSynchroOpenWindow = '';
 op_DocumentSynchroOpenNewWindow = 'DocumentSynchroOpenNewWindow';
 op_capDocumentSynchroOpenNewWindow = '';
 op_DictListOpenFrmAct = 'DictListOpenFrmAct';
 op_capDictListOpenFrmAct = '';
 op_GotoBookmark = 'GotoBookmark';
 op_capGotoBookmark = '';
 op_LiteratureListForDictionary = 'LiteratureListForDictionary';
 op_capLiteratureListForDictionary = '';
 op_OpenProducedDrugList = 'OpenProducedDrugList';
 op_capOpenProducedDrugList = '';
 op_OpenSimilarDrugList = 'OpenSimilarDrugList';
 op_capOpenSimilarDrugList = '';
 en_ExternalObject = 'ExternalObject';
 en_capExternalObject = '';
 op_Open = 'Open';
 op_capOpen = '';
 op_Save = 'Save';
 op_capSave = '';
 en_WarnRedaction = 'WarnRedaction';
 en_capWarnRedaction = '�������������� � ������������ ��������';
 op_ShowInfo = 'ShowInfo';
 op_capShowInfo = '�������� ����� ��������������';
 op_OpenActualRedaction = 'OpenActualRedaction';
 op_capOpenActualRedaction = '';
 en_WarnTimeMachine = 'WarnTimeMachine';
 en_capWarnTimeMachine = '�������������� ��� ������ �������';
 op_TimeMachineOnOffNew = 'TimeMachineOnOffNew';
 op_capTimeMachineOnOffNew = '��������/��������� ������ �������';
 en_WarnJuror = 'WarnJuror';
 en_capWarnJuror = '�������������� (�����������)';
 en_BookmarkIcon = 'BookmarkIcon';
 en_capBookmarkIcon = '';
 op_Delete = 'Delete';
 op_capDelete = '';
 op_Edit = 'Edit';
 op_capEdit = '';
 en_UserCommentIcon = 'UserCommentIcon';
 en_capUserCommentIcon = '';
 op_HideShow = 'HideShow';
 op_capHideShow = '������/��������';
 en_UserComment = 'UserComment';
 en_capUserComment = '';
 en_Text = 'Text';
 en_capText = '';
 op_AddUserComment = 'AddUserComment';
 op_capAddUserComment = '';
 op_DeleteBookmark = 'DeleteBookmark';
 op_capDeleteBookmark = '';
 op_EditBookmark = 'EditBookmark';
 op_capEditBookmark = '';
 op_OpenNewWindow = 'OpenNewWindow';
 op_capOpenNewWindow = '';
 op_TimeMachineOffAndReset = 'TimeMachineOffAndReset';
 op_capTimeMachineOffAndReset = '';
 op_ActualRedaction = 'ActualRedaction';
 op_capActualRedaction = '';
 op_TimeMachineOff = 'TimeMachineOff';
 op_capTimeMachineOff = '';
 en_Reminder = 'Reminder';
 en_capReminder = '';
 op_RemWarnJuror = 'RemWarnJuror';
 op_capRemWarnJuror = '';
 op_RemWarnTimeMachineOn = 'RemWarnTimeMachineOn';
 op_capRemWarnTimeMachineOn = '';
 op_RemWarnRedaction = 'RemWarnRedaction';
 op_capRemWarnRedaction = '';
 op_RemWarnOnControl = 'RemWarnOnControl';
 op_capRemWarnOnControl = '';
 op_RemWarnIsAbolished = 'RemWarnIsAbolished';
 op_capRemWarnIsAbolished = '';
 op_RemWarnTimeMachineException = 'RemWarnTimeMachineException';
 op_capRemWarnTimeMachineException = '';
 op_RemWarnPreActive = 'RemWarnPreActive';
 op_capRemWarnPreActive = '';
 op_RemWarnTimeMachineWarning = 'RemWarnTimeMachineWarning';
 op_capRemWarnTimeMachineWarning = '';
 op_ViewInactualDocument = 'ViewInactualDocument';
 op_capViewInactualDocument = '';
 en_SynchroView = 'SynchroView';
 en_capSynchroView = '';
 op_ShowText = 'ShowText';
 op_capShowText = '';
 op_Annotation = 'Annotation';
 op_capAnnotation = '';
 op_ShowAttributes = 'ShowAttributes';
 op_capShowAttributes = '';
 op_ShowRelated = 'ShowRelated';
 op_capShowRelated = '';
 op_ShowUserCRList1 = 'ShowUserCRList1';
 op_capShowUserCRList1 = '';
 op_ShowUserCRList2 = 'ShowUserCRList2';
 op_capShowUserCRList2 = '';
 op_SimilarDocuments = 'SimilarDocuments';
 op_capSimilarDocuments = '';
 en_Edition = 'Edition';
 en_capEdition = '';
 op_OpenNewTab = 'OpenNewTab';
 op_capOpenNewTab = '';
 en_Attribute = 'Attribute';
 en_capAttribute = '';
 op_Resize = 'Resize';
 op_capResize = '';
 op_Enlarge = 'Enlarge';
 op_capEnlarge = '';
 op_Shrink = 'Shrink';
 op_capShrink = '';
 op_ActualSize = 'ActualSize';
 op_capActualSize = '';
 op_FitInWIndow = 'FitInWIndow';
 op_capFitInWIndow = '';
 en_ContentsValidator = 'ContentsValidator';
 en_capContentsValidator = 'http://mdp.garant.ru/pages/viewpage.action?pageId=259891063';
 op_IsDocumentAdornmentsChanged = 'IsDocumentAdornmentsChanged';
 op_capIsDocumentAdornmentsChanged = '';
 en_DocumentSubPanel = 'DocumentSubPanel';
 en_capDocumentSubPanel = '';
 op_UpdateSubPanel = 'UpdateSubPanel';
 op_capUpdateSubPanel = '';
 op_DoCompareEditions = 'DoCompareEditions';
 op_capDoCompareEditions = '�������� ��������';
 op_BuildChangedFragments = 'BuildChangedFragments';
 op_capBuildChangedFragments = '��������� ����� ���������';
 en_DocumentBlockBookmarks = 'DocumentBlockBookmarks';
 en_capDocumentBlockBookmarks = '�������� �� ����� ����������';
 en_IntranetSourcePoint = 'IntranetSourcePoint';
 en_capIntranetSourcePoint = '';
 op_GoToIntranet = 'GoToIntranet';
 op_capGoToIntranet = '';
 op_ChangesButton = 'ChangesButton';
 op_capChangesButton = '��������� � ���������';
 en_SubsPanel = 'SubsPanel';
 en_capSubsPanel = '������ �����';
 op_CopySubNumber = 'CopySubNumber';
 op_capCopySubNumber = '���������� �������';
 en_BaseSearchPresentationHolder = 'BaseSearchPresentationHolder';
 en_capBaseSearchPresentationHolder = '';
 op_GetBaseSearchPresentation = 'GetBaseSearchPresentation';
 op_capGetBaseSearchPresentation = '';
 op_SelectWord = 'SelectWord';
 op_capSelectWord = '';
 op_SelectPara = 'SelectPara';
 op_capSelectPara = '';

// ��������� ��������:
var st_user_Selection_InsertHyperlink_ModifyLink : TvcmOperationStateIndex = (rID : -1);
  // ���������� �������� -> ��������� ������... <-> �������� ������...
var st_user_DocumentBlock_GetTypedCorrespondentList_InText : TvcmOperationStateIndex = (rID : -1);
  // ����� ���������� -> ������ �� �������� (��� ����������) <-> ������ �� ��������:
var st_user_DocumentBlockHeader_UserCR1_Corr : TvcmOperationStateIndex = (rID : -1);
  // ����� ���������� - ��������� �������� -> ���������������� ������ �� �������� (������ �� ���������) 1 <-> Corr
var st_user_DocumentBlockHeader_UserCR2_Corr : TvcmOperationStateIndex = (rID : -1);
  // ����� ���������� - ��������� �������� -> ���������������� ������ �� �������� (������ �� ���������) 2 <-> Corr
var st_user_TasksPanel_TimeMachineOnOff_On : TvcmOperationStateIndex = (rID : -1);
  // TasksPanel -> �������� ������ ������� � ����������� ����\��������� ������ ������� <-> �������� ������ �������
var st_user_TasksPanel_TimeMachineOnOff_Off : TvcmOperationStateIndex = (rID : -1);
  // TasksPanel -> �������� ������ ������� � ����������� ����\��������� ������ ������� <-> ��������� ������ �������
var st_user_Document_OpenContentsFrmAct_Drug : TvcmOperationStateIndex = (rID : -1);
  // Document -> ��������� ��������� <-> ��������� ���������
var st_user_WarnRedaction_ShowInfo_Hide : TvcmOperationStateIndex = (rID : -1);
  // �������������� � ������������ �������� -> �������� ����� �������������� <-> ������ ����� ��������������
var st_user_WarnTimeMachine_ShowInfo_Hide : TvcmOperationStateIndex = (rID : -1);
  // �������������� ��� ������ ������� -> �������� ����� �������������� <-> ������ ����� ��������������
var st_user_WarnTimeMachine_TimeMachineOnOffNew_MachineOn : TvcmOperationStateIndex = (rID : -1);
  // �������������� ��� ������ ������� -> ��������/��������� ������ ������� <-> �������� ������ �������
var st_user_WarnTimeMachine_TimeMachineOnOffNew_MachineOff : TvcmOperationStateIndex = (rID : -1);
  // �������������� ��� ������ ������� -> ��������/��������� ������ ������� <-> ��������� ������ �������/�������� ����
var st_user_WarnJuror_ShowInfo_Hide : TvcmOperationStateIndex = (rID : -1);
  // �������������� (�����������) -> �������� ����� �������������� <-> ������ ����� ��������������
var st_user_UserCommentIcon_HideShow_GarantHidden : TvcmOperationStateIndex = (rID : -1);
  // UserCommentIcon -> ������/�������� <-> �������� ����������� �������
var st_user_UserCommentIcon_HideShow_GarantShown : TvcmOperationStateIndex = (rID : -1);
  // UserCommentIcon -> ������/�������� <-> ������ ����������� �������
var st_user_UserCommentIcon_HideShow_UserShown : TvcmOperationStateIndex = (rID : -1);
  // UserCommentIcon -> ������/�������� <-> ������ ��� �����������
var st_user_UserCommentIcon_HideShow_UserHidden : TvcmOperationStateIndex = (rID : -1);
  // UserCommentIcon -> ������/�������� <-> �������� ��� �����������
var st_user_UserCommentIcon_HideShow_Invisible : TvcmOperationStateIndex = (rID : -1);
  // UserCommentIcon -> ������/�������� <-> Invisible
var st_user_UserCommentIcon_HideShow_VersionShown : TvcmOperationStateIndex = (rID : -1);
  // UserCommentIcon -> ������/�������� <-> ��������� ���������� �� ���������� ���������
var st_user_UserCommentIcon_HideShow_VersionHidden : TvcmOperationStateIndex = (rID : -1);
  // UserCommentIcon -> ������/�������� <-> �������� ���������� �� ���������� ���������
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  vcmBase {a},
  StdRes {a}
  ;

type
 TEditions_SetCurrent_Params = class(Tl3CProtoObject, IEditions_SetCurrent_Params)
  {* ���������� IEditions_SetCurrent_Params }
 private
 // private fields
   f_Document : IDocument;
 protected
 // realized methods
   function Get_Document: IDocument;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
 public
 // public methods
   constructor Create(const aDocument: IDocument); reintroduce;
     {* ����������� TEditions_SetCurrent_Params }
   class function Make(const aDocument: IDocument): IEditions_SetCurrent_Params; reintroduce;
     {* ������� TEditions_SetCurrent_Params }
 end;//TEditions_SetCurrent_Params

// start class TEditions_SetCurrent_Params

constructor TEditions_SetCurrent_Params.Create(const aDocument: IDocument);
 {-}
begin
 inherited Create;
 f_Document := aDocument;
end;//TEditions_SetCurrent_Params.Create

class function TEditions_SetCurrent_Params.Make(const aDocument: IDocument): IEditions_SetCurrent_Params;
var
 l_Inst : TEditions_SetCurrent_Params;
begin
 l_Inst := Create(aDocument);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TEditions_SetCurrent_Params.Get_Document: IDocument;
 {-}
begin
 Result := f_Document;
end;//TEditions_SetCurrent_Params.Get_Document

procedure TEditions_SetCurrent_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Document := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TEditions_SetCurrent_Params.ClearFields
// start class Op_Editions_SetCurrent

class function Op_Editions_SetCurrent.Call(const aTarget: IvcmEntity;
  const aDocument: IDocument): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TEditions_SetCurrent_Params.Make(aDocument));
  aTarget.Operation(TdmStdRes.opcode_Editions_SetCurrent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Editions_SetCurrent.Call

class function Op_Editions_SetCurrent.Call(const aTarget: IvcmAggregate;
  const aDocument: IDocument): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TEditions_SetCurrent_Params.Make(aDocument));
  aTarget.Operation(TdmStdRes.opcode_Editions_SetCurrent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Editions_SetCurrent.Call

class function Op_Editions_SetCurrent.Call(const aTarget: IvcmEntityForm;
  const aDocument: IDocument): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aDocument);
end;//Op_Editions_SetCurrent.Call

class function Op_Editions_SetCurrent.Call(const aTarget: IvcmContainer;
  const aDocument: IDocument): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aDocument);
end;//Op_Editions_SetCurrent.Call

type
 TSystem_TimeMachineStateChange_Params = class(Tl3CProtoObject, ISystem_TimeMachineStateChange_Params)
  {* ���������� ISystem_TimeMachineStateChange_Params }
 private
 // private fields
   f_StayInCurrentRedaction : Boolean;
 protected
 // realized methods
   function Get_StayInCurrentRedaction: Boolean;
 public
 // public methods
   constructor Create(aStayInCurrentRedaction: Boolean); reintroduce;
     {* ����������� TSystem_TimeMachineStateChange_Params }
   class function Make(aStayInCurrentRedaction: Boolean): ISystem_TimeMachineStateChange_Params; reintroduce;
     {* ������� TSystem_TimeMachineStateChange_Params }
 end;//TSystem_TimeMachineStateChange_Params

// start class TSystem_TimeMachineStateChange_Params

constructor TSystem_TimeMachineStateChange_Params.Create(aStayInCurrentRedaction: Boolean);
 {-}
begin
 inherited Create;
 f_StayInCurrentRedaction := aStayInCurrentRedaction;
end;//TSystem_TimeMachineStateChange_Params.Create

class function TSystem_TimeMachineStateChange_Params.Make(aStayInCurrentRedaction: Boolean): ISystem_TimeMachineStateChange_Params;
var
 l_Inst : TSystem_TimeMachineStateChange_Params;
begin
 l_Inst := Create(aStayInCurrentRedaction);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TSystem_TimeMachineStateChange_Params.Get_StayInCurrentRedaction: Boolean;
 {-}
begin
 Result := f_StayInCurrentRedaction;
end;//TSystem_TimeMachineStateChange_Params.Get_StayInCurrentRedaction
// start class Op_System_TimeMachineStateChange

class function Op_System_TimeMachineStateChange.Call(const aTarget: IvcmEntity;
  aStayInCurrentRedaction: Boolean = false): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSystem_TimeMachineStateChange_Params.Make(aStayInCurrentRedaction));
  aTarget.Operation(TdmStdRes.opcode_System_TimeMachineStateChange, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_System_TimeMachineStateChange.Call

class function Op_System_TimeMachineStateChange.Call(const aTarget: IvcmAggregate;
  aStayInCurrentRedaction: Boolean = false): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSystem_TimeMachineStateChange_Params.Make(aStayInCurrentRedaction));
  aTarget.Operation(TdmStdRes.opcode_System_TimeMachineStateChange, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_System_TimeMachineStateChange.Call

class function Op_System_TimeMachineStateChange.Call(const aTarget: IvcmEntityForm;
  aStayInCurrentRedaction: Boolean = false): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aStayInCurrentRedaction);
end;//Op_System_TimeMachineStateChange.Call

class function Op_System_TimeMachineStateChange.Call(const aTarget: IvcmContainer;
  aStayInCurrentRedaction: Boolean = false): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aStayInCurrentRedaction);
end;//Op_System_TimeMachineStateChange.Call

class procedure Op_System_TimeMachineStateChange.Broadcast(aStayInCurrentRedaction: Boolean = false);
var
 l_Params : IvcmExecuteParams;
begin
 if (vcmDispatcher <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSystem_TimeMachineStateChange_Params.Make(aStayInCurrentRedaction));
  vcmDispatcher.EntityOperationBroadcast(TdmStdRes.opcode_System_TimeMachineStateChange, l_Params);
 end;//vcmDispatcher <> nil
end;//Op_System_TimeMachineStateChange.Broadcast

type
 TContents_SetCurrent_Params = class(Tl3CProtoObject, IContents_SetCurrent_Params)
  {* ���������� IContents_SetCurrent_Params }
 private
 // private fields
   f_Sub : Integer;
 protected
 // realized methods
   function Get_Sub: Integer;
 public
 // public methods
   constructor Create(aSub: Integer); reintroduce;
     {* ����������� TContents_SetCurrent_Params }
   class function Make(aSub: Integer): IContents_SetCurrent_Params; reintroduce;
     {* ������� TContents_SetCurrent_Params }
 end;//TContents_SetCurrent_Params

// start class TContents_SetCurrent_Params

constructor TContents_SetCurrent_Params.Create(aSub: Integer);
 {-}
begin
 inherited Create;
 f_Sub := aSub;
end;//TContents_SetCurrent_Params.Create

class function TContents_SetCurrent_Params.Make(aSub: Integer): IContents_SetCurrent_Params;
var
 l_Inst : TContents_SetCurrent_Params;
begin
 l_Inst := Create(aSub);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TContents_SetCurrent_Params.Get_Sub: Integer;
 {-}
begin
 Result := f_Sub;
end;//TContents_SetCurrent_Params.Get_Sub
// start class Op_Contents_SetCurrent

class function Op_Contents_SetCurrent.Call(const aTarget: IvcmEntity;
  aSub: Integer): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContents_SetCurrent_Params.Make(aSub));
  aTarget.Operation(TdmStdRes.opcode_Contents_SetCurrent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Contents_SetCurrent.Call

class function Op_Contents_SetCurrent.Call(const aTarget: IvcmAggregate;
  aSub: Integer): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContents_SetCurrent_Params.Make(aSub));
  aTarget.Operation(TdmStdRes.opcode_Contents_SetCurrent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Contents_SetCurrent.Call

class function Op_Contents_SetCurrent.Call(const aTarget: IvcmEntityForm;
  aSub: Integer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aSub);
end;//Op_Contents_SetCurrent.Call

class function Op_Contents_SetCurrent.Call(const aTarget: IvcmContainer;
  aSub: Integer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aSub);
end;//Op_Contents_SetCurrent.Call

type
 TContents_MoveCurrent_Params = class(Tl3CProtoObject, IContents_MoveCurrent_Params)
  {* ���������� IContents_MoveCurrent_Params }
 private
 // private fields
   f_Sub : Integer;
   f_Down : Boolean;
 protected
 // realized methods
   function Get_Down: Boolean;
   function Get_Sub: Integer;
 public
 // public methods
   constructor Create(aSub: Integer;
    aDown: Boolean); reintroduce;
     {* ����������� TContents_MoveCurrent_Params }
   class function Make(aSub: Integer;
    aDown: Boolean): IContents_MoveCurrent_Params; reintroduce;
     {* ������� TContents_MoveCurrent_Params }
 end;//TContents_MoveCurrent_Params

// start class TContents_MoveCurrent_Params

constructor TContents_MoveCurrent_Params.Create(aSub: Integer;
  aDown: Boolean);
 {-}
begin
 inherited Create;
 f_Sub := aSub;
 f_Down := aDown;
end;//TContents_MoveCurrent_Params.Create

class function TContents_MoveCurrent_Params.Make(aSub: Integer;
  aDown: Boolean): IContents_MoveCurrent_Params;
var
 l_Inst : TContents_MoveCurrent_Params;
begin
 l_Inst := Create(aSub, aDown);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TContents_MoveCurrent_Params.Get_Down: Boolean;
 {-}
begin
 Result := f_Down;
end;//TContents_MoveCurrent_Params.Get_Down

function TContents_MoveCurrent_Params.Get_Sub: Integer;
 {-}
begin
 Result := f_Sub;
end;//TContents_MoveCurrent_Params.Get_Sub
// start class Op_Contents_MoveCurrent

class function Op_Contents_MoveCurrent.Call(const aTarget: IvcmEntity;
  aSub: Integer;
  aDown: Boolean): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContents_MoveCurrent_Params.Make(aSub,aDown));
  aTarget.Operation(TdmStdRes.opcode_Contents_MoveCurrent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Contents_MoveCurrent.Call

class function Op_Contents_MoveCurrent.Call(const aTarget: IvcmAggregate;
  aSub: Integer;
  aDown: Boolean): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContents_MoveCurrent_Params.Make(aSub,aDown));
  aTarget.Operation(TdmStdRes.opcode_Contents_MoveCurrent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Contents_MoveCurrent.Call

class function Op_Contents_MoveCurrent.Call(const aTarget: IvcmEntityForm;
  aSub: Integer;
  aDown: Boolean): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aSub, aDown);
end;//Op_Contents_MoveCurrent.Call

class function Op_Contents_MoveCurrent.Call(const aTarget: IvcmContainer;
  aSub: Integer;
  aDown: Boolean): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aSub, aDown);
end;//Op_Contents_MoveCurrent.Call

type
 TContents_HasUserComments_Params = class(Tl3CProtoObject, IContents_HasUserComments_Params)
  {* ���������� IContents_HasUserComments_Params }
 private
 // private fields
   f_ResultValue : Boolean;
 protected
 // realized methods
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
 public
 // public methods
   constructor Create; reintroduce;
     {* ����������� TContents_HasUserComments_Params }
   class function Make: IContents_HasUserComments_Params; reintroduce;
     {* ������� TContents_HasUserComments_Params }
 end;//TContents_HasUserComments_Params

// start class TContents_HasUserComments_Params

constructor TContents_HasUserComments_Params.Create;
 {-}
begin
 inherited Create;
end;//TContents_HasUserComments_Params.Create

class function TContents_HasUserComments_Params.Make: IContents_HasUserComments_Params;
var
 l_Inst : TContents_HasUserComments_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TContents_HasUserComments_Params.Get_ResultValue: Boolean;
 {-}
begin
 Result := f_ResultValue;
end;//TContents_HasUserComments_Params.Get_ResultValue

procedure TContents_HasUserComments_Params.Set_ResultValue(aValue: Boolean);
 {-}
begin
 f_ResultValue := aValue;
end;//TContents_HasUserComments_Params.Set_ResultValue
// start class Op_Contents_HasUserComments

class function Op_Contents_HasUserComments.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContents_HasUserComments_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_Contents_HasUserComments, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IContents_HasUserComments_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Contents_HasUserComments.Call

class function Op_Contents_HasUserComments.Call(const aTarget: IvcmAggregate): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContents_HasUserComments_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_Contents_HasUserComments, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IContents_HasUserComments_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Contents_HasUserComments.Call

class function Op_Contents_HasUserComments.Call(const aTarget: IvcmEntityForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Contents_HasUserComments.Call

class function Op_Contents_HasUserComments.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Contents_HasUserComments.Call

type
 TContents_HasBookmarks_Params = class(Tl3CProtoObject, IContents_HasBookmarks_Params)
  {* ���������� IContents_HasBookmarks_Params }
 private
 // private fields
   f_ResultValue : Boolean;
 protected
 // realized methods
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
 public
 // public methods
   constructor Create; reintroduce;
     {* ����������� TContents_HasBookmarks_Params }
   class function Make: IContents_HasBookmarks_Params; reintroduce;
     {* ������� TContents_HasBookmarks_Params }
 end;//TContents_HasBookmarks_Params

// start class TContents_HasBookmarks_Params

constructor TContents_HasBookmarks_Params.Create;
 {-}
begin
 inherited Create;
end;//TContents_HasBookmarks_Params.Create

class function TContents_HasBookmarks_Params.Make: IContents_HasBookmarks_Params;
var
 l_Inst : TContents_HasBookmarks_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TContents_HasBookmarks_Params.Get_ResultValue: Boolean;
 {-}
begin
 Result := f_ResultValue;
end;//TContents_HasBookmarks_Params.Get_ResultValue

procedure TContents_HasBookmarks_Params.Set_ResultValue(aValue: Boolean);
 {-}
begin
 f_ResultValue := aValue;
end;//TContents_HasBookmarks_Params.Set_ResultValue
// start class Op_Contents_HasBookmarks

class function Op_Contents_HasBookmarks.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContents_HasBookmarks_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_Contents_HasBookmarks, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IContents_HasBookmarks_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Contents_HasBookmarks.Call

class function Op_Contents_HasBookmarks.Call(const aTarget: IvcmAggregate): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContents_HasBookmarks_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_Contents_HasBookmarks, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IContents_HasBookmarks_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Contents_HasBookmarks.Call

class function Op_Contents_HasBookmarks.Call(const aTarget: IvcmEntityForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Contents_HasBookmarks.Call

class function Op_Contents_HasBookmarks.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Contents_HasBookmarks.Call

type
 TContents_ToggleContentsVisibility_Params = class(Tl3CProtoObject, IContents_ToggleContentsVisibility_Params)
  {* ���������� IContents_ToggleContentsVisibility_Params }
 private
 // private fields
   f_ResultValue : Boolean;
 protected
 // realized methods
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
 public
 // public methods
   constructor Create; reintroduce;
     {* ����������� TContents_ToggleContentsVisibility_Params }
   class function Make: IContents_ToggleContentsVisibility_Params; reintroduce;
     {* ������� TContents_ToggleContentsVisibility_Params }
 end;//TContents_ToggleContentsVisibility_Params

// start class TContents_ToggleContentsVisibility_Params

constructor TContents_ToggleContentsVisibility_Params.Create;
 {-}
begin
 inherited Create;
end;//TContents_ToggleContentsVisibility_Params.Create

class function TContents_ToggleContentsVisibility_Params.Make: IContents_ToggleContentsVisibility_Params;
var
 l_Inst : TContents_ToggleContentsVisibility_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TContents_ToggleContentsVisibility_Params.Get_ResultValue: Boolean;
 {-}
begin
 Result := f_ResultValue;
end;//TContents_ToggleContentsVisibility_Params.Get_ResultValue

procedure TContents_ToggleContentsVisibility_Params.Set_ResultValue(aValue: Boolean);
 {-}
begin
 f_ResultValue := aValue;
end;//TContents_ToggleContentsVisibility_Params.Set_ResultValue
// start class Op_Contents_ToggleContentsVisibility

class function Op_Contents_ToggleContentsVisibility.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContents_ToggleContentsVisibility_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_Contents_ToggleContentsVisibility, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IContents_ToggleContentsVisibility_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Contents_ToggleContentsVisibility.Call

class function Op_Contents_ToggleContentsVisibility.Call(const aTarget: IvcmAggregate): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContents_ToggleContentsVisibility_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_Contents_ToggleContentsVisibility, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IContents_ToggleContentsVisibility_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Contents_ToggleContentsVisibility.Call

class function Op_Contents_ToggleContentsVisibility.Call(const aTarget: IvcmEntityForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Contents_ToggleContentsVisibility.Call

class function Op_Contents_ToggleContentsVisibility.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Contents_ToggleContentsVisibility.Call

type
 TContents_IsContentsVisible_Params = class(Tl3CProtoObject, IContents_IsContentsVisible_Params)
  {* ���������� IContents_IsContentsVisible_Params }
 private
 // private fields
   f_ResultValue : Boolean;
 protected
 // realized methods
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
 public
 // public methods
   constructor Create; reintroduce;
     {* ����������� TContents_IsContentsVisible_Params }
   class function Make: IContents_IsContentsVisible_Params; reintroduce;
     {* ������� TContents_IsContentsVisible_Params }
 end;//TContents_IsContentsVisible_Params

// start class TContents_IsContentsVisible_Params

constructor TContents_IsContentsVisible_Params.Create;
 {-}
begin
 inherited Create;
end;//TContents_IsContentsVisible_Params.Create

class function TContents_IsContentsVisible_Params.Make: IContents_IsContentsVisible_Params;
var
 l_Inst : TContents_IsContentsVisible_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TContents_IsContentsVisible_Params.Get_ResultValue: Boolean;
 {-}
begin
 Result := f_ResultValue;
end;//TContents_IsContentsVisible_Params.Get_ResultValue

procedure TContents_IsContentsVisible_Params.Set_ResultValue(aValue: Boolean);
 {-}
begin
 f_ResultValue := aValue;
end;//TContents_IsContentsVisible_Params.Set_ResultValue
// start class Op_Contents_IsContentsVisible

class function Op_Contents_IsContentsVisible.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContents_IsContentsVisible_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_Contents_IsContentsVisible, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IContents_IsContentsVisible_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Contents_IsContentsVisible.Call

class function Op_Contents_IsContentsVisible.Call(const aTarget: IvcmAggregate): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContents_IsContentsVisible_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_Contents_IsContentsVisible, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IContents_IsContentsVisible_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Contents_IsContentsVisible.Call

class function Op_Contents_IsContentsVisible.Call(const aTarget: IvcmEntityForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Contents_IsContentsVisible.Call

class function Op_Contents_IsContentsVisible.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Contents_IsContentsVisible.Call

type
 TWarning_BecomeActive_Params = class(Tl3CProtoObject, IWarning_BecomeActive_Params)
  {* ���������� IWarning_BecomeActive_Params }
 private
 // private fields
   f_SubID : TnsWarningSub;
 protected
 // realized methods
   function Get_SubID: TnsWarningSub;
 public
 // public methods
   constructor Create(aSubID: TnsWarningSub); reintroduce;
     {* ����������� TWarning_BecomeActive_Params }
   class function Make(aSubID: TnsWarningSub): IWarning_BecomeActive_Params; reintroduce;
     {* ������� TWarning_BecomeActive_Params }
 end;//TWarning_BecomeActive_Params

// start class TWarning_BecomeActive_Params

constructor TWarning_BecomeActive_Params.Create(aSubID: TnsWarningSub);
 {-}
begin
 inherited Create;
 f_SubID := aSubID;
end;//TWarning_BecomeActive_Params.Create

class function TWarning_BecomeActive_Params.Make(aSubID: TnsWarningSub): IWarning_BecomeActive_Params;
var
 l_Inst : TWarning_BecomeActive_Params;
begin
 l_Inst := Create(aSubID);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TWarning_BecomeActive_Params.Get_SubID: TnsWarningSub;
 {-}
begin
 Result := f_SubID;
end;//TWarning_BecomeActive_Params.Get_SubID
// start class Op_Warning_BecomeActive

class function Op_Warning_BecomeActive.Call(const aTarget: IvcmEntity;
  aSubID: TnsWarningSub): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TWarning_BecomeActive_Params.Make(aSubID));
  aTarget.Operation(TdmStdRes.opcode_Warning_BecomeActive, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Warning_BecomeActive.Call

class function Op_Warning_BecomeActive.Call(const aTarget: IvcmAggregate;
  aSubID: TnsWarningSub): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TWarning_BecomeActive_Params.Make(aSubID));
  aTarget.Operation(TdmStdRes.opcode_Warning_BecomeActive, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Warning_BecomeActive.Call

class function Op_Warning_BecomeActive.Call(const aTarget: IvcmEntityForm;
  aSubID: TnsWarningSub): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aSubID);
end;//Op_Warning_BecomeActive.Call

class function Op_Warning_BecomeActive.Call(const aTarget: IvcmContainer;
  aSubID: TnsWarningSub): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aSubID);
end;//Op_Warning_BecomeActive.Call

type
 TWarning_SwitchActive_Params = class(Tl3CProtoObject, IWarning_SwitchActive_Params)
  {* ���������� IWarning_SwitchActive_Params }
 private
 // private fields
   f_SubID : TnsWarningSub;
 protected
 // realized methods
   function Get_SubID: TnsWarningSub;
 public
 // public methods
   constructor Create(aSubID: TnsWarningSub); reintroduce;
     {* ����������� TWarning_SwitchActive_Params }
   class function Make(aSubID: TnsWarningSub): IWarning_SwitchActive_Params; reintroduce;
     {* ������� TWarning_SwitchActive_Params }
 end;//TWarning_SwitchActive_Params

// start class TWarning_SwitchActive_Params

constructor TWarning_SwitchActive_Params.Create(aSubID: TnsWarningSub);
 {-}
begin
 inherited Create;
 f_SubID := aSubID;
end;//TWarning_SwitchActive_Params.Create

class function TWarning_SwitchActive_Params.Make(aSubID: TnsWarningSub): IWarning_SwitchActive_Params;
var
 l_Inst : TWarning_SwitchActive_Params;
begin
 l_Inst := Create(aSubID);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TWarning_SwitchActive_Params.Get_SubID: TnsWarningSub;
 {-}
begin
 Result := f_SubID;
end;//TWarning_SwitchActive_Params.Get_SubID
// start class Op_Warning_SwitchActive

class function Op_Warning_SwitchActive.Call(const aTarget: IvcmEntity;
  aSubID: TnsWarningSub): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TWarning_SwitchActive_Params.Make(aSubID));
  aTarget.Operation(TdmStdRes.opcode_Warning_SwitchActive, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Warning_SwitchActive.Call

class function Op_Warning_SwitchActive.Call(const aTarget: IvcmAggregate;
  aSubID: TnsWarningSub): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TWarning_SwitchActive_Params.Make(aSubID));
  aTarget.Operation(TdmStdRes.opcode_Warning_SwitchActive, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Warning_SwitchActive.Call

class function Op_Warning_SwitchActive.Call(const aTarget: IvcmEntityForm;
  aSubID: TnsWarningSub): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aSubID);
end;//Op_Warning_SwitchActive.Call

class function Op_Warning_SwitchActive.Call(const aTarget: IvcmContainer;
  aSubID: TnsWarningSub): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aSubID);
end;//Op_Warning_SwitchActive.Call

type
 TPicture_InitNewContent_Params = class(Tl3CProtoObject, IPicture_InitNewContent_Params)
  {* ���������� IPicture_InitNewContent_Params }
 private
 // private fields
   f_Data : InsLinkedObjectData;
 protected
 // realized methods
   function Get_Data: InsLinkedObjectData;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
 public
 // public methods
   constructor Create(const aData: InsLinkedObjectData); reintroduce;
     {* ����������� TPicture_InitNewContent_Params }
   class function Make(const aData: InsLinkedObjectData): IPicture_InitNewContent_Params; reintroduce;
     {* ������� TPicture_InitNewContent_Params }
 end;//TPicture_InitNewContent_Params

// start class TPicture_InitNewContent_Params

constructor TPicture_InitNewContent_Params.Create(const aData: InsLinkedObjectData);
 {-}
begin
 inherited Create;
 f_Data := aData;
end;//TPicture_InitNewContent_Params.Create

class function TPicture_InitNewContent_Params.Make(const aData: InsLinkedObjectData): IPicture_InitNewContent_Params;
var
 l_Inst : TPicture_InitNewContent_Params;
begin
 l_Inst := Create(aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TPicture_InitNewContent_Params.Get_Data: InsLinkedObjectData;
 {-}
begin
 Result := f_Data;
end;//TPicture_InitNewContent_Params.Get_Data

procedure TPicture_InitNewContent_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Data := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TPicture_InitNewContent_Params.ClearFields
// start class Op_Picture_InitNewContent

class function Op_Picture_InitNewContent.Call(const aTarget: IvcmEntity;
  const aData: InsLinkedObjectData): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TPicture_InitNewContent_Params.Make(aData));
  aTarget.Operation(TdmStdRes.opcode_Picture_InitNewContent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Picture_InitNewContent.Call

class function Op_Picture_InitNewContent.Call(const aTarget: IvcmAggregate;
  const aData: InsLinkedObjectData): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TPicture_InitNewContent_Params.Make(aData));
  aTarget.Operation(TdmStdRes.opcode_Picture_InitNewContent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Picture_InitNewContent.Call

class function Op_Picture_InitNewContent.Call(const aTarget: IvcmEntityForm;
  const aData: InsLinkedObjectData): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aData);
end;//Op_Picture_InitNewContent.Call

class function Op_Picture_InitNewContent.Call(const aTarget: IvcmContainer;
  const aData: InsLinkedObjectData): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aData);
end;//Op_Picture_InitNewContent.Call

type
 TContentsValidator_IsDocumentAdornmentsChanged_Params = class(Tl3CProtoObject, IContentsValidator_IsDocumentAdornmentsChanged_Params)
  {* ���������� IContentsValidator_IsDocumentAdornmentsChanged_Params }
 private
 // private fields
   f_New : InsDocumentAdornments;
   f_ResultValue : Boolean;
 protected
 // realized methods
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   function Get_New: InsDocumentAdornments;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
 public
 // public methods
   constructor Create(const aNew: InsDocumentAdornments); reintroduce;
     {* ����������� TContentsValidator_IsDocumentAdornmentsChanged_Params }
   class function Make(const aNew: InsDocumentAdornments): IContentsValidator_IsDocumentAdornmentsChanged_Params; reintroduce;
     {* ������� TContentsValidator_IsDocumentAdornmentsChanged_Params }
 end;//TContentsValidator_IsDocumentAdornmentsChanged_Params

// start class TContentsValidator_IsDocumentAdornmentsChanged_Params

constructor TContentsValidator_IsDocumentAdornmentsChanged_Params.Create(const aNew: InsDocumentAdornments);
 {-}
begin
 inherited Create;
 f_New := aNew;
end;//TContentsValidator_IsDocumentAdornmentsChanged_Params.Create

class function TContentsValidator_IsDocumentAdornmentsChanged_Params.Make(const aNew: InsDocumentAdornments): IContentsValidator_IsDocumentAdornmentsChanged_Params;
var
 l_Inst : TContentsValidator_IsDocumentAdornmentsChanged_Params;
begin
 l_Inst := Create(aNew);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TContentsValidator_IsDocumentAdornmentsChanged_Params.Get_ResultValue: Boolean;
 {-}
begin
 Result := f_ResultValue;
end;//TContentsValidator_IsDocumentAdornmentsChanged_Params.Get_ResultValue

procedure TContentsValidator_IsDocumentAdornmentsChanged_Params.Set_ResultValue(aValue: Boolean);
 {-}
begin
 f_ResultValue := aValue;
end;//TContentsValidator_IsDocumentAdornmentsChanged_Params.Set_ResultValue

function TContentsValidator_IsDocumentAdornmentsChanged_Params.Get_New: InsDocumentAdornments;
 {-}
begin
 Result := f_New;
end;//TContentsValidator_IsDocumentAdornmentsChanged_Params.Get_New

procedure TContentsValidator_IsDocumentAdornmentsChanged_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_New := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TContentsValidator_IsDocumentAdornmentsChanged_Params.ClearFields
// start class Op_ContentsValidator_IsDocumentAdornmentsChanged

class function Op_ContentsValidator_IsDocumentAdornmentsChanged.Call(const aTarget: IvcmEntity;
  const aNew: InsDocumentAdornments): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContentsValidator_IsDocumentAdornmentsChanged_Params.Make(aNew));
  aTarget.Operation(TdmStdRes.opcode_ContentsValidator_IsDocumentAdornmentsChanged, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IContentsValidator_IsDocumentAdornmentsChanged_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_ContentsValidator_IsDocumentAdornmentsChanged.Call

class function Op_ContentsValidator_IsDocumentAdornmentsChanged.Call(const aTarget: IvcmAggregate;
  const aNew: InsDocumentAdornments): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContentsValidator_IsDocumentAdornmentsChanged_Params.Make(aNew));
  aTarget.Operation(TdmStdRes.opcode_ContentsValidator_IsDocumentAdornmentsChanged, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IContentsValidator_IsDocumentAdornmentsChanged_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_ContentsValidator_IsDocumentAdornmentsChanged.Call

class function Op_ContentsValidator_IsDocumentAdornmentsChanged.Call(const aTarget: IvcmEntityForm;
  const aNew: InsDocumentAdornments): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNew);
end;//Op_ContentsValidator_IsDocumentAdornmentsChanged.Call

class function Op_ContentsValidator_IsDocumentAdornmentsChanged.Call(const aTarget: IvcmContainer;
  const aNew: InsDocumentAdornments): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNew);
end;//Op_ContentsValidator_IsDocumentAdornmentsChanged.Call
// start class Op_DocumentSubPanel_UpdateSubPanel

class function Op_DocumentSubPanel_UpdateSubPanel.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_DocumentSubPanel_UpdateSubPanel, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_DocumentSubPanel_UpdateSubPanel.Call

class function Op_DocumentSubPanel_UpdateSubPanel.Call(const aTarget: IvcmAggregate): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_DocumentSubPanel_UpdateSubPanel, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_DocumentSubPanel_UpdateSubPanel.Call

class function Op_DocumentSubPanel_UpdateSubPanel.Call(const aTarget: IvcmEntityForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_DocumentSubPanel_UpdateSubPanel.Call

class function Op_DocumentSubPanel_UpdateSubPanel.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_DocumentSubPanel_UpdateSubPanel.Call

type
 TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params = class(Tl3CProtoObject, IBaseSearchPresentationHolder_GetBaseSearchPresentation_Params)
  {* ���������� IBaseSearchPresentationHolder_GetBaseSearchPresentation_Params }
 private
 // private fields
   f_ResultValue : InsBaseSearchPresentation;
 protected
 // realized methods
   function Get_ResultValue: InsBaseSearchPresentation;
   procedure Set_ResultValue(const aValue: InsBaseSearchPresentation);
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
 public
 // public methods
   constructor Create; reintroduce;
     {* ����������� TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params }
   class function Make: IBaseSearchPresentationHolder_GetBaseSearchPresentation_Params; reintroduce;
     {* ������� TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params }
 end;//TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params

// start class TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params

constructor TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params.Create;
 {-}
begin
 inherited Create;
end;//TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params.Create

class function TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params.Make: IBaseSearchPresentationHolder_GetBaseSearchPresentation_Params;
var
 l_Inst : TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params.Get_ResultValue: InsBaseSearchPresentation;
 {-}
begin
 Result := f_ResultValue;
end;//TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params.Get_ResultValue

procedure TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params.Set_ResultValue(const aValue: InsBaseSearchPresentation);
 {-}
begin
 f_ResultValue := aValue;
end;//TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params.Set_ResultValue

procedure TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_ResultValue := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params.ClearFields
// start class Op_BaseSearchPresentationHolder_GetBaseSearchPresentation

class function Op_BaseSearchPresentationHolder_GetBaseSearchPresentation.Call(const aTarget: IvcmEntity): InsBaseSearchPresentation;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_BaseSearchPresentationHolder_GetBaseSearchPresentation, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IBaseSearchPresentationHolder_GetBaseSearchPresentation_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_BaseSearchPresentationHolder_GetBaseSearchPresentation.Call

class function Op_BaseSearchPresentationHolder_GetBaseSearchPresentation.Call(const aTarget: IvcmAggregate): InsBaseSearchPresentation;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_BaseSearchPresentationHolder_GetBaseSearchPresentation, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IBaseSearchPresentationHolder_GetBaseSearchPresentation_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_BaseSearchPresentationHolder_GetBaseSearchPresentation.Call

class function Op_BaseSearchPresentationHolder_GetBaseSearchPresentation.Call(const aTarget: IvcmEntityForm): InsBaseSearchPresentation;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_BaseSearchPresentationHolder_GetBaseSearchPresentation.Call

class function Op_BaseSearchPresentationHolder_GetBaseSearchPresentation.Call(const aTarget: IvcmContainer): InsBaseSearchPresentation;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_BaseSearchPresentationHolder_GetBaseSearchPresentation.Call
{$IfEnd} //not Admin AND not Monitorings


end.