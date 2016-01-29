unit kwLeftParam;

interface

uses
 l3IntfUses
 , kwCompiledWordPrim
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , l3ProtoObject
;

type
 TkwObjRefParam = class(TkwCompiledWordPrim)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwObjRefParam
 
 TkwRefParam = class(TkwObjRefParam)
 end;//TkwRefParam
 
 TkwRightParam = class(TkwRefParam)
 end;//TkwRightParam
 
 TkwRightLiteralParam = class(TkwRightParam)
 end;//TkwRightLiteralParam
 
 TkwRightParamEx = class(TkwRightParam)
 end;//TkwRightParamEx
 
 TkwLeftWordRefParam = class(TkwRefParam)
 end;//TkwLeftWordRefParam
 
 TtfwRefParamWordInfo = class(Tl3ProtoObject)
  function WI: TtfwWordInfo;
  function GetWordInfo: TtfwWordInfo;
 end;//TtfwRefParamWordInfo
 
 TkwObjRefParamWordInfo = class(TtfwRefParamWordInfo)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function GetWordInfo: TtfwWordInfo;
 end;//TkwObjRefParamWordInfo
 
 TkwLeftWordRefParamWordInfo = class(TtfwRefParamWordInfo)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function GetWordInfo: TtfwWordInfo;
 end;//TkwLeftWordRefParamWordInfo
 
 TkwRightParamWordInfo = class(TtfwRefParamWordInfo)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function GetWordInfo: TtfwWordInfo;
 end;//TkwRightParamWordInfo
 
 TkwRightLiteralParamWordInfo = class(TtfwRefParamWordInfo)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function GetWordInfo: TtfwWordInfo;
 end;//TkwRightLiteralParamWordInfo
 
 TkwLeftParam = class(TkwCompiledWordPrim)
  function ClassForCreate(aTypeInfo: TtfwWordInfo;
   const aCtx: TtfwContext): RkwCompiledWordPrim;
 end;//TkwLeftParam
 
implementation

uses
 l3ImplUses
 , l3Base
 , TypInfo
 , l3String
 , tfwValueTypes
;

end.
