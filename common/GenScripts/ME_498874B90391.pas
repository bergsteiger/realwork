unit Document_Strange_Controls;
 {* �������� ��������, �� ���������� ���� ����������� ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document_Strange_Controls.pas"
// ���������: "VCMControls"
// ������� ������: "Strange" MUID: (498874B90391)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUnit
 , nevBase
 , l3TreeInterfaces
 , bsTypes
 , eeInterfaces
 , DocumentAndListInterfaces
 , DocumentDomainInterfaces
 , Base_Operations_Editions_Controls
 , BaseSearchInterfaces
 , F1TagDataProviderInterface
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 IEditions_SetCurrent_Params = interface
  {* ��������� ��� �������� Editions.SetCurrent }
  ['{69481C49-8E84-4A41-BAE4-E419D710DF8C}']
  function Get_Document: IDocument;
  property Document: IDocument
   read Get_Document;
 end;//IEditions_SetCurrent_Params

 Op_Editions_SetCurrent = class
  {* ����� ��� ������ �������� Editions.SetCurrent }
  public
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

 ISystem_TimeMachineStateChange_Params = interface
  {* ��������� ��� �������� System.TimeMachineStateChange }
  ['{F9F5407A-002A-4696-94D1-DAC349ED07AD}']
  function Get_StayInCurrentRedaction: Boolean;
  property StayInCurrentRedaction: Boolean
   read Get_StayInCurrentRedaction;
 end;//ISystem_TimeMachineStateChange_Params

 Op_System_TimeMachineStateChange = class
  {* ����� ��� ������ �������� System.TimeMachineStateChange }
  public
   class function Call(const aTarget: IvcmEntity;
    aStayInCurrentRedaction: Boolean = False): Boolean; overload;
    {* ����� �������� System.TimeMachineStateChange � �������� }
   class function Call(const aTarget: IvcmAggregate;
    aStayInCurrentRedaction: Boolean = False): Boolean; overload;
    {* ����� �������� System.TimeMachineStateChange � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    aStayInCurrentRedaction: Boolean = False): Boolean; overload;
    {* ����� �������� System.TimeMachineStateChange � ����� }
   class function Call(const aTarget: IvcmContainer;
    aStayInCurrentRedaction: Boolean = False): Boolean; overload;
    {* ����� �������� System.TimeMachineStateChange � ���������� }
   class procedure Broadcast(aStayInCurrentRedaction: Boolean = False);
    {* ����� �������� System.TimeMachineStateChange � ���� ������������������ ��������� }
 end;//Op_System_TimeMachineStateChange

 IContents_SetCurrent_Params = interface
  {* ��������� ��� �������� Contents.SetCurrent }
  ['{63B60DA6-E67A-4D05-8194-8CBFBC186C14}']
  function Get_Sub: Integer;
  property Sub: Integer
   read Get_Sub;
 end;//IContents_SetCurrent_Params

 Op_Contents_SetCurrent = class
  {* ����� ��� ������ �������� Contents.SetCurrent }
  public
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

 IContents_MoveCurrent_Params = interface
  {* ��������� ��� �������� Contents.MoveCurrent }
  ['{4F7D3966-D37A-4F3F-B435-413523D01CD7}']
  function Get_Sub: Integer;
  function Get_Down: Boolean;
  property Sub: Integer
   read Get_Sub;
  property Down: Boolean
   read Get_Down;
 end;//IContents_MoveCurrent_Params

 Op_Contents_MoveCurrent = class
  {* ����� ��� ������ �������� Contents.MoveCurrent }
  public
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

 IContents_HasUserComments_Params = interface
  {* ��������� ��� �������� Contents.HasUserComments }
  ['{B5B7276E-4C38-489E-B8EA-335CAA4DF145}']
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//IContents_HasUserComments_Params

 Op_Contents_HasUserComments = class
  {* ����� ��� ������ �������� Contents.HasUserComments }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� Contents.HasUserComments � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� Contents.HasUserComments � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� Contents.HasUserComments � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� Contents.HasUserComments � ���������� }
 end;//Op_Contents_HasUserComments

 IContents_HasBookmarks_Params = interface
  {* ��������� ��� �������� Contents.HasBookmarks }
  ['{70D89AEC-9A94-460E-BDA6-0E43352E7897}']
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//IContents_HasBookmarks_Params

 Op_Contents_HasBookmarks = class
  {* ����� ��� ������ �������� Contents.HasBookmarks }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� Contents.HasBookmarks � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� Contents.HasBookmarks � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� Contents.HasBookmarks � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� Contents.HasBookmarks � ���������� }
 end;//Op_Contents_HasBookmarks

 IContents_ToggleContentsVisibility_Params = interface
  {* ��������� ��� �������� Contents.ToggleContentsVisibility }
  ['{8F5D6186-6988-42D3-8F65-708CD881074F}']
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//IContents_ToggleContentsVisibility_Params

 Op_Contents_ToggleContentsVisibility = class
  {* ����� ��� ������ �������� Contents.ToggleContentsVisibility }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� Contents.ToggleContentsVisibility � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� Contents.ToggleContentsVisibility � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� Contents.ToggleContentsVisibility � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� Contents.ToggleContentsVisibility � ���������� }
 end;//Op_Contents_ToggleContentsVisibility

 IContents_IsContentsVisible_Params = interface
  {* ��������� ��� �������� Contents.IsContentsVisible }
  ['{E1AC8242-4977-4049-9A09-C907355ED7F6}']
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//IContents_IsContentsVisible_Params

 Op_Contents_IsContentsVisible = class
  {* ����� ��� ������ �������� Contents.IsContentsVisible }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� Contents.IsContentsVisible � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� Contents.IsContentsVisible � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� Contents.IsContentsVisible � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� Contents.IsContentsVisible � ���������� }
 end;//Op_Contents_IsContentsVisible

 IWarning_BecomeActive_Params = interface
  {* ��������� ��� �������� Warning.BecomeActive }
  ['{8C5435DC-692B-4F21-8EEF-D2D096386C0E}']
  function Get_SubID: TnsWarningSub;
  property SubID: TnsWarningSub
   read Get_SubID;
 end;//IWarning_BecomeActive_Params

 Op_Warning_BecomeActive = class
  {* ����� ��� ������ �������� Warning.BecomeActive }
  public
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

 IWarning_SwitchActive_Params = interface
  {* ��������� ��� �������� Warning.SwitchActive }
  ['{FFE6A34D-8019-458E-A0F2-D2A9FFCE4B84}']
  function Get_SubID: TnsWarningSub;
  property SubID: TnsWarningSub
   read Get_SubID;
 end;//IWarning_SwitchActive_Params

 Op_Warning_SwitchActive = class
  {* ����� ��� ������ �������� Warning.SwitchActive }
  public
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

 IPicture_InitNewContent_Params = interface
  {* ��������� ��� �������� Picture.InitNewContent }
  ['{CE6432BB-C0B5-4CF2-9078-68E5B203981A}']
  function Get_Data: InsLinkedObjectData;
  property Data: InsLinkedObjectData
   read Get_Data;
 end;//IPicture_InitNewContent_Params

 Op_Picture_InitNewContent = class
  {* ����� ��� ������ �������� Picture.InitNewContent }
  public
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

 IContentsValidator_IsDocumentAdornmentsChanged_Params = interface
  {* ��������� ��� �������� ContentsValidator.IsDocumentAdornmentsChanged }
  ['{17F041E4-CEDF-4EE2-972C-56865AE8181E}']
  function Get_New: InsDocumentAdornments;
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property New: InsDocumentAdornments
   read Get_New;
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//IContentsValidator_IsDocumentAdornmentsChanged_Params

 Op_ContentsValidator_IsDocumentAdornmentsChanged = class
  {* ����� ��� ������ �������� ContentsValidator.IsDocumentAdornmentsChanged }
  public
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
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� DocumentSubPanel.UpdateSubPanel � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� DocumentSubPanel.UpdateSubPanel � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� DocumentSubPanel.UpdateSubPanel � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� DocumentSubPanel.UpdateSubPanel � ���������� }
 end;//Op_DocumentSubPanel_UpdateSubPanel

 IBaseSearchPresentationHolder_GetBaseSearchPresentation_Params = interface
  {* ��������� ��� �������� BaseSearchPresentationHolder.GetBaseSearchPresentation }
  ['{C3E3A909-AA62-47CC-A4BD-7DBFD9851892}']
  function Get_ResultValue: InsBaseSearchPresentation;
  procedure Set_ResultValue(const aValue: InsBaseSearchPresentation);
  property ResultValue: InsBaseSearchPresentation
   read Get_ResultValue
   write Set_ResultValue;
 end;//IBaseSearchPresentationHolder_GetBaseSearchPresentation_Params

 Op_BaseSearchPresentationHolder_GetBaseSearchPresentation = class
  {* ����� ��� ������ �������� BaseSearchPresentationHolder.GetBaseSearchPresentation }
  public
   class function Call(const aTarget: IvcmEntity): InsBaseSearchPresentation; overload;
    {* ����� �������� BaseSearchPresentationHolder.GetBaseSearchPresentation � �������� }
   class function Call(const aTarget: IvcmAggregate): InsBaseSearchPresentation; overload;
    {* ����� �������� BaseSearchPresentationHolder.GetBaseSearchPresentation � ��������� }
   class function Call(const aTarget: IvcmEntityForm): InsBaseSearchPresentation; overload;
    {* ����� �������� BaseSearchPresentationHolder.GetBaseSearchPresentation � ����� }
   class function Call(const aTarget: IvcmContainer): InsBaseSearchPresentation; overload;
    {* ����� �������� BaseSearchPresentationHolder.GetBaseSearchPresentation � ���������� }
 end;//Op_BaseSearchPresentationHolder_GetBaseSearchPresentation
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3CProtoObject
;

