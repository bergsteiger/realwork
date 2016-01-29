unit ddAppConfigConst;

interface

uses
 l3IntfUses
;

type
 TddValueKind = (
  dd_vkString
  , dd_vkInteger
  , dd_vkBoolean
  , dd_vkDateTime
  , dd_vkObject
 );//TddValueKind
 
 TddConfigValue = record
 end;//TddConfigValue
 
 TddConfigItemType = (
  dd_citUserDefined
  , dd_citGroup
  , dd_citString
  , dd_citBoolean
  , dd_citInteger
  , dd_citRadioGroup
  , dd_citDate
  , dd_citTime
  , dd_citFileName
  , dd_citFolderName
  , dd_citList
  , dd_citColorName
  , dd_citFont
 );//TddConfigItemType
 
 // ddStringArrayOfBool
 
implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
 , Windows
;

end.
