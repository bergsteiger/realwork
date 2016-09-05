unit csMdpSyncImport;

// Модуль: "w:\common\components\rtl\Garant\cs\csMdpSyncImport.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsMdpSyncImport" MUID: (574C16DD0300)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csMdpSyncPrim
 , k2Base
;

type
 TcsMdpSyncImport = class(TcsMdpSyncPrim)
  public
   class function GetTaggedDataType: Tk2Type; override;
 end;//TcsMdpSyncImport
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , mdpSyncImport_Const
 //#UC START# *574C16DD0300impl_uses*
 //#UC END# *574C16DD0300impl_uses*
;

class function TcsMdpSyncImport.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typmdpSyncImport;
end;//TcsMdpSyncImport.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
