unit ImportExportUnit;

// Библиотека "GblAdapterLib"
// Модуль: ImportExportUnit

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include nsDefine.inc}

interface

uses
  IOUnit,
  BaseTypesUnit
  ;

type
 AuthorizationNeed = class
  {* Для проведения экспорта предвароительно необходимо авторизоваться }
 end;//AuthorizationNeed

 UnknownExportError = class
  {* Произошла неизвестная ошибка во время экспорта настроек }
 end;//UnknownExportError

 DataLoadFailed = class
  {* Возникает при ошибке загрузки данных из XML файла }
 end;//DataLoadFailed

 XercesAdapterNotFound = class
 end;//XercesAdapterNotFound

 IUserProfile5x = interface
  {* Структура провиля пользователя формата 5х }
   ['{D90D29AB-4C5F-4F71-8367-1A6B1D51D7FB}']
   function GetName: IString; stdcall;
   class function Make(aUserHomeData); reintroduce; stdcall;
   property name: IString
     read GetName;
 end;//IUserProfile5x

 UserProfile5xList = array of UserProfile5x;

 IImport5x = interface
  {* Интерфейс для работы с импортом данных из 5х }
   ['{2B69C115-7D7D-47D7-8087-C49498949A9B}']
   function GetUserProfile: IUserProfile5xList; stdcall;
     {* Возхвращает список необработанных пользовательских профилей из 5х }
   procedure ExportData(const aProfile: IUserProfile5x); stdcall; // can raise AuthorizationNeed, UnknownExportError, XercesAdapterNotFound
     {* Экспортирует в Немезис указанный провиль 5х и все связанные с ним данные (настройки, папки/закладки). В случае успеха помечает его как обработанный. Выполнение операции требует предварительной авторизации на сервере. }
   procedure LoadDataFromXML(aFileName: PChar); stdcall; // can raise InvalidXMLType, DataLoadFailed, XercesAdapterNotFound
     {* Загружает в Немезис указанный XML-файл, содержащий настройки,  папки/закладки. Выполнение операции требует предварительной авторизации  на сервере. Если XML-файл не содержит правильных данных, то генерится  - EInvalidXMLType, если загрузка не удалась, то генерится - EDataLoadFailed }
   class function Make; reintroduce; stdcall;
 end;//IImport5x

implementation

end.