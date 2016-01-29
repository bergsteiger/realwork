unit m3DB;
{* Реализация хранилища документов Архивариуса. }

{ Библиотека "M3"         }
{ Автор: Люлин А.В. ©     }
{ Модуль: m3DB -          }
{ Начат: 17.08.2004 19:14 }
{ $Id: m3DB.pas,v 1.272 2015/11/06 11:04:40 lulin Exp $ }

// $Log: m3DB.pas,v $
// Revision 1.272  2015/11/06 11:04:40  lulin
// - подтачиваем.
//
// Revision 1.271  2015/11/06 10:57:32  lulin
// - выводим ошибку в лог.
//
// Revision 1.270  2015/10/19 06:16:10  fireton
// - более полноценно поддерживаем NoEVD
//
// Revision 1.269  2015/05/21 13:10:31  lulin
// - развязываем зависимости.
//
// Revision 1.268  2015/05/21 12:47:36  lulin
// - развязываем зависимости.
//
// Revision 1.267  2015/05/21 11:19:15  lulin
// - развязываем зависимости.
//
// Revision 1.266  2015/05/20 16:28:44  lulin
// - чистим код.
//
// Revision 1.265  2015/05/20 15:56:50  lulin
// - чистим код.
//
// Revision 1.264  2015/05/20 15:48:35  lulin
// - чистим код.
//
// Revision 1.263  2015/05/20 15:31:00  lulin
// - чистим код.
//
// Revision 1.262  2015/05/20 15:08:27  lulin
// - чистим код.
//
// Revision 1.261  2015/05/20 15:02:44  lulin
// - чистим код.
//
// Revision 1.260  2015/05/20 14:50:11  lulin
// - чистим код.
//
// Revision 1.259  2015/05/20 14:43:44  lulin
// - чистим код.
//
// Revision 1.258  2015/05/20 14:06:31  lulin
// - рисуем на модели.
//
// Revision 1.257  2015/05/20 14:02:25  lulin
// - рисуем на модели.
//
// Revision 1.255  2015/05/19 16:56:29  lulin
// - чистим код.
//
// Revision 1.254  2015/05/19 16:46:47  lulin
// - чистим код.
//
// Revision 1.253  2015/05/19 15:32:07  lulin
// - чистим код.
//
// Revision 1.252  2015/05/19 15:23:42  lulin
// - чистим код.
//
// Revision 1.251  2015/05/19 15:00:54  lulin
// - чистим код.
//
// Revision 1.250  2015/05/19 14:13:06  lulin
// - рисуем на модели.
//
// Revision 1.249  2015/05/19 13:03:55  lulin
// - рисуем на модели.
//
// Revision 1.248  2015/05/19 13:02:06  lulin
// - рисуем на модели.
//
// Revision 1.247  2015/05/19 12:28:26  lulin
// - рисуем на модели.
//
// Revision 1.246  2015/05/14 10:31:16  lulin
// {RequestLink:588034502}. Перетряхиваем код.
//
// Revision 1.245  2015/05/13 15:26:52  lulin
// {RequestLink:588034502}. Чистим код.
//
// Revision 1.244  2015/05/13 15:16:23  lulin
// {RequestLink:588034502}. Чистим код.
//
// Revision 1.243  2015/05/13 14:17:10  lulin
// {RequestLink:588034502}. Инкапсулируем.
//
// Revision 1.242  2015/05/13 13:55:55  lulin
// {RequestLink:588034502}. Инкапсулируем.
//
// Revision 1.241  2015/05/12 16:25:22  lulin
// - причёсываем код.
//
// Revision 1.240  2015/05/12 16:04:18  lulin
// - инкапсулируем функциональность.
//
// Revision 1.239  2015/05/12 14:38:39  lulin
// {RequestLink:588034502}.
//
// Revision 1.238  2015/05/12 14:18:24  lulin
// {RequestLink:588034502}.
//
// Revision 1.237  2015/05/12 11:58:15  lulin
// - причёсываем код.
//
// Revision 1.236  2015/05/12 10:00:28  lulin
// - причёсываем код.
//
// Revision 1.235  2015/05/12 09:51:54  lulin
// - причёсываем код.
//
// Revision 1.233  2015/05/12 09:22:15  lulin
// - причёсываем код.
//
// Revision 1.232  2015/04/29 17:44:06  lulin
// {RequestLink:588034502}
//
// Revision 1.231  2015/04/29 17:24:15  lulin
// {RequestLink:588034502}
//
// Revision 1.230  2015/04/29 15:11:00  lulin
// {RequestLink:588034502}
//
// Revision 1.229  2015/03/27 11:55:38  lulin
// {RequestLink:595437415}.
//
// Revision 1.228  2015/03/16 14:38:46  lulin
// - делаем стереотипы Service и ServiceImplementation.
//
// Revision 1.227  2014/10/31 17:42:58  lulin
// - перетряхиваем код.
//
// Revision 1.226  2014/10/31 14:14:30  lulin
// - перетряхиваем код.
//
// Revision 1.225  2014/10/30 16:37:12  lulin
// - перетряхиваем код.
//
// Revision 1.224  2014/10/30 15:59:02  lulin
// - перетряхиваем код.
//
// Revision 1.223  2014/10/30 13:43:54  lulin
// - перетряхиваем код.
//
// Revision 1.222  2014/10/30 08:29:49  lulin
// - перетряхиваем код.
//
// Revision 1.221  2014/10/27 13:14:45  lulin
// - оптимизируем "размазывание хранилища версий".
//
// Revision 1.220  2014/10/22 16:10:27  lulin
// - правильнее обрабатываем ошибки.
//
// Revision 1.219  2014/10/14 13:53:46  lulin
// - правильнее обрабатываем залочки.
//
// Revision 1.218  2014/10/13 12:41:08  lulin
// - поменьше держим рутовое хранилище при работе с информацией о документе.
//
// Revision 1.217  2014/10/13 12:20:02  lulin
// - чистим код.
//
// Revision 1.216  2014/10/03 07:42:54  lulin
// - стараемся пораньше отпускать документ.
//
// Revision 1.215  2014/10/02 14:32:01  lulin
// - правим сигнатуру фабрики.
//
// Revision 1.214  2014/10/02 11:41:39  lulin
// - корректно обрабатываем недописанные данные.
//
// Revision 1.213  2014/10/02 11:27:18  lulin
// - причёсываем код.
//
// Revision 1.212  2014/10/02 10:47:18  lulin
// - комментарии к коду.
//
// Revision 1.211  2014/09/30 16:12:05  lulin
// - боремся за более раннее отпускание рутового потока.
//
// Revision 1.210  2014/09/30 11:19:23  lulin
// - не пишем немодифицированные списки.
//
// Revision 1.209  2014/09/24 11:46:09  lulin
// - прикручиваем "градусник.
//
// Revision 1.208  2014/09/24 11:18:48  lulin
// - прикручиваем "градусник.
//
// Revision 1.207  2014/09/24 10:56:43  lulin
// - прикручиваем "градусник.
//
// Revision 1.206  2014/09/19 11:35:42  lulin
// - добавляем диагностику.
//
// Revision 1.205  2014/09/19 11:31:03  lulin
// - добавляем диагностику.
//
// Revision 1.204  2014/09/18 16:34:25  lulin
// - используем более кошерные функции.
//
// Revision 1.203  2014/09/18 15:27:04  lulin
// - делаем возможность распаковывать и backup тоже.
//
// Revision 1.202  2014/09/18 15:00:49  lulin
// - переносим функцию распаковки в более правильное место.
//
// Revision 1.201  2014/09/18 14:22:40  lulin
// - делаем распаковку базы целиком.
//
// Revision 1.200  2014/09/18 14:01:54  lulin
// - делаем распаковку базы целиком.
//
// Revision 1.199  2014/09/18 12:57:54  lulin
// - защищаем переименование бекапа.
//
// Revision 1.198  2014/09/18 12:46:28  lulin
// - не убиваем битый бекап, а переименовываем.
//
// Revision 1.197  2014/09/18 11:58:17  lulin
// - стараемся не упираться в залочку.
//
// Revision 1.196  2014/09/18 11:48:17  voba
// - боремся с битым бекапом.
//
// Revision 1.195  2014/09/18 10:58:24  lulin
// - отлаживаем копирование.
//
// Revision 1.194  2014/09/18 09:14:26  lulin
// - реализуем копирование из бекапа в версии и обратно.
//
// Revision 1.193  2014/09/18 08:45:33  lulin
// - по идее у evd-потоков заголовки должны совпадать.
//
// Revision 1.191  2014/09/18 08:26:44  lulin
// - дотачиваем процедуру сравнения.
//
// Revision 1.190  2014/09/17 17:08:08  lulin
// - в первом приближении реализовал сравнение версий и бекапа.
//
// Revision 1.189  2014/09/17 15:49:51  lulin
// - заготовка для сравнения версий и бекапа, а также копирования их туда-сюда.
//
// Revision 1.188  2014/09/16 16:30:27  lulin
// - бекап пытаемся писать в новом формате.
//
// Revision 1.187  2014/09/16 10:43:22  lulin
// - возвращаем старую реализацию хранилища.
//
// Revision 1.186  2014/09/16 07:32:05  lulin
// - чистим код.
//
// Revision 1.185  2014/09/15 16:46:41  lulin
// - стараемся открывать файл из бекапа.
//
// Revision 1.184  2014/09/15 16:08:00  lulin
// - чистим код.
//
// Revision 1.183  2014/09/15 11:39:36  lulin
// - если файла нет в sav, то пытаемся открыть его в bkp.
//
// Revision 1.182  2014/09/11 16:51:11  lulin
// - продолжаем рефакторинг внутреннего устройства хранилища.
//
// Revision 1.181  2014/09/11 12:58:20  lulin
// - при ежедневном обновлении работаем с базой в монопольном режиме.
//
// Revision 1.179  2014/09/05 13:11:15  lulin
// - восстанавливаем "вилку".
//
// Revision 1.178  2014/09/01 13:57:31  lulin
// - в таком разрезе не надо исключение типизировать иначе можно открытую скобку не закрыть.
//
// Revision 1.177  2014/08/27 08:09:23  lukyanets
// Отцепили проверку орфографии
//
// Revision 1.176  2014/08/26 14:11:01  lukyanets
// Учимся прерывать
//
// Revision 1.175  2014/08/19 16:05:30  lulin
// - прикручиваем ещё более внятную диагностику.
//
// Revision 1.174  2014/08/19 15:50:34  lulin
// - пытаемся восстановить битую переменную часть путём удаления неправильного элемента.
//
// Revision 1.173  2014/08/19 12:06:25  lulin
// - не падаем если побилась какая-нибудь ОДНА часть для сохранения.
//
// Revision 1.172  2014/08/19 10:58:56  lulin
// - рефакторинг.
//
// Revision 1.171  2014/08/06 14:19:31  voba
// - переделал откат к сохраненной версии
//
// Revision 1.170  2014/05/12 12:22:56  lulin
// - bug fix: скорее всего присваивали неверный результат.
//
// Revision 1.169  2013/05/17 16:14:08  voba
// - K:455105818
//
// Revision 1.168  2013/05/17 16:04:54  voba
// - K:455105818 для дальнейших разборок
//
// Revision 1.167  2013/04/05 12:04:33  lulin
// - портируем.
//
// Revision 1.166  2012/10/02 08:12:28  narry
// Обновление
//
// Revision 1.165  2012/05/25 13:43:52  lulin
// - чистка кода.
//
// Revision 1.164  2012/05/24 09:05:37  lulin
// - bug fix: не сохранялись списки удалённых и модифицированных при переименовании.
//
// Revision 1.163  2012/05/22 12:52:27  lulin
// {RequestLink:365838449}
//
// Revision 1.162  2012/05/22 11:59:11  lulin
// {RequestLink:365838449}
//
// Revision 1.161  2012/05/05 11:20:48  lulin
// {RequestLink:361038156}
//
// Revision 1.160  2012/05/02 17:43:55  lulin
// {RequestLink:361038156}
//
// Revision 1.159  2011/12/27 12:51:49  lulin
// {RequestLink:324571064}
// - не дело падать в итераторе.
//
// Revision 1.158  2011/09/20 09:25:40  lulin
// - очищаем состояние Filer'а.
//
// Revision 1.157  2010/11/30 14:32:35  lulin
// {RequestLink:244194190}.
//
// Revision 1.156  2010/06/29 12:27:48  narry
// - забытый коммит :(
//
// Revision 1.155  2010/06/29 12:17:50  fireton
// - отслеживаем ошибки итерации "повыше", пишем в лог и продолжаем работу
//
// Revision 1.154  2010/06/02 10:06:29  fireton
// - расширенное логирование (under defines)
//
// Revision 1.153  2010/04/16 12:43:03  fireton
// - не падаем при ошибках в трубе, а продолжаем обрабатывать следующий документ
//
// Revision 1.152  2010/04/16 10:00:00  lulin
// {RequestLink:199590828}.
// - делаем возможность писать в базу из итератора с фильтром.
//
// Revision 1.151  2010/04/15 14:46:18  fireton
// - Range  - список файлов
//
// Revision 1.150  2010/02/08 09:46:21  dinishev
// [$186712161]
//
// Revision 1.149  2009/11/27 12:54:08  lulin
// {RequestLink:172365087}.
//
// Revision 1.148  2009/05/27 14:42:29  lulin
// [$148570764]. №1. Обновление падало на битом документе.
//
// Revision 1.147  2009/04/02 11:11:15  lulin
// [$141918746]. При итерации по переменной части открываем потоки ТОЛЬКО в переменной части.
//
// Revision 1.146  2009/03/31 06:21:23  voba
// - bug fix при апдейте создавались пустые аннотации
//
// Revision 1.145  2009/03/27 15:26:12  lulin
// - сохраняем списка в более правильный момент.
//
// Revision 1.144  2009/03/23 13:38:08  lulin
// [$139441846]. Убираем лишнюю вложенную процедуру.
//
// Revision 1.143  2009/03/23 13:34:37  lulin
// [$139441846]. Ещё раз меняем вложенность локальных функций.
//
// Revision 1.142  2009/03/23 13:28:36  lulin
// [$139441846]. Меняем вложенность локальных функций.
//
// Revision 1.141  2009/03/23 13:22:54  lulin
// [$139441846]. Не получаем документ по нескольку раз.
//
// Revision 1.140  2009/03/23 13:07:10  lulin
// [$139441846]. Переделываем удаление объектов на общий механизм.
//
// Revision 1.139  2009/03/23 12:39:16  lulin
// [$139441846]. Доделываем итерацию по объектам.
//
// Revision 1.138  2009/03/23 12:11:30  lulin
// [$139441846]. Переделал итерацию документов, но без объектов.
//
// Revision 1.137  2009/03/23 11:24:02  lulin
// - используем кошерный конструктор индекса потока документа.
//
// Revision 1.136  2009/03/23 10:21:38  lulin
// - синхронизируем код с моделью.
//
// Revision 1.135  2009/03/23 09:16:13  lulin
// - расставляем директивы условной компиляции.
//
// Revision 1.134  2009/03/23 09:03:21  lulin
// - убираем отладочный вывод в лог.
//
// Revision 1.133  2009/03/23 08:37:25  lulin
// - серьёзно уменьшаем время ожидания залочки и там где надо крутим собственные циклы ожидания - с предварительным отпусканием ресурсов.
//
// Revision 1.132  2009/03/20 13:22:40  lulin
// [$139443100]. Вставляем проверку на существование файла.
//
// Revision 1.131  2009/03/20 13:11:00  lulin
// [$139443100]. bug fix: более младшей перетирали более старшую версию.
//
// Revision 1.130  2009/03/20 11:25:41  lulin
// [$139443674]. Метод открытия потока переносим туда, где ему положено быть.
//
// Revision 1.129  2009/03/19 18:04:58  lulin
// [$139443132].
//
// Revision 1.128  2009/03/19 17:42:23  lulin
// [$139443138].
//
// Revision 1.127  2009/03/19 15:13:17  lulin
// - используем структуру, а не размазанные параметры.
//
// Revision 1.126  2009/03/19 14:29:28  lulin
// - выносим на базу функцию получения списка номеров объектов в документе.
//
// Revision 1.125  2009/03/19 12:49:00  lulin
// - чистка кода.
//
// Revision 1.124  2009/03/19 12:39:33  lulin
// - переносим директиву в правильный файл.
//
// Revision 1.123  2009/03/19 12:31:48  lulin
// - переносим итератор по объектам документа на базу.
//
// Revision 1.122  2009/03/18 15:56:40  lulin
// - итератор по объектам документа сделан локальной процедурой.
//
// Revision 1.121  2009/03/18 15:50:15  lulin
// - итератор по версиям сделан локальной процедурой.
//
// Revision 1.120  2009/03/18 12:07:44  lulin
// - после успешной записи потока переименовываем его в то название по которому пытаемся его писать.
//
// Revision 1.119  2009/03/17 18:47:27  lulin
// - чистка кода.
//
// Revision 1.118  2009/03/17 18:31:14  lulin
// - делаем запись служебной информации о базе и версии документа, ПОСЛЕ УСПЕШНОЙ записи потока.
//
// Revision 1.117  2009/03/17 15:03:17  lulin
// - убираем ненужную виртуальность.
//
// Revision 1.116  2009/03/17 14:07:45  lulin
// - используем локальные процедуры и перемещаем часть методов на объект.
//
// Revision 1.115  2009/03/17 13:10:09  lulin
// - используем локальные процедуры.
//
// Revision 1.114  2009/03/17 12:38:35  lulin
// - переносим итераторы на объект.
//
// Revision 1.113  2009/03/17 11:52:40  lulin
// - убираем ненуждные методы интерфейса.
//
// Revision 1.112  2009/03/16 19:31:43  lulin
// - убираем ненужный параметр.
//
// Revision 1.111  2009/03/16 19:16:19  lulin
// - причёсываем видимость процедур.
//
// Revision 1.109  2009/03/16 18:44:13  lulin
// - расширяем скобки работы с базой.
//
// Revision 1.108  2009/03/16 18:42:29  lulin
// - избавляемся от лишнего списка идентификаторов объектов.
//
// Revision 1.107  2009/03/16 18:39:37  lulin
// - убираем ненужный итератор с части документа.
//
// Revision 1.105  2009/03/16 18:15:33  lulin
// - поправлено форматирование.
//
// Revision 1.104  2009/03/16 17:58:24  lulin
// - избавляемся от ненужного и странного метода.
//
// Revision 1.103  2009/03/16 17:35:04  lulin
// - выделяем идентификатор нового объекта в самом низу.
//
// Revision 1.102  2009/03/16 17:25:38  lulin
// - восстанавливаем возможность рулить отпусканием версий в хранилище.
//
// Revision 1.101  2009/03/16 17:15:42  lulin
// - убираем устаревший метод.
//
// Revision 1.100  2009/03/16 17:11:38  lulin
// - проверяем догадку о том, что нафи не нужно выносить этот метод на базу.
//
// Revision 1.99  2009/03/16 17:03:49  lulin
// - убираем ненужные значения по-умолчанию.
//
// Revision 1.98  2009/03/16 16:59:07  lulin
// - используем человеческий интерфейс, а не кишочки.
//
// Revision 1.97  2009/03/16 16:46:19  lulin
// - убираем ненужные параметры по-умолчанию и вставляем проверку инвариантов.
//
// Revision 1.96  2009/03/16 16:18:52  lulin
// - <K>: 138969458. Убираем ненужный параметр.
//
// Revision 1.95  2009/03/16 13:31:29  lulin
// - вычищаем использование ненужного модуля.
//
// Revision 1.94  2009/03/16 13:28:27  lulin
// - [$139434552].
//
// Revision 1.93  2008/10/22 12:52:19  voba
// - bug fix ошибка с множественной подсветкой найденных
//
// Revision 1.92  2008/07/02 13:30:39  lulin
// - <K>: 90443135.
//
// Revision 1.91  2008/07/02 12:26:56  fireton
// - рефакторинг (mdp-90443135): избавляемся от списков обработанных объектов в объявлении методов
//
// Revision 1.90  2008/06/06 11:57:45  fireton
// - bug fix: утечки
//
// Revision 1.89  2008/05/14 12:16:53  fireton
// - развязал логику итераторов (К 90443149)
//
// Revision 1.88  2008/05/13 11:21:16  lulin
// - вычищен ненужный параметр, <K>: 90443135.
//
// Revision 1.87  2008/05/13 10:15:34  lulin
// - изменения в рамках <K>: 90443135.
//
// Revision 1.86  2008/05/12 14:54:07  lulin
// - <K>: 90443788.
//
// Revision 1.85  2008/05/12 06:57:13  lulin
// - bug fix: не собирался Архивариус, т.к. генерация перетёрла Антошины изменения.
//
// Revision 1.84  2008/05/08 14:04:19  fireton
// - перенос объектов в потоках из ветки
//
// Revision 1.83  2008/04/17 15:14:16  narry
// - в монопольном режиме пишем только в одно хранилище
//
// Revision 1.82  2008/03/20 09:48:42  lulin
// - cleanup.
//
// Revision 1.81  2008/02/29 08:24:14  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.80  2008/02/19 11:38:41  lulin
// - восстановил компилируемость Архивариуса.
//
// Revision 1.79  2008/02/14 17:30:34  lulin
// - cleanup.
//
// Revision 1.78  2008/02/13 16:03:16  lulin
// - убраны излишне гибкие методы поиска.
//
// Revision 1.77  2008/02/12 14:39:45  lulin
// - методы для чтения списка переехали на примесь.
//
// Revision 1.76  2008/02/12 11:44:54  lulin
// - методы для сохранения списка переехали на примесь.
//
// Revision 1.75  2008/02/07 14:44:48  lulin
// - класс _Tl3LongintList переехал в собственный модуль.
//
// Revision 1.74  2007/12/21 08:26:10  lulin
// - функции для построения оберток вынесены в отдельный модуль.
//
// Revision 1.73  2007/11/21 18:11:04  lulin
// - убрана ненужная виртуальность.
//
// Revision 1.72  2007/10/29 12:51:53  lulin
// - используем интерфейс, вместо класса.
//
// Revision 1.71  2007/10/26 15:01:31  lulin
// - вычищен ненужный интерфейс.
//
// Revision 1.70  2007/08/21 11:39:54  lulin
// - избавляемся от предупреждений компилятора.
//
// Revision 1.69  2007/08/20 19:06:25  lulin
// - bug fix: возвращали неправильное значение.
//
// Revision 1.68  2007/08/20 18:28:16  lulin
// - делаем вилку для сохранения файлов хранилища.
//
// Revision 1.66  2007/08/20 18:12:53  lulin
// - cleanup.
//
// Revision 1.65  2007/08/20 18:09:22  lulin
// - cleanup.
//
// Revision 1.64  2007/07/23 15:09:25  voba
// - refact. переделал буферезацию удаленных/измененных
//
// Revision 1.63  2007/04/19 12:36:50  voba
// - спасение тверских данных
// - del procedure CheckVersion
//
// Revision 1.62  2006/12/18 15:29:24  lulin
// - cleanup.
//
// Revision 1.61  2006/10/05 09:30:04  fireton
// - более правильное чтение info
//
// Revision 1.60  2006/10/04 08:44:25  voba
// - add кеширование modified и deleted листов в m3DB
//
// Revision 1.59  2006/09/25 14:43:04  voba
// - new beh. загрузка листов без сортировки
//
// Revision 1.58  2006/09/12 12:13:38  fireton
// - подготовка к реализации right management на сервере
//
// Revision 1.57  2006/08/29 11:18:23  fireton
// - поддержка интерфейса хелпера на базе
// - _CopyThrough теперь принимает nil в качестве базы (пропустить через фильтр и никуда не писать)
// - в инфо пишутся и читаются новые поля
//
// Revision 1.56  2006/04/25 09:34:14  lulin
// - cleanup.
//
// Revision 1.55  2006/04/13 15:44:22  fireton
// - bug fix: _CopyThrough - отлинковываем writer от фильтров (чтобы он полностью освободился)
//
// Revision 1.54  2006/04/04 09:58:05  fireton
// - bug fix: _CopyTrough - информацию о документе не надо пропускать через трубу
//
// Revision 1.53  2006/03/27 08:19:47  voba
// - bug fix
//
// Revision 1.52  2006/03/24 14:38:11  fireton
// - add: в _CopyThrough добавлен фильтр, через который пропускается поток
//
// Revision 1.51  2006/03/20 08:56:43  fireton
// - метод _CopyThrough
//
// Revision 1.50  2006/03/16 09:58:17  voba
// - поддержка версий в SimpleDB
//
// Revision 1.49  2006/03/09 09:02:12  voba
// - merge
//
// Revision 1.48.2.3  2006/03/09 08:31:02  voba
// - bug fix
//
// Revision 1.48.2.2  2006/03/02 14:43:36  voba
// - new beh. абстрагирование _Im3DB от структуры базы (продолжение)
//
// Revision 1.48.2.1  2006/03/02 09:41:28  voba
// - new beh. абстрагирование _Im3DB от структуры базы (продолжение)
//
// Revision 1.48  2006/02/22 09:07:19  voba
// - new beh. абстрагирование _Im3DB от структуры базы (продолжение)
//
// Revision 1.47  2006/02/21 12:52:08  voba
// - new beh. абстрагирование _Im3DB от структуры базы (часть 3)
//
// Revision 1.46  2006/02/14 08:41:40  voba
// - new beh. абстрагирование _Im3DB от структуры базы (часть 2)
// - rename
//  Tm3DocumentStream   -> Tm3DocPartSelector
//  Tm3DocumentStreams  -> Tm3DocPartSet
//  m3_defDocStream     -> m3_defDocPart
//  m3_AllDocStreams    -> m3_AllDocParts
//
// Revision 1.45  2006/02/09 15:03:50  voba
// - new beh. абстрагирование _Im3DB от структуры базы
//
// Revision 1.44  2006/02/07 16:38:41  voba
// - new beh. абстрагирование _Im3DB от структуры базы
//
// Revision 1.43  2006/02/06 13:32:18  voba
// - new beh. выпилил поддержку стаго хранилища (часть 2)
//
// Revision 1.42  2006/02/03 07:15:24  voba
// - new beh. выпилил поддержку стаго хранилища
//
// Revision 1.41  2005/05/24 11:07:42  lulin
// - cleanup.
//
// Revision 1.40  2005/04/19 15:41:54  lulin
// - переходим на "правильный" ProcessMessages.
//
// Revision 1.39  2005/02/15 17:46:53  lulin
// - new behavior: при работе с информацией о документе используем стандартную функцию _Open(.. _m3_dsInfo).
//
// Revision 1.38  2005/02/15 17:08:46  lulin
// - new const: _m3_dsInfo.
//
// Revision 1.37  2005/02/15 16:11:02  lulin
// - cleanup.
//
// Revision 1.36  2005/02/15 16:05:06  lulin
// - спрятал ненужные методы.
//
// Revision 1.35  2005/02/15 15:59:39  lulin
// - new behavior: метод m3IterateVersionsForCompare теперь работает через интерфейс _Im3DB.
//
// Revision 1.34  2005/02/15 15:13:02  lulin
// - обновлена документация.
//
// Revision 1.33  2005/02/15 14:41:25  lulin
// - cleanup.
//
// Revision 1.32  2005/02/15 13:12:36  lulin
// - new prop: _Tm3DBFiler.DocStream,
//
// Revision 1.31  2005/02/15 11:49:15  lulin
// - new behavior: теперь все итераторы могут перебирать составные части документов (main, anno).
//
// Revision 1.30  2005/02/14 16:09:32  lulin
// - new behavior: теперь документы Архивариуса состоят из двух потоков - main (текст) и anno (аннотация).
//
// Revision 1.29  2005/02/14 15:12:01  lulin
// - изменены сигнатуры методов.
//
// Revision 1.28  2005/02/14 14:41:23  lulin
// - new behavior: записываем номер версии базы в хранилище.
//
// Revision 1.27  2005/02/14 13:54:50  lulin
// - new behavior: в хранилище версий документов документ теперь представляется директорией с потоком main.
//
// Revision 1.26  2004/11/10 08:02:43  lulin
// - выключены "лишние" директивы.
//
// Revision 1.25  2004/11/03 17:44:37  lulin
// - remove unit: m3OldBaseTools.
//
// Revision 1.24  2004/11/03 17:33:38  voba
// - new behavior: при неудаче записи в старое хранилище пытаемся записать ТОЛЬКО в новое или выводим exception.
//
// Revision 1.23  2004/11/03 14:29:55  lulin
// - убрал лишний перехват exception'ов.
//
// Revision 1.22  2004/11/03 13:21:09  lulin
// - не поднимаем exception если не смогли открыть файл в старом хранилище.
//
// Revision 1.21  2004/11/02 17:50:48  lulin
// - bug fix: избавляемся от Dealock'а при зеркальном доступе с разных машин к разным компонентам хранилища.
//
// Revision 1.20  2004/11/02 16:54:25  lulin
// - bug fix: при закрытии базы очищаем режимы открытия хранилищ.
//
// Revision 1.19  2004/11/02 15:12:30  lulin
// - bug fix: неправильно указывали режим открытия базы.
//
// Revision 1.18  2004/10/06 13:52:18  lulin
// - теперь метод _Im3DB._Start имеет два ОБЯЗАТЕЛЬНЫХ параметра - режимы открытия частей.
//
// Revision 1.17  2004/10/01 09:08:36  lulin
// - new method: Im3DBDocument._Open.
//
// Revision 1.16  2004/10/01 07:48:28  lulin
// - bug fix: забыл значение параметра по умолчанию.
//
// Revision 1.15  2004/10/01 07:19:44  lulin
// - new behavior: сделана возможность в итераторе и обновлении игнорировать пустые файлы.
//
// Revision 1.14  2004/09/27 12:15:11  lulin
// - new method: _Im3DB.Files.
//
// Revision 1.13  2004/09/27 11:33:01  lulin
// - new method: _Im3DB.SingleDocument.
//
// Revision 1.12  2004/09/24 15:52:52  lulin
// - bug fix: были несбалансированны скобки индикатора.
//
// Revision 1.11  2004/09/24 10:40:00  lulin
// - bug fix: не освобождался файл с резервными копиями.
//
// Revision 1.10  2004/09/24 07:54:51  lulin
// - были несбалансированы скобки индикатора.
//
// Revision 1.9  2004/09/23 14:41:08  lulin
// - bug fix: невовремя создавали "вилку".
//
// Revision 1.8  2004/09/23 14:04:34  lulin
// - bug fix: задавил exception при попытке открытия файла старого хранилища на запись.
//
// Revision 1.7  2004/09/23 12:14:50  lulin
// - new behavior: при записи в новое хранилище сделана запись в резервную часть.
//
// Revision 1.6  2004/09/22 10:43:15  lulin
// - не падаем если не смогли открыть базу.
//
// Revision 1.5  2004/09/21 11:22:27  lulin
// - Release заменил на Cleanup.
//
// Revision 1.4  2004/09/09 16:03:20  voba
// - закоментировали открытие постоянной части на запись?
//
// Revision 1.3  2004/09/09 15:09:03  lulin
// - bug fix: не очищали поле f_Starts (!).
//
// Revision 1.2  2004/09/06 16:28:05  law
// - new define: m3NotUseForkStreamToOldBase.
//
// Revision 1.1  2004/09/02 08:09:47  law
// - cleanup.
//
// Revision 1.85  2004/09/01 16:28:25  law
// - new behavior: не делаем "вилку" при записи в постоянную часть.
//
// Revision 1.84  2004/09/01 15:15:32  voba
// - bug fix несовместимость с консольным режимом
//
// Revision 1.83  2004/08/31 17:17:09  law
// - перевел на лог от l3System.
//
// Revision 1.82  2004/08/31 17:02:24  law
// - cleanup: убраны ненужные параметры.
//
// Revision 1.81  2004/08/31 16:54:59  narry
// - bug fix by Lulin
//
// Revision 1.80  2004/08/31 16:46:47  law
// - в модифицирующих операциях выставляем базе режим ReadWrite.
//
// Revision 1.79  2004/08/31 16:40:32  law
// - при открытии потока в Filer'е указываем режим открытия базы.
//
// Revision 1.78  2004/08/31 16:33:57  law
// - bug fix: в итераторе по старой базе заменил залочку с административной на пользовательскую.
//
// Revision 1.77  2004/08/31 13:59:24  law
// - cleanup.
//
// Revision 1.76  2004/08/31 13:56:33  law
// - bug fix: не учитывали опцию - старая/новая база.
//
// Revision 1.75  2004/08/31 13:52:34  law
// - new method: _Im3DB.Purge.
//
// Revision 1.74  2004/08/31 13:24:03  law
// - сделана возможность в процедуре _Im3DB._CopyTo перезаписывать пустые.
//
// Revision 1.73  2004/08/30 16:16:59  law
// - подавляем ошибки при получении DocInfo для документа из старого хранилища.
//
// Revision 1.72  2004/08/30 15:13:14  voba
// - add function _m3DBDocumentInfo - "делает" Tm3DBDocumentInfo.
//
// Revision 1.71  2004/08/30 13:12:13  voba
// - bug fix: пытались открывать документ с идентификатором 0.
//
// Revision 1.70  2004/08/30 12:45:10  law
// - new behavior: отпускаем ExchangeDirStream перед вызовом подитеративной функции.
//
// Revision 1.69  2004/08/30 10:59:02  law
// - remove class: TmgBasePackageTagFilter.
// - new unit: m3DocumentInfoFilter.
//
// Revision 1.68  2004/08/30 09:32:12  law
// - bug fix: _Tm3DBFiler не учитывал постоянную часть.
//
// Revision 1.67  2004/08/30 08:21:28  law
// - при копировании Info проверяем, что это первая верси.
//
// Revision 1.66  2004/08/30 08:13:38  law
// - new behavior: при создании версии копируем инфо из постоянной части.
//
// Revision 1.65  2004/08/27 15:12:59  voba
// - merge with B_New_Text_Base
//
// Revision 1.64  2004/08/27 14:50:40  law
// - new define: m3UseForkStreamToOldBase.
//
// Revision 1.63.2.1  2004/08/25 16:11:54  law
// - постепенно отказываемся от прямого использования старого хранилища.
//
// Revision 1.63  2004/08/25 14:37:56  law
// - new method: Tm3DB._MakeDef.
//
// Revision 1.62  2004/08/25 12:06:45  law
// - new behavior: _Im3DB.Update и Im3DBRange._CopyTo теперь возвращают код успеха.
//
// Revision 1.61  2004/08/25 11:05:31  law
// - new param: _Im3DB._Start -> aMode.
//
// Revision 1.60  2004/08/25 10:02:44  law
// - bug fix: не падаем на чтении Info из "битых" файлов.
//
// Revision 1.59  2004/08/24 15:22:22  law
// - при индексации нового хранилища читаем список удаленных из "правильного места".
//
// Revision 1.58  2004/08/24 14:22:46  law
// - bug fix: метод _Tm3BaseRange.Mul не учитывал f_IndexID.
//
// Revision 1.57  2004/08/24 14:13:35  law
// - bug fix: повисало при индексации новой постоянной части.
// - bug fix: при пропускании документов которые не надо индексировать не рисовался "градусник".
// - new behavior: перебор постоянной части нового хранилища учитывает (_ModifiedFiles).
//
// Revision 1.56  2004/08/24 13:43:29  law
// - bug fix: не туда писалась информация о переменной части.
// - new behavior: ведем список модифицированных файлов.
//
// Revision 1.55  2004/08/24 13:06:36  law
// - new method: Im3DBDocument.Undelete.
//
// Revision 1.54  2004/08/24 10:45:05  law
// - сделана запись об удаленных файлах в новое хранилище.
//
// Revision 1.53  2004/08/24 07:52:24  law
// - new: сделана возможность индексировать в несколько индексов.
//
// Revision 1.52  2004/08/24 06:28:52  law
// - new methods versions: Im3DBRange._Iterate, _IterateF.
//
// Revision 1.51  2004/08/24 06:13:21  law
// - new method: Tm3DB.TuneFiler.
//
// Revision 1.50  2004/08/24 06:01:48  law
// - _Tm3DBDocumentPart._Open переведен на использование Filer'а.
//
// Revision 1.49  2004/08/23 16:15:51  law
// - bug fix.
//
// Revision 1.48  2004/08/23 15:29:33  law
// - для старого хранилища возвращаем rIndexID.
//
// Revision 1.47  2004/08/23 15:12:13  law
// - rename prop: Im3DBDocumentPart.ContentType -> Info.
//
// Revision 1.46  2004/08/23 14:56:58  law
// - методы _Open* переехали на интерфейс Im3DBDocumentPart.
//
// Revision 1.45  2004/08/23 13:16:06  law
// - new behavior: копирование документов учитывает ContentType.
//
// Revision 1.44  2004/08/23 12:58:20  law
// - new interface: Im3DBDocumentPart.
//
// Revision 1.43  2004/08/23 12:01:47  law
// - добавлено значение параметра по умолчанию.
//
// Revision 1.42  2004/08/23 11:50:58  law
// - даны более вразумительне названия методам.
//
// Revision 1.41  2004/08/23 11:45:46  law
// - добавлены скобки.
//
// Revision 1.40  2004/08/20 16:28:56  law
// - cleanup.
//
// Revision 1.39  2004/08/20 16:24:19  law
// - new param: Im3DBRange._CopyTo -> aRewrite.
//
// Revision 1.38  2004/08/20 16:20:45  law
// - new method: Im3DBRange._CopyTo.
//
// Revision 1.37  2004/08/20 16:01:53  law
// - метод _Im3DB.Update переведен на рельсы работы с Im3DBDocument.
//
// Revision 1.36  2004/08/20 15:48:41  law
// - открытие документа на запись обновляет информацию о наибольшем и наиментшем индексах.
//
// Revision 1.35  2004/08/20 15:34:34  law
// - реализованы функции Im3DBDocument._Open* и для старой базы тоже.
//
// Revision 1.34  2004/08/20 14:54:12  law
// - вынес константы.
//
// Revision 1.33  2004/08/20 13:57:42  law
// - bug fix: при переборе файлов ExchDirStream открывался только на Read, что приводило к WriteStreamError при вызове LockDirHandle.
//
// Revision 1.32  2004/08/20 12:30:05  law
// - new methods: Im3DBDocument._Open*.
//
// Revision 1.31  2004/08/20 11:48:05  law
// - new method: _Im3DB.GetDocument.
//
// Revision 1.30  2004/08/20 11:29:29  law
// - кешируем файлы нового хранилища.
//
// Revision 1.29  2004/08/20 11:17:10  law
// - new behavior: меряем время уже после закрытия базы.
//
// Revision 1.28  2004/08/20 11:14:14  law
// - new behavior: по завершению процесса закрываем базу.
//
// Revision 1.27  2004/08/20 10:44:24  law
// - new behavior: при обновлении нового хранилища выводим прогресс копирования файла.
//
// Revision 1.26  2004/08/20 08:59:09  law
// - new behavior: итератор по новой базе теперь учитывает и переменную часть тоже (пока на основе ldl-файла).
//
// Revision 1.25  2004/08/20 08:09:17  law
// - new method: Im3DBDocument.Delete.
//
// Revision 1.24  2004/08/20 07:48:16  law
// - new interface: Im3DBDocument.
//
// Revision 1.23  2004/08/20 07:17:27  law
// - new props: Im4DB.FakeIndex, _PackedIndex.
//
// Revision 1.22  2004/08/20 06:53:16  law
// - убрал с Tm3DB знания об _afw.ProcessMessages.
//
// Revision 1.21  2004/08/20 06:32:52  law
// - время процесса и флаг остановки теперь относятся к _Im3DB.
//
// Revision 1.20  2004/08/20 06:07:17  law
// - new procs: _Im3DB._Start, Finish, LastElapsed.
//
// Revision 1.19  2004/08/20 05:55:30  law
// - Tm3DB.Update для новой базы переведен на итератор по _ModifiedFiles.
//
// Revision 1.18  2004/08/20 05:45:47  law
// - new proc: _Im3DB.Update.
//
// Revision 1.17  2004/08/19 18:20:02  law
// - реализован метод _Tm4DB._UpdateIndex.
//
// Revision 1.16  2004/08/19 17:51:47  law
// - new method: Im4DB._UpdateIndex.
//
// Revision 1.15  2004/08/19 17:27:14  law
// - не пользуемся внутренними переменными напрямую.
//
// Revision 1.14  2004/08/19 17:06:12  law
// - new proc: _m3GetVersionsStorage.
//
// Revision 1.13  2004/08/19 16:58:28  law
// - в хранилище версий записываем информацию о верхнем и нижнем индексах хранимых файлов.
//
// Revision 1.12  2004/08/19 16:49:37  law
// - более корректно обращаемся с индикатором общего процесса.
//
// Revision 1.11  2004/08/19 15:37:03  law
// - в нулевом приближении сделана индексация нового хранилища.
//
// Revision 1.10  2004/08/19 12:16:15  law
// - new class: _Tm3BaseRange.
//
// Revision 1.9  2004/08/18 17:46:11  law
// - new method version: Im3DBRange._Iterate.
//
// Revision 1.8  2004/08/18 17:37:26  law
// - поправлен заголовок модуля.
//
// Revision 1.7  2004/08/18 17:36:29  law
// - remove method: Im3DBRange.Add.
// - new method: Im3DBRange.Mul.
//
// Revision 1.6  2004/08/18 17:23:25  law
// - new method: Im3DBRange.LastElapsed.
//
// Revision 1.5  2004/08/18 17:20:53  law
// - new method: Im3DBRange._Iterate.
//
// Revision 1.4  2004/08/18 16:51:30  law
// - начал перетаскивать функции работы с базой из глобальных в интерфейс _Im3DB.
//
// Revision 1.3  2004/08/18 15:42:30  law
// - new units.
//
// Revision 1.2  2004/08/17 15:19:00  law
// - убрал лишний inc.
//
// Revision 1.1  2004/08/17 15:16:13  law
// - new unit: m3DB.
//

