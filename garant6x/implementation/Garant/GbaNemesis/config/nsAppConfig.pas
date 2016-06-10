unit nsAppConfig;

(*-----------------------------------------------------------------------------
 Название:   nsAppConfig
 Автор:      М. Морозов.
 Назначение: Отображение и редактирование настроек проекта.
 История:

 $Id: nsAppConfig.pas,v 1.333 2016/05/30 13:49:34 kostitsin Exp $

 $Log: nsAppConfig.pas,v $
 Revision 1.333  2016/05/30 13:49:34  kostitsin
 {requestlink: 623926944 }

 Revision 1.332  2016/04/05 15:38:32  kostitsin
 {requestlink: 620672440 } - По умолчанию - старое основное меню

 Revision 1.331  2016/04/05 11:06:42  kostitsin
 {requestlink: 620672440 } - Переосмыслили позицию настройки в диалоге

 Revision 1.330  2016/03/29 11:02:00  kostitsin
 {requestlink: 620672440 } - Настройки

 Revision 1.329  2016/01/19 11:22:33  kostitsin
 {requestlink: 615698409 }

 Revision 1.328  2016/01/11 13:15:59  kostitsin
 {requestlink: 615114318 }

 Revision 1.327  2015/04/23 10:21:49  lulin
 http://mdp.garant.ru/pages/viewpage.action?pageId=596627087&focusedCommentId=597929314#comment-597929314

 Revision 1.326  2014/12/08 13:06:22  kostitsin
 {requestlink: 580689608 }

 Revision 1.325  2014/10/21 11:15:52  morozov
 {RequestLink: 565841996}

 Revision 1.324  2014/10/13 09:01:04  morozov
 {RequestLink: 565841996}

 Revision 1.323  2014/07/30 08:39:12  morozov
 Вернул настройки подтверждений для "моих документов"

 Revision 1.322  2014/07/24 10:26:24  morozov
 {RequestLink: 340174500}

 Revision 1.321  2014/06/24 06:12:28  morozov
 {RequestLink: 340174500}

 Revision 1.320  2014/06/18 11:22:11  kostitsin
 {requestlink: 513615258 }

 Revision 1.319  2014/05/23 09:36:23  morozov
 {RequestLink: 518765917}

 Revision 1.318  2014/01/14 18:02:07  kostitsin
 {requestlink:507441274}

 Revision 1.317  2013/11/29 12:50:32  kostitsin
 [$372643503]

 Revision 1.316  2013/10/25 13:29:00  morozov
 {RequestLink: 423620375}

 Revision 1.315  2013/10/04 12:12:19  morozov
 {RequestLink: 488606734}

 Revision 1.314  2013/10/04 10:20:03  morozov
 {RequestLink: 488606734}

 Revision 1.313  2013/09/25 17:13:06  lulin
 - рефакторим подписку к настройкам.

 Revision 1.312  2013/09/18 13:47:41  lulin
 {RequestLink:414849897}

 Revision 1.311  2013/09/18 11:46:52  morozov
 {RequestLink: 481440254}

 Revision 1.310  2013/09/17 14:04:50  lulin
 - синхронизируем отображение со значением настройки.

 Revision 1.309  2013/09/12 12:15:02  kostitsin
 [$476838236] - nsConfigurationProperties

 Revision 1.308  2013/09/10 14:22:00  lulin
 - выносим настройку печати из модуля "Документ".

 Revision 1.307  2013/09/10 04:42:55  lulin
 - генерируем ключи для вложенных настроек.

 Revision 1.306  2013/09/09 13:05:11  kostitsin
 [$476838236]

 Revision 1.305  2013/09/05 09:24:03  kostitsin
 [$476838236] - закончил c ddAppConfigTypes

 Revision 1.304  2013/09/03 09:35:30  kostitsin
 [$476838236]

 Revision 1.303  2013/08/28 08:01:24  lulin
 - реорганизуем модель.

 Revision 1.302  2013/08/27 15:28:47  kostitsin
 [$476838236]

 Revision 1.301  2013/08/23 12:58:46  lulin
 {RequestLink:414849897}

 Revision 1.300  2013/08/22 15:35:24  lulin
 {RequestLink:414849897}
 - делаем возможность вкладывать в значения настроек другие настройки.
 - автоматом проставляем связь реализации вложенным настройкам.

 Revision 1.299  2013/08/22 12:15:34  kostitsin
 [$476838236]

 Revision 1.298  2013/08/20 14:44:28  kostitsin
 [$414849897] - перенес "мапу" на модель

 Revision 1.297  2013/08/20 10:33:58  kostitsin
 [$414849897] - настройку шрифта для печати и экспорта необходимо удалить.

 Revision 1.296  2013/08/20 10:07:54  kostitsin
 [$414849897] - новые контролы на форме настройки

 Revision 1.295  2013/07/04 07:41:39  dinishev
 {Requestlink:462555887}

 Revision 1.294  2013/07/02 14:21:32  morozov
 {RequestLink:434744658}

 Revision 1.293  2013/05/24 08:38:30  morozov
 {RequestLink:372641792}

 Revision 1.292  2013/05/23 06:55:39  morozov
 {RequestLink:372641792}

 Revision 1.291  2013/05/13 17:23:47  lulin
 - разборки с упавшими тестами.

 Revision 1.290  2013/04/24 09:35:57  lulin
 - портируем.

 Revision 1.289  2012/09/18 11:19:28  kostitsin
 [$393644295]

 Revision 1.288  2012/05/22 03:52:38  kostitsin
 [$278844315]

 Revision 1.287  2012/05/22 03:08:56  kostitsin
 [$365835680]

 Revision 1.286  2012/05/21 17:09:52  kostitsin
 [$276541294]

 Revision 1.285  2012/05/21 16:51:07  kostitsin
 [$365825806]

 Revision 1.284  2012/05/21 15:06:55  kostitsin
 [$365833331]

 Revision 1.283  2012/04/28 13:10:31  lulin
 {RequestLink:361404275}

 Revision 1.282  2012/04/28 09:52:01  lulin
 {RequestLink:294599518}

 Revision 1.281  2012/04/27 16:00:59  lulin
 {RequestLink:361404275}

 Revision 1.280  2012/04/18 12:42:18  lulin
 {RequestLink:356847447}

 Revision 1.279  2012/04/09 08:41:25  lulin
 {RequestLink:237994598}
 - думаем о VGScene.

 Revision 1.278  2012/04/06 12:41:37  lulin
 {RequestLink:237994598}

 Revision 1.277  2012/04/04 09:03:18  lulin
 {RequestLink:237994598}

 Revision 1.276  2012/03/23 13:04:11  lulin
 - отпиливаем настройки.

 Revision 1.275  2011/12/20 13:48:13  kostitsin
 http://mdp.garant.ru/pages/viewpage.action?pageId=300516302

 Revision 1.274  2011/11/02 15:19:40  lulin
 {RequestLink:265395473}

 Revision 1.273  2011/10/19 08:49:32  lulin
 {RequestLink:278832944}.
 [$294591153].

 Revision 1.272  2011/10/17 10:49:31  lulin
 {RequestLink:268341330}.

 Revision 1.271  2011/09/23 16:38:28  lulin
 {RequestLink:217681331}.

 Revision 1.270  2011/07/28 13:12:24  lulin
 {RequestLink:209585097}.

 Revision 1.269  2011/07/28 08:39:47  lulin
 {RequestLink:275780337}.

 Revision 1.268  2011/07/27 18:18:40  lulin
 {RequestLink:275780337}.

 Revision 1.267  2011/06/28 19:19:59  lulin
 {RequestLink:254944102}.

 Revision 1.266  2011/06/28 17:55:00  lulin
 {RequestLink:254944102}.

 Revision 1.265  2011/06/23 15:32:16  lulin
 {RequestLink:254944102}.

 Revision 1.264  2011/06/17 12:31:51  lulin
 {RequestLink:228688486}.

 Revision 1.263  2011/06/08 16:06:29  lulin
 {RequestLink:267326476}.

 Revision 1.262  2011/06/06 13:10:42  lulin
 {RequestLink:268345098}.
 [$268347311].

 Revision 1.261  2011/05/19 12:19:31  lulin
 {RequestLink:266409354}.

 Revision 1.260  2011/04/04 16:04:20  lulin
 {RequestLink:259175088}.

 Revision 1.259  2011/02/24 18:14:26  vkuprovich
 {RequestLink:254345841}
 Повторный commit, т.к. в прошлый раз пропали изменения

 Revision 1.258  2011/02/24 17:41:32  vkuprovich
 {RequestLink:254345841}
 Для сообщений с .DefaultChoice в настройках выводятся не все варианты выбора

 Revision 1.257  2011/02/15 13:25:25  lulin
 {RequestLink:231670346}.

 Revision 1.256  2011/02/04 15:30:39  lulin
 {RequestLink:252523791}.

 Revision 1.255  2011/01/27 12:16:51  lulin
 {RequestLink:248195582}.
 - избавляемся от развесистых макарон.

 Revision 1.254  2010/12/21 13:27:18  migel
 - add: для настройки "Включить интеграцию с MS Office" пишем и проверяем значение в реестре.

 Revision 1.253  2010/12/21 11:34:05  migel
 - add: настройка "Включить интеграцию с MS Office".

 Revision 1.252  2010/10/11 08:42:38  oman
 - new: {RequestLink:235871729}

 Revision 1.251  2010/09/13 16:00:41  lulin
 {RequestLink:235047275}.

 Revision 1.250  2010/07/15 12:28:41  oman
 - new: Заготовки {RequestLink:226002365}    

 Revision 1.249  2010/04/13 10:18:29  oman
 - new: {RequestLink:185205058}

 Revision 1.248  2010/03/10 19:42:14  lulin
 {RequestLink:196445017}.

 Revision 1.247  2010/03/10 17:50:51  lulin
 {RequestLink:196445017}.

 Revision 1.246  2010/03/10 16:46:43  lulin
 {RequestLink:196445017}.

 Revision 1.245  2010/02/26 13:42:48  oman
 - new: Заготовки {RequestLink:190251273}

 Revision 1.244  2009/12/15 09:16:13  oman
 - new: Заготовка {RequestLink:173933321}

 Revision 1.243  2009/11/09 11:21:14  lulin
 - промежуточный коммит избавления от внутренних операций без параметров.

 Revision 1.242  2009/10/15 06:42:48  oman
 - new: Реализация перманентых настроек {RequestLink:122652464}

 Revision 1.241  2009/10/14 08:06:33  oman
 - new:  {RequestLink:166855015}

 Revision 1.240  2009/09/24 09:25:36  lulin
 [$164594698].

 Revision 1.239  2009/09/23 13:32:45  lulin
 - начинаем перенос модуля Настройки на модель.

 Revision 1.238  2009/09/15 16:33:10  lulin
 - основной модуль мониторингов полностью перенесён на модель.

 Revision 1.237  2009/09/15 12:50:29  lulin
 - сделана фабрика для формы настроек принтера.

 Revision 1.236  2009/07/29 13:09:02  oman
 - new: Настройка конфигурации - {RequestLink:152408792}

 Revision 1.235  2009/07/29 12:27:57  oman
 - new: Настройка конфигурации - {RequestLink:152408792}

 Revision 1.234  2009/06/10 08:48:56  oman
 - new: Показываем в настройках - [$151585826]

 Revision 1.233  2009/06/08 08:18:27  oman
 - new: Показываем настройку - [$140286494]

 Revision 1.232  2009/04/20 15:06:07  oman
 - new: Форма групп в первом приближении - [$127762671]

 Revision 1.231  2009/03/25 16:01:53  lulin
 [$136937722]. Добавляем кнопки, настройки, иконки.

 Revision 1.230  2009/02/19 19:05:04  lulin
 - переносим идентификаторы сообщений.

 Revision 1.229  2009/02/10 19:03:57  lulin
 - <K>: 133891247. Вычищаем морально устаревший модуль.

 Revision 1.228  2009/02/10 15:43:36  lulin
 - <K>: 133891247. Выделяем интерфейсы локализации.

 Revision 1.227  2009/02/10 12:53:46  lulin
 - <K>: 133891247. Выделяем интерфейсы настройки.

 Revision 1.226  2009/01/20 17:03:14  lulin
 - bug fix: <K> 135600354.

 Revision 1.225  2008/12/25 12:20:13  lulin
 - <K>: 121153186.

 Revision 1.224  2008/12/24 19:49:46  lulin
 - <K>: 121153186.

 Revision 1.223  2008/11/07 14:47:44  lulin
 - <K>: 121167570.

 Revision 1.222  2008/10/29 17:14:02  lulin
 - <K>: 121159661.

 Revision 1.221  2008/10/03 11:38:40  lulin
 - bug fix: не собиралось.

 Revision 1.220  2008/09/25 12:26:55  oman
 - fix: Текст сообщения (К-109087200)

 Revision 1.219  2008/07/31 07:01:16  oman
 - new: Разрешаем кнопку ок (K-96481354)

 Revision 1.218  2008/07/31 05:20:17  oman
 K-96481266

 Revision 1.217  2008/07/29 06:17:40  dolgop
 - не собирался проект.

 Revision 1.216  2008/07/22 10:10:20  oman
 - new: Отключение пищалки - настроки (К-103940886)

 Revision 1.215  2008/07/22 09:47:32  oman
 -fix: Переименовали настройки взад (К-103940652)

 Revision 1.214  2008/07/17 12:00:25  oman
 - new: Поддержка сообщений с радиокнопками в настройках (К-103449075)

 Revision 1.213  2008/07/15 14:38:00  lulin
 - <K>: 98828459.

 Revision 1.212  2008/07/15 08:18:23  oman
 - new: Переименовывание выборов (К-96482449)

 Revision 1.211  2008/07/15 08:00:03  oman
 - new: Готовимся к переименовыванию выборов (К-96482449)

 Revision 1.210  2008/06/20 08:39:55  oman
 - fix: Убрали подтверждение (cq29304)

 Revision 1.209  2008/05/15 20:15:33  lulin
 - тотальная чистка.

 Revision 1.208  2008/04/17 05:53:54  mmorozov
 - new: "Экспортировать и печатать списки без вхождений" настраивается для документов и препаратов.

 Revision 1.207  2008/04/10 07:45:34  oman
 - new: запрещаем вкладки (cq28755)

 Revision 1.206  2008/03/26 17:40:22  lulin
 - <K>: 88080899.

 Revision 1.205  2008/03/26 11:37:12  lulin
 - зачистка в рамках <K>: 88080898.

 Revision 1.204  2008/03/26 11:12:48  lulin
 - зачистка в рамках <K>: 88080898.

 Revision 1.203  2008/02/15 12:10:09  oman
 - fix: детерминируем порядок в списках подписчиков

 Revision 1.202  2008/02/13 11:24:02  oman
 Опечатка

 Revision 1.201  2008/02/13 11:15:19  oman
 - new: Настройки для советов дня (cq28223, 16723)

 Revision 1.200  2008/02/04 13:02:45  oman
 - fix: Подтверждения не на той странице (cq28344)

 Revision 1.199  2008/01/31 11:58:40  oman
 - new: Заготовки сообщений  (cq28344, 28328)

 Revision 1.198  2008/01/31 11:37:24  oman
 - new: Спрашиваем перед пересылкой выеделния по почте (cq28346)

 Revision 1.197  2008/01/21 07:18:45  mmorozov
 - new: работа с пользовательскими ссылками на докумени и из документа перенесене на sdsDocInfo, чтобы быть доступной для списка и документа + сопутствующий рефакторинг (в рамках работы над CQ: OIT5-17587);

 Revision 1.196  2008/01/10 07:23:32  oman
 Переход на новый адаптер

 Revision 1.195  2007/12/18 08:51:54  mmorozov
 - bugfix: шаблон был включен дважды (в рамках CQ: OIT5-27823);

 Revision 1.194  2007/12/17 12:42:58  mmorozov
 - rename method (в рамках CQ: OIT5-27823);

 Revision 1.193  2007/12/17 12:22:44  mmorozov
 - уведомления о начале редактирования, а также изменения пользовательских настроек + избавляемся от операции enSystem.opConfigUpdated (в рамках CQ: OIT5-27823);

 Revision 1.192  2007/12/11 07:01:34  mmorozov
 - вызываем родительские обработчики (в рамках CQ: OIT5-27823);

 Revision 1.191  2007/12/10 12:50:58  mmorozov
 - new: реализуем шаблон publisher\subscriber при редактировании настроек, замены настроек (переключения конфигураций), настройке панелей инструментов (в рамках CQ: OIT5-27823);

 Revision 1.190  2007/12/07 16:26:07  lulin
 - переименовываем файл, чтобы не путать с другой библиотекой.

 Revision 1.189  2007/11/15 12:33:42  oman
 - new: Групповые операции для привилегированных пользователей  (cq27255)

 Revision 1.188  2007/10/22 07:45:22  oman
 - new: Настройки для панели задач (cq27155)

 Revision 1.187  2007/09/20 08:24:45  oman
 - fix: Переместили подверждения (cq26746)

 Revision 1.186  2007/09/10 12:00:15  oman
 - fix: Настройки администратора показываем только
  администратору (cq26639)

 Revision 1.185  2007/08/14 19:31:52  lulin
 - оптимизируем очистку памяти.

 Revision 1.184  2007/08/10 13:27:37  oman
 - fix: "Нелогичный диалог" (с) (cq26327)

 Revision 1.183  2007/06/14 14:08:59  oman
 - new: При попытке открыть пустую папку выводим таки
  всплывающее окошко (cq25673)

 Revision 1.182  2007/06/01 12:03:15  oman
 - fix: Запрещаем опцию Ситуации для преемственной ППС (cq25510)

 Revision 1.181  2007/06/01 11:06:47  oman
 - fix: Запрещаем опцию Ситуации для преемственной ППС (cq25510)

 Revision 1.180  2007/05/28 07:58:59  oman
 - fix: Параметры контекстного поиска подравниваем по левому
  краю (cq25414)

 Revision 1.179  2007/05/24 14:13:37  oman
 - new: Мультиоперации в администраторе (удалить, права на консалтинг
  и отключить)  (cq25336)

 Revision 1.178  2007/05/17 14:23:24  oman
 - new: При посылке проверки статуса подключения правовой
  поддержки выводим всплывающее окно (cq25300)

 Revision 1.177  2007/04/20 13:47:16  oman
 - new: Вычищаем старую ППР и старые фильтры - пока из
  редактирования настроек конфигурации (cq25125)

 Revision 1.176  2007/04/13 08:08:08  oman
 - new: Новый реквизит - e-mail и новый гиперлинк - проверка
  подключения к ПП (cq24926, 24416)

 Revision 1.175  2007/04/12 13:30:32  oman
 - new: более наглядная индикация полученного ответа по
  линии Правового консалтинга (cq24493)

 Revision 1.174  2007/04/11 13:00:25  oman
 - fix: Не был реализован абстракный метод (cq25003)

 Revision 1.173  2007/04/10 14:52:09  oman
 cleanup (cq23401)

 Revision 1.172  2007/04/10 13:33:43  oman
 - new: Назойливо предлагаем пользователю оценить консультацию (cq24524)

 Revision 1.171  2007/04/10 09:22:44  oman
 - fix: Подтверждение с галкой не попадало в редактирование
  настроек (cq23405)

 Revision 1.170  2007/04/05 10:22:38  lulin
 - избавляемся от лишних преобразований строк.

 Revision 1.169  2007/04/05 07:58:25  lulin
 - избавляемся от лишних преобразований строк при записи в настройки.

 Revision 1.168  2007/03/28 19:43:06  lulin
 - ЭлПаковский редактор переводим на строки с кодировкой.

 Revision 1.167  2007/03/21 11:54:55  oman
 - выделил фабричную функцию для производства параметров
   контекстной фильтрации

 Revision 1.166  2007/03/21 11:30:38  oman
 - new: добавил нотификацию о переключении конфигураций и возможной смене
  всех настроек

 Revision 1.165  2007/03/21 10:30:52  oman
 - new: Выделил хранителя параметров контекстной фильтрации

 Revision 1.164  2007/03/20 11:57:37  lulin
 - cleanup.

 Revision 1.163  2007/03/20 11:38:20  lulin
 - не теряем кодировку при присваивании заголовков форм и контролов.

 Revision 1.162  2007/03/20 10:52:52  oman
 - fix: Параметры контекстнйо фильтрации определяем без
  nscContextParams

 Revision 1.161  2007/03/19 14:42:23  lulin
 - используем "родной редактор".

 Revision 1.160  2007/03/19 14:34:01  lulin
 - избавляемся от преобразования строк.

 Revision 1.159  2007/03/19 11:35:28  lulin
 - разделяем приведение к строке для форматирования и для исключения.

 Revision 1.158  2007/03/16 12:20:29  lulin
 - переводим на строки с кодировкой.

 Revision 1.157  2007/03/13 13:28:37  oman
 - new: Настроки для _SubPanel редактора (cq24618)

 Revision 1.156  2007/02/28 14:17:46  lulin
 - переводим на строки с кодировкой.

 Revision 1.155  2007/02/13 15:41:44  mmorozov
 - change: настройка форма зоны синхронного просмотра по умолчанию приобрела другой вид и другие формулировки (CQ: OIT5-24379);

 Revision 1.154  2007/02/13 14:33:28  lulin
 - cleanup.

 Revision 1.153  2007/02/13 09:37:50  lulin
 - cleanup.

 Revision 1.152  2007/02/13 09:33:48  lulin
 - переводим на строки с кодировкой.

 Revision 1.151  2007/02/12 16:39:11  lulin
 - переводим на строки с кодировкой.

 Revision 1.150  2007/02/12 09:58:49  lulin
 - bug fix: искажались входные строковые параметры адаптера.

 Revision 1.149  2007/02/10 13:25:59  lulin
 - переводим на строки с кодировкой.

 Revision 1.148  2007/02/09 12:58:27  lulin
 - выделена функция преобразования к входной строке адаптера.

 Revision 1.147  2007/02/08 09:20:40  mmorozov
 - new: показ аннотации в зоне синхронного просмотра (CQ: OIT5-24105);

 Revision 1.146  2007/02/07 19:13:35  lulin
 - переводим мапы на строки с кодировкой.

 Revision 1.145  2007/02/07 17:48:48  lulin
 - избавляемся от копирования строк при чтении из настроек.

 Revision 1.144  2007/02/06 15:20:54  lulin
 - переводим на строки с кодировкой.

 Revision 1.143  2007/01/19 14:36:06  oman
 - new: Локализация библиотек - dd (cq24078)

 Revision 1.142  2007/01/19 09:50:12  oman
 - new: Локализация библиотек - dd (cq24078)

 Revision 1.141  2007/01/18 12:57:24  mmorozov
 - new: Простое основное меню (CQ: OIT5-23939);

 Revision 1.140  2006/12/12 11:57:35  oman
 - fix: Поскольку настройка тулбаров работает только с активной
   конфигурацией - запрещаем при редактировании неактивных
   (cq23863)

 Revision 1.139  2006/12/11 15:53:38  mmorozov
  MERGE WITH B_NEMESIS_6_4;

 Revision 1.135.2.6.2.1  2006/12/11 13:01:22  mmorozov
 - new: вкладка с переводом у прецедента документ (CQ: OIT5-23834);

 Revision 1.138  2006/12/11 09:57:16  oman
 - new: Убраны неактуальные настройки (cq12564)

 Revision 1.137  2006/12/06 08:00:40  lulin
 - везде используем одни и те же метки.

 Revision 1.136  2006/11/03 09:46:03  oman
 Merge with B_NEMESIS_6_4_0

 Revision 1.135.2.6  2006/10/31 16:19:06  oman
 - fix: СКР переведены со строк на типы (cq23213)

 Revision 1.135.2.5  2006/10/26 13:43:38  mmorozov
 - new: локализация (CQ: OIT5-23236);

 Revision 1.135.2.4  2006/10/25 07:54:46  oman
 Готовимся к завершению локализации настроек СКР

 Revision 1.135.2.3  2006/10/25 07:29:56  oman
 Продолжаем избавлятся от StdStr

 Revision 1.135.2.2  2006/10/18 08:36:14  lulin
 - выливаем подсказки для сообщений.

 Revision 1.135.2.1  2006/10/18 08:00:56  lulin
 - заголовок для настроек приобрел общее название.

 Revision 1.135  2006/10/10 13:18:42  oman
 - fix: Мапа для типов СКР. Пока полуживая - не выделено понятие
  "Все документы" и нет четкой типизации, потом надо будет докрутить
   (cq22964)

 Revision 1.134  2006/09/22 09:46:20  oman
 - new: Новые сообщения про оплату консультации + их вынос
  в настройки (cq22681)

 Revision 1.133  2006/09/06 09:45:40  oman
 - fix: Для сообщений с кнопкой OK не сохранялся признак "не
  спрашивать"
 - fix: Не сохранялась конфигурация по умолчанию (cq22457)

 Revision 1.132  2006/07/18 09:08:00  mmorozov
 new: настраиваемая возможность "Экспортировать и печатать списки без вхождений" (CQ: OIT50010826);

 Revision 1.131  2006/06/29 11:56:11  mmorozov
 - change: изменения в связи с поялением типа GblAdapter.TDateTime;

 Revision 1.130  2006/06/20 11:46:23  oman
 - fix: При ошибочных значениях диалог настройки конфигурации
  закрывался, а не должен был (cq21402)

 Revision 1.129  2006/06/09 08:49:19  oman
 - new beh: Галка для уведомления об отправке консультации вынесена
  в настройки конфигурации (cq21285)

 Revision 1.128  2006/06/09 08:28:23  oman
 - fix: Запросы на сохранение/восстановление значений по умолчанию
  для таблицы стилей (cq18958)

 Revision 1.127  2006/05/31 08:25:52  oman
 - fix: При переключении конфигурации не обновлялись шорткаты (cq17830)

 Revision 1.126  2006/05/18 13:45:17  oman
 cleanup

 Revision 1.125  2006/05/04 07:57:26  oman
 - new beh: для комбобоксов при редактирования настроек пользуем мапы значений

 Revision 1.124  2006/05/03 14:25:42  oman
 - change: сведение редактирования настроек к одним воротам
 - new beh: операция "восстановить все" для списка конфигураций (cq20377)

 Revision 1.123  2006/04/25 13:52:28  oman
 - change: Собирание интерфейсов по редактированию настроек в одно место
 - new beh: Интерфейсы по работе с настройками конфигурации и
  списком конфигураций (cq20377)

 Revision 1.122  2006/04/19 11:45:17  oman
 - fix: Были перепутаны мапы для параметров контекстного поиска (cq20545)

 Revision 1.121  2006/04/12 13:15:01  oman
 - change: перевод механизма локализации строк на использование фабрик
 - new beh: Локализация nsc

 Revision 1.120  2006/04/06 11:24:17  oman
 - new beh: Перевод на механизм мап "строка для отображения в UI"-<нечто>.

 Revision 1.119  2006/04/06 06:05:45  oman
 - new beh: В мессагах уделен Key, переименован ShortCaption => _ControlCaption,
  добавлен _ControlHint

 Revision 1.118  2006/04/05 14:52:21  oman
 - new beh: Перевод на механизм мап "строка для отображения в UI"-<нечто>.

 Revision 1.117  2006/04/05 08:51:34  oman
 - new beh: Перевод на механизм мап "строка для отображения в UI"-<нечто>.

 Revision 1.116  2006/04/04 14:03:43  oman
 - new beh: Перевод на механизм мап "строка для отображения в UI"-<нечто>.

 Revision 1.115  2006/04/04 09:23:52  oman
 - new beh: Перевод на механизм мап "строка для отображения в UI"-<нечто>.
 - fix: в масштаб картинки можно было вписать билеберду (cq20204)

 Revision 1.114  2006/04/04 06:33:27  oman
 cleanup

 Revision 1.113  2006/04/03 15:01:27  oman
 - new beh: Перевод на механизм мап "строка для отображения в UI"-<нечто>.

 Revision 1.112  2006/04/03 12:00:17  oman
 - new beh: Реализация механизм мап "строка для отображения в UI"-<нечто>.

 Revision 1.111  2006/03/17 14:15:01  oman
 - cleanup: Устаревшее сообщение из настроек конфигурации

 Revision 1.110  2006/03/17 13:52:11  oman
 - change: Избавляемся от %s в сообщениях, которые приездают не с адаптера

 Revision 1.109  2006/03/16 12:12:53  oman
 - new beh: Перекладываем все текстовые константы в три места (StdStr, DebugStr и SystemStr)

 Revision 1.108  2006/03/16 11:36:00  oman
 - new beh: Перекладываем все текстовые константы в три места (StdStr, DebugStr и SystemStr)

 Revision 1.107  2006/03/10 06:41:35  mmorozov
 - bugfix: не освобождался IConfiguration;

 Revision 1.106  2006/01/18 09:37:46  oman
 - cleanup (убраны не использовавшиеся методы)

 Revision 1.105  2005/12/08 13:33:07  oman
 - fix: возможно текла ссылка IvcmSettings

 Revision 1.104  2005/12/02 08:58:31  oman
 - fix: При переименовании конфигурации не синхронизировалось меню

 Revision 1.103  2005/12/01 12:15:39  oman
 - fix: Название конфигурации не сохранялось при сохранении по умолчнию

 Revision 1.102  2005/11/11 19:40:39  mmorozov
 - _format code;

 Revision 1.101  2005/09/21 08:34:52  dolgop
 - change: изменения, связанные с появлением IString в Settings

 Revision 1.100  2005/06/30 07:48:19  cyberz
 READY FOR TIE-TEMPLATE GENERATION

 Revision 1.99  2005/04/12 12:56:59  demon
 - fix: орфографическая ошибка.

 Revision 1.98  2005/04/12 12:45:37  demon
 - fix: поправлен хинт к настройке Показ вкладки Информация о документе.

 Revision 1.97  2005/04/12 10:18:47  demon
 - new behavior: Вкладка атрибуты и все связанные с ней операции переименованы. Новое имя - Информация о документе.

 Revision 1.96  2005/04/06 12:44:01  am
 change: убрал настройку-подтверждение qr_ListWasSaved

 Revision 1.95  2005/04/06 10:34:00  am
 bugfix: орфография

 Revision 1.94  2005/03/29 07:22:42  am
 change: переместил настройку про вкладку атрибутов

 Revision 1.93  2005/03/25 11:39:36  am
 pi_Document_Sheets_Attributes - настройка "открывать ли атрибуты при открытии документа"

 Revision 1.92  2005/03/24 08:21:15  mmorozov
 new: настройки для выдачи предупреждения при построении автореферата;

 Revision 1.91  2005/03/10 11:42:48  mmorozov
 new: property TnsManagerConfig.IsShowDialog;

 Revision 1.90  2005/03/09 13:47:20  am
 change: в случае равенства настроек пользовательских вкладок тип. корр\респ. не только выкидываем сообщение, но и переключаемся на нужную страницу с настройками

 Revision 1.89  2005/03/09 12:46:49  am
 change: при выборе настройки типа показываемой пользовательской вкладки корр\респ как "не показывать", дизейблим выбор тип. корр\респ.

 Revision 1.88  2005/03/04 12:10:53  am
 change: запрещаем выбирать одинаковые настройки для пользовательских вкладок корр\респ.

 Revision 1.87  2005/03/01 10:38:36  am
 change: настройки для новых вкладок типизированых корр\респ.

 Revision 1.86  2005/02/25 14:46:55  mmorozov
 new: property TnsManagerConfig.ShowDialog;

 Revision 1.85  2005/02/14 12:06:40  mmorozov
 bugfix: орфографическая ошибка;

 Revision 1.84  2005/01/31 06:54:23  mmorozov
 new: настройки для определения плавного скрытия навигатора;

 Revision 1.83  2005/01/30 16:37:00  mmorozov
 change: вместо самостоятельного перебора настроек для определения состояния "изменено" используем ddAppConfig.Changed, которое учитывает все типы элементов;

 Revision 1.82  2005/01/30 14:44:46  mmorozov
 change: управление видимость и положение вкладки "Фильтры" перенесено в раздел "Поведение системы";

 Revision 1.81  2005/01/28 15:33:41  am
 new: подтверждение при перезаписи объекта

 Revision 1.80  2005/01/26 13:01:51  mmorozov
 new: настройки для основного меню выделены в группу;

 Revision 1.79  2005/01/25 08:23:23  mmorozov
 change: captions;

 Revision 1.78  2005/01/21 15:06:11  mmorozov
 new: расшифровки (hint) для параметров контекстной фильтрации;

 Revision 1.77  2005/01/20 14:18:52  mmorozov
 change: _caption;

 Revision 1.76  2005/01/20 12:47:43  mmorozov
 new: выводим сообщение об ошибки при сохранении;

 Revision 1.75  2005/01/17 11:01:01  mmorozov
 - change _caption;

 Revision 1.74  2005/01/17 09:17:36  lulin
 - убраны Warning'и.

 Revision 1.73  2005/01/14 17:22:11  mmorozov
 new: использование для параметров контекстной фильтрации MasterSlaveItem;

 Revision 1.72  2005/01/11 16:22:41  am
 change: Комментарий пользователя - Мой комментарий

 Revision 1.71  2005/01/08 13:46:32  mmorozov
 - _format code;

 Revision 1.70  2005/01/08 11:26:17  mmorozov
 - cleanup code;

 Revision 1.69  2005/01/08 11:24:33  mmorozov
 remove: старая реализация контекстной фильтрации;

 Revision 1.68  2005/01/08 10:35:06  mmorozov
 new: используем cContextParamsTrees для формирования параметров контекстной фильтрации;

 Revision 1.67  2005/01/08 09:29:20  mmorozov
 new: Новый раздел "Контекстная фильтрация";

 Revision 1.66  2004/12/28 12:20:52  mmorozov
 change: settings _caption;

 Revision 1.65  2004/12/28 12:17:07  mmorozov
 change: FreeAndNil -> vcmFree;

 Revision 1.64  2004/12/28 10:31:17  mmorozov
 new: настройки для списков журнала, последних открытых документов и запросов;

 Revision 1.63  2004/12/25 09:35:55  mmorozov
 change: Закладки -> Вкладки;
 change: определения положения вкладки фильтры из поиска и списка документов перенесено в поведение системы;

 Revision 1.62  2004/12/23 08:41:39  lulin
 - вычищен ненужный модуль.

 Revision 1.61  2004/12/17 09:06:53  am
 new: в секции "настройки интерфейса" появилась кнопка "Панели инструментов"

 Revision 1.60  2004/11/24 12:38:00  mmorozov
 change: изменен hint и название настройки qr_StyleTableChanged;

 Revision 1.59  2004/11/15 15:50:54  mmorozov
 add: qr_DropChangeStatusAllObjects (подтверждение сброса статуса изменен со всех объектов);

 Revision 1.58  2004/11/09 13:19:14  mmorozov
 change: идентификатор cFrmIDDictionaryTerm;

 Revision 1.57  2004/10/27 16:21:53  mmorozov
 - изменения в связи с возможностью восстанавливать, записывать по умолчанию "Настройки страницы";

 Revision 1.56  2004/10/26 17:15:37  mmorozov
 new: возможность восстанавливать "Настройки страницы";

 Revision 1.55  2004/10/26 09:36:26  mmorozov
 - синтаксис;

 Revision 1.54  2004/10/25 15:25:02  mmorozov
 new: type TnsHistoryItemsProperty;
 new: определение значения для g_vcmHistoryLimit (элементов в истории);

 Revision 1.53  2004/10/12 12:54:59  demon
 - new behavior: подтверждение выхода из системы добавлено в конфигурацию.

 Revision 1.52  2004/10/07 15:06:07  mmorozov
 new: method Reload;

 Revision 1.51  2004/10/01 14:44:59  am
 change: запрет ввода отрицательных значений в "Поиск/Подтверждения/Спрашивать подтверждение на построение списка после поиска при количестве документов от"

 Revision 1.50  2004/09/30 10:59:22  mmorozov
 change: Оглавление -> Структура документа;

 Revision 1.49  2004/09/30 08:17:20  mmorozov
 change: Положение -> Показывать;

 Revision 1.48  2004/09/27 14:09:58  mmorozov
 new: управление закладками "На контроле", "Термины словаря";

 Revision 1.47  2004/09/17 12:59:06  lulin
 - все что было возможно перевел с _TStrings на IvcmStrings.

 Revision 1.46  2004/09/15 15:16:41  am
 change: убрал настройку рубрикатора

 Revision 1.45  2004/09/15 14:11:39  lulin
 - заменил _TStringList на _TvcmStringList.

 Revision 1.44  2004/09/10 13:58:16  demon
 - fix: удалены избыточные сообщения

 Revision 1.43  2004/09/10 12:34:43  mmorozov
 change: сигнатура _AddComboBoxItem;

 Revision 1.42  2004/09/07 16:22:18  law
 - перевел Nemesis на кешированные обьекты.

 Revision 1.41  2004/08/27 11:21:56  mmorozov
 change: li_Search_ContextFilterType0 -> li_Search_cftAtBegining;
 change: li_Search_ContextFilterType1 -> li_Search_cftAnyPosition;

 Revision 1.40  2004/08/25 09:02:17  mmorozov
 new: реализация в соответствии с новым ТЗ;

 Revision 1.39  2004/08/25 06:41:02  mmorozov
 bugfix: при мапинге подтверждений использовался mrOk вместо mrYes;

 Revision 1.38  2004/08/24 14:32:20  mmorozov
 change: реализация настроек системы в соответствии с ТЗ от УМ;

 Revision 1.37  2004/08/24 12:42:23  mmorozov
 new: работа по новому ТЗ над настройками;

 Revision 1.36  2004/08/24 09:11:41  mmorozov
 new: не доступен выбор языка системы;

----------------------------------------------------------------------------*)

