unit nevParaList;

interface

uses
 l3IntfUses
 , nevPara
 , nevTools
 , nevBase
 , l3Variant
 , l3Interfaces
;

type
 TnevParaList = class(TnevPara, InevObjectList, InevParaList, InevParaListModify)
  {* ���������� ����������� InevParaList }
  function Make(aTag: Tl3Variant): InevParaList;
  function GetParaCount: TnevParaIndex;
  function GetPara(anIndex: TnevParaIndex): InevPara;
  function GetIndexOfObj(const aPara: InevObject): TnevParaIndex;
  function GetModify: InevParaListModify;
  procedure CheckPrev(const anOp: InevOp;
   aPara: Tl3Variant;
   aPID: Integer);
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
 end;//TnevParaList
 
implementation

uses
 l3ImplUses
 , l3InterfacesMisc
 , k2Tags
 , l3Math
 , nevParas
 , nevFacade
 , l3Base
 , l3MinMax
 , k2Base
 , k2Const
 , SysUtils
 , evCursorTools
 , evMsgCode
 , k2Facade
 , k2OpMisc
 , Para_Const
 , k2Interfaces
;

end.