{$Include m3Define.inc}

interface

uses
  Classes,

  l3Types,
  l3Base,
  l3CacheableBase,
  l3Filer,
  l3LongintList,
  l3CProtoObject,

  m3StorageInterfaces,
  m3Interfaces,
  m3DBInterfaces,
  m3PrimDB
  ;

type
 Tm3CommonListSelector = (clsDeleted, clsModified);

type
  Tm3CustomDB = class(Tm3PrimDB, Im3DB)
    private
    // internal fields
      f_BaseName         : AnsiString;
      f_DeletedList_Add  : Tl3LongintList;
      f_DeletedList_Del  : Tl3LongintList;
      f_ModifiedList_Add : Tl3LongintList;
      f_ModifiedList_Del : Tl3LongintList;
    protected
    // internal fields
      f_Stopped          : Boolean;
      f_Starts           : Integer;
      f_Elapsed          : TDateTime;
      f_DeletedFiles     : Tl3LongintList;
      f_OnYield          : TNotifyEvent;
    protected
    // interface methods
      // Im3DB
      function AsDB: Im3DB; override;
      function  IndexedFiles(anIndexID : Integer = 1): Im3DBRange;
        virtual; abstract;
        {-}
      function  ModifiedFiles(aNotEmpty : Boolean = false;
                              aLevel    : Integer = Cm3LastVersion): Im3DBRange;
        virtual; abstract;
        {-}
      function  AllFiles: Im3DBRange; virtual; abstract;
        {-}
      function FilesInList(const aList: Im3StorageElementIDList): Im3DBRange; virtual; abstract;
        {-}
      function  InProcess: Boolean; override;
        {* - с базой идет процесс. }
      function  Stopped: Boolean; override;
        {* - предыдущий процесс был остановлен. }
      procedure Stop;
        {* - остановить текущий процесс. }
      function  Purge: Integer;
        virtual;
        abstract;
        {* - удаляет файлы, помеченные как удаленные. }
      function  Update(aNotEmpty: Boolean = true; aPurgeDeletedObjects: Boolean = true): Boolean;
        virtual;
        abstract;
      procedure FlushLists;
        {* - сбрасывает кеш Modified и Deleted листов.
             Применяется при массовой заливке документов в конце заливки пачки.
             Так же вызывается при уничтожении объекта доступа к базе (Tm3DB)}

        {* - переливает файлы из переменной части в постоянную. }
      function  LastElapsed: TDateTime; override;
        {* - время последнего процесса с базой. }
      function  GetDocument(anID: Integer): Im3DBDocument;
        virtual;
        abstract;
        {* - возвращает документ по номеру. }

      function OpenList(const aName: AnsiString;
                        aStatStgMode: Integer = m3_saReadWrite;
                        aUseCompression : Boolean = True) : IStream;
        virtual;
        abstract;
        {-}

      procedure LoadList(const aName: AnsiString; aList: Tl3LongintList);
        {-}
      procedure SaveList(const aName: AnsiString; aList: Tl3LongintList);
        {-}

      procedure SetList(aListSelector : Tm3CommonListSelector; anID: Integer; aInsert: Boolean);
        {* - Исправляет список aListSelector.}
      function  MakeCommonList(aListSelector : Tm3CommonListSelector): Tl3LongintList;
        {-}
      function  DeletedFiles: Tl3LongintList;
        {-}
      procedure ModifyDeleted(anID: Integer; aInsert: Boolean); override;
        {* - Исправляет список удаленных. }
      procedure ModifyModified(anID: Integer);
        override;
        {* - Исправляет список измененных. }
      procedure FreeVersions; virtual; abstract;
        {-}
      procedure DeleteVersion;
        {-}
      procedure DeleteVersionOnly;
        {-}
      procedure DeleteBackupOnly;
        {-}
      procedure DeleteBackupOnlyPrim;
        {-}
   function CompareVersionWithBackup: Boolean;
   procedure ExtractMainTo(const aDir: AnsiString);
   procedure ExtractVersionTo(const aDir: AnsiString);
   procedure ExtractBackupTo(const aDir: AnsiString);
   procedure CopyBackupToVersion;
   procedure CopyVersionToBackup;
      procedure DeleteMain;
        {-}
      procedure CheckExclusive; virtual;
        {-}
   procedure RenameMain(const aNewName: AnsiString);
   procedure RenameBackupOnly(const aNewName: AnsiString);
   procedure RenameVersion(const aNewName: AnsiString);
   procedure Rename(const aNewName: AnsiString);
    protected
      procedure BeforeRelease;
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
      procedure FreeLists;
        {-}  
      procedure Release;
        override;
        {-}
      procedure Yield;
        override;
        {-}
      procedure TuneFiler(aFiler: Tl3CustomFiler);
        override;
        {-}
    protected
    // internal properties
      property BaseName: AnsiString
        read f_BaseName;
        {-}
    public
    // public methods
      constructor Create(const aBaseName   : AnsiString;
                         aOnYield          : TNotifyEvent;
                         aFileMeter        : Tl3ProgressProc;
                         aFilesMeter       : Tl3ProgressProc;
                         aFilesProcessed   : Tm3FilesProcessed;
                         aFilesProcessedEx : Tm3FilesProcessedEx);
        reintroduce;
        virtual;
        {* - создает экземпляр класса. }
      class function Make(const aBaseName   : AnsiString;
                          aOnYield          : TNotifyEvent = nil;
                          aFileMeter        : Tl3ProgressProc = nil;
                          aFilesMeter       : Tl3ProgressProc = nil;
                          aFilesProcessed   : Tm3FilesProcessed = nil;
                          aFilesProcessedEx : Tm3FilesProcessedEx = nil): Im3DB;
        reintroduce;
        {* - создает экземпляр класса как интерфейс Im3DB. }
  end;//Tm3CustomDB

  Tm3DB = class(Tm3CustomDB)
   {* Реализация хранилища документов Архивариуса. }
    private
    // internal fields
      f_BackupVersionsStorage : Im3IndexedStorage;
      f_MainStorage         : Im3IndexedStorage;
      f_MainStorageMode     : Tm3StoreAccess;
      f_VersionsStorage     : Im3IndexedStorage;
      f_VersionsStorageMode : Tm3StoreAccess;
      f_Exclusive           : Boolean;
    private  
      procedure pm_SetVersionsStorage(const Value: Im3IndexedStorage);
    protected
    // interface methods
      // Im3DB
      procedure FreeVersions; override;
        {-}
      function  IndexedFiles(anIndexID : Integer = 1): Im3DBRange;
        override;
        {-}
      function  ModifiedFiles(aNotEmpty : Boolean = false;
                              aLevel    : Integer = Cm3LastVersion): Im3DBRange;
        override;
        {-}
      function  AllFiles: Im3DBRange;
        override;
        {-}
      function FilesInList(const aList: Im3StorageElementIDList): Im3DBRange;
        override;
        {-}
      function  Purge: Integer;
        override;
        {* - удаляет файлы, помеченные как удаленные. }
      function  Update(aNotEmpty: Boolean = true; aPurgeDeletedObjects: Boolean = true): Boolean;
        override;
        {* - переливает файлы из переменной части в постоянную. }
      procedure Start(aOpenMode : Tm3StoreAccess);
        override;
        {* - начинает процесс с базой. }
      procedure Finish;
        override;
        {* - заканчивает процесс с базой. }
      function  GetDocument(anID: Integer): Im3DBDocument;
        override;
        {* - возвращает документ по номеру. }
      function IsExclusive: Boolean; override;  
    protected
    // internal methods
      procedure CheckExclusive; override;
        {-}
      procedure SetExclusive;
        {-}  
      procedure StartEx(aVersionsMode : Tm3StoreAccess;
                        aConstMode    : Tm3StoreAccess);
        override;
        {* - начинает процесс с базой. }
      function MainStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
        override;
        {-}
      function NeedCreateVersionsStorage(aMode: Tm3StoreAccess): Boolean;
      function GetVersionsStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
        override;
        {-}
      function GetBackupStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
        override;
        {-}
      procedure CloseBase;
        override;
        {* - закрывает открытые файлы. }
      procedure InitFields; override;
      function OpenList(const aName: AnsiString;
                        aStatStgMode: Integer = m3_saReadWrite;
                        aUseCompression : Boolean = True) : IStream;
        override;
        {* - Исправляет список измененных. }
  public
     class function MakeExclusive(const aBaseName   : AnsiString;
                          aOnYield          : TNotifyEvent = nil;
                          aFileMeter        : Tl3ProgressProc = nil;
                          aFilesMeter       : Tl3ProgressProc = nil;
                          aFilesProcessed   : Tm3FilesProcessed = nil;
                          aFilesProcessedEx : Tm3FilesProcessedEx = nil): Im3DB;
      property VersionsStorage: Im3IndexedStorage
        read f_VersionsStorage
        write pm_SetVersionsStorage;
  end;//Tm3DB