type
 TEditions_SetCurrent_Params = class(Tl3CProtoObject, IEditions_SetCurrent_Params)
  {* ���������� IEditions_SetCurrent_Params }
  private
   f_Document: IDocument;
  protected
   function Get_Document: IDocument;
   procedure ClearFields; override;
  public
   constructor Create(const aDocument: IDocument); reintroduce;
    {* ����������� TEditions_SetCurrent_Params }
   class function Make(const aDocument: IDocument): IEditions_SetCurrent_Params; reintroduce;
    {* ������� TEditions_SetCurrent_Params }
 end;//TEditions_SetCurrent_Params

 TSystem_TimeMachineStateChange_Params = class(Tl3CProtoObject, ISystem_TimeMachineStateChange_Params)
  {* ���������� ISystem_TimeMachineStateChange_Params }
  private
   f_StayInCurrentRedaction: Boolean;
  protected
   function Get_StayInCurrentRedaction: Boolean;
  public
   constructor Create(aStayInCurrentRedaction: Boolean); reintroduce;
    {* ����������� TSystem_TimeMachineStateChange_Params }
   class function Make(aStayInCurrentRedaction: Boolean): ISystem_TimeMachineStateChange_Params; reintroduce;
    {* ������� TSystem_TimeMachineStateChange_Params }
 end;//TSystem_TimeMachineStateChange_Params

 TContents_SetCurrent_Params = class(Tl3CProtoObject, IContents_SetCurrent_Params)
  {* ���������� IContents_SetCurrent_Params }
  private
   f_Sub: Integer;
  protected
   function Get_Sub: Integer;
  public
   constructor Create(aSub: Integer); reintroduce;
    {* ����������� TContents_SetCurrent_Params }
   class function Make(aSub: Integer): IContents_SetCurrent_Params; reintroduce;
    {* ������� TContents_SetCurrent_Params }
 end;//TContents_SetCurrent_Params

 TContents_MoveCurrent_Params = class(Tl3CProtoObject, IContents_MoveCurrent_Params)
  {* ���������� IContents_MoveCurrent_Params }
  private
   f_Sub: Integer;
   f_Down: Boolean;
  protected
   function Get_Down: Boolean;
   function Get_Sub: Integer;
  public
   constructor Create(aSub: Integer;
    aDown: Boolean); reintroduce;
    {* ����������� TContents_MoveCurrent_Params }
   class function Make(aSub: Integer;
    aDown: Boolean): IContents_MoveCurrent_Params; reintroduce;
    {* ������� TContents_MoveCurrent_Params }
 end;//TContents_MoveCurrent_Params

 TContents_HasUserComments_Params = class(Tl3CProtoObject, IContents_HasUserComments_Params)
  {* ���������� IContents_HasUserComments_Params }
  private
   f_ResultValue: Boolean;
  protected
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
  public
   constructor Create; reintroduce;
    {* ����������� TContents_HasUserComments_Params }
   class function Make: IContents_HasUserComments_Params; reintroduce;
    {* ������� TContents_HasUserComments_Params }
 end;//TContents_HasUserComments_Params

 TContents_HasBookmarks_Params = class(Tl3CProtoObject, IContents_HasBookmarks_Params)
  {* ���������� IContents_HasBookmarks_Params }
  private
   f_ResultValue: Boolean;
  protected
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
  public
   constructor Create; reintroduce;
    {* ����������� TContents_HasBookmarks_Params }
   class function Make: IContents_HasBookmarks_Params; reintroduce;
    {* ������� TContents_HasBookmarks_Params }
 end;//TContents_HasBookmarks_Params

 TContents_ToggleContentsVisibility_Params = class(Tl3CProtoObject, IContents_ToggleContentsVisibility_Params)
  {* ���������� IContents_ToggleContentsVisibility_Params }
  private
   f_ResultValue: Boolean;
  protected
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
  public
   constructor Create; reintroduce;
    {* ����������� TContents_ToggleContentsVisibility_Params }
   class function Make: IContents_ToggleContentsVisibility_Params; reintroduce;
    {* ������� TContents_ToggleContentsVisibility_Params }
 end;//TContents_ToggleContentsVisibility_Params

 TContents_IsContentsVisible_Params = class(Tl3CProtoObject, IContents_IsContentsVisible_Params)
  {* ���������� IContents_IsContentsVisible_Params }
  private
   f_ResultValue: Boolean;
  protected
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
  public
   constructor Create; reintroduce;
    {* ����������� TContents_IsContentsVisible_Params }
   class function Make: IContents_IsContentsVisible_Params; reintroduce;
    {* ������� TContents_IsContentsVisible_Params }
 end;//TContents_IsContentsVisible_Params

 TWarning_BecomeActive_Params = class(Tl3CProtoObject, IWarning_BecomeActive_Params)
  {* ���������� IWarning_BecomeActive_Params }
  private
   f_SubID: TnsWarningSub;
  protected
   function Get_SubID: TnsWarningSub;
  public
   constructor Create(aSubID: TnsWarningSub); reintroduce;
    {* ����������� TWarning_BecomeActive_Params }
   class function Make(aSubID: TnsWarningSub): IWarning_BecomeActive_Params; reintroduce;
    {* ������� TWarning_BecomeActive_Params }
 end;//TWarning_BecomeActive_Params

 TWarning_SwitchActive_Params = class(Tl3CProtoObject, IWarning_SwitchActive_Params)
  {* ���������� IWarning_SwitchActive_Params }
  private
   f_SubID: TnsWarningSub;
  protected
   function Get_SubID: TnsWarningSub;
  public
   constructor Create(aSubID: TnsWarningSub); reintroduce;
    {* ����������� TWarning_SwitchActive_Params }
   class function Make(aSubID: TnsWarningSub): IWarning_SwitchActive_Params; reintroduce;
    {* ������� TWarning_SwitchActive_Params }
 end;//TWarning_SwitchActive_Params

 TPicture_InitNewContent_Params = class(Tl3CProtoObject, IPicture_InitNewContent_Params)
  {* ���������� IPicture_InitNewContent_Params }
  private
   f_Data: InsLinkedObjectData;
  protected
   function Get_Data: InsLinkedObjectData;
   procedure ClearFields; override;
  public
   constructor Create(const aData: InsLinkedObjectData); reintroduce;
    {* ����������� TPicture_InitNewContent_Params }
   class function Make(const aData: InsLinkedObjectData): IPicture_InitNewContent_Params; reintroduce;
    {* ������� TPicture_InitNewContent_Params }
 end;//TPicture_InitNewContent_Params

 TContentsValidator_IsDocumentAdornmentsChanged_Params = class(Tl3CProtoObject, IContentsValidator_IsDocumentAdornmentsChanged_Params)
  {* ���������� IContentsValidator_IsDocumentAdornmentsChanged_Params }
  private
   f_New: InsDocumentAdornments;
   f_ResultValue: Boolean;
  protected
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   function Get_New: InsDocumentAdornments;
   procedure ClearFields; override;
  public
   constructor Create(const aNew: InsDocumentAdornments); reintroduce;
    {* ����������� TContentsValidator_IsDocumentAdornmentsChanged_Params }
   class function Make(const aNew: InsDocumentAdornments): IContentsValidator_IsDocumentAdornmentsChanged_Params; reintroduce;
    {* ������� TContentsValidator_IsDocumentAdornmentsChanged_Params }
 end;//TContentsValidator_IsDocumentAdornmentsChanged_Params

 TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params = class(Tl3CProtoObject, IBaseSearchPresentationHolder_GetBaseSearchPresentation_Params)
  {* ���������� IBaseSearchPresentationHolder_GetBaseSearchPresentation_Params }
  private
   f_ResultValue: InsBaseSearchPresentation;
  protected
   function Get_ResultValue: InsBaseSearchPresentation;
   procedure Set_ResultValue(const aValue: InsBaseSearchPresentation);
   procedure ClearFields; override;
  public
   constructor Create; reintroduce;
    {* ����������� TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params }
   class function Make: IBaseSearchPresentationHolder_GetBaseSearchPresentation_Params; reintroduce;
    {* ������� TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params }
 end;//TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params

