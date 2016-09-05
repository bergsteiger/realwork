{.$Define AAC_Support}
{.$Undef l3UseSSE}
{.$Undef l3UseMMX}
{$DEFINE _m0LOGSAV1}
{$DEFINE ItsLAW}
{$DEFINE _EverestRelease}
{$DEFINE evSpellChecker}
{$DEFINE EverestLite}
{$DEFINE DebugStackTrace}
{$DEFINE USE_PROGRESSBAR}
{$DEFINE GXE}
{$DEFINE evNotArchi}
{$DEFINE evDualSpell}
{$DEFINE NotNeedGarDoc}
{$DEFINE NotStackInException}
{$DEFINE evFullNSRC}
{$DEFINE l3OldRegExpOff}
{$DEFINE l3NoTrace}
{$DEFINE _NoObjTopic}
{$DEFINE _evUseEvdStyleOnly}
{$DEFINE NoVGScene}

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



{$IFDEF AAC_Support} // Так сказать бизнес-логика - машина на которой исользовалась функция с ААС была без поддержки SSE-команд (старые процессоры AMD). 
{$Undef l3UseSSE}
{$ENDIF AAC_Support}
