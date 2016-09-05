{$I ArchiGlobals.inc}
{$Define DebugRelease}
{$Define FlushTbl}  //dtDefine.inc
{.$Define EverestRelease}
{.$Define MonoUser}
{.$Define NOJOKE}
{$Define _m0DEBUG1}
{$Define _m0LOGSAV1}
{$Define _m0MSGBOX1} //показывать сообщение об exception пользователю
{$Define ddWriteGarantAttributes} //ddDefine.inc
{$Define DebugStackTrace}
{$Define l3OldRegExpOff}
{.$Define DisableNSRCOut} //откручивает возможность выливки в NSRC
{.$Define StackInExeption}
{$Define evDualSpell}
{$Define evNotUseTreePara}
{$Define k2NoTagTree}
{.$Define l3TraceAllocStub}
{$Define evNeedWaitHeight} //форматирующая псевдотреада

{$Define ReadPropErrorToLog} //ReadProperty Error to write log and not Show
                             //Используется в Classes.pas, где его нужно определять ТОЖЕ

//{$Define VersionCommands}
{.$Define SilentAttrSet} // отключить запись в лог операций изменения документов
{.$Define m3UseForkStreamToOldBase} // включает сохранение документов паралельно в старое и новое хранилища
{.$Define m3UseOldBase}
{.$Define m3LogLocks} // писать в лог залочки/отлочки в новом хранилище
{$Undef  l3TraceMemAllocStat} //чето Шурино, который обещал потом отключить у себя Срет в лог двумя колонками чисел
{$Undef  l3AssertSimpleMMCanFreeBlocks} //чето Шурино

{$Define evRealPaint} //выделение в редакторе будет синее
{$Define l3RealPaint}

{$UnDef l3UseMMX} //Использование регистров MMX для Move
{$Undef l3UseSSE} //Использование регистров SSE для Move
{$Undef l3UseFPU}
{$Undef evStoreSubsIndex} //Не записывает список использованых меток в док, а набирает его при чтении =======
{$DEFINE l3CheckUnfreedResources}
{$DEFINE l3TraceClasses}
{$DEFINE NewPubDict}
{.$DEFINE RemoteDict} // Удаленное редактирование словарей
{$DEFINE LoginEx} // Все пути получаются с Парня
{$DEFINE ddUseVTSpin}
{.$DEFINE evdCheckFrames}
{.$DEFINE HT_NEWDLL}

{.$Define DelLogTrace}

{$Define NoVGScene}
{$Define NoVCM}
{.$DEFINE ForRegion}

{$DEFINE evCalcSubFlags}
{$DEFINE arAttrInEVD} // можно удалить
{.$DEFINE evOldNSRCTableOff}

{$DEFINE DisableTimeDiff} // жесткая проверка синхронизации времени с сервером

{$Define AppClientSide}
