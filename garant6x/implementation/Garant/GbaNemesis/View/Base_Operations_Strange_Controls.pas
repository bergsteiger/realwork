unit Base_Operations_Strange_Controls;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Base_Operations_Strange_Controls.pas"
// ���������: "VCMControls"
// ������� ������: "Strange" MUID: (4A9807DB01A5)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , FoldersUnit
 , DocumentUnit
 , l3Interfaces
 , nevBase
 , l3TreeInterfaces
 , l3Tree_TLB
 , eeInterfaces
 , DocumentAndListInterfaces
 , Base_Operations_Editions_Controls
 , PrimPrimListInterfaces
 , nsTypes
 , l3Variant
 , bsTypesNew
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Op_Switcher_BecomeActive = {final} class
  {* ����� ��� ������ �������� Switcher.BecomeActive }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� Switcher.BecomeActive � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� Switcher.BecomeActive � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� Switcher.BecomeActive � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� Switcher.BecomeActive � ���������� }
 end;//Op_Switcher_BecomeActive

 IDocument_FindExplanation_Params = interface
  {* ��������� ��� �������� Document.FindExplanation }
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//IDocument_FindExplanation_Params

 Op_Document_FindExplanation = {final} class
  {* ����� ��� ������ �������� Document.FindExplanation }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� Document.FindExplanation � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� Document.FindExplanation � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� Document.FindExplanation � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� Document.FindExplanation � ���������� }
 end;//Op_Document_FindExplanation

 ISynchroView_BecomeActive_Params = interface
  {* ��������� ��� �������� SynchroView.BecomeActive }
  function Get_FormType: TnsShowSynchroForm;
  property FormType: TnsShowSynchroForm
   read Get_FormType;
 end;//ISynchroView_BecomeActive_Params

 Op_SynchroView_BecomeActive = {final} class
  {* ����� ��� ������ �������� SynchroView.BecomeActive }
  public
   class function Call(const aTarget: IvcmEntity;
    aFormType: TnsShowSynchroForm): Boolean; overload;
    {* ����� �������� SynchroView.BecomeActive � �������� }
   class function Call(const aTarget: IvcmAggregate;
    aFormType: TnsShowSynchroForm): Boolean; overload;
    {* ����� �������� SynchroView.BecomeActive � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    aFormType: TnsShowSynchroForm): Boolean; overload;
    {* ����� �������� SynchroView.BecomeActive � ����� }
   class function Call(const aTarget: IvcmContainer;
    aFormType: TnsShowSynchroForm): Boolean; overload;
    {* ����� �������� SynchroView.BecomeActive � ���������� }
 end;//Op_SynchroView_BecomeActive

 IList_GetDeList_Params = interface
  {* ��������� ��� �������� List.GetDeList }
  function Get_ResultValue: IdeList;
  procedure Set_ResultValue(const aValue: IdeList);
  property ResultValue: IdeList
   read Get_ResultValue
   write Set_ResultValue;
 end;//IList_GetDeList_Params

 Op_List_GetDeList = {final} class
  {* ����� ��� ������ �������� List.GetDeList }
  public
   class function Call(const aTarget: IvcmEntity): IdeList; overload;
    {* ����� �������� List.GetDeList � �������� }
   class function Call(const aTarget: IvcmAggregate): IdeList; overload;
    {* ����� �������� List.GetDeList � ��������� }
   class function Call(const aTarget: IvcmEntityForm): IdeList; overload;
    {* ����� �������� List.GetDeList � ����� }
   class function Call(const aTarget: IvcmContainer): IdeList; overload;
    {* ����� �������� List.GetDeList � ���������� }
 end;//Op_List_GetDeList

 Op_List_SetCurrentVisible = {final} class
  {* ����� ��� ������ �������� List.SetCurrentVisible }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� List.SetCurrentVisible � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� List.SetCurrentVisible � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� List.SetCurrentVisible � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� List.SetCurrentVisible � ���������� }
 end;//Op_List_SetCurrentVisible

 IList_GetDsList_Params = interface
  {* ��������� ��� �������� List.GetDsList }
  function Get_ResultValue: IdsList;
  procedure Set_ResultValue(const aValue: IdsList);
  property ResultValue: IdsList
   read Get_ResultValue
   write Set_ResultValue;
 end;//IList_GetDsList_Params

 Op_List_GetDsList = {final} class
  {* ����� ��� ������ �������� List.GetDsList }
  public
   class function Call(const aTarget: IvcmEntity): IdsList; overload;
    {* ����� �������� List.GetDsList � �������� }
   class function Call(const aTarget: IvcmAggregate): IdsList; overload;
    {* ����� �������� List.GetDsList � ��������� }
   class function Call(const aTarget: IvcmEntityForm): IdsList; overload;
    {* ����� �������� List.GetDsList � ����� }
   class function Call(const aTarget: IvcmContainer): IdsList; overload;
    {* ����� �������� List.GetDsList � ���������� }
 end;//Op_List_GetDsList

 Op_Form_RequestClose = {final} class
  {* ����� ��� ������ �������� Form.RequestClose }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� Form.RequestClose � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� Form.RequestClose � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� Form.RequestClose � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� Form.RequestClose � ���������� }
 end;//Op_Form_RequestClose

 Op_ControlCenter_Refresh = {final} class
  {* ����� ��� ������ �������� ControlCenter.Refresh }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� ControlCenter.Refresh � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� ControlCenter.Refresh � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� ControlCenter.Refresh � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� ControlCenter.Refresh � ���������� }
 end;//Op_ControlCenter_Refresh

 Op_ListInfo_BecomeActive = {final} class
  {* ����� ��� ������ �������� ListInfo.BecomeActive }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� ListInfo.BecomeActive � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� ListInfo.BecomeActive � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� ListInfo.BecomeActive � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� ListInfo.BecomeActive � ���������� }
 end;//Op_ListInfo_BecomeActive

 Op_Filters_DeselectAll = {final} class
  {* ����� ��� ������ �������� Filters.DeselectAll }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� Filters.DeselectAll � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� Filters.DeselectAll � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� Filters.DeselectAll � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� Filters.DeselectAll � ���������� }
 end;//Op_Filters_DeselectAll

 Op_TimeMachine_TimeMachineOnOff = {final} class
  {* ����� ��� ������ �������� TimeMachine.TimeMachineOnOff }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� TimeMachine.TimeMachineOnOff � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� TimeMachine.TimeMachineOnOff � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� TimeMachine.TimeMachineOnOff � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� TimeMachine.TimeMachineOnOff � ���������� }
 end;//Op_TimeMachine_TimeMachineOnOff

 Op_TimeMachine_TimeMachineOffAndReset = {final} class
  {* ����� ��� ������ �������� TimeMachine.TimeMachineOffAndReset }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� TimeMachine.TimeMachineOffAndReset � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� TimeMachine.TimeMachineOffAndReset � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� TimeMachine.TimeMachineOffAndReset � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� TimeMachine.TimeMachineOffAndReset � ���������� }
 end;//Op_TimeMachine_TimeMachineOffAndReset

 IFilter_ActivateNode_Params = interface
  {* ��������� ��� �������� Filter.ActivateNode }
  function Get_Node: Il3Node;
  property Node: Il3Node
   read Get_Node;
 end;//IFilter_ActivateNode_Params

 Op_Filter_ActivateNode = {final} class
  {* ����� ��� ������ �������� Filter.ActivateNode }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNode: Il3Node): Boolean; overload;
    {* ����� �������� Filter.ActivateNode � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: Il3Node): Boolean; overload;
    {* ����� �������� Filter.ActivateNode � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: Il3Node): Boolean; overload;
    {* ����� �������� Filter.ActivateNode � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aNode: Il3Node): Boolean; overload;
    {* ����� �������� Filter.ActivateNode � ���������� }
 end;//Op_Filter_ActivateNode

 IFoldersControl_EditElement_Params = interface
  {* ��������� ��� �������� FoldersControl.EditElement }
  function Get_Node: IFoldersNode;
  property Node: IFoldersNode
   read Get_Node;
 end;//IFoldersControl_EditElement_Params

 Op_FoldersControl_EditElement = {final} class
  {* ����� ��� ������ �������� FoldersControl.EditElement }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNode: IFoldersNode): Boolean; overload;
    {* ����� �������� FoldersControl.EditElement � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: IFoldersNode): Boolean; overload;
    {* ����� �������� FoldersControl.EditElement � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: IFoldersNode): Boolean; overload;
    {* ����� �������� FoldersControl.EditElement � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aNode: IFoldersNode): Boolean; overload;
    {* ����� �������� FoldersControl.EditElement � ���������� }
 end;//Op_FoldersControl_EditElement

 IFoldersControl_DeleteElement_Params = interface
  {* ��������� ��� �������� FoldersControl.DeleteElement }
  function Get_Node: IFoldersNode;
  function Get_ResultValue: TnsDeleteResult;
  procedure Set_ResultValue(aValue: TnsDeleteResult);
  property Node: IFoldersNode
   read Get_Node;
  property ResultValue: TnsDeleteResult
   read Get_ResultValue
   write Set_ResultValue;
 end;//IFoldersControl_DeleteElement_Params

 Op_FoldersControl_DeleteElement = {final} class
  {* ����� ��� ������ �������� FoldersControl.DeleteElement }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNode: IFoldersNode): TnsDeleteResult; overload;
    {* ����� �������� FoldersControl.DeleteElement � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: IFoldersNode): TnsDeleteResult; overload;
    {* ����� �������� FoldersControl.DeleteElement � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: IFoldersNode): TnsDeleteResult; overload;
    {* ����� �������� FoldersControl.DeleteElement � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aNode: IFoldersNode): TnsDeleteResult; overload;
    {* ����� �������� FoldersControl.DeleteElement � ���������� }
 end;//Op_FoldersControl_DeleteElement

 Op_Filters_InternalClear = {final} class
  {* ����� ��� ������ �������� Filters.InternalClear }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� Filters.InternalClear � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� Filters.InternalClear � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� Filters.InternalClear � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� Filters.InternalClear � ���������� }
 end;//Op_Filters_InternalClear

 IDocument_SetActive_Params = interface
  {* ��������� ��� �������� Document.SetActive }
  function Get_UserType: Integer;
  property UserType: Integer
   read Get_UserType;
 end;//IDocument_SetActive_Params

 Op_Document_SetActive = {final} class
  {* ����� ��� ������ �������� Document.SetActive }
  public
   class function Call(const aTarget: IvcmEntity;
    aUserType: Integer): Boolean; overload;
    {* ����� �������� Document.SetActive � �������� }
   class function Call(const aTarget: IvcmAggregate;
    aUserType: Integer): Boolean; overload;
    {* ����� �������� Document.SetActive � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    aUserType: Integer): Boolean; overload;
    {* ����� �������� Document.SetActive � ����� }
   class function Call(const aTarget: IvcmContainer;
    aUserType: Integer): Boolean; overload;
    {* ����� �������� Document.SetActive � ���������� }
 end;//Op_Document_SetActive

 IDocument_ExportBlock_Params = interface
  {* ��������� ��� �������� Document.ExportBlock }
  function Get_Data: IUnknown;
  function Get_UserType: Integer;
  function Get_ToActiveWindow: Boolean;
  property Data: IUnknown
   read Get_Data;
  property UserType: Integer
   read Get_UserType;
  property ToActiveWindow: Boolean
   read Get_ToActiveWindow;
 end;//IDocument_ExportBlock_Params

 Op_Document_ExportBlock = {final} class
  {* ����� ��� ������ �������� Document.ExportBlock }
  public
   class function Call(const aTarget: IvcmEntity;
    const aData: IUnknown;
    aUserType: Integer;
    aToActiveWindow: Boolean): Boolean; overload;
    {* ����� �������� Document.ExportBlock � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aData: IUnknown;
    aUserType: Integer;
    aToActiveWindow: Boolean): Boolean; overload;
    {* ����� �������� Document.ExportBlock � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aData: IUnknown;
    aUserType: Integer;
    aToActiveWindow: Boolean): Boolean; overload;
    {* ����� �������� Document.ExportBlock � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aData: IUnknown;
    aUserType: Integer;
    aToActiveWindow: Boolean): Boolean; overload;
    {* ����� �������� Document.ExportBlock � ���������� }
 end;//Op_Document_ExportBlock

 IDocument_GetCurrentPosition_Params = interface
  {* ��������� ��� �������� Document.GetCurrentPosition }
  function Get_ResultValue: Integer;
  procedure Set_ResultValue(aValue: Integer);
  property ResultValue: Integer
   read Get_ResultValue
   write Set_ResultValue;
 end;//IDocument_GetCurrentPosition_Params

 Op_Document_GetCurrentPosition = {final} class
  {* ����� ��� ������ �������� Document.GetCurrentPosition }
  public
   class function Call(const aTarget: IvcmEntity): Integer; overload;
    {* ����� �������� Document.GetCurrentPosition � �������� }
   class function Call(const aTarget: IvcmAggregate): Integer; overload;
    {* ����� �������� Document.GetCurrentPosition � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Integer; overload;
    {* ����� �������� Document.GetCurrentPosition � ����� }
   class function Call(const aTarget: IvcmContainer): Integer; overload;
    {* ����� �������� Document.GetCurrentPosition � ���������� }
 end;//Op_Document_GetCurrentPosition

 IDocument_SelectBlock_Params = interface
  {* ��������� ��� �������� Document.SelectBlock }
  function Get_Data: IUnknown;
  function Get_UserType: Integer;
  property Data: IUnknown
   read Get_Data;
  property UserType: Integer
   read Get_UserType;
 end;//IDocument_SelectBlock_Params

 Op_Document_SelectBlock = {final} class
  {* ����� ��� ������ �������� Document.SelectBlock }
  public
   class function Call(const aTarget: IvcmEntity;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* ����� �������� Document.SelectBlock � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* ����� �������� Document.SelectBlock � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* ����� �������� Document.SelectBlock � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* ����� �������� Document.SelectBlock � ���������� }
 end;//Op_Document_SelectBlock

 IDocument_CopyBlock_Params = interface
  {* ��������� ��� �������� Document.CopyBlock }
  function Get_Data: IUnknown;
  function Get_UserType: Integer;
  property Data: IUnknown
   read Get_Data;
  property UserType: Integer
   read Get_UserType;
 end;//IDocument_CopyBlock_Params

 Op_Document_CopyBlock = {final} class
  {* ����� ��� ������ �������� Document.CopyBlock }
  public
   class function Call(const aTarget: IvcmEntity;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* ����� �������� Document.CopyBlock � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* ����� �������� Document.CopyBlock � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* ����� �������� Document.CopyBlock � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* ����� �������� Document.CopyBlock � ���������� }
 end;//Op_Document_CopyBlock

 IDocument_PrintBlock_Params = interface
  {* ��������� ��� �������� Document.PrintBlock }
  function Get_Data: IUnknown;
  function Get_UserType: Integer;
  property Data: IUnknown
   read Get_Data;
  property UserType: Integer
   read Get_UserType;
 end;//IDocument_PrintBlock_Params

 Op_Document_PrintBlock = {final} class
  {* ����� ��� ������ �������� Document.PrintBlock }
  public
   class function Call(const aTarget: IvcmEntity;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* ����� �������� Document.PrintBlock � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* ����� �������� Document.PrintBlock � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* ����� �������� Document.PrintBlock � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* ����� �������� Document.PrintBlock � ���������� }
 end;//Op_Document_PrintBlock

 IDocument_PrintDialogBlock_Params = interface
  {* ��������� ��� �������� Document.PrintDialogBlock }
  function Get_Data: IUnknown;
  function Get_UserType: Integer;
  property Data: IUnknown
   read Get_Data;
  property UserType: Integer
   read Get_UserType;
 end;//IDocument_PrintDialogBlock_Params

 Op_Document_PrintDialogBlock = {final} class
  {* ����� ��� ������ �������� Document.PrintDialogBlock }
  public
   class function Call(const aTarget: IvcmEntity;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* ����� �������� Document.PrintDialogBlock � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* ����� �������� Document.PrintDialogBlock � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* ����� �������� Document.PrintDialogBlock � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* ����� �������� Document.PrintDialogBlock � ���������� }
 end;//Op_Document_PrintDialogBlock

 IDocument_PreviewBlock_Params = interface
  {* ��������� ��� �������� Document.PreviewBlock }
  function Get_Data: IUnknown;
  function Get_UserType: Integer;
  property Data: IUnknown
   read Get_Data;
  property UserType: Integer
   read Get_UserType;
 end;//IDocument_PreviewBlock_Params

 Op_Document_PreviewBlock = {final} class
  {* ����� ��� ������ �������� Document.PreviewBlock }
  public
   class function Call(const aTarget: IvcmEntity;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* ����� �������� Document.PreviewBlock � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* ����� �������� Document.PreviewBlock � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* ����� �������� Document.PreviewBlock � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* ����� �������� Document.PreviewBlock � ���������� }
 end;//Op_Document_PreviewBlock

 IDocument_ShowRespondentListToPart_Params = interface
  {* ��������� ��� �������� Document.ShowRespondentListToPart }
  function Get_List: IPositionList;
  function Get_Current: Il3SimpleNode;
  property List: IPositionList
   read Get_List;
  property Current: Il3SimpleNode
   read Get_Current;
 end;//IDocument_ShowRespondentListToPart_Params

 Op_Document_ShowRespondentListToPart = {final} class
  {* ����� ��� ������ �������� Document.ShowRespondentListToPart }
  public
   class function Call(const aTarget: IvcmEntity;
    const aList: IPositionList;
    const aCurrent: Il3SimpleNode = nil): Boolean; overload;
    {* ����� �������� Document.ShowRespondentListToPart � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aList: IPositionList;
    const aCurrent: Il3SimpleNode = nil): Boolean; overload;
    {* ����� �������� Document.ShowRespondentListToPart � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aList: IPositionList;
    const aCurrent: Il3SimpleNode = nil): Boolean; overload;
    {* ����� �������� Document.ShowRespondentListToPart � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aList: IPositionList;
    const aCurrent: Il3SimpleNode = nil): Boolean; overload;
    {* ����� �������� Document.ShowRespondentListToPart � ���������� }
 end;//Op_Document_ShowRespondentListToPart

 IDocument_ShowCorrespondentListToPart_Params = interface
  {* ��������� ��� �������� Document.ShowCorrespondentListToPart }
  function Get_List: IPositionList;
  function Get_Current: Il3SimpleNode;
  property List: IPositionList
   read Get_List;
  property Current: Il3SimpleNode
   read Get_Current;
 end;//IDocument_ShowCorrespondentListToPart_Params

 Op_Document_ShowCorrespondentListToPart = {final} class
  {* ����� ��� ������ �������� Document.ShowCorrespondentListToPart }
  public
   class function Call(const aTarget: IvcmEntity;
    const aList: IPositionList;
    const aCurrent: Il3SimpleNode = nil): Boolean; overload;
    {* ����� �������� Document.ShowCorrespondentListToPart � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aList: IPositionList;
    const aCurrent: Il3SimpleNode = nil): Boolean; overload;
    {* ����� �������� Document.ShowCorrespondentListToPart � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aList: IPositionList;
    const aCurrent: Il3SimpleNode = nil): Boolean; overload;
    {* ����� �������� Document.ShowCorrespondentListToPart � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aList: IPositionList;
    const aCurrent: Il3SimpleNode = nil): Boolean; overload;
    {* ����� �������� Document.ShowCorrespondentListToPart � ���������� }
 end;//Op_Document_ShowCorrespondentListToPart

 IDocument_ModifyBookmarkNotify_Params = interface
  {* ��������� ��� �������� Document.ModifyBookmarkNotify }
  function Get_nEntity: IUnknown;
  property nEntity: IUnknown
   read Get_nEntity;
 end;//IDocument_ModifyBookmarkNotify_Params

 Op_Document_ModifyBookmarkNotify = {final} class
  {* ����� ��� ������ �������� Document.ModifyBookmarkNotify }
  public
   class function Call(const aTarget: IvcmEntity;
    const anEntity: IUnknown): Boolean; overload;
    {* ����� �������� Document.ModifyBookmarkNotify � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const anEntity: IUnknown): Boolean; overload;
    {* ����� �������� Document.ModifyBookmarkNotify � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const anEntity: IUnknown): Boolean; overload;
    {* ����� �������� Document.ModifyBookmarkNotify � ����� }
   class function Call(const aTarget: IvcmContainer;
    const anEntity: IUnknown): Boolean; overload;
    {* ����� �������� Document.ModifyBookmarkNotify � ���������� }
   class procedure Broadcast(const anEntity: IUnknown);
    {* ����� �������� Document.ModifyBookmarkNotify � ���� ������������������ ��������� }
 end;//Op_Document_ModifyBookmarkNotify

 IDocument_AddBookmarkFromContents_Params = interface
  {* ��������� ��� �������� Document.AddBookmarkFromContents }
  function Get_Tag: Il3TagRef;
  property Tag: Il3TagRef
   read Get_Tag;
 end;//IDocument_AddBookmarkFromContents_Params

 Op_Document_AddBookmarkFromContents = {final} class
  {* ����� ��� ������ �������� Document.AddBookmarkFromContents }
  public
   class function Call(const aTarget: IvcmEntity;
    const aTag: Il3TagRef): Boolean; overload;
    {* ����� �������� Document.AddBookmarkFromContents � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aTag: Il3TagRef): Boolean; overload;
    {* ����� �������� Document.AddBookmarkFromContents � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aTag: Il3TagRef): Boolean; overload;
    {* ����� �������� Document.AddBookmarkFromContents � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aTag: Il3TagRef): Boolean; overload;
    {* ����� �������� Document.AddBookmarkFromContents � ���������� }
 end;//Op_Document_AddBookmarkFromContents

 Op_Document_OpenNotSureTopic = {final} class
  {* ����� ��� ������ �������� Document.OpenNotSureTopic }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� Document.OpenNotSureTopic � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� Document.OpenNotSureTopic � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� Document.OpenNotSureTopic � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� Document.OpenNotSureTopic � ���������� }
 end;//Op_Document_OpenNotSureTopic

 IDocument_GotoPara_Params = interface
  {* ��������� ��� �������� Document.GotoPara }
  function Get_Para: Il3TagRef;
  function Get_UserType: Integer;
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property Para: Il3TagRef
   read Get_Para;
  property UserType: Integer
   read Get_UserType;
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//IDocument_GotoPara_Params

 Op_Document_GotoPara = {final} class
  {* ����� ��� ������ �������� Document.GotoPara }
  public
   class function Call(const aTarget: IvcmEntity;
    const aPara: Il3TagRef;
    aUserType: Integer): Boolean; overload;
    {* ����� �������� Document.GotoPara � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aPara: Il3TagRef;
    aUserType: Integer): Boolean; overload;
    {* ����� �������� Document.GotoPara � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aPara: Il3TagRef;
    aUserType: Integer): Boolean; overload;
    {* ����� �������� Document.GotoPara � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aPara: Il3TagRef;
    aUserType: Integer): Boolean; overload;
    {* ����� �������� Document.GotoPara � ���������� }
 end;//Op_Document_GotoPara

