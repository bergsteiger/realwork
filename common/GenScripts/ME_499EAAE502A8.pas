unit vcmUserControls;
 {* ����������� ��������, ����������������� � ������������� }

// ������: "w:\common\components\gui\Garant\VCM\vcmUserControls.pas"
// ���������: "Interfaces"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmExternalInterfaces
 , Classes
 {$If NOT Defined(NoVCL)}
 , ActnList
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 IvcmBaseObjectDef = interface(IvcmBase)
  ['{C2874075-FAA7-4C00-B3BE-F6FD56ED5433}']
  function Get_Caption: IvcmCString;
  function Get_Name: TvcmString;
  property Caption: IvcmCString
   read Get_Caption;
   {* ���������������� ��� ������� }
  property Name: TvcmString
   read Get_Name;
   {* ��� ������� }
 end;//IvcmBaseObjectDef

 IvcmUserFriendlyControl = interface(IvcmBaseObjectDef)
  {* ������� ��������� ��� �������� ������� ����������� ��� ������������ }
  ['{F12A7495-DA83-4EEE-A5C1-77957F72E98A}']
  function Get_ImageIndex: Integer;
  function Get_Hint: IvcmCString;
  function Get_LongHint: IvcmCString;
  property ImageIndex: Integer
   read Get_ImageIndex;
  property Hint: IvcmCString
   read Get_Hint;
   {* ��������� ��� ������ ����, ��������������� ������ }
  property LongHint: IvcmCString
   read Get_LongHint;
   {* ��������� ��������� ��� ������ ����, ��������������� ������ }
 end;//IvcmUserFriendlyControl

 IvcmIdentifiedUserFriendlyControl = interface(IvcmUserFriendlyControl)
  {* ������� ��������� ��� �������� ������� ����������� ��� ������������ � ������������� }
  ['{218D3AE5-6CA7-4CF3-B27B-B277C74C4165}']
  function Get_ID: TvcmControlID;
  property ID: TvcmControlID
   read Get_ID;
   {* ������������� ������� }
 end;//IvcmIdentifiedUserFriendlyControl

 TvcmOperationOption = (
  {* ����� ���������� �������� � ���� � �� ������ ������������. }
  vcm_ooShowInMainToolbar
   {* �������� ����� �������� �� ������
                                  ������������ ������� ����� }
  , vcm_ooShowInChildToolbar
   {* �������� ����� �������� �� ������
                                  ������������ ����� �������� }
  , vcm_ooShowInContextMenu
   {* �������� ����� �������� � ����������� ���� }
  , vcm_ooShowInMainMenu
   {* �������� ����� �������� � ������� ����
                                  ������� �����. }
  , vcm_ooShowInChildMenu
   {* �������� ����� �������� � ���� �����
                                  �������� }
 );//TvcmOperationOption

 TvcmOperationMode = (
  {* ����� ���������� ��������. }
  vcm_omTest
   {* ����� �������� ����������� �������� }
  , vcm_omExecute
   {* ����� ����������������� �����������
                      �������� }
  , vcm_omAggregateExecute
 );//TvcmOperationMode

 TvcmOperationCallType = (
  vcm_octShortCut
  , vcm_octMainMenu
  , vcm_octContextMenu
  , vcm_octToolbar
 );//TvcmOperationCallType

 TvcmUserType = 0 .. 31;
  {* ��� �����. }

 TvcmUserTypes = set of TvcmUserType;

 TvcmOperationOptions = set of TvcmOperationOption;

 IvcmOperationDef = interface(IvcmIdentifiedUserFriendlyControl)
  {* �������� �������� }
  ['{1563410C-852B-4365-A993-8A50640BADA1}']
  function Get_VisibleToUser: Boolean;
  function Get_IsCaptionUnique: Boolean;
  function Get_StatesCount: Integer;
  function Get_IsDefault: Boolean;
  function Get_GroupID: Integer;
  function Get_Category: TvcmString;
  function Get_OperationType: TvcmOperationType;
  function Get_ShortCut: TShortCut;
  function Get_SecondaryShortCuts: TShortCutList;
  function Get_ExcludeUserTypes: TvcmUserTypes;
  function Get_State(anIndex: Integer): IvcmUserFriendlyControl;
  function Get_ContextMenuWeight: Integer;
  function Get_Options: TvcmOperationOptions;
  property VisibleToUser: Boolean
   read Get_VisibleToUser;
  property IsCaptionUnique: Boolean
   read Get_IsCaptionUnique;
   {* ���������� �������� �� ��� �������� ���������� � �������� ����
             �������� ����� }
  property StatesCount: Integer
   read Get_StatesCount;
  property IsDefault: Boolean
   read Get_IsDefault;
  property GroupID: Integer
   read Get_GroupID;
   {* ������ ������ ��������� }
  property Category: TvcmString
   read Get_Category;
   {* ��������� ������� }
  property OperationType: TvcmOperationType
   read Get_OperationType;
  property ShortCut: TShortCut
   read Get_ShortCut;
  property SecondaryShortCuts: TShortCutList
   read Get_SecondaryShortCuts;
  property ExcludeUserTypes: TvcmUserTypes
   read Get_ExcludeUserTypes;
  property State[anIndex: Integer]: IvcmUserFriendlyControl
   read Get_State;
  property ContextMenuWeight: Integer
   read Get_ContextMenuWeight;
  property Options: TvcmOperationOptions
   read Get_Options;
 end;//IvcmOperationDef

 TvcmToolBarPos = (
  vcm_tbpTop
  , vcm_tbpBottom
  , vcm_tbpLeft
  , vcm_tbpRight
  , vcm_tbpNone
 );//TvcmToolBarPos

 TvcmToolBarPoses = set of TvcmToolBarPos;

 TvcmEffectiveToolBarPos = Low(TvcmToolBarPos) .. Pred(High(TvcmToolBarPos));

 TvcmEffectiveToolBarPoses = set of TvcmEffectiveToolBarPos;

 IvcmOperationalIdentifiedUserFriendlyControl = interface;

 IvcmOperationsDefIterator = interface
  {* �������� �������� �������� }
  ['{3B8CFB31-F1BF-469A-A248-1C613BA636C9}']
  function Get_Next: IvcmOperationDef;
  property Next: IvcmOperationDef
   read Get_Next;
   {* ��������� ��������� �������� }
 end;//IvcmOperationsDefIterator

 IvcmOperationalIdentifiedUserFriendlyControl = interface(IvcmIdentifiedUserFriendlyControl)
  {* ������� ��������� ��� �������� ������� ����������� ��� ������������ � �������� }
  ['{0F52E633-4306-4D75-93D1-5F259A9B3D45}']
  function Get_OperationsDefIterator: IvcmOperationsDefIterator;
  function Get_ToolbarPos: TvcmToolBarPos;
  property OperationsDefIterator: IvcmOperationsDefIterator
   read Get_OperationsDefIterator;
   {* �������� �������� ��������. ����� ���� nil }
  property ToolbarPos: TvcmToolBarPos
   read Get_ToolbarPos;
   {* ����� ������, ���������� ������� ��������, ����� ���������� �� � ������� }
 end;//IvcmOperationalIdentifiedUserFriendlyControl
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
