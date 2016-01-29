unit l3ConvertersList;

interface

uses
 l3IntfUses
 , l3StringList
;

type
 Tl3ConvertersList = class(Tl3StringList)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//Tl3ConvertersList
 
implementation

uses
 l3ImplUses
;

end.
