unit m3FileStream;

interface

uses
 l3IntfUses
 , m3BaseStream
 , Windows
 , ActiveX
 , m3FileStreamMapView
 , Classes
;

type
 Tm3FileStream = class(Tm3BaseStream)
  procedure SysCheck(AResult: LongBool);
  procedure Create(const AName: WideString;
   AAccess: LongWord;
   ASharedMode: LongWord;
   ADistribution: LongWord;
   AFlags: LongWord);
  function Make(const AName: WideString;
   AAccess: LongWord;
   ASharedMode: LongWord;
   ADistribution: LongWord;
   AFlags: LongWord): IStream;
  function CreateMapView(AProtect: LongWord;
   AAccess: LongWord): Tm3FileStreamMapView;
 end;//Tm3FileStream
 
implementation

uses
 l3ImplUses
 , ComObj
 , SysUtils
 , l3Base
 , m2AddPrc
 , StrUtils
;

end.
