unit CsErrors;

{ $Id: CsErrors.pas,v 1.2 2006/02/08 17:24:29 step Exp $ }

// $Log: CsErrors.pas,v $
// Revision 1.2  2006/02/08 17:24:29  step
// выполнение запросов перенесено из классов-потомков в процедуры объектов
//

{$I CsDefine.inc}

interface

uses
 SysUtils;

type
 ECsError = class(Exception)
 public
  class procedure IfNot(aCondition: Boolean); virtual; abstract;
 end;

 ECsWrongVersionError = class(ECsError)
 public
  class procedure IfNot(aCondition: Boolean); override;
 end;

 ECsUnregisteredQueryError = class(ECsError)
 public
  class procedure IfNot(aCondition: Boolean); override;
 end;

implementation

{ ECsWrongVersionError }

class procedure ECsWrongVersionError.IfNot(aCondition: Boolean);
begin
 if not aCondition then
  raise Self.Create('Версия клиента не соответствует версии сервера.');
end;

{ ECsUnregisteredQueryError }

class procedure ECsUnregisteredQueryError.IfNot(aCondition: Boolean);
begin
 if not aCondition then
  raise Self.Create('Тип запроса не зарегистрирован на сервере.');
end;

end.

