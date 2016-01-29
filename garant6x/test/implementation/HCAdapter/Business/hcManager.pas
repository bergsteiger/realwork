unit hcManager;

{------------------------------------------------------------------------------}
{ Библиотека : Тестовый слой;                                                  }
{ Автор      : Морозов М.А.                                                    }
{ Начат      : 26.03.2006 16.48;                                               }
{ Модуль     : hcManager                                                       }
{ Описание   : Для тестирования запросов на консультацию:                      }
{                  - получение запроса на консультацию;                        }
{                  - получение оценки консультации;                            }
{                  - выдача ответа на консультацию;                            }  
{------------------------------------------------------------------------------}

// $Id: hcManager.pas,v 1.17 2008/09/25 10:21:06 oman Exp $
// $Log: hcManager.pas,v $
// Revision 1.17  2008/09/25 10:21:06  oman
// - new: Обрабатываем новый код ошибки (К-119473134)
//
// Revision 1.16  2008/06/26 07:54:37  mmorozov
// - new: подпись консультации (CQ: OIT5-23252);
//
// Revision 1.15  2008/03/25 05:15:53  mmorozov
// - new: модуль взаимодействия с библиотекой в динамическом варианте;
//
// Revision 1.14  2008/02/26 13:15:49  mmorozov
// - new: реализация удаления запросов (CQ: OIT5-28426);
//
// Revision 1.13  2008/01/16 12:35:18  mmorozov
// - работа с новым адаптером;
//
// Revision 1.12  2008/01/10 07:31:51  oman
// Переход на новый адаптер
//
// Revision 1.11.4.1  2007/12/07 09:01:05  oman
// Перепиливаем на новый адаптер
//
// Revision 1.11  2007/01/22 14:17:19  mmorozov
// - MERGE WITH B_NEMESIS_6_4 (CQ: OIT5-24141);
//
// Revision 1.10.4.1  2007/01/22 13:49:56  mmorozov
// - new: показ статусов выбранных консультаций (CQ: OIT5-24141);
//
// Revision 1.10  2006/10/06 11:40:35  mmorozov
// - new: используем l3;
// - new behaviour: ожидаем от dll-ли при запуске не только типизированных, но и не типизированных исключений, завершаем работу с сообщением если такое случилось;
//
// Revision 1.9  2006/08/10 06:40:31  dolgop
// - bugfix: формирование запроса вручную;
//
// Revision 1.8  2006/08/07 08:50:47  mmorozov
// - new: формирование запроса вручную (CQ: OIT500022171);
//
// Revision 1.7  2006/08/03 04:35:34  mmorozov
// - new behaviour: IConsultingRequests получаем один раз, по первому требоавнию;
//
// Revision 1.6  2006/06/02 14:40:44  mmorozov
// - new: загрузка DLL-ли по новому;
// - new: обработка результов работы методов dll-ли;
//
// Revision 1.5  2006/06/02 10:44:50  migel
// - change: перегенерация с новым шаблоном.
// - fix: совместимость с новыми перегенеренными файлами.
//
// Revision 1.4  2006/04/04 07:59:12  mmorozov
// - new: использование фабрики потока + в случае успешного получения данных завершаем вызовом DataReceived;
//
// Revision 1.3  2006/04/03 14:05:30  mmorozov
// - new: вычитывание оценки;
//
// Revision 1.2  2006/04/03 10:49:25  mmorozov
// - new: выделена функция tstFileToStream;
//

interface

uses
  Classes,
  ActiveX,

  l3Base,

  HCInterfacesUnit,
  HCAdapter,

  hcInterfaces
  ;

