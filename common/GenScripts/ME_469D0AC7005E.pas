unit evdTypes;

interface

uses
 l3IntfUses
;

type
 TevIndentType = (
  {* Выравнивание объекта по горизонтали. }
  ev_itLeft
   {* по левому краю. }
  , ev_itRight
   {* по правому краю. }
  , ev_itCenter
   {* по центру. }
  , ev_itWidth
   {* по ширине. }
  , ev_itPreformatted
   {* "преформатированный". }
  , ev_itNone
 );//TevIndentType
 
 TevPageOrientation = (
  {* Ориентация страницы. }
  ev_poPortrait
   {* книжная. }
  , ev_poLandscape
   {* альбомная. }
 );//TevPageOrientation
 
 TevMergeStatus = (
  {* признак объединения ячеек. }
  ev_msNone
  , ev_msHead
  , ev_msContinue
 );//TevMergeStatus
 
 TevVerticalAligment = (
  {* Выравнивание объекта по вертикали. }
  ev_valTop
  , ev_valCenter
  , ev_valBottom
 );//TevVerticalAligment
 
 TevControlType = (
  {* Тип контрола. }
  ev_ctLabel
   {* метка с курсором в виде рамки }
  , ev_ctEdit
   {* обычный редактор }
  , ev_ctCombo
   {* выпадающий список }
  , ev_ctButton
   {* кнопка }
  , ev_ctSpinedit
   {* редактор с возможностью редактирования чисел }
  , ev_ctCheckEdit
   {* редактор с CheckBox }
  , ev_ctEllipsesEdit
   {* редактор с кнопкой }
  , ev_ctRadioEdit
   {* редактор с RadioButton }
  , ev_ctCalEdit
   {* редактор с выпадающим календарём }
  , ev_ctCollapsedPanel
   {* сворачивающая панель }
  , ev_ctStateButton
   {* кнопка с изменением состояния }
  , ev_ctEmailEdit
   {* редактор для ввода E-mail адреса (с проверкой) }
  , ev_ctMemoEdit
   {* многострочное поле ввода (не используется) }
  , ev_ctPictureLabel
   {* текст примечания с картинкой }
  , ev_ctTextParaLabel
   {* метка с обычным курсором }
  , ev_ctPhoneEdit
  , ev_ctUnknown
   {* неизвестный тип контрола }
 );//TevControlType
 
 TevReqKind = (
  {* Тип реквизита. }
  ev_rkSimple
   {* обычный реквизит, допускающий редактировани (попадающий в модель) (ev_rkSimple). }
  , ev_rkContext
   {* контекстный атрибут, допускающий редактирование (попадающий в модель)(ev_rkContext). }
  , ev_rkDescription
   {* информационный атрибут (НЕ попадает в модель (ev_rkDescription). }
 );//TevReqKind
 
 TevSubPlace = (
  ev_spNoWhere
  , ev_spOnlyInContents
  , ev_spInContentsAndOnSubPanel
  , ev_spOnlyOnSubPanel
 );//TevSubPlace
 
 TevLinkViewKind = (
  ev_lvkUnknown
   {* Неизвестно }
  , ev_lvkInternalValid
   {* Внутри системы. Правильная }
  , ev_lvkInternalInvalid
   {* Внутри системы. На отсутствующую информацию }
  , ev_lvkExternal
   {* Наружу }
  , ev_lvkInternalAbolished
   {* Внутри системы. На утративший силу документ }
  , ev_lvkInternalPreactive
   {* Внутри системы. На не вступивший в силу документ }
  , ev_lvkExternalENO
   {* Внешнее приложение }
  , ev_lvkInternalEdition
   {* Редакция документа }
  , ev_lvkScript
  , ev_lvkShellInternal
 );//TevLinkViewKind
 
 TevSubHandle = (
  {* Слои меток. }
  None
  , Sub
  , Marker
  , Bookmark
  , Mark
 );//TevSubHandle
 
 TevDocumentPlace = (
  {* Место в документе. }
  ev_dpNone
   {* Нигде. }
  , ev_dpEnd
   {* В конце. }
 );//TevDocumentPlace
 
 TevHFType = (
  {* Тип колонтитула }
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
