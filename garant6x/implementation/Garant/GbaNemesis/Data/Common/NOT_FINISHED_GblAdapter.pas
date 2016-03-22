unit NOT_FINISHED_GblAdapter;
 {* Используется потому, что иначе никак не достучаться до EUnknownFactoryKey. }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\NOT_FINISHED_GblAdapter.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "GblAdapter" MUID: (4912B19E0139)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
;

type
 EUnknownFactoryKey = class
  {* На самом деле - оно где-то в Shared }
 end;//EUnknownFactoryKey

 ECorbaException = class
 end;//ECorbaException

implementation

uses
 l3ImplUses
;

end.
