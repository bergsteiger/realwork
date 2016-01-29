unit m3EndingReplaceList;

interface

uses
 l3IntfUses
 , m3EndingReplaceListPrim
 , l3Interfaces
 , Classes
 , l3Types
;

type
 TByteArrayOfChar = array [Byte] of AnsiChar;
 
 Tm3EndingReplaceList = class(_l3Searcher_)
  procedure Load(aStream: TStream);
  function MakeNorm(var aCheckStr: Tl3WString): Boolean;
 end;//Tm3EndingReplaceList
 
implementation

uses
 l3ImplUses
 , l3String
 , l3Chars
 , SysUtils
 , l3Parser
;

end.