interface

{$Include nsDefine.inc}

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes,
  Forms,
  ExtCtrls,
  StdCtrls,
  Controls,
  SysUtils,

  l3Interfaces,
  l3MessageID,
  l3VCLStrings,

  afwInterfaces,

  vcmBase,
  vcmInterfaces,
  vcmExternalInterfaces,
  vcmMessagesCollectionItem,

  Dialogs,

  ddConfigStorages,
  ddAppConfigConst,
  ddAppConfig,
  ddAppConfigTypes,

  nscComboBox,

  nsConfiguration,

  SettingsUnit,

  InsConfigNotifyRecipientPtrList,
  bsInterfaces,

  ConfigInterfaces,
  vcmGUI
  ;

type
  EDuplicateConfName = class(Exception)
  {* - генерируется при дублировании имени конфигурации. }
  private
  // property fields
    f_ConfName: AnsiString;
  private
  // property methods
    procedure SetConfName(const Value: AnsiString);
      {-}
  public
  // public properties
    property ConfName : AnsiString
      read f_ConfName
      write SetConfName;
      {-}
  end;//EDuplicateConfName

  ECRSettingsAreEqual = class(Exception);

  EConfigNotSaved = class(Exception);

  TnsHistoryItemsProperty = class(TddIntegerConfigItem)
  {* - количество элементов в истории. }
  public
  // public methods
    procedure SaveValue(const aStorage : IddConfigStorage);
      override;
      {* - помимо сохранения настройки установим значене g_vcmHistoryLimit. }
  end;//TnsHistoryItemsProperty

  TnsConfInfoNode = class(TddCustomConfigNode)
  {* - панель информации конфигурации. }
  private
  // internal fields
    f_Frame    : TFrame;
    f_ConfName : TnscComboBox;
    f_ConfHint : TnscComboBox;
    f_Changed  : Boolean;
    f_Config   : Pointer;
  private
  // internal methods
    procedure OnResize(Sender : TObject);
      {* - подгоняем размеры полей ввода. }
    procedure SetEditsWidth;
      {-}
    procedure OnChangeName(Sender : TObject);
      {-}
    procedure OnChangeHint(Sender : TObject);
      {-}
  protected
  // protected
    function pm_GetValue: TddConfigValue;
      override;
      {-}
    procedure Cleanup;
      override;
      {-}
    procedure pm_SetValue(const Value: TddConfigValue);
      override;
      {-}
  public
    constructor Create(const aAlias   : AnsiString;
                       const aCaption : AnsiString;
                       const aConfig  : InsConfigSettingsInfo = nil);
      reintroduce;
      {-}
    procedure DoClearControls;
      override;
      {-}
    function DoCreateFrame(aOwner: TComponent; aTag: Integer): TCustomFrame;
      override;
      {-}
    procedure DoFrameSize(aParent     : TWinControl;
                        out aHeight : Integer;
                        out aWidth  : Integer);
      override;
      {-}
    procedure DoGetControlValues;
      override;
      {-}
    procedure DoLoad(const aStorage: IddConfigStorage);
      override;
      {-}
    procedure DoSave(const aStorage: IddConfigStorage);
      override;
      {-}
    procedure DoSetControlValues(aDefault: Boolean);
      override;
      {-}
    function pm_GetChanged : Boolean;
      override;
      {-}
    procedure pm_SetChanged(Value : Boolean);
      override;
      {-}
    function DoIsItem(aItem : TObject) : Boolean;
     override;
      {-}
  end;//TnsConfInfoNode

  TnsAppConfig = class(TddAppConfiguration)
  {-}
  private
  // properties methods
   function GetIsNeedReinsertForms: Boolean;
    {-}
  public
   function IsSettingsChanged: Boolean;
  public
  // public properties
   property IsNeedReinsertForms : Boolean
       read GetIsNeedReinsertForms;
      {-}
  end;

  InsConfigStorage = interface(IddConfigStorage)
  ['{8247036B-85B8-41D8-A922-12A5883D8197}']
  // private
    function GetDefaultValuesOperation: Boolean;
     {-}
    procedure SetDefaultValuesOperation(const aValue: Boolean);
     {-}
  // public
    property DefaultValuesOperation: Boolean
        read GetDefaultValuesOperation
       write SetDefaultValuesOperation;
     { Все операции делаются со значениями по умолчанию:
       Load - восстановить значения по умолчанию и загрузить
       Save - сохранить и сделать значениями по умолчанию}
  end;//InsConfigStorage

  TnsConfigStorage = class(TvcmCacheableBase, InsConfigStorage)
  {* - производит запись, чтение настроек. }
  private
  // property fields
    f_DefaultValuesOperation: Boolean;
    f_Settings: IvcmSettings;
  private
  // properties methods
    function GetDefaultValuesOperation: Boolean;
    procedure SetDefaultValuesOperation(const aValue: Boolean);
  protected
   procedure Cleanup;
    override;
  public
  // public methods
    constructor Create(const aSettings : IvcmSettings = nil{;
                       anOwner              : TObject = nil});
      reintroduce;
      {-}
    function Get_Section: AnsiString;
      stdcall;
      {-}
    function ReadBool(const Alias: AnsiString; Default: Boolean): Boolean;
      stdcall;
      {-}
    function ReadDateTime(const Alias: AnsiString; Default: System.TDateTime): System.TDateTime;
      stdcall;
      {-}
    function ReadInteger(const Alias: AnsiString; Default: Integer): Integer;
      stdcall;
      {-}
    function ReadString(const Alias: AnsiString; const Default: AnsiString): Il3CString;
      stdcall;
      {-}
    procedure Set_Section(const Value: AnsiString);
      stdcall;
      {-}
    procedure WriteBool(const Alias: AnsiString; B: Boolean);
      stdcall;
      {-}
    procedure WriteDateTime(const Alias: AnsiString; DT: System.TDateTime);
      stdcall;
      {-}
    procedure WriteInteger(const Alias: AnsiString; I: Integer);
      stdcall;
      {-}
    procedure WriteString(const Alias: AnsiString; const S: AnsiString);
      stdcall;
      {-}
  end;//TnsConfigStorage