type
  ThcManager = class(Tl3Base, IhcManager)
  private
  // internal methods
    f_Adapter  : IHCAdapterDll;
    f_Requests : IConsultingRequests;
  private
  // methods
    procedure SaveToFile(const aFileName : String;
                         const aData     : String);
      {* - сохранить в файл. }
  private
  // property methods
    function pm_GetRequests: IConsultingRequests;
      {-}
  private
  // IhcManager
    function NextQuery: String;
      {* - получить очередной запрос. }
    procedure SetAnswer(const aFileName: String);
      {-}
    function NextMark: String;
      {* - получить оценку. }
    function MakeQueryManual(const aCardId    : String;
                             const aProductId : String;
                             const aQuery     : String): String;
      {* - сформировать XML для запроса полученного не через сервер
           консультации. }
    function PrintQueryStatus(const aFileName: String): String;
      {* - получить статусы консультаций в формате XML. }
    function DeleteQuery(const aFileName: String): String;
      {* - получить статусы консультаций в формате XML. }
    procedure SignImportConsultation(const aSourceFile : String;
                                     const aDestFile   : String);
      {* - подписать импортируемую консультацию. }
  protected
  // methods
    procedure Cleanup;
      override;
      {-}
  protected
  // property
    property Requests: IConsultingRequests
      read pm_GetRequests;
      {-}
  public
  // public methods
    constructor Create;
      reintroduce;
      {-}
    class function Make: IhcManager;
      {-}
  end;//ThcManager

implementation

uses
  SysUtils,

  tstUtils,

  hcConst
  ;

procedure hcCheckResult(const aValue: TResultValue);
begin
 case aValue of
  RV_BAD_XML:
   raise EhcBadXml.Create(c_hcBadXML);
  RV_DUPLICATED:
   raise EhcDuplicateAnswer.Create(c_hcDuplicateAnswer);
  RV_ERROR:
   raise EhcError.Create(c_hcError);
 end;//case aValue of
end;//hcCheckResult

function mgReadStream(const aRequests : IConsultingRequests;
                      const aType     : ThcStreamType): String;
var
 l_Data     : IConsultingData;
 l_Stream   : IStream;
 l_Success  : Boolean;
 l_Result   : TResultValue;
begin
 Result := '';
 if Assigned(aRequests) then
 begin
  l_Data := nil;
  l_Result := RV_EMPTY;
  case aType of
   stNextMark:
    l_Result := aRequests.GetNextMark(l_Data);
   stNextQuery:
    l_Result := aRequests.GetNextQuery(l_Data);
  end;//case aType of
  hcCheckResult(l_Result);
  if l_Result in [RV_SUCCESS, RV_COMPLECT_REMOVED_ERROR] then
  try
   l_Data.GetData(l_Stream);
   if Assigned(l_Stream) then
   try
    Result := tstReadStream(l_Stream, @l_Success);
    if l_Success then
     l_Data.DataReceived;
   finally
    l_Stream := nil;
   end;{try..finally}
  finally
   l_Data := nil;
  end;{try..finally}
 end;{try..finally}
end;//hcStream

type
  ThcAdapter = class(THCAdapterDll)
  protected
  // methods
    procedure AfterConstruction;
      override;
      {-}
    destructor Destroy;
      override;
      {-}
  public
  // methods
    class function Make: IHCAdapterDll;
      reintroduce;
      {-} 
  end;//ThcAdapter

{ ThcManager }

procedure ThcManager.Cleanup;
begin
 f_Requests := nil;
 f_Adapter := nil;
 inherited;
end;

constructor ThcManager.Create;
begin
 inherited Create;
 f_Adapter := ThcAdapter.Make;
end;

class function ThcManager.Make: IhcManager;
var
 l_Class: ThcManager;
begin
 l_Class := Create;
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;
end;//Make

procedure ThcManager.SignImportConsultation(const aSourceFile : String;
                                            const aDestFile   : String);
  {* - подписать импортируемую консультацию. }
var
 l_Source  : IStream;
 l_Dest    : IStream;
 l_Signed  : String;
begin
 l_Source := f_Adapter.MakeStream;
 try
  if FileExists(aSourceFile) and tstFileToStream(aSourceFile, l_Source) then
  begin
   hcCheckResult(Requests.SignQuery(l_Source, l_Dest));
   try
    l_Signed := tstReadStream(l_Dest);
    SaveToFile(aDestFile, l_Signed);
   finally
    l_Dest := nil;
   end;
  end;
 finally
  l_Source := nil;
 end;
end;//SignImportConsultation

function ThcManager.DeleteQuery(const aFileName: String): String;
  {* - получить статусы консультаций в формате XML. }
var
 l_Stream : IStream;
 l_Status : IStream;
