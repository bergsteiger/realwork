unit nevNullParaList;

interface

uses
 l3IntfUses
 , nevNullPara
 , nevTools
 , nevBase
 , l3Variant
;

type
 TnevNullParaList = class(TnevNullPara, InevObjectList, InevParaList, InevParaListModify)
  function Make: InevParaList;
  function IndexOfObj(const aPara: InevObject): TnevParaIndex;
  function Count: TnevParaIndex;
   {* число элементов. }
  function LeafShapeCount: Integer;
  function Obj: InevObject;
  function AlmostLinear: Boolean;
   {* список почти линейный? }
  function GetParas(aFrom: TnevParaIndex;
   aTo: TnevParaIndex): InevParas;
   {* возвращает список параграфов. }
  function Modify: InevParaListModify;
  function ParaCount: TnevParaIndex;
   {* число параграфов. }
  function Para: InevPara;
  function InsertPara(aPID: TnevParaIndex;
   aPara: Tl3Variant;
   const anOp: InevOp;
   aFlags: TevInsertParaFlags): Boolean;
   {* вставляет параграф в указанную позицию. }
  function InsertDefaultPara(aPID: TnevParaIndex;
   const anOp: InevOp;
   aNeedFire: Boolean): Boolean;
   {* вставляет параграф с типом по-умолчанию в указанную позицию. }
 end;//TnevNullParaList
 
implementation

uses
 l3ImplUses
 , l3Base
 , nevFacade
;

end.
