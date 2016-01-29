unit tcOperation;

interface

uses
 l3Interfaces,

 tcInterfaces,
 tcItem
 ;

type
 TtcOperation = class(TtcItem,
                      ItcOperation)
 public
  class function Make(const anID: Il3CString): ItcOperation;
 end;

implementation

uses
 SysUtils
 ;

{ TtcOperation }

class function TtcOperation.Make(const anID: Il3CString): ItcOperation;
var
 l_Instance: TtcOperation;
begin
 l_Instance := Create(anID);
 try
  Result := l_Instance;
 finally
  FreeAndNil(l_Instance);
 end;
end;

end.
