unit vtHideField;

interface

uses
 l3IntfUses
 , l3Interfaces
 , afwTextControl
 , afwInterfaces
 , evTypes
 , Classes
 , Graphics
 , ImgList
 , Controls
 , Types
 , Messages
 , afwTypes
 , l3InternalInterfaces
;

type
 ThfOption = (
  hfoCanHide
  , hfoHyperlink
 );//ThfOption
 
 ThfState = (
  hfsHide
  , hfsShow
 );//ThfState
 
 ThfOptions = set of ThfOption;
 
 ThfValidateStateEvent = procedure(aSender: TObject;
  var theState: ThfState) of object;
 
 ThfCommandEvent = function(aSender: TObject;
  aOperation: Tl3OperationCode): Boolean of object;
 
 TvtCustomHideField = class(TafwTextControl, IafwStyleTableSpy)
  procedure DoStateChanged;
  function CheckImage(aImages: TCustomImageList;
   aImageIndex: Integer): Boolean;
   {* проверяет установлен ли imagelist и не выходит ли за пределы диапазона индекс. }
  procedure DoHyperlink;
  procedure OnImageListChange(Sender: TObject);
  procedure ExchangeState;
   {* поменять состояние }
  function GetHeaderLineRect: TRect;
   {* высота заголовка, содержащего гипперссылку и кнопку }
  function GetHeaderLineHeight: Integer;
   {* высота линии содержащей гиперссылку и кнопку }
  function GetImageRect: TRect;
   {* возвращает положение иконки }
  function GetImageTop: Integer;
   {* верхняя точка иконки }
  procedure Rebuild;
   {* изменился один из параметров, нужно изменеить высоту и перерисовать }
  procedure MakeHideHeight;
   {* установить размер для свернутого состояния }
  function IsHandledShortcut(var Msg: TWMKeyDown): Boolean;
  procedure DoStyleTableChanged;
  procedure HideControl;
  procedure CMControlChange(var Message: TMessage);
  procedure WMEraseBkgnd(var Message: TWMEraseBkgnd);
  procedure CMTextChanged(var Message: TMessage);
  procedure CMFontChanged(var Message: TMessage);
  procedure WMKillFocus(var Message: TMessage);
  procedure WMSetFocus(var Message: TMessage);
  procedure WMSysKeyDown(var Msg: TWMSysKeyDown);
  procedure CNKeyDown(var Msg: TWMKeyDown);
  function OptionsStored: Boolean;
   {* "Функция определяющая, что свойство Options сохраняется" }
  procedure StyleTableChanged;
   {* таблица стилей изменилась. }
 end;//TvtCustomHideField
 
 TvtHideField = class(TvtCustomHideField)
 end;//TvtHideField
 
implementation

uses
 l3ImplUses
 , vtHideFieldUtils
 , Windows
 , l3ScreenIC
 , l3String
 , l3Base
 , l3MinMax
 , afwFacade
 , evStyleInterface
 , TextPara_Const
 , evStyleTableSpy
 , evdTextStyle_Const
 , OvcCmd
 , OvcConst
 , l3Units
 , Forms
 , TtfwClassRef_Proxy
 , vtHideFieldWords
;

end.
