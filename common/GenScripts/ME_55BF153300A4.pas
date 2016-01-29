unit tfwTypeInfo;

interface

uses
 l3IntfUses
 , l3Interfaces
 , TypInfo
;

type
 TtfwValueType = (
  tfw_vtVoid
  , tfw_vtInt
  , tfw_vtBool
  , tfw_vtStr
  , tfw_vtObj
  , tfw_vtList
  , tfw_vtIntf
   {* »нтерфейс }
  , tfw_vtNil
  , tfw_vtFile
  , tfw_vtChar
  , tfw_vtClass
   {* —сылка на класс }
 );//TtfwValueType
 
 TtfwStackValue = object
 end;//TtfwStackValue
 
 TtfwTypeInfo = object
 end;//TtfwTypeInfo
 
 PtfwStackValue = ^TtfwStackValue;
 
implementation

uses
 l3ImplUses
 , TypeInfoPack
 , VarWorkingPack
 , SysUtils
 , Classes
 , tfwScriptingTypes
 , tfwScriptingInterfaces
 , l3String
;

end.
