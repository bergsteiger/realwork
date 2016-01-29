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
   {* ����� ���������. }
  function LeafShapeCount: Integer;
  function Obj: InevObject;
  function AlmostLinear: Boolean;
   {* ������ ����� ��������? }
  function GetParas(aFrom: TnevParaIndex;
   aTo: TnevParaIndex): InevParas;
   {* ���������� ������ ����������. }
  function Modify: InevParaListModify;
  function ParaCount: TnevParaIndex;
   {* ����� ����������. }
  function Para: InevPara;
  function InsertPara(aPID: TnevParaIndex;
   aPara: Tl3Variant;
   const anOp: InevOp;
   aFlags: TevInsertParaFlags): Boolean;
   {* ��������� �������� � ��������� �������. }
  function InsertDefaultPara(aPID: TnevParaIndex;
   const anOp: InevOp;
   aNeedFire: Boolean): Boolean;
   {* ��������� �������� � ����� ��-��������� � ��������� �������. }
 end;//TnevNullParaList
 
implementation

uses
 l3ImplUses
 , l3Base
 , nevFacade
;

end.