implementation

uses
  Windows,
  ActiveX,

  SysUtils,

  ComObj,

  l3Interfaces,
  l3MinMax,
  l3String,
  l3Stream,
  l3Except,
  l3ForkStream,
  l3FileUtils,

  m2MemLib,
  m2COMLib,

  m3Const,
  m3DBActions,
  m3BackupTools,
  m3StorageTools,
  m3StgMgr,
  m3StorageElementIDList,
  m3DBProxyWriteStream,
  m3NewVersionStream,

  {$IfNDef m3NoEVD}
  k2CustomFileGenerator,
  k2TagGen,
  k2EVDReaderService,
  k2EVDWriterService,
  k2CustomReader,
  k2CustomFileReader,
  {$ENDIF}

  m3Exceptions,
  m3BaseObject,
  m3DBDocument,
  m3DBDocumentPart,
  m3DBFiler
  ;

const
 cCommonListName : array[Tm3CommonListSelector] of AnsiString = ('deleted', 'modified');

type
  Tm3BaseRangeParam = (m3_brpIndexed, m3_brpModified);
  Tm3BaseRangeParams = set of Tm3BaseRangeParam;

  Im3BaseRangeParamsSource = interface(Im3Base)
    ['{99AC6CB3-A7C2-4F40-B013-0D8A23BCBA9E}']
    // property methods
      function  pm_GetParams: Tm3BaseRangeParams;
      procedure pm_SetParams(aValue: Tm3BaseRangeParams);
        {-}
    // public properties
      property Params: Tm3BaseRangeParams
        read pm_GetParams
        write pm_SetParams;
        {-}
  end;//Im3BaseRangeParamsSource

  Tm3BaseRange = class(Tm3BaseObject, Im3DBRange)
    protected
        {-}
      function Iterate(const aFilter : Im3TagGenerator;
                       aNeedWriteToBase : Boolean;
                       aParts  : Tm3DocPartSet = m3_AllDocParts): Integer;
        overload;
      function Iterate(anAction : Tm3DocumentAction;
                       aParts   : Tm3DocPartSet): Integer;
        overload;
        virtual;
        abstract;
        {-}
      function Iterate(anAction : Tm3FilerAction;
                       aParts   : Tm3DocPartSet): Integer;
        overload;
        virtual;
        abstract;
        {-}
      function IterateF(anAction : Tm3FilerAction;
                        aParts   : Tm3DocPartSet = m3_AllDocParts): Integer;
        overload;
        {-}
      function  IterateF(anAction : Tm3DocumentAction;
                         aParts   : Tm3DocPartSet = m3_AllDocParts): Integer;
        overload;
        {-}
      function  CopyTo(const aDB : Im3DB;
                       aMode     : Tm3DBCopyMode = m3_cmRewrite;
                       aParts    : Tm3DocPartSet = m3_AllDocParts): Boolean;
        {-}
      function LastElapsed: TDateTime;
        {-}
      function Mul(const aRange: Im3DBRange): Im3DBRange; virtual; abstract;
    public
        {-}
  end;//Tm3BaseRange

  Tm3DocListRange = class(Tm3BaseRange)
  private
   f_List: Im3StorageElementIDList;
  protected
   function Iterate(anAction : Tm3DocumentAction;
                    aParts   : Tm3DocPartSet): Integer;
     //overload;
     override;
     {-}
   function Iterate(anAction : Tm3FilerAction;
                    aParts   : Tm3DocPartSet): Integer;
     //overload;
     override;
     {-}
   function Mul(const aRange: Im3DBRange): Im3DBRange; override;
  public
   constructor Create(aDB: Tm3PrimDB; const aList: Im3StorageElementIDList);
     reintroduce;
     overload;
     {-}
   class function Make(aDB: Tm3PrimDB; const aList: Im3StorageElementIDList): Im3DBRange;
     reintroduce;
     overload;
  end;

  Tm3BaseParametricRange = class(Tm3BaseRange, Im3BaseRangeParamsSource)
   private
    // internal fields
    f_Params  : Tm3BaseRangeParams;
    f_IndexID : Integer;
  protected
    function Iterate(anAction : Tm3DocumentAction; aParts : Tm3DocPartSet): Integer;
      //overload;
      override;
        {-}
    // Im3DBRange
    function Mul(const aRange: Im3DBRange): Im3DBRange; override;
        {-}
    // interface methods
    // Im3BaseRangeParamsSource
    function pm_GetParams: Tm3BaseRangeParams;
    procedure pm_SetParams(aValue: Tm3BaseRangeParams);
  public
    // public methods
    constructor Create(aDB : Tm3PrimDB; aParams : Tm3BaseRangeParams; anIndexID : Integer);
      reintroduce;
      overload;
        {-}
    class function Make(aDB : Tm3PrimDB; aParams : Tm3BaseRangeParams = []; anIndexID : Integer = 1): Im3DBRange;
      reintroduce;
      overload;
  end;

  Tm3BiCompBaseRange = class(Tm3BaseParametricRange)
    private
    // internal fields
      f_NotEmpty : Boolean;
      f_Level    : Integer;
    protected
    // interface methods
      function Iterate(anAction : Tm3FilerAction;
                       aParts   : Tm3DocPartSet): Integer;
        override;
        {-}
    public
    // public methods
      constructor Create(aDB       : Tm3PrimDB;
                         aParams   : Tm3BaseRangeParams;
                         aNotEmpty : Boolean;
                         aLevel    : Integer);
        overload;
        {-}
      class function Make(aDB       : Tm3PrimDB;
                          aParams   : Tm3BaseRangeParams;
                          aNotEmpty : Boolean;
                          aLevel    : Integer): Im3DBRange;
        overload;
        {-}
  end;//Tm3BiCompBaseRange