begin
 Result := '';
 l_Stream := f_Adapter.MakeStream;
 try
  if tstFileToStream(aFileName, l_Stream) then
  begin
   hcCheckResult(Requests.EraseQueriesById(l_Stream, l_Status));
   try
    Result := tstReadStream(l_Status);
   finally
    l_Status := nil;
   end;{try..finally}
  end;//if tstFileToStream(aFileName, l_Stream) then
 finally
  l_Stream := nil;
 end;{try..finally}
end;

function ThcManager.PrintQueryStatus(const aFileName: String): String;
  {* - получить статусы консультаций в формате XML. }
var
 l_Stream : IStream;
 l_Status : IStream;
begin
 Result := '';
 l_Stream := f_Adapter.MakeStream;
 try
  if tstFileToStream(aFileName, l_Stream) then
  begin
   hcCheckResult(Requests.GetStatusStatistic(l_Stream, l_Status));
   try
    Result := tstReadStream(l_Status);
   finally
    l_Status := nil;
   end;{try..finally}
  end;//if tstFileToStream(aFileName, l_Stream) then
 finally
  l_Stream := nil;
 end;{try..finally}
end;//PrintQueryStatus

function ThcManager.MakeQueryManual(const aCardId    : String;
                                    const aProductId : String;
                                    const aQuery     : String): String;
  {* - сформировать XML для запроса полученного не через сервер
       консультации. }
var
 l_Data : IConsultingData;
 l_XML  : IStream;
begin
 Result := '';
 case Requests.GetOfflineQuery(PAnsiChar(aCardId), PAnsiChar(aProductId),
   PAnsiChar(aQuery), l_Data) of
  RV_EMPTY:
   raise EhcInvalidNumber.Create('Неправильный номер карточки или продукта');
  RV_ERROR:
   raise EhcAccessDenied.Create('Ошибка при доступе к АРМ-у или СК');
 end;//case f_Requests.GetOfflineQuery(
 l_Data.GetData(l_XML);
 Result := tstReadStream(l_XML);
end;//MakeQueryManual

function ThcManager.NextMark: String;
  {* - получить оценку. }
begin
 Result := mgReadStream(Requests, stNextMark);
end;//NextMark

function ThcManager.NextQuery: String;
begin
 Result := mgReadStream(Requests, stNextQuery);
end;//NextQuery

procedure ThcManager.SaveToFile(const aFileName : String;
                                const aData     : String);
  {* - сохранить в файл. }
var
 l_F      : TextFile;
 l_Buffer : PAnsiChar;
begin
 AssignFile(l_F, aFileName);
 try
  Rewrite(l_F);
  GetMem(l_Buffer, Length(aData));
  try
   StrPCopy(l_Buffer, aData);
   Write(l_F, l_Buffer);
  finally
   FreeMem(l_Buffer);
  end;
 finally
  CloseFile(l_F);
 end;
end;

function ThcManager.pm_GetRequests: IConsultingRequests;
begin
 if not Assigned(f_Requests) then
  f_Requests := f_Adapter.MakeConsultingRequests;
 Result := f_Requests;
end;

procedure ThcManager.SetAnswer(const aFileName: String);
var
 l_Stream   : IStream;
begin
 if FileExists(aFileName) and Assigned(Requests) then
 begin
  l_Stream := f_Adapter.MakeStream;
  try
   if tstFileToStream(aFileName, l_Stream) then
   try
    hcCheckResult(Requests.SetAnswer(l_Stream));
   finally
    l_Stream := nil;
   end;{try..finally}
  finally
   l_Stream := nil;
  end;{try..finally}
 end;//if FileExists(aFileName) then
end;//SetAnswer

{ ThcAdapter }

procedure ThcAdapter.AfterConstruction;
begin
 inherited;
 MakeBusinessLogicLifeCycle.Start;
end;

destructor ThcAdapter.Destroy;
var
 l_Business: IBusinessLogicLifeCycle;
begin
 // Здесь действительно нужна локальная переменная, т.к. интерфейс бизнес
 // объекта должен быть освобожден раньше самой бибилиотеке (dll):
 l_Business := MakeBusinessLogicLifeCycle;
 try
  l_Business.Stop;
 finally
  l_Business := nil;
 end;//try..finally
 inherited;
end;//Cleanup

class function ThcAdapter.Make: IHCAdapterDll;
begin
 Result := Create(CLibraryVersion);
end;//Make

end.
