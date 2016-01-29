{$I evDefine.inc}

{$IFDEF EverestRelease}
 {.$Define evSpellChecker}
{$ELSE  EverestRelease}
 {$Define evMemoryUsageDialog}
 {$Define evUndoBrowser}
{$ENDIF EverestRelease}
