unit ddTaskRecord;

// Модуль: "w:\common\components\rtl\Garant\cs\ddTaskRecord.pas"
// Стереотип: "SimpleClass"

{$Include CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
 , csTaskTypes
 , ddServerTask
;

type
 TddTaskRecord = class(Tl3ProtoObject)
  public
   TaskType: TcsTaskType;
   TaskClass: TddTaskClass;
   Description: AnsiString;
 end;//TddTaskRecord
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Nemesis)

end.
