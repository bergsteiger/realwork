unit tfwAutoregisteredDiction;

interface

uses
 l3IntfUses
 , tfwStandardDictionary
 , tfwDictionaryEx
 , l3Interfaces
 , tfwScriptingInterfaces
;

type
 TtfwAutoregisteredDiction = class(TtfwStandardDictionary)
  {* Словарь с базовой аксиоматикой }
  procedure Create;
  function DictionaryByWord(const aWord: Il3CString): TtfwDictionaryEx;
  function CheckDictionaryByWordAndUse(const aWord: Il3CString): Boolean;
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TtfwAutoregisteredDiction
 
implementation

uses
 l3ImplUses
 , tfwStandardDictionaries
 , l3String
 , SysUtils
 , l3Chars
 , tfwCStringFactory
;

end.
