sDCErrorParamNumber = 'Неправильное число параметров.';

sDCImportMainFormCaption    = 'Генератор импортных файлов';
sDCSourceFilesPanelCaption  = 'Исходные файлы';
sDCPostfixLabelCaption      = 'Суффикс:';

sDCImportOptionsPanelCaption      = 'Опции импорта';
sDCDestPathLabelCaption           = 'Путь вывода:';
sDCLibPathLabelCaption            = 'Пути к библиотекам:';
sDCConditionalDefinesLabelCaption = 'Условные определения:';
sDCAliasesLabelCaption            = 'Синонимы:';
sDCDelphiLibsBtnHint              = 'Заполнить путями к Delphi библиотекам';

sDCIncludeCommentsCheckCaption   = 'Включать комментарии в файлы';
sDCCustomImportCheckCaption      = 'Регистрировать указанные элементы';
sDCImportSilentlyCheckCaption    = 'Использовать список по умолчанию';
sDCAddUnregistrationCheckCaption = 'Добавлять разрегистрацию элементов';

sDCImportBtnCaption = 'Запустить';
sDCImportHelpButton = 'Подсказка';

sDCAddFilesDlgTitle = 'Выберите файлы которые вы хотите проимпортировать';

sDCImportHelpFormCaption = 'Подсказка по генератору импортных файлов';
sDCImportHelpContextLine = 19;
sDCImportHelpContext : Array[ 0 .. sDCImportHelpContextLine - 1 ] Of String =
          ( 'Генератор импортных файлов',
            'Copyright (c) 1998-2000 Dream Company',
            '',
            'Запустите impgen.exe -h чтобы показать подсказку по параметрам коммандной строки',
            '',
            'Синтакс: ImpGen [опции] ИсходныеФайлы КаталогРезультатов',
            '',
            'Опции:',
            '     -A		Определить aliases',
            '     -D<syms>	Определить условные операторы',
            '     -S		Рекурсивный поиск файлов по подкаталогам',
            '     -U<paths>	Каталог с исходными файлами',
            '     -L		Добавить путь к VCL библиотекам',
            '     -X		Не выводить комментарии',
            '     -P<postfix>	Суффикс который будет добавлен к результирующим файлам',
            '     -E<filename>	Исключаемые из импорта файлы',
            '',
            'Пример:',
            'ImpGen -UC:\D3\SOURCE\VCL;C:\D3\SOURCE\RTL\SYS -P_IMP D:\MYPROG\*.pas D:\IMP' );

sDCFileImportCaption       = 'Генератор импортных файлов ';
sDCBuildingInProgress      = 'Генерирование импортных файлов';
sDCBuildingFinished        = 'Генерирование закончено';
sDCBuildingFinishedByError = 'Генерация файлов была прекращена в результате ошибки.';
sDCBuildingFinishedByUser  = 'Генерация файлов была прекращена пользователем.';

sDCCollectingTopicsInfo = 'Сбор информации об учавствующих элементах ...';

sDCFileProcessed  = '%d файлов было обработано.';
sDCFilesGenerated = '%d файлов было сгенерировано.';

sDCImportingUnits    = 'Импортирование модулей ...';
sDCCheckinTopics     = 'Проверка импортируемых элементов ...';
sDCCollectingTopics  = 'Сбор информации об элементах ...';
sDCCollectionFrom    = 'Сбор информации об элементах из модуля "%s".';
sDCUserCancelProcess = 'Пользователь прекратил процесс.';
sDCCreateFolders     = 'Создание каталога "%s".';
sDCFilesNumber       = '%d файлов';

sDCExcludeConfirm           = 'Вы действительно хотите исключить файл ''%s'' из импортирования?';
sDCImportTerminationConfirm = 'Вы действительно хотите очистить список импортирумых файлов?';
sDCFolderCreateConfirmation = 'Каталог "%s" не существует. Вы хотите создать его?';

sDCErrorFolderCannotBeCreated = 'Каталог "%s" не может быть создан.';

sDCImportingPosfix       = '[Импортирование]';
sDCImportCompletePostfix = '[Импорт закончен]';

sDCTopicsCheckFormCaption = 'Отбор регистрируемых элементов';
sDCSelectAllItemCaption   = '&Отметить все элементы';
sDCUnselectAllItemCaption = '&Снять пометку со всех элементов';
sDCProcCheckHeader        = 'Список доступных процедур:';
sDCTypeCheckHeader        = 'Список доступных типов:';
sDCClassCheckHeader       = 'Список доступных классов:';
sDCVarCheckHeader         = 'Список доступных переменных:';
sDCConstsCheckHeader      = 'Список доступных констант:';
sDCPropertiesCheckHeader  = 'Список доступных свойств:';
sDCMethodsCheckHeader     = 'Список доступных методов:';

sDCProjectItemsCaption   = 'Проект';

sDCAddUnitsActionCaption = '&Добавить файлы...';
sDCAddUnitsActionHint    = 'Добавить файлы...';
sDCAddUnitsRecursActionCaption = 'Добавить рекурсивно все модули из &каталога';
sDCAddUnitsRecursActionHint    = 'Добавить рекурсивно все модули из каталога';
sDCDeleteActionCaption   = '&Удалить отмеченные файлы';
sDCDeleteActionHint      = 'Удалить отмеченные файлы';
sDCClearAllActionCaption = 'Удалить все файлы';
sDCClearAllActionHint    = 'Удалить все файлы';

sDCNewImportProjectName = 'Новый Импортный Проект';

sDCSaveDialogTitle = 'Сохранить ''%s'' как ...';
sDCFilterImportProject = 'Импортный проект';
sDCImportOpenPrjDialogTitle = 'Открыть импортный проект';
sDCPathDialogTitle = 'Выберите каталог с файлами которые вы хотите импортированть:';

sDCCreateFileError = 'Не могу открыть указанный файл';
sDCSaveFileError = 'Ошибка произошла при сохранении данных проекта.';
sDCOpenFileError = 'Не могу открыть указанный файл.';
sDCLoadFileError = 'Ошибка произошла во время считывания данных проекта.';

sDCSaveProjectFile = 'Сохранение файла проекта';
sDCLoadProjectFile = 'Загрузка файла проекта';

sDCSaveWarning = 'Текущий проект не был сохранён, хотите сохранить изменения?';

sDCFormListOfBadClasses    = 'Формирование списка классов, методов и свойств исключённых из импортирования';
sDCFormListOfBadProcedures = 'Формирование списка процедур исключённых из импортирования';
sDCFormListOfBadTypes      = 'Формирование списка типов исключённых из импортирования';
sDCFormListOfBadVariables  = 'Формирование списка переменных исключённых из импортирования';
sDCFormListOfBadConstants  = 'Формирование списка констант исключённых из импортирования';

sDCBadTopicsAreCollected = 'Информация об исключаемых элементов собрана.';

sDCImportTerminateQuery = 'Вы действительно хотите прервать процесс импортирования?';