const
  { navigator form position - "nfp" }

  cnfpLeftNavigator  = 'LeftNavigator';
  cnfpRightNavigator = 'RightNavigator';

  cnfpNavigator = 'vcm_ztNavigator/';
  cnfpZone      = cnfpNavigator + 'Zone';
  cnfpFloating  = cnfpNavigator + 'Floating';

type
  TstgTextSelection = class(TddComboBoxConfigItem)
  {-}
  public
  // public methods
    constructor Create(aMasterItem : TddBaseConfigItem = nil);
      reintroduce;
      {-}
  end;//TstgTextSelection

  TstgShowVersionComments = class(TddComboBoxConfigItem)
  {-}
  public
  // public methods
    constructor Create(aMasterItem : TddBaseConfigItem = nil);
      reintroduce;
      {-}
  end;//TstgShowVersionComments

  TstgShortList = class(TddComboBoxConfigItem)
  {-}
  public
  // public methods
    constructor Create(aMasterItem : TddBaseConfigItem = nil);
      reintroduce;
      {-}
  end;//TstgShortList

  TstgConfirmationItem = class(TddBooleanConfigItem)
  {* - для работы с подтверждениями. "Всегда спрашивать", "Да" перемапируется
       в значения mrNone, mrOk. }
  private
   f_DefaultResult: TModalResult;
  public
  // public methods
    constructor Create(const aAlias, aCaption: AnsiString; aDefaultResult: TModalResult;
      aDefaultValue: TddConfigValue; aMasterItem: TddBaseConfigItem = nil);
      reintroduce;
    procedure LoadValue(const aStorage : IddConfigStorage);
      override;
      {-}
    procedure SaveValue(const aStorage : IddConfigStorage);
      override;
      {-}
  end;//TstgConfirmationItem

  TstgNavigatorFormPosition = class(TddComboBoxConfigItem)
  {* - класс для сохранения позиции форм встраиваемых в область навиагатора. }
  private
  // property fields
    fFloatingValue : Boolean;
    fZoneValue     : Il3CString;
  private
  // property methods
    function GetFloatingSetting: AnsiString;
      {-}
    function GetZoneSetting: AnsiString;
      {-}
    procedure SetFloatingValue(const Value: Boolean);
      {-}
    procedure SetZoneValue(const Value: Il3CString);
      {-}
  protected
  // protected methods
    function GetAliasName : AnsiString;
      virtual;
      {-}
  public
  // public methods
    constructor Create(const aFormSetting : AnsiString;
                       const aCaption     : AnsiString;
                       aMasterItem        : TddBaseConfigItem = nil);
      reintroduce;
      {* - инициализируем значениями. }
    procedure LoadValue(const aStorage : IddConfigStorage);
      override;
      {* - читаем положение формы. }
    procedure SaveValue(const aStorage : IddConfigStorage);
      override;
      {* - пишем положение формы. }
    procedure Cleanup;
      override;
      {-}
  public
  // public properties
    property ZoneSetting : AnsiString
      read GetZoneSetting;
      {-}
    property FloatingSetting : AnsiString
      read GetFloatingSetting;
      {-}
    property FloatingValue : Boolean
      read fFloatingValue
      write SetFloatingValue;
      {-}
    property ZoneValue : Il3CString
      read fZoneValue
      write SetZoneValue;
      {-}
  end;//TstgNavigatorFormPosition

  TstgScalePicture = class(TddComboBoxConfigItem)
  {* - масштаб картинки. }
  private
    f_SavedValue: TddConfigValue;
  // internal methods
    function CheckValue: boolean;
      { Были ли исправлены ошибки: true - ошибки были }
  protected
  // protected methods
    procedure DoExit;
      override;
      {-}
  public
    procedure GetValueFromControl;
     override;
      {-}
    procedure SaveValue(const aStorage: IddConfigStorage);
      override;
      {-}
  public
    constructor Create(aMasterItem : TddBaseConfigItem = nil);
      reintroduce;
      {-}
    procedure LoadValue(const aStorage: IddConfigStorage);
      override;
      {-}
  end;//TstgScalePicture

  TstgFilterFormPosition = class(TstgNavigatorFormPosition)
  protected
  // protected methods
    function GetAliasName : AnsiString;
      override;
      {-}
  end;//TstgFilterFormPosition

  TstgTabbedInterfaceBehaviour = class(TddMapRadioGroupConfigItem)
  protected
   function pm_GetFullControlHeight(aParent: TWinControl): Integer; override;
  public
   constructor Create(const aTabUseCaseSettingsID: AnsiString;
    const aCaption: AnsiString); reintroduce;
  end;

  TnsButtonCaptionArray = array[TMsgDlgBtn] of PvcmStringID;
  PnsButtonCaptionArray = ^TnsButtonCaptionArray;

  _afwSettingChanged_Parent_ = TnsEditSettingsInfo;
  {$Include afwSettingChanged.imp.pas}
  TnsConfigSettingsInfo = class(_afwSettingChanged_,
                                InsConfigSettingsInfo,
                                InsConfigNotificationSource)
  protected
  // IafwSettingListener
    function DoSettingChanged(const aSettingId : TafwSettingId): Boolean;
      override;
      {* - настройки изменились. }
  protected
  // IafwSettingsReplaceListener
    procedure SettingsReplaceFinish;
      override;
      {* - после замены настроек. }
  private
   function pm_GetIsOverallModified: Boolean;
     {-}
   function pm_GetConfigName: Il3CString;
     {-}
   function pm_GetConfigHint: Il3CString;
     {-}
   function pm_GetID: LongInt;
     {-}
   function pm_GetConfiguration: IConfiguration;
     {-}
  public
   procedure RenameConfig(const aName, aHint: Tl3WString);
     {-}
   procedure RestoreAllSettings;
     {-}
   procedure FillDialog(const aForm: IvcmEntityForm;
    aButtonsPanelHeight: Integer);
     {* - заполнить форму редактирования и подключить обработчики. }
   procedure DoneEditing;
    override;
     {* - отключить обработчики. }
   procedure Subscribe(const aSubscriber: InsConfigNotifyRecipient);
     {-}
   procedure Unsubscribe(const aSubscriber: InsConfigNotifyRecipient);
     {-}
  private
  // internal fields
   f_AppConfig: TnsAppConfig;
   f_Storage: InsConfigStorage;
   f_ConfInfo: TnsConfInfoNode;
   f_UserCR1SheetType: TddBaseConfigItem;
   f_UserCR2SheetType: TddBaseConfigItem;
   f_UserCR1Type: TddBaseConfigItem;
   f_UserCR2Type: TddBaseConfigItem;
   f_EnableMSOIntegration: TddBaseConfigItem;
   f_DocumentNode: TddCustomConfigNode;
   f_SubsriberList: TInsConfigNotifyRecipientPtrList;
   f_ConfigName: Il3CString;
   f_ConfigHint: Il3CString;
   f_DuplicateCheckes: Pointer;
   f_InRestoreAll: Boolean;
    // Блокирует лишний вызов Reinsert при восстановлении всего
   f_NeedReinsertFormsAfterSave: Boolean;
    // После сохранения/восстановления надо перевставить формы
   f_MakeSettings: Boolean;
    // Блокирует загрузку настроек при создании списка имен параметров
   f_Filled: Boolean;
    // Признак того, что подключились к диалогу
   f_InProcess: Boolean;
    // В процессе сохранения/восстановления
   f_DefaultValuesOperation: Boolean;
    // Операции проходять со значениями по умолчанию
   f_DialogsCalled: Boolean;
  private
  // internal methods
    {$IfDef nsExportSettings}
    procedure ExportSettings;
      {-}
    {$EndIf nsExportSettings}
    procedure LoadMessage(const aMsg  : Tl3Message;
                          const aNode : TddCustomConfigNode = nil;
                          const aNames: PnsButtonCaptionArray = nil);
      overload;
      {* - загружает предупреждение. }
(*    procedure LoadMessage(aMsg        : TvcmMessagesCollectionItem;
                          const aNode : TddCustomConfigNode = nil;
                          const aNames: PnsButtonCaptionArray = nil);
      overload;
      {* - загружает предупреждение. }*)
    procedure LoadMessage(aMsg        : TvcmMessageID;
                          const aNode : TddCustomConfigNode = nil;
                          const aNames: PnsButtonCaptionArray = nil);
      overload;
      {-}
    procedure ErrorShow(aSender        : TObject;
                        const aMessage : AnsiString);
      {* - показывает сообщение об ошибке. }
    procedure ToolbarNotify(aSender: TObject);
    procedure PageSetupNotify(aSender: TObject);
    procedure StyleEditorNotify(aSender: TObject);
      { нотификаторы для кнопок редактирующих тулбар, стили и пр.}
    function AppConfig: TnsAppConfig;
      { получить и инициализировать хранилище-наследник от ddAppConfig }
    procedure CreateStruct;
      { создать структуру описания AppConfig }
    function GetModalResult(aBtn: TMsgDlgBtn): longint;
      {-}
    procedure NotifySettingsChanged;
      {-}
  protected
  // protected methods
   function DoGetModified: Boolean;
    override;
   function MakeEditingSettings: IvcmStrings;
    override;
   procedure DoLoad(aRestoreDefault: Boolean = False);
    override;
   { Реальная загрузка }
   procedure DoSave(aSaveAsDefault: Boolean = False);
    override;
   { Реальное сохранение }
   procedure DoAfterLoad(aRestoreDefault: Boolean = False);
    override;
   procedure DoAfterSave(aSaveAsDefault: Boolean = False);
    override;
   procedure Cleanup;
    override;
   function MakeNotUserSettingList: IvcmStrings;
    override;
  public
   constructor Create(const aConfig : IConfiguration = nil;
    aDuplicateNameChecker: InsDuplicateConfigNameChecker = nil);
    reintroduce;
   class function Make(const aConfig : IConfiguration = nil;
    aDuplicateNameChecker: InsDuplicateConfigNameChecker = nil): InsConfigSettingsInfo;
    reintroduce;
  end;//TnsConfigSettingsInfo

 TstgVersionCommentLinkBehaviour = class(TddComboBoxConfigItem)
  {* [requestlink:513615258] }
 public
 // public methods
   constructor Create(aMasterItem: TddBaseConfigItem = nil); reintroduce;
 end;//TstgVersionCommentLinkBehaviour  
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Graphics,
  Registry,
  StrUtils,
  Windows,

  afwFacade,

  l3Types,
  l3ValueMap,
  l3String,
  l3Base,

  vtLabel,

  vcmForm,
  vcmStringList,
  vcmBaseMenuManager,
  vcmBaseCollection,
  vcmHistory,
  vcmSettings,
  
  CustomizeTools_Form,  

  ctTypes,

  evStyleInterface,

  nscInterfaces,

  StdRes,
  SystemStr,

  DataAdapter,
  DynamicTreeUnit,

  IOUnit,

  nscConst,

  nsTypes,
  nsSettingsUtils,
  nsNodes,
  nsConst,
  nsValueMapsIDs,
  nsValueMaps,
  nsIntegerValueMap,
  nsSimpleIntegerValueMap,
  nsListSortTypeMap,
  nsPageSetup,
  nsStyleEditor,
  nsContextFilterParamsConst,
  nsContextFilterParams,
  nsConfigurationProperties,

  L10nInterfaces,
  nscComboBoxWithReadOnly,

  nsAppConfigRes,
  nsTextWithCommentsRes,
  vcmTabbedContainerRes,

  vtDialogsResEx,

  vcmMessagesSupport,

  stDocumentShowChangesInfoItem,
  //stDocumentUseFixedFontForPrintAndExportItem,

  ControlStatusUtils,
  PrimMain_Form,

  nsSettingsConst,
  nsQuestions,
  nsQuestionsWithChoices,
  Pl3StringIDExList,

  vtComboBoxQS,
  stevStylesPrintAndExportFontSizeItem,
  evStylesPrintAndExportSettingRes,
  evStyles_SH,
  afwSettingsChangePublisher
  ;

