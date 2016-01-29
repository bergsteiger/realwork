unit GZipUnzipTest;

interface

uses
 l3IntfUses
 , BaseTest
;

type
 TGZipUnzipTest = class(TBaseTest)
  procedure DoIt;
 end;//TGZipUnzipTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , SysUtils
 , l3Stream
 , l3GZipStream
 , l3Types
;

end.
