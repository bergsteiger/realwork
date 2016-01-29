unit tfwWordInfoCache;

interface

uses
 l3IntfUses
 , tfwWordInfoList
 , tfwScriptingInterfaces
 , tfwScriptingTypes
;

type
 TtfwWordInfoCache = class(TtfwWordInfoList)
  function GetTypeInfo(const aModifiers: TtfwWordInfoRec): TtfwWordInfo;
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TtfwWordInfoCache
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
