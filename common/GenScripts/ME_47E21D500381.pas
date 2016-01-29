unit l3VCLStringsItems;

interface

uses
 l3IntfUses
 , l3CastableStrings
;

type
 Tl3VCLStringsItems = class(_l3Unknown_)
  procedure Clear;
  procedure Insert(Index: Integer;
   const S: String);
  function Get(Index: Integer): String;
  procedure Put(Index: Integer;
   const S: String);
  function GetCount: Integer;
 end;//Tl3VCLStringsItems
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
;

end.
