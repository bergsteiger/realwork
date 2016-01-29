unit ddAppConfigUtils;

interface

uses
 l3IntfUses
 , ddAppConfigTypes
 , ddConfigStorages
 , l3ProtoObject
;

type
 TddItemLink = class(Tl3ProtoObject)
  procedure Create(aItem: TddVisualConfigItem;
   aNext: TddItemLink);
 end;//TddItemLink
 
implementation

uses
 l3ImplUses
 , SysUtils
 , Windows
 , Math
 , StrUtils
 , Controls
 , Dialogs
 , Forms
 , ddAppConfigSimpleBFrame
 , ddAppConfigStrings
 , ddAppConfigConst
 , ddAppConfigDates
 , ddAppConfigLists
 , afwVCL
 , ddIniStorage
 , l3Base
;

end.
