{.$Define AAC_Support}
{.$Undef l3UseSSE}
{.$Undef l3UseMMX}

// для ночных сборок
{$IFDEF NB_AMD}
 {$Undef l3UseSSE}
{$ENDIF}

{$UNDEF NotTunedDUnit}

{$IFDEF nsTest}
 {$IFDEF NoKPageTool}
  {$DEFINE MTDORB}
 {$ENDIF NoKPageTool}
{$ELSE}
 {$DEFINE NoScripts}
{$ENDIF nsTest}

{$DEFINE NoVGScene}

{$IFDEF AAC_Support} // Так сказать бизнес-логика - машина на которой исользовалась функция с ААС была без поддержки SSE-команд (старые процессоры AMD). 
{$Undef l3UseSSE}
{$ENDIF AAC_Support}
