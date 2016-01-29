unit nevShapesPaintedSpy;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Filer
 , nevTools
 , nevShapesPainted
;

type
 InevShapesLogger = interface
  {* ��� ������������ �������� }
  function OpenLog(const aView: InevView): AnsiString;
  procedure CloseLog(const aLogName: AnsiString);
  function LogScreen(const aView: InevView): Boolean;
 end;//InevShapesLogger
 
 TnevShapesPaintedSpy = class(Tl3ProtoObject)
  {* �������� �� ������������� ���������. [RequestLink:235864309] }
  procedure LogShapes(const aView: InevView;
   aShapes: TnevBaseTopShape);
   {* �������� ������������ ������� }
  procedure SetLogger(const aLogger: InevShapesLogger);
  procedure RemoveLogger(const aLogger: InevShapesLogger);
  function Exists: Boolean;
  function LogScreen(const aView: InevView): Boolean;
 end;//TnevShapesPaintedSpy
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Types
 , k2Tags
 , l3String
 , evParaTools
 , nevBase
 , l3MinMax
;

end.
