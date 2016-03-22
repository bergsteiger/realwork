{$I ArchiGlobals.inc}
{$DEFINE ddLog}
{$DEFINE NotShowException}
{$DEFINE DebugStackTrace}
{$DEFINE notStackInExeption}
{$DEFINE ALCU}
{$DEFINE Synapse}
{$DEFINE m3NotUseForkStreamToOldBase}
{$DEFINE l3NotUseW95Meter}
{$DEFINE RxLibrary}
{$DEFINE ddUseVTSpin}
{$DEFINE NOFORMS}
{$DEFINE evFormatOnDraw}
{$DEFINE NoVCM}  // Не используем VCM
{$DEFINE NoVGScene}
{$DEFINE EverestLite}
{$DEFINE evdNeedEverestTxt}
{$Define l3UseMMX} //Использование регистров MMX для Move
{$Undef l3UseSSE} //Использование регистров SSE для Move
{$Undef l3UseFPU}
{.$UNDEf Synapse}
{$DEFINE evAlienSpell}
{$DEFINE NewFixer}
{$Undef  l3TraceMemAllocStat}
{$DEFINE AnnoExport}  // ?
{$UnDef evNeedClipboardSpy}
{$Undef  evNeedNormalWordSearcher}
{$DEFINE evNotNeedDisp}
{$DEFINE RxLibrary}
{$DEFINE AutoClass}  // Автоматическая классификация документов
{.$DEFINE AutoAnno}   // Автоматический экспорт аннотаций
{.$DEFINE RemoteDict}// Дистанционное редактирование словарей
{$DEFINE ArchiCheck} // Поддержка команды ARCHICHECK
{$DEFINE NewCourt}   // Список ФАСов
{.$DEFINE ZipMaster}
{$DEFINE NewLogo}    // Менеджер стартовых экранов
{.$DEFINE LockDebug} // вывод отладочной информации о залочках
{$DEFINE UserQuery}
{$DEFINE Courts} // расстановка меток в ФАС
{$DEFINE Prime} // Экспорт аннотация для Прайм
{$DEFINE ExchangeDocs} // Импорт-экспорт внешних дельт
{$DEFINE ManualExchangeDocs} // ручное создание Дельт
{$DEFINE MakeSections} // Автоматическая расстановка разделов
{$DEFINE EveryWeek} // Еженедельное обновление
{$DEFINE SubDeletedNotify} // Рассылка удаленных меток
{$DEFINE KWSending} // Рассылка файла ключевых слов
{$DEFINE DailyImportKW} // Ежедневный импорт ключевых слов
{$DEFINE CheckPriority} // Обновление таблицы приоритетов
{.$DEFINE UseCommandFile} // Обновление базы с помощью батника
{.$DEFINE aiSMSNotify} // уведомление об Автоэкспорте по СМС
{$DEFINE MDPSyncIntegrated} // интеграция с MDP в качестве Гардока
{.$DEFINE MDPSyncStandAlone} // интеграция с MDP в качестве Гардока (отдельное приложение)
{$DEFINE NewLine} // новый формат информации о задании
{.$DEFINE OvgaExport} // спецзадание для Гаджиловой
{.$DEFINE TrayIcon} // сворачивание в трей
{$DEFINE AutoSP}  // автопополнение справок
{.$DEFINE HT_NEWDLL} // Новый HyTech
// Составное хранилище
{$DEFINE UseArchiCopyFile} // Можно выбрать процедуру копирования файлов
{.$DEFINE Linktask} // Дополнительные параметры для серверных задач
{.$DEFINE AEByBelongs} // Документы для АЭ отбираются по группам документов
{$DEFINE HavanskyExport} // Экcпорт для Пик Пресс (Хаванский)
{.$DEFINE Service}   // Работа Парня в качестве службы
{$DEFINE AnoncedExport} // Автоматический экспорт анонсированных

{.$DEFINE Debug} // Отладочная версия

