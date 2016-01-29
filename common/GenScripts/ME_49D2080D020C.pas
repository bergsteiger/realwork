unit nevRealTools;

interface

uses
 l3IntfUses
 , nevTools
 , nevBase
 , l3InternalInterfaces
 , l3Variant
;

type
 InevBaseTool = InevBase;
  {* ������� ���������� }
 
 TnevShapeArea = object
  {* ������� ������ }
 end;//TnevShapeArea
 
 TnevShapeInfo = record
  {* ���������� �� ������������ �������. }
 end;//TnevShapeInfo
 
 TnevShapePoints = record
  {* ������ ��� �����������. }
 end;//TnevShapePoints
 
 TnevShapeAreaEx = object(TnevShapeArea)
 end;//TnevShapeAreaEx
 
 PnevShapeArea = ^TnevShapeArea;
  {* ��������� �� ������� ������ }
 
 InevDrawingShape = interface(InevTool)
  {* ��������� ������������ ������ ������� ���� ��������. }
  function Draw(const anArea: TnevShapeArea;
   const aPoints: TnevShapePoints;
   out theInfo: TnevShapeInfo): Boolean;
 end;//InevDrawingShape
 
 TevParaMarkStyle = (
  {* ����� ��������� ����� ��������� }
  ev_pmUsial
  , ev_pmCell
 );//TevParaMarkStyle
 
 InevPaintersHolder = interface
  {* ��������� ��� ��������� ����������� ���������. [$89096971]. [$89096991] }
  procedure RemeberSelPart(const aChildMap: InevMap;
   aSelection: Boolean);
   {* ��������� ������������� ��� ���������. }
  procedure SetHeight(aHeight: Integer);
 end;//InevPaintersHolder
 
 TnevCheckType = (
  {* ��� �������� �������������� }
  nev_None
   {* �� ��������� }
  , nev_CheckOnly
   {* ������ �������� }
  , nev_NeedAdd
   {* ��������� � �������� ����� �������� }
 );//TnevCheckType
 
 IevTablePainter = interface
  {* ��������� ����������� ��������� �������. }
  procedure CheckCell(aPara: Tl3Tag;
   aCheckType: TnevCheckType);
  procedure CalcOffset;
   {* ����������� �������� ��� ��������� ������ }
  function WasPainted(aPara: Tl3Tag;
   anPID: Integer;
   aForLines: Boolean): Boolean;
   {* �������� ���� �� ���������� ��������� ������ �����������. }
  function HasOwnStyle: Boolean;
 end;//IevTablePainter
 
 IevTableRowPainter = interface
  {* ��������� ����������� ��������� ������. }
  function CheckChildren(const aFI: TnevFormatInfoPrim;
   const aCanvas: Il3Canvas): Boolean;
   {* [$219123966] }
  procedure CorrectTopDelta(var aDelta: Integer);
  function IsTopAnchorAtStart: Boolean;
  function GetTopAnchor4Row: InevBasePoint;
   {* ���������� ��������� �� ������ �� View.TopAnchor }
 end;//IevTableRowPainter
 
 IevPainter = interface(InevDrawingShape)
  {* ��������� ������������ ��� ��������� ��������. }
  function IsSelectedOneWholePara(const aPara: InevPara): Boolean;
 end;//IevPainter
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
