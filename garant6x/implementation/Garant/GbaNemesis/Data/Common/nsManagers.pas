unit nsManagers;

{------------------------------------------------------------------------------}
{ Библиотека : Проект "Немезис";                                               }
{ Автор      : Морозов М.А;                                                    }
{ Начат      : 21.04.2006;                                                     }
{ Модуль     : nsManagers                                                      }
{ Описание   : Файл содержит объявления глобальных управляющих объектов;       }
{------------------------------------------------------------------------------}

// $Id: nsManagers.pas,v 1.3 2015/09/18 11:00:16 kostitsin Exp $
// $Log: nsManagers.pas,v $
// Revision 1.3  2015/09/18 11:00:16  kostitsin
// {requestlink: 606129273 }
//
// Revision 1.2  2009/12/02 14:39:06  oman
// - new: Контекстный фильтр {RequestLink:121157219}
//
// Revision 1.1  2009/09/14 11:28:53  lulin
// - выводим пути и для незавершённых модулей.
//
// Revision 1.20  2009/09/08 13:52:36  lulin
// - удаляем ненужного менеджера.
//
// Revision 1.19  2009/09/08 09:07:49  lulin
// - минимизируем общие поисковые интерфейсы.
//
// Revision 1.18  2009/08/14 14:57:43  lulin
// {RequestLink:129240934}. №42.
//
// Revision 1.17  2009/08/04 11:25:31  lulin
// [$159351827].
//
// Revision 1.16  2009/06/24 12:58:07  oman
// - new: Собираемся - [$152408792]
//
// Revision 1.15  2009/06/24 12:32:50  oman
// - new: Cleanup - [$152408792]
//
// Revision 1.14  2009/06/24 11:37:25  oman
// - new: Заготовки диспетчера - [$152408792]
//
// Revision 1.13  2009/02/10 19:03:13  lulin
// - <K>: 133891247. Вычищаем морально устаревший модуль.
//
// Revision 1.12  2009/02/10 13:34:35  lulin
// - <K>: 133891247. Выделяем интерфейсы профайлеров.
//
// Revision 1.11  2009/02/10 11:21:50  lulin
// - <K>: 133891247. Переносим поисковые интерфейсы.
//
// Revision 1.10  2009/02/10 09:49:56  lulin
// - <K>: 133891247. Выделяем интерфейсы логирования.
//
// Revision 1.9  2008/12/25 12:19:26  lulin
// - <K>: 121153186.
//
// Revision 1.8  2008/12/24 18:23:34  lulin
// - <K>: 121153186.
//
// Revision 1.7  2008/03/26 11:04:20  oman
// cleanup
//
// Revision 1.6  2007/07/26 09:39:47  mmorozov
// - new: регистрирация события фильтрации дерева (CQ: OIT5-25852);
//
// Revision 1.5  2006/09/29 07:19:21  mmorozov
// - change: переменная менеджера консультаций переместилась в модуль bsConsultationManager;
//
// Revision 1.4  2006/09/20 15:03:12  mmorozov
// - new: изменения в рамках работы над журналом работы пользователя;
//
// Revision 1.3  2006/07/05 07:51:04  mmorozov
// - new: профайлеры прецедентов;
//
// Revision 1.2  2006/05/12 07:14:29  mmorozov
// - изменения накопившиеся за время отсутствия CVS;
//
// Revision 1.1  2006/05/02 13:56:26  mmorozov
// - работы связанные с редактированием фильтров;
//

interface

uses
  bsInterfaces,
  SearchInterfaces,

  ProfilersInterfaces,
  QueryCardInterfaces
  ;

{$Include nsDefine.inc}

{$If not defined(Admin) AND not defined(Monitorings)}
function ConsultationManager: IbsConsultationManager;
  {* - глобальный объект менеджер консультаций. }
{$IfEnd}
{$IfDef vcmUseProfilers}
function ProfilersManager: InsProfilersManager;
  {* - глобальный объект менеджер профайлеров. }
{$EndIf vcmUseProfilers}

implementation

uses
  {$If not defined(Admin) AND not defined(Monitorings)}
  bsConsultationManager,
  {$IfEnd}
  {$IfDef vcmUseProfilers}
  nsProfilers
  {$EndIf vcmUseProfilers}
  ;

var
 {$IfDef vcmUseProfilers}
 g_ProfilersManager    : InsProfilersManager = nil;
 {$EndIf vcmUseProfilers}

{$IfDef vcmUseProfilers}
function ProfilersManager: InsProfilersManager;
  {* - глобальный объект менеджер профайлеров. }
begin
 if not Assigned(g_ProfilersManager) then
  g_ProfilersManager := TnsProfilersManager.Make;
 Result := g_ProfilersManager;
end;
{$EndIf vcmUseProfilers}

{$If not defined(Admin) AND not defined(Monitorings)}
function ConsultationManager: IbsConsultationManager;
  {* - глобальный объект менеджер консультаций. }
begin
 Result := g_ConsultationManager;
end;//ConsultationManager
{$IfEnd}

initialization

finalization
  {$IfDef vcmUseProfilers}
  g_ProfilersManager := nil;
  {$EndIf vcmUseProfilers}

end.
