unit evInternalInterfaces;

interface

uses
 l3IntfUses
 , evdInterfaces
 , nevTools
 , l3Interfaces
 , nevBase
 , l3Variant
 , l3Types
 , l3Core
;

type
 PIevDataObject = ^IevdDataObject;
 
 IevColumnBorderMarker = interface(IevMarker)
  {* Маркер границы ячейки таблицы }
 end;//IevColumnBorderMarker
 
 IevChangeParamTool = interface
  {* Инструмент для изменения параметров тега }
  function ChangeParam(const aMarker: IevMarker;
   aValue: Integer;
   const anOpPack: InevOp;
   SeeByLevel: Boolean;
   aMinIndex: Tl3Index;
   aMaxIndex: Tl3Index): Boolean;
   {* Изменить значение параметра }
 end;//IevChangeParamTool
 
 IevObjectFrame = interface
  function ObjectXOffset: Integer;
 end;//IevObjectFrame
 
 TShiftState = l3Core.TShiftState;
 
 TevMouseButton = Tl3MouseButton;
  {* Кнопка мыши }
 
 TevMouseAction = Tl3MouseAction;
  {* Событие мыши }
 
 IevSubFlagsSpy = interface
  {* Объект, принимающий уведомления об изменении флагов метки (IevSub) }
  procedure NotifyFlagsChange(const aSub: IevSub);
   {* флаги метки изменились }
 end;//IevSubFlagsSpy
 
 IevMarkerSpy = interface
  {* Объект, принимающий уведомления о изменении маркеров }
  procedure NotifyMarkerChange;
   {* маркеры изменились }
 end;//IevMarkerSpy
 
 IevCursorSource = interface
  {* Объект-источник курсора }
  procedure MakeCursor;
   {* создать курсор }
  procedure InitAACLikeCursor;
 end;//IevCursorSource
 
 InevContentsNodeFilter = interface
  procedure ColorNode(const aNode: InevNode);
  procedure CheckTagList;
  procedure AddFilterTag(aTag: Tl3Variant);
  procedure ChangeDocument(aDocument: Tl3Variant);
  function NeedCreate(aTag: Tl3Variant): Boolean;
 end;//InevContentsNodeFilter
 
 IevF1LikeEditor = interface
  function CanInsertParaOnMove: Boolean;
   {* Можно ли вставлять параграфы при движении курсора }
  function IsInReadOnlyPara(const aPara: InevPara;
   NeedDeleteIfReadOnly: Boolean): Boolean;
   {* Находимся ли в параграфе, в котором запрещено редактирование }
 end;//IevF1LikeEditor
 
 TevMergeParaListType = (
  ev_mltBlocks
  , ev_mtlTables
  , ev_mtlCells
 );//TevMergeParaListType
 
implementation

uses
 l3ImplUses
;

end.
