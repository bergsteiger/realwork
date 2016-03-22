unit NOT_FINISHED_nsNodes;
 {* Узлы деревьев проекта. }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\NOT_FINISHED_nsNodes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsNodes" MUID: (47F60E8E019C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , nsBaseNode
 {$If NOT Defined(Admin)}
 , nsWrapperNode
 {$IfEnd} // NOT Defined(Admin)
;

type
 RnsCacheableNode = class of TnsCacheableNode;

 TnsCacheableNode = class(TnsBaseNode)
  protected
   function Get_IsFirst: Boolean;
   function Get_IsLast: Boolean;
 end;//TnsCacheableNode

 TnsRootNode = TnsWrapperNode;

procedure nsMakeTreeLevel;
procedure nsGetCaption; overload;
procedure nsGetHint;
procedure nsGetCaption; overload;
 {* Получить название адаптерного узла. }

implementation

uses
 l3ImplUses
;

procedure nsMakeTreeLevel;
//#UC START# *4ABB8B1B031D_47F60E8E019C_var*
//#UC END# *4ABB8B1B031D_47F60E8E019C_var*
begin
//#UC START# *4ABB8B1B031D_47F60E8E019C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABB8B1B031D_47F60E8E019C_impl*
end;//nsMakeTreeLevel

procedure nsGetCaption;
//#UC START# *4ADDF529018F_47F60E8E019C_var*
//#UC END# *4ADDF529018F_47F60E8E019C_var*
begin
//#UC START# *4ADDF529018F_47F60E8E019C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ADDF529018F_47F60E8E019C_impl*
end;//nsGetCaption

procedure nsGetHint;
//#UC START# *4ADDF53403CA_47F60E8E019C_var*
//#UC END# *4ADDF53403CA_47F60E8E019C_var*
begin
//#UC START# *4ADDF53403CA_47F60E8E019C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ADDF53403CA_47F60E8E019C_impl*
end;//nsGetHint

procedure nsGetCaption;
 {* Получить название адаптерного узла. }
//#UC START# *47F60EC50128_47F60E8E019C_var*
//#UC END# *47F60EC50128_47F60E8E019C_var*
begin
//#UC START# *47F60EC50128_47F60E8E019C_impl*
 !!! Needs to be implemented !!!
//#UC END# *47F60EC50128_47F60E8E019C_impl*
end;//nsGetCaption

function TnsCacheableNode.Get_IsFirst: Boolean;
//#UC START# *5481A1DD0225_4ADDF46000A4get_var*
//#UC END# *5481A1DD0225_4ADDF46000A4get_var*
begin
//#UC START# *5481A1DD0225_4ADDF46000A4get_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481A1DD0225_4ADDF46000A4get_impl*
end;//TnsCacheableNode.Get_IsFirst

function TnsCacheableNode.Get_IsLast: Boolean;
//#UC START# *5481A1EA00F3_4ADDF46000A4get_var*
//#UC END# *5481A1EA00F3_4ADDF46000A4get_var*
begin
//#UC START# *5481A1EA00F3_4ADDF46000A4get_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481A1EA00F3_4ADDF46000A4get_impl*
end;//TnsCacheableNode.Get_IsLast

end.
