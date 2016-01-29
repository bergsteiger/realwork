unit csCommandsConst;

interface
Uses
 csCommandsTypes;

const
 c_CommandBaseIndex = 1000;
 c_CommandNames: Array[TcsCommands] of String =
  ('Неизвестная команда',
   'Запустить службу',
   'Остановить службу',
   'Приостановить службу',
   'Продолжить выполнение службы',
   'Перезапустить службу',
   'Обработать все задания', //acmdStopAndGoAll,
   'Удалить задание', // acmdDeleteTask
   'Конфигурация', //acmdConfig
   'Отправить сообщение', //acmdSendMessage
   'Отключить пользователя', //acmdAutoLogoff
   'Записывать сообщения', //acmdLogMessages
   'Проверить таблицы', //acmdCheckTables
   'Обновить таблицы', // acmdUpdateTables
   'Закрыть базу', //acmdLockBase
   'Открыть базу', //acmdUnlockBase
   'Компилировать словари', //acmdCompileDictionaries
   'Обновить текстовую часть', //acmdUpdateText
   'Выполнить Ежедневное обновление', //acmdDoEverydayUpdate
   'Полностью перестроить текстовый индекс', // acmdBuildTextIndex
    'Проверить свободное место', //CheckFreeSpace,
    'Проверить текстовое хранилище', //CheckTexts,
    'Очистить залочки', //ClearLocks,
    'Уведомление', //EmailNotify,
    'Сделать копию семейства', //FamilyBackup,
    'Сделать полную копию', //FullBackup,
    'ServerCommand', //GardocBridge,
    'ServerCommand', //IsDeltaReady,
    'ServerCommand', //LoadDelta,
    'ServerCommand', //LoadEQ,
    'ServerCommand', //LoadKW,
    'ServerCommand', //MakeDelta,
    'ServerCommand', //MakeLoadDelta,
    'ServerCommand', //PauseTask,
    'ServerCommand', //PreventiveUpdate,
    'ServerCommand', //Refresh,
    'ServerCommand', //RestoreFamily,
    'ServerCommand', //RunTask,
    'ServerCommand', //SetHighestPriority,
    'ServerCommand', //SetHighPriority,
    'ServerCommand', //SetLowestPriority,
    'ServerCommand', //SetLowPriority,
    'ServerCommand', //SetNormalPriority,
    'ServerCommand', //Stack2Log,
    'ServerCommand', //StopNGoAnnoExport,
    'ServerCommand', //StopNGoExport,
    'ServerCommand', //StopNGoImport,
    'ServerCommand', //SwitchToRealBase,
    'ServerCommand', //SwitchToTempBase,
    'ServerCommand', //UndoRestore,
    'ServerCommand', //UpdateDictEntryIndex,
    'ServerCommand', //UpdateHeaderIndex,
    'Обновить текстовый индекс', //UpdateIndex,
    'ServerCommand', //UserInfo,
    'ServerCommand' //WeeklyUpdate
  );

implementation

end.
 