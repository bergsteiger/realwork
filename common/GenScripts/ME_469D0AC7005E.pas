unit evdTypes;
 {* Базовые типы, используемые форматом EVD. }

// Модуль: "w:\common\components\rtl\Garant\EVD\evdTypes.pas"
// Стереотип: "Interfaces"

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
;

const
 CI_TOPIC = 65537;
  {* для всех ссылок на документы }
 CI_BLOB = 65538;
  {* для ссылок на двоичные объекты }
 CI_MULT = 65539;
  {* для мультиссылок на документы/двоичные объекты }
 CI_REF = 65540;
  {* для ссылок на внешние интернет-ресурсы }
 CI_FolderLink = 65544;
 CI_ExternalOperation = 65545;
 CI_PHARM_MULTI = 65547;
  {* для мультиссылок на документы инфарма }
 CI_PIC = 65541;
  {* для ссылок на внешние картинки }
 CI_SCRIPT = 65552;
 CI_EDITION = 65543;
 CI_SHELL_INTERNAL = 65554;
  {* Ссылки с раскрывающихся блоков и т.п. Не должны передаваться на адаптер. [Requestlink:607263536] }
 ev_NullAddressType = 0;
 ev_defAddressType = CI_TOPIC;
 ev_cUserCommentFlags = 2;
  {* Флаги пользовательских комментариев }
 ev_cCommentsFlag = 1;
  {* Флаги комментариев юристов }
 ev_cVersionCommentsFlag = 4;
  {* Флаги версионных комментариев }
 POSITION_TYPE_PARA_ID = 2147483648;

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

 TevNormalSegLayerHandleP = ev_slView .. ev_slMistakes;

 TevBlockViewKind = (
  ev_bvkNone
  , ev_bvkLeft
  , ev_bvkRight
 );//TevBlockViewKind

 TevNormalSegLayerHandleSet = set of TevNormalSegLayerHandleP;

const
 {* Слои меток. }
 ev_sbtNone = None;
  {* несуществующий слой меток. }
 ev_sbtSub = Sub;
  {* слой Sub'ов. }
 ev_sbtMarker = Marker;
  {* слой закладок. }
 ev_sbtBookmark = Bookmark;
  {* слой именованных закладок (зарезервированно). }
 ev_sbtMark = Mark;
  {* слой вспомогательных значков (зарезервированно). }
 ev_sbtPara = 10;
  {* параграф (псевдослой). }
 ev_sbtDocumentPlace = 11;
  {* место в документе (псевдослой) см. [TevDocumentPlace]. }
 ev_sbtBySearcher = 14;
  {* условие по Searcher'у (псевдослой). }
 {* Метка входит в оглавление }
 ev_spInContents = [ev_spOnlyInContents, ev_spInContentsAndOnSubPanel];
 {* Слои сегментов оформления }
 ev_slSuperposition = Superposition;
  {* слой суперпозиции сегментов. }
 ev_slView = View;
  {* слой оформления. }
 ev_slHyperlinks = Hyperlinks;
  {* слой гиперссылок. }
 ev_slFoundWords = FoundWords;
  {* слой слов найденных по контексту. }
 ev_slFound = Found;
  {* слой найденных слов (зарезервированно). }
 ev_slObjects = Objects;
  {* слой объектов, вставленных в параграф. }
 ev_slMistakes = Mistakes;
  {* слой сегментов для покраски опечаток. }
 ev_slDiff = Diff;
  {* Разница двух сравниваемых документов }

implementation

uses
 l3ImplUses
;

end.