{$Include afwSettingChanged.imp.pas}

{ TnsConfigStorage }

constructor TnsConfigStorage.Create(const aSettings : IvcmSettings{;
                                    anOwner              : TObject});
begin
 inherited Create{(anOwner)};
 f_Settings := aSettings;
end;

procedure TnsConfigStorage.Cleanup;
begin
 f_Settings := nil;
 inherited;
end;

function TnsConfigStorage.Get_Section: AnsiString;
begin

end;

function TnsConfigStorage.ReadBool(const Alias : AnsiString;
                                   Default     : Boolean) : Boolean;
begin
 Result := f_Settings.LoadBoolean(Alias,Default,f_DefaultValuesOperation)
end;

function TnsConfigStorage.ReadDateTime(const Alias : AnsiString;
                                       Default     : System.TDateTime) : System.TDateTime;
begin
 Result := f_Settings.LoadInteger(Alias, Trunc(Default), f_DefaultValuesOperation)
end;

function TnsConfigStorage.ReadInteger(const Alias : AnsiString;
                                      Default     : Integer): Integer;
begin
 Result := f_Settings.LoadInteger(Alias, Default, f_DefaultValuesOperation)
end;

function TnsConfigStorage.ReadString(const Alias, Default: AnsiString): Il3CString;
begin
 Result := f_Settings.LoadString(Alias, Default, f_DefaultValuesOperation)
end;

procedure TnsConfigStorage.Set_Section(const Value: AnsiString);
begin

end;

procedure TnsConfigStorage.WriteBool(const Alias: AnsiString; B: Boolean);
begin
 f_Settings.SaveBoolean(Alias, B, B, f_DefaultValuesOperation);
end;

procedure TnsConfigStorage.WriteDateTime(const Alias: AnsiString; DT: System.TDateTime);
var
 lLong : Integer;
begin
 lLong := Trunc(DT);
 f_Settings.SaveInteger(Alias, lLong, lLong, f_DefaultValuesOperation);
end;

procedure TnsConfigStorage.WriteInteger(const Alias: AnsiString; I: Integer);
begin
 f_Settings.SaveInteger(Alias, I, I, f_DefaultValuesOperation);
end;

procedure TnsConfigStorage.WriteString(const Alias, S: AnsiString);
begin
 f_Settings.SaveString(Alias, nsCStr(S), S, f_DefaultValuesOperation);
end;

function TnsConfigStorage.GetDefaultValuesOperation: Boolean;
begin
 Result := f_DefaultValuesOperation;
end;

procedure TnsConfigStorage.SetDefaultValuesOperation(
  const aValue: Boolean);
begin
 f_DefaultValuesOperation := aValue;
end;

{ TnsHistoryItemsProperty }

procedure TnsHistoryItemsProperty.SaveValue(const aStorage : IddConfigStorage);
//override;
{* - помимо сохранения настройки установим значене g_vcmHistoryLimit. }
begin
 inherited SaveValue(aStorage);
 g_vcmHistoryLimit := Value.AsInteger;
end;

{ TnsConfInfoNode }

procedure TnsConfInfoNode.DoClearControls;
begin
end;

constructor TnsConfInfoNode.Create(const aAlias   : AnsiString;
                                   const aCaption : AnsiString;
                                   const aConfig  : InsConfigSettingsInfo = nil);
begin
 inherited Create(aAlias, aCaption);
 f_Config := Pointer(aConfig);
end;

function TnsConfInfoNode.DoCreateFrame(aOwner : TComponent;
                                     aTag   : Integer) : TCustomFrame;
var
 lTop    : Integer;

 function CreateLabel(const aCaption : Il3CString) : TvtLabel;
 begin
  Result := TvtLabel.Create(f_Frame);
  Result.Parent := f_Frame;
  Result.Left := c_ConfigItemLeft;
  Result.Top := lTop;
  lTop := lTop + Result.Height + c_ConfigItemTop;
  Result.CCaption := l3Cat(aCaption, ':');
 end;

 function CreateEdit(aOnChange : TNotifyEvent = nil) : TnscComboBoxWithReadOnly;
 begin
  Result := TnscComboBoxWithReadOnly.Create(f_Frame);
  Result.Parent := f_Frame;
  Result.Left := c_ConfigItemLeft;
  Result.Top := lTop;
  Result.OnChange := aOnChange;
  if InsConfigSettingsInfo(f_config).IsPredefined then
  begin
   Result.Enabled := false;
(*   Result.ReadOnly := True;
   Result.Color := $00F9F8FA;*)
  end;
  lTop := lTop + Result.Height + c_ConfigItemTop;
 end;

begin
 Assert(not Assigned(f_Frame));
 lTop := c_ConfigItemTop;
 f_Frame := TFrame.Create(aOwner);
 f_Frame.Parent := TWinControl(aOwner);
 f_Frame.Tag := aTag;
 f_Frame.OnResize := OnResize;

 // Название конфигурации
 CreateLabel(vcmCStr(str_cnConfigurationName));
 // поле ввода
 f_ConfName := CreateEdit(OnChangeName);
 f_ConfName.Modified := Changed;
 // Описание конфигурации
 CreateLabel(vcmCStr(str_cnConfigurationDescription));
 // поле ввода
 f_ConfHint := CreateEdit(OnChangeHint);
 f_ConfHint.Modified := Changed;

 // расположем в клиентской области
 f_Frame.Align := alClient;

 Result := f_Frame;
end;

procedure TnsConfInfoNode.DoFrameSize(aParent: TWinControl;
                                    out aHeight, aWidth: Integer);
begin
 aHeight := 100;
 aWidth := 100;
end;

procedure TnsConfInfoNode.DoGetControlValues;
begin
 //http://mdp.garant.ru/pages/viewpage.action?pageId=481440254 
 try
  if Assigned(f_ConfName) and Assigned(f_ConfHint) then
   if (f_ConfName.Modified and not l3IsNil(f_ConfName.Text)) or
    (f_ConfHint.Modified and not l3IsNil(f_ConfHint.Text)) then
    InsConfigSettingsInfo(f_Config).RenameConfig(nsWStr(f_ConfName.Text), nsWStr(f_ConfHint.Text));
 except
  on e: EDuplicateConfName do
   vcmSay(err_DublicateConfName, [e.ConfName])
  else
   raise; 
 end;
end;

function TnsConfInfoNode.pm_GetValue : TddConfigValue;
begin

end;

procedure TnsConfInfoNode.DoLoad(const aStorage: IddConfigStorage);
begin
end;

procedure TnsConfInfoNode.SetEditsWidth;
begin
 if Assigned(f_ConfName) then
  f_ConfName.Width := f_Frame.Width - c_ConfigItemRight - f_ConfName.Left;
 if Assigned(f_ConfHint) then
  f_ConfHint.Width := f_Frame.Width - c_ConfigItemRight - f_ConfHint.Left;
end;

procedure TnsConfInfoNode.OnResize(Sender: TObject);
begin
 SetEditsWidth;
end;

procedure TnsConfInfoNode.Cleanup;
begin
 f_Config := nil;
 inherited;
end;

procedure TnsConfInfoNode.DoSave(const aStorage: IddConfigStorage);
begin
//http://mdp.garant.ru/pages/viewpage.action?pageId=481440254
 (*
 try
  if Assigned(f_ConfName) and Assigned(f_ConfHint) then
   if (f_ConfName.Modified and not l3IsNil(f_ConfName.Text)) or
    (f_ConfHint.Modified and not l3IsNil(f_ConfHint.Text)) then
    InsConfigSettingsInfo(f_Config).RenameConfig(nsWStr(f_ConfName.Text), nsWStr(f_ConfHint.Text))
 except
  on e: EDuplicateConfName do
   vcmSay(err_DublicateConfName, [e.ConfName])
  else
   raise; 
 end;
*)
end;

procedure TnsConfInfoNode.DoSetControlValues(aDefault: Boolean);
begin
 // значение
 with InsConfigSettingsInfo(f_Config) do
 begin
  f_ConfName.Text := ConfigName;
  f_ConfHint.Text := ConfigHint;
 end;//with InsConfigSettingsInfo(f_Config)
 Changed := False;
end;

procedure TnsConfInfoNode.pm_SetValue(const Value: TddConfigValue);
begin

end;

procedure TnsConfInfoNode.OnChangeHint(Sender: TObject);
begin
 f_Changed := True;
end;

procedure TnsConfInfoNode.OnChangeName(Sender: TObject);
begin
 f_Changed := True;
end;

function TnsConfInfoNode.pm_GetChanged: Boolean;
begin
 Result := f_Changed;
end;

procedure TnsConfInfoNode.pm_SetChanged(Value: Boolean);
begin
 if Value <> f_Changed then
 begin
  f_Changed := Value;
  if Assigned(f_ConfHint) then
   f_ConfHint.Modified := Value;
  if Assigned(f_ConfName) then
   f_ConfName.Modified := Value;
 end;
end;

function TnsConfInfoNode.DoIsItem(aItem: TObject): Boolean;
begin
 Result := Assigned(aItem) and ((aItem =  f_ConfName) or (aItem =  f_ConfHint));
end;

{ EDuplicateConfName }

procedure EDuplicateConfName.SetConfName(const Value: AnsiString);
begin
 f_ConfName := Value;
end;

{ TstgNavigatorFormPosition }

constructor TstgNavigatorFormPosition.Create(const aFormSetting : AnsiString;
                                            const aCaption     : AnsiString;
                                            aMasterItem        : TddBaseConfigItem = nil);
var
 lDefaultValue : TddConfigValue;
begin
 // значение по умолчанию
 l3FillChar(lDefaultValue, SizeOf(lDefaultValue), 0);
 with lDefaultValue do
 begin
  Kind := dd_vkInteger;
  AsInteger := Byte(nfpLeftNavigator);
 end;
 // создадим
 inherited Create(aFormSetting, aCaption, lDefaultValue,
  nsIntegerMapManager.Map[imap_NavigatorSheetPosition], aMasterItem);
end;

procedure TstgNavigatorFormPosition.Cleanup;
  //override;
  {-}
begin
 fZoneValue := nil;
 inherited;
end;

function TstgNavigatorFormPosition.GetAliasName: AnsiString;
begin
 Result := Alias;
end;

function TstgNavigatorFormPosition.GetFloatingSetting: AnsiString;
begin
 Result := GetAliasName + cnfpFloating;
end;

function TstgNavigatorFormPosition.GetZoneSetting: AnsiString;
begin
 Result := GetAliasName + cnfpZone;
end;

procedure TstgNavigatorFormPosition.LoadValue(const aStorage: IddConfigStorage);
begin
 fFloatingValue := aStorage.ReadBool(FloatingSetting, False);
 if fFloatingValue then
  IntegerValue := Integer(nfpFloating)
 else
 begin
  fZoneValue := aStorage.ReadString(ZoneSetting, cnfpLeftNavigator);
  if l3Same(fZoneValue, cnfpLeftNavigator) then
   IntegerValue := Integer(nfpLeftNavigator)
  else
  if l3Same(fZoneValue, cnfpRightNavigator) then
   IntegerValue := Integer(nfpRightNavigator);
 end;//fFloatingValue
end;

procedure TstgNavigatorFormPosition.SaveValue(const aStorage: IddConfigStorage);
begin
 aStorage.WriteBool(FloatingSetting, False);
 case TnsNavigatorFormPositionType(IntegerValue) of
  nfpFloating:
   aStorage.WriteBool(FloatingSetting, True);
  nfpLeftNavigator:
   aStorage.WriteString(ZoneSetting, cnfpLeftNavigator);
  nfpRightNavigator:
   aStorage.WriteString(ZoneSetting, cnfpRightNavigator);
 end;
end;

procedure TstgNavigatorFormPosition.SetFloatingValue(const Value: Boolean);
begin
 fFloatingValue := Value;
end;

procedure TstgNavigatorFormPosition.SetZoneValue(const Value: Il3CString);
begin
 fZoneValue := Value;
end;

{ TnsAppConfig }

function TnsAppConfig.GetIsNeedReinsertForms: Boolean;
var
 lIndex : Integer;
begin
 Result := False;
 for lIndex := 0 to Pred(Items.Count) do
  if Assigned(Items.Objects[lIndex]) and
   (TObject(Items.Objects[lIndex]) is TstgNavigatorFormPosition) and
   (TstgNavigatorFormPosition(Items.Objects[lIndex]).Changed) then
  begin
   Result := True;
   Break;
  end;
end;

function TnsAppConfig.IsSettingsChanged: Boolean;
var
  I: Integer;
  l_Obj: TObject;
begin
  Result := False;
  for i:= 0 to Pred(Items.Count) do
  begin
   l_Obj:= Items.Objects[i];
   if not (l_Obj is TnsConfInfoNode) then
   begin
    if l_Obj is TddBaseConfigItem then
    begin
     if TddBaseConfigItem(l_Obj).Changed then
     begin
      Result:= True;
      Break;
     end
    end
    else
     if TddCustomConfigNode(l_Obj).Changed then
     begin
      Result := True;
      Break;
     end;
   end;
  end;
end;

{ TstgFilterFormPosition }

function TstgFilterFormPosition.GetAliasName: AnsiString;
begin
 Result := cFrmIDFilter;
end;

{ TstgTabbedInterfaceBehaviour }

function TstgTabbedInterfaceBehaviour.pm_GetFullControlHeight(aParent: TWinControl): Integer;
begin
 Result := ControlHeight(aParent);
end;

constructor TstgTabbedInterfaceBehaviour.Create(const aTabUseCaseSettingsID: AnsiString;
 const aCaption: AnsiString);
var
 l_DefaultValue : TddConfigValue;
begin
 // значение по умолчанию
 l3FillChar(l_DefaultValue, SizeOf(l_DefaultValue), 0);
 with l_DefaultValue do
 begin
  Kind := dd_vkInteger;
  AsInteger := Byte(vcm_okInCurrentTab);
 end;
 // создадим
 inherited Create(aTabUseCaseSettingsID, aCaption, l_DefaultValue,
  nsIntegerMapManager.Map[imap_DocumentAndLinkOpenKind], nil);
 Labeled := False;
 LabelTop := False; 
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=565841996
end;

{ TstgScalePicture }

constructor TstgScalePicture.Create(aMasterItem : TddBaseConfigItem = nil);
var
 lValue : TddConfigValue;
begin
 lValue.Kind := dd_vkString;
 lValue.AsString := dvDocumentPictureScale;
 inherited Create(piDocumentPictureScale, l3Str(nsStringMapManager.Map[smap_Settings].ValueToDisplayName(nsCStr(piDocumentPictureScale))),
  lValue, nsStringMapManager.Map[smap_piDocumentPictureScale], aMasterItem);
 ComboBoxStyle := csDropDown;
 DropDownCount := ValueMap.MapSize;
end;

function TstgScalePicture.CheckValue: Boolean;
begin
 Result := False;
 try
  if Control <> nil then
  begin
   Assert(Control Is TvtComboBoxQS, Control.ClassName);
   TvtComboBoxQS(Control).Text := nsCStr(CalcDisplayName(CalcValue(TvtComboBoxQS(Control).Text)));
  end; 
 except
  on El3ValueMapValueNotFound do
  begin
   TvtComboBoxQS(Control).Text := nsCStr(CalcDisplayName(f_SavedValue));
   Result := True;
  end;
 end;
end;

procedure TstgScalePicture.DoExit;
begin
 CheckValue;
end;

procedure TstgScalePicture.LoadValue(const aStorage: IddConfigStorage);
begin
 inherited LoadValue(aStorage);
 f_SavedValue := Value;
end;

procedure TstgScalePicture.SaveValue(const aStorage: IddConfigStorage);
begin
 if not CheckValue and Assigned(Control) then
  GetValueFromControl;
 inherited SaveValue(aStorage);
 f_SavedValue := Value;
end;

procedure TstgScalePicture.GetValueFromControl;
begin
 try
  inherited GetValueFromControl;
 except
  on El3ValueMapValueNotFound do
   Value := f_SavedValue;
 end;
end;

{ TstgTextSelection }

constructor TstgTextSelection.Create(aMasterItem: TddBaseConfigItem = nil);
var
 lValue : TddConfigValue;
begin
 l3FillChar(lValue, SizeOf(lValue), 0);
 lValue.Kind := dd_vkBoolean;
 lValue.AsBoolean := dv_Document_PermanentSelection;
 inherited Create(pi_Document_PermanentSelection,
  l3Str(nsStringMapManager.Map[smap_Settings].ValueToDisplayName(nsCStr(pi_Document_PermanentSelection))),
  lValue, nsIntegerMapManager.Map[imap_pi_Document_PermanentSelection], aMasterItem);
end;

// start class TstgShowVersionComments

constructor TstgShowVersionComments.Create(aMasterItem: TddBaseConfigItem = nil);
var
 lValue : TddConfigValue;
begin
 l3FillChar(lValue, SizeOf(lValue), 0);
 lValue.Kind := dd_vkBoolean;
 lValue.AsBoolean := dv_Document_ShowVersionsComment;
 inherited Create(pi_Document_ShowVersionsComment,
  str_pi_Document_ShowVersionsComment.AsStr,
  lValue, TShowVersionCommentsMapImpl.Make, aMasterItem);
end;

{ TstgConfirmationItem }

