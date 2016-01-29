unit csCommandsConst;

interface
Uses
 csCommandsTypes;

const
 c_CommandBaseIndex = 1000;
 c_CommandNames: Array[TcsCommands] of String =
  ('����������� �������',
   '��������� ������',
   '���������� ������',
   '������������� ������',
   '���������� ���������� ������',
   '������������� ������',
   '���������� ��� �������', //acmdStopAndGoAll,
   '������� �������', // acmdDeleteTask
   '������������', //acmdConfig
   '��������� ���������', //acmdSendMessage
   '��������� ������������', //acmdAutoLogoff
   '���������� ���������', //acmdLogMessages
   '��������� �������', //acmdCheckTables
   '�������� �������', // acmdUpdateTables
   '������� ����', //acmdLockBase
   '������� ����', //acmdUnlockBase
   '������������� �������', //acmdCompileDictionaries
   '�������� ��������� �����', //acmdUpdateText
   '��������� ���������� ����������', //acmdDoEverydayUpdate
   '��������� ����������� ��������� ������', // acmdBuildTextIndex
    '��������� ��������� �����', //CheckFreeSpace,
    '��������� ��������� ���������', //CheckTexts,
    '�������� �������', //ClearLocks,
    '�����������', //EmailNotify,
    '������� ����� ���������', //FamilyBackup,
    '������� ������ �����', //FullBackup,
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
    '�������� ��������� ������', //UpdateIndex,
    'ServerCommand', //UserInfo,
    'ServerCommand' //WeeklyUpdate
  );

implementation

end.
 