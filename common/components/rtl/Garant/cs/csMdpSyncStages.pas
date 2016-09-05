unit csMdpSyncStages;

// Модуль: "w:\common\components\rtl\Garant\cs\csMdpSyncStages.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsMdpSyncStages" MUID: (573D91050026)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csMdpSyncPrim
 , k2Base
;

type
 TcsMdpSyncStages = class(TcsMdpSyncPrim)
  public
   class function GetTaggedDataType: Tk2Type; override;
 end;//TcsMdpSyncStages
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , mdpSyncStages_Const
 //#UC START# *573D91050026impl_uses*
 //#UC END# *573D91050026impl_uses*
;

class function TcsMdpSyncStages.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typmdpSyncStages;
end;//TcsMdpSyncStages.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