constructor TEditions_SetCurrent_Params.Create(const aDocument: IDocument);
 {* ����������� TEditions_SetCurrent_Params }
//#UC START# *029FDD562795_804368EB57C8_var*
//#UC END# *029FDD562795_804368EB57C8_var*
begin
//#UC START# *029FDD562795_804368EB57C8_impl*
 !!! Needs to be implemented !!!
//#UC END# *029FDD562795_804368EB57C8_impl*
end;//TEditions_SetCurrent_Params.Create

class function TEditions_SetCurrent_Params.Make(const aDocument: IDocument): IEditions_SetCurrent_Params;
 {* ������� TEditions_SetCurrent_Params }
var
 l_Inst : TEditions_SetCurrent_Params;
begin
 l_Inst := Create(aDocument);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TEditions_SetCurrent_Params.Make

function TEditions_SetCurrent_Params.Get_Document: IDocument;
//#UC START# *5687127ABA38_804368EB57C8get_var*
//#UC END# *5687127ABA38_804368EB57C8get_var*
begin
//#UC START# *5687127ABA38_804368EB57C8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *5687127ABA38_804368EB57C8get_impl*
end;//TEditions_SetCurrent_Params.Get_Document

procedure TEditions_SetCurrent_Params.ClearFields;
begin
 f_Document := nil;
 inherited;
end;//TEditions_SetCurrent_Params.ClearFields

class function Op_Editions_SetCurrent.Call(const aTarget: IvcmEntity;
 const aDocument: IDocument): Boolean;
 {* ����� �������� Editions.SetCurrent � �������� }
//#UC START# *D7115A457BA5_F65FF6F6E09E_var*
//#UC END# *D7115A457BA5_F65FF6F6E09E_var*
begin
//#UC START# *D7115A457BA5_F65FF6F6E09E_impl*
 !!! Needs to be implemented !!!
//#UC END# *D7115A457BA5_F65FF6F6E09E_impl*
end;//Op_Editions_SetCurrent.Call

class function Op_Editions_SetCurrent.Call(const aTarget: IvcmAggregate;
 const aDocument: IDocument): Boolean;
 {* ����� �������� Editions.SetCurrent � ��������� }
//#UC START# *07511A3405F6_F65FF6F6E09E_var*
//#UC END# *07511A3405F6_F65FF6F6E09E_var*
begin
//#UC START# *07511A3405F6_F65FF6F6E09E_impl*
 !!! Needs to be implemented !!!
//#UC END# *07511A3405F6_F65FF6F6E09E_impl*
end;//Op_Editions_SetCurrent.Call

class function Op_Editions_SetCurrent.Call(const aTarget: IvcmEntityForm;
 const aDocument: IDocument): Boolean;
 {* ����� �������� Editions.SetCurrent � ����� }
//#UC START# *79582622B9A7_F65FF6F6E09E_var*
//#UC END# *79582622B9A7_F65FF6F6E09E_var*
begin
//#UC START# *79582622B9A7_F65FF6F6E09E_impl*
 !!! Needs to be implemented !!!
//#UC END# *79582622B9A7_F65FF6F6E09E_impl*
end;//Op_Editions_SetCurrent.Call

class function Op_Editions_SetCurrent.Call(const aTarget: IvcmContainer;
 const aDocument: IDocument): Boolean;
 {* ����� �������� Editions.SetCurrent � ���������� }
//#UC START# *DEAFAD0F3702_F65FF6F6E09E_var*
//#UC END# *DEAFAD0F3702_F65FF6F6E09E_var*
begin
//#UC START# *DEAFAD0F3702_F65FF6F6E09E_impl*
 !!! Needs to be implemented !!!
//#UC END# *DEAFAD0F3702_F65FF6F6E09E_impl*
end;//Op_Editions_SetCurrent.Call

constructor TSystem_TimeMachineStateChange_Params.Create(aStayInCurrentRedaction: Boolean);
 {* ����������� TSystem_TimeMachineStateChange_Params }
//#UC START# *91524C4BF057_E9AE5C57BABE_var*
//#UC END# *91524C4BF057_E9AE5C57BABE_var*
begin
//#UC START# *91524C4BF057_E9AE5C57BABE_impl*
 !!! Needs to be implemented !!!
//#UC END# *91524C4BF057_E9AE5C57BABE_impl*
end;//TSystem_TimeMachineStateChange_Params.Create

class function TSystem_TimeMachineStateChange_Params.Make(aStayInCurrentRedaction: Boolean): ISystem_TimeMachineStateChange_Params;
 {* ������� TSystem_TimeMachineStateChange_Params }
var
 l_Inst : TSystem_TimeMachineStateChange_Params;
begin
 l_Inst := Create(aStayInCurrentRedaction);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TSystem_TimeMachineStateChange_Params.Make

function TSystem_TimeMachineStateChange_Params.Get_StayInCurrentRedaction: Boolean;
//#UC START# *7CCB281A1862_E9AE5C57BABEget_var*
//#UC END# *7CCB281A1862_E9AE5C57BABEget_var*
begin
//#UC START# *7CCB281A1862_E9AE5C57BABEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *7CCB281A1862_E9AE5C57BABEget_impl*
end;//TSystem_TimeMachineStateChange_Params.Get_StayInCurrentRedaction

class function Op_System_TimeMachineStateChange.Call(const aTarget: IvcmEntity;
 aStayInCurrentRedaction: Boolean = False): Boolean;
 {* ����� �������� System.TimeMachineStateChange � �������� }
//#UC START# *5CBC9F6719A8_960A769A44DC_var*
//#UC END# *5CBC9F6719A8_960A769A44DC_var*
begin
//#UC START# *5CBC9F6719A8_960A769A44DC_impl*
 !!! Needs to be implemented !!!
//#UC END# *5CBC9F6719A8_960A769A44DC_impl*
end;//Op_System_TimeMachineStateChange.Call

class function Op_System_TimeMachineStateChange.Call(const aTarget: IvcmAggregate;
 aStayInCurrentRedaction: Boolean = False): Boolean;
 {* ����� �������� System.TimeMachineStateChange � ��������� }
//#UC START# *8CFC5F55A3F8_960A769A44DC_var*
//#UC END# *8CFC5F55A3F8_960A769A44DC_var*
begin
//#UC START# *8CFC5F55A3F8_960A769A44DC_impl*
 !!! Needs to be implemented !!!
//#UC END# *8CFC5F55A3F8_960A769A44DC_impl*
end;//Op_System_TimeMachineStateChange.Call

class function Op_System_TimeMachineStateChange.Call(const aTarget: IvcmEntityForm;
 aStayInCurrentRedaction: Boolean = False): Boolean;
 {* ����� �������� System.TimeMachineStateChange � ����� }
//#UC START# *C57FAE380089_960A769A44DC_var*
//#UC END# *C57FAE380089_960A769A44DC_var*
begin
//#UC START# *C57FAE380089_960A769A44DC_impl*
 !!! Needs to be implemented !!!
//#UC END# *C57FAE380089_960A769A44DC_impl*
end;//Op_System_TimeMachineStateChange.Call

class function Op_System_TimeMachineStateChange.Call(const aTarget: IvcmContainer;
 aStayInCurrentRedaction: Boolean = False): Boolean;
 {* ����� �������� System.TimeMachineStateChange � ���������� }
//#UC START# *595F7219C4F3_960A769A44DC_var*
//#UC END# *595F7219C4F3_960A769A44DC_var*
begin
//#UC START# *595F7219C4F3_960A769A44DC_impl*
 !!! Needs to be implemented !!!
//#UC END# *595F7219C4F3_960A769A44DC_impl*
end;//Op_System_TimeMachineStateChange.Call

class procedure Op_System_TimeMachineStateChange.Broadcast(aStayInCurrentRedaction: Boolean = False);
 {* ����� �������� System.TimeMachineStateChange � ���� ������������������ ��������� }
//#UC START# *A583EB7B688F_960A769A44DC_var*
//#UC END# *A583EB7B688F_960A769A44DC_var*
begin
//#UC START# *A583EB7B688F_960A769A44DC_impl*
 !!! Needs to be implemented !!!
//#UC END# *A583EB7B688F_960A769A44DC_impl*
end;//Op_System_TimeMachineStateChange.Broadcast

constructor TContents_SetCurrent_Params.Create(aSub: Integer);
 {* ����������� TContents_SetCurrent_Params }
//#UC START# *EDFF86C13EC8_57F3B94A0870_var*
//#UC END# *EDFF86C13EC8_57F3B94A0870_var*
begin
//#UC START# *EDFF86C13EC8_57F3B94A0870_impl*
 !!! Needs to be implemented !!!
//#UC END# *EDFF86C13EC8_57F3B94A0870_impl*
end;//TContents_SetCurrent_Params.Create

class function TContents_SetCurrent_Params.Make(aSub: Integer): IContents_SetCurrent_Params;
 {* ������� TContents_SetCurrent_Params }
var
 l_Inst : TContents_SetCurrent_Params;
begin
 l_Inst := Create(aSub);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TContents_SetCurrent_Params.Make

