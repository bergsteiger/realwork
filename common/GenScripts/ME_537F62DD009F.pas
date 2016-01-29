unit CsDataPipe;

interface

uses
 l3IntfUses
 , CsDataPipePrim
;

type
 TCsDataPipe = class(TCsDataPipePrim)
  function ReadFolder(const aToPath: AnsiString): Boolean;
  procedure WriteFolder(const aFolderName: AnsiString);
 end;//TCsDataPipe
 
implementation

uses
 l3ImplUses
 , l3Stream
 , l3Memory
 , l3FileUtils
 , l3BaseStream
 , SysUtils
 , l3Base
 , l3TempMemoryStream
 , l3Types
 , IdIOHandler
 , Classes
;

end.
