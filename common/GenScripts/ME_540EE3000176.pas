unit l3Logger;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3ExceptionsLogEx
;

type
 Tl3Logger = class(Tl3ProtoObject)
  procedure Create(const aFileName: AnsiString);
  procedure ToLog(const aString: AnsiString);
 end;//Tl3Logger
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3ExceptionsLog
;

end.