function TContents_SetCurrent_Params.Get_Sub: Integer;
//#UC START# *4BDE9981FCAF_57F3B94A0870get_var*
//#UC END# *4BDE9981FCAF_57F3B94A0870get_var*
begin
//#UC START# *4BDE9981FCAF_57F3B94A0870get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDE9981FCAF_57F3B94A0870get_impl*
end;//TContents_SetCurrent_Params.Get_Sub

class function Op_Contents_SetCurrent.Call(const aTarget: IvcmEntity;
 aSub: Integer): Boolean;
 {* ����� �������� Contents.SetCurrent � �������� }
//#UC START# *54AE7BA5B13D_278ED22C13A3_var*
//#UC END# *54AE7BA5B13D_278ED22C13A3_var*
begin
//#UC START# *54AE7BA5B13D_278ED22C13A3_impl*
 !!! Needs to be implemented !!!
//#UC END# *54AE7BA5B13D_278ED22C13A3_impl*
end;//Op_Contents_SetCurrent.Call

class function Op_Contents_SetCurrent.Call(const aTarget: IvcmAggregate;
 aSub: Integer): Boolean;
 {* ����� �������� Contents.SetCurrent � ��������� }
//#UC START# *84EE3B953B8D_278ED22C13A3_var*
//#UC END# *84EE3B953B8D_278ED22C13A3_var*
begin
//#UC START# *84EE3B953B8D_278ED22C13A3_impl*
 !!! Needs to be implemented !!!
//#UC END# *84EE3B953B8D_278ED22C13A3_impl*
end;//Op_Contents_SetCurrent.Call

class function Op_Contents_SetCurrent.Call(const aTarget: IvcmEntityForm;
 aSub: Integer): Boolean;
 {* ����� �������� Contents.SetCurrent � ����� }
//#UC START# *837818D41D77_278ED22C13A3_var*
//#UC END# *837818D41D77_278ED22C13A3_var*
begin
//#UC START# *837818D41D77_278ED22C13A3_impl*
 !!! Needs to be implemented !!!
//#UC END# *837818D41D77_278ED22C13A3_impl*
end;//Op_Contents_SetCurrent.Call

class function Op_Contents_SetCurrent.Call(const aTarget: IvcmContainer;
 aSub: Integer): Boolean;
 {* ����� �������� Contents.SetCurrent � ���������� }
//#UC START# *850E03F406D8_278ED22C13A3_var*
//#UC END# *850E03F406D8_278ED22C13A3_var*
begin
//#UC START# *850E03F406D8_278ED22C13A3_impl*
 !!! Needs to be implemented !!!
//#UC END# *850E03F406D8_278ED22C13A3_impl*
end;//Op_Contents_SetCurrent.Call

constructor TContents_MoveCurrent_Params.Create(aSub: Integer;
 aDown: Boolean);
 {* ����������� TContents_MoveCurrent_Params }
//#UC START# *AB3E85FFAA4F_22A1531C8354_var*
//#UC END# *AB3E85FFAA4F_22A1531C8354_var*
begin
//#UC START# *AB3E85FFAA4F_22A1531C8354_impl*
 !!! Needs to be implemented !!!
//#UC END# *AB3E85FFAA4F_22A1531C8354_impl*
end;//TContents_MoveCurrent_Params.Create

class function TContents_MoveCurrent_Params.Make(aSub: Integer;
 aDown: Boolean): IContents_MoveCurrent_Params;
 {* ������� TContents_MoveCurrent_Params }
var
 l_Inst : TContents_MoveCurrent_Params;
begin
 l_Inst := Create(aSub, aDown);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TContents_MoveCurrent_Params.Make

function TContents_MoveCurrent_Params.Get_Down: Boolean;
//#UC START# *9FFAB71AFB8D_22A1531C8354get_var*
//#UC END# *9FFAB71AFB8D_22A1531C8354get_var*
begin
//#UC START# *9FFAB71AFB8D_22A1531C8354get_impl*
 !!! Needs to be implemented !!!
//#UC END# *9FFAB71AFB8D_22A1531C8354get_impl*
end;//TContents_MoveCurrent_Params.Get_Down

function TContents_MoveCurrent_Params.Get_Sub: Integer;
//#UC START# *A3A1A6FF2714_22A1531C8354get_var*
//#UC END# *A3A1A6FF2714_22A1531C8354get_var*
begin
//#UC START# *A3A1A6FF2714_22A1531C8354get_impl*
 !!! Needs to be implemented !!!
//#UC END# *A3A1A6FF2714_22A1531C8354get_impl*
end;//TContents_MoveCurrent_Params.Get_Sub

class function Op_Contents_MoveCurrent.Call(const aTarget: IvcmEntity;
 aSub: Integer;
 aDown: Boolean): Boolean;
 {* ����� �������� Contents.MoveCurrent � �������� }
//#UC START# *0D934A39FE43_1BB1961C4380_var*
//#UC END# *0D934A39FE43_1BB1961C4380_var*
begin
//#UC START# *0D934A39FE43_1BB1961C4380_impl*
 !!! Needs to be implemented !!!
//#UC END# *0D934A39FE43_1BB1961C4380_impl*
end;//Op_Contents_MoveCurrent.Call

class function Op_Contents_MoveCurrent.Call(const aTarget: IvcmAggregate;
 aSub: Integer;
 aDown: Boolean): Boolean;
 {* ����� �������� Contents.MoveCurrent � ��������� }
//#UC START# *3DD30A298893_1BB1961C4380_var*
//#UC END# *3DD30A298893_1BB1961C4380_var*
begin
//#UC START# *3DD30A298893_1BB1961C4380_impl*
 !!! Needs to be implemented !!!
//#UC END# *3DD30A298893_1BB1961C4380_impl*
end;//Op_Contents_MoveCurrent.Call

class function Op_Contents_MoveCurrent.Call(const aTarget: IvcmEntityForm;
 aSub: Integer;
 aDown: Boolean): Boolean;
 {* ����� �������� Contents.MoveCurrent � ����� }
//#UC START# *46CC44782815_1BB1961C4380_var*
//#UC END# *46CC44782815_1BB1961C4380_var*
begin
//#UC START# *46CC44782815_1BB1961C4380_impl*
 !!! Needs to be implemented !!!
//#UC END# *46CC44782815_1BB1961C4380_impl*
end;//Op_Contents_MoveCurrent.Call

class function Op_Contents_MoveCurrent.Call(const aTarget: IvcmContainer;
 aSub: Integer;
 aDown: Boolean): Boolean;
 {* ����� �������� Contents.MoveCurrent � ���������� }
//#UC START# *65301C32DEBE_1BB1961C4380_var*
//#UC END# *65301C32DEBE_1BB1961C4380_var*
begin
//#UC START# *65301C32DEBE_1BB1961C4380_impl*
 !!! Needs to be implemented !!!
//#UC END# *65301C32DEBE_1BB1961C4380_impl*
end;//Op_Contents_MoveCurrent.Call

constructor TContents_HasUserComments_Params.Create;
 {* ����������� TContents_HasUserComments_Params }
//#UC START# *9F173E5F409C_651B2EB75884_var*
//#UC END# *9F173E5F409C_651B2EB75884_var*
begin
//#UC START# *9F173E5F409C_651B2EB75884_impl*
 !!! Needs to be implemented !!!
//#UC END# *9F173E5F409C_651B2EB75884_impl*
end;//TContents_HasUserComments_Params.Create

class function TContents_HasUserComments_Params.Make: IContents_HasUserComments_Params;
 {* ������� TContents_HasUserComments_Params }
var
 l_Inst : TContents_HasUserComments_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TContents_HasUserComments_Params.Make

function TContents_HasUserComments_Params.Get_ResultValue: Boolean;
//#UC START# *35B957603990_651B2EB75884get_var*
//#UC END# *35B957603990_651B2EB75884get_var*
begin
//#UC START# *35B957603990_651B2EB75884get_impl*
 !!! Needs to be implemented !!!
//#UC END# *35B957603990_651B2EB75884get_impl*
end;//TContents_HasUserComments_Params.Get_ResultValue

procedure TContents_HasUserComments_Params.Set_ResultValue(aValue: Boolean);
//#UC START# *35B957603990_651B2EB75884set_var*
//#UC END# *35B957603990_651B2EB75884set_var*
begin
//#UC START# *35B957603990_651B2EB75884set_impl*
 !!! Needs to be implemented !!!
//#UC END# *35B957603990_651B2EB75884set_impl*
end;//TContents_HasUserComments_Params.Set_ResultValue

class function Op_Contents_HasUserComments.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� Contents.HasUserComments � �������� }
//#UC START# *0A52033C859D_187AC391FFA7_var*
//#UC END# *0A52033C859D_187AC391FFA7_var*
begin
//#UC START# *0A52033C859D_187AC391FFA7_impl*
 !!! Needs to be implemented !!!
//#UC END# *0A52033C859D_187AC391FFA7_impl*
end;//Op_Contents_HasUserComments.Call

