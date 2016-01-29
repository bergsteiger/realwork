unit ddTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/ddTypes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::dd::ddTypes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  l3Base
  ;

type
 TAddSizeEvent = procedure (Size: LongInt) of object;

 TddErrorEvent = procedure (const aDescription: AnsiString;
  aCategory: Integer = 0) of object;

 TddCommentWriteEvent = procedure (TopicNo: LongInt;
  Comment: Tl3String) of object;

 IddErrorHandler = interface(IUnknown)
   ['{45306EDA-E758-4DF3-AA37-32E19F7C7641}']
   function pm_GetOnError: TddErrorEvent; stdcall;
   procedure pm_SetOnError(aValue: TddErrorEvent); stdcall;
   property OnError: TddErrorEvent
     read pm_GetOnError
     write pm_SetOnError;
 end;//IddErrorHandler

const
  { Common }
 propUndefined = High(Integer);
 ddDefaultPad = 108;
 ddDefaultCellWidth = 2 * ddDefaultPad;

type
 TddClearBoder = (
   dd_cbNeedFrame
 , dd_cbClearFrame
 );//TddClearBoder

 TddCellJust = (
   cellTop
 , cellCenter
 , cellBottom
 );//TddCellJust

 TddBorderOwner = (
   boNone
 , boChar
 , boPara
 , boRow
 , boCell
 );//TddBorderOwner

 TJust = (
   justL
 , justR
 , justC
 , justF
 , justP
 , justNotDefined
 );//TJust

 TTabKind = (
   tkLeft
 , tkRight
 , tkCentered
 , tkDecimal
 , tkNotDefined
 );//TTabKind

 TTabLead = (
   tlNone
 , tlDots
 , tlMiddleDots
 , tlHyphens
 , tlUnderline
 , tlThickLine
 , tlEqualSign
 );//TTabLead

 TddCharProperties = (
   ddAnime
 , ddUnderline
 , ddCaps
 , ddContour
 , ddCharPosition
 , ddBold
 , ddItalic
 , ddHidden
 , ddStrikeout
 , ddDeleted
 , ddCharScale
 , ddSubPos
 , ddFontNumber
 , ddFontSize
 , ddFontCharSet
 , ddLanguage
 , ddFColor
 , ddBColor
 , ddForeColor
 , ddBackColor
 , ddHighlight
 , ddStyle
 , ddEvdStyle
 , ddPrintFontSize
 );//TddCharProperties

 TddListType = (
   ltOrdered
 , ltUnordered
 );//TddListType

 TddOrderType = (
   otCapitalLetters
 , otSmallLetters
 , otLargeRoman
 , otSmallRoman
 , otNumbers
 );//TddOrderType

 TddRowType = (
   dd_rtNone
 , dd_rtSBS
 , dd_rtNested
 , dd_rtAAC
 , dd_rtNestedAAC
 );//TddRowType

 IddSaveObjectPath = interface(IUnknown)
   ['{F0BCA447-CD86-4385-87BC-4F043822DD02}']
   procedure SaveObjectPath(const aFileName: AnsiString);
 end;//IddSaveObjectPath

 IddDocumentListner = interface(IUnknown)
   ['{88B10A4A-9FBA-41A4-B6CD-33FF3A4E26E6}']
   procedure NeedDeleteFileData;
 end;//IddDocumentListner

 TddFillAAC = (
   dd_faacNone // Обычная заливка
 , dd_faacWhite // Заливка строки белым цветом.
 , dd_faacDefColor // Заливка строки цветом стиля
 , dd_faacDefColorWithoutLine // Заливка строки цветом фона, но без скрытия границ ячеек.
 , dd_faacAlignCell // Выравнивающая ячейка - костыль для LibreOffice, чтобы он не позволял себе "оптимизировать" ширину ячеек после широкой вложенной таблицы. Это обычная ячейка с границами и заливкой в белый цвет без текста.
 );//TddFillAAC

 TddRowPosition = (
   dd_rpNone // Обычная строка
 , dd_rpFirst
 , dd_rpLast
 );//TddRowPosition

 TGetLoginPasswordProc = function (var aLogin: AnsiString;
  var aPassword: AnsiString): Boolean;

 TddRTFWidthUnits = (
   dd_wuNull
 , dd_wuAuto
 , dd_wuPercentage
 , dd_wuTwips
 );//TddRTFWidthUnits

implementation

end.