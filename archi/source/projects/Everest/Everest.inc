{$I evDefine.inc}

{$IFDEF EverestRelease}
 {.$Define evSpellChecker}
{$ELSE  EverestRelease}
 {$IfNDef evMyEditor}
  {$IfNDef EverestLite}
   {$Define evMemoryUsageDialog}
   {$Define evUndoBrowser}
  {$EndIf EverestLite}
 {$EndIf evMyEditor}
{$ENDIF EverestRelease}
