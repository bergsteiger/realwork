unit tfwCStringFactory;

interface

uses
 l3IntfUses
 , tfwCStringList
 , l3Interfaces
 , l3Variant
;

type
 TtfwCStringFactory = class(TtfwCStringList)
  function C(const aString: AnsiString): Il3CString; overload;
  function C(const aString: Tl3WString): Il3CString; overload;
  function C(aString: Tl3PrimString): Il3CString; overload;
  function C(aChar: AnsiChar): Il3CString; overload;
  function C(const aString: Il3CString): Il3CString; overload;
  procedure CacheString(var theIndex: Integer;
   const aString: Il3CString);
  function Cat(const aA: Il3CString;
   const aB: Il3CString): Il3CString; overload;
  function Cat(const aStrings: array of Il3CString): Il3CString; overload;
  function ViewOf(const aString: Tl3WString): Il3CString; overload;
  function CatSep(const aA: Il3CString;
   const aSep: Il3CString;
   const aB: Il3CString): Il3CString;
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TtfwCStringFactory
 
implementation

uses
 l3ImplUses
 , l3String
 , tfwCStringArraySing
 , tfwCStringArraySing2
 , l3Types
;

end.
