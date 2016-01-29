unit GZipTest;

interface

uses
 l3IntfUses
 , BaseTest
;

type
 TGZipTest = class(TBaseTest)
  procedure DoIt;
 end;//TGZipTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , l3Stream
 , l3GZipStream
 , SysUtils
 , l3Types
;

end.