constructor TstgConfirmationItem.Create(const aAlias, aCaption: AnsiString;
  aDefaultResult: TModalResult; aDefaultValue: TddConfigValue;
  aMasterItem: TddBaseConfigItem);
begin
 inherited Create(aAlias, aCaption, aDefaultValue, aMasterItem);
 f_DefaultResult := aDefaultResult;
 Assert(f_DefaultResult <> mrNone);
end;

procedure TstgConfirmationItem.LoadValue(const aStorage : IddConfigStorage);
var
 lResult : TModalResult;
begin
 lResult := aStorage.ReadInteger(Alias, mrNone);
 (* Не показывать подтверждение *)
  if lResult <> mrNone then
  BooleanValue := False
 else
  BooleanValue := True;
end;

procedure TstgConfirmationItem.SaveValue(const aStorage : IddConfigStorage);
begin
 (* Не показывать подтверждение *)
 if not BooleanValue then
  aStorage.WriteInteger(Alias, f_DefaultResult)
else
  aStorage.WriteInteger(Alias, mrNone);
end;

{ TnsConfigSettingsInfo }

function TnsConfigSettingsInfo.AppConfig: TnsAppConfig;
var
 lStorage : TnsConfigStorage;
begin
 if f_AppConfig = nil then
 begin
  lStorage := TnsConfigStorage.Create(Settings);
  try
   if Supports(lStorage, InsConfigStorage, f_Storage) then
   begin
    f_Storage.DefaultValuesOperation := f_DefaultValuesOperation;
    f_AppConfig := TnsAppConfig.Create(f_Storage);
    f_AppConfig.OnErrorShow := ErrorShow;
    CreateStruct;
   end;
  finally
   vcmFree(lStorage);
  end;
 end;
 Result := f_AppConfig;
end;

procedure TnsConfigSettingsInfo.Cleanup;
begin
 DoneEditing;
 vcmFree(f_SubsriberList);
 f_DuplicateCheckes := nil;
 f_ConfigName := nil;
 f_ConfigHint := nil;
 f_DialogsCalled := False;
 inherited Cleanup;
end;

function TnsConfigSettingsInfo.MakeNotUserSettingList: IvcmStrings;
var
 l_Strings: IvcmStrings;
begin
 l_Strings := inherited MakeNotUserSettingList;
 l_Strings.Add('Настройки форм/utMainWindow/utConfigurationList/vcm_ztNavigator/Zone');
 l_Strings.Add('Настройки форм/utMainWindow/utFolders/vcm_ztNavigator/Zone');
 l_Strings.Add('Настройки форм/utMainWindow/utNavigator/vcm_ztNavigator/Zone');
 Result := l_Strings;
end;

constructor TnsConfigSettingsInfo.Create(const aConfig: IConfiguration;
 aDuplicateNameChecker: InsDuplicateConfigNameChecker);
var
 lString : IString;
begin
 inherited Create(aConfig);
 f_SubsriberList := TInsConfigNotifyRecipientPtrList.Make;
 f_DuplicateCheckes := Pointer(aDuplicateNameChecker);
 Configuration.GetName(lString);
 try
  f_ConfigName := nsCStr(lString);
 finally
  lString := nil;
 end;
 Configuration.GetHint(lString);
 try
  f_ConfigHint := nsCStr(lString);
 finally
  lString := nil;
 end;
 {$IfDef nsExportSettings}
 AppConfig;
 DoneEditing;
 {$EndIf nsExportSettings}
end;

procedure TnsConfigSettingsInfo.DoLoad(aRestoreDefault: Boolean);
begin
 f_InProcess := true;
 try
  f_DefaultValuesOperation := aRestoreDefault;
  If Assigned(f_Storage) then
   f_Storage.DefaultValuesOperation := aRestoreDefault;
  try
   AppConfig.Load;
   if f_Filled and aRestoreDefault then
    AppConfig.ReadValuesFromDialog(False);
  finally
   f_DefaultValuesOperation := False;
   If Assigned(f_Storage) then
    f_Storage.DefaultValuesOperation := False;
  end;
 finally
  f_InProcess := False;
 end;
end;

procedure TnsConfigSettingsInfo.DoneEditing;
begin
 inherited DoneEditing;
 f_Storage := nil;
 vcmFree(f_AppConfig);
 f_ConfInfo := nil;
 f_UserCR1SheetType := nil;
 f_UserCR2SheetType := nil;
 f_UserCR1Type := nil;
 f_UserCR2Type := nil;
 f_EnableMSOIntegration := nil;
 f_DocumentNode := nil;
 f_Filled := false;
end;

procedure TnsConfigSettingsInfo.DoSave(aSaveAsDefault: Boolean);
 procedure StoreMSOIValueToRegistry(const a_Value: Boolean);
 begin
  try
   with TRegistry.Create(KEY_WRITE) do
    try
     RootKey := HKEY_CURRENT_USER;
     //
     if OpenKey('Software\Garant.F1-Launcher', True) then
      try
       WriteString('MSOIntegrationEnabled', BoolToStr(a_Value, True));
      finally
       CloseKey;
      end;
    finally
     Free;
    end;
  except
   on ERegistryException do; // ignore
  end;
 end;

 function lp_CheckUserCRTypes: Boolean;
 var
  l_UserCR1Type: TddComboBoxConfigItem;
  l_UserCR2Type: TddComboBoxConfigItem;
 begin
  // Может случиться, что доступен только один тип СКР для вкладок -
  // "Все документы", в результате и в 1-й и во 2-й вкладке оказались
  // одинаковые типы СКР.
  // http://mdp.garant.ru/pages/viewpage.action?pageId=488606734
  Result := False;

  Assert(f_UserCR1Type is TddComboBoxConfigItem, f_UserCR1Type.ClassName);
  Assert(f_UserCR2Type is TddComboBoxConfigItem, f_UserCR2Type.ClassName);

  l_UserCR1Type := TddComboBoxConfigItem(f_UserCR1Type);
  l_UserCR2Type := TddComboBoxConfigItem(f_UserCR2Type);

  Result := ((TvtComboBoxQS( l_UserCR1Type.Control).Items.Count = 1) and
            (TvtComboBoxQS(l_UserCR2Type.Control).Items.Count = 1)) OR
            ((f_UserCR1SheetType.IntegerValue <> f_UserCR2SheetType.IntegerValue) or
            (f_UserCR1Type.StringValue <> f_UserCR2Type.StringValue));
 end;//lp_CheckUserCRTypes

begin
 f_InProcess := True;
 try
  f_DefaultValuesOperation := aSaveAsDefault;
  If Assigned(f_Storage) then
   f_Storage.DefaultValuesOperation := aSaveAsDefault;
  try
   if f_Filled then
   begin
    f_NeedReinsertFormsAfterSave := IsActive and AppConfig.IsNeedReinsertForms;
    TddVisualConfigItem(f_UserCR1SheetType).GetValueFromControl;
    TddVisualConfigItem(f_UserCR2SheetType).GetValueFromControl;
    TddVisualConfigItem(f_UserCR1Type).GetValueFromControl;
    TddVisualConfigItem(f_UserCR2Type).GetValueFromControl;
    if Assigned(f_EnableMSOIntegration) then
    begin
     TddVisualConfigItem(f_EnableMSOIntegration).GetValueFromControl;
     StoreMSOIValueToRegistry(f_EnableMSOIntegration.BooleanValue);
    end;
    //http://mdp.garant.ru/pages/viewpage.action?pageId=488606734
    if (not lp_CheckUserCRTypes) then
    begin
     AppConfig.MakeNodeVisible(f_DocumentNode);
     raise ECRSettingsAreEqual.Create(vcmConstString(str_CRSettingsAreEqual))
    end;
    if not AppConfig.ReadValuesFromDialog then
     raise EConfigNotSaved.Create('');
   end;
   if aSaveAsDefault then
    AppConfig.Changed := True;
   AppConfig.Save;
  finally
   f_DefaultValuesOperation := False;
   If Assigned(f_Storage) then
    f_Storage.DefaultValuesOperation := False;
  end;
 finally
  f_InProcess := False;
 end;
end;

procedure TnsConfigSettingsInfo.ErrorShow(aSender: TObject;
  const aMessage: AnsiString);
begin
 vcmShowMessageDlg(Tl3Message_C(nsCStr(aMessage),
                                'TnsConfigSettingsInfo.ErrorShow',
                                mtError));
end;

{$IfDef nsExportSettings}
procedure TnsConfigSettingsInfo.ExportSettings;

 function ExportSetting(const aValue        : AnsiString;
                        const aDefaultValue : AnsiString;
                        const aSetting      : AnsiString;
                        const aCaption      : AnsiString = '';
                        const aType         : AnsiString = '') : AnsiString;
 begin
  Result := Format('%s; %s; %s; %s; %s;', [aValue,
                                           aDefaultValue,
                                           aType,
                                           aSetting,
                                           aCaption]);
 end;

var
 lSettings : TStrings;
 lIndex    : Integer;
begin
 lSettings := TvcmStringList.Make;
 try
  lSettings.Add(casExportTitle);
  for lIndex := 0 to Pred(AppConfig.Items.Count) do
   if AppConfig.Items.Objects[lIndex] is TstgNavigatorFormPosition then
     with TstgNavigatorFormPosition(AppConfig.Items.Objects[lIndex]) do
     begin
      lSettings.Add(ExportSetting(IntToStr(Integer(FloatingValue)),
                                  '0',
                                  FloatingSetting,
                                  '',
                                  'Boolean'));
      lSettings.Add(ExportSetting(ZoneValue,
                                  cnfpLeftNavigator,
                                  ZoneSetting,
                                  '',
                                  'AnsiString'));
     end
   else
   if AppConfig.Items.Objects[lIndex] is TstgTextSelection then
    with TstgTextSelection(AppConfig.Items.Objects[lIndex]) do
     lSettings.Add(ExportSetting(IntToStr(Integer(BooleanValue)),
                                 IntToStr(Integer(DefaultBooleanValue)),
                                 Alias,
                                 Caption,
                                 'Boolean'))
   else
   if AppConfig.Items.Objects[lIndex] is TstgShortList then
    with TstgShortList(AppConfig.Items.Objects[lIndex]) do
     lSettings.Add(ExportSetting(IntToStr(Integer(BooleanValue)),
                                 IntToStr(Integer(DefaultBooleanValue)),
                                 Alias,
                                 Caption,
                                 'Boolean'))
   else
   if AppConfig.Items.Objects[lIndex] is TstgScalePicture then
    with TstgScalePicture(AppConfig.Items.Objects[lIndex]) do
     lSettings.Add(ExportSetting(StringValue,
                                 DefaultStringValue,
                                 Alias,
                                 Caption,
                                 'AnsiString'))
   else
     with TddBaseConfigItem(AppConfig.Items.Objects[lIndex]) do
      case DefaultValue.Kind of
       dd_vkInteger:
        lSettings.Add(ExportSetting(IntToStr(IntegerValue),
                                    IntToStr(DefaultIntegerValue),
                                    Alias,
                                    Caption,
                                    'Integer'));
       dd_vkString:
        if DefaultValue.AsString <> '' then
         lSettings.Add(ExportSetting(StringValue,
                                     DefaultStringValue,
                                     Alias,
                                     Caption,
                                     'AnsiString'));
       dd_vkBoolean :
        lSettings.Add(ExportSetting(IntToStr(Integer(BooleanValue)),
                                    IntToStr(Integer(DefaultBooleanValue)),
                                    Alias,
                                    Caption,
                                    'Boolean'));
       dd_vkDateTime:
        lSettings.Add(ExportSetting(DateToStr(DateTimeValue),
                                    DateToStr(DefaultDateTimeValue),
                                    Alias,
                                    Caption,
                                    'DateTime'));
      end;
 finally
  lSettings.SaveToFile(Format('C:\nsExportSettings (%s).csv',
   [COnfigName]));
  FreeAndNil(lSettings);
 end;
end;
{$EndIf nsExportSettings}

procedure TnsConfigSettingsInfo.FillDialog(const aForm: IvcmEntityForm;
  aButtonsPanelHeight: Integer);
begin
 AppConfig.ButtonsPanelHeight := aButtonsPanelHeight;
 AppConfig.FillDialog(aForm.VCLWinControl As TCustomForm, [dd_doNoButtons],
  [cptNormalBevel]);
 AppConfig.Changed := False;
 f_Filled := true;
end;

procedure TnsConfigSettingsInfo.LoadMessage(aMsg: TvcmMessageID;
  const aNode: TddCustomConfigNode;
  const aNames: PnsButtonCaptionArray);
var
 lMsg : TvcmMessagesCollectionItem;
begin
 lMsg := TvcmMessagesCollectionItem(g_MenuManager.Messages.Items[aMsg.rM]);
 Assert(Assigned(lMsg));
(* LoadMessage(lMsg, aNode, aNames);*)
 LoadMessage(vcmMessageIDToMessage(aMsg, vcmCStr(lMsg.Caption)), aNode, aNames);
end;

procedure TnsConfigSettingsInfo.LoadMessage(const aMsg : Tl3Message;
                      const aNode : TddCustomConfigNode = nil;
                      const aNames: PnsButtonCaptionArray = nil);
  //overload;
  {* - загружает предупреждение. }
const
 imap_Dummy: TnsValueMapID = (rName: 'MessageButtons'; rID: -1);

 lc_ButtonMaps: TnsButtonCaptionArray = (
  @str_pui_ask_Yes, @str_pui_ask_No, @str_pui_ask_OK, @str_pui_ask_Cancel,
  @str_pui_ask_Abort, @str_pui_ask_Retry, @str_pui_ask_Ignore, @str_pui_ask_All,
  @str_pui_ask_NoToAll, @str_pui_ask_YesToAll, @str_pui_ask_Help {$IfDef XE}, nil{$EndIf});

var
 lForbiddenBtns : Set of TMsgDlgBtn;
 lIndex         : TMsgDlgBtn;
 lValue         : TddConfigValue;
 lItemCount     : Integer;
 lConf          : TstgConfirmationItem;
 l_ButtonsArray : array of TnsIntegerValueMapRecord;
 l_DefaultResult: TModalResult;
 l_Names: PnsButtonCaptionArray;
 l_Choices: TPl3StringIDExList;
 l_IDX: Integer;
 l_ChoicesArray : array of TnsSimpleIntegerValueMapRecord;
 l_Value: Integer;
begin
 l_Choices := aMsg.rData.rChoices.Use;
 try
  //if (l_Choices <> nil) then
   //(l_Choices As Il3StringsEx).Items.Text := aMsg.rData.rChoices;

  if (l_Choices = nil) or (l_Choices.Count = 0) then
  begin
   if Assigned(aNames) then
    l_Names := aNames
   else
    l_Names := @lc_ButtonMaps;
   l3FillChar(lValue, SizeOf(lValue), 0);
   // Если в диалоге присутствует кнопка Cancel - не включаем её в список
   // Если Cancel нет - не включаем кнопку No
   lForbiddenBtns := [mbCancel];
   if not (mbCancel in aMsg.rData.rButtons) then
    lForbiddenBtns := lForbiddenBtns + [mbNo];
   // определим будем использовать checkboxitem или comboboxitem
   lItemCount := 0;
   l_DefaultResult := mrNone;
   for lIndex := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
   begin
    if (lIndex in lForbiddenBtns) then
     Continue;
    if (lIndex in aMsg.rData.rButtons) then
    begin
     l_DefaultResult := vtGetDlgBtnResult(lIndex);
     Inc(lItemCount);
    end;//lIndex in aMsg.Buttons
   end;//for lIndex
   (* CheckBoxItem *)
   if lItemCount = 1 then
   begin
    Assert(Assigned(aNode));
    lConf := TstgConfirmationItem.Create(aMsg.rName, aMsg.SettingsCaption, l_DefaultResult, lValue);
    with AppConfig do
    begin
     AddItem(aNode, lConf);
     Hint := aMsg.LongHint;
    end;
   end//if lItemCount = 1
   (* ComboBoxItem *)
   else
   begin
    // создадим выпадающий список
    with AppConfig do
    begin
     SetLength(l_ButtonsArray,1);
     l_ButtonsArray[0] := nsIntegerValueMapRecord(str_pui_AskConfirmation, mrNone);
     for lIndex := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
     begin
     // запрещено
      if (lIndex in lForbiddenBtns) then
       Continue;
      // добавим значение
      if lIndex in aMsg.rData.rButtons then
      begin
       SetLength(l_ButtonsArray,Length(l_ButtonsArray)+1);
       l_ButtonsArray[High(l_ButtonsArray)] := nsIntegerValueMapRecord(l_Names^[lIndex]^, GetModalResult(lIndex));
      end;
     end;
     AddComboBoxItem(nsCStr(aMsg.rName), nsCStr(aMsg.SettingsCaption + ':'), mrNone,
      TnsIntegerValueMap.Make(imap_Dummy, l_ButtonsArray));
     Hint := aMsg.LongHint;
    end;
   end;//if lItemCount = 1
  end//if l_Choices.Count = 0
  else
  begin
   // Проверка и корректировка для совместимости
   l_Value := f_Storage.ReadInteger(aMsg.rName, mrNone);
   if (l_Value > 0) then
   begin
    Assert(aMsg.rData.rButtons = [mbOk, mbCancel]);
    Assert((l_Choices.Count = 2) and (l_Value in [mrOk, mrYes, mrNo]));
    case l_Value of
     mrOk, mrYes: l_Value := -1;
     mrNo: l_Value := -2;
    end;
    f_Storage.WriteInteger(aMsg.rName, l_Value);
   end;//l_Value > 0

   // Собственно наборка мапы
   //if (aMsg.rData.rDefaultChoice=0) or (Abs(aMsg.rData.rDefaultChoice)>l_Choices.Count) then
   if l3IsNil(aMsg.CheckCaption) then
   begin
    SetLength(l_ChoicesArray, l_Choices.Count+1);
    l_ChoicesArray[0] := nsSimpleIntegerValueMapRecord(vcmCStr(str_pui_AskConfirmation), mrNone);
    for l_IDX := 0 to l_Choices.Count - 1 do
     l_ChoicesArray[l_IDX + 1] := nsSimpleIntegerValueMapRecord(l_Choices.Items[l_IDX].AsCStr, -(l_IDX + 1));
     //l_ChoicesArray[High(l_ChoicesArray)] := nsSimpleIntegerValueMapRecord(l_Choices.ItemC[l_IDX], -(l_IDX + 1));
   end//aMsg.rData.rDefaultChoice=0..
   else
   begin
    SetLength(l_ChoicesArray, 2);
    l_ChoicesArray[0] := nsSimpleIntegerValueMapRecord(vcmCStr(str_pui_AskConfirmation), mrNone);
    l_ChoicesArray[1] := nsSimpleIntegerValueMapRecord(l3CStr(aMsg.CheckCaption), aMsg.rData.rDefaultChoice);
   end;//aMsg.rData.rDefaultChoice=0

   with AppConfig do
   begin
    AddComboBoxItem(nsCStr(aMsg.rName), nsCStr(aMsg.SettingsCaption + ':'), mrNone,
     TnsSimpleIntegerValueMap.Make(imap_Dummy, l_ChoicesArray));
    Hint := aMsg.LongHint;
   end;//with AppConfig
  end;//if l_Choices.Count = 0
 finally
  FreeAndNil(l_Choices);
 end;//try..finally
