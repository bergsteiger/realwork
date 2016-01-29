unit k2DictItem;

interface

uses
 l3IntfUses
 , k2DictRecTag
 , l3BitArr
;

type
 Tk2DictItem = class(_k2HashTag_)
  {* —ловарна€ запись, со ссылкой на родительский тег }
 end;//Tk2DictItem
 
implementation

uses
 l3ImplUses
 , SysUtils
 , k2Tags
 , l3Dict
 , k2Const
 , l3Const
 , l3String
 , k2Except
 , k2Strings
 , k2TagList
 , TypInfo
 , l3Stream
 , l3Base
 , k2Facade
 , Classes
 , k2OList_Const
 , k2Dictionary
 , k2NonOptimizeContext
 , k2VariantImpl
 , k2Bool_Const
 , k2String
 , k2NullTagImpl
 , k2Interfaces
 , k2DictionaryPrim
 , l3Variant
 , k2Base
 , k2InterfaceFactory
;

end.
