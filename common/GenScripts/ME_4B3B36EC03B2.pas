unit l3StringIDEx;

interface

uses
 l3IntfUses
 , l3Interfaces
 , l3Types
 , l3ProtoDataContainer
 , l3ProtoObject
;

type
 Tl3StringIDExPrim = object(Tl3StringID)
 end;//Tl3StringIDExPrim
 
 Tl3StringIDEx = object(Tl3StringIDExPrim)
 end;//Tl3StringIDEx
 
 Pl3StringIDEx = ^Tl3StringIDEx;
 
 {$Undef l3Items_NoSort}
 
 Tl3ConstStringsPrim = class(Tl3ProtoDataContainer)
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//Tl3ConstStringsPrim
 
 (*
 Ml3StringIDExHelper = interface
  {* Контракт сервиса Tl3StringIDExHelper }
  function AsCStr(const aStr: Tl3StringIDEx): Il3CString;
  function AsStr(const aStr: Tl3StringIDEx): AnsiString;
  procedure Init(var theStr: Tl3StringIDEx);
 end;//Ml3StringIDExHelper
 *)
 
 Il3StringIDExHelper = interface
  {* Интерфейс сервиса Tl3StringIDExHelper }
  function AsCStr(const aStr: Tl3StringIDEx): Il3CString;
  function AsStr(const aStr: Tl3StringIDEx): AnsiString;
  procedure Init(var theStr: Tl3StringIDEx);
 end;//Il3StringIDExHelper
 
 Tl3StringIDExHelper = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  procedure Init(var theStr: Tl3StringIDEx);
  function AsCStr(const aStr: Tl3StringIDEx): Il3CString;
  function AsStr(const aStr: Tl3StringIDEx): AnsiString;
 end;//Tl3StringIDExHelper
 
implementation

uses
 l3ImplUses
 , l3String
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 , l3ConstStrings
;

end.