function Tm3BaseRange.Iterate(const aFilter : Im3TagGenerator;
                              aNeedWriteToBase : Boolean;
                              aParts  : Tm3DocPartSet): Integer;
  {-}
{$IfNDef m3NoEVD}  
var
 l_DocIDSource    : Il3DocIDSource;
 l_EvdReader      : Tk2CustomFileReader;
 l_ProgressSource : Il3ProgressSource;
 l_OutFiler       : Tm3DBFiler;
 
  function DoFiler(aFiler: Tl3CustomFiler; const anIndex : Tm3DBStreamIndex): Boolean;
  var
   l_Num: Integer;
  begin//DoFiler
   Result := true;
   if (l_ProgressSource <> nil) then
   begin
    l_ProgressSource.Progress := aFiler.Indicator;
    l_ProgressSource := nil;
   end;//l_ProgressSource <> ni
   if (l_DocIDSource <> nil) then
    l_DocIDSource.DocID := aFiler.Handle;
   if aNeedWriteToBase then
   begin
    l_OutFiler.PartSelector := anIndex.rPart;
    l_OutFiler.ObjectIndex  := anIndex.rIdx;
    l_OutFiler.Handle       := anIndex.rID;
    l_OutFiler.Open;
   end;//aNeedWriteToBase
   try
    l_EvdReader.Filer := aFiler;
    try
     try
      l_EvdReader.Execute;
     except
      on E: Exception do
      begin
       l_EvdReader.Generator.Rollback;
       l3System.Msg2Log('[%d:%s] ERROR', [anIndex.rID, m3_cDocPartName[anIndex.rPart]]);
       if E is El3AbortLoadFilter then
         raise;
       l_EvdReader.Generator.Start;
      end;//on E: Exception
     end;//try..except
    finally
     l_EvdReader.Filer := nil;
    end;//try..finally
   finally
    if aNeedWriteToBase then
     l_OutFiler.Close;
   end;//try..finally
  end;//DoFiler

var
 l_Writer : Tk2CustomFileGenerator;
begin
 l_EvdReader := Tk2EVDReaderService.Instance.GetReader;
 try
  Supports(aFilter, Il3DocIDSource, l_DocIDSource);
  l_EvdReader.Generator := aFilter;
  l_OutFiler := nil;
  try
   l_Writer := nil;
   try
    if aNeedWriteToBase then
    begin
     l_Writer := Tk2EVDWriterService.Instance.GetWriter;
     l_OutFiler := Tm3DBFiler.Create(f_DB.AsDB);
     l_OutFiler.Mode := l3_fmWrite;
     l_Writer.Filer := l_OutFiler;
     l_EvdReader.Link(l_Writer);
    end;//aNeedWriteToBase
    try
     l_EvdReader.Start;
//     try  // Грязный хак чтобы ExceptObject продолжал жить
      Supports(aFilter, Il3ProgressSource, l_ProgressSource);
      try
      Result := IterateF(m3L2FilerAction(@DoFiler), aParts);
      except   // Грязный хак чтобы ExceptObject продолжал жить
//        on E: Exception do
//        begin
          l_EvdReader.Finish(True);
          raise;
//        end;
      end;
//     finally   // Грязный хак чтобы ExceptObject продолжал жить
      l_EvdReader.Finish;
