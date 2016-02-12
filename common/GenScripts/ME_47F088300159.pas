unit evInternalInterfaces;
 {* Описывает основные интерфейсы нижнего уровня для библиотеки "Эверест" }

// Модуль: "w:\common\components\gui\Garant\Everest\evInternalInterfaces.pas"
// Стереотип: "Interfaces"

{$Include evDefine.inc}

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

const
 ev_mbLeft = l3_mbLeft;
 ev_mbMiddle = l3_mbMiddle;
 ev_mbRight = l3_mbRight;
 ev_maDown = l3_maDown;
 ev_maUp = l3_maUp;
 ev_maDouble = l3_maDouble;
 ev_maMove = l3_maMove;
 ev_maCtlMove = l3_maCtlMove;

type
 PIevDataObject = ^IevdDataObject;

 IevColumnBorderMarker = interface(IevMarker)
  {* Маркер границы ячейки таблицы }
  ['{1EC1FA6B-67EB-41A5-811B-20683FE4AFB4}']
  function pm_GetColumnID: Integer;
  procedure pm_SetColumnID(aValue: Integer);
  property ColumnID: Integer
   read pm_GetColumnID
   write pm_SetColumnID;
   {* Номер ячейки для которой построен данный маркер (начиная с 1) }
 end;//IevColumnBorderMarker

 {$If Defined(evNeedHotSpot)}
 IevChangeParamTool = interface
  {* Инструмент для изменения параметров тега }
  ['{33D9C262-0D09-41ED-B63B-0DE6FCE9EE13}']
  function ChangeParam(const aMarker: IevMarker;
   aValue: Integer;
   const anOpPack: InevOp;
   SeeByLevel: Boolean = False;
   aMinIndex: Tl3Index = l3MinIndex;
   aMaxIndex: Tl3Index = l3MaxIndex): Boolean;
   {* Изменить значение параметра }
 end;//IevChangeParamTool
 {$IfEnd} // Defined(evNeedHotSpot)

 IevObjectFrame = interface
  ['{841E16E1-E852-4CEF-A22B-240346E83282}']
  function ObjectXOffset: Integer;
 end;//IevObjectFrame

 TShiftState = l3Core.TShiftState;

 TevMouseButton = Tl3MouseButton;
  {* Кнопка мыши }

 TevMouseAction = Tl3MouseAction;
  {* Событие мыши }

 IevSubFlagsSpy = interface
  {* Объект, принимающий уведомления об изменении флагов метки (IevSub) }
  ['{C93F6D8C-E15D-473A-99B2-567EF6FE2709}']
  procedure NotifyFlagsChange(const aSub: IevSub);
   {* флаги метки изменились }
 end;//IevSubFlagsSpy

 IevMarkerSpy = interface
  {* Объект, принимающий уведомления о изменении маркеров }
  ['{EF9AAA90-9524-42AE-B834-6E38523B0D47}']
  procedure NotifyMarkerChange;
   {* маркеры изменились }
 end;//IevMarkerSpy

 IevCursorSource = interface
  {* Объект-источник курсора }
  ['{29ADCD6B-90B4-49FD-B4FC-118C765B427E}']
  procedure MakeCursor;
   {* создать курсор }
  procedure InitAACLikeCursor;
 end;//IevCursorSource

 InevContentsNodeFilter = interface
  ['{9E8D86EF-CA35-4601-9BE6-7E0054456FE5}']
  function pm_GetFilteredNodeFlag: Integer;
  procedure pm_SetFilteredNodeFlag(aValue: Integer);
  procedure ColorNode(const aNode: InevNode);
  procedure CheckTagList;
  procedure AddFilterTag(aTag: Tl3Variant);
  procedure ChangeDocument(aDocument: Tl3Variant);
  function NeedCreate(aTag: Tl3Variant): Boolean;
  property FilteredNodeFlag: Integer
   read pm_GetFilteredNodeFlag
   write pm_SetFilteredNodeFlag;
 end;//InevContentsNodeFilter

 IevF1LikeEditor = interface
  ['{44931BB3-8D47-435C-9F5F-41F9CC25F0E8}']
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
