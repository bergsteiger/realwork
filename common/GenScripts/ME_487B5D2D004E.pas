unit evCursorController;

interface

uses
 l3IntfUses
 , l3_Base
 , nevTools
 , l3Variant
 , nevBase
 , l3IID
;

type
 TevCursorController = class(Tl3_Base, InevSelection, InevPointListener)
  {* Курсор на документ. }
  procedure ForceStore;
  function DoGetBlock(const aDocument: InevObject): InevRange;
  procedure Create(const aView: InevInputView);
  function GetIsMulti: Boolean;
  function DoAddBlock(const aStart: InevBasePoint;
   const aFinish: InevBasePoint): Boolean;
  function GetContains(const C: InevBasePoint): Boolean;
  procedure DoCursorChanged(const aCursor: InevBasePoint);
  procedure DoAssignSel(const aView: InevView;
   const aSource: InevRange;
   AllowAddToMulti: Boolean);
  function Processor: InevProcessor;
  function DocumentPara: InevObject;
  procedure Lock;
   {* Запретить нотификацию об изменениях }
  procedure Unlock;
   {* Разрешить нотификацию об изменениях }
  procedure DoSetDocument(aValue: Tl3Tag);
  function NeedUnselectOnSelectPoint(const aPoint: InevBasePoint): Boolean;
   {* Нужно ли сбрасывать выделение в SelectPoint }
  function DoUnselect: Boolean;
   {* Снять выделение }
  procedure FreeCursor(var C: InevLinkedPoint); overload;
  procedure FreeCursor(var C: InevPoint); overload;
  function CheckCursor(var C: InevLinkedPoint): InevLinkedPoint; overload;
  function CheckCursor(var C: InevPoint): InevPoint; overload;
  function CheckCursor: InevLinkedPoint; overload;
  procedure LinkView(const aView: InevInputView);
  procedure FreeCursor(var C: InevBasePoint); overload;
  function Point: InevLinkedPoint;
  function IsMulti: Boolean;
  function Select(const aSource: InevRange;
   AllowAddToMulti: Boolean): Boolean;
   {* присваивает одно выделение другому. }
  procedure SelectPt(const Value: TnevPoint;
   aNeedUpdate: Boolean);
   {* устанавливает позицию выделения (в мировых координатах). }
  function SelectPoint(const aPoint: InevBasePoint;
   aNeedSetTop: Boolean;
   aNeedShowCaret: Boolean;
   aDiff: Integer): Boolean;
   {* параметр aNeedSetTop означает подравливать ли верхний край экрана под курсор
если false, то курсор должен показаться в ЛЮБОМ месте экрана
а если true - то жёстко сверху }
  function AddBlock(const aStart: InevBasePoint;
   const aFinish: InevBasePoint): Boolean;
   {* добавляет отрезок выделения. }
  function Unselect: Boolean;
   {* снять выделение. }
  function GetBlock: InevRange;
   {* получить текущий объект выделения. }
  function Contains(const C: InevBasePoint): Boolean;
   {* проверяет содержит ли выделение курсор. }
  procedure CursorChanged(const aCursor: InevBasePoint);
   {* курсор aCursor изменился. }
  procedure ParaChanged(const aCursor: InevBasePoint);
   {* текущий параграф изменился. }
  function View: InevView;
 end;//TevCursorController
 
implementation

uses
 l3ImplUses
 , k2Base
 , evMsgCode
 , evOp
 , k2TagGen
 , l3InternalInterfaces
 , evDocumentPartGenerator
 , SysUtils
 , nevNavigation
 , l3InterfacesMisc
 , evdStyles
 , LeafPara_Const
 , k2Tags
 , evParaTools
;

end.
