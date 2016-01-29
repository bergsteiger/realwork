unit TestFilerCopyViaReadLn;

interface

uses
 l3IntfUses
 , BaseTest
;

type
 TTestFilerCopyViaReadLn = class(TBaseTest)
  procedure DoIt;
   {* Тест правильности копирования файлов с помощью ReadLn }
  procedure CopyUnicode;
   {* Тест для [RequestLink:175540286]. }
 end;//TTestFilerCopyViaReadLn
 
implementation

uses
 l3ImplUses
 , TestGlobals
 , TestFrameWork
 , l3Filer
 , l3Stream
 , l3Types
 , SysUtils
;

end.
