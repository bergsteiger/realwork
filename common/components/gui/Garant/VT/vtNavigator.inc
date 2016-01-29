{$Include vtDefine.inc}

{.$Define vtNavDebug}

{$IfDef Nemesis}
 {$Define NavigatorPanelNeedsTb97}
 {$IfOpt D+ and vtNavDebug}
   {$Define vtNavUseDebugLog}
 {$EndIf}
{$EndIf Nemesis}