//     end;//try..finally
    finally
     l_EvdReader.Unlink(l_Writer);
    end;//try..finally
    l_EvdReader.Generator := nil;
   finally
    FreeAndNil(l_Writer);
   end;//try..finally
  finally
   FreeAndNil(l_OutFiler);
  end;//try..finally
 finally
  FreeAndNil(l_EvdReader);
 end;//try..finally
end;
{$Else  m3NoEVD}
begin
 Assert(false);
 Result := -1;
end;
{$EndIf m3NoEVD}

function Tm3BaseRange.IterateF(anAction : Tm3FilerAction;
                               aParts   : Tm3DocPartSet = m3_AllDocParts): Integer;
  {-}
begin
 try
  Result := Iterate(anAction, aParts);
 finally
  m3FreeFilerAction(anAction);
 end;//try..finally
end;

function Tm3BaseRange.IterateF(anAction : Tm3DocumentAction;
                               aParts   : Tm3DocPartSet = m3_AllDocParts): Integer;
  //overload;
  {-}
begin
 try
  Result := Iterate(anAction, aParts);
 finally
  m3FreeDocumentAction(anAction);
 end;//try..finally
end;

function Tm3BaseRange.CopyTo(const aDB : Im3DB;
                             aMode     : Tm3DBCopyMode = m3_cmRewrite;
                             aParts    : Tm3DocPartSet = m3_AllDocParts): Boolean;
  {-}

var
 l_Done : Boolean absolute Result;

 function DoDoc(const aDocIn : Im3DBDocumentPart;
                      const anIndex : Tm3DBStreamIndex): Boolean;
 var
  l_DocOut    : Im3DBDocumentPart;
  l_Document  : Im3DBDocument;
  l_Stream    : IStream;
  l_VerStream : IStream;
  l_Read      : Int64;
  l_Written   : Int64;
 begin//DoDoc
  Result := true;
  try
   l_Document := aDB.GetDocument(aDocIn.Document.ID);
   if (l_Document <> nil) then
    try
     l_DocOut := l_Document.GetVersion;
     if (aMode <> m3_cmRewrite) then
     begin
      l_Stream := l_DocOut.Open(m3_saRead, anIndex.rPart, anIndex.rIdx);
      if (l_Stream <> nil) then
      begin
       if (aMode = m3_cmRewriteEmpty) then
       begin
        if (m2COMGetSize(l_Stream) = 0) then
         l_Stream := nil
        else
        begin
         l_Stream := nil;
         Exit;
        end;//m2COMGetSize(l_Stream) = 0
       end
       else
       begin
        l_Stream := nil;
        Exit;
       end;//aMode = m3_cmRewriteEmpty
      end;//l_NewStream <> nil
     end;//not aRewrite
     l_Stream := l_DocOut.Open(m3_saReadWrite, anIndex.rPart, anIndex.rIdx);
     if (l_Stream <> nil) then
      try
       l_VerStream := aDocIn.Open(m3_saRead, anIndex.rPart, anIndex.rIdx);
       if (l_VerStream <> nil) then
        try
         l_VerStream.Seek(0, STREAM_SEEK_SET, l_Read);
         l_VerStream.CopyTo(l_Stream, High(Int64), l_Read, l_Written);
        finally
         l_VerStream := nil;
        end;//try..finally
      finally
       l_Stream := nil;
      end;//try..finally
    finally
     l_Document := nil;
    end;//try..finally
  except
   on E: Exception do
   begin
    l_Done := false;
    l3System.Exception2Log(E);
    l3System.Msg2Log(Format('DocID = %d', [aDocIn.Document.ID]));
   end;//on E: Exception
  end;//try..except
 end;//DoDoc

begin
 Result := false;
 if (f_DB <> nil) then
 begin
  if (aDB <> nil) then
  begin
   f_DB.Start(m3_saRead);
   try
    aDB.Start(m3_saReadWrite);
    try
     try
      Result := true;
      // - будем оптимистами
      IterateF(m3L2DocumentAction(@DoDoc), aParts);
     except
      on E: Exception do
      begin
       l3System.Exception2Log(E);
       Result := false;
      end;//on E: Exception
     end;//try..except
    finally
     aDB.Finish;
    end;//try..finally
   finally
    f_DB.Finish;
   end;//try..finally
  end;//aDB <> nil
 end;//f_DB <> nil
end;

function Tm3BaseRange.LastElapsed: TDateTime;
  {-}
begin
 if (f_DB = nil) then
  Result := 0
 else
  Result := f_DB.LastElapsed;
end;

const
  cIterateMsg = 'Перебор файлов';

// start class Tm3NewBaseRange

constructor Tm3BiCompBaseRange.Create(aDB       : Tm3PrimDB;
                                      aParams   : Tm3BaseRangeParams;
                                      aNotEmpty : Boolean;
                                      aLevel    : Integer);
  //overload;
  {-}
begin
 Create(aDB, aParams, 1);
 f_Level := aLevel;
end;

class function Tm3BiCompBaseRange.Make(aDB       : Tm3PrimDB;
                                       aParams   : Tm3BaseRangeParams;
                                       aNotEmpty : Boolean;
                                       aLevel    : Integer): Im3DBRange;
  //overload;
  {-}
var
 l_Part : Tm3BiCompBaseRange;
begin
 l_Part := Create(aDB, aParams, aNotEmpty, aLevel);
 try
  Result := l_Part;
 finally
  FreeAndNil(l_Part);
 end;//try..finally
end;

function Tm3BiCompBaseRange.Iterate(anAction : Tm3FilerAction;
                                 aParts   : Tm3DocPartSet): Integer;
  //override;
  {-}
var
 l_Filer  : Tl3CustomFiler;
 l_Count  : Integer absolute Result;
 l_Summ   : Tm3BaseSummary;

 procedure IterateDocumentsInBase(const aBase : Im3IndexedStorage);
   {* - перебрать версии всех документов. }

  function DoDocument(const aStoreInfo: Tm3StoreInfo; aDocID: Integer): Boolean;

  var
   l_Doc  : Im3DBDocument;

   function DoDocumentStream(const aStream : IStream;
                             const anIndex : Tm3DBStreamIndex): Boolean;
   var
    l_Size    : Int64;
    l_DocPart : Im3DBDocumentPart;
    l_DoFile  : Boolean;
   begin//DoDocumentStream
    with f_DB do
     if Stopped then
      Result := false
     else
     begin
      l_DoFile := true;
      if (m3_brpIndexed in f_Params) then
      begin
       l_DocPart := nil;
       if (m3_brpModified in f_Params) then
        l_DocPart := l_Doc.GetVersion;
       if (l_DocPart = nil) then
        l_DocPart := l_Doc.GetConst;
       if (l_DocPart.Info.rIndexID <> f_IndexID) then
        l_DoFile := false;
      end;//m3_brpIndexed in f_Params
      if Assigned(FilesProcessed) AND (anIndex.rID mod 50 = 0) then
       FilesProcessed(anIndex.rID);
      if Assigned(FilesProcessedEx) AND (anIndex.rID mod 1000 = 0) then
       FilesProcessedEx(anIndex.rID, l_Summ.rMax, LastElapsed);
      if l_DoFile then
      begin
       try
        l_Filer.Handle := anIndex.rID;
        l_Filer.COMStream := aStream;
        try
         l_Size := l_Filer.Size;
         if Assigned(FilesMeter) then
          FilesMeter(piCurrent,
                       anIndex.rID,
                       IntToStr(anIndex.rID) + '/' + IntToStr(l_Size));
         Yield;

         Result := anAction(l_Filer, anIndex);
         if Result then
          Inc(l_Count);
        finally
         l_Filer.COMStream := nil;
        end;//try..finally
       except
         on E: Exception do
         begin
          l3System.Msg2Log('Error iterating ID = %d (%s)', [anIndex.rID, E.Message]);
          Result := True; // чтобы на этом обработка не останавливалась
         end; 
       end;
      end//l_DoFile
      else
      begin
       if Assigned(FilesMeter) then
        FilesMeter(piCurrent,
                     anIndex.rID,
                     IntToStr(anIndex.rID) + '/' + IntToStr(0));
       Yield;
       Result := true;
      end;//l_DoFile
     end;//Stopped
    if not Result then
     DoDocument := false;
   end;//DoDocumentStream

  var
   l_StreamSelector : Tm3DocPartSelector;
   l_S              : IStream;
   l_Part           : Im3DBDocumentPart;
  begin//DoDocument
   Result := true;
   l_Doc := f_DB.AsDB.GetDocument(aDocID);
   try
    try
     for l_StreamSelector := Low(Tm3DocPartSelector) to High(Tm3DocPartSelector) do
     begin
      if not Result then
       break;
      if (l_StreamSelector in aParts) then
      begin
       if (l_StreamSelector = m3_dsObject) then
       begin
        try
         f_DB.IterateObjectsInDocF(aDocID, false, m3L2DBStreamAction(@DoDocumentStream), m3_brpModified in f_Params)
        except
         on E : Exception do
          l3System.Exception2Log(E);
        end;//try..except
       end//l_StreamSelector = m3_dsObject
       else
       begin
        if (m3_brpModified in f_Params) then
         l_Part := l_Doc.GetVersion;
        try
         if (m3_brpModified in f_Params) then
          l_S := l_Part.Open(m3_saRead, l_StreamSelector)
         else
          l_S := l_Doc.Open(m3_saRead, l_StreamSelector);
         try
          if (l_S <> nil) then
           if not DoDocumentStream(l_S, Tm3DBStreamIndex_C(aDocID, l_StreamSelector)) then
            Result := false;
         finally
          l_S := nil;
         end;//try..finally
        finally
         l_Part := nil;
        end;//try..finally
       end;//l_StreamSelector = m3_dsObject
      end;//l_StreamSelector in aParts
     end;//for l_Part
    except
     on E: Exception do
     begin
      l3System.Exception2Log(E);
      l3System.Msg2Log(Format('DocID = %d', [l_Doc.ID]));
     end;//on E: Exception
    end;
   finally
    l_Doc := nil;
   end;//try..finally
  end;//DoDocument

 begin//IterateDocumentsInBase
  if (aBase <> nil) then
   aBase.IterateIndexedF(L2Mm3StorageIteratorsIterateIndexedFAction(@DoDocument));
   // - перебираем хранилища с версиями документов
 end;//IterateDocumentsInBase

var
 l_Versions : Im3IndexedStorage;
 l_Main     : Im3IndexedStorage;
begin
 Result := 0;
 if (f_DB <> nil) then
 begin
  l_Filer := Tl3CustomFiler.Create;
  try
   with f_DB do
   begin
    Start(m3_saRead);
    try
     TuneFiler(l_Filer);
     if (m3_brpModified in f_Params) then
     begin
      l_Versions := GetVersionsStorage(m3_saRead);
      try
       m3GetBaseSummary(l_Versions, l_Summ);
       if Assigned(FilesMeter) then
        FilesMeter(piStart, l_Summ.rMax, cIterateMsg);
       try
        IterateDocumentsInBase(l_Versions);
       finally
        if Assigned(FilesMeter) then
         FilesMeter(piEnd, 0, '');
       end;//try..finally
      finally
       l_Versions := nil;
      end;//try..finally
     end//m3_brpModified in f_Params
     else
     begin
      l_Main := MainStorage(m3_saRead);
      try
       m3GetBaseSummary(l_Main, l_Summ);
       if Assigned(FilesMeter) then
        FilesMeter(piStart, l_Summ.rMax, cIterateMsg);
       try
        if (l_Main <> nil) then
         IterateDocumentsInBase(l_Main);
       finally
        if Assigned(FilesMeter) then
         FilesMeter(piEnd, 0, '');
       end;//try..finally
      finally
       l_Main := nil;
      end;//try..finally
     end;//m3_brpModified in f_Params
     Yield;
    finally
     Finish;
    end;//try..finally
   end;//with f_DB
  finally
   FreeAndNil(l_Filer);
  end;//try..finally
 end;//f_DB <> nil
end;

// start class Tm3CustomDB

procedure Tm3CustomDB.BeforeRelease;
  //override;
  {-}
begin
 FlushLists;
 inherited;
end;

procedure Tm3CustomDB.Cleanup;
  //override;
  {-}
begin
 f_Starts := 0;
 CloseBase;
 inherited;
end;

procedure Tm3CustomDB.FreeLists;
  {-}
begin
 FreeAndNil(f_DeletedList_Add);
 FreeAndNil(f_DeletedList_Del);
 FreeAndNil(f_ModifiedList_Add);
 FreeAndNil(f_ModifiedList_Del);
end;

procedure Tm3CustomDB.Release;
begin
 FreeLists;
 Inherited;
end;

procedure Tm3CustomDB.LoadList(const aName: AnsiString; aList: Tl3LongintList);
  {-}
var
 l_Stream : IStream;
begin
 l_Stream := OpenList(aName, m3_saRead, False);
 if (l_Stream <> nil) then
  try
   aList.LoadFromStream(l_Stream, False);
  finally
   l_Stream := nil;
  end;//try..finally
end;

procedure Tm3CustomDB.SaveList(const aName: AnsiString; aList: Tl3LongintList);
  {-}
var
 l_Stream : IStream;
begin
 l_Stream := OpenList(aName, m3_saReadWrite, True);
 if (l_Stream <> nil) then
  try
   aList.SaveToStream(l_Stream);
  finally
   l_Stream := nil;
  end;//try..finally
end;

procedure Tm3CustomDB.SetList(aListSelector : Tm3CommonListSelector; anID: Integer; aInsert: Boolean);

// - все модифицированные (добавленные в f_ModifiedList_Add) подлежат удалению из f_DeletedList
// - все удаленные доки (добавленные в f_DeletedList_Add) подлежат удалению из f_ModifiedList

procedure AddToList(var aList : Tl3LongintList; anID : Integer);
var
 l_Index : Integer;
begin
 if aList = nil then
  aList := Tl3LongintList.MakeSorted;

 if not aList.FindData(anID, l_Index) then
  aList.Insert(l_Index, anID);
end;

procedure DelFromList(aList : Tl3LongintList; anID : Integer);
var
 l_Index : Integer;
begin
 if aList <> nil then
  if aList.FindData(anID, l_Index) then
   aList.Delete(l_Index);
end;

var
 lAddList : ^Tl3LongintList;
 lDelList : ^Tl3LongintList;

begin
 case aListSelector of
  clsDeleted :
   begin
    lAddList := @f_DeletedList_Add;
    lDelList := @f_DeletedList_Del;
   end;

  clsModified :
   begin
    lAddList := @f_ModifiedList_Add;
    lDelList := @f_ModifiedList_Del;
   end;
  else
   begin
    lAddList := nil;
    lDelList := nil;
    Assert(false)
   end;//else
 end;

 if aInsert then
 begin
  AddToList(lAddList^, anID);
  DelFromList(lDelList^, anID);

  // - все удаленные доки (добавленные в f_DeletedList_Add) подлежат удалению из f_ModifiedList
  if aListSelector = clsDeleted then
   SetList(clsModified, anID, False {aInsert});
  // - все модифицированные (добавленные в f_ModifiedList_Add) подлежат удалению из f_DeletedList
  if aListSelector = clsModified then
   SetList(clsDeleted, anID, False {aInsert});
 end
 else
 begin
  AddToList(lDelList^, anID);
  DelFromList(lAddList^, anID);
 end;//aInsert
