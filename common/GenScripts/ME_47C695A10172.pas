unit evTypes;

interface

uses
 l3IntfUses
 , l3Interfaces
;

type
 TevSelectTarget = (
  ev_stChar
  , ev_stWord
  , ev_stLine
  , ev_stPara
  , ev_stDocument
 );//TevSelectTarget
 
 TevSearchOptionEx = (
  {* Опции поиска/замены. }
  ev_soFind
  , ev_soBackward
  , ev_soMatchCase
  , ev_soGlobal
  , ev_soReplace
  , ev_soReplaceAll
  , ev_soWholeWord
  , ev_soSelText
  , ev_soConfirm
  , ev_soDocumentPart
 );//TevSearchOptionEx
 
 TevSearchOptionSetEx = set of TevSearchOptionEx;
  {* Набор опций поиска/замены. }
 
 // TevSearchOption
 
 TevSearchOptionSet = set of TevSearchOption;
  {* Набор урезанных опций поиска/замены. }
 
 TevPageColontituls = (
  pcUpLeftFirst
  , pcUpRightFirst
  , pcDownLeftFirst
  , pcDownRightFirst
  , pcUpLeft
  , pcUpRight
  , pcDownLeft
  , pcDownRight
 );//TevPageColontituls
 
 TevFormat = Tl3ClipboardFormat;
  {* идентификатор формата данных. Может быть:
         cf_EverestBin. cf_EverestTxt, cf_RTF, cf_RTFLite, cf_Text, cf_OEMText etc. }
 
 TevStyleId = ;
 
 TevPixel = ;
 
implementation

uses
 l3ImplUses
;

end.
