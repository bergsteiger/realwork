unit evdTypes;

interface

uses
 l3IntfUses
;

type
 TevIndentType = (
  {* ������������ ������� �� �����������. }
  ev_itLeft
   {* �� ������ ����. }
  , ev_itRight
   {* �� ������� ����. }
  , ev_itCenter
   {* �� ������. }
  , ev_itWidth
   {* �� ������. }
  , ev_itPreformatted
   {* "������������������". }
  , ev_itNone
 );//TevIndentType
 
 TevPageOrientation = (
  {* ���������� ��������. }
  ev_poPortrait
   {* �������. }
  , ev_poLandscape
   {* ���������. }
 );//TevPageOrientation
 
 TevMergeStatus = (
  {* ������� ����������� �����. }
  ev_msNone
  , ev_msHead
  , ev_msContinue
 );//TevMergeStatus
 
 TevVerticalAligment = (
  {* ������������ ������� �� ���������. }
  ev_valTop
  , ev_valCenter
  , ev_valBottom
 );//TevVerticalAligment
 
 TevControlType = (
  {* ��� ��������. }
  ev_ctLabel
   {* ����� � �������� � ���� ����� }
  , ev_ctEdit
   {* ������� �������� }
  , ev_ctCombo
   {* ���������� ������ }
  , ev_ctButton
   {* ������ }
  , ev_ctSpinedit
   {* �������� � ������������ �������������� ����� }
  , ev_ctCheckEdit
   {* �������� � CheckBox }
  , ev_ctEllipsesEdit
   {* �������� � ������� }
  , ev_ctRadioEdit
   {* �������� � RadioButton }
  , ev_ctCalEdit
   {* �������� � ���������� ��������� }
  , ev_ctCollapsedPanel
   {* ������������� ������ }
  , ev_ctStateButton
   {* ������ � ���������� ��������� }
  , ev_ctEmailEdit
   {* �������� ��� ����� E-mail ������ (� ���������) }
  , ev_ctMemoEdit
   {* ������������� ���� ����� (�� ������������) }
  , ev_ctPictureLabel
   {* ����� ���������� � ��������� }
  , ev_ctTextParaLabel
   {* ����� � ������� �������� }
  , ev_ctPhoneEdit
  , ev_ctUnknown
   {* ����������� ��� �������� }
 );//TevControlType
 
 TevReqKind = (
  {* ��� ���������. }
  ev_rkSimple
   {* ������� ��������, ����������� ������������� (���������� � ������) (ev_rkSimple). }
  , ev_rkContext
   {* ����������� �������, ����������� �������������� (���������� � ������)(ev_rkContext). }
  , ev_rkDescription
   {* �������������� ������� (�� �������� � ������ (ev_rkDescription). }
 );//TevReqKind
 
 TevSubPlace = (
  ev_spNoWhere
  , ev_spOnlyInContents
  , ev_spInContentsAndOnSubPanel
  , ev_spOnlyOnSubPanel
 );//TevSubPlace
 
 TevLinkViewKind = (
  ev_lvkUnknown
   {* ���������� }
  , ev_lvkInternalValid
   {* ������ �������. ���������� }
  , ev_lvkInternalInvalid
   {* ������ �������. �� ������������� ���������� }
  , ev_lvkExternal
   {* ������ }
  , ev_lvkInternalAbolished
   {* ������ �������. �� ���������� ���� �������� }
  , ev_lvkInternalPreactive
   {* ������ �������. �� �� ���������� � ���� �������� }
  , ev_lvkExternalENO
   {* ������� ���������� }
  , ev_lvkInternalEdition
   {* �������� ��������� }
  , ev_lvkScript
  , ev_lvkShellInternal
 );//TevLinkViewKind
 
 TevSubHandle = (
  {* ���� �����. }
  None
  , Sub
  , Marker
  , Bookmark
  , Mark
 );//TevSubHandle
 
 TevDocumentPlace = (
  {* ����� � ���������. }
  ev_dpNone
   {* �����. }
  , ev_dpEnd
   {* � �����. }
 );//TevDocumentPlace
 
 TevHFType = (
  {* ��� ����������� }
  evd_hftOrdinal
  , evd_hftLeft
  , evd_hftRight
  , evd_hftFirst
 );//TevHFType
 
 // Tevev_spInContents
 
 TevSegmentHandle = (
  Superposition
  , View
  , Hyperlinks
  , FoundWords
  , Found
  , Objects
  , Mistakes
  , Diff
 );//TevSegmentHandle
 
 // TevNormalSegLayerHandleP
 
 TevBlockViewKind = (
  ev_bvkNone
  , ev_bvkLeft
  , ev_bvkRight
 );//TevBlockViewKind
 
 TevNormalSegLayerHandleSet = set of TevNormalSegLayerHandleP;
 
implementation

uses
 l3ImplUses
;

end.
