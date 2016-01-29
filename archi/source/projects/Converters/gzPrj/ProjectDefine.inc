{$I ArchiGlobals.inc}
{$DEFINE RxLibrary}
{$DEFINE _m0LOGSAV1}
{.$DEFINE NOSENDLOG}
{$DEFINE _Debug}
{$Define NoVGScene}
{$Define NoVCM}
{$DEFINE ddUseVTSpin}
{$UnDef l3UseMMX} //Использование регистров MMX для Move
{$Undef l3UseSSE} //Использование регистров SSE для Move
{$Undef l3UseFPU}
{$Define evDualSpell}
{$Define evNotUseTreePara}
{$Define k2NoTagTree}
{$Define ReadPropErrorToLog} //ReadProperty Error to write log and not Show
                             //Используется в Classes.pas, где его нужно определять ТОЖЕ

{$Define DebugRelease}
{$Define FlushTbl}

{$DEFINE NoScripts}