const
 en_Switcher = 'Switcher';
 en_capSwitcher = '';
 op_BecomeActive = 'BecomeActive';
 op_capBecomeActive = '';
 en_Document = 'Document';
 en_capDocument = '��������';
 op_FindExplanation = 'FindExplanation';
 op_capFindExplanation = '����� ����������';
 en_SynchroView = 'SynchroView';
 en_capSynchroView = '';
 en_List = 'List';
 en_capList = '';
 op_GetDeList = 'GetDeList';
 op_capGetDeList = '';
 op_SetCurrentVisible = 'SetCurrentVisible';
 op_capSetCurrentVisible = '';
 op_SwitchToFullList = 'SwitchToFullList';
 op_capSwitchToFullList = '��������� ������ ������';
 op_GetDsList = 'GetDsList';
 op_capGetDsList = '';
 en_Form = 'Form';
 en_capForm = '';
 op_RequestClose = 'RequestClose';
 op_capRequestClose = '';
 en_ControlCenter = 'ControlCenter';
 en_capControlCenter = '';
 op_Refresh = 'Refresh';
 op_capRefresh = '';
 en_ListInfo = 'ListInfo';
 en_capListInfo = '';
 en_Filters = 'Filters';
 en_capFilters = '';
 op_DeselectAll = 'DeselectAll';
 op_capDeselectAll = '';
 en_LocalList = 'LocalList';
 en_capLocalList = '������ (����������� ��������)';
 op_SearchInList = 'SearchInList';
 op_capSearchInList = '������ �� ���������� � ������� ������';
 op_PublishSourceSearchInList = 'PublishSourceSearchInList';
 op_capPublishSourceSearchInList = '������ �� ��������� ������������� � ������� ������';
 op_Open = 'Open';
 op_capOpen = '';
 op_SearchDrugInList = 'SearchDrugInList';
 op_capSearchDrugInList = '';
 op_OpenNewWindow = 'OpenNewWindow';
 op_capOpenNewWindow = '������� ������� ������ � ����� ����';
 en_TimeMachine = 'TimeMachine';
 en_capTimeMachine = '';
 op_TimeMachineOnOffNew = 'TimeMachineOnOffNew';
 op_capTimeMachineOnOffNew = '�������� ������ �������';
 op_TimeMachineOnOff = 'TimeMachineOnOff';
 op_capTimeMachineOnOff = '';
 op_TimeMachineOffAndReset = 'TimeMachineOffAndReset';
 op_capTimeMachineOffAndReset = '';
 en_Filter = 'Filter';
 en_capFilter = '';
 op_Activate = 'Activate';
 op_capActivate = '��������� ������';
 op_ActivateNode = 'ActivateNode';
 op_capActivateNode = '';
 op_GetAnnotationDocFrmAct = 'GetAnnotationDocFrmAct';
 op_capGetAnnotationDocFrmAct = '';
 op_SimilarDocuments = 'SimilarDocuments';
 op_capSimilarDocuments = '';
 op_DocumentIsUseful = 'DocumentIsUseful';
 op_capDocumentIsUseful = '��������';
 op_DocumentIsUseless = 'DocumentIsUseless';
 op_capDocumentIsUseless = '�� ��������';
 op_PrevDocumentInList = 'PrevDocumentInList';
 op_capPrevDocumentInList = '���������� �������� � ������';
 op_NextDocumentInList = 'NextDocumentInList';
 op_capNextDocumentInList = '��������� �������� � ������';
 op_ReturnToList = 'ReturnToList';
 op_capReturnToList = '��������� � �����';
 op_AddToControl = 'AddToControl';
 op_capAddToControl = '��������� �� ��������';
 op_UserCR1 = 'UserCR1';
 op_capUserCR1 = '���������������� ������ �� �������� (������ �� ���������) 1';
 op_UserCR2 = 'UserCR2';
 op_capUserCR2 = '���������������� ������ �� �������� (������ �� ���������) 2';
 op_AddBookmark = 'AddBookmark';
 op_capAddBookmark = '�������� ��������';
 op_GetGraphicImage = 'GetGraphicImage';
 op_capGetGraphicImage = '';
 en_FoldersControl = 'FoldersControl';
 en_capFoldersControl = '���������� �������';
 op_EditElement = 'EditElement';
 op_capEditElement = '������ �������������� ��������';
 op_DeleteElement = 'DeleteElement';
 op_capDeleteElement = '������� �������';
 en_SavedQuery = 'SavedQuery';
 en_capSavedQuery = '';
 op_OpenQuery = 'OpenQuery';
 op_capOpenQuery = '';
 op_ExecuteQuery = 'ExecuteQuery';
 op_capExecuteQuery = '';
 op_FiltersList = 'FiltersList';
 op_capFiltersList = '';
 op_Clear = 'Clear';
 op_capClear = '';
 op_InternalClear = 'InternalClear';
 op_capInternalClear = '';
 en_Openable = 'Openable';
 en_capOpenable = '';
 op_OpenInNewWindow = 'OpenInNewWindow';
 op_capOpenInNewWindow = '';
 en_HyperLink = 'HyperLink';
 en_capHyperLink = '�����������';
 op_NextHyperLink = 'NextHyperLink';
 op_capNextHyperLink = '';
 op_PrevHyperLink = 'PrevHyperLink';
 op_capPrevHyperLink = '';
 op_OpenInNewTab = 'OpenInNewTab';
 op_capOpenInNewTab = '';
 op_OpenScriptHyperLink = 'OpenScriptHyperLink';
 op_capOpenScriptHyperLink = '';
 op_NavigateInternetHyperlink = 'NavigateInternetHyperlink';
 op_capNavigateInternetHyperlink = '������� �� �����������';
 op_Delete = 'Delete';
 op_capDelete = '';
 op_SetActive = 'SetActive';
 op_capSetActive = '';
 op_ExportBlock = 'ExportBlock';
 op_capExportBlock = '';
 op_GetCurrentPosition = 'GetCurrentPosition';
 op_capGetCurrentPosition = '';
 op_SelectBlock = 'SelectBlock';
 op_capSelectBlock = '';
 op_CopyBlock = 'CopyBlock';
 op_capCopyBlock = '';
 op_PrintBlock = 'PrintBlock';
 op_capPrintBlock = '';
 op_PrintDialogBlock = 'PrintDialogBlock';
 op_capPrintDialogBlock = '';
 op_PreviewBlock = 'PreviewBlock';
 op_capPreviewBlock = '';
 op_ShowRespondentListToPart = 'ShowRespondentListToPart';
 op_capShowRespondentListToPart = '';
 op_ShowCorrespondentListToPart = 'ShowCorrespondentListToPart';
 op_capShowCorrespondentListToPart = '';
 op_ModifyBookmarkNotify = 'ModifyBookmarkNotify';
 op_capModifyBookmarkNotify = '';
 op_AddBookmarkFromContents = 'AddBookmarkFromContents';
 op_capAddBookmarkFromContents = '';
 op_OpenNotSureTopic = 'OpenNotSureTopic';
 op_capOpenNotSureTopic = '';
 op_GotoPara = 'GotoPara';
 op_capGotoPara = '';