end;

(*procedure TnsConfigSettingsInfo.LoadMessage(
  aMsg: TvcmMessagesCollectionItem;
  const aNode: TddCustomConfigNode;
  const aNames: PnsButtonCaptionArray);
const
 imap_Dummy: TnsValueMapID = (rName: 'MessageButtons'; rID: -1);

 lc_ButtonMaps: TnsButtonCaptionArray = (
  @str_pui_ask_Yes, @str_pui_ask_No, @str_pui_ask_OK, @str_pui_ask_Cancel,
  @str_pui_ask_Abort, @str_pui_ask_Retry, @str_pui_ask_Ignore, @str_pui_ask_All,
  @str_pui_ask_NoToAll, @str_pui_ask_YesToAll, @str_pui_ask_Help);

var
 lForbiddenBtns : Set of TMsgDlgBtn;
 lIndex         : TMsgDlgBtn;
 lValue         : TddConfigValue;
 lItemCount     : Integer;
 lConf          : TstgConfirmationItem;
 l_ButtonsArray : array of TnsIntegerValueMapRecord;
 l_DefaultResult: TModalResult;
 l_Names: PnsButtonCaptionArray;
 l_Choices: Tl3Strings;
 l_IDX: Integer;
 l_ChoicesArray : array of TnsSimpleIntegerValueMapRecord;
 l_Value: Integer;
begin
 if (aMsg.Choices = '') then
  l_Choices := nil
 else
  l_Choices := Tl3Strings.Create;
 try
  if (l_Choices <> nil) then
   (l_Choices As Il3StringsEx).Items.Text := aMsg.Choices;

  if (l_Choices = nil) or (l_Choices.Count = 0) then
  begin
   if Assigned(aNames) then
    l_Names := aNames
   else
    l_Names := @lc_ButtonMaps;
   l3FillChar(lValue, SizeOf(lValue), 0);
   // Если в диалоге присутствует кнопка Cancel - не включаем её в список
   // Если Cancel нет - не включаем кнопку No
   lForbiddenBtns := [mbCancel];
   if not (mbCancel in aMsg.Buttons) then
    lForbiddenBtns := lForbiddenBtns + [mbNo];
   // определим будем использовать checkboxitem или comboboxitem
   lItemCount := 0;
   l_DefaultResult := mrNone;
   for lIndex := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
   begin
    if (lIndex in lForbiddenBtns) then
     Continue;
    if (lIndex in aMsg.Buttons) then
    begin
     l_DefaultResult := vtGetDlgBtnResult(lIndex);
     Inc(lItemCount);
    end;//lIndex in aMsg.Buttons
   end;//for lIndex
   { CheckBoxItem }
   if lItemCount = 1 then
   begin
    Assert(Assigned(aNode));
    lConf := TstgConfirmationItem.Create(aMsg.Name, aMsg.SettingsCaption, l_DefaultResult, lValue);
    with AppConfig do
    begin
     AddItem(aNode, lConf);
     Hint := aMsg.LongHint;
    end;
   end//if lItemCount = 1
   { ComboBoxItem }
   else
   begin
    // создадим выпадающий список
    with AppConfig do
    begin
     SetLength(l_ButtonsArray,1);
     l_ButtonsArray[0] := nsIntegerValueMapRecord(str_pui_AskConfirmation, mrNone);
     for lIndex := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
     begin
     // запрещено
      if (lIndex in lForbiddenBtns) then
       Continue;
      // добавим значение
      if lIndex in aMsg.Buttons then
      begin
       SetLength(l_ButtonsArray,Length(l_ButtonsArray)+1);
       l_ButtonsArray[High(l_ButtonsArray)] := nsIntegerValueMapRecord(l_Names^[lIndex]^, GetModalResult(lIndex));
      end;
     end;
     AddComboBoxItem(nsCStr(aMsg.Name), nsCStr(aMsg.SettingsCaption + ':'), mrNone,
      TnsIntegerValueMap.Make(imap_Dummy, l_ButtonsArray));
     Hint := aMsg.LongHint;
    end;
   end;//if lItemCount = 1
  end//if l_Choices.Count = 0
  else
  begin
   // Проверка и корректировка для совместимости
   l_Value := f_Storage.ReadInteger(aMsg.Name, mrNone);
   if l_Value > 0 then
   begin
    Assert(aMsg.Buttons = [mbOk, mbCancel]);
    Assert((l_Choices.Count = 2) and (l_Value in [mrOk, mrYes, mrNo]));
    case l_Value of
     mrOk, mrYes: l_Value := -1;
     mrNo: l_Value := -2;
    end;
    f_Storage.WriteInteger(aMsg.Name, l_Value);
   end;

   // Собственно наборка мапы
   if (aMsg.DefaultChoice=0) or (Abs(aMsg.DefaultChoice)>l_Choices.Count) then
   begin
    SetLength(l_ChoicesArray, l_Choices.Count+1);
    l_ChoicesArray[0] := nsSimpleIntegerValueMapRecord(vcmCStr(str_pui_AskConfirmation), mrNone);
    for l_IDX := 0 to l_Choices.Count - 1 do
     l_ChoicesArray[High(l_ChoicesArray)] := nsSimpleIntegerValueMapRecord(l_Choices.ItemC[l_IDX], -(l_IDX + 1));
   end
   else
   begin
    SetLength(l_ChoicesArray, 2);
    l_ChoicesArray[0] := nsSimpleIntegerValueMapRecord(vcmCStr(str_pui_AskConfirmation), mrNone);
    l_ChoicesArray[1] := nsSimpleIntegerValueMapRecord(vcmCStr(aMsg.CheckCaption), aMsg.DefaultChoice);
   end;

   with AppConfig do
   begin
    AddComboBoxItem(nsCStr(aMsg.Name), nsCStr(aMsg.SettingsCaption + ':'), mrNone,
     TnsSimpleIntegerValueMap.Make(imap_Dummy, l_ChoicesArray));
    Hint := aMsg.LongHint;
   end;
  end;//if l_Choices.Count = 0
 finally
  FreeAndNil(l_Choices);
 end;
end;*)

class function TnsConfigSettingsInfo.Make(const aConfig: IConfiguration;
 aDuplicateNameChecker: InsDuplicateConfigNameChecker): InsConfigSettingsInfo;
var
 l_Config: TnsConfigSettingsInfo;
begin
 l_Config := TnsConfigSettingsInfo.Create(aConfig, aDuplicateNameChecker);
 try
  Result := l_Config;
 finally
  vcmFree(l_Config);
 end;
end;

function TnsConfigSettingsInfo.MakeEditingSettings: IvcmStrings;
var
 l_NeedClear: Boolean;
 l_Idx: Integer;
begin
 if not TnsConfigurationProperties.HasInstance then
 begin
  f_MakeSettings := true;
  try
   l_NeedClear := not Assigned(f_AppConfig);
   with AppConfig do
    for l_Idx := 0 to Pred(Items.Count) do
     if Assigned(Items.Objects[l_Idx]) then
      if Items.Objects[l_Idx] is TstgNavigatorFormPosition then
       with TstgNavigatorFormPosition(Items.Objects[l_Idx]) do
       begin
        TnsConfigurationProperties.Instance.Add(FloatingSetting);
        TnsConfigurationProperties.Instance.Add(ZoneSetting);
       end
      else
        TnsConfigurationProperties.Instance.Add(Items[l_Idx]);
   if l_NeedClear then
    DoneEditing;
  finally
   f_MakeSettings := false;
  end;
 end;
 Result := TnsConfigurationProperties.Instance;
end;

procedure TnsConfigSettingsInfo.PageSetupNotify(aSender: TObject);
begin
 {$IfNDef Admin}
 if TdmStdRes.MakePageSetup(TnsPageSetup.Make(Configuration)) = mrOk then
  f_DialogsCalled := True;
 {$EndIf  Admin} 
end;

function TnsConfigSettingsInfo.pm_GetConfiguration: IConfiguration;
begin
 Result := Configuration;
end;

function TnsConfigSettingsInfo.pm_GetConfigHint: Il3CString;
begin
 Result := f_ConfigHint;
end;

function TnsConfigSettingsInfo.pm_GetID: LongInt;
begin
 Result := Configuration.GetId;
end;

function TnsConfigSettingsInfo.pm_GetIsOverallModified: Boolean;
begin
 Result := Modified or f_DialogsCalled;
 if Assigned(f_ConfInfo) then
  Result := Result or f_ConfInfo.Changed;
end;

function TnsConfigSettingsInfo.pm_GetConfigName: Il3CString;
begin
 Result := f_ConfigName;
end;

procedure TnsConfigSettingsInfo.RenameConfig(const aName, aHint: Tl3WString);
var
 l_Idx      : Integer;
 l_Error    : EDuplicateConfName;
 l_Modified : Boolean;
begin
 if l3IsNil(aName) and l3IsNil(aHint) then
  exit;
 l_Modified := False;
 If Assigned(f_DuplicateCheckes) and
  InsDuplicateConfigNameChecker(f_DuplicateCheckes).DuplicateName(aName, pm_GetID) then
   begin
    l_Error := EDuplicateConfName.CreateFmt(vcmConstString(str_DuplicateConfigName), [nsEStr(aName)]);
    l_Error.ConfName := l3Str(aName);
    // генерируем исключение о дублировании имени
    raise l_Error;
   end;
 if (not l3IsNil(aName)) and (not l3Same(f_ConfigName, aName)) then
 begin
  f_ConfigName := nsCStr(aName);
  Configuration.SetName(nsIStr(f_ConfigName));
  l_Modified := True;
 end;
 if (not l3IsNil(aHint)) and (not l3Same(f_ConfigHint, aHint)) then
 begin
  f_ConfigHint := nsCStr(aHint);
  Configuration.SetHint(nsIStr(f_ConfigHint));
  l_Modified := True;
 end;
 if l_Modified then
  for l_Idx := f_SubsriberList.Count-1 downto 0 do
   f_SubsriberList[l_idx].InfoChanged;
end;

procedure TnsConfigSettingsInfo.NotifySettingsChanged;
var
 l_Settings: InsSettings;
begin
 if IsActive and
  Supports(afw.Application.Settings, InsSettings, l_Settings) then
 try
  l_Settings.UserSettingsChanged;
 finally
  l_Settings := nil;
 end;//try..finally
end;//NotifySettingsChanged

procedure TnsConfigSettingsInfo.RestoreAllSettings;
var
 l_SettingsInfo: InsEditSettingsInfo;
begin
 vcmDispatcher.BeginRestoreAllSettings;
 try
  // Чтобы приложение получило нотификацию об изменении свойств, использовать
  // f_ManagerConf.Configuration.RestoreDefaultValues (IConfiguration) - нельзя.
  // Т.к. Записываем по умолчанию мы значения только по оговренным спискам
  // (ConfigurationProperties, PageSetupProperties, StyleTableProperties) - двойные
  // стандарты однако.
  // С определенными тормозами надо делать так.

  // по хорошему для f_ManagerConf должен быть свой InsEditSettingsInfo, который
  // будет знать про редакторы таблицы стилей и параметров страницы и уметь делать
  // RestoreAll (в т.ч. и им)
  l_SettingsInfo := TnsStyleTableSettingsInfo.Make(Configuration);
  try
   with TevStyleInterface.Make do
   try
    Changing;
    try
     l_SettingsInfo.Load(True);
     if not l_SettingsInfo.IsActive then
      LoadStyleTableFromSettings;
    finally
     ChangedEx(not l_SettingsInfo.IsActive);
    end;
   finally
    Free;
   end;
  finally
   l_SettingsInfo := nil;
  end;

  l_SettingsInfo := TnsPageSetup.Make(Configuration);
  try
   l_SettingsInfo.Load(True);
  finally
   l_SettingsInfo := nil;
  end;

  f_InRestoreAll := True;
  try
   Load(True);
  finally
   f_InRestoreAll := False;
  end;

  // Для тех настроек которые пишутся в обход всего напрямую в адаптер.
  // Именно эта строчка приводит к cq18536, 18709.
  Configuration.RestoreDefaultValues;

  // И по идее это тоже должно быть излишне...
  (* Перечитываем визуальные компоненты только для активной конфигурации *)
  if IsActive then
  begin
   (* Перечитаем toolbar-ы *)
   g_MenuManager.ReloadAllToolbars;
   g_MenuManager.LoadShortcuts;
   (* Определим положение форм (вставим плавающие навигаторы) *)
   g_Dispatcher.ReinsertForms;
   vcmDispatcher.RestoreFormSize;
   NotifySettingsChanged;
  end;
 finally
  vcmDispatcher.EndRestoreAllSettings;
 end;
end;

procedure TnsConfigSettingsInfo.StyleEditorNotify(aSender: TObject);
begin
 {$If not Defined(Admin) AND not Defined(Monitorings)}
 if (TdmStdRes.OpenStyleEditorAsModal(TnsStyleTableSettingsInfo.Make(Configuration)) = mrOk) then
  f_DialogsCalled := True;
 {$Else}
 Assert(false); 
 {$IfEnd}
end;

procedure TnsConfigSettingsInfo.Subscribe(
  const aSubscriber: InsConfigNotifyRecipient);
begin
 if f_SubsriberList.IndexOf(aSubscriber) = -1 then
  f_SubsriberList.Add(aSubscriber);
end;

procedure TnsConfigSettingsInfo.ToolbarNotify(aSender: TObject);
begin
 if TCustomizeToolsForm.Execute(g_MenuManager, nil) then
  f_DialogsCalled := True;
end;

procedure TnsConfigSettingsInfo.Unsubscribe(
  const aSubscriber: InsConfigNotifyRecipient);
begin
 f_SubsriberList.Remove(aSubscriber);
end;

