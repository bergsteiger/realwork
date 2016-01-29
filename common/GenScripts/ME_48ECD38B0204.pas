unit evMultiSelectionRange;

interface

uses
 l3IntfUses
 , evMultiSelectionLocation
 , nevTools
 , nevRangeList
 , evdInterfaces
 , l3Variant
 , nevBase
 , evTypes
 , l3Interfaces
 , l3IID
;

type
 TevMultiSelectionRange = class(TevMultiSelectionLocation, InevRange, InevRangeModify)
  procedure Create(aTagWrap: Tl3Variant;
   aBlocks: TnevRangeList);
  function Make(aTagWrap: Tl3Variant;
   aBlocks: TnevRangeList): InevRange;
  function GetData: IevdDataObject;
  function GetAsStorable: InevDataObjectPrim2;
  function MakePrim(aTagWrap: Tl3Variant;
   aBlocks: TnevRangeList): InevRange;
  function SolidBottomChildBlock(const aView: InevView): InevRange;
  function GetChildSel(const aView: InevView;
   aChildIndex: Integer;
   aForDrawing: Boolean): InevRange;
  procedure GetBorderPoints(out BS: InevBasePoint;
   out BF: InevBasePoint);
  function BottomChildBlock(const aView: InevView): InevRange;
  function CloneSel(const aView: InevView): InevRange;
  function Delete(const aView: InevView;
   const anOp: InevOp;
   aMode: TevClearMode;
   const aPara: InevPara): Boolean;
  function Modify: InevRangeModify;
  function ParentRange(aLevel: Integer): InevRange;
  function Contains(const aView: InevView;
   const aPoint: InevBasePoint): Boolean;
  procedure Select(const aView: InevView;
   const C: InevBasePoint;
   aTarget: TevSelectTarget;
   const Ctx: InevOp); overload;
  procedure Select(const aView: InevView;
   const C: InevBasePoint;
   aOpen: Integer;
   aClose: Integer;
   const Ctx: InevOp); overload;
  function Borders: TevPair;
  function Data: IevdDataObject;
  function Solid(const aView: InevView): Boolean;
  function ContainsEnd(const aView: InevView): Boolean;
  function Collapsed(const aView: InevView): Boolean;
  function AsStorable: InevDataObjectPrim2;
  function GetRange: InevRange;
  function SearchReplace(const aSearcher: IevSearcher;
   const aReplacer: IevReplacer;
   const aConfirm: InevConfirm;
   const aCursor: InevBasePoint;
   const anOpPack: InevOp;
   aNeedProgress: Boolean): Boolean;
   {* процесс поиска/замены. Возвращает - была ли отмена замены. }
  function Search(const aView: InevView;
   const aSearcher: IevSearcher;
   const Progress: Il3Progress;
   const aStart: InevBasePoint;
   out cFStart: InevBasePoint;
   out cFFinish: InevBasePoint): Boolean;
   {* ищет в выделении критерий ОnSearch
             и возвращает начало и конец найденного фрагмента в (cFStart, cFFinish). }
  procedure RefreshBorders;
   {* Обновляет границы блока. http://mdp.garant.ru/pages/viewpage.action?pageId=409750147 }
 end;//TevMultiSelectionRange
 
implementation

uses
 l3ImplUses
 , l3Base
 , k2Tags
 , evLeafParaMultiSelectionBlock
 , evTextParaMultiSelectionBlock
 , nevNavigation
 , evExcept
 , evMultiSelectionBlock
 , nevFacade
 , SysUtils
 , LeafPara_Const
 , TextPara_Const
;

end.
