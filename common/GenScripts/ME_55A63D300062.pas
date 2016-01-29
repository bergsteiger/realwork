unit tfwMainDictionaryCache;

interface

uses
 l3IntfUses
 , tfwMainDictionaryList
 , l3Interfaces
 , l3Types
;

type
 TtfwMainDictionaryCache = class(TtfwMainDictionaryList)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TtfwMainDictionaryCache
 
implementation

uses
 l3ImplUses
 , l3String
;

end.