end;

function Tm3CustomDB.MakeCommonList(aListSelector : Tm3CommonListSelector): Tl3LongintList;
begin
 FlushLists;
 Result := Tl3LongintList.MakeSorted;
 LoadList(cCommonListName[aListSelector], Result);
end;

function Tm3CustomDB.DeletedFiles: Tl3LongintList;
  {-}
begin
 if (f_DeletedFiles = nil) then
  f_DeletedFiles := MakeCommonList(clsDeleted);
 Result := f_DeletedFiles;
end;

procedure Tm3CustomDB.ModifyDeleted(anID: Integer; aInsert: Boolean);
begin
 SetList(clsDeleted, anID, aInsert);
end;

procedure Tm3CustomDB.ModifyModified(anID: Integer);
begin
 SetList(clsModified, anID, true);
end;

const
 cBackupExt = '_bkp';

procedure Tm3CustomDB.DeleteVersionOnly;
  {-}
var
 l_S : AnsiString;
begin
 CloseBase;
 FreeLists;
 l_S := ChangeFileExt(BaseName, m3_cExchangeExt);
 Tm3StorageManager.DeleteStorageFile(l_S);
end;

procedure Tm3CustomDB.DeleteBackupOnlyPrim;
  {-}
var
 l_S : AnsiString;
begin
 l_S := ChangeFileExt(BaseName, cBackupExt + m3_cExchangeExt);
 Tm3StorageManager.DeleteStorageFile(l_S);
end;

procedure Tm3CustomDB.DeleteBackupOnly;
  {-}
var
 l_S : AnsiString;
begin
 CloseBase;
 FreeLists;
 DeleteBackupOnlyPrim;
end;

procedure Tm3CustomDB.DeleteVersion;
  {-}
begin
 DeleteVersionOnly;
 DeleteBackupOnly
end;

