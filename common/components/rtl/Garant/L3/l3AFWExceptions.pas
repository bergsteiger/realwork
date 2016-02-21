unit l3AFWExceptions;

// Модуль: "w:\common\components\rtl\Garant\L3\l3AFWExceptions.pas"
// Стереотип: "Interfaces"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , SysUtils
;

type
 El3TryEnterModalState = class(Exception)
 end;//El3TryEnterModalState

implementation

uses
 l3ImplUses
;

end.