class function Op_Contents_HasUserComments.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� Contents.HasUserComments � ��������� }
//#UC START# *3A91C32C0FED_187AC391FFA7_var*
//#UC END# *3A91C32C0FED_187AC391FFA7_var*
begin
//#UC START# *3A91C32C0FED_187AC391FFA7_impl*
 !!! Needs to be implemented !!!
//#UC END# *3A91C32C0FED_187AC391FFA7_impl*
end;//Op_Contents_HasUserComments.Call

class function Op_Contents_HasUserComments.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� Contents.HasUserComments � ����� }
//#UC START# *6E8831C8BE35_187AC391FFA7_var*
//#UC END# *6E8831C8BE35_187AC391FFA7_var*
begin
//#UC START# *6E8831C8BE35_187AC391FFA7_impl*
 !!! Needs to be implemented !!!
//#UC END# *6E8831C8BE35_187AC391FFA7_impl*
end;//Op_Contents_HasUserComments.Call

class function Op_Contents_HasUserComments.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� Contents.HasUserComments � ���������� }
//#UC START# *F8D87784FDEA_187AC391FFA7_var*
//#UC END# *F8D87784FDEA_187AC391FFA7_var*
begin
//#UC START# *F8D87784FDEA_187AC391FFA7_impl*
 !!! Needs to be implemented !!!
//#UC END# *F8D87784FDEA_187AC391FFA7_impl*
end;//Op_Contents_HasUserComments.Call

constructor TContents_HasBookmarks_Params.Create;
 {* ����������� TContents_HasBookmarks_Params }
//#UC START# *FC55CE667DF9_CB1885E8E977_var*
//#UC END# *FC55CE667DF9_CB1885E8E977_var*
begin
//#UC START# *FC55CE667DF9_CB1885E8E977_impl*
 !!! Needs to be implemented !!!
//#UC END# *FC55CE667DF9_CB1885E8E977_impl*
end;//TContents_HasBookmarks_Params.Create

class function TContents_HasBookmarks_Params.Make: IContents_HasBookmarks_Params;
 {* ������� TContents_HasBookmarks_Params }
var
 l_Inst : TContents_HasBookmarks_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TContents_HasBookmarks_Params.Make

function TContents_HasBookmarks_Params.Get_ResultValue: Boolean;
//#UC START# *264BAD44CB13_CB1885E8E977get_var*
//#UC END# *264BAD44CB13_CB1885E8E977get_var*
begin
//#UC START# *264BAD44CB13_CB1885E8E977get_impl*
 !!! Needs to be implemented !!!
//#UC END# *264BAD44CB13_CB1885E8E977get_impl*
end;//TContents_HasBookmarks_Params.Get_ResultValue

procedure TContents_HasBookmarks_Params.Set_ResultValue(aValue: Boolean);
//#UC START# *264BAD44CB13_CB1885E8E977set_var*
//#UC END# *264BAD44CB13_CB1885E8E977set_var*
begin
//#UC START# *264BAD44CB13_CB1885E8E977set_impl*
 !!! Needs to be implemented !!!
//#UC END# *264BAD44CB13_CB1885E8E977set_impl*
end;//TContents_HasBookmarks_Params.Set_ResultValue

class function Op_Contents_HasBookmarks.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� Contents.HasBookmarks � �������� }
//#UC START# *AD6FCD168CE3_182198D75D19_var*
//#UC END# *AD6FCD168CE3_182198D75D19_var*
begin
//#UC START# *AD6FCD168CE3_182198D75D19_impl*
 !!! Needs to be implemented !!!
//#UC END# *AD6FCD168CE3_182198D75D19_impl*
end;//Op_Contents_HasBookmarks.Call

class function Op_Contents_HasBookmarks.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� Contents.HasBookmarks � ��������� }
//#UC START# *DDAF8D051733_182198D75D19_var*
//#UC END# *DDAF8D051733_182198D75D19_var*
begin
//#UC START# *DDAF8D051733_182198D75D19_impl*
 !!! Needs to be implemented !!!
//#UC END# *DDAF8D051733_182198D75D19_impl*
end;//Op_Contents_HasBookmarks.Call

class function Op_Contents_HasBookmarks.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� Contents.HasBookmarks � ����� }
//#UC START# *20E29D7061CD_182198D75D19_var*
//#UC END# *20E29D7061CD_182198D75D19_var*
begin
//#UC START# *20E29D7061CD_182198D75D19_impl*
 !!! Needs to be implemented !!!
//#UC END# *20E29D7061CD_182198D75D19_impl*
end;//Op_Contents_HasBookmarks.Call

class function Op_Contents_HasBookmarks.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� Contents.HasBookmarks � ���������� }
//#UC START# *30EAF27BACF1_182198D75D19_var*
//#UC END# *30EAF27BACF1_182198D75D19_var*
begin
//#UC START# *30EAF27BACF1_182198D75D19_impl*
 !!! Needs to be implemented !!!
//#UC END# *30EAF27BACF1_182198D75D19_impl*
end;//Op_Contents_HasBookmarks.Call

constructor TContents_ToggleContentsVisibility_Params.Create;
 {* ����������� TContents_ToggleContentsVisibility_Params }
//#UC START# *C4478EFB111D_655809521596_var*
//#UC END# *C4478EFB111D_655809521596_var*
begin
//#UC START# *C4478EFB111D_655809521596_impl*
 !!! Needs to be implemented !!!
//#UC END# *C4478EFB111D_655809521596_impl*
end;//TContents_ToggleContentsVisibility_Params.Create

class function TContents_ToggleContentsVisibility_Params.Make: IContents_ToggleContentsVisibility_Params;
 {* ������� TContents_ToggleContentsVisibility_Params }
var
 l_Inst : TContents_ToggleContentsVisibility_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TContents_ToggleContentsVisibility_Params.Make

function TContents_ToggleContentsVisibility_Params.Get_ResultValue: Boolean;
//#UC START# *65DE917B8156_655809521596get_var*
//#UC END# *65DE917B8156_655809521596get_var*
begin
//#UC START# *65DE917B8156_655809521596get_impl*
 !!! Needs to be implemented !!!
//#UC END# *65DE917B8156_655809521596get_impl*
end;//TContents_ToggleContentsVisibility_Params.Get_ResultValue

procedure TContents_ToggleContentsVisibility_Params.Set_ResultValue(aValue: Boolean);
//#UC START# *65DE917B8156_655809521596set_var*
//#UC END# *65DE917B8156_655809521596set_var*
begin
//#UC START# *65DE917B8156_655809521596set_impl*
 !!! Needs to be implemented !!!
//#UC END# *65DE917B8156_655809521596set_impl*
end;//TContents_ToggleContentsVisibility_Params.Set_ResultValue

class function Op_Contents_ToggleContentsVisibility.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� Contents.ToggleContentsVisibility � �������� }
//#UC START# *2AD77F89B3DD_E7CE4E3803C5_var*
//#UC END# *2AD77F89B3DD_E7CE4E3803C5_var*
begin
//#UC START# *2AD77F89B3DD_E7CE4E3803C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *2AD77F89B3DD_E7CE4E3803C5_impl*
end;//Op_Contents_ToggleContentsVisibility.Call

class function Op_Contents_ToggleContentsVisibility.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� Contents.ToggleContentsVisibility � ��������� }
//#UC START# *5B173F793E2D_E7CE4E3803C5_var*
//#UC END# *5B173F793E2D_E7CE4E3803C5_var*
begin
//#UC START# *5B173F793E2D_E7CE4E3803C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *5B173F793E2D_E7CE4E3803C5_impl*
end;//Op_Contents_ToggleContentsVisibility.Call

class function Op_Contents_ToggleContentsVisibility.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� Contents.ToggleContentsVisibility � ����� }
//#UC START# *2BFB0B9A330D_E7CE4E3803C5_var*
//#UC END# *2BFB0B9A330D_E7CE4E3803C5_var*
begin
//#UC START# *2BFB0B9A330D_E7CE4E3803C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *2BFB0B9A330D_E7CE4E3803C5_impl*
end;//Op_Contents_ToggleContentsVisibility.Call

class function Op_Contents_ToggleContentsVisibility.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� Contents.ToggleContentsVisibility � ���������� }
//#UC START# *5F6EEB3636E4_E7CE4E3803C5_var*
//#UC END# *5F6EEB3636E4_E7CE4E3803C5_var*
begin
//#UC START# *5F6EEB3636E4_E7CE4E3803C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *5F6EEB3636E4_E7CE4E3803C5_impl*
end;//Op_Contents_ToggleContentsVisibility.Call

constructor TContents_IsContentsVisible_Params.Create;
 {* ����������� TContents_IsContentsVisible_Params }
//#UC START# *22B59A817425_12AB68D44650_var*
//#UC END# *22B59A817425_12AB68D44650_var*
begin
//#UC START# *22B59A817425_12AB68D44650_impl*
 !!! Needs to be implemented !!!