procedure TnsConfigSettingsInfo.CreateStruct;
var
 l_Node         : TddCustomConfigNode;
 l_Item         : TddBaseConfigItem;
 l_GroupIndex   : Integer;
 l_Map          : InsStringValueMap;
 l_IsEnglish    : Boolean;

 function GetAliasName : AnsiString;
 begin
  Inc(l_GroupIndex);
  Result := Format('AliasName%d', [l_GroupIndex]);
 end;

 procedure AddGUISettings;
 var
  l_Node : TddCustomConfigNode;
 begin
  with AppConfig do
  begin
   l_Node := AddNode('UIOptions', vcmConstString(str_UISettingsCaption));
   //
   AddGroupItem(GetAliasName, vcmConstString(str_pui_Language));
   //
   AddComboBoxItem(nsCStr(pi_IfaceLanguage), l_Map.ValueToDisplayName(nsCStr(pi_IfaceLanguage)),
    nsCStr(dv_IfaceLanguage), nsStringMapManager.Map[smap_pi_IfaceLanguage]);
     Enabled := False;
   //
   AddBooleanItem(nsCStr(pi_ActivateDefaultLanguage), l_Map.ValueToDisplayName(nsCStr(pi_ActivateDefaultLanguage)),
    dv_ActivateDefaultLanguage);
   CloseGroup;
   //
   AddGroupItem(GetAliasName, vcmConstString(str_pui_Navigator));
     AddGroupItem(GetAliasName, vcmConstString(str_pui_LeftNavigator));
       // Положение
       AddComboBoxItem(nsCStr(pi_LeftNavigator), vcmCStr(str_pui_LeftNavigatorPosition),
        Ord(dv_LeftNavigator), nsIntegerMapManager.Map[imap_NavigatorPosition]);
       // Режим автоскрытия
       AddBooleanItem(nsCStr(pi_lnAutoHideFloat), l_Map.ValueToDisplayName(nsCStr(pi_lnAutoHideFloat)), dv_lnAutoHideFloat);
     CloseGroup;
     AddGroupItem(GetAliasName, vcmConstString(str_pui_RightNavigator));
       // Положение
       AddComboBoxItem(nsCStr(pi_RightNavigator), vcmCStr(str_pui_RightNavigatorPosition),
        Ord(dv_RightNavigator), nsIntegerMapManager.Map[imap_NavigatorPosition]);
       // Режим автоскрытия
       AddBooleanItem(nsCStr(pi_rnAutoHideFloat), l_Map.ValueToDisplayName(nsCStr(pi_rnAutoHideFloat)), dv_rnAutoHideFloat);
     CloseGroup;
   CloseGroup;


   // Вкладки основного окна
   AddGroupItem(GetAliasName, vcmConstString(str_pui_MainWindowTabs));
    l_Item := TstgTabbedInterfaceBehaviour.Create(pi_OpenDocumentsFromList, vcmConstString(str_pi_OpenDocumentsFromList));
    AddItem(l_Node, l_Item);
    l_Item := TstgTabbedInterfaceBehaviour.Create(pi_OpenLinksFromDocument, vcmConstString(str_pi_OpenLinksFromDocument));
    AddItem(l_Node, l_Item);    
   CloseGroup;

   AddGroupItem(GetAliasName, vcmConstString(str_pui_MainManu));
    // Вид основного меню
    AddComboBoxItem(nsCStr(pi_MainMenuKind), nsCStr(pui_MainPenuKind + ':'),
     dv_MainMenuKind, nsIntegerMapManager.Map[imap_MainMenuKind]);
    // Последние открытые документы
    AddIntegerItem(nsCStr(pi_RecentlyOpenDocumentsCount), l_Map.ValueToDisplayName(nsCStr(pi_RecentlyOpenDocumentsCount)),
     dv_RecentlyOpenDocumentsCount);
      MinValue := 1;
      MaxValue := max_RecentlyOpenDocumentsCount;
   CloseGroup;
   // Количество элементов истории
  l_Item := TnsHistoryItemsProperty.CreateItem(piHistoryItems, l3Str(l_Map.ValueToDisplayName(nsCStr(piHistoryItems))), dvHistoryItems);
   AddItem(l_Node, l_Item);
     MinValue := cvHistoryItemsMin;
     MaxValue := cvHistoryItemsMax;
   // Журнал работы
   AddIntegerItem(nsCStr(pi_WorkJournalSize), l_Map.ValueToDisplayName(nsCStr(pi_WorkJournalSize)),
    dv_WorkJournalSize);
     MinValue := 1;
     MaxValue := max_WorkJournalSize;

   //
   AddButtonItem(vcmConstString(str_pui_PageSetupButton), PageSetupNotify, nil);
     ButtonPlace := dd_bpBottomRight;
   //
   AddButtonItem(vcmConstString(str_pui_StyleTableButton), StyleEditorNotify, nil);
     ButtonPlace := dd_bpBottomRight;
   //
   AddButtonItem(vcmConstString(str_pui_ToolbarButton), ToolbarNotify, nil);
     ButtonPlace := dd_bpBottomRight;
     // Поскольку настройка тулбаров заточена на прямую работу с MenuManager...
     Enabled := IsActive;
       // Положение

 // Преемственный вид основного меню решили изжить
 // http://mdp.garant.ru/pages/viewpage.action?pageId=434744658
 (* // Вид основного меню:
   AddComboBoxItem(nsCStr(pi_MainMenuType), vcmCStr(str_pui_MainMenuType),
    dv_MainMenuType, nsIntegerMapManager.Map[imap_pi_MainMenuType]);
 *)
  end;
 end;

 procedure AddSystemBehaviour;
 begin
  with AppConfig do
  begin
   l_Node := AddNode('BehaviourSystem',  vcmConstString(str_pui_SystemBehavior));
   // Начало работы
   AddComboBoxItem(nsCStr(pi_OpenOnStart), l_Map.ValueToDisplayName(nsCStr(pi_OpenOnStart)),
    nsCStr(dv_OpenOnStart), nsStringMapManager.Map[smap_pi_OpenOnStart]);
     Hint := vcmConstString(str_pi_OpenOnStartHint);
   // Вкладки
   AddGroupItem(GetAliasName, vcmConstString(str_pui_NavigatorSheets));
     // Основное меню (показывать\не показывать)
     l_Item := AddBooleanItem(nsCStr(pi_Sheets_MainMenu),
                             l_Map.ValueToDisplayName(nsCStr(pi_Sheets_MainMenu)),
                             dv_Sheets_MainMenu);
       Hint := vcmConstString(str_pi_Sheets_MainMenu_Hint);
     // Основное меню (положение формы)
     l_Item := TstgNavigatorFormPosition.Create(cFrmIDMainMenu, vcmConstString(str_pui_cFrmIDMainMenu), l_Item);
     AddItem(l_Node, l_Item);
     LabelTop := False;
     // "Мои документы" (показывать\не показывать)
     l_Item := AddBooleanItem(nsCStr(pi_Sheets_MyDocuments),
                    l_Map.ValueToDisplayName(nsCStr(pi_Sheets_MyDocuments)),
                    dv_Sheets_MyDocuments);
       Hint := vcmConstString(str_pi_Sheets_MyDocuments_Hint);
     // "Мои документы" (положение формы)
     l_Item := TstgNavigatorFormPosition.Create(cFrmIDMyDoc, vcmConstString(str_pui_cFrmIDMyDoc),
      l_Item);
     AddItem(l_Node, l_Item);
     LabelTop := False;
     // Конфигурации (показывать\не показывать)
     l_Item := AddBooleanItem(nsCStr(pi_Sheets_Config),
                    l_Map.ValueToDisplayName(nsCStr(pi_Sheets_Config)),
                    dv_Sheets_Config);
       Hint := vcmConstString(str_pi_Sheets_Config_Hint);
     // Конфигурации (положение формы)
     l_Item := TstgNavigatorFormPosition.Create(cFrmIDConfList, vcmConstString(str_pui_cFrmIDConfList),
      l_Item);
     AddItem(l_Node, l_Item);
     LabelTop := False;
     // Документы на контроле (показывать\не показывать)
     l_Item := AddBooleanItem(nsCStr(piSheetsDocUnderControl),
                             l_Map.ValueToDisplayName(nsCStr(piSheetsDocUnderControl)),
                             dvSheetsDocUnderControl);
       Hint := vcmConstString(str_piSheetsDocUnderControl_Hint);
     // Документы на контроле (положение формы)
     l_Item := TstgNavigatorFormPosition.Create(cFrmIDDocUnderControl,
                                               vcmConstString(str_pui_cFrmIDDocUnderControl),
                                               l_Item);
     AddItem(l_Node, l_Item);
     LabelTop := False;
     // Панель задач (показывать\не показывать)
     l_Item := AddBooleanItem(nsCStr(piSheetsTaskPanel),
                             l_Map.ValueToDisplayName(nsCStr(piSheetsTaskPanel)),
                             dvSheetsTaskPanel);
       Hint := vcmConstString(str_piSheetsTaskPanel_Hint);
     // Панель задач (положение формы)
     l_Item := TstgNavigatorFormPosition.Create(cFrmIDTaskPanel,
                                               vcmConstString(str_pui_cFrmIDTaskPanel),
                                               l_Item);
     AddItem(l_Node, l_Item);
     LabelTop := False;
     // Термины словаря (положение формы)
     l_Item := TstgNavigatorFormPosition.Create(cFrmIDDictionaryTerm,
                                               vcmConstString(str_pui_cFrmIDDictionaryTerm));
     AddItem(l_Node, l_Item);
   CloseGroup;
   AddGroupItem(GetAliasName, vcmConstString(str_pui_Filters)); // Фильтры
     // Карточки поиска
     AddBooleanItem(nsCStr(pi_Search_Sheets_Filters),
                    l_Map.ValueToDisplayName(nsCStr(pi_Search_Sheets_Filters)),
                    dv_Search_Sheets_Filters);
       Hint := vcmConstString(str_pi_Search_Sheets_Filters_Hint);
     // Список
     AddBooleanItem(nsCStr(pi_List_Sheets_Filters),
                    l_Map.ValueToDisplayName(nsCStr(pi_List_Sheets_Filters)),
                    dv_List_Sheets_Filters);
       Hint := vcmConstString(str_pi_List_Sheets_Filters_Hint);
     // Показывать
     l_Item := TstgFilterFormPosition.Create(GetAliasName, vcmConstString(str_pui_SheetPosition));
     AddItem(l_Node, l_Item);

   CloseGroup;
   // Печать и экспорт
   AddGroupItem(pi_evStyles_PrintAndExport, str_PrintAndExport.AsStr);
     // Использовать для экспорта и печати размер шрифта, отображаемого на экране
     l_Item := TddRadioConfigItem.CreateItem(pi_evStyles_PrintAndExport_Default, str_PrintAndExport_Default.AsStr, SHevStyles.PrintAndExportDefaultSetting{False});
     AddItem(l_Node, l_Item);
     LabelTop := False;
     // Использовать для экспорта и печати следующий размер шрифта
     l_Item := TddRadioConfigItem.CreateItem(pi_evStyles_PrintAndExport_Custom, str_PrintAndExport_Custom.AsStr, SHevStyles.PrintAndExportCustomSetting{True});
     AddItem(l_Node, l_Item);
     LabelTop := False;

     AddItem(l_Node, TstevStylesPrintAndExportFontSizeItem.Create(l_Item));
(*     AddComboBoxItem(nsCStr(GetAliasName), vcmCStr(str_EmptyStr),
       Ord(pef12), TPrintAndExportFontSizeMapImpl.Make, l_Item);*)
     LabelTop := False;
   CloseGroup;
   AddBooleanItem(nsCStr(pi_DayTips_DontShowAtStart),
                  l_Map.ValueToDisplayName(nsCStr(pi_DayTips_DontShowAtStart)),
                  dv_DayTips_DontShowAtStart);
    Hint := vcmConstString(str_pi_DayTips_DontShowAtStart_Hint);
   AddBooleanItem(nsCStr(pi_PlayBeepOnMistake),
                  l_Map.ValueToDisplayName(nsCStr(pi_PlayBeepOnMistake)),
                  dv_PlayBeepOnMistake);
    Hint := vcmConstString(str_pi_PlayBeepOnMistake_Hint);

   AddBooleanItem(nsCStr(pi_NotifyNewChatMesages),
                  l_Map.ValueToDisplayName(nsCStr(pi_NotifyNewChatMesages)),
                  dv_PlayBeepOnMistake);
    Hint := vcmConstString(str_pi_NotifyNewChatMesages_Hint);
   if (afw.Application.LocaleInfo.Language <> afw_lngEnglish) then
   begin
    f_EnableMSOIntegration := AddBooleanItem(nsCStr(pi_EnableMSOfficeIntegration),
                  l_Map.ValueToDisplayName(nsCStr(pi_EnableMSOfficeIntegration)),
                  dv_EnableMSOfficeIntegration);
    Hint := vcmConstString(str_pi_EnableMSOfficeIntegration_Hint);
   end;
   {l_Item := TstDocumentUseFixedFontForPrintAndExportItem.Create;
   AddItem(l_Node, l_Item);}
   
   // Подтверждения
   l_Node := AddChild(GetAliasName, vcmConstString(str_pui_Asknoweladgemets));
   LoadMessage(str_MayExit.AsMessage, l_Node);
   LoadMessage(qr_ConfigurationDelete, l_Node);
   LoadMessage(qr_SaveAsDefaultValuesConf, l_Node);
   LoadMessage(qr_StyleTableChanged, l_Node);
   LoadMessage(qr_RestoreDefaultValuesPageSetup, l_Node);
   LoadMessage(qr_SaveAsDefaultValuesPageSetup, l_Node);
   LoadMessage(qr_RestoreDefaultValuesStyleTable, l_Node);
   LoadMessage(qr_SaveAsDefaultValuesStyleTable, l_Node);
   CloseChild;
  end;
 end;

 procedure AddSearch;
 begin
  with AppConfig do
  begin
   l_Node := AddNode('Search', vcmConstString(str_pui_Search));
   AddGroupItem(GetAliasName, vcmConstString(str_pui_QueryCards));
   //
   l_Item := AddComboBoxItem(nsCStr(pi_Search_SituationType), l_Map.ValueToDisplayName(nsCStr(pi_Search_SituationType)),
    nsCStr(dv_Search_SituationType), nsStringMapManager.Map[smap_pi_Search_SituationType], nil, li_Search_SituationType_Disable);
     Hint := vcmConstString(str_pi_Search_SituationType_Hint);
   //
   CloseGroup;
   //

   // Укороченные списки в БП
   l_Item := TstgShortList.Create;
   AddItem(l_Node, l_Item);
   Hint := vcmConstString(str_pi_BaseSearch_BuildShortList_Hint);

   l_Node := AddChild(GetAliasName, vcmConstString(str_pui_Asknoweladgemets));
   // Построение списка
    AddGroupItem(GetAliasName, vcmConstString(str_pui_FIlter_BuildList));
    l_Item := AddBooleanItem(nsCStr(pi_Search_List_IsBuild),
                            l_Map.ValueToDisplayName(nsCStr(pi_Search_List_IsBuild)),
                            dv_Search_List_IsBuild);
    Hint := vcmConstString(str_pi_Search_List_IsBuild_Hint);
    AddIntegerItem(nsCStr(pi_Search_List_BuildCount),
                   l_Map.ValueToDisplayName(nsCStr(pi_Search_List_BuildCount)),
                   dv_Search_List_BuildCount, l_Item);
      MinValue := 0;
    CloseGroup;
   // Построение автореферата
    AddGroupItem(GetAliasName, vcmConstString(str_pui_Filter_BuildReview));
    l_Item := AddBooleanItem(nsCStr(piSearchListIsBuildReview),
                            l_Map.ValueToDisplayName(nsCStr(piSearchListIsBuildReview)),
                            dvSearchListIsBuildReview);
    Hint := vcmConstString(str_piSearchListIsBuildReview_Hint);
    AddIntegerItem(nsCStr(piSearchListBuildCountReview),
                   l_Map.ValueToDisplayName(nsCStr(piSearchListBuildCountReview)),
                   dvSearchListBuildCountReview, l_Item);
      MinValue := 0;
    CloseGroup;
   //
   CloseChild;
  end;
 end;

 procedure AddList;
 begin
  with AppConfig do
  begin
   l_Node := AddNode('List', vcmConstString(str_pui_List));
   AddGroupItem(GetAliasName, vcmConstString(str_pui_DefaultSort));
    // Тип сортировки
    AddComboBoxItem(nsCStr(pi_List_SortType),
                    l_Map.ValueToDisplayName(nsCStr(pi_List_SortType)),
                    dv_List_SortType,
                    nsIntegerMapManager.Map[imap_pi_List_SortType]);
    // Порядок
    AddComboBoxItem(nsCStr(pi_List_OrderType),
                    l_Map.ValueToDisplayName(nsCStr(pi_List_OrderType)),
                    dv_List_OrderType,
                    nsIntegerMapManager.Map[imap_pi_List_OrderType]);
   CloseGroup;
   // Открывать в новом окне
  (* AddBooleanItem(nsCStr(pi_List_OpenInNewWindow),
                  l_Map.ValueToDisplayName(nsCStr(pi_List_OpenInNewWindow)),
                  dv_List_OpenInNewWindow);
   Hint := vcmConstString(str_pi_List_OpenInNewWindow_Hint);*)
   // Автоматический переход
   AddBooleanItem(nsCStr(pi_List_AutoTransfer),
                  l_Map.ValueToDisplayName(nsCStr(pi_List_AutoTransfer)),
                  dv_List_AutoTransfer);
   Hint := vcmConstString(str_pi_List_AutoTransfer_Hint);
   AddGroupItem(GetAliasName, vcmConstString(str_pi_List_PrintOnlyFirstLevel));
   // Печатать только первый уровень
   AddBooleanItem(nsCStr(pi_DocumentList_PrintOnlyFirstLevel),
                  l_Map.ValueToDisplayName(nsCStr(pi_DocumentList_PrintOnlyFirstLevel)),
                  dv_DocumentList_PrintOnlyFirstLevel);
   if (afw.Application.LocaleInfo.Language <> afw_lngEnglish) then
    AddBooleanItem(nsCStr(pi_DrugList_PrintOnlyFirstLevel),
                   l_Map.ValueToDisplayName(nsCStr(pi_DrugList_PrintOnlyFirstLevel)),
                   dv_DrugList_PrintOnlyFirstLevel);
   CloseGroup;
   // Форма зоны синхронного просмотра:
   AddBooleanItem(nsCStr(pi_List_ShowAnnotationByDefault),
                  l_Map.ValueToDisplayName(nsCStr(pi_List_ShowAnnotationByDefault)),
                  dv_List_ShowAnnotationByDefault);
   Hint := vcmConstString(str_pi_List_ShowAnnotationByDefault_Hint);
   // Ограничения при эксопрте
   if afw.Application.IsInternal then
    AddBooleanItem(nsCStr(pi_List_ExportWORestrictions),
                   l_Map.ValueToDisplayName(nsCStr(pi_List_ExportWORestrictions)),
                   dv_List_ExportWORestrictions);
   // Подтверждения
   l_Node := AddChild(GetAliasName, vcmConstString(str_pui_Asknoweladgemets));
     LoadMessage(qr_DeleteListSelected, l_Node);
     AddGroupItem(GetAliasName, vcmConstString(str_pui_ListSelectionsAsk));
     LoadMessage(str_ListExportSelectionToWord.AsMessage, l_Node);
     LoadMessage(str_ListEMailSelection.AsMessage, l_Node);
     LoadMessage(str_ListPrintSelectedConfirmation.AsMessage, l_Node);
     CloseGroup;
   CloseChild;
  end;
 end;

 procedure AddDocument;
 begin
  with AppConfig do
  begin
   l_Node := AddNode('Document', vcmConstString(str_pui_DOcument));
   f_DocumentNode := l_Node;
   // Открывать ссылки в новом окне
(*   AddBooleanItem(nsCStr(pi_Document_OpenInNewWindow),
                  l_Map.ValueToDisplayName(nsCStr(pi_Document_OpenInNewWindow)),
                  dv_Document_OpenInNewWindow); *)
   Hint := vcmConstString(str_pi_Document_OpenInNewWindow_Hint);
   // Показывать предупреждение
   AddBooleanItem(nsCStr(pi_Document_Warning),
                  l_Map.ValueToDisplayName(nsCStr(pi_Document_Warning)),
                  dv_Document_Warning);
   Hint := vcmConstString(str_pi_Document_Warning_Hint);
   // Показывать информацию о документе:
   l_Item := AddBooleanItem(nsCStr(pi_Document_Sheets_Attributes),
                           l_Map.ValueToDisplayName(nsCStr(pi_Document_Sheets_Attributes)),
                           dv_Document_Sheets_Attributes);
   Hint := vcmConstString(str_pi_Document_Sheets_Attributes_Hint);
   // Показывать перевод текста:
   l_Item := AddBooleanItem(nsCStr(pi_Document_Sheets_Translation),
                           l_Map.ValueToDisplayName(nsCStr(pi_Document_Sheets_Translation)),
                           dv_Document_Sheets_Translation);
   Hint := vcmConstString(str_pi_Document_Sheets_Translation_Hint);
   // Эксопртировать с заголовками:
   l_Item := AddBooleanItem(nsCStr(pi_Document_ExportWithBlockNames),
                           l_Map.ValueToDisplayName(nsCStr(pi_Document_ExportWithBlockNames)),
                           dv_Document_ExportWithBlockNames);
   Hint := vcmConstString(str_pi_Document_ExportWithBlockNames_Hint);
   // Версионные комментарии:
   l_Item := TstgShowVersionComments.Create;
   AddItem(l_Node, l_Item);
   // По ссылке в информации об изменениях в тексте документа открывать

   //if (afw.Application.LocaleInfo.Language <> afw_lngEnglish) then
   begin
    l_Item := TstgVersionCommentLinkBehaviour.Create;
    AddItem(l_Node, l_Item);

