unit l3Base;

interface

uses
 l3IntfUses
 , l3_Base
 , l3ObjectRefList1
 , l3_String
 , l3CustomString
 , l3CProtoObject
 , l3Interfaces
 , l3MemUtils
 , l3ObjectsMemoryManager
;

type
 Tl3Base = class(Tl3_Base)
  {* Базовый класс библиотеки L3. Реализует интерфейс IUnknown и подсчет ссылок. }
 end;//Tl3Base
 
 Rl3ObjectRefList = class of Tl3ObjectRefList1;
 
 Tl3String = Tl3_String;
  {* Строка. }
 
 Tl3CustomString = l3CustomString.Tl3CustomString;
 
 Pl3CustomString = ^Tl3CustomString;
 
 Tl3CResString = class(Tl3CProtoObject, Il3CString)
  function AsWStr: Tl3WString;
   {* Возвращает данные строки. }
 end;//Tl3CResString
 
 Tl3CNodeString = class(Tl3CProtoObject, Il3CString)
  function AsWStr: Tl3WString;
   {* Возвращает данные строки. }
 end;//Tl3CNodeString
 
 Tl3CWideString = class(Tl3CProtoObject, Il3CString)
  function AsWStr: Tl3WString;
   {* Возвращает данные строки. }
 end;//Tl3CWideString
 
 Tl3CConstDelphiString = class(Tl3CProtoObject, Il3CString)
  function AsWStr: Tl3WString;
   {* Возвращает данные строки. }
 end;//Tl3CConstDelphiString
 
 Tl3CDelphiString = class(Tl3CProtoObject, Il3CString)
  function AsWStr: Tl3WString;
   {* Возвращает данные строки. }
 end;//Tl3CDelphiString
 
 Tl3SystemPrim = class(Tl3MemUtils)
  {* Базовый класс менеджеров ресурсов. }
 end;//Tl3SystemPrim
 
 Tl3System = class(Tl3SystemPrim)
  {* Класс менеджеров ресурсов. }
  procedure SetClipboardData;
 end;//Tl3System
 
 Rl3String = class of Tl3String;
 
 Tl3ThreadContainer = class(Tl3_Base)
  procedure DoExecute;
   {* основная процедура нити. Для перекрытия в потомках }
 end;//Tl3ThreadContainer
 
 Tl3ObjectHash = object
 end;//Tl3ObjectHash
 
 Tl3ConstString = class(Tl3CustomString)
 end;//Tl3ConstString
 
 Tl3IntfString = class(Tl3CustomString)
 end;//Tl3IntfString
 
 Tl3DataIntfString = class(Tl3IntfString)
 end;//Tl3DataIntfString
 
 Tl3ObjPtrString = class(Tl3_String)
 end;//Tl3ObjPtrString
 
 Tl3ObjPtrIntfString = class(Tl3IntfString)
 end;//Tl3ObjPtrIntfString
 
 Tl3ObjRefString = class(Tl3_String)
 end;//Tl3ObjRefString
 
implementation

uses
 l3ImplUses
 , l3TwoByteCString
 , l3OneByteCString
 , l3CEmptyStringPrim
 , l3CEmptyString
 , l3FourByteCString
;

end.