//#UC END# *22B59A817425_12AB68D44650_impl*
end;//TContents_IsContentsVisible_Params.Create

class function TContents_IsContentsVisible_Params.Make: IContents_IsContentsVisible_Params;
 {* ������� TContents_IsContentsVisible_Params }
var
 l_Inst : TContents_IsContentsVisible_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TContents_IsContentsVisible_Params.Make

function TContents_IsContentsVisible_Params.Get_ResultValue: Boolean;
//#UC START# *697189C9879C_12AB68D44650get_var*
//#UC END# *697189C9879C_12AB68D44650get_var*
begin
//#UC START# *697189C9879C_12AB68D44650get_impl*
 !!! Needs to be implemented !!!
//#UC END# *697189C9879C_12AB68D44650get_impl*
end;//TContents_IsContentsVisible_Params.Get_ResultValue

procedure TContents_IsContentsVisible_Params.Set_ResultValue(aValue: Boolean);
//#UC START# *697189C9879C_12AB68D44650set_var*
//#UC END# *697189C9879C_12AB68D44650set_var*
begin
//#UC START# *697189C9879C_12AB68D44650set_impl*
 !!! Needs to be implemented !!!
//#UC END# *697189C9879C_12AB68D44650set_impl*
end;//TContents_IsContentsVisible_Params.Set_ResultValue

class function Op_Contents_IsContentsVisible.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� Contents.IsContentsVisible � �������� }
//#UC START# *6EA5DCEC87EA_924B310A5493_var*
//#UC END# *6EA5DCEC87EA_924B310A5493_var*
begin
//#UC START# *6EA5DCEC87EA_924B310A5493_impl*
 !!! Needs to be implemented !!!
//#UC END# *6EA5DCEC87EA_924B310A5493_impl*
end;//Op_Contents_IsContentsVisible.Call

class function Op_Contents_IsContentsVisible.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� Contents.IsContentsVisible � ��������� }
//#UC START# *9EE59CDB123A_924B310A5493_var*
//#UC END# *9EE59CDB123A_924B310A5493_var*
begin
//#UC START# *9EE59CDB123A_924B310A5493_impl*
 !!! Needs to be implemented !!!
//#UC END# *9EE59CDB123A_924B310A5493_impl*
end;//Op_Contents_IsContentsVisible.Call

class function Op_Contents_IsContentsVisible.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� Contents.IsContentsVisible � ����� }
//#UC START# *5EBD213909BF_924B310A5493_var*
//#UC END# *5EBD213909BF_924B310A5493_var*
begin
//#UC START# *5EBD213909BF_924B310A5493_impl*
 !!! Needs to be implemented !!!
//#UC END# *5EBD213909BF_924B310A5493_impl*
end;//Op_Contents_IsContentsVisible.Call

class function Op_Contents_IsContentsVisible.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� Contents.IsContentsVisible � ���������� }
//#UC START# *E0EA4E37BA01_924B310A5493_var*
//#UC END# *E0EA4E37BA01_924B310A5493_var*
begin
//#UC START# *E0EA4E37BA01_924B310A5493_impl*
 !!! Needs to be implemented !!!
//#UC END# *E0EA4E37BA01_924B310A5493_impl*
end;//Op_Contents_IsContentsVisible.Call

constructor TWarning_BecomeActive_Params.Create(aSubID: TnsWarningSub);
 {* ����������� TWarning_BecomeActive_Params }
//#UC START# *D48C1B1C2AE7_AA0355168DE6_var*
//#UC END# *D48C1B1C2AE7_AA0355168DE6_var*
begin
//#UC START# *D48C1B1C2AE7_AA0355168DE6_impl*
 !!! Needs to be implemented !!!
//#UC END# *D48C1B1C2AE7_AA0355168DE6_impl*
end;//TWarning_BecomeActive_Params.Create

class function TWarning_BecomeActive_Params.Make(aSubID: TnsWarningSub): IWarning_BecomeActive_Params;
 {* ������� TWarning_BecomeActive_Params }
var
 l_Inst : TWarning_BecomeActive_Params;
begin
 l_Inst := Create(aSubID);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TWarning_BecomeActive_Params.Make

function TWarning_BecomeActive_Params.Get_SubID: TnsWarningSub;
//#UC START# *ACC3EC984096_AA0355168DE6get_var*
//#UC END# *ACC3EC984096_AA0355168DE6get_var*
begin
//#UC START# *ACC3EC984096_AA0355168DE6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *ACC3EC984096_AA0355168DE6get_impl*
end;//TWarning_BecomeActive_Params.Get_SubID

class function Op_Warning_BecomeActive.Call(const aTarget: IvcmEntity;
 aSubID: TnsWarningSub): Boolean;
 {* ����� �������� Warning.BecomeActive � �������� }
//#UC START# *7CDCD3738AC1_F97FA6AC7624_var*
//#UC END# *7CDCD3738AC1_F97FA6AC7624_var*
begin
//#UC START# *7CDCD3738AC1_F97FA6AC7624_impl*
 !!! Needs to be implemented !!!
//#UC END# *7CDCD3738AC1_F97FA6AC7624_impl*
end;//Op_Warning_BecomeActive.Call

class function Op_Warning_BecomeActive.Call(const aTarget: IvcmAggregate;
 aSubID: TnsWarningSub): Boolean;
 {* ����� �������� Warning.BecomeActive � ��������� }
//#UC START# *AD1C93631511_F97FA6AC7624_var*
//#UC END# *AD1C93631511_F97FA6AC7624_var*
begin
//#UC START# *AD1C93631511_F97FA6AC7624_impl*
 !!! Needs to be implemented !!!
//#UC END# *AD1C93631511_F97FA6AC7624_impl*
end;//Op_Warning_BecomeActive.Call

class function Op_Warning_BecomeActive.Call(const aTarget: IvcmEntityForm;
 aSubID: TnsWarningSub): Boolean;
 {* ����� �������� Warning.BecomeActive � ����� }
//#UC START# *8CB9FB720247_F97FA6AC7624_var*
//#UC END# *8CB9FB720247_F97FA6AC7624_var*
begin
//#UC START# *8CB9FB720247_F97FA6AC7624_impl*
 !!! Needs to be implemented !!!
//#UC END# *8CB9FB720247_F97FA6AC7624_impl*
end;//Op_Warning_BecomeActive.Call

class function Op_Warning_BecomeActive.Call(const aTarget: IvcmContainer;
 aSubID: TnsWarningSub): Boolean;
 {* ����� �������� Warning.BecomeActive � ���������� }
//#UC START# *F3C41B9AAEA3_F97FA6AC7624_var*
//#UC END# *F3C41B9AAEA3_F97FA6AC7624_var*
begin
//#UC START# *F3C41B9AAEA3_F97FA6AC7624_impl*
 !!! Needs to be implemented !!!
//#UC END# *F3C41B9AAEA3_F97FA6AC7624_impl*
end;//Op_Warning_BecomeActive.Call

constructor TWarning_SwitchActive_Params.Create(aSubID: TnsWarningSub);
 {* ����������� TWarning_SwitchActive_Params }
//#UC START# *8917D5B096A2_D560DF6E073B_var*
//#UC END# *8917D5B096A2_D560DF6E073B_var*
begin
//#UC START# *8917D5B096A2_D560DF6E073B_impl*
 !!! Needs to be implemented !!!
//#UC END# *8917D5B096A2_D560DF6E073B_impl*
end;//TWarning_SwitchActive_Params.Create

class function TWarning_SwitchActive_Params.Make(aSubID: TnsWarningSub): IWarning_SwitchActive_Params;
 {* ������� TWarning_SwitchActive_Params }
var
 l_Inst : TWarning_SwitchActive_Params;
begin
 l_Inst := Create(aSubID);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TWarning_SwitchActive_Params.Make

function TWarning_SwitchActive_Params.Get_SubID: TnsWarningSub;
//#UC START# *A4AED59A47B8_D560DF6E073Bget_var*
//#UC END# *A4AED59A47B8_D560DF6E073Bget_var*
begin
//#UC START# *A4AED59A47B8_D560DF6E073Bget_impl*
 !!! Needs to be implemented !!!
//#UC END# *A4AED59A47B8_D560DF6E073Bget_impl*
end;//TWarning_SwitchActive_Params.Get_SubID

class function Op_Warning_SwitchActive.Call(const aTarget: IvcmEntity;
 aSubID: TnsWarningSub): Boolean;
 {* ����� �������� Warning.SwitchActive � �������� }
//#UC START# *57DE09C5E0EA_A0C4D9C117E2_var*
//#UC END# *57DE09C5E0EA_A0C4D9C117E2_var*
begin
//#UC START# *57DE09C5E0EA_A0C4D9C117E2_impl*
 !!! Needs to be implemented !!!
//#UC END# *57DE09C5E0EA_A0C4D9C117E2_impl*
end;//Op_Warning_SwitchActive.Call

class function Op_Warning_SwitchActive.Call(const aTarget: IvcmAggregate;
 aSubID: TnsWarningSub): Boolean;
 {* ����� �������� Warning.SwitchActive � ��������� }