(*   l_Item := AddBooleanItem(nsCStr(pi_Document_ShowVersionsComment),
                           l_Map.ValueToDisplayName(nsCStr(pi_Document_ShowVersionsComment)),
                           dv_Document_ShowVersionsComment);*)
    Hint := str_pi_Document_ShowVersionsComment_Hint.AsStr;
   end;

   l_Item := TstDocumentShowChangesInfoItem.Create;
   AddItem(l_Node, l_Item);

   // Масштаб картинки
   l_Item := TstgScalePicture.Create;
   AddItem(l_Node, l_Item);
   Hint := vcmConstString(str_piDocumentPictureScale_Hint);
   // Выделение текста
   l_Item := TstgTextSelection.Create;
   AddItem(l_Node, l_Item);
   Hint := vcmConstString(str_pi_Document_PermanentSelection_Hint);
   // Показ корреспондентов\респондентов
   AddGroupItem(GetAliasName, vcmConstString(str_pui_Correst_Rest_ShowMethod));
     f_UserCR1SheetType := AddComboBoxItem(nsCStr(pi_Document_CRSheet0), l_Map.ValueToDisplayName(nsCStr(pi_Document_CRSheet0)),
      dv_Document_CRSheet0, nsIntegerMapManager.Map[imap_lstCRType], nil, li_Document_CRSheet0_Disable);
     f_UserCR1Type := AddComboBoxItem(nsCStr(pi_Document_CRType0), l_Map.ValueToDisplayName(nsCStr(pi_Document_CRType0)),
      nsCStr(dv_Document_CRType0), nsStringMapManager.Map[smap_SettingsCRType], f_UserCR1SheetType);
       LabelTop := False;

     f_UserCR2SheetType := AddComboBoxItem(nsCStr(pi_Document_CRSheet1), l_Map.ValueToDisplayName(nsCStr(pi_Document_CRSheet1)),
      dv_Document_CRSheet1, nsIntegerMapManager.Map[imap_lstCRType], nil, li_Document_CRSheet1_Disable);
     f_UserCR2Type := AddComboBoxItem(nsCStr(pi_Document_CRType1), l_Map.ValueToDisplayName(nsCStr(pi_Document_CRType1)),
      nsCStr(dv_Document_CRType1), nsStringMapManager.Map[smap_SettingsCRType], f_UserCR2SheetType);
       LabelTop := False;
   CloseGroup;

   // Вкладки
   AddGroupItem(GetAliasName, vcmConstString(str_pui_Document_Sheets));
   l_Item := AddBooleanItem(nsCStr(pi_Document_Sheets_Redactions),
                           l_Map.ValueToDisplayName(nsCStr(pi_Document_Sheets_Redactions)),
                           dv_Document_Sheets_Redactions);
     Hint := vcmConstString(str_pi_Document_Sheets_Redactions_Hint);
   l_Item := TstgNavigatorFormPosition.Create(cFrmIDRedations, vcmConstString(str_pui_cFrmIDRedations),
    l_Item);
   AddItem(l_Node, l_Item);
   CloseGroup;
   // Поля
   AddChild(GetAliasName, vcmConstString(str_piu_Document_SubPanel));
   AddBooleanItem(nsCStr(pi_Document_SubPanel_ShowBlocks),
                  l_Map.ValueToDisplayName(nsCStr(pi_Document_SubPanel_ShowBlocks)),
                  dv_Document_SubPanel_ShowBlocks);
   AddBooleanItem(nsCStr(pi_Document_SubPanel_ShowBookmarks),
                  l_Map.ValueToDisplayName(nsCStr(pi_Document_SubPanel_ShowBookmarks)),
                  dv_Document_SubPanel_ShowBookmarks);
   AddBooleanItem(nsCStr(pi_Document_SubPanel_ShowJurorComments),
                  l_Map.ValueToDisplayName(nsCStr(pi_Document_SubPanel_ShowJurorComments)),
                  dv_Document_SubPanel_ShowJurorComments);
   AddBooleanItem(nsCStr(pi_Document_SubPanel_ShowUserComments),
                  l_Map.ValueToDisplayName(nsCStr(pi_Document_SubPanel_ShowUserComments)),
                  dv_Document_SubPanel_ShowUserComments);
   AddBooleanItem(nsCStr(pi_Document_SubPanel_ShowVersionComments),
                  l_Map.ValueToDisplayName(nsCStr(pi_Document_SubPanel_ShowVersionComments)),
                  dv_Document_SubPanel_ShowVersionComments);
   CloseChild;
   // Подтверждения
   l_Node := AddChild(GetAliasName, vcmConstString(str_pui_Asknoweladgemets));
   LoadMessage(qr_OpenExternalQuery, l_Node);
   AddGroupItem(GetAliasName, vcmConstString(str_pui_SelectionsAsk));
   LoadMessage(str_ExportSelectionToWord.AsMessage, l_Node);
   LoadMessage(str_DocumentEMailSelection.AsMessage, l_Node);
   LoadMessage(str_PrintSelectedConfirmation.AsMessage, l_Node);
   CloseGroup;
   LoadMessage(qr_DropChangeStatusToDoc, l_Node);
   if defDataAdapter.RevisionCheckEnabled then
    AddBooleanItem(nsCStr(pi_Document_ForceAskForIntranet),
                   l_Map.ValueToDisplayName(nsCStr(pi_Document_ForceAskForIntranet)),
                   dv_Document_ForceAskForIntranet);
   //LoadMessage(str_InActualDocumentAction.AsMessage, l_Node);
   // http://mdp.garant.ru/pages/viewpage.action?pageId=278832944&focusedCommentId=294591153#comment-294591153
   LoadMessage(inf_HyperlinkToDocumentProducerLinkMade, l_Node);
   CloseChild;
  end;
 end;

 procedure AddMyDoc;
 begin
  with AppConfig do
  begin
   AddNode('MyDocument', vcmConstString(str_pui_MyDocument));
//   AddBooleanItem(nsCStr(pi_OpenInNewWindow), l_Map.ValueToDisplayName(nsCStr(pi_OpenInNewWindow)),
//    dv_OpenInNewWindow);
//   Hint := vcmConstString(str_pi_OpenInNewWindow_Hint);
   // Подтверждения
   l_Node := AddChild(GetAliasName, vcmConstString(str_pui_Asknoweladgemets));
    LoadMessage(qr_FolderEmptyQuery, l_Node);
    LoadMessage(qr_ObjectDelete, l_Node);
    LoadMessage(qr_SaveItemQuery, l_Node);
    LoadMessage(qr_FolderSave, l_Node);
    LoadMessage(qr_QueryWasSavedEx, l_Node);
    LoadMessage(qr_QueryIsEmpty, l_Node);
    LoadMessage(qr_FilterWasSaved, l_Node);
    LoadMessage(qr_DeleteFilter, l_Node);
   CloseChild;
  end;
 end;

 procedure AddDocInControl;
 begin
  with AppConfig do
  begin
   AddNode('DocOnControl', vcmConstString(str_pui_ControlledDocuments));
   AddComboBoxItem(nsCStr(pi_DropChangeStatus), l_Map.ValueToDisplayName(nsCStr(pi_DropChangeStatus)),
    nsCStr(dv_DropChangeStatus), nsStringMapManager.Map[smap_pi_DropChangeStatus]);
     Hint := vcmConstString(str_pi_DropChangeStatus_Hint);
   // Подтверждения
   l_Node := AddChild(GetAliasName, vcmConstString(str_pui_Asknoweladgemets));
   LoadMessage(qr_RemoveControlStatus, l_Node);
   LoadMessage(qr_SetControlStatus, l_Node);
   LoadMessage(qr_DelControlStatus, l_Node);
   LoadMessage(inf_SetDocToControl, l_Node);
   LoadMessage(qr_RemoveDocumentFromControl, l_Node);
   LoadMessage(qr_DropChangeStatusToSelected, l_Node);
   LoadMessage(qr_DropChangeStatusToOpened, l_Node);
   LoadMessage(qr_DropChangeStatusAllObjects, l_Node);
   LoadMessage(str_ChangedDocumentOnControl.AsMessage, l_Node);
   CloseChild;
  end;
 end;

 procedure AddConsultations;
 const
  lc_ButtonMaps: TnsButtonCaptionArray = (
   @str_pui_ask_ShowDialog, @str_pui_ask_DoNotShowDialog, @str_pui_ask_OK, @str_pui_ask_Cancel,
   @str_pui_ask_Abort, @str_pui_ask_Retry, @str_pui_ask_Ignore, @str_pui_ask_All,
   @str_pui_ask_NoToAll, @str_pui_ask_YesToAll, @str_pui_ask_Help {$IfDef XE}, nil{$EndIf});
 begin
  with AppConfig do
  begin
   l_Node := AddNode('Consultations', vcmConstString(str_pui_ConsultationsAsknoweladgemets));
   AddGroupItem(GetAliasName, vcmConstString(str_pui_Asknoweladgemets));
    LoadMessage(inf_ConsultationSuccessSend, l_Node);
    // http://mdp.garant.ru/pages/viewpage.action?pageId=423620375
    if (not l_IsEnglish) then
    begin
     LoadMessage(inf_PaymentConfirmed, l_Node);
     LoadMessage(inf_PaymentRejected, l_Node);
    end;
    LoadMessage(qr_CloseUnmarkedConsultation, l_Node, @lc_ButtonMaps);
    LoadMessage(qr_TryOpenConsultationAnswer, l_Node);
    LoadMessage(qr_CheckLegalAdviseAvailable, l_Node);
    LoadMessage(inf_ConsultationSuccessCheck, l_Node);
   CloseGroup;
  end;
 end;

 procedure AddContextFilterParams;

   procedure lpAddSettings;
   var
    lIndex  : Integer;
    lCaptionMap: InsStringValueMap;
    l_FilterParamsInfo: InsContextFilterParamsInfo;
   begin
    lCaptionMap := nsStringMapManager.Map[smap_ContextParamsCaptions];
    with AppConfig do
     for lIndex := Low(SupportedContextsFilterRoots) to High(SupportedContextsFilterRoots) do
     begin
      if (afw.Application.LocaleInfo.Language = afw_lngEnglish) and
         ((SupportedContextsFilterRoots[lIndex] = AT_CLASS_REVIEW) or
          (SupportedContextsFilterRoots[lIndex] = AT_SOURCE_REVIEW)) then
       Continue;
      if Supports(TnsContextFilterParams.Make(SupportedContextsFilterRoots[lIndex]),
           InsContextFilterParamsInfo, l_FilterParamsInfo) then
       with l_FilterParamsInfo do
       try
        AddCaptionElement(l3Str(lCaptionMap.ValueToDisplayName(nsCStr(BaseSettingID))));
        // Идентификаторы настроек
        AddAlias(WordPositionSettingID);
        AddAlias(WordOrderSettingID);
        AddAlias(TreeLevelDistSettingID);
       finally
        l_FilterParamsInfo := nil;
       end;
     end;
   end;

 begin
   with AppConfig do
   begin
    AddNode('ContextParamsNode', vcmConstString(str_pui_ContextFilter));
    // MasterSlaveItem
    AddMasterSlaveItem(GetAliasName, vcmConstString(str_pui_ContextFilterParams));
    try
     // Положение контекста
     AddComboBoxItem(nsCStr(GetAliasName), vcmCStr(str_pui_COntextWordPosition),
      Ord(Low(Tl3WordPosition)), TWordPositionNamesMapImpl.Make);
      Hint := str_nsc_cpmWordPositionHint.AsStr;
     // Порядок слов
     AddComboBoxItem(nsCStr(GetAliasName), vcmCStr(str_pui_ContextWordOrder),
      Ord(Low(Tl3WordOrder)), TWordOrderNamesMapImpl.Make);
      Hint := str_nsc_cpmWordOrderHint.AsStr;
     // Область поиска
     AddComboBoxItem(nsCStr(GetAliasName), vcmCStr(str_pui_COntextSearchArea),
      Ord(Low(Tl3TreeLevelDist)), TTreeLevelDistNamesMapImpl.Make);
      Hint := str_nsc_cpmTreeLevelDistHint.AsStr;
     // Добавим список настроек
     lpAddSettings;
    finally
     CloseMasterSlaveItem;
    end;
   end;
 end;

 procedure AddAdmin;
 begin
  with AppConfig do
  begin
   l_Node := AddNode('Admin', vcmConstString(str_pui_AdminAsknoweladgemets));
   AddGroupItem(GetAliasName, vcmConstString(str_pui_Asknoweladgemets));
    LoadMessage(qr_DeleteUser, l_Node);
    LoadMessage(qr_DeleteUsers, l_Node);
    LoadMessage(qr_LogoutUsers, l_Node);
    LoadMessage(inf_UsersDeleted, l_Node);
    LoadMessage(inf_MultiplyChangeConsulting, l_Node);
    LoadMessage(inf_LogoutUsersNotify, l_Node);
    LoadMessage(inf_LogoutUserNotify, l_Node);
    LoadMessage(inf_MultiplyChangePrivilegedUsers, l_Node);
    LoadMessage(qr_DeleteGroup, l_Node);
   CloseGroup;
  end;
 end;

begin
 l_IsEnglish := afw.Application.LocaleInfo.Language = afw_lngEnglish;
 l_Map := nsStringMapManager.Map[smap_Settings];
 l_GroupIndex := -1;
 AppConfig.AutoSize := True;
 // Информация о конфигурации
 f_ConfInfo := TnsConfInfoNode.Create('ConfInfo', vcmConstString(str_cnCaption),
  Self);
 AppConfig.AddUserNode(f_ConfInfo);
 // Настройки интерфейса
 AddGUISettings;
 // Поведение системы
 AddSystemBehaviour;
 // Работа с рубрикатором
 // AddRubricator;
 // Работа с поиском
 AddSearch;
 // Работа со списком
 AddList;
 // Работа с документом
 AddDocument;
 // Работа с ''Моими документами''
 AddMyDoc; 
 // Документы на контроле
 AddDocInControl;
 // Консультации подтверждения
 if DefDataAdapter.HasConsultations then
  AddConsultations;
 // Параметры контекстной фильтрации
 AddContextFilterParams;
 // Параметры контекстной фильтрации
 if defDataAdapter.AdministratorLogin then
  AddAdmin;
 // Загрузим данные
 if Assigned(f_Storage) and not f_MakeSettings and not f_InProcess then
 begin
  Load(False);
  // Экспорт настроек
  {$IfDef nsExportSettings}
  ExportSettings;
  {$EndIf nsExportSettings}
 end;
end;

function TnsConfigSettingsInfo.GetModalResult(aBtn: TMsgDlgBtn): longint;
begin
 Result := 65535;
 case aBtn of
  mbYes:      Result := mrYes;
  mbNo:       Result := mrNo;
  mbOk:       Result := mrOk;
  mbCancel:   Result := mrCancel;
  mbAbort:    Result := mrAbort;
  mbRetry:    Result := mrRetry;
  mbIgnore:   Result := mrIgnore;
  mbAll:      Result := mrAll;
  mbNoToAll:  Result := mrNoToAll;
  mbYesToAll: Result := mrYesToAll;
 end;
end;

procedure TnsConfigSettingsInfo.DoAfterLoad(aRestoreDefault: Boolean);
begin
 inherited DoAfterLoad(aRestoreDefault);
 if aRestoreDefault and not f_InRestoreAll then
 begin
  if IsActive then
   g_Dispatcher.ReinsertForms;
  NotifySettingsChanged;
 end;//if aRestoreDefault and not f_InRestoreAll then
 if Assigned(f_AppConfig) then
  f_AppConfig.Changed := False;
end;//DoAfterLoad

procedure TnsConfigSettingsInfo.DoAfterSave(aSaveAsDefault: Boolean);
begin
 try
  inherited DoAfterSave(aSaveAsDefault);
  if f_NeedReinsertFormsAfterSave then
   g_Dispatcher.ReinsertForms;
  if f_AppConfig.Changed then
   NotifySettingsChanged;
  if Assigned(f_AppConfig) then
   f_AppConfig.Changed := False;
 finally
  f_NeedReinsertFormsAfterSave := False;
 end;
end;

function TnsConfigSettingsInfo.DoGetModified: Boolean;
begin
 Result := Inherited DoGetModified;
 if Assigned(f_AppCOnfig) then
  Result := Result or f_AppConfig.IsSettingsChanged;
end;

function TnsConfigSettingsInfo.DoSettingChanged(
  const aSettingId: TvcmSettingId): Boolean;
begin
 Result := not f_InProcess and (EditingSettings.IndexOf(aSettingId)<>-1);
 if Result then
  CheckDifferFromDefault
end;

procedure TnsConfigSettingsInfo.SettingsReplaceFinish;
begin
 inherited;
 CheckDifferFromDefault;
end;//SettingsReplaceFinish

constructor TstgVersionCommentLinkBehaviour.Create(aMasterItem: TddBaseConfigItem = nil);
var
 lValue : TddConfigValue;
begin
 l3FillChar(lValue, SizeOf(lValue), 0);
 lValue.Kind := dd_vkBoolean;
 lValue.AsBoolean := dv_Document_ShowVersionCommentsLinkBehaviour;
 inherited Create(pi_Document_ShowVersionCommentsLinkBehaviour,
  str_pi_Document_ShowVersionCommentsLinkBehaviour.AsStr,
  lValue, TVersionCommentsLinkBegaviourMapImpl.Make, aMasterItem);
end;//TstgVersionCommentLinkBehaviour.Create

{ TstgShortList }

constructor TstgShortList.Create(aMasterItem: TddBaseConfigItem);
var
 lValue : TddConfigValue;
begin
 l3FillChar(lValue, SizeOf(lValue), 0);
 lValue.Kind := dd_vkBoolean;
 lValue.AsBoolean := dv_BaseSearch_BuildShortList;
 inherited Create(pi_BaseSearch_BuildShortList,
  l3Str(nsStringMapManager.Map[smap_Settings].ValueToDisplayName(nsCStr(pi_BaseSearch_BuildShortList))),
  lValue, nsIntegerMapManager.Map[imap_pi_BaseSearch_BuildShortList], aMasterItem);
end;

{$IfEnd} //not Admin AND not Monitorings

end.

