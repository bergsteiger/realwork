unit tfwScriptingTypes;

interface

uses
 l3IntfUses
 , TypInfo
 , tfwValueTypes
 , tfwTypeInfo
 , l3Interfaces
;

type
 TtfwValueTypes = tfwValueTypes.TtfwValueTypes;
 
 TtfwWordModifier = (
  tfw_wmVirtual
  , tfw_wmAbstract
  , tfw_wmFinal
  , tfw_wmSummoned
  , tfw_wmOverride
  , tfw_wmRealize
  , tfw_wmRedefinition
  , tfw_wmRedefineable
  , tfw_wmSealed
  , tfw_wmCanBeMerged
   {* Одноимённые слова с одинаковыми стереотипами МОГУТ склеиваться в одно, как например %CHILDREN. }
  , tfw_wmRightWordRef
  , tfw_wmLeftWordRef
  , tfw_wmImmediate
  , tfw_wmInline
  , tfw_wmTreatUnknownAsString
  , tfw_wmCaller
 );//TtfwWordModifier
 
 TtfwWordModifiers = set of TtfwWordModifier;
 
 TtfwAccessType = (
  tfw_atNone
  , tfw_atPrivate
  , tfw_atProtected
  , tfw_atPublic
 );//TtfwAccessType
 
 TtfwLinkType = (
  tfw_ltNone
  , tfw_ltAggregation
  , tfw_ltLink
  , tfw_ltReference
 );//TtfwLinkType
 
 TtfwWordInfoRec = object
  {* Информация о типе }
 end;//TtfwWordInfoRec
 
 PtfwWordInfoRec = ^TtfwWordInfoRec;
 
implementation

uses
 l3ImplUses
 , tfwScriptingInterfaces
 , l3Base
 , l3String
;

end.
