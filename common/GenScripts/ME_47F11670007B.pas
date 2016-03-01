unit k2InternalInterfaces;
 {* Внутренние интерфейсы библиотеки К-2. }

// Модуль: "w:\common\components\rtl\Garant\K2\k2InternalInterfaces.pas"
// Стереотип: "Interfaces"

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , l3Filer
;

type
 Ik2FilerSource = Il3FilerSource;

 Ik2FilerSource2 = interface(Ik2FilerSource)
  ['{6135A72A-EED6-42B4-8746-FD8A73BDA620}']
 end;//Ik2FilerSource2

implementation

uses
 l3ImplUses
;

end.
