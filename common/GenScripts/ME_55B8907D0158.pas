{$IfNDef nsLogEvent_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Logging\nsLogEvent.imp.pas"
// ���������: "Impurity"

{$Define nsLogEvent_imp}

 _nsLogEvent_ = {abstract} class(_nsLogEvent_Parent_)
 end;//_nsLogEvent_

{$Else nsLogEvent_imp}

{$IfNDef nsLogEvent_imp_impl}

{$Define nsLogEvent_imp_impl}

{$EndIf nsLogEvent_imp_impl}

{$EndIf nsLogEvent_imp}