var opcode_Switcher_BecomeActive: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_FindExplanation: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_SynchroView_BecomeActive: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_List_GetDeList: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_List_SetCurrentVisible: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_List_SwitchToFullList: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_List_GetDsList: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Form_RequestClose: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_ControlCenter_Refresh: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_ListInfo_BecomeActive: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Filters_DeselectAll: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_LocalList_SearchInList: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_LocalList_PublishSourceSearchInList: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_LocalList_Open: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_LocalList_SearchDrugInList: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_LocalList_OpenNewWindow: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_TimeMachine_TimeMachineOnOffNew: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_TimeMachine_TimeMachineOnOffNew_MachineOn: TvcmOperationStateIndex = (rID : -1);
 {*  -> �������� ������ ������� <->  }
var st_user_TimeMachine_TimeMachineOnOffNew_MachineOff: TvcmOperationStateIndex = (rID : -1);
 {*  -> �������� ������ ������� <-> ��������� ������ �������/�������� ���� }
var opcode_TimeMachine_TimeMachineOnOff: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_TimeMachine_TimeMachineOffAndReset: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Filter_Activate: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_Filter_Activate_Deactivate: TvcmOperationStateIndex = (rID : -1);
 {*  -> ��������� ������ <-> �������� ������ }
var opcode_Filter_ActivateNode: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_GetAnnotationDocFrmAct: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_SimilarDocuments: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_DocumentIsUseful: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_DocumentIsUseless: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_PrevDocumentInList: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_NextDocumentInList: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_ReturnToList: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_AddToControl: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_Document_AddToControl_RemoveFromControl: TvcmOperationStateIndex = (rID : -1);
 {* �������� -> ��������� �� �������� <-> ����� � �������� }
var opcode_Document_UserCR1: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_Document_UserCR1_Corr: TvcmOperationStateIndex = (rID : -1);
 {* �������� -> ���������������� ������ �� �������� (������ �� ���������) 1 <->  }
var opcode_Document_UserCR2: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_Document_UserCR2_Corr: TvcmOperationStateIndex = (rID : -1);
 {* �������� -> ���������������� ������ �� �������� (������ �� ���������) 2 <->  }
