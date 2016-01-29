unit evDropControl;

interface

uses
 l3IntfUses
 , evEditControl
 , evQueryCardDropControlsInt
 , Controls
 , l3Interfaces
 , nevTools
 , l3Units
 , nevBase
 , Messages
;

type
 TevDropControl = class(TevEditControl, IevDropControl)
  function DropContainer: IevDropContainer;
   {* Возвращает интерфейс контейнера с обработкой событий дерева }
  function GetControl: TControl;
  procedure CalcControlPosition(const aView: InevView;
   const aPt0: Tl3Point;
   const aExtend: Tl3Point;
   var aDropPoint: TPoint;
   var aInvert: Boolean;
   var aWidth: Integer);
  function DocumentToScreen(const aPt: Tl3Point): TPoint;
  function DropControlHeigth: Integer;
  procedure DoDrop(const aPoint: TPoint;
   AInvert: Boolean;
   AWidth: Integer;
   ByUser: Boolean);
   {* Вываливает выпадающий виджет по указанным координатам }
  function PtInButton(const aPt: TnevPoint;
   const aMap: InevMap): Boolean;
   {* Щелчок по кнопке редактора }
  procedure DoEscPressed;
  procedure DoDropDownCurrentChanged(const aNode: InevSimpleNode);
  procedure DoAfterHideControl;
  procedure AfterHideControl;
  procedure EscPressed;
   {* Обработчик закрытия дерева по ESC. }
  procedure HideControl;
   {* Прячет выпадающий контрол. }
  function MouseWheel(aDown: Boolean): Boolean;
   {* Обработчик прокрутки колеса мыши. }
  function KeyDown(const aView: InevView;
   var Msg: TWMKeyDown): Boolean;
  procedure CloseTree;
   {* Прячет дерево как по нажатию Esc - с посылкой сообщения редактору. }
  function Down: Boolean;
   {* Нажата ли кнопка в редакторе. }
  function DropDown(const aView: InevView;
   const aTextPara: InevPara;
   ByUser: Boolean): Boolean;
   {* Реализует выпадение дерева или календаря. }
  function Para: InevPara;
  procedure DropDownCurrentChanged(const aNode: InevSimpleNode);
 end;//TevDropControl
 
implementation

uses
 l3ImplUses
 , Windows
 , k2Tags
 , OvcConst
 , Forms
 , nevFacade
 , SysUtils
;

end.