function Tm3CustomDB.CompareVersionWithBackup: Boolean;

 function __CompareStream(const anInStorage          : Im3IndexedStorage;
                          const aStoreInfo : Tm3StorageElementInfo;
                          const aStorage   : Im3IndexedStorage): Boolean;
 var
  l_S1 : IStream;
  l_S2 : IStream;
 begin
  try
   l_S1 := m3COMOpenStream(AStorage, aStoreInfo.rName, m3_saRead, False);
  except
   l_S1 := nil;
  end;//try..except
  l_S2 := anInStorage.OpenStore(aStoreInfo, m3_saRead, true).rStream;
  if (l_S1 = nil) OR (l_S2 = nil) then
  begin
   Result := false;
   l3System.Msg2Log('Один из потоков для сравнения пустой ' + l3Str(aStoreInfo.rName));
   Exit;
  end;//(l_S1 = nil) OR (l_S2 = nil)
  if (l3Str(aStoreInfo.rName) = Format(m3IndexPrefixFormatStr, [0])) then
  // - не сравниваем потоки где лежит время
   Result := (m2COMGetSize(l_S1) = m2COMGetSize(l_S2))
  else
   Result := l3CompareStreams(l_S1,
                              l_S2,
                              #0{'%'});
 end;

var
 l_Summ   : Tm3BaseSummary;
 
 function __CompareStorage(const anInStorage          : Im3IndexedStorage;
                         const aStoreInfo : Tm3StorageElementInfo;
                         const AStorage             : Im3IndexedStorage): Boolean; forward;

 function CompareStorage(const A: Im3IndexedStorage;
                         const B: Im3IndexedStorage): Boolean;

 var
  l_Result : Boolean absolute Result;
  l_Index  : Integer;

  function CheckElement(const aStoreInfo : Tm3StorageElementInfo): Boolean;
  begin//CheckElement
   Result := true;
   case aStoreInfo.rInfo.rStoreType of
    m3_stStorage:
    begin
     if Assigned(FilesMeter) then
     begin
      FilesMeter(piCurrent, Min(l_Index, l_Summ.rMax), l3Str(aStoreInfo.rName));
      Yield;
     end;//Assigned(f_FilesMeter)
     if Assigned(FilesProcessed) then
      if (l_Index mod 50 = 0) then
       FilesProcessed(l_Index);
     if not __CompareStorage(A, aStoreInfo, B) then
     begin
      //Result := false;
      l_Result := false;
      l3System.Msg2Log('Не совпадают хранилища ' + l3Str(aStoreInfo.rName));
     end;//not __CompareStorage
    end;//m3_stStorage
    m3_stStream:
    begin
     if not __CompareStream(A, aStoreInfo, B) then
     begin
      //Result := false;
      l_Result := false;
      l3System.Msg2Log('Не совпадают потоки ' + l3Str(aStoreInfo.rName));
     end;//not __CompareStream
    end;//m3_stStream
    else
    begin
     l_Result := false;
     l3System.Msg2Log('Странный тип элемента ' + l3Str(aStoreInfo.rName));
    end;//else
   end;//case HandleType
   Inc(l_Index);
   if (l_Index >= l_Summ.rMax) then
    l_Index := l_Summ.rMax div 2;
  end;//CheckElement

 begin
  if (A = nil) OR (B = nil) then
  begin
   Result := false;
   l3System.Msg2Log('Одно из хранилищ для сравнения пустое');
   Exit;
  end;//(A = nil) OR (B = nil)
  Result := true;
  // - будем оптимистами
  l_Index := 1;
  A.IterateAllF(L2Mm3StorageIteratorsIterateAllFAction(@CheckElement));
 end;

 function __CompareStorage(const anInStorage          : Im3IndexedStorage;
                         const aStoreInfo : Tm3StorageElementInfo;
                         const AStorage             : Im3IndexedStorage): Boolean;
 var
  l_S1 : Im3IndexedStorage;
  l_S2 : Im3IndexedStorage;                        
 begin
  try
   l_S1 := m3COMOpenStorage(AStorage, aStoreInfo.rName, m3_saRead, false);
  except
   l_S1 := nil;
  end;//try..except
  l_S2 := anInStorage.OpenStore(aStoreInfo, m3_saRead, true).rStorage;
  if (l_S1 = nil) OR (l_S1 = nil) then
  begin
   Result := false;
   l3System.Msg2Log('Одно из хранилищ для сравнения пустое ' + l3Str(aStoreInfo.rName));
   Exit;
  end;//(l_S1 = nil) OR (l_S1 = nil)
  Result := CompareStorage(l_S1, l_S2);
 end;

var
 l_Versions : Im3IndexedStorage;
 l_Backup  : Im3IndexedStorage;
begin
 Result := true;
 // - будем оптимистами
 CheckExclusive;
 Start(m3_saRead);
 try
  l_Versions := GetVersionsStorage(m3_saRead);
  try
   l_Backup := GetBackupStorage(m3_saRead);
   try
    Assert(l_Versions <> nil);
    //Assert(l_Backup <> nil);
    m3GetBaseSummary(l_Versions, l_Summ);
    if Assigned(FilesMeter) then
     FilesMeter(piStart, l_Summ.rMax, 'Сравнение версий с бекапом');
    try
     Result := CompareStorage(l_Versions, l_Backup);
    finally
     if Assigned(FilesMeter) then
      FilesMeter(piEnd, 0, '');
    end;//try..finally
    if Result then
    begin
     m3GetBaseSummary(l_Backup, l_Summ);
     if Assigned(FilesMeter) then
      FilesMeter(piStart, l_Summ.rMax, 'Сравнение бекапа с версиями');
     try
      Result := CompareStorage(l_Backup, l_Versions);
     finally
      if Assigned(FilesMeter) then
       FilesMeter(piEnd, 0, '');
     end;//try..finally
    end;
   finally
    l_Backup := nil;
   end;//try..finally
  finally
   l_Versions := nil;
  end;//try..finally
 finally
  Finish;
 end;//try..finally
end;

procedure Tm3CustomDB.ExtractMainTo(const aDir: AnsiString);
var
 l_Main : Im3IndexedStorage;
begin
 Start(m3_saRead);
 try
  l_Main := MainStorage(m3_saRead);
  Assert(l_Main <> nil);
  m3ExtractStorage(l_Main, ConcatDirName(aDir, 'main'));
 finally
  Finish;
 end;//try..finally
end;

procedure Tm3CustomDB.ExtractVersionTo(const aDir: AnsiString);
var
 l_Main : Im3IndexedStorage;
begin
 Start(m3_saRead);
 try
  l_Main := GetVersionsStorage(m3_saRead);
  Assert(l_Main <> nil);
  m3ExtractStorage(l_Main, ConcatDirName(aDir, 'version'));
 finally
  Finish;
 end;//try..finally
end;

procedure Tm3CustomDB.ExtractBackupTo(const aDir: AnsiString);
var
 l_Main : Im3IndexedStorage;
begin
 Start(m3_saReadWrite);
 try
  l_Main := GetBackupStorage(m3_saReadWrite);
  Assert(l_Main <> nil);
  m3ExtractStorage(l_Main, ConcatDirName(aDir, 'backup'));
 finally
  Finish;
 end;//try..finally
end;

procedure Tm3CustomDB.CopyBackupToVersion;
var
 l_Versions : Im3IndexedStorage;
 l_Backup  : Im3IndexedStorage;
begin
 CheckExclusive;
 DeleteVersionOnly;
 l_Versions := GetVersionsStorage(m3_saReadWrite);
 try
  l_Backup := GetBackupStorage(m3_saRead);
  try
   Assert(l_Versions <> nil);
   Assert(l_Backup <> nil);
   l_Versions.CopyFrom(l_Backup);
  finally
   l_Backup := nil;
  end;//try..finally
 finally
  l_Versions := nil;
 end;//try..finally
 if not CompareVersionWithBackup then
  l3System.Msg2Log('Переменная часть и бекап - не совпадают');
end;

procedure Tm3CustomDB.CopyVersionToBackup;
var
 l_Versions : Im3IndexedStorage;
 l_Backup  : Im3IndexedStorage;
begin
 CheckExclusive;
 DeleteBackupOnly;
 l_Versions := GetVersionsStorage(m3_saReadWrite);
 try
  l_Backup := GetBackupStorage(m3_saReadWrite);
  try
   Assert(l_Versions <> nil);
   Assert(l_Backup <> nil);
   l_Backup.CopyFrom(l_Versions);
  finally
   l_Backup := nil;
  end;//try..finally
 finally
  l_Versions := nil;
 end;//try..finally
 if not CompareVersionWithBackup then
  l3System.Msg2Log('Переменная часть и бекап - не совпадают');
end;

procedure Tm3CustomDB.CheckExclusive;
  {-}
begin
 Assert(false, 'Данное храниище не умеет работать в монопольном режиме');
end;

procedure Tm3CustomDB.DeleteMain;
  {-}
var
 l_S : AnsiString;
begin
 CloseBase;
 l_S := ChangeFileExt(BaseName, m3_cMainExt);
 Tm3StorageManager.DeleteStorageFile(l_S);
end;

procedure Tm3CustomDB.RenameMain(const aNewName: AnsiString);
var
 l_S1 : AnsiString;
 l_S2 : AnsiString;
begin
 CloseBase;
 l_S1 := ChangeFileExt(BaseName, m3_cMainExt);
 l_S2 := ChangeFileExt(aNewName, m3_cMainExt);
 Tm3StorageManager.RenameStorageFile(l_S1, l_S2);
end;

procedure Tm3CustomDB.RenameBackupOnly(const aNewName: AnsiString);
var
 l_S1 : AnsiString;
 l_S2 : AnsiString;
begin
 l_S1 := ChangeFileExt(BaseName, cBackupExt + m3_cExchangeExt);
 l_S2 := ChangeFileExt(aNewName, cBackupExt + m3_cExchangeExt);
 Tm3StorageManager.RenameStorageFile(l_S1, l_S2);
end;
 
procedure Tm3CustomDB.RenameVersion(const aNewName: AnsiString);
var
 l_S1 : AnsiString;
 l_S2 : AnsiString;
begin
 FlushLists;
 CloseBase;
 FreeLists;
 l_S1 := ChangeFileExt(BaseName, m3_cExchangeExt);
 l_S2 := ChangeFileExt(aNewName, m3_cExchangeExt);
 Tm3StorageManager.RenameStorageFile(l_S1, l_S2);
 RenameBackupOnly(aNewName);
end;

procedure Tm3CustomDB.Rename(const aNewName: AnsiString);
var
 l_S : AnsiString;
begin
 l_S := ChangeFileExt(aNewName, '');
 RenameVersion(l_S);
 RenameMain(l_S);
 f_BaseName := l_S;
end;

procedure Tm3CustomDB.FlushLists;

 procedure FlushOneList(aListSelector : Tm3CommonListSelector; aAddList, aDelList : Tl3LongintList);
 var
  l_List     : Tl3LongintList;
  l_ListName : AnsiString;
  l_NeedSave : Boolean;
  //l_Stream   : IStream;
  //l_Position : Int64;
 begin
  l_List := Tl3LongintList.MakeSorted;
  try
   l_ListName := cCommonListName[aListSelector];

   {Пытался устроить чтение-модификация-запись в одном цикле, без "отпускания"  потока
   к сожалению ничего не получилось, (в пакованном потоке m3_saReadWrite не бывает, непакованный поток вообще не пишет ничего ) 
   надо разбираться с  реализацией на нижнем уровне}
   (* l_Stream := OpenList(l_ListName, m3_saReadWrite);
   if (l_Stream <> nil) then
   try
    l_List.LoadFromStream(l_Stream, False);
    *)
    LoadList(l_ListName, l_List);

    l_NeedSave := false;

    if ((aDelList <> nil) and (aDelList.Count > 0)) then
    begin
     //оставим только те элементы, которые действительно были в списке удаленных, они нам потом понадобятся
     if (aListSelector = clsDeleted) then
      aDelList.IntersectList(l_List); // сейчас aDelList = f_DeletedList_Del

     if l_List.DeleteList(aDelList) then
      l_NeedSave := true;
    end;//((aDelList <> nil) and (aDelList.Count > 0))

    if ((aAddList <> nil) and (aAddList.Count > 0)) then
     if l_List.InsertList(aAddList) then
      l_NeedSave := true;

    // если это ModifiedList то нужно добавить в него восстановленные (Undelete) доки
    // (добавленные в f_DeletedList_Del), но только если только они действительно были в списке удаленных
    // !! не совсем корректно, поскольку удалить и потом восстановить можно и не измененный док,
    // !! но ничего страшного не произойдет, отсутствующий в пременной части док не перетирается при апдейте
    if (aListSelector = clsModified) then
     if l_List.InsertList(f_DeletedList_Del) then
      l_NeedSave := true;

    if l_NeedSave then
     SaveList(l_ListName, l_List);
    (*
    l_Stream.Seek(0, Ord(soBeginning), l_Position);
    l_List.SaveToStream(l_Stream);
   finally
    l_Stream := nil;
   end;//try..finally
    *)
  finally
   FreeAndNil(l_List);
  end;//try..finally
 end;

begin
 if ((f_DeletedList_Add <> nil) and (f_DeletedList_Add.Count > 0)) or
    ((f_DeletedList_Del <> nil) and (f_DeletedList_Del.Count > 0)) or
    ((f_ModifiedList_Add <> nil) and (f_ModifiedList_Add.Count > 0)) or
    ((f_ModifiedList_Del <> nil) and (f_ModifiedList_Del.Count > 0)) then
 begin
  Start(m3_saReadWrite);
  try
   // сначала сливаем Deleted, т к там корректируем f_DeletedList_Del
   if ((f_DeletedList_Add <> nil) and (f_DeletedList_Add.Count > 0)) or
      ((f_DeletedList_Del <> nil) and (f_DeletedList_Del.Count > 0)) then
    FlushOneList(clsDeleted, f_DeletedList_Add, f_DeletedList_Del);

   if ((f_ModifiedList_Add <> nil) and (f_ModifiedList_Add.Count > 0)) or
      ((f_ModifiedList_Del <> nil) and (f_ModifiedList_Del.Count > 0)) then
    FlushOneList(clsModified, f_ModifiedList_Add, f_ModifiedList_Del);

   if (f_DeletedList_Add <> nil)  then
    f_DeletedList_Add.Clear;
   if (f_DeletedList_Del <> nil)  then
    f_DeletedList_Del.Clear;
   if (f_ModifiedList_Add <> nil) then
    f_ModifiedList_Add.Clear;
   if (f_ModifiedList_Del <> nil) then
    f_ModifiedList_Del.Clear;

  finally
   Finish;
  end;//try..finally
 end;
end;

function Tm3CustomDB.AsDB: Im3DB;
begin
 Result := Self;
end;

function Tm3CustomDB.InProcess: Boolean;
  {* с базой идет процесс. }
begin
 Result := (f_Starts > 0);
end;

function Tm3CustomDB.Stopped: Boolean;
  {* - предыдущий процесс был остановлен. }
begin
 Result := f_Stopped;
end;

procedure Tm3CustomDB.Stop;
  {* - остановить текущий процесс. }
begin
 f_Stopped := true;
end;

function Tm3CustomDB.LastElapsed: TDateTime;
  {* - время последнего процесса с базой. }
begin
 if (f_Starts = 0) then
  Result := f_Elapsed
 else
  Result := Now - f_Elapsed;
end;

procedure Tm3CustomDB.TuneFiler(aFiler: Tl3CustomFiler);
  {-}
begin
 if (aFiler <> nil) then
 begin
  aFiler.Indicator.NeedProgressProc := true;
  aFiler.Indicator.OnProgressProc := Self.FileMeter;
  aFiler.Mode := l3_fmRead;
 end;//aFiler <> nil
end;

procedure Tm3CustomDB.Yield;
  {-}
begin
 if Assigned(f_OnYield) then
  f_OnYield(Self);
end;

constructor Tm3CustomDB.Create(const aBaseName   : AnsiString;
                         aOnYield          : TNotifyEvent;
                         aFileMeter        : Tl3ProgressProc;
                         aFilesMeter       : Tl3ProgressProc;
                         aFilesProcessed   : Tm3FilesProcessed;
                         aFilesProcessedEx : Tm3FilesProcessedEx);
  //reintroduce;
  {-}
begin
 inherited Create;
 f_BaseName := aBaseName;
 f_OnYield := aOnYield;
 Self.FileMeter := aFileMeter;
 Self.FilesMeter := aFilesMeter;
 Self.FilesProcessed := aFilesProcessed;
 Self.FilesProcessedEx := aFilesProcessedEx;
end;

class function Tm3CustomDB.Make(const aBaseName   : AnsiString;
                          aOnYield          : TNotifyEvent = nil;
                          aFileMeter        : Tl3ProgressProc = nil;
                          aFilesMeter       : Tl3ProgressProc = nil;
                          aFilesProcessed   : Tm3FilesProcessed = nil;
                          aFilesProcessedEx : Tm3FilesProcessedEx = nil): Im3DB;
  //reintroduce;
  {-}
var
 l_DB : Tm3CustomDB;
begin
 l_DB := Create(aBaseName,
                aOnYield,
                aFileMeter, aFilesMeter,
                aFilesProcessed, aFilesProcessedEx);
 try
  Result := l_DB;
 finally
  FreeAndNil(l_DB);
 end;//try..finally
end;

// start class Tm3DB

procedure Tm3DB.InitFields;
begin
 inherited;
 f_Exclusive := false;
end;

procedure Tm3DB.CheckExclusive;
begin
 if not f_Exclusive then
  raise Exception.Create('База ' + BaseName + ' должна быть открыта в монопольном режиме');
end;

procedure Tm3DB.SetExclusive;
  {-}
begin
 f_Exclusive := true;
end;

procedure Tm3DB.CloseBase;
  //virtual;
  {* - закрывает открытые файлы. }
begin
 f_MainStorageMode := 0;
 f_VersionsStorageMode := 0;
 f_VersionsStorage := nil;
 f_BackupVersionsStorage := nil;
 f_MainStorage := nil;
 FreeAndNil(f_DeletedFiles);
 //l3System.Msg2Log('CloseBase');
end;

class function Tm3DB.MakeExclusive(const aBaseName   : AnsiString;
                          aOnYield          : TNotifyEvent = nil;
                          aFileMeter        : Tl3ProgressProc = nil;
                          aFilesMeter       : Tl3ProgressProc = nil;
                          aFilesProcessed   : Tm3FilesProcessed = nil;
                          aFilesProcessedEx : Tm3FilesProcessedEx = nil): Im3DB;
var
 l_DB : Tm3DB;
begin
 l_DB := Create(aBaseName, aOnYield, aFileMeter, aFilesMeter, aFilesProcessed, aFilesProcessedEx);
 try
  l_DB.SetExclusive;
  Result := l_DB;
 finally
  FreeAndNil(l_DB);
 end;//try..finally
end;

function Tm3DB.OpenList(const aName: AnsiString;
                        aStatStgMode: Integer = m3_saReadWrite;
                        aUseCompression : Boolean = True) : IStream;
var
 l_Fork: Tl3ForkStream;
 l_Version : IStream;
 l_Backup : IStream;
begin
 GetVersionsStorage(aStatStgMode);
 if NeedsFork then
 begin
  if (aStatStgMode = m3_saReadWrite) then
  begin
   l_Version := m3COMOpenStream(VersionsStorage,
                        l3PCharLen(aName),
                        aStatStgMode,
                        aUseCompression);
   l_Backup := m3COMOpenStream(f_BackupVersionsStorage,
                               l3PCharLen(aName),
                               aStatStgMode,
                               aUseCompression);
   if (l_Backup = nil) then
    Result := l_Version
   else
   begin
    l_Fork := Tl3ForkStream.MakeI(l_Version, l_Backup);
    try
     //Result := l3Stream2IStream(l_Fork);
     Result := l_Fork;
    finally
     FreeAndNil(l_Fork);
    end;//try..finally
   end;//l_Backup = nil
   Exit;
  end//aStatStgMode = m3_saReadWrite
 end;//NeedsFork
 Result := m3COMOpenStream(VersionsStorage,
                          l3PCharLen(aName),
                          aStatStgMode,
                          aUseCompression);
end;

procedure Tm3DB.FreeVersions;
  {-}
begin
 VersionsStorage := nil;
end;

function Tm3DB.IndexedFiles(anIndexID: Integer = 1): Im3DBRange;
  {-}
begin
 Result := Tm3BiCompBaseRange.Make(Self, [m3_brpIndexed], anIndexID);
end;

function Tm3DB.ModifiedFiles(aNotEmpty : Boolean = false;
                             aLevel    : Integer = Cm3LastVersion): Im3DBRange;
  {-}
begin
 Result := Tm3BiCompBaseRange.Make(Self, [m3_brpModified], aNotEmpty, aLevel);
end;

function Tm3DB.AllFiles: Im3DBRange;
  {-}
begin
 Result := Tm3BiCompBaseRange.Make(Self, []);
end;

function Tm3DB.FilesInList(const aList: Im3StorageElementIDList): Im3DBRange;
begin
 Result := Tm3DocListRange.Make(Self, aList);
end;

function Tm3DB.Purge: Integer;
  {* - удаляет файлы, помеченные как удаленные. }
var
 l_Base  : Im3IndexedStorage;
 l_Index : Integer;
begin
 Result := 0;
 StartEx(m3_saRead, m3_saReadWrite);
 try
  l_Base := MainStorage(m3_saReadWrite);
  try
   with DeletedFiles do
   begin
    if Assigned(FilesMeter) then
     FilesMeter(piStart, Hi, 'Удаление файлов');
    try
     for l_Index := Lo to Hi do
     begin
      if Assigned(FilesMeter) then
       FilesMeter(piCurrent, l_Index, '');
      if l3IOk(l_Base.DeleteStore(Items[l_Index])) then
       Inc(Result);
     end;//for l_Index
    finally
     if Assigned(FilesMeter) then
      FilesMeter(piEnd, 0, '');
    end;//try..finally
   end;//with DeletedFiles
  finally
   l_Base := nil;
  end;//try..finally
 finally
  Finish;
 end;//try..finally
end;

function Tm3DB.Update(aNotEmpty: Boolean = true; aPurgeDeletedObjects: Boolean = true): Boolean;
  {* - переливает файлы из переменной части в постоянную. }

 procedure PurgeDeletedObjects;

 var
  l_MainBase: Im3IndexedStorage;

  procedure IterateDeletedObjects(const aBase : Im3IndexedStorage);

   function DoVersion(const aStoreInfo: Tm3StoreInfo; anIndex: Integer): Boolean;

    function DoObject(const aStream: IStream;
                      const anIndex: Tm3DBStreamIndex): Boolean;
    var
     l_DocBase    : Im3IndexedStorage;
     l_ObjStorage : Im3IndexedStorage;
    begin//DoObject
     Result := True;
     m3COMSafeOpenStorage(l_MainBase, anIndex.rID, m3_saRead, False, l_DocBase);
     if (l_DocBase <> nil) then
      try
       m3COMSafeOpenStorage(l_DocBase, l3PCharLen(PAnsiChar(m3_cObject)), m3_saReadWrite, False, l_ObjStorage);
       if (l_ObjStorage <> nil) then
        try
         l_ObjStorage.DeleteStore(anIndex.rIdx)
        finally
         l_ObjStorage := nil;
        end;//try..finally
      finally
       l_DocBase := nil;
      end;//try..finally
    end;//DoObject 

   begin//DoVersion
    Result := true;
    try
     IterateObjectsInDocF(anIndex, true, m3L2DBStreamAction(@DoObject), true);
    except
     on E: Exception do
     begin
      l3System.Exception2Log(E);
      l3System.Msg2Log(Format('DocID = %d', [anIndex]));
     end;//on E: Exception
    end;//try..except
   end;//DoVersion

  begin//IterateDeletedObjects
   if (aBase <> nil) then
    aBase.IterateIndexedF(L2Mm3StorageIteratorsIterateIndexedFAction(@DoVersion));
    // - перебираем хранилища с версиями документов
  end;//IterateDeletedObjects

 var
  l_Versions : Im3IndexedStorage;
 begin//PurgeDeletedObjects
  l_MainBase := MainStorage(m3_saRead);
  try
   l_Versions := VersionsStorage;
   if l_Versions <> nil then
    try
     IterateDeletedObjects(l_Versions);
    finally
     l_Versions := nil;
    end;//try..finally
  finally
   l_MainBase := nil;
  end;//try..finally
 end;//PurgeDeletedObjects

var
 l_Done : Boolean absolute Result;

 function DoDoc(const aDocIn : Im3DBDocumentPart;
                const anIndex : Tm3DBStreamIndex): Boolean;
 var
  l_DocOut    : Im3DBDocumentPart;
  l_Document  : Im3DBDocument;
  l_Stream    : IStream;
  l_VerStream : IStream;
  l_Read      : Int64;
  l_Written   : Int64;
 begin//DoDoc
  Result := true;
  try
   l_Document := GetDocument(aDocIn.Document.ID);
   if (l_Document <> nil) then
    try
     l_DocOut := l_Document.GetConst;
     l_Stream := l_DocOut.Open(m3_saReadWrite, anIndex.rPart, anIndex.rIdx);
     if (l_Stream <> nil) then
      try
       l_VerStream := aDocIn.Open(m3_saRead, anIndex.rPart, anIndex.rIdx);
       if (l_VerStream <> nil) then
        try
         l_VerStream.Seek(0, STREAM_SEEK_SET, l_Read);
         l_VerStream.CopyTo(l_Stream, High(Int64), l_Read, l_Written);
        finally
         l_VerStream := nil;
        end;//try..finally
      finally
       l_Stream := nil;
      end;//try..finally
    finally
     l_Document := nil;
    end;//try..finally
  except
   on E: Exception do
   begin
    l_Done := false;
    l3System.Exception2Log(E);
    l3System.Msg2Log(Format('DocID = %d', [aDocIn.Document.ID]));
   end;//on E: Exception
  end;//try..except
 end;//DoDoc

begin
 CheckExclusive;
 if CompareVersionWithBackup then
  l3System.Msg2Log('Переменная часть и бекап - совпали')
 else
  l3System.Msg2Log('Переменная часть и бекап - не совпадают');
 StartEx(m3_saRead, m3_saReadWrite);
 try
  try
   Result := True;
   ModifiedFiles(aNotEmpty).IterateF(m3L2DocumentAction(@DoDoc));
  except
   on E: Exception do
   begin
    l3System.Exception2Log(E);
    Result := false;
   end;//on E: Exception
  end;//try..except
  if aPurgeDeletedObjects then
   PurgeDeletedObjects;
 finally
  Finish;
 end;//try..finally
end;

procedure Tm3DB.Start(aOpenMode : Tm3StoreAccess);
 {* - начинает процесс с базой. }
begin
 if aOpenMode = m3_saRead then
  StartEx(m3_saRead, m3_saRead)
 else
  StartEx(m3_saReadWrite, m3_saRead);
end;

procedure Tm3DB.StartEx(aVersionsMode : Tm3StoreAccess;
                        aConstMode    : Tm3StoreAccess);
  {* - начинает процесс с базой. }
var
 l_TryCount : Integer;
begin
 Inc(f_Starts);
 if (f_Starts = 1) then
 begin
  l_TryCount := 0;
  while (l_TryCount < m3_cMaxTry) do
  begin
   Inc(l_TryCount);
   try
   if (aVersionsMode <> m3_saRead) then
    GetVersionsStorage(aVersionsMode);
   if (aConstMode <> m3_saRead) then
    MainStorage(aConstMode);
   except
    on E: EOleSysError do
    begin
     if (E.ErrorCode = STG_E_LOCKVIOLATION) then
     begin
      CloseBase;
      // - стараемся отпустить всё по-максимуму
      if (l_TryCount >= m3_cMaxTry) then
       raise
      else
      begin
       Sleep(Random(m3_cMaxSleep));
       continue;
      end;//l_TryCount >= m3_cMaxTry
     end//E.ErrorCode = STG_E_LOCKVIOLATION
     else
      raise;
    end;//on E: EOleSysError
   end;//try..excepy
   break;
  end;//while (l_TryCount < m3_cMaxTry)
  f_Stopped := false;
  f_Elapsed := Now;
 end;//f_Starts = 1
end;

procedure Tm3DB.Finish;
  {* - заканчивает процесс с базой. }
begin
 if (f_Starts = 1) then
 begin
  CloseBase;
  f_Elapsed := Now - f_Elapsed;
 end;//f_Starts = 1
 Dec(f_Starts);
end;

function Tm3DB.GetDocument(anID: Integer): Im3DBDocument;
  {* - возвращает документ по номеру. }
begin
 Result := Tm3DBDocument.Make(Self, anID);
end;

function Tm3DB.MainStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
  {-}
  
 function m3GetMainStorage(const aBaseName: AnsiString;
   anExclusive: Boolean;
   aMode: Tm3StoreAccess): Im3IndexedStorage;
 begin
  try
   if anExclusive then
   begin
    if (aMode = m3_saRead) then
     Result := Tm3ReadModeExclusiveStorageManager.MakeInterface(ChangeFileExt(aBaseName, m3_cMainExt))
    else
     Result := Tm3FullModeExclusiveStorageManager.MakeInterface(ChangeFileExt(aBaseName, m3_cMainExt));
   end//anExclusive
   else
   begin
    if (aMode = m3_saRead) then
     Result := {Tm3ReadModeStorageManager}Tm3ConstantStorageManager.MakeInterface(ChangeFileExt(aBaseName, m3_cMainExt))
    else
     Result := Tm3FullModeStorageManager.MakeInterface(ChangeFileExt(aBaseName, m3_cMainExt));
   end;//anExclusive
  except
   on E: EOleSysError do
   begin
    if (E.ErrorCode = STG_E_LOCKVIOLATION) then
     raise
    else
     Result := nil;
   end;//on EOleSysError
  end;//try..except
 end;//m3GetMainStorage

begin
 if (f_MainStorage = nil) OR
    ((f_MainStorageMode <> m3_saReadWrite) AND (aMode = m3_saReadWrite)) then
 begin
  f_MainStorage := nil;
  f_MainStorage := m3GetMainStorage(BaseName, f_Exclusive, aMode);
  f_MainStorageMode := aMode;
  //l3System.Msg2Log('Main');
 end;//f_MainStorage = nil..
 Result := f_MainStorage;
end;

function Tm3DB.NeedCreateVersionsStorage(aMode: Tm3StoreAccess): Boolean;
begin
 if (VersionsStorage = nil) OR
    ((f_VersionsStorageMode <> m3_saReadWrite) AND (aMode = m3_saReadWrite)) then
  Result := true
 else
  Result := false;   
end;

function Tm3DB.GetVersionsStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
  {-}

 function m3GetBackupStorage(const aBaseName: AnsiString;
   anExclusive: Boolean;
   aMode: Tm3StoreAccess): Im3IndexedStorage;
 begin
  try
   if anExclusive then
   begin
    if (aMode = m3_saRead) then
     Result := Tm3ReadModeExclusiveStorageManager.MakeInterface(ChangeFileExt(aBaseName, m3_cExchangeExt))
    else
     Result := Tm3FullModeBackupExclusiveStorageManager.MakeInterface(ChangeFileExt(aBaseName, m3_cExchangeExt));
   end//anExclusive
   else
   begin
    if (aMode = m3_saRead) then
     Result := Tm3ReadModeBackupStorageManager.MakeInterface(ChangeFileExt(aBaseName, m3_cExchangeExt))
    else
     Result := Tm3FullModeBackupStorageManager.MakeInterface(ChangeFileExt(aBaseName, m3_cExchangeExt));
   end;//anExclusive
  except
   on E: EOleSysError do
   begin
    if (E.ErrorCode = STG_E_LOCKVIOLATION) then
     raise
    else
    begin
     Result := nil;
     l3System.Exception2Log(E);
    end;//else 
   end;//on EOleSysError
   on E: Exception do
   begin
    Result := nil;
    l3System.Exception2Log(E);
    if (aMode <> m3_saRead) then
     raise;
   end;//on E: Exception
   else
    Result := nil;
  end;//try..except
 end;//m3GetBackupStorage

 function m3GetVersionsStorage(const aBaseName: AnsiString;
   anExclusive: Boolean;
   aMode: Tm3StoreAccess): Im3IndexedStorage;
 begin
  try
   if anExclusive then
   begin
    if (aMode = m3_saRead) then
     Result := Tm3ReadModeExclusiveStorageManager.MakeInterface(ChangeFileExt(aBaseName, m3_cExchangeExt))
    else
     Result := Tm3FullModeExclusiveStorageManager.MakeInterface(ChangeFileExt(aBaseName, m3_cExchangeExt));
   end//anExclusive
   else
   begin
    if (aMode = m3_saRead) then
     Result := Tm3ReadModeStorageManager.MakeInterface(ChangeFileExt(aBaseName, m3_cExchangeExt))
    else
     Result := Tm3FullModeStorageManager.MakeInterface(ChangeFileExt(aBaseName, m3_cExchangeExt));
   end;//anExclusive
  except
   on E: EOleSysError do
   begin
    if (E.ErrorCode = STG_E_LOCKVIOLATION) then
     raise
    else
     Result := nil;
   end;//on EOleSysError
  end;//try..except
 end;//m3GetVersionsStorage

 procedure RemoveBadBackup;
 begin//RemoveBadBackup
  f_BackupVersionsStorage := nil;
  try
   RenameBackupOnly(ChangeFileExt(BaseName, '') + '_bad');
  //DeleteBackupOnlyPrim;
  //VersionsStorage := m3GetVersionsStorage(BaseName, f_Exclusive, aMode);
  except
   on E: Exception do
    l3System.Exception2Log(E);
  end;//try..except
 end;//RemoveBadBackup

begin
 if NeedCreateVersionsStorage(aMode) then
 begin
  VersionsStorage := nil;
  f_BackupVersionsStorage := nil;
  VersionsStorage := m3GetVersionsStorage(BaseName, f_Exclusive, aMode);
  //l3System.Msg2Log('Versions');
  if NeedsFork then
  begin
   f_BackupVersionsStorage := nil;
   if (aMode <> m3_saRead) then
   begin
    try
     f_BackupVersionsStorage := m3GetBackupStorage(BaseName + cBackupExt, f_Exclusive, aMode);
    except
     on E: EOleSysError do
     begin
      if (E.ErrorCode <> STG_E_LOCKVIOLATION) then
       RemoveBadBackup;
     end;//on E: EOleSysError
     else
      RemoveBadBackup;
    end;//try..except
    //l3System.Msg2Log('Backup');
   end//aMode <> m3_saRead
   else
   begin
    if f_Exclusive then
     f_BackupVersionsStorage := m3GetBackupStorage(BaseName + cBackupExt, f_Exclusive, aMode)
    else
     f_BackupVersionsStorage := nil;
   end;//aMode <> m3_saRead
  end;//NeedsFork 
  f_VersionsStorageMode := aMode;
 end;//NeedCreateVersionsStorage(aMode)
 Result := VersionsStorage;
end;

function Tm3DB.GetBackupStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
  //override;
  {-}
var
 l_Vers : Im3IndexedStorage;
begin
 l_Vers := GetVersionsStorage(aMode);
 l_Vers := nil;
 if NeedsFork then
  Result := f_BackupVersionsStorage
 else
  Result := nil;
end;
  
procedure Tm3DB.pm_SetVersionsStorage(const Value: Im3IndexedStorage);
begin
 f_VersionsStorage := Value;
 f_BackupVersionsStorage := nil;
end;

function Tm3DB.IsExclusive: Boolean;
begin
 Result := f_Exclusive;
end;

// start class Tm3BaseRange

constructor Tm3BaseParametricRange.Create(aDB : Tm3PrimDB; aParams : Tm3BaseRangeParams; anIndexID : Integer);
  //reintroduce;
  {-}
begin
 inherited Create(aDB);
 f_Params := aParams;
 f_IndexID := anIndexID;
end;

function Tm3BaseParametricRange.Iterate(anAction : Tm3DocumentAction; aParts : Tm3DocPartSet): Integer;
  //overload;
  {-}

 function DoFiler(aFiler: Tl3CustomFiler; const anIndex : Tm3DBStreamIndex): Boolean;
 var
  l_Doc : Im3DBDocumentPart;
 const
  cLevelCalc : array[Boolean] of Longint = (Cm3ConstVersion, Cm3LastVersion);
 begin//DoFiler
  l_Doc := Tm3DBDocumentPart.Make(f_DB,
                                  f_DB.AsDB.GetDocument(aFiler.Handle),
                                  cLevelCalc[m3_brpModified in f_Params], //not (m3_brpModified in f_Params),
                                  aFiler);
  try
   Result := anAction(l_Doc, anIndex);
  finally
    l_Doc := nil;
  end;//try..finally
 end;//DoFiler

begin
 Result := IterateF(m3L2FilerAction(@DoFiler), aParts);
end;

class function Tm3BaseParametricRange.Make(aDB : Tm3PrimDB; aParams : Tm3BaseRangeParams = []; anIndexID : Integer =
    1): Im3DBRange;
  //reintroduce;
  {-}
var
 l_DBR : Tm3BaseRange;
begin
 l_DBR := Create(aDB, aParams, anIndexID);
 try
  Result := l_DBR;
 finally
  FreeAndNil(l_DBR);
 end;//try..finally
end;

function Tm3BaseParametricRange.Mul(const aRange: Im3DBRange): Im3DBRange;
  {-}
var
 l_Params : Im3BaseRangeParamsSource;
begin
 if Supports(aRange, Im3BaseRangeParamsSource, l_Params) then
  try
   Result := Make(f_DB, l_Params.Params + f_Params, f_IndexID);
  finally
   l_Params := nil;
  end
 else
  Result := nil;
end;

function Tm3BaseParametricRange.pm_GetParams: Tm3BaseRangeParams;
  {-}
begin
 Result := f_Params;
end;

procedure Tm3BaseParametricRange.pm_SetParams(aValue: Tm3BaseRangeParams);
  {-}
begin
 f_Params := aValue;
end;


{ Tm3DocListRange }

constructor Tm3DocListRange.Create(aDB: Tm3PrimDB; const aList: Im3StorageElementIDList);
begin
 inherited Create(aDB);
 f_List := aList;
end;

function Tm3DocListRange.Iterate(anAction : Tm3DocumentAction;
                                 aParts   : Tm3DocPartSet): Integer;

 function DoFiler(aFiler: Tl3CustomFiler; const anIndex : Tm3DBStreamIndex): Boolean;
 var
  l_Doc : Im3DBDocumentPart;
 //const
 // cLevelCalc : array[Boolean] of Longint = (Cm3ConstVersion, Cm3LastVersion);
 begin//DoFiler
  l_Doc := Tm3DBDocumentPart.Make(f_DB,
                                  f_DB.AsDB.GetDocument(aFiler.Handle),
                                  Cm3LastVersion,
                                  aFiler);
  try
   Result := anAction(l_Doc, anIndex);
  finally
    l_Doc := nil;
  end;//try..finally
 end;//DoFiler

begin
 Result := IterateF(m3L2FilerAction(@DoFiler), aParts);
end;

function Tm3DocListRange.Iterate(anAction : Tm3FilerAction;
                                 aParts   : Tm3DocPartSet): Integer;
var
 l_Filer  : Tl3CustomFiler;
 l_Doc    : Im3DBDocument;

 function DoDocumentStream(const aStream : IStream;
                           const anIndex : Tm3DBStreamIndex): Boolean;
 var
  l_Size    : Int64;
 begin//DoDocumentStream
  with f_DB do
   if Stopped then
    Result := false
   else
   begin
     l_Filer.Handle := anIndex.rID;
     l_Filer.COMStream := aStream;
     try
      {
      l_Size := l_Filer.Size;
      if Assigned(f_FilesMeter) then
       f_FilesMeter(piCurrent,
                    anIndex.rID,
                    IntToStr(anIndex.rID) + '/' + IntToStr(l_Size));
      Yield;
      }
      Result := anAction(l_Filer, anIndex);
     finally
      l_Filer.COMStream := nil;
     end;//try..finally
   end;//Stopped
 end;//DoDocumentStream

var
 I : Integer;
 l_DocID  : Tm3StorageElementID;
 l_DocPart: Tm3DocPartSelector;
 l_Stream : IStream;
begin
 Result := 0;
 if (f_DB <> nil) and (f_List <> nil) then
 begin
  l_Filer := Tl3CustomFiler.Create;
  try
   with f_DB do
   begin
    Start(m3_saRead);
    try
     TuneFiler(l_Filer);
     if Assigned(FilesMeter) then
      FilesMeter(piStart, f_List.Count, cIterateMsg);
     for I := 0 to f_List.Count - 1 do
     begin
      l_DocID := f_List.Items[I];
      l_Doc := f_DB.AsDB.GetDocument(l_DocID);
      if Assigned(FilesMeter) then
      begin
       FilesMeter(piCurrent, I+1, Format('%d из %d', [I+1, f_List.Count]));
       Yield;
      end;
      for l_DocPart := Low(Tm3DocPartSelector) to High(Tm3DocPartSelector) do
      begin
       if l_DocPart in aParts then
       begin
        if l_DocPart = m3_dsObject then
         f_DB.IterateObjectsInDocF(l_DocID, False, m3L2DBStreamAction(@DoDocumentStream), False)
        else
        begin
         l_Stream := l_Doc.Open(m3_saRead, l_DocPart);
         if l_Stream <> nil then
          DoDocumentStream(l_Stream, Tm3DBStreamIndex_C(l_DocID, l_DocPart));
        end;
       end;
      end;

      if Assigned(FilesProcessed) or Assigned(FilesProcessedEx) then
      begin
       if Assigned(FilesProcessed) then
        FilesProcessed(I+1);
       if Assigned(FilesProcessedEx) then
        FilesProcessedEx(I+1, f_List.Count, LastElapsed);
       Yield;
      end; // if Assigned(f_FilesProcessed) or Assigned(f_FilesProcessedEx)
     end; // for I := 0 to f_List.Count - 1 do
     if Assigned(FilesMeter) then
      FilesMeter(piEnd, 0);
    finally
     Finish;
    end; // try..finally
   end; // with f_DB do
  finally
   FreeAndNil(l_Filer);
  end; // try..finally
 end; // if (f_DB <> nil)
end;

class function Tm3DocListRange.Make(aDB: Tm3PrimDB; const aList: Im3StorageElementIDList): Im3DBRange;
var
 l_Range: Tm3DocListRange;
begin
 l_Range := Tm3DocListRange.Create(aDB, aList);
 try
  Result := l_Range;
 finally
  FreeAndNil(l_Range);
 end;
end;

function Tm3DocListRange.Mul(const aRange: Im3DBRange): Im3DBRange;
begin
 Assert(False, 'Tm3DocListRange.Mul is not implemented');
end;

end.