var opcode_Document_AddBookmark: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_GetGraphicImage: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_FoldersControl_EditElement: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_FoldersControl_DeleteElement: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_SavedQuery_OpenQuery: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_SavedQuery_ExecuteQuery: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Filters_FiltersList: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Filters_Clear: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Filters_InternalClear: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Openable_OpenInNewWindow: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_HyperLink_Open: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_HyperLink_OpenNewWindow: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_HyperLink_NextHyperLink: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_HyperLink_PrevHyperLink: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_HyperLink_OpenInNewTab: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_HyperLink_OpenScriptHyperLink: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_HyperLink_NavigateInternetHyperlink: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_HyperLink_Delete: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_SetActive: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_ExportBlock: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_GetCurrentPosition: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_SelectBlock: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_CopyBlock: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_PrintBlock: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_PrintDialogBlock: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_PreviewBlock: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_ShowRespondentListToPart: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_ShowCorrespondentListToPart: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_ModifyBookmarkNotify: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_AddBookmarkFromContents: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_OpenNotSureTopic: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_GotoPara: TvcmOPID = (rEnID : -1; rOpID : -1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3CProtoObject
 {$If NOT Defined(NoVCM)}
 , vcmOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmOperationStatesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TDocument_FindExplanation_Params = {final} class(Tl3CProtoObject, IDocument_FindExplanation_Params)
  {* ���������� IDocument_FindExplanation_Params }
  private
   f_ResultValue: Boolean;
  protected
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
  public
   class function Make: IDocument_FindExplanation_Params; reintroduce;
 end;//TDocument_FindExplanation_Params

 TSynchroView_BecomeActive_Params = {final} class(Tl3CProtoObject, ISynchroView_BecomeActive_Params)
  {* ���������� ISynchroView_BecomeActive_Params }
  private
   f_FormType: TnsShowSynchroForm;
  protected
   function Get_FormType: TnsShowSynchroForm;
  public
   constructor Create(aFormType: TnsShowSynchroForm); reintroduce;
   class function Make(aFormType: TnsShowSynchroForm): ISynchroView_BecomeActive_Params; reintroduce;
 end;//TSynchroView_BecomeActive_Params

 TList_GetDeList_Params = {final} class(Tl3CProtoObject, IList_GetDeList_Params)
  {* ���������� IList_GetDeList_Params }
  private
   f_ResultValue: IdeList;
  protected
   function Get_ResultValue: IdeList;
   procedure Set_ResultValue(const aValue: IdeList);
   procedure ClearFields; override;
  public
   class function Make: IList_GetDeList_Params; reintroduce;
 end;//TList_GetDeList_Params

 TList_GetDsList_Params = {final} class(Tl3CProtoObject, IList_GetDsList_Params)
  {* ���������� IList_GetDsList_Params }
  private
   f_ResultValue: IdsList;
  protected
   function Get_ResultValue: IdsList;
   procedure Set_ResultValue(const aValue: IdsList);
   procedure ClearFields; override;
  public
   class function Make: IList_GetDsList_Params; reintroduce;
 end;//TList_GetDsList_Params

 TFilter_ActivateNode_Params = {final} class(Tl3CProtoObject, IFilter_ActivateNode_Params)
  {* ���������� IFilter_ActivateNode_Params }
  private
   f_Node: Il3Node;
  protected
   function Get_Node: Il3Node;
   procedure ClearFields; override;
  public
   constructor Create(const aNode: Il3Node); reintroduce;
   class function Make(const aNode: Il3Node): IFilter_ActivateNode_Params; reintroduce;
 end;//TFilter_ActivateNode_Params

 TFoldersControl_EditElement_Params = {final} class(Tl3CProtoObject, IFoldersControl_EditElement_Params)
  {* ���������� IFoldersControl_EditElement_Params }
  private
   f_Node: IFoldersNode;
  protected
   function Get_Node: IFoldersNode;
   procedure ClearFields; override;
  public
   constructor Create(const aNode: IFoldersNode); reintroduce;
   class function Make(const aNode: IFoldersNode): IFoldersControl_EditElement_Params; reintroduce;
 end;//TFoldersControl_EditElement_Params

 TFoldersControl_DeleteElement_Params = {final} class(Tl3CProtoObject, IFoldersControl_DeleteElement_Params)
  {* ���������� IFoldersControl_DeleteElement_Params }
  private
   f_Node: IFoldersNode;
   f_ResultValue: TnsDeleteResult;
  protected
   function Get_Node: IFoldersNode;
   function Get_ResultValue: TnsDeleteResult;
   procedure Set_ResultValue(aValue: TnsDeleteResult);
   procedure ClearFields; override;
  public
   constructor Create(const aNode: IFoldersNode); reintroduce;
   class function Make(const aNode: IFoldersNode): IFoldersControl_DeleteElement_Params; reintroduce;
 end;//TFoldersControl_DeleteElement_Params

 TDocument_SetActive_Params = {final} class(Tl3CProtoObject, IDocument_SetActive_Params)
  {* ���������� IDocument_SetActive_Params }
  private
   f_UserType: Integer;
  protected
   function Get_UserType: Integer;
  public
   constructor Create(aUserType: Integer); reintroduce;
   class function Make(aUserType: Integer): IDocument_SetActive_Params; reintroduce;
 end;//TDocument_SetActive_Params

 TDocument_ExportBlock_Params = {final} class(Tl3CProtoObject, IDocument_ExportBlock_Params)
  {* ���������� IDocument_ExportBlock_Params }
  private
   f_Data: IUnknown;
   f_UserType: Integer;
   f_ToActiveWindow: Boolean;
  protected
   function Get_Data: IUnknown;
   function Get_UserType: Integer;
   function Get_ToActiveWindow: Boolean;
   procedure ClearFields; override;
  public
   constructor Create(const aData: IUnknown;
    aUserType: Integer;
    aToActiveWindow: Boolean); reintroduce;
   class function Make(const aData: IUnknown;
    aUserType: Integer;
    aToActiveWindow: Boolean): IDocument_ExportBlock_Params; reintroduce;
 end;//TDocument_ExportBlock_Params

 TDocument_GetCurrentPosition_Params = {final} class(Tl3CProtoObject, IDocument_GetCurrentPosition_Params)
  {* ���������� IDocument_GetCurrentPosition_Params }
  private
   f_ResultValue: Integer;
  protected
   function Get_ResultValue: Integer;
   procedure Set_ResultValue(aValue: Integer);
  public
   class function Make: IDocument_GetCurrentPosition_Params; reintroduce;
 end;//TDocument_GetCurrentPosition_Params

 TDocument_SelectBlock_Params = {final} class(Tl3CProtoObject, IDocument_SelectBlock_Params)
  {* ���������� IDocument_SelectBlock_Params }
  private
   f_Data: IUnknown;
   f_UserType: Integer;
  protected
   function Get_Data: IUnknown;
   function Get_UserType: Integer;
   procedure ClearFields; override;
  public
   constructor Create(const aData: IUnknown;
    aUserType: Integer); reintroduce;
   class function Make(const aData: IUnknown;
    aUserType: Integer): IDocument_SelectBlock_Params; reintroduce;
 end;//TDocument_SelectBlock_Params

 TDocument_CopyBlock_Params = {final} class(Tl3CProtoObject, IDocument_CopyBlock_Params)
  {* ���������� IDocument_CopyBlock_Params }
  private
   f_Data: IUnknown;
   f_UserType: Integer;
  protected
   function Get_Data: IUnknown;
   function Get_UserType: Integer;
   procedure ClearFields; override;
  public
   constructor Create(const aData: IUnknown;
    aUserType: Integer); reintroduce;
   class function Make(const aData: IUnknown;
    aUserType: Integer): IDocument_CopyBlock_Params; reintroduce;
 end;//TDocument_CopyBlock_Params

 TDocument_PrintBlock_Params = {final} class(Tl3CProtoObject, IDocument_PrintBlock_Params)
  {* ���������� IDocument_PrintBlock_Params }
  private
   f_Data: IUnknown;
   f_UserType: Integer;
  protected
   function Get_Data: IUnknown;
   function Get_UserType: Integer;
   procedure ClearFields; override;
  public
   constructor Create(const aData: IUnknown;
    aUserType: Integer); reintroduce;
   class function Make(const aData: IUnknown;
    aUserType: Integer): IDocument_PrintBlock_Params; reintroduce;
 end;//TDocument_PrintBlock_Params

 TDocument_PrintDialogBlock_Params = {final} class(Tl3CProtoObject, IDocument_PrintDialogBlock_Params)
  {* ���������� IDocument_PrintDialogBlock_Params }
  private
   f_Data: IUnknown;
   f_UserType: Integer;
  protected
   function Get_Data: IUnknown;
   function Get_UserType: Integer;
   procedure ClearFields; override;
  public
   constructor Create(const aData: IUnknown;
    aUserType: Integer); reintroduce;
   class function Make(const aData: IUnknown;
    aUserType: Integer): IDocument_PrintDialogBlock_Params; reintroduce;
 end;//TDocument_PrintDialogBlock_Params

 TDocument_PreviewBlock_Params = {final} class(Tl3CProtoObject, IDocument_PreviewBlock_Params)
  {* ���������� IDocument_PreviewBlock_Params }
  private
   f_Data: IUnknown;
   f_UserType: Integer;
  protected
   function Get_Data: IUnknown;
   function Get_UserType: Integer;
   procedure ClearFields; override;
  public
   constructor Create(const aData: IUnknown;
    aUserType: Integer); reintroduce;
   class function Make(const aData: IUnknown;
    aUserType: Integer): IDocument_PreviewBlock_Params; reintroduce;
 end;//TDocument_PreviewBlock_Params

 TDocument_ShowRespondentListToPart_Params = {final} class(Tl3CProtoObject, IDocument_ShowRespondentListToPart_Params)
  {* ���������� IDocument_ShowRespondentListToPart_Params }
  private
   f_List: IPositionList;
   f_Current: Il3SimpleNode;
  protected
   function Get_List: IPositionList;
   function Get_Current: Il3SimpleNode;
   procedure ClearFields; override;
  public
   constructor Create(const aList: IPositionList;
    const aCurrent: Il3SimpleNode = nil); reintroduce;
   class function Make(const aList: IPositionList;
    const aCurrent: Il3SimpleNode = nil): IDocument_ShowRespondentListToPart_Params; reintroduce;
 end;//TDocument_ShowRespondentListToPart_Params

 TDocument_ShowCorrespondentListToPart_Params = {final} class(Tl3CProtoObject, IDocument_ShowCorrespondentListToPart_Params)
  {* ���������� IDocument_ShowCorrespondentListToPart_Params }
  private
   f_List: IPositionList;
   f_Current: Il3SimpleNode;
  protected
   function Get_List: IPositionList;
   function Get_Current: Il3SimpleNode;
   procedure ClearFields; override;
  public
   constructor Create(const aList: IPositionList;
    const aCurrent: Il3SimpleNode = nil); reintroduce;
   class function Make(const aList: IPositionList;
    const aCurrent: Il3SimpleNode = nil): IDocument_ShowCorrespondentListToPart_Params; reintroduce;
 end;//TDocument_ShowCorrespondentListToPart_Params

 TDocument_ModifyBookmarkNotify_Params = {final} class(Tl3CProtoObject, IDocument_ModifyBookmarkNotify_Params)
  {* ���������� IDocument_ModifyBookmarkNotify_Params }
  private
   f_nEntity: IUnknown;
  protected
   function Get_nEntity: IUnknown;
   procedure ClearFields; override;
  public
   constructor Create(const anEntity: IUnknown); reintroduce;
   class function Make(const anEntity: IUnknown): IDocument_ModifyBookmarkNotify_Params; reintroduce;
 end;//TDocument_ModifyBookmarkNotify_Params

 TDocument_AddBookmarkFromContents_Params = {final} class(Tl3CProtoObject, IDocument_AddBookmarkFromContents_Params)
  {* ���������� IDocument_AddBookmarkFromContents_Params }
  private
   f_Tag: Il3TagRef;
  protected
   function Get_Tag: Il3TagRef;
   procedure ClearFields; override;
  public
   constructor Create(const aTag: Il3TagRef); reintroduce;
   class function Make(const aTag: Il3TagRef): IDocument_AddBookmarkFromContents_Params; reintroduce;
 end;//TDocument_AddBookmarkFromContents_Params

 TDocument_GotoPara_Params = {final} class(Tl3CProtoObject, IDocument_GotoPara_Params)
  {* ���������� IDocument_GotoPara_Params }
  private
   f_Para: Il3TagRef;
   f_UserType: Integer;
   f_ResultValue: Boolean;
  protected
   function Get_Para: Il3TagRef;
   function Get_UserType: Integer;
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   procedure ClearFields; override;
  public
   constructor Create(const aPara: Il3TagRef;
    aUserType: Integer); reintroduce;
   class function Make(const aPara: Il3TagRef;
    aUserType: Integer): IDocument_GotoPara_Params; reintroduce;
 end;//TDocument_GotoPara_Params

class function Op_Switcher_BecomeActive.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� Switcher.BecomeActive � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(opcode_Switcher_BecomeActive, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Switcher_BecomeActive.Call

class function Op_Switcher_BecomeActive.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� Switcher.BecomeActive � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(opcode_Switcher_BecomeActive, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Switcher_BecomeActive.Call

class function Op_Switcher_BecomeActive.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� Switcher.BecomeActive � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Switcher_BecomeActive.Call

class function Op_Switcher_BecomeActive.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� Switcher.BecomeActive � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Switcher_BecomeActive.Call

class function TDocument_FindExplanation_Params.Make: IDocument_FindExplanation_Params;
var
 l_Inst : TDocument_FindExplanation_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_FindExplanation_Params.Make

function TDocument_FindExplanation_Params.Get_ResultValue: Boolean;
begin
 Result := f_ResultValue;
end;//TDocument_FindExplanation_Params.Get_ResultValue

procedure TDocument_FindExplanation_Params.Set_ResultValue(aValue: Boolean);
begin
 f_ResultValue := aValue;
end;//TDocument_FindExplanation_Params.Set_ResultValue

class function Op_Document_FindExplanation.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� Document.FindExplanation � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_FindExplanation_Params.Make);
  aTarget.Operation(opcode_Document_FindExplanation, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IDocument_FindExplanation_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_FindExplanation.Call

class function Op_Document_FindExplanation.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� Document.FindExplanation � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_FindExplanation_Params.Make);
  aTarget.Operation(opcode_Document_FindExplanation, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IDocument_FindExplanation_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_FindExplanation.Call

class function Op_Document_FindExplanation.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� Document.FindExplanation � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Document_FindExplanation.Call

class function Op_Document_FindExplanation.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� Document.FindExplanation � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Document_FindExplanation.Call

constructor TSynchroView_BecomeActive_Params.Create(aFormType: TnsShowSynchroForm);
begin
 inherited Create;
 f_FormType := aFormType;
end;//TSynchroView_BecomeActive_Params.Create

class function TSynchroView_BecomeActive_Params.Make(aFormType: TnsShowSynchroForm): ISynchroView_BecomeActive_Params;
var
 l_Inst : TSynchroView_BecomeActive_Params;
begin
 l_Inst := Create(aFormType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TSynchroView_BecomeActive_Params.Make

function TSynchroView_BecomeActive_Params.Get_FormType: TnsShowSynchroForm;
begin
 Result := f_FormType;
end;//TSynchroView_BecomeActive_Params.Get_FormType

class function Op_SynchroView_BecomeActive.Call(const aTarget: IvcmEntity;
 aFormType: TnsShowSynchroForm): Boolean;
 {* ����� �������� SynchroView.BecomeActive � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSynchroView_BecomeActive_Params.Make(aFormType));
  aTarget.Operation(opcode_SynchroView_BecomeActive, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_SynchroView_BecomeActive.Call

class function Op_SynchroView_BecomeActive.Call(const aTarget: IvcmAggregate;
 aFormType: TnsShowSynchroForm): Boolean;
 {* ����� �������� SynchroView.BecomeActive � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSynchroView_BecomeActive_Params.Make(aFormType));
  aTarget.Operation(opcode_SynchroView_BecomeActive, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_SynchroView_BecomeActive.Call

class function Op_SynchroView_BecomeActive.Call(const aTarget: IvcmEntityForm;
 aFormType: TnsShowSynchroForm): Boolean;
 {* ����� �������� SynchroView.BecomeActive � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aFormType);
end;//Op_SynchroView_BecomeActive.Call

class function Op_SynchroView_BecomeActive.Call(const aTarget: IvcmContainer;
 aFormType: TnsShowSynchroForm): Boolean;
 {* ����� �������� SynchroView.BecomeActive � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aFormType);
end;//Op_SynchroView_BecomeActive.Call

class function TList_GetDeList_Params.Make: IList_GetDeList_Params;
var
 l_Inst : TList_GetDeList_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TList_GetDeList_Params.Make

function TList_GetDeList_Params.Get_ResultValue: IdeList;
begin
 Result := f_ResultValue;
end;//TList_GetDeList_Params.Get_ResultValue

procedure TList_GetDeList_Params.Set_ResultValue(const aValue: IdeList);
begin
 f_ResultValue := aValue;
end;//TList_GetDeList_Params.Set_ResultValue

procedure TList_GetDeList_Params.ClearFields;
begin
 f_ResultValue := nil;
 inherited;
end;//TList_GetDeList_Params.ClearFields

class function Op_List_GetDeList.Call(const aTarget: IvcmEntity): IdeList;
 {* ����� �������� List.GetDeList � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TList_GetDeList_Params.Make);
  aTarget.Operation(opcode_List_GetDeList, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IList_GetDeList_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_List_GetDeList.Call

class function Op_List_GetDeList.Call(const aTarget: IvcmAggregate): IdeList;
 {* ����� �������� List.GetDeList � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TList_GetDeList_Params.Make);
  aTarget.Operation(opcode_List_GetDeList, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IList_GetDeList_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_List_GetDeList.Call

class function Op_List_GetDeList.Call(const aTarget: IvcmEntityForm): IdeList;
 {* ����� �������� List.GetDeList � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_List_GetDeList.Call

class function Op_List_GetDeList.Call(const aTarget: IvcmContainer): IdeList;
 {* ����� �������� List.GetDeList � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_List_GetDeList.Call

class function Op_List_SetCurrentVisible.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� List.SetCurrentVisible � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(opcode_List_SetCurrentVisible, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_List_SetCurrentVisible.Call

class function Op_List_SetCurrentVisible.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� List.SetCurrentVisible � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(opcode_List_SetCurrentVisible, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_List_SetCurrentVisible.Call

class function Op_List_SetCurrentVisible.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� List.SetCurrentVisible � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_List_SetCurrentVisible.Call

class function Op_List_SetCurrentVisible.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� List.SetCurrentVisible � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_List_SetCurrentVisible.Call

class function TList_GetDsList_Params.Make: IList_GetDsList_Params;
var
 l_Inst : TList_GetDsList_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TList_GetDsList_Params.Make

function TList_GetDsList_Params.Get_ResultValue: IdsList;
begin
 Result := f_ResultValue;
end;//TList_GetDsList_Params.Get_ResultValue

procedure TList_GetDsList_Params.Set_ResultValue(const aValue: IdsList);
begin
 f_ResultValue := aValue;
end;//TList_GetDsList_Params.Set_ResultValue

procedure TList_GetDsList_Params.ClearFields;
begin
 f_ResultValue := nil;
 inherited;
end;//TList_GetDsList_Params.ClearFields

class function Op_List_GetDsList.Call(const aTarget: IvcmEntity): IdsList;
 {* ����� �������� List.GetDsList � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TList_GetDsList_Params.Make);
  aTarget.Operation(opcode_List_GetDsList, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IList_GetDsList_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_List_GetDsList.Call

class function Op_List_GetDsList.Call(const aTarget: IvcmAggregate): IdsList;
 {* ����� �������� List.GetDsList � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TList_GetDsList_Params.Make);
  aTarget.Operation(opcode_List_GetDsList, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IList_GetDsList_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_List_GetDsList.Call

class function Op_List_GetDsList.Call(const aTarget: IvcmEntityForm): IdsList;
 {* ����� �������� List.GetDsList � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_List_GetDsList.Call

class function Op_List_GetDsList.Call(const aTarget: IvcmContainer): IdsList;
 {* ����� �������� List.GetDsList � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_List_GetDsList.Call

class function Op_Form_RequestClose.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� Form.RequestClose � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(opcode_Form_RequestClose, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Form_RequestClose.Call

class function Op_Form_RequestClose.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� Form.RequestClose � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(opcode_Form_RequestClose, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Form_RequestClose.Call

class function Op_Form_RequestClose.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� Form.RequestClose � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Form_RequestClose.Call

class function Op_Form_RequestClose.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� Form.RequestClose � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Form_RequestClose.Call

class function Op_ControlCenter_Refresh.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� ControlCenter.Refresh � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(opcode_ControlCenter_Refresh, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_ControlCenter_Refresh.Call

class function Op_ControlCenter_Refresh.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� ControlCenter.Refresh � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(opcode_ControlCenter_Refresh, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_ControlCenter_Refresh.Call

class function Op_ControlCenter_Refresh.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� ControlCenter.Refresh � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_ControlCenter_Refresh.Call

class function Op_ControlCenter_Refresh.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� ControlCenter.Refresh � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_ControlCenter_Refresh.Call

class function Op_ListInfo_BecomeActive.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� ListInfo.BecomeActive � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(opcode_ListInfo_BecomeActive, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_ListInfo_BecomeActive.Call

class function Op_ListInfo_BecomeActive.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� ListInfo.BecomeActive � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(opcode_ListInfo_BecomeActive, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_ListInfo_BecomeActive.Call

class function Op_ListInfo_BecomeActive.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� ListInfo.BecomeActive � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_ListInfo_BecomeActive.Call

class function Op_ListInfo_BecomeActive.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� ListInfo.BecomeActive � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_ListInfo_BecomeActive.Call

class function Op_Filters_DeselectAll.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� Filters.DeselectAll � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(opcode_Filters_DeselectAll, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Filters_DeselectAll.Call

class function Op_Filters_DeselectAll.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� Filters.DeselectAll � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(opcode_Filters_DeselectAll, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Filters_DeselectAll.Call

class function Op_Filters_DeselectAll.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� Filters.DeselectAll � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Filters_DeselectAll.Call

class function Op_Filters_DeselectAll.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� Filters.DeselectAll � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Filters_DeselectAll.Call

class function Op_TimeMachine_TimeMachineOnOff.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� TimeMachine.TimeMachineOnOff � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(opcode_TimeMachine_TimeMachineOnOff, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_TimeMachine_TimeMachineOnOff.Call

class function Op_TimeMachine_TimeMachineOnOff.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� TimeMachine.TimeMachineOnOff � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(opcode_TimeMachine_TimeMachineOnOff, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_TimeMachine_TimeMachineOnOff.Call

class function Op_TimeMachine_TimeMachineOnOff.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� TimeMachine.TimeMachineOnOff � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_TimeMachine_TimeMachineOnOff.Call

class function Op_TimeMachine_TimeMachineOnOff.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� TimeMachine.TimeMachineOnOff � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_TimeMachine_TimeMachineOnOff.Call

class function Op_TimeMachine_TimeMachineOffAndReset.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� TimeMachine.TimeMachineOffAndReset � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(opcode_TimeMachine_TimeMachineOffAndReset, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_TimeMachine_TimeMachineOffAndReset.Call

class function Op_TimeMachine_TimeMachineOffAndReset.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� TimeMachine.TimeMachineOffAndReset � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(opcode_TimeMachine_TimeMachineOffAndReset, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_TimeMachine_TimeMachineOffAndReset.Call

class function Op_TimeMachine_TimeMachineOffAndReset.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� TimeMachine.TimeMachineOffAndReset � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_TimeMachine_TimeMachineOffAndReset.Call

class function Op_TimeMachine_TimeMachineOffAndReset.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� TimeMachine.TimeMachineOffAndReset � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_TimeMachine_TimeMachineOffAndReset.Call

constructor TFilter_ActivateNode_Params.Create(const aNode: Il3Node);
begin
 inherited Create;
 f_Node := aNode;
end;//TFilter_ActivateNode_Params.Create

class function TFilter_ActivateNode_Params.Make(const aNode: Il3Node): IFilter_ActivateNode_Params;
var
 l_Inst : TFilter_ActivateNode_Params;
begin
 l_Inst := Create(aNode);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TFilter_ActivateNode_Params.Make

function TFilter_ActivateNode_Params.Get_Node: Il3Node;
begin
 Result := f_Node;
end;//TFilter_ActivateNode_Params.Get_Node

procedure TFilter_ActivateNode_Params.ClearFields;
begin
 f_Node := nil;
 inherited;
end;//TFilter_ActivateNode_Params.ClearFields

class function Op_Filter_ActivateNode.Call(const aTarget: IvcmEntity;
 const aNode: Il3Node): Boolean;
 {* ����� �������� Filter.ActivateNode � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFilter_ActivateNode_Params.Make(aNode));
  aTarget.Operation(opcode_Filter_ActivateNode, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Filter_ActivateNode.Call

class function Op_Filter_ActivateNode.Call(const aTarget: IvcmAggregate;
 const aNode: Il3Node): Boolean;
 {* ����� �������� Filter.ActivateNode � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFilter_ActivateNode_Params.Make(aNode));
  aTarget.Operation(opcode_Filter_ActivateNode, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Filter_ActivateNode.Call

class function Op_Filter_ActivateNode.Call(const aTarget: IvcmEntityForm;
 const aNode: Il3Node): Boolean;
 {* ����� �������� Filter.ActivateNode � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode);
end;//Op_Filter_ActivateNode.Call

class function Op_Filter_ActivateNode.Call(const aTarget: IvcmContainer;
 const aNode: Il3Node): Boolean;
 {* ����� �������� Filter.ActivateNode � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode);
end;//Op_Filter_ActivateNode.Call

constructor TFoldersControl_EditElement_Params.Create(const aNode: IFoldersNode);
begin
 inherited Create;
 f_Node := aNode;
end;//TFoldersControl_EditElement_Params.Create

class function TFoldersControl_EditElement_Params.Make(const aNode: IFoldersNode): IFoldersControl_EditElement_Params;
var
 l_Inst : TFoldersControl_EditElement_Params;
begin
 l_Inst := Create(aNode);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TFoldersControl_EditElement_Params.Make

function TFoldersControl_EditElement_Params.Get_Node: IFoldersNode;
begin
 Result := f_Node;
end;//TFoldersControl_EditElement_Params.Get_Node

procedure TFoldersControl_EditElement_Params.ClearFields;
begin
 f_Node := nil;
 inherited;
end;//TFoldersControl_EditElement_Params.ClearFields

class function Op_FoldersControl_EditElement.Call(const aTarget: IvcmEntity;
 const aNode: IFoldersNode): Boolean;
 {* ����� �������� FoldersControl.EditElement � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFoldersControl_EditElement_Params.Make(aNode));
  aTarget.Operation(opcode_FoldersControl_EditElement, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FoldersControl_EditElement.Call

class function Op_FoldersControl_EditElement.Call(const aTarget: IvcmAggregate;
 const aNode: IFoldersNode): Boolean;
 {* ����� �������� FoldersControl.EditElement � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFoldersControl_EditElement_Params.Make(aNode));
  aTarget.Operation(opcode_FoldersControl_EditElement, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FoldersControl_EditElement.Call

class function Op_FoldersControl_EditElement.Call(const aTarget: IvcmEntityForm;
 const aNode: IFoldersNode): Boolean;
 {* ����� �������� FoldersControl.EditElement � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode);
end;//Op_FoldersControl_EditElement.Call

class function Op_FoldersControl_EditElement.Call(const aTarget: IvcmContainer;
 const aNode: IFoldersNode): Boolean;
 {* ����� �������� FoldersControl.EditElement � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode);
end;//Op_FoldersControl_EditElement.Call

constructor TFoldersControl_DeleteElement_Params.Create(const aNode: IFoldersNode);
begin
 inherited Create;
 f_Node := aNode;
end;//TFoldersControl_DeleteElement_Params.Create

class function TFoldersControl_DeleteElement_Params.Make(const aNode: IFoldersNode): IFoldersControl_DeleteElement_Params;
var
 l_Inst : TFoldersControl_DeleteElement_Params;
begin
 l_Inst := Create(aNode);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TFoldersControl_DeleteElement_Params.Make

function TFoldersControl_DeleteElement_Params.Get_Node: IFoldersNode;
begin
 Result := f_Node;
end;//TFoldersControl_DeleteElement_Params.Get_Node

function TFoldersControl_DeleteElement_Params.Get_ResultValue: TnsDeleteResult;
begin
 Result := f_ResultValue;
end;//TFoldersControl_DeleteElement_Params.Get_ResultValue

procedure TFoldersControl_DeleteElement_Params.Set_ResultValue(aValue: TnsDeleteResult);
begin
 f_ResultValue := aValue;
end;//TFoldersControl_DeleteElement_Params.Set_ResultValue

procedure TFoldersControl_DeleteElement_Params.ClearFields;
begin
 f_Node := nil;
 inherited;
end;//TFoldersControl_DeleteElement_Params.ClearFields

class function Op_FoldersControl_DeleteElement.Call(const aTarget: IvcmEntity;
 const aNode: IFoldersNode): TnsDeleteResult;
 {* ����� �������� FoldersControl.DeleteElement � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFoldersControl_DeleteElement_Params.Make(aNode));
  aTarget.Operation(opcode_FoldersControl_DeleteElement, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IFoldersControl_DeleteElement_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FoldersControl_DeleteElement.Call

class function Op_FoldersControl_DeleteElement.Call(const aTarget: IvcmAggregate;
 const aNode: IFoldersNode): TnsDeleteResult;
 {* ����� �������� FoldersControl.DeleteElement � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFoldersControl_DeleteElement_Params.Make(aNode));
  aTarget.Operation(opcode_FoldersControl_DeleteElement, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IFoldersControl_DeleteElement_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FoldersControl_DeleteElement.Call

class function Op_FoldersControl_DeleteElement.Call(const aTarget: IvcmEntityForm;
 const aNode: IFoldersNode): TnsDeleteResult;
 {* ����� �������� FoldersControl.DeleteElement � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode);
end;//Op_FoldersControl_DeleteElement.Call

class function Op_FoldersControl_DeleteElement.Call(const aTarget: IvcmContainer;
 const aNode: IFoldersNode): TnsDeleteResult;
 {* ����� �������� FoldersControl.DeleteElement � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode);
end;//Op_FoldersControl_DeleteElement.Call

class function Op_Filters_InternalClear.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� Filters.InternalClear � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(opcode_Filters_InternalClear, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Filters_InternalClear.Call

class function Op_Filters_InternalClear.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� Filters.InternalClear � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(opcode_Filters_InternalClear, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Filters_InternalClear.Call

class function Op_Filters_InternalClear.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� Filters.InternalClear � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Filters_InternalClear.Call

class function Op_Filters_InternalClear.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� Filters.InternalClear � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Filters_InternalClear.Call

constructor TDocument_SetActive_Params.Create(aUserType: Integer);
begin
 inherited Create;
 f_UserType := aUserType;
end;//TDocument_SetActive_Params.Create

class function TDocument_SetActive_Params.Make(aUserType: Integer): IDocument_SetActive_Params;
var
 l_Inst : TDocument_SetActive_Params;
begin
 l_Inst := Create(aUserType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_SetActive_Params.Make

function TDocument_SetActive_Params.Get_UserType: Integer;
begin
 Result := f_UserType;
end;//TDocument_SetActive_Params.Get_UserType

class function Op_Document_SetActive.Call(const aTarget: IvcmEntity;
 aUserType: Integer): Boolean;
 {* ����� �������� Document.SetActive � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_SetActive_Params.Make(aUserType));
  aTarget.Operation(opcode_Document_SetActive, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_SetActive.Call

class function Op_Document_SetActive.Call(const aTarget: IvcmAggregate;
 aUserType: Integer): Boolean;
 {* ����� �������� Document.SetActive � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_SetActive_Params.Make(aUserType));
  aTarget.Operation(opcode_Document_SetActive, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_SetActive.Call

class function Op_Document_SetActive.Call(const aTarget: IvcmEntityForm;
 aUserType: Integer): Boolean;
 {* ����� �������� Document.SetActive � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aUserType);
end;//Op_Document_SetActive.Call

class function Op_Document_SetActive.Call(const aTarget: IvcmContainer;
 aUserType: Integer): Boolean;
 {* ����� �������� Document.SetActive � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aUserType);
end;//Op_Document_SetActive.Call

constructor TDocument_ExportBlock_Params.Create(const aData: IUnknown;
 aUserType: Integer;
 aToActiveWindow: Boolean);
begin
 inherited Create;
 f_Data := aData;
 f_UserType := aUserType;
 f_ToActiveWindow := aToActiveWindow;
end;//TDocument_ExportBlock_Params.Create

class function TDocument_ExportBlock_Params.Make(const aData: IUnknown;
 aUserType: Integer;
 aToActiveWindow: Boolean): IDocument_ExportBlock_Params;
var
 l_Inst : TDocument_ExportBlock_Params;
begin
 l_Inst := Create(aData, aUserType, aToActiveWindow);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_ExportBlock_Params.Make

function TDocument_ExportBlock_Params.Get_Data: IUnknown;
begin
 Result := f_Data;
end;//TDocument_ExportBlock_Params.Get_Data

function TDocument_ExportBlock_Params.Get_UserType: Integer;
begin
 Result := f_UserType;
end;//TDocument_ExportBlock_Params.Get_UserType

function TDocument_ExportBlock_Params.Get_ToActiveWindow: Boolean;
begin
 Result := f_ToActiveWindow;
end;//TDocument_ExportBlock_Params.Get_ToActiveWindow

procedure TDocument_ExportBlock_Params.ClearFields;
begin
 f_Data := nil;
 inherited;
end;//TDocument_ExportBlock_Params.ClearFields

class function Op_Document_ExportBlock.Call(const aTarget: IvcmEntity;
 const aData: IUnknown;
 aUserType: Integer;
 aToActiveWindow: Boolean): Boolean;
 {* ����� �������� Document.ExportBlock � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_ExportBlock_Params.Make(aData, aUserType, aToActiveWindow));
  aTarget.Operation(opcode_Document_ExportBlock, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_ExportBlock.Call

class function Op_Document_ExportBlock.Call(const aTarget: IvcmAggregate;
 const aData: IUnknown;
 aUserType: Integer;
 aToActiveWindow: Boolean): Boolean;
 {* ����� �������� Document.ExportBlock � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_ExportBlock_Params.Make(aData, aUserType, aToActiveWindow));
  aTarget.Operation(opcode_Document_ExportBlock, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_ExportBlock.Call

class function Op_Document_ExportBlock.Call(const aTarget: IvcmEntityForm;
 const aData: IUnknown;
 aUserType: Integer;
 aToActiveWindow: Boolean): Boolean;
 {* ����� �������� Document.ExportBlock � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aData, aUserType, aToActiveWindow);
end;//Op_Document_ExportBlock.Call

class function Op_Document_ExportBlock.Call(const aTarget: IvcmContainer;
 const aData: IUnknown;
 aUserType: Integer;
 aToActiveWindow: Boolean): Boolean;
 {* ����� �������� Document.ExportBlock � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aData, aUserType, aToActiveWindow);
end;//Op_Document_ExportBlock.Call

class function TDocument_GetCurrentPosition_Params.Make: IDocument_GetCurrentPosition_Params;
var
 l_Inst : TDocument_GetCurrentPosition_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_GetCurrentPosition_Params.Make

function TDocument_GetCurrentPosition_Params.Get_ResultValue: Integer;
begin
 Result := f_ResultValue;
end;//TDocument_GetCurrentPosition_Params.Get_ResultValue

procedure TDocument_GetCurrentPosition_Params.Set_ResultValue(aValue: Integer);
begin
 f_ResultValue := aValue;
end;//TDocument_GetCurrentPosition_Params.Set_ResultValue

class function Op_Document_GetCurrentPosition.Call(const aTarget: IvcmEntity): Integer;
 {* ����� �������� Document.GetCurrentPosition � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_GetCurrentPosition_Params.Make);
  aTarget.Operation(opcode_Document_GetCurrentPosition, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IDocument_GetCurrentPosition_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_GetCurrentPosition.Call

class function Op_Document_GetCurrentPosition.Call(const aTarget: IvcmAggregate): Integer;
 {* ����� �������� Document.GetCurrentPosition � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_GetCurrentPosition_Params.Make);
  aTarget.Operation(opcode_Document_GetCurrentPosition, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IDocument_GetCurrentPosition_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_GetCurrentPosition.Call

class function Op_Document_GetCurrentPosition.Call(const aTarget: IvcmEntityForm): Integer;
 {* ����� �������� Document.GetCurrentPosition � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Document_GetCurrentPosition.Call

class function Op_Document_GetCurrentPosition.Call(const aTarget: IvcmContainer): Integer;
 {* ����� �������� Document.GetCurrentPosition � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Document_GetCurrentPosition.Call

constructor TDocument_SelectBlock_Params.Create(const aData: IUnknown;
 aUserType: Integer);
begin
 inherited Create;
 f_Data := aData;
 f_UserType := aUserType;
end;//TDocument_SelectBlock_Params.Create

class function TDocument_SelectBlock_Params.Make(const aData: IUnknown;
 aUserType: Integer): IDocument_SelectBlock_Params;
var
 l_Inst : TDocument_SelectBlock_Params;
begin
 l_Inst := Create(aData, aUserType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_SelectBlock_Params.Make

function TDocument_SelectBlock_Params.Get_Data: IUnknown;
begin
 Result := f_Data;
end;//TDocument_SelectBlock_Params.Get_Data

function TDocument_SelectBlock_Params.Get_UserType: Integer;
begin
 Result := f_UserType;
end;//TDocument_SelectBlock_Params.Get_UserType

procedure TDocument_SelectBlock_Params.ClearFields;
begin
 f_Data := nil;
 inherited;
end;//TDocument_SelectBlock_Params.ClearFields

class function Op_Document_SelectBlock.Call(const aTarget: IvcmEntity;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* ����� �������� Document.SelectBlock � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_SelectBlock_Params.Make(aData, aUserType));
  aTarget.Operation(opcode_Document_SelectBlock, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_SelectBlock.Call

class function Op_Document_SelectBlock.Call(const aTarget: IvcmAggregate;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* ����� �������� Document.SelectBlock � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_SelectBlock_Params.Make(aData, aUserType));
  aTarget.Operation(opcode_Document_SelectBlock, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_SelectBlock.Call

class function Op_Document_SelectBlock.Call(const aTarget: IvcmEntityForm;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* ����� �������� Document.SelectBlock � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aData, aUserType);
end;//Op_Document_SelectBlock.Call

class function Op_Document_SelectBlock.Call(const aTarget: IvcmContainer;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* ����� �������� Document.SelectBlock � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aData, aUserType);
end;//Op_Document_SelectBlock.Call

constructor TDocument_CopyBlock_Params.Create(const aData: IUnknown;
 aUserType: Integer);
begin
 inherited Create;
 f_Data := aData;
 f_UserType := aUserType;
end;//TDocument_CopyBlock_Params.Create

class function TDocument_CopyBlock_Params.Make(const aData: IUnknown;
 aUserType: Integer): IDocument_CopyBlock_Params;
var
 l_Inst : TDocument_CopyBlock_Params;
begin
 l_Inst := Create(aData, aUserType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_CopyBlock_Params.Make

function TDocument_CopyBlock_Params.Get_Data: IUnknown;
begin
 Result := f_Data;
end;//TDocument_CopyBlock_Params.Get_Data

function TDocument_CopyBlock_Params.Get_UserType: Integer;
begin
 Result := f_UserType;
end;//TDocument_CopyBlock_Params.Get_UserType

procedure TDocument_CopyBlock_Params.ClearFields;
begin
 f_Data := nil;
 inherited;
end;//TDocument_CopyBlock_Params.ClearFields

class function Op_Document_CopyBlock.Call(const aTarget: IvcmEntity;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* ����� �������� Document.CopyBlock � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_CopyBlock_Params.Make(aData, aUserType));
  aTarget.Operation(opcode_Document_CopyBlock, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_CopyBlock.Call

class function Op_Document_CopyBlock.Call(const aTarget: IvcmAggregate;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* ����� �������� Document.CopyBlock � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_CopyBlock_Params.Make(aData, aUserType));
  aTarget.Operation(opcode_Document_CopyBlock, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_CopyBlock.Call

class function Op_Document_CopyBlock.Call(const aTarget: IvcmEntityForm;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* ����� �������� Document.CopyBlock � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aData, aUserType);
end;//Op_Document_CopyBlock.Call

class function Op_Document_CopyBlock.Call(const aTarget: IvcmContainer;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* ����� �������� Document.CopyBlock � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aData, aUserType);
end;//Op_Document_CopyBlock.Call

constructor TDocument_PrintBlock_Params.Create(const aData: IUnknown;
 aUserType: Integer);
begin
 inherited Create;
 f_Data := aData;
 f_UserType := aUserType;
end;//TDocument_PrintBlock_Params.Create

class function TDocument_PrintBlock_Params.Make(const aData: IUnknown;
 aUserType: Integer): IDocument_PrintBlock_Params;
var
 l_Inst : TDocument_PrintBlock_Params;
begin
 l_Inst := Create(aData, aUserType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_PrintBlock_Params.Make

function TDocument_PrintBlock_Params.Get_Data: IUnknown;
begin
 Result := f_Data;
end;//TDocument_PrintBlock_Params.Get_Data

function TDocument_PrintBlock_Params.Get_UserType: Integer;
begin
 Result := f_UserType;
end;//TDocument_PrintBlock_Params.Get_UserType

procedure TDocument_PrintBlock_Params.ClearFields;
begin
 f_Data := nil;
 inherited;
end;//TDocument_PrintBlock_Params.ClearFields

class function Op_Document_PrintBlock.Call(const aTarget: IvcmEntity;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* ����� �������� Document.PrintBlock � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_PrintBlock_Params.Make(aData, aUserType));
  aTarget.Operation(opcode_Document_PrintBlock, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_PrintBlock.Call

class function Op_Document_PrintBlock.Call(const aTarget: IvcmAggregate;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* ����� �������� Document.PrintBlock � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_PrintBlock_Params.Make(aData, aUserType));
  aTarget.Operation(opcode_Document_PrintBlock, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_PrintBlock.Call

class function Op_Document_PrintBlock.Call(const aTarget: IvcmEntityForm;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* ����� �������� Document.PrintBlock � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aData, aUserType);
end;//Op_Document_PrintBlock.Call

class function Op_Document_PrintBlock.Call(const aTarget: IvcmContainer;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* ����� �������� Document.PrintBlock � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aData, aUserType);
end;//Op_Document_PrintBlock.Call

constructor TDocument_PrintDialogBlock_Params.Create(const aData: IUnknown;
 aUserType: Integer);
begin
 inherited Create;
 f_Data := aData;
 f_UserType := aUserType;
end;//TDocument_PrintDialogBlock_Params.Create

class function TDocument_PrintDialogBlock_Params.Make(const aData: IUnknown;
 aUserType: Integer): IDocument_PrintDialogBlock_Params;
var
 l_Inst : TDocument_PrintDialogBlock_Params;
begin
 l_Inst := Create(aData, aUserType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_PrintDialogBlock_Params.Make

function TDocument_PrintDialogBlock_Params.Get_Data: IUnknown;
begin
 Result := f_Data;
end;//TDocument_PrintDialogBlock_Params.Get_Data

function TDocument_PrintDialogBlock_Params.Get_UserType: Integer;
begin
 Result := f_UserType;
end;//TDocument_PrintDialogBlock_Params.Get_UserType

procedure TDocument_PrintDialogBlock_Params.ClearFields;
begin
 f_Data := nil;
 inherited;
end;//TDocument_PrintDialogBlock_Params.ClearFields

class function Op_Document_PrintDialogBlock.Call(const aTarget: IvcmEntity;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* ����� �������� Document.PrintDialogBlock � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_PrintDialogBlock_Params.Make(aData, aUserType));
  aTarget.Operation(opcode_Document_PrintDialogBlock, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_PrintDialogBlock.Call

class function Op_Document_PrintDialogBlock.Call(const aTarget: IvcmAggregate;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* ����� �������� Document.PrintDialogBlock � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_PrintDialogBlock_Params.Make(aData, aUserType));
  aTarget.Operation(opcode_Document_PrintDialogBlock, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_PrintDialogBlock.Call

class function Op_Document_PrintDialogBlock.Call(const aTarget: IvcmEntityForm;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* ����� �������� Document.PrintDialogBlock � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aData, aUserType);
end;//Op_Document_PrintDialogBlock.Call

class function Op_Document_PrintDialogBlock.Call(const aTarget: IvcmContainer;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* ����� �������� Document.PrintDialogBlock � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aData, aUserType);
end;//Op_Document_PrintDialogBlock.Call

constructor TDocument_PreviewBlock_Params.Create(const aData: IUnknown;
 aUserType: Integer);
begin
 inherited Create;
 f_Data := aData;
 f_UserType := aUserType;
end;//TDocument_PreviewBlock_Params.Create

class function TDocument_PreviewBlock_Params.Make(const aData: IUnknown;
 aUserType: Integer): IDocument_PreviewBlock_Params;
var
 l_Inst : TDocument_PreviewBlock_Params;
begin
 l_Inst := Create(aData, aUserType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_PreviewBlock_Params.Make

function TDocument_PreviewBlock_Params.Get_Data: IUnknown;
begin
 Result := f_Data;
end;//TDocument_PreviewBlock_Params.Get_Data

function TDocument_PreviewBlock_Params.Get_UserType: Integer;
begin
 Result := f_UserType;
end;//TDocument_PreviewBlock_Params.Get_UserType

procedure TDocument_PreviewBlock_Params.ClearFields;
begin
 f_Data := nil;
 inherited;
end;//TDocument_PreviewBlock_Params.ClearFields

class function Op_Document_PreviewBlock.Call(const aTarget: IvcmEntity;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* ����� �������� Document.PreviewBlock � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_PreviewBlock_Params.Make(aData, aUserType));
  aTarget.Operation(opcode_Document_PreviewBlock, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_PreviewBlock.Call

class function Op_Document_PreviewBlock.Call(const aTarget: IvcmAggregate;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* ����� �������� Document.PreviewBlock � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_PreviewBlock_Params.Make(aData, aUserType));
  aTarget.Operation(opcode_Document_PreviewBlock, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_PreviewBlock.Call

class function Op_Document_PreviewBlock.Call(const aTarget: IvcmEntityForm;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* ����� �������� Document.PreviewBlock � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aData, aUserType);
end;//Op_Document_PreviewBlock.Call

class function Op_Document_PreviewBlock.Call(const aTarget: IvcmContainer;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* ����� �������� Document.PreviewBlock � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aData, aUserType);
end;//Op_Document_PreviewBlock.Call

constructor TDocument_ShowRespondentListToPart_Params.Create(const aList: IPositionList;
 const aCurrent: Il3SimpleNode = nil);
begin
 inherited Create;
 f_List := aList;
 f_Current := aCurrent;
end;//TDocument_ShowRespondentListToPart_Params.Create

class function TDocument_ShowRespondentListToPart_Params.Make(const aList: IPositionList;
 const aCurrent: Il3SimpleNode = nil): IDocument_ShowRespondentListToPart_Params;
var
 l_Inst : TDocument_ShowRespondentListToPart_Params;
begin
 l_Inst := Create(aList, aCurrent);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_ShowRespondentListToPart_Params.Make

function TDocument_ShowRespondentListToPart_Params.Get_List: IPositionList;
begin
 Result := f_List;
end;//TDocument_ShowRespondentListToPart_Params.Get_List

function TDocument_ShowRespondentListToPart_Params.Get_Current: Il3SimpleNode;
begin
 Result := f_Current;
end;//TDocument_ShowRespondentListToPart_Params.Get_Current

procedure TDocument_ShowRespondentListToPart_Params.ClearFields;
begin
 Finalize(f_List);
 f_Current := nil;
 inherited;
end;//TDocument_ShowRespondentListToPart_Params.ClearFields

class function Op_Document_ShowRespondentListToPart.Call(const aTarget: IvcmEntity;
 const aList: IPositionList;
 const aCurrent: Il3SimpleNode = nil): Boolean;
 {* ����� �������� Document.ShowRespondentListToPart � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_ShowRespondentListToPart_Params.Make(aList, aCurrent));
  aTarget.Operation(opcode_Document_ShowRespondentListToPart, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_ShowRespondentListToPart.Call

class function Op_Document_ShowRespondentListToPart.Call(const aTarget: IvcmAggregate;
 const aList: IPositionList;
 const aCurrent: Il3SimpleNode = nil): Boolean;
 {* ����� �������� Document.ShowRespondentListToPart � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_ShowRespondentListToPart_Params.Make(aList, aCurrent));
  aTarget.Operation(opcode_Document_ShowRespondentListToPart, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_ShowRespondentListToPart.Call

class function Op_Document_ShowRespondentListToPart.Call(const aTarget: IvcmEntityForm;
 const aList: IPositionList;
 const aCurrent: Il3SimpleNode = nil): Boolean;
 {* ����� �������� Document.ShowRespondentListToPart � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aList, aCurrent);
end;//Op_Document_ShowRespondentListToPart.Call

class function Op_Document_ShowRespondentListToPart.Call(const aTarget: IvcmContainer;
 const aList: IPositionList;
 const aCurrent: Il3SimpleNode = nil): Boolean;
 {* ����� �������� Document.ShowRespondentListToPart � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aList, aCurrent);
end;//Op_Document_ShowRespondentListToPart.Call

constructor TDocument_ShowCorrespondentListToPart_Params.Create(const aList: IPositionList;
 const aCurrent: Il3SimpleNode = nil);
begin
 inherited Create;
 f_List := aList;
 f_Current := aCurrent;
end;//TDocument_ShowCorrespondentListToPart_Params.Create

class function TDocument_ShowCorrespondentListToPart_Params.Make(const aList: IPositionList;
 const aCurrent: Il3SimpleNode = nil): IDocument_ShowCorrespondentListToPart_Params;
var
 l_Inst : TDocument_ShowCorrespondentListToPart_Params;
begin
 l_Inst := Create(aList, aCurrent);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_ShowCorrespondentListToPart_Params.Make

function TDocument_ShowCorrespondentListToPart_Params.Get_List: IPositionList;
begin
 Result := f_List;
end;//TDocument_ShowCorrespondentListToPart_Params.Get_List

function TDocument_ShowCorrespondentListToPart_Params.Get_Current: Il3SimpleNode;
begin
 Result := f_Current;
end;//TDocument_ShowCorrespondentListToPart_Params.Get_Current

procedure TDocument_ShowCorrespondentListToPart_Params.ClearFields;
begin
 Finalize(f_List);
 f_Current := nil;
 inherited;
end;//TDocument_ShowCorrespondentListToPart_Params.ClearFields

class function Op_Document_ShowCorrespondentListToPart.Call(const aTarget: IvcmEntity;
 const aList: IPositionList;
 const aCurrent: Il3SimpleNode = nil): Boolean;
 {* ����� �������� Document.ShowCorrespondentListToPart � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_ShowCorrespondentListToPart_Params.Make(aList, aCurrent));
  aTarget.Operation(opcode_Document_ShowCorrespondentListToPart, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_ShowCorrespondentListToPart.Call

class function Op_Document_ShowCorrespondentListToPart.Call(const aTarget: IvcmAggregate;
 const aList: IPositionList;
 const aCurrent: Il3SimpleNode = nil): Boolean;
 {* ����� �������� Document.ShowCorrespondentListToPart � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_ShowCorrespondentListToPart_Params.Make(aList, aCurrent));
  aTarget.Operation(opcode_Document_ShowCorrespondentListToPart, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_ShowCorrespondentListToPart.Call

class function Op_Document_ShowCorrespondentListToPart.Call(const aTarget: IvcmEntityForm;
 const aList: IPositionList;
 const aCurrent: Il3SimpleNode = nil): Boolean;
 {* ����� �������� Document.ShowCorrespondentListToPart � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aList, aCurrent);
end;//Op_Document_ShowCorrespondentListToPart.Call

class function Op_Document_ShowCorrespondentListToPart.Call(const aTarget: IvcmContainer;
 const aList: IPositionList;
 const aCurrent: Il3SimpleNode = nil): Boolean;
 {* ����� �������� Document.ShowCorrespondentListToPart � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aList, aCurrent);
end;//Op_Document_ShowCorrespondentListToPart.Call

constructor TDocument_ModifyBookmarkNotify_Params.Create(const anEntity: IUnknown);
begin
 inherited Create;
 f_nEntity := anEntity;
end;//TDocument_ModifyBookmarkNotify_Params.Create

class function TDocument_ModifyBookmarkNotify_Params.Make(const anEntity: IUnknown): IDocument_ModifyBookmarkNotify_Params;
var
 l_Inst : TDocument_ModifyBookmarkNotify_Params;
begin
 l_Inst := Create(anEntity);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_ModifyBookmarkNotify_Params.Make

function TDocument_ModifyBookmarkNotify_Params.Get_nEntity: IUnknown;
begin
 Result := f_nEntity;
end;//TDocument_ModifyBookmarkNotify_Params.Get_nEntity

procedure TDocument_ModifyBookmarkNotify_Params.ClearFields;
begin
 f_nEntity := nil;
 inherited;
end;//TDocument_ModifyBookmarkNotify_Params.ClearFields

class function Op_Document_ModifyBookmarkNotify.Call(const aTarget: IvcmEntity;
 const anEntity: IUnknown): Boolean;
 {* ����� �������� Document.ModifyBookmarkNotify � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_ModifyBookmarkNotify_Params.Make(anEntity));
  aTarget.Operation(opcode_Document_ModifyBookmarkNotify, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_ModifyBookmarkNotify.Call

class function Op_Document_ModifyBookmarkNotify.Call(const aTarget: IvcmAggregate;
 const anEntity: IUnknown): Boolean;
 {* ����� �������� Document.ModifyBookmarkNotify � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_ModifyBookmarkNotify_Params.Make(anEntity));
  aTarget.Operation(opcode_Document_ModifyBookmarkNotify, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_ModifyBookmarkNotify.Call

class function Op_Document_ModifyBookmarkNotify.Call(const aTarget: IvcmEntityForm;
 const anEntity: IUnknown): Boolean;
 {* ����� �������� Document.ModifyBookmarkNotify � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, anEntity);
end;//Op_Document_ModifyBookmarkNotify.Call

class function Op_Document_ModifyBookmarkNotify.Call(const aTarget: IvcmContainer;
 const anEntity: IUnknown): Boolean;
 {* ����� �������� Document.ModifyBookmarkNotify � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, anEntity);
end;//Op_Document_ModifyBookmarkNotify.Call

class procedure Op_Document_ModifyBookmarkNotify.Broadcast(const anEntity: IUnknown);
 {* ����� �������� Document.ModifyBookmarkNotify � ���� ������������������ ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 if (vcmDispatcher <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_ModifyBookmarkNotify_Params.Make(anEntity));
  vcmDispatcher.EntityOperationBroadcast(opcode_Document_ModifyBookmarkNotify, l_Params);
 end//vcmDispatcher <> nil
end;//Op_Document_ModifyBookmarkNotify.Broadcast

constructor TDocument_AddBookmarkFromContents_Params.Create(const aTag: Il3TagRef);
begin
 inherited Create;
 f_Tag := aTag;
end;//TDocument_AddBookmarkFromContents_Params.Create

class function TDocument_AddBookmarkFromContents_Params.Make(const aTag: Il3TagRef): IDocument_AddBookmarkFromContents_Params;
var
 l_Inst : TDocument_AddBookmarkFromContents_Params;
begin
 l_Inst := Create(aTag);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_AddBookmarkFromContents_Params.Make

function TDocument_AddBookmarkFromContents_Params.Get_Tag: Il3TagRef;
begin
 Result := f_Tag;
end;//TDocument_AddBookmarkFromContents_Params.Get_Tag

procedure TDocument_AddBookmarkFromContents_Params.ClearFields;
begin
 f_Tag := nil;
 inherited;
end;//TDocument_AddBookmarkFromContents_Params.ClearFields

class function Op_Document_AddBookmarkFromContents.Call(const aTarget: IvcmEntity;
 const aTag: Il3TagRef): Boolean;
 {* ����� �������� Document.AddBookmarkFromContents � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_AddBookmarkFromContents_Params.Make(aTag));
  aTarget.Operation(opcode_Document_AddBookmarkFromContents, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_AddBookmarkFromContents.Call

class function Op_Document_AddBookmarkFromContents.Call(const aTarget: IvcmAggregate;
 const aTag: Il3TagRef): Boolean;
 {* ����� �������� Document.AddBookmarkFromContents � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_AddBookmarkFromContents_Params.Make(aTag));
  aTarget.Operation(opcode_Document_AddBookmarkFromContents, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_AddBookmarkFromContents.Call

class function Op_Document_AddBookmarkFromContents.Call(const aTarget: IvcmEntityForm;
 const aTag: Il3TagRef): Boolean;
 {* ����� �������� Document.AddBookmarkFromContents � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aTag);
end;//Op_Document_AddBookmarkFromContents.Call

class function Op_Document_AddBookmarkFromContents.Call(const aTarget: IvcmContainer;
 const aTag: Il3TagRef): Boolean;
 {* ����� �������� Document.AddBookmarkFromContents � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aTag);
end;//Op_Document_AddBookmarkFromContents.Call

class function Op_Document_OpenNotSureTopic.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� Document.OpenNotSureTopic � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(opcode_Document_OpenNotSureTopic, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_OpenNotSureTopic.Call

class function Op_Document_OpenNotSureTopic.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� Document.OpenNotSureTopic � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(opcode_Document_OpenNotSureTopic, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_OpenNotSureTopic.Call

class function Op_Document_OpenNotSureTopic.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� Document.OpenNotSureTopic � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Document_OpenNotSureTopic.Call

class function Op_Document_OpenNotSureTopic.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� Document.OpenNotSureTopic � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Document_OpenNotSureTopic.Call

constructor TDocument_GotoPara_Params.Create(const aPara: Il3TagRef;
 aUserType: Integer);
begin
 inherited Create;
 f_Para := aPara;
 f_UserType := aUserType;
end;//TDocument_GotoPara_Params.Create

class function TDocument_GotoPara_Params.Make(const aPara: Il3TagRef;
 aUserType: Integer): IDocument_GotoPara_Params;
var
 l_Inst : TDocument_GotoPara_Params;
begin
 l_Inst := Create(aPara, aUserType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_GotoPara_Params.Make

function TDocument_GotoPara_Params.Get_Para: Il3TagRef;
begin
 Result := f_Para;
end;//TDocument_GotoPara_Params.Get_Para

function TDocument_GotoPara_Params.Get_UserType: Integer;
begin
 Result := f_UserType;
end;//TDocument_GotoPara_Params.Get_UserType

function TDocument_GotoPara_Params.Get_ResultValue: Boolean;
begin
 Result := f_ResultValue;
end;//TDocument_GotoPara_Params.Get_ResultValue

procedure TDocument_GotoPara_Params.Set_ResultValue(aValue: Boolean);
begin
 f_ResultValue := aValue;
end;//TDocument_GotoPara_Params.Set_ResultValue

procedure TDocument_GotoPara_Params.ClearFields;
begin
 f_Para := nil;
 inherited;
end;//TDocument_GotoPara_Params.ClearFields

class function Op_Document_GotoPara.Call(const aTarget: IvcmEntity;
 const aPara: Il3TagRef;
 aUserType: Integer): Boolean;
 {* ����� �������� Document.GotoPara � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_GotoPara_Params.Make(aPara, aUserType));
  aTarget.Operation(opcode_Document_GotoPara, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IDocument_GotoPara_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_GotoPara.Call

class function Op_Document_GotoPara.Call(const aTarget: IvcmAggregate;
 const aPara: Il3TagRef;
 aUserType: Integer): Boolean;
 {* ����� �������� Document.GotoPara � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_GotoPara_Params.Make(aPara, aUserType));
  aTarget.Operation(opcode_Document_GotoPara, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IDocument_GotoPara_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_GotoPara.Call

class function Op_Document_GotoPara.Call(const aTarget: IvcmEntityForm;
 const aPara: Il3TagRef;
 aUserType: Integer): Boolean;
 {* ����� �������� Document.GotoPara � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aPara, aUserType);
end;//Op_Document_GotoPara.Call

class function Op_Document_GotoPara.Call(const aTarget: IvcmContainer;
 const aPara: Il3TagRef;
 aUserType: Integer): Boolean;
 {* ����� �������� Document.GotoPara � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aPara, aUserType);
end;//Op_Document_GotoPara.Call

initialization
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Switcher, op_BecomeActive, en_capSwitcher, op_capBecomeActive, True, False, opcode_Switcher_BecomeActive)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_FindExplanation, en_capDocument, op_capFindExplanation, True, False, opcode_Document_FindExplanation)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_SynchroView, op_BecomeActive, en_capSynchroView, op_capBecomeActive, True, False, opcode_SynchroView_BecomeActive)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_List, op_GetDeList, en_capList, op_capGetDeList, True, False, opcode_List_GetDeList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_List, op_SetCurrentVisible, en_capList, op_capSetCurrentVisible, True, False, opcode_List_SetCurrentVisible)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_List, op_SwitchToFullList, en_capList, op_capSwitchToFullList, False, False, opcode_List_SwitchToFullList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_List, op_GetDsList, en_capList, op_capGetDsList, True, False, opcode_List_GetDsList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Form, op_RequestClose, en_capForm, op_capRequestClose, True, False, opcode_Form_RequestClose)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_ControlCenter, op_Refresh, en_capControlCenter, op_capRefresh, True, False, opcode_ControlCenter_Refresh)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_ListInfo, op_BecomeActive, en_capListInfo, op_capBecomeActive, True, False, opcode_ListInfo_BecomeActive)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Filters, op_DeselectAll, en_capFilters, op_capDeselectAll, True, False, opcode_Filters_DeselectAll)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_LocalList, op_SearchInList, en_capLocalList, op_capSearchInList, False, False, opcode_LocalList_SearchInList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_LocalList, op_PublishSourceSearchInList, en_capLocalList, op_capPublishSourceSearchInList, False, False, opcode_LocalList_PublishSourceSearchInList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_LocalList, op_Open, en_capLocalList, op_capOpen, False, False, opcode_LocalList_Open)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_LocalList, op_SearchDrugInList, en_capLocalList, op_capSearchDrugInList, False, False, opcode_LocalList_SearchDrugInList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_LocalList, op_OpenNewWindow, en_capLocalList, op_capOpenNewWindow, False, False, opcode_LocalList_OpenNewWindow)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_TimeMachine, op_TimeMachineOnOffNew, en_capTimeMachine, op_capTimeMachineOnOffNew, False, False, opcode_TimeMachine_TimeMachineOnOffNew)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('MachineOn', st_user_TimeMachine_TimeMachineOnOffNew_MachineOn))^ do
  begin
  end;
  with AddState(TvcmOperationStateForRegister_C('MachineOff', st_user_TimeMachine_TimeMachineOnOffNew_MachineOff))^ do
  begin
   rCaption := '��������� ������ �������/�������� ����';
   rImageIndex := 110;
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_TimeMachine, op_TimeMachineOnOff, en_capTimeMachine, op_capTimeMachineOnOff, True, False, opcode_TimeMachine_TimeMachineOnOff)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_TimeMachine, op_TimeMachineOffAndReset, en_capTimeMachine, op_capTimeMachineOffAndReset, True, False, opcode_TimeMachine_TimeMachineOffAndReset)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_TimeMachine, op_TimeMachineOnOffNew, en_capTimeMachine, op_capTimeMachineOnOffNew, False, False, opcode_TimeMachine_TimeMachineOnOffNew)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Filter, op_Activate, en_capFilter, op_capActivate, False, False, opcode_Filter_Activate)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('Deactivate', st_user_Filter_Activate_Deactivate))^ do
  begin
   rCaption := '�������� ������';
   rChecked := vcm_osfTrue;
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Filter, op_ActivateNode, en_capFilter, op_capActivateNode, True, False, opcode_Filter_ActivateNode)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_GetAnnotationDocFrmAct, en_capDocument, op_capGetAnnotationDocFrmAct, False, False, opcode_Document_GetAnnotationDocFrmAct)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_SimilarDocuments, en_capDocument, op_capSimilarDocuments, False, False, opcode_Document_SimilarDocuments)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_DocumentIsUseful, en_capDocument, op_capDocumentIsUseful, False, False, opcode_Document_DocumentIsUseful)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_DocumentIsUseless, en_capDocument, op_capDocumentIsUseless, False, False, opcode_Document_DocumentIsUseless)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_PrevDocumentInList, en_capDocument, op_capPrevDocumentInList, False, False, opcode_Document_PrevDocumentInList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_NextDocumentInList, en_capDocument, op_capNextDocumentInList, False, False, opcode_Document_NextDocumentInList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_ReturnToList, en_capDocument, op_capReturnToList, False, False, opcode_Document_ReturnToList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_AddToControl, en_capDocument, op_capAddToControl, False, False, opcode_Document_AddToControl)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('RemoveFromControl', st_user_Document_AddToControl_RemoveFromControl))^ do
  begin
   rCaption := '����� � ��������';
   rChecked := vcm_osfTrue;
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_UserCR1, en_capDocument, op_capUserCR1, False, False, opcode_Document_UserCR1)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('Corr', st_user_Document_UserCR1_Corr))^ do
  begin
   rImageIndex := 18;
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_UserCR2, en_capDocument, op_capUserCR2, False, False, opcode_Document_UserCR2)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('Corr', st_user_Document_UserCR2_Corr))^ do
  begin
   rImageIndex := 18;
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_AddToControl, en_capDocument, op_capAddToControl, False, False, opcode_Document_AddToControl)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_UserCR1, en_capDocument, op_capUserCR1, False, False, opcode_Document_UserCR1)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_UserCR2, en_capDocument, op_capUserCR2, False, False, opcode_Document_UserCR2)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_AddBookmark, en_capDocument, op_capAddBookmark, False, False, opcode_Document_AddBookmark)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_GetGraphicImage, en_capDocument, op_capGetGraphicImage, False, False, opcode_Document_GetGraphicImage)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_FoldersControl, op_EditElement, en_capFoldersControl, op_capEditElement, True, False, opcode_FoldersControl_EditElement)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_FoldersControl, op_DeleteElement, en_capFoldersControl, op_capDeleteElement, True, False, opcode_FoldersControl_DeleteElement)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_SavedQuery, op_OpenQuery, en_capSavedQuery, op_capOpenQuery, False, False, opcode_SavedQuery_OpenQuery)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_SavedQuery, op_ExecuteQuery, en_capSavedQuery, op_capExecuteQuery, False, False, opcode_SavedQuery_ExecuteQuery)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Filters, op_FiltersList, en_capFilters, op_capFiltersList, False, False, opcode_Filters_FiltersList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Filters, op_Clear, en_capFilters, op_capClear, False, False, opcode_Filters_Clear)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Filters, op_InternalClear, en_capFilters, op_capInternalClear, True, False, opcode_Filters_InternalClear)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Openable, op_OpenInNewWindow, en_capOpenable, op_capOpenInNewWindow, False, False, opcode_Openable_OpenInNewWindow)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_HyperLink, op_Open, en_capHyperLink, op_capOpen, False, False, opcode_HyperLink_Open)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_HyperLink, op_OpenNewWindow, en_capHyperLink, op_capOpenNewWindow, False, False, opcode_HyperLink_OpenNewWindow)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_HyperLink, op_NextHyperLink, en_capHyperLink, op_capNextHyperLink, False, False, opcode_HyperLink_NextHyperLink)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_HyperLink, op_PrevHyperLink, en_capHyperLink, op_capPrevHyperLink, False, False, opcode_HyperLink_PrevHyperLink)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_HyperLink, op_OpenInNewTab, en_capHyperLink, op_capOpenInNewTab, False, False, opcode_HyperLink_OpenInNewTab)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_HyperLink, op_OpenScriptHyperLink, en_capHyperLink, op_capOpenScriptHyperLink, False, False, opcode_HyperLink_OpenScriptHyperLink)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_HyperLink, op_NavigateInternetHyperlink, en_capHyperLink, op_capNavigateInternetHyperlink, False, False, opcode_HyperLink_NavigateInternetHyperlink)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_HyperLink, op_Delete, en_capHyperLink, op_capDelete, False, True, opcode_HyperLink_Delete)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_SetActive, en_capDocument, op_capSetActive, True, False, opcode_Document_SetActive)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_ExportBlock, en_capDocument, op_capExportBlock, True, False, opcode_Document_ExportBlock)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_GetCurrentPosition, en_capDocument, op_capGetCurrentPosition, True, False, opcode_Document_GetCurrentPosition)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_SelectBlock, en_capDocument, op_capSelectBlock, True, False, opcode_Document_SelectBlock)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_CopyBlock, en_capDocument, op_capCopyBlock, True, False, opcode_Document_CopyBlock)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_PrintBlock, en_capDocument, op_capPrintBlock, True, False, opcode_Document_PrintBlock)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_PrintDialogBlock, en_capDocument, op_capPrintDialogBlock, True, False, opcode_Document_PrintDialogBlock)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_PreviewBlock, en_capDocument, op_capPreviewBlock, True, False, opcode_Document_PreviewBlock)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_ShowRespondentListToPart, en_capDocument, op_capShowRespondentListToPart, True, False, opcode_Document_ShowRespondentListToPart)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_ShowCorrespondentListToPart, en_capDocument, op_capShowCorrespondentListToPart, True, False, opcode_Document_ShowCorrespondentListToPart)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_ModifyBookmarkNotify, en_capDocument, op_capModifyBookmarkNotify, True, False, opcode_Document_ModifyBookmarkNotify)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_AddBookmarkFromContents, en_capDocument, op_capAddBookmarkFromContents, True, False, opcode_Document_AddBookmarkFromContents)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_OpenNotSureTopic, en_capDocument, op_capOpenNotSureTopic, True, False, opcode_Document_OpenNotSureTopic)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_GotoPara, en_capDocument, op_capGotoPara, True, False, opcode_Document_GotoPara)) do
 begin
 end;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
