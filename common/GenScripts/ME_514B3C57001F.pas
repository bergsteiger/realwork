unit NOT_FINISHED_vtHeader;

// Модуль: "w:\common\components\gui\Garant\VT\NOT_FINISHED_vtHeader.pas"
// Стереотип: "UtilityPack"

{$Include vtDefine.inc}

interface

uses
 l3IntfUses
;

type
 TvtCustomHeader = class
 end;//TvtCustomHeader

 TvtHeader = class(TvtCustomHeader)
 end;//TvtHeader

 TGetItemImageIndex = function(Sender: TObject;
  Index: LongInt): Integer of object;

implementation

uses
 l3ImplUses
;

end.