{.$DEFINE SBRF}  // Версия для Сбербанка
{.$DEFINE Region} // региональная версия
{.$DEFINE AAC} // База для работы с постановлениями ААС
{.$DEFINE LUK} // Версия для Лукойла
{.$DEFINE SGC}
{.$DEFINE LogInit}
{$DEFINE LogRelPublish}

// Для ночных сборок
{$IFDEF NB_NPP}
 {$UNDEF debug}                                            
 {$UNDEF SBRF}
 {$UNDEF LUK}
 {$UNDEF AAC}
 {$UNDEF Region}
 {$UNDEF SGC}
{$ENDIF}

{$IFDEF NB_INDEXER}
 // на индексере должен быть обычный сервер, но с обновлением баз с помощью батника
 {$UNDEF debug}                                            
 {$UNDEF SBRF}
 {$UNDEF LUK}
 {$UNDEF AAC}
 {$UNDEF Region}
 {$UNDEF SGC}
 {$DEFINE UseCommandFile} // <<--- !!!
{$ENDIF}

{$IFDEF NB_LUK}
 {$UNDEF debug}                                            
 {$UNDEF SBRF}
 {$DEFINE LUK}
 {$UNDEF AAC}
 {$UNDEF Region}
 {$UNDEF SGC}
{$ENDIF}

{$IFDEF NB_REGION}
 {$UNDEF SBRF}
 {$UNDEF LUK}
 {$UNDEF AAC}
 {$DEFINE Region}
 {$UNDEF SGC}
{$ENDIF}

{$IFDEF NB_AAC}
 {$UNDEF SBRF}
 {$UNDEF LUK}
 {$DEFINE AAC}
 {$UNDEF Region}
 {$UNDEF SGC}
{$ENDIF}

