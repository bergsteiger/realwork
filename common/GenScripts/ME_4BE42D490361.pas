unit l3CheckStamp.imp;

interface

uses
 l3IntfUses
 , l3PureMixIns
;

type
 _l3CheckStamp_ = class
  function CheckStamp(const aGUID: TGUID): Boolean;
   {* Проверяет метку реализации интерфейса. Например для того, чтобы узнать, что реализация наша "родная". }
 end;//_l3CheckStamp_
 
implementation

uses
 l3ImplUses
;

end.