//#UC START# *881DC9B46B3A_A0C4D9C117E2_var*
//#UC END# *881DC9B46B3A_A0C4D9C117E2_var*
begin
//#UC START# *881DC9B46B3A_A0C4D9C117E2_impl*
 !!! Needs to be implemented !!!
//#UC END# *881DC9B46B3A_A0C4D9C117E2_impl*
end;//Op_Warning_SwitchActive.Call

class function Op_Warning_SwitchActive.Call(const aTarget: IvcmEntityForm;
 aSubID: TnsWarningSub): Boolean;
 {* ����� �������� Warning.SwitchActive � ����� }
//#UC START# *685833AE26F5_A0C4D9C117E2_var*
//#UC END# *685833AE26F5_A0C4D9C117E2_var*
begin
//#UC START# *685833AE26F5_A0C4D9C117E2_impl*
 !!! Needs to be implemented !!!
//#UC END# *685833AE26F5_A0C4D9C117E2_impl*
end;//Op_Warning_SwitchActive.Call

class function Op_Warning_SwitchActive.Call(const aTarget: IvcmContainer;
 aSubID: TnsWarningSub): Boolean;
 {* ����� �������� Warning.SwitchActive � ���������� }
//#UC START# *77055EEA2F62_A0C4D9C117E2_var*
//#UC END# *77055EEA2F62_A0C4D9C117E2_var*
begin
//#UC START# *77055EEA2F62_A0C4D9C117E2_impl*
 !!! Needs to be implemented !!!
//#UC END# *77055EEA2F62_A0C4D9C117E2_impl*
end;//Op_Warning_SwitchActive.Call

constructor TPicture_InitNewContent_Params.Create(const aData: InsLinkedObjectData);
 {* ����������� TPicture_InitNewContent_Params }
//#UC START# *02E25259F1FB_F4681B18E4AB_var*
//#UC END# *02E25259F1FB_F4681B18E4AB_var*
begin
//#UC START# *02E25259F1FB_F4681B18E4AB_impl*
 !!! Needs to be implemented !!!
//#UC END# *02E25259F1FB_F4681B18E4AB_impl*
end;//TPicture_InitNewContent_Params.Create

class function TPicture_InitNewContent_Params.Make(const aData: InsLinkedObjectData): IPicture_InitNewContent_Params;
 {* ������� TPicture_InitNewContent_Params }
var
 l_Inst : TPicture_InitNewContent_Params;
begin
 l_Inst := Create(aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TPicture_InitNewContent_Params.Make

function TPicture_InitNewContent_Params.Get_Data: InsLinkedObjectData;
//#UC START# *FEB4DEC501A8_F4681B18E4ABget_var*
//#UC END# *FEB4DEC501A8_F4681B18E4ABget_var*
begin
//#UC START# *FEB4DEC501A8_F4681B18E4ABget_impl*
 !!! Needs to be implemented !!!
//#UC END# *FEB4DEC501A8_F4681B18E4ABget_impl*
end;//TPicture_InitNewContent_Params.Get_Data

procedure TPicture_InitNewContent_Params.ClearFields;
begin
 f_Data := nil;
 inherited;
end;//TPicture_InitNewContent_Params.ClearFields

class function Op_Picture_InitNewContent.Call(const aTarget: IvcmEntity;
 const aData: InsLinkedObjectData): Boolean;
 {* ����� �������� Picture.InitNewContent � �������� }
//#UC START# *29D34F730AF9_F36300A04E7E_var*
//#UC END# *29D34F730AF9_F36300A04E7E_var*
begin
//#UC START# *29D34F730AF9_F36300A04E7E_impl*
 !!! Needs to be implemented !!!
//#UC END# *29D34F730AF9_F36300A04E7E_impl*
end;//Op_Picture_InitNewContent.Call

class function Op_Picture_InitNewContent.Call(const aTarget: IvcmAggregate;
 const aData: InsLinkedObjectData): Boolean;
 {* ����� �������� Picture.InitNewContent � ��������� }
//#UC START# *5A130F619549_F36300A04E7E_var*
//#UC END# *5A130F619549_F36300A04E7E_var*
begin
//#UC START# *5A130F619549_F36300A04E7E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5A130F619549_F36300A04E7E_impl*
end;//Op_Picture_InitNewContent.Call

class function Op_Picture_InitNewContent.Call(const aTarget: IvcmEntityForm;
 const aData: InsLinkedObjectData): Boolean;
 {* ����� �������� Picture.InitNewContent � ����� }
//#UC START# *C1F991D62CF3_F36300A04E7E_var*
//#UC END# *C1F991D62CF3_F36300A04E7E_var*
begin
//#UC START# *C1F991D62CF3_F36300A04E7E_impl*
 !!! Needs to be implemented !!!
//#UC END# *C1F991D62CF3_F36300A04E7E_impl*
end;//Op_Picture_InitNewContent.Call

class function Op_Picture_InitNewContent.Call(const aTarget: IvcmContainer;
 const aData: InsLinkedObjectData): Boolean;
 {* ����� �������� Picture.InitNewContent � ���������� }
//#UC START# *AEB1E5B53016_F36300A04E7E_var*
//#UC END# *AEB1E5B53016_F36300A04E7E_var*
begin
//#UC START# *AEB1E5B53016_F36300A04E7E_impl*
 !!! Needs to be implemented !!!
//#UC END# *AEB1E5B53016_F36300A04E7E_impl*
end;//Op_Picture_InitNewContent.Call

constructor TContentsValidator_IsDocumentAdornmentsChanged_Params.Create(const aNew: InsDocumentAdornments);
 {* ����������� TContentsValidator_IsDocumentAdornmentsChanged_Params }
//#UC START# *B5274B138F27_A71AD1EB8CF4_var*
//#UC END# *B5274B138F27_A71AD1EB8CF4_var*
begin
//#UC START# *B5274B138F27_A71AD1EB8CF4_impl*
 !!! Needs to be implemented !!!
//#UC END# *B5274B138F27_A71AD1EB8CF4_impl*
end;//TContentsValidator_IsDocumentAdornmentsChanged_Params.Create

class function TContentsValidator_IsDocumentAdornmentsChanged_Params.Make(const aNew: InsDocumentAdornments): IContentsValidator_IsDocumentAdornmentsChanged_Params;
 {* ������� TContentsValidator_IsDocumentAdornmentsChanged_Params }
var
 l_Inst : TContentsValidator_IsDocumentAdornmentsChanged_Params;
begin
 l_Inst := Create(aNew);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TContentsValidator_IsDocumentAdornmentsChanged_Params.Make

function TContentsValidator_IsDocumentAdornmentsChanged_Params.Get_ResultValue: Boolean;
//#UC START# *1A74E61081C3_A71AD1EB8CF4get_var*
//#UC END# *1A74E61081C3_A71AD1EB8CF4get_var*
begin
//#UC START# *1A74E61081C3_A71AD1EB8CF4get_impl*
 !!! Needs to be implemented !!!
//#UC END# *1A74E61081C3_A71AD1EB8CF4get_impl*
end;//TContentsValidator_IsDocumentAdornmentsChanged_Params.Get_ResultValue

procedure TContentsValidator_IsDocumentAdornmentsChanged_Params.Set_ResultValue(aValue: Boolean);
//#UC START# *1A74E61081C3_A71AD1EB8CF4set_var*
//#UC END# *1A74E61081C3_A71AD1EB8CF4set_var*
begin
//#UC START# *1A74E61081C3_A71AD1EB8CF4set_impl*
 !!! Needs to be implemented !!!
//#UC END# *1A74E61081C3_A71AD1EB8CF4set_impl*
end;//TContentsValidator_IsDocumentAdornmentsChanged_Params.Set_ResultValue

function TContentsValidator_IsDocumentAdornmentsChanged_Params.Get_New: InsDocumentAdornments;
//#UC START# *9CEF0395616A_A71AD1EB8CF4get_var*
//#UC END# *9CEF0395616A_A71AD1EB8CF4get_var*
begin
//#UC START# *9CEF0395616A_A71AD1EB8CF4get_impl*
 !!! Needs to be implemented !!!
//#UC END# *9CEF0395616A_A71AD1EB8CF4get_impl*
end;//TContentsValidator_IsDocumentAdornmentsChanged_Params.Get_New

procedure TContentsValidator_IsDocumentAdornmentsChanged_Params.ClearFields;
begin
 f_New := nil;
 inherited;
end;//TContentsValidator_IsDocumentAdornmentsChanged_Params.ClearFields

class function Op_ContentsValidator_IsDocumentAdornmentsChanged.Call(const aTarget: IvcmEntity;
 const aNew: InsDocumentAdornments): Boolean;
 {* ����� �������� ContentsValidator.IsDocumentAdornmentsChanged � �������� }
//#UC START# *2FC23BB31FC7_3774AC7445CF_var*
//#UC END# *2FC23BB31FC7_3774AC7445CF_var*
begin
//#UC START# *2FC23BB31FC7_3774AC7445CF_impl*
 !!! Needs to be implemented !!!
//#UC END# *2FC23BB31FC7_3774AC7445CF_impl*
end;//Op_ContentsValidator_IsDocumentAdornmentsChanged.Call

class function Op_ContentsValidator_IsDocumentAdornmentsChanged.Call(const aTarget: IvcmAggregate;
 const aNew: InsDocumentAdornments): Boolean;
 {* ����� �������� ContentsValidator.IsDocumentAdornmentsChanged � ��������� }
//#UC START# *6001FBA2AA17_3774AC7445CF_var*
//#UC END# *6001FBA2AA17_3774AC7445CF_var*
begin
//#UC START# *6001FBA2AA17_3774AC7445CF_impl*
 !!! Needs to be implemented !!!
//#UC END# *6001FBA2AA17_3774AC7445CF_impl*
end;//Op_ContentsValidator_IsDocumentAdornmentsChanged.Call

class function Op_ContentsValidator_IsDocumentAdornmentsChanged.Call(const aTarget: IvcmEntityForm;
 const aNew: InsDocumentAdornments): Boolean;
 {* ����� �������� ContentsValidator.IsDocumentAdornmentsChanged � ����� }
//#UC START# *039431D4ADC0_3774AC7445CF_var*
//#UC END# *039431D4ADC0_3774AC7445CF_var*
begin
//#UC START# *039431D4ADC0_3774AC7445CF_impl*
 !!! Needs to be implemented !!!
//#UC END# *039431D4ADC0_3774AC7445CF_impl*
end;//Op_ContentsValidator_IsDocumentAdornmentsChanged.Call

class function Op_ContentsValidator_IsDocumentAdornmentsChanged.Call(const aTarget: IvcmContainer;
 const aNew: InsDocumentAdornments): Boolean;
 {* ����� �������� ContentsValidator.IsDocumentAdornmentsChanged � ���������� }
//#UC START# *0E0022342FAF_3774AC7445CF_var*
//#UC END# *0E0022342FAF_3774AC7445CF_var*
begin
//#UC START# *0E0022342FAF_3774AC7445CF_impl*
 !!! Needs to be implemented !!!
//#UC END# *0E0022342FAF_3774AC7445CF_impl*
end;//Op_ContentsValidator_IsDocumentAdornmentsChanged.Call

class function Op_DocumentSubPanel_UpdateSubPanel.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� DocumentSubPanel.UpdateSubPanel � �������� }
//#UC START# *EEAC10A317BA_F8D6068331F6_var*
//#UC END# *EEAC10A317BA_F8D6068331F6_var*
begin
//#UC START# *EEAC10A317BA_F8D6068331F6_impl*
 !!! Needs to be implemented !!!