{$IF Defined(Region)} // Версия для регионов
 {$UNDEF AAC}
 {$UNDEF SBRF}
 {$UNDEF LUK}
 {$UNDEF SGC}
 {$UNDEF Debug}
 {$UNDEF RemoteDict}
 {$UNDEF UserQuery}
 {$UNDEF KWSending}
 {$UNDEF EveryWeek}
 {$UNDEF ManualExchangeDocs}
 {$UNDEF CheckPriority}
 {$DEFINE ManualSet20005Sub}
 {.$UNDEF MDPSyncIntegrated}
 {.$UNDEF MDPSyncStandAlone}
 {$UNDEF OvgaExport}
 {.$UNDEF UseArchiCopyFile}
 {$UNDEF AutoSP}
 {$UNDEF HavanskyExport} // Экпорт для Пик Пресс (Хаванский)
 {$UNDEF AnoncedExport}
{$ELSEIF Defined(SBRF)} // Версия для Сбербанка
 {$UNDEF AAC}
 {$UNDEF LUK}
 {$UNDEF SGC}
 {$UNDEF Debug}
 {$UNDEF AutoClass}
 {$UNDEF RemoteDict}
 {$UNDEF ManualExchangeDocs}
 {$UNDEF MDPSyncIntegrated}
 {$UNDEF MDPSyncStandAlone}
 {$UNDEF OvgaExport}
 {$UNDEF AutoSP}
 {$UNDEF UseArchiCopyFile}
 {$UNDEF TrayIcon}
 {$UNDEF AutoSP}
 {$DEFINE AEByBelongs}
 {$UNDEF HavanskyExport} // Экпорт для Пик Пресс (Хаванский)
 {$UNDEF AnoncedExport}
{$ELSEIF Defined(LUK)} // Версия для ЛУКойла
 {$UNDEF AAC}
 {$UNDEF SBRF}
 {$UNDEF Debug}
 {$UNDEF SGC}
 {$UNDEF Courts}
 {$UNDEF RemoteDict}
 {$UNDEF AutoClass}
 {$UNDEF UserQuery}
 {$UNDEF Prime}
 {$UNDEF ExchangeDocs}
 {$UNDEF ManualExchangeDocs}
 {$UNDEF MakeSections}
 {$UNDEF EveryWeek}
 {$UNDEF KWSending}
 {$UNDEF SubDeletedNotify}
 {$UNDEF DailyImportKW}
 {$UNDEF CheckPriority}
 {$UNDEF ExchangeDocs}
 {$UNDEF MDPSyncIntegrated}
 {$UNDEF MDPSyncStandAlone}
 {$UNDEF OvgaExport}
 {$UNDEF AutoSP}
 {$UNDEF UseArchiCopyFile}
 {$UNDEF TrayIcon}
 {$UNDEF AutoSP}
 {$DEFINE AEByBelongs}
 {$UNDEF AutoAnno}
 {$UNDEF HavanskyExport} // Экпорт для Пик Пресс (Хаванский)
 {$UNDEF AnoncedExport}
{$ELSEIF Defined(SGC)} // Версия для СтройГазКонсалтинга
 {$UNDEF AAC}
 {$UNDEF LUK}
 {$UNDEF SBRF}
 {$UNDEF Debug}
 {$UNDEF Courts}
 {$UNDEF RemoteDict}
 {$UNDEF AutoClass}
 {$UNDEF UserQuery}
 {$UNDEF Prime}
 {$UNDEF ExchangeDocs}
 {$UNDEF ManualExchangeDocs}
 {$UNDEF MakeSections}
 {$UNDEF EveryWeek}
 {$UNDEF KWSending}
 {$UNDEF SubDeletedNotify}
 {$UNDEF DailyImportKW}
 {$UNDEF CheckPriority}
 {$UNDEF ExchangeDocs}
 {$UNDEF MDPSyncIntegrated}
 {$UNDEF MDPSyncStandAlone}
 {$UNDEF OvgaExport}
 {$UNDEF AutoSP}
 {$UNDEF UseArchiCopyFile}
 {$UNDEF TrayIcon}
 {$UNDEF AutoSP}
 {$DEFINE AEByBelongs}
 {$UNDEF AutoAnno}
 {$UNDEF HavanskyExport} // Экпорт для Пик Пресс (Хаванский)
 {$UNDEF AnoncedExport}
{$ELSEIF Defined(AAC)} // версия для Апелляций
 {$UNDEF Region}
 {.$UNDEF Courts}
 {$UNDEF SBRF}
 {$UNDEF LUK}
 {$UNDEF SGC}
 {.$UNDEF Debug}
 {$UNDEF RemoteDict}
 {$UNDEF Prime}
 {.$UNDEF EveryWeek}
 {$UNDEF KWSending}
 {$UNDEF SubDeletedNotify}
 {$UNDEF DailyImportKW}
 {$UNDEF CheckPriority}
 {$UNDEF ManualExchangeDocs}
 {$UNDEF MDPSyncIntegrated}
 {$UNDEF MDPSyncStandAlone}
 {$UNDEF OvgaExport}
 {$UNDEF TrayIcon}
 {$UNDEF AutoSP}
 {$DEFINE ManualSet20005Sub}
 {$UNDEF HavanskyExport} // Экпорт для Пик Пресс (Хаванский)
 {$DEFINE UseCommandFile}
 {$UNDEF AnoncedExport}
 {.$DEFINE HT_NEWDLL}
{$IFEND}

{$IF defined(MDPSyncIntegrated) or defined(MDPSyncStandAlone)}
 {$DEFINE MDPSync} // интеграция с MDP в качестве Гардока
{$IFEND defined(MDPSyncIntegrated) or defined(MDPSyncStandAlone)}

{$IF defined(MDPSyncIntegrated) and defined(MDPSyncStandAlone)}
~~~ Incompatible directive combination
{$IFEND defined(MDPSyncIntegrated) and defined(MDPSyncStandAlone)}