//#UC END# *EEAC10A317BA_F8D6068331F6_impl*
end;//Op_DocumentSubPanel_UpdateSubPanel.Call

class function Op_DocumentSubPanel_UpdateSubPanel.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� DocumentSubPanel.UpdateSubPanel � ��������� }
//#UC START# *1EEBD092A20B_F8D6068331F6_var*
//#UC END# *1EEBD092A20B_F8D6068331F6_var*
begin
//#UC START# *1EEBD092A20B_F8D6068331F6_impl*
 !!! Needs to be implemented !!!
//#UC END# *1EEBD092A20B_F8D6068331F6_impl*
end;//Op_DocumentSubPanel_UpdateSubPanel.Call

class function Op_DocumentSubPanel_UpdateSubPanel.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� DocumentSubPanel.UpdateSubPanel � ����� }
//#UC START# *0D45C0BF7B50_F8D6068331F6_var*
//#UC END# *0D45C0BF7B50_F8D6068331F6_var*
begin
//#UC START# *0D45C0BF7B50_F8D6068331F6_impl*
 !!! Needs to be implemented !!!
//#UC END# *0D45C0BF7B50_F8D6068331F6_impl*
end;//Op_DocumentSubPanel_UpdateSubPanel.Call

class function Op_DocumentSubPanel_UpdateSubPanel.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� DocumentSubPanel.UpdateSubPanel � ���������� }
//#UC START# *7A2CFD67CE57_F8D6068331F6_var*
//#UC END# *7A2CFD67CE57_F8D6068331F6_var*
begin
//#UC START# *7A2CFD67CE57_F8D6068331F6_impl*
 !!! Needs to be implemented !!!
//#UC END# *7A2CFD67CE57_F8D6068331F6_impl*
end;//Op_DocumentSubPanel_UpdateSubPanel.Call

constructor TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params.Create;
 {* ����������� TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params }
//#UC START# *C346BA5860F9_40CED96C73B9_var*
//#UC END# *C346BA5860F9_40CED96C73B9_var*
begin
//#UC START# *C346BA5860F9_40CED96C73B9_impl*
 !!! Needs to be implemented !!!
//#UC END# *C346BA5860F9_40CED96C73B9_impl*
end;//TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params.Create

class function TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params.Make: IBaseSearchPresentationHolder_GetBaseSearchPresentation_Params;
 {* ������� TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params }
var
 l_Inst : TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params.Make

function TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params.Get_ResultValue: InsBaseSearchPresentation;
//#UC START# *2E3A1F2E3290_40CED96C73B9get_var*
//#UC END# *2E3A1F2E3290_40CED96C73B9get_var*
begin
//#UC START# *2E3A1F2E3290_40CED96C73B9get_impl*
 !!! Needs to be implemented !!!
//#UC END# *2E3A1F2E3290_40CED96C73B9get_impl*
end;//TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params.Get_ResultValue

procedure TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params.Set_ResultValue(const aValue: InsBaseSearchPresentation);
//#UC START# *2E3A1F2E3290_40CED96C73B9set_var*
//#UC END# *2E3A1F2E3290_40CED96C73B9set_var*
begin
//#UC START# *2E3A1F2E3290_40CED96C73B9set_impl*
 !!! Needs to be implemented !!!
//#UC END# *2E3A1F2E3290_40CED96C73B9set_impl*
end;//TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params.Set_ResultValue

procedure TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params.ClearFields;
begin
 f_ResultValue := nil;
 inherited;
end;//TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params.ClearFields

class function Op_BaseSearchPresentationHolder_GetBaseSearchPresentation.Call(const aTarget: IvcmEntity): InsBaseSearchPresentation;
 {* ����� �������� BaseSearchPresentationHolder.GetBaseSearchPresentation � �������� }
//#UC START# *03EBE82AC26B_A80593BFCAD9_var*
//#UC END# *03EBE82AC26B_A80593BFCAD9_var*
begin
//#UC START# *03EBE82AC26B_A80593BFCAD9_impl*
 !!! Needs to be implemented !!!
//#UC END# *03EBE82AC26B_A80593BFCAD9_impl*
end;//Op_BaseSearchPresentationHolder_GetBaseSearchPresentation.Call

class function Op_BaseSearchPresentationHolder_GetBaseSearchPresentation.Call(const aTarget: IvcmAggregate): InsBaseSearchPresentation;
 {* ����� �������� BaseSearchPresentationHolder.GetBaseSearchPresentation � ��������� }
//#UC START# *E6EFA50E4CBB_A80593BFCAD9_var*
//#UC END# *E6EFA50E4CBB_A80593BFCAD9_var*
begin
//#UC START# *E6EFA50E4CBB_A80593BFCAD9_impl*
 !!! Needs to be implemented !!!
//#UC END# *E6EFA50E4CBB_A80593BFCAD9_impl*
end;//Op_BaseSearchPresentationHolder_GetBaseSearchPresentation.Call

class function Op_BaseSearchPresentationHolder_GetBaseSearchPresentation.Call(const aTarget: IvcmEntityForm): InsBaseSearchPresentation;
 {* ����� �������� BaseSearchPresentationHolder.GetBaseSearchPresentation � ����� }
//#UC START# *D775BB9F31C3_A80593BFCAD9_var*
//#UC END# *D775BB9F31C3_A80593BFCAD9_var*
begin
//#UC START# *D775BB9F31C3_A80593BFCAD9_impl*
 !!! Needs to be implemented !!!
//#UC END# *D775BB9F31C3_A80593BFCAD9_impl*
end;//Op_BaseSearchPresentationHolder_GetBaseSearchPresentation.Call

class function Op_BaseSearchPresentationHolder_GetBaseSearchPresentation.Call(const aTarget: IvcmContainer): InsBaseSearchPresentation;
 {* ����� �������� BaseSearchPresentationHolder.GetBaseSearchPresentation � ���������� }
//#UC START# *95453F567EB1_A80593BFCAD9_var*
//#UC END# *95453F567EB1_A80593BFCAD9_var*
begin
//#UC START# *95453F567EB1_A80593BFCAD9_impl*
 !!! Needs to be implemented !!!
//#UC END# *95453F567EB1_A80593BFCAD9_impl*
end;//Op_BaseSearchPresentationHolder_GetBaseSearchPresentation.Call
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
