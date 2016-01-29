unit vcmForm;
{* Базовый класс форм приложения построенного на библиотеке vcm. }

{ Библиотека "vcm"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcm -           }
{ Начат: 24.02.2003 13:45 }
{ $Id: vcmForm.pas,v 1.284 2015/09/30 09:23:03 morozov Exp $ }

// $Log: vcmForm.pas,v $
// Revision 1.284  2015/09/30 09:23:03  morozov
// {RequestLink: 607522449}
//
// Revision 1.283  2015/09/09 13:51:58  kostitsin
// {requestlink: 606817704 }
//
// Revision 1.282  2015/09/03 12:25:04  morozov
// {RequestLink: 606410551}
//
// Revision 1.281  2015/03/24 17:50:23  kostitsin
// {requestlink: 588833931 }
//
// Revision 1.280  2015/03/18 11:20:26  lulin
// - упорядочиваем генерацию зависимостей.
//
// Revision 1.279  2015/02/25 13:11:47  lulin
// - перегенерация.
//
// Revision 1.278  2015/01/16 15:07:45  kostitsin
// {requestlink: 585429385 }
//
// Revision 1.277  2015/01/16 15:05:07  kostitsin
// {requestlink: 585429385 }
//
// Revision 1.276  2015/01/15 18:05:06  kostitsin
// {requestlink: 585429385 }
//
// Revision 1.275  2014/11/12 09:00:30  morozov
// {RequestLink: 571653443}
//
// Revision 1.274  2014/10/07 06:14:58  morozov
// {RequestLink: 566113866}
//
// Revision 1.273  2014/09/30 08:46:45  morozov
// {RequestLink: 565492823}
//
// Revision 1.272  2014/09/10 10:57:22  kostitsin
// {requestlink: 564997003 }
//
// Revision 1.271  2014/08/29 16:35:04  kostitsin
// {requestlink: 564734118 }
//
// Revision 1.270  2014/07/03 05:40:35  morozov
// {RequestLink: 340174500}
//
// Revision 1.269  2014/05/21 10:03:01  morozov
// {RequestLink: 518765917}
//
// Revision 1.268  2013/05/21 08:29:20  lulin
// - собираем тестовый проект нового генератора под XE3.
//
// Revision 1.267  2013/05/07 07:21:23  morozov
// {RequestLink:453162055}
//
// Revision 1.266  2013/05/06 12:22:15  morozov
// {RequestLink:453150513}
//
// Revision 1.265  2013/04/25 14:22:38  lulin
// - портируем.
//
// Revision 1.264  2013/04/08 09:28:02  lulin
// - портируем.
//
// Revision 1.263  2013/04/05 12:02:41  lulin
// - портируем.
//
// Revision 1.262  2012/11/02 09:16:37  lulin
// - выкидываем лишнее.
//
// Revision 1.261  2012/08/10 14:22:09  lulin
// - bug fix: не собирались библиотеки.
//
// Revision 1.260  2012/08/06 17:26:07  lulin
// {RequestLink:380046115}
//
// Revision 1.259  2012/05/28 16:50:18  kostitsin
// [$367201314]
//
// Revision 1.257  2012/04/13 14:38:46  lulin
// {RequestLink:237994598}
//
// Revision 1.256  2012/04/09 09:03:28  lulin
// {RequestLink:237994598}
// - думаем о VGScene.
//
// Revision 1.255  2012/04/09 06:14:07  lulin
// {RequestLink:237994598}
//
// Revision 1.254  2012/04/04 17:55:45  lulin
// {RequestLink:237994598}
// - разбираемся с упавшими тестами.
//
// Revision 1.253  2012/03/22 14:57:38  lulin
// - заготовочка.
//
// Revision 1.252  2012/02/01 16:20:29  lulin
// {RequestLink:332566005}
//
// Revision 1.251  2012/01/27 17:49:47  lulin
// {RequestLink:321989072}
//
// Revision 1.250  2011/12/13 12:35:54  gensnet
// http://mdp.garant.ru/pages/viewpage.action?pageId=290948175
//
// Revision 1.249  2011/10/04 10:56:52  lulin
// {RequestLink:289933577}.
//
// Revision 1.248  2011/06/28 17:53:29  lulin
// {RequestLink:254944102}.
//
// Revision 1.247  2011/06/27 14:56:42  lulin
// {RequestLink:254944102}.
// [$271749095].
//
// Revision 1.246  2011/06/27 13:54:33  lulin
// {RequestLink:254944102}.
//
// Revision 1.245  2011/06/27 09:38:25  lulin
// {RequestLink:269078978}.
//
// Revision 1.244  2011/06/23 17:01:35  lulin
// {RequestLink:254944102}.
//
// Revision 1.243  2011/06/23 12:03:46  dinishev
// [$269080484]. Поддержка Wait:XXX на уровне _vtDialogs
//
// Revision 1.242  2011/06/14 13:37:44  lulin
// {RequestLink:269063487}.
//
// Revision 1.241  2011/06/03 09:54:02  dinishev
// Переносим общие слова из F1
//
// Revision 1.240  2011/05/27 16:05:12  lulin
// {RequestLink:266425723}.
//
// Revision 1.239  2011/04/28 12:53:07  lulin
// {RequestLink:259892768}.
// - делаем тест модификации списка.
//
// Revision 1.238  2011/04/20 11:45:20  lulin
// {RequestLink:263292879}.
// - подготавливаем инфраструктуру для возможности прятанья не VCM форм. Правда - пока не понадобилось - ошибка сама собой рассосалась.
//
// Revision 1.237  2011/04/14 14:39:53  lulin
// - в случае диалога об ошибке поднимаем Exception.
//
// Revision 1.236  2011/04/14 11:20:56  lulin
// {RequestLink:233013564}.
// №14.
//
// Revision 1.235  2011/04/12 15:30:50  lulin
// {RequestLink:195757811}.
//
// Revision 1.234  2011/04/04 16:47:30  lulin
// {RequestLink:259175088}.
//
// Revision 1.233  2011/04/04 16:03:39  lulin
// {RequestLink:259175088}.
//
// Revision 1.232  2011/02/28 14:08:39  lulin
// {RequestLink:254944075}.
// - чистка кода.
//
// Revision 1.231  2011/02/21 15:51:10  lulin
// {RequestLink:253659765}.
// - с ломом и такой-то матерью восстанавливаем сквозное хождение по контролам по Tab при наличии сцены.
//
// Revision 1.230  2011/02/17 13:37:57  lulin
// {RequestLink:253659765}.
// - транслируем Tab из VCL в VGScene.
//
// Revision 1.229  2011/02/11 18:16:30  vkuprovich
// {RequestLink:253231185]
//
// Revision 1.228  2011/02/10 14:15:35  vkuprovich
// {RequestLink:252519357]
// Диалог "Выход" переведен на новый стиль
//
// Revision 1.227  2011/02/08 16:46:07  vkuprovich
// {RequestLink:253231216]
// Чекбокс запоминает дефолтный выбор
//
// Revision 1.226  2011/02/07 18:33:49  vkuprovich
// {RequestLink:252519379]
// Чекбокс умеет умеет запоминать дефолтный выбор.
//
// Revision 1.225  2010/12/07 15:55:09  lulin
// {RequestLink:228688602}.
// - что-то задышало.
//
// Revision 1.224  2010/07/21 10:30:23  oman
// - fix: {RequestLink:227478314}
//
// Revision 1.223  2010/03/10 12:48:45  lulin
// {RequestLink:193826739}.
//
// Revision 1.222  2010/03/03 18:31:41  lulin
// {RequestLink:193826739}.
//
// Revision 1.221  2009/12/07 15:29:54  oman
// - new: {RequestLink:171542365}
//
// Revision 1.220  2009/11/12 18:08:13  lulin
// - убираем ненужные возвращаемые значения.
//
// Revision 1.219  2009/10/15 17:22:48  lulin
// {RequestLink:166856141}. Попытки ещё что-нибудь полечить.
//
// Revision 1.218  2009/10/14 18:39:54  lulin
// {RequestLink:166855347}.
//
// Revision 1.217  2009/10/14 13:24:16  lulin
// - чистка кода.
//
// Revision 1.216  2009/10/01 15:59:32  lulin
// {RequestLink:159360578}. №47.
//
// Revision 1.215  2009/10/01 14:58:33  lulin
// - убираем сферического коня в вакууме.
//
// Revision 1.214  2009/10/01 13:30:31  lulin
// - убираем сферического коня в вакууме.
//
// Revision 1.213  2009/09/30 15:23:02  lulin
// - убираем ненужное приведение ко вполне понятным интерфейсам.
//
// Revision 1.212  2009/09/25 12:09:16  lulin
// - выкидываем ненужное.
//
// Revision 1.211  2009/09/22 17:39:31  lulin
// - модуль Поиск полностью перенесён на модель.
//
// Revision 1.210  2009/08/06 16:08:18  lulin
// {RequestLink:159352843}.
//
// Revision 1.209  2009/08/04 16:53:02  lulin
// - наконец-то дошли до вызова сравнения редакций, которое падает.
//
// Revision 1.208  2009/06/04 07:19:06  oman
// - new: Не падаем на выходе - [$148014435]
//
// Revision 1.207  2009/02/20 17:29:21  lulin
// - чистка комментариев.
//
// Revision 1.206  2009/02/20 15:19:08  lulin
// - <K>: 136941122.
//
// Revision 1.205  2009/02/20 13:07:08  lulin
// - <K>: 136941122.
//
// Revision 1.204  2009/02/19 19:02:43  lulin
// - переносим идентификаторы сообщений.
//
// Revision 1.203  2009/02/12 18:06:15  lulin
// - <K>: 135604584. Переносим константы.
//
// Revision 1.202  2009/02/12 16:06:51  lulin
// - <K>: 135604584. Выделен модуль локализации.
//
// Revision 1.201  2009/01/30 13:51:37  lulin
// - чистка кода.
//
// Revision 1.200  2009/01/21 14:43:55  lulin
// - боремся с родительским шрифтом (подробности у Вована).
//
// Revision 1.199  2008/12/25 15:26:50  oman
// - fix: Перелечиваем по старому (К-133891591)
//
// Revision 1.198  2008/12/25 15:11:09  oman
// - fix: При убиении гасимся - чтоб не болтаться (К-133891591)
//
// Revision 1.197  2008/12/24 13:21:43  oman
// - fix: Оставались в полуразваленном состоянии (К-122653398)
//
// Revision 1.196  2008/12/12 19:19:25  lulin
// - <K>: 129762414.
//
// Revision 1.195  2008/07/22 12:32:09  oman
// - fix: (К-103941607)
//
// Revision 1.194  2008/07/17 12:44:45  oman
// - new: Поддержка сообщений с радиокнопками в настройках (К-103449075)
//
// Revision 1.193  2008/07/15 12:46:07  lulin
// - <K>: 100958755.
//
// Revision 1.192  2008/07/15 09:52:57  oman
// Не собиралось
//
// Revision 1.191  2008/07/15 09:48:22  oman
// - new: Перестриваим ширину кнопок в запросах по требованию (К-96484708)
//
// Revision 1.190  2008/07/15 09:02:55  oman
// - new: Выбираем кнопку для закрытия подтверждения крестиком (К-100008730)
//
// Revision 1.189  2008/07/09 16:13:25  lulin
// - <K>: 100008415.
//
// Revision 1.188  2008/04/02 14:22:15  lulin
// - cleanup.
//
// Revision 1.187  2008/03/26 12:12:39  lulin
// - зачистка в рамках <K>: 88080898.
//
// Revision 1.186  2008/03/24 15:46:15  lulin
// http://mdp.garant.ru/pages/viewpage.action?pageId=87591840&focusedCommentId=87592645#comment-87592645
//
// Revision 1.185  2008/02/14 17:09:05  lulin
// - cleanup.
//
// Revision 1.184  2008/01/31 09:13:31  oman
// - fix: Боремся с #13#10 в заголовке окна (cq28330)
//
// Revision 1.183  2007/10/12 13:07:08  oman
// - fix: Не обновлялся заголовок на таскбаре с выключенными темами (cq27048)
//
// Revision 1.182  2007/06/18 13:38:46  mmorozov
// - new behaviour: при открытии нового прецедента сначала удаляем формы из панели задач потом регистрируем новые, алгоритм по которому выполнены измнения см. в К<18219426>;
//
// Revision 1.181  2007/05/21 13:33:19  lulin
// - cleanup.
//
// Revision 1.180  2007/05/10 14:45:23  oman
// - new: На FormDispatcher добавлена возможность подписаться на
//  нотификацию о последнем Unlock (cq25145)
//
// Revision 1.179  2007/04/13 09:55:03  oman
// - fix: Откатил изменения по ЦК24524 поскольку сломалась история
//   и эти изменения все равно не решили полностью проблемы когда
//   у сборки меняется только содержимое без закрытия форм (cq25016)
//
// Revision 1.178  2007/04/10 12:52:09  oman
// - fix: В историю пищем после CloseQuery (cq24524)
//
// Revision 1.177  2007/04/04 07:24:38  lulin
// - bug fix: на ХП-темах не обновлялся заголовок окна (CQ OIT5-24880).
//
// Revision 1.176  2007/04/02 10:39:37  lulin
// - bug fix: не было заголовка формы на панели задач (CQ OIT5-24839).
//
// Revision 1.175  2007/03/23 12:56:15  mmorozov
// - в рамках работы над представлением панели задач, представление обновляет своё содержимое при изменении данных;
//
// Revision 1.174  2007/03/21 16:17:59  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.173  2007/03/21 15:22:52  lulin
// - выделен интерфейс контрола с текстом.
//
// Revision 1.172  2007/03/21 11:40:40  lulin
// - посылаем докам нотификацию о смене текста.
//
// Revision 1.171  2007/03/20 15:25:14  lulin
// - bug fix: не обновлялся текст закладок.
//
// Revision 1.170  2007/03/20 10:34:15  lulin
// - bug fix: не перерисовывался заголовок окна.
//
// Revision 1.169  2007/03/20 07:50:40  lulin
// - теперь у формы заголовок поддерживает различные кодировки (отрисовка пока не изменена).
//
// Revision 1.168  2007/03/16 13:56:56  lulin
// - переходим на собственную функцию форматирования строк.
//
// Revision 1.167  2007/03/16 12:21:26  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.166  2007/03/01 14:16:20  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.165  2007/02/28 16:23:15  lulin
// - bug fix: не собиралось.
//
// Revision 1.164  2007/02/28 14:17:48  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.163  2007/02/12 16:40:31  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.162  2007/02/07 17:48:44  lulin
// - избавляемся от копирования строк при чтении из настроек.
//
// Revision 1.161  2007/02/06 07:53:22  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.160  2007/01/23 10:06:19  lulin
// - интерфейсу формы добавлен метод показа в модальном режиме.
//
// Revision 1.159  2007/01/20 15:31:10  lulin
// - разделяем параметры операции для выполнения и для тестирования.
//
// Revision 1.158  2007/01/19 09:48:52  oman
// - new: Локализация библиотек - vcm (cq24078)
//
// Revision 1.157  2007/01/19 09:47:39  lulin
// - выделяем интерфейс параметров для создания формы.
//
// Revision 1.156  2006/12/27 14:44:57  mmorozov
// - change: механизм объединения панелей инструментов (CQ: OIT5-23903);
//
// Revision 1.155  2006/12/13 09:22:08  mmorozov
// - new: возможность указывать фиксированный размер для зон стыковки панелей инструментов формы, в рамках работы над CQ: OIT5-13323;
//
// Revision 1.154  2006/12/10 18:59:01  lulin
// - класс формы переименован в соответствии с библиотекой.
//
// Revision 1.153  2006/12/07 13:22:48  lulin
// - убрана запись свойств по-умолчанию.
//
// Revision 1.152  2006/12/06 10:16:39  lulin
// - выделен шаблонный метод.
//
// Revision 1.151  2006/12/05 12:05:18  lulin
// - bug fix: не выставляли обработчик сообщения об изменении шрифта.
//
// Revision 1.150  2006/12/04 16:08:53  lulin
// - создаем свой, "более умный" шрифт.
//
// Revision 1.149  2006/12/04 15:00:49  lulin
// - выставляем кодовую страницу.
//
// Revision 1.148  2006/11/03 11:00:34  lulin
// - объединил с веткой 6.4.
//
// Revision 1.147.2.1  2006/10/30 09:40:18  oman
// - fix: Заменяем непечатаемые символы при установке заголовка
//   (cq23300)
// - fix: _SafeClose не всегда возвращала результат (warning-fix)
//
// Revision 1.147  2006/09/14 06:19:58  oman
// - fix: Не собиралась библиотека
//
// Revision 1.146  2006/09/14 05:50:59  mmorozov
// - new behaviour: показываем сообщения последовательно (CQ: OIT500022558);
//
// Revision 1.145  2006/09/13 12:35:26  oman
// - fix: Если сохраненный ModalResult для _vcmMessageDlg отсутствует
//  в списке допустимых кнопок, то показываем диалог (cq22547)
//
// Revision 1.144  2006/05/30 14:36:02  oman
// - fix: Утечки
//
// Revision 1.143  2006/05/30 13:31:40  oman
// - fix: List index out of bounds в _SafeClose при показе в CloseQuery модального диалога (cq18693)
//
// Revision 1.142  2006/04/06 15:41:25  dinishev
// Bug fix: Не собирался bpl
//
// Revision 1.141  2006/04/06 14:43:52  dinishev
// Переделка диалога с дополнительной кнопкой
//
// Revision 1.140  2006/04/05 14:24:35  dinishev
// Окно с пользовательской кнопкой
//
// Revision 1.139  2006/03/16 14:12:56  lulin
// - убрана возможность изменения входного параметра - идентификатора операции.
//
// Revision 1.138  2006/02/02 14:48:46  mmorozov
// new: вычисление модуля в котором зарегистрирована формы, по классу формы;
// change: убрано указание модуля при создании формы;
//
// Revision 1.137  2005/11/10 17:59:42  lulin
// - bug fix: не становились доступными стрелочки у кнопок с множественным выбором (CQ OIT5-17940).
//
// Revision 1.136  2005/11/09 12:04:47  lulin
// - bug fix: был AV при обновлении Action'ов при удалении формы (CQ OIT5-17081).
//
// Revision 1.135  2005/10/05 14:25:43  mmorozov
// new: у vcmEntityForm появился дополнительный идентификатор SubUserType;
//
// Revision 1.134  2005/10/04 10:06:11  mmorozov
// new: вложенная в контейнер форма уведомляет его о смене источника данных (событие на контейнере OnChildDataSourceChanged);
// new: на контейнере новое событие OnNeedUpdateTab (вызывается при вставке формы и смене _DataSource у вложенной формы);
//
// Revision 1.133  2005/08/25 10:24:12  lulin
// - new behavior: теперь в историю сохраняется _DataSource от формы.
//
// Revision 1.132  2005/07/22 13:02:56  lulin
// - модуль с базовыми формами переехал в библиотеку L3.
//
// Revision 1.131  2005/06/23 16:02:35  mmorozov
// remove: у метода vcmSaveIntParam теперь отсутсвует параметр aVisible;
//
// Revision 1.130  2005/06/22 06:31:45  mmorozov
// remove: метод TvcmForm._UpdateActions по праву сделан overrid-ным;
//
// Revision 1.129  2005/01/31 13:07:38  mmorozov
// bugfix: цикл for заменен на while поскольку во время прохода выдергивали компоненты;
//
// Revision 1.128  2005/01/14 14:34:09  lulin
// - new method: _Tafw.GetMainForm.
//
// Revision 1.127  2005/01/14 10:42:32  lulin
// - методы Get*ParentForm переехали в библиотеку AFW.
//
// Revision 1.126  2004/12/20 16:16:57  lulin
// - вычищены ошметки от старой строки статуса.
//
// Revision 1.125  2004/12/10 17:41:10  lulin
// - начал пилить Лехину красоту с Print-_preview на кусочки.
//
// Revision 1.124  2004/11/18 17:34:03  lulin
// - new interface: IvcmParamsPrim.
//
// Revision 1.123  2004/11/17 15:28:34  am
// change: нормальная работа и при несуществующем _Dispatcher'е
//
// Revision 1.122  2004/11/15 14:28:54  demon
// - new method: IvcmContainer._SetFocusToZone(aZoneType: TvcmZoneType); устанавливает фокус в самую вложенную форму указанной зоны контейнера.
//
// Revision 1.121  2004/11/12 13:32:59  mmorozov
// new: property TvcmForm.FloatWindowBounds;
//
// Revision 1.120  2004/11/10 14:20:37  mmorozov
// new: property TvcmForm.FloatWindowState;
//
// Revision 1.119  2004/10/29 09:59:14  fireton
// - bug fix: AV в _vcmMessageDlg если диспетчер еще не создан
//
// Revision 1.118  2004/10/28 14:55:17  fireton
// - add: скрытие floating окон при показе сообщений
//
// Revision 1.117  2004/10/13 10:47:44  lulin
// - new behavior: в момент смены Showing на true дергаем _ManualUpdateActions.
//
// Revision 1.116  2004/10/12 17:05:35  demon
// - new behavior: отключили лишние проверки OnTest на невидимых формах во время вызовов ManualUpdateAction.
//
// Revision 1.115  2004/10/07 14:17:04  lulin
// - new: теперь у _IvcmParams можно присваивать только свойство DoneStatus - код завершения. На основе этого "по-хитрому" обрабатываем ShortCut'ы для запрещенных операций (CQ OIT5-10123).
//
// Revision 1.114  2004/09/28 12:41:35  am
// bugfix: защита от зацикливания
//
// Revision 1.113  2004/09/27 09:34:16  lulin
// - пытаемся не дергать OnTest для невидимых форм.
//
// Revision 1.112  2004/09/23 13:37:48  lulin
// - bug fix: внутри операции не освобождались модальные формы (CQ OIT5-9796).
//
// Revision 1.111  2004/09/22 09:34:36  lulin
// - оптимизщация - кешируем результат преобразования Name -> ID при посылке операций.
//
// Revision 1.110  2004/09/21 12:55:57  lulin
// - Release заменил на Cleanup.
//
// Revision 1.109  2004/09/11 11:37:33  lulin
// - cleanup.
//
// Revision 1.108  2004/09/10 16:53:52  mmorozov
// new: methods (RegForm, UnregForm, _RemoveForm;
//
// Revision 1.107  2004/09/10 12:23:57  lulin
// - оптимизация - гораздо аккуратнее обращаемся с UserType'ами и VisibleOpCount. В итоге уменьшено количество различных вызовов.
//
// Revision 1.106  2004/09/07 16:19:49  law
// - перевел VCM на кшированные обьекты.
//
// Revision 1.105  2004/09/06 13:06:32  am
// change: вынес код из _ManualUpdateActions в статический _UpdateActions
//
// Revision 1.104  2004/09/03 11:45:53  mmorozov
// new: method _TvcmNULLContainer.IsSmallImages;
//
// Revision 1.103  2004/09/02 14:25:49  law
// - new behavior: не добавляем к сообщению пунктуацию или оно уже заканчивается пунктуацией (CQ OIT5-7840).
//
// Revision 1.102  2004/09/02 06:57:10  law
// - bug fix: при восстановлении формы из истории не учитывался GUID (точнее подменялся старый) и из-за этого не сохранялось состояние формы по операции Back (и соответственно не восстанавливалось по Forward) (CQ OIT5-8743).
//
// Revision 1.101  2004/08/25 14:02:06  am
// change: убираем лок отрисовки на время показа сообщения (_vcmMessageDlg)
//
// Revision 1.100  2004/08/13 11:21:56  am
// change: откатил пока попытку починить клинч с _vcm_msgCloseForm
//
// Revision 1.99  2004/08/12 12:19:29  am
// change: обход зацикливания с удалением форм
//
// Revision 1.98  2004/08/02 14:05:40  law
// - открутил VCM от тесной интеграции с моделью Немезиса.
//
// Revision 1.97  2004/07/30 13:04:40  am
// change: вернул код c BeginPaint\EndPaint в _WMPaint
//
// Revision 1.96  2004/07/30 12:45:57  am
// change: вернул лок (WM_NCPaint)
//
// Revision 1.95  2004/07/30 11:43:58  mmorozov
// change: в TvcmForm._WMPaint удален хитрый код, если форма "заморожена", то возвращается Message.Result = 0;
//
// Revision 1.94  2004/07/30 11:15:57  law
// - добавлен комментарий.
//
// Revision 1.93  2004/07/29 11:34:33  am
// bugfix: зацикливание в _KillMe\CleanQueue (по просьбе Шуры)
//
// Revision 1.92  2004/07/21 13:47:44  am
// change: Create -> _CreateNew (для возможности создания форм без ресурсов)
//
// Revision 1.91  2004/07/09 11:19:39  am
// new: в _Dispatcher.Unlock перерисовываем не только формы, но и отдельные контролы.
//
// Revision 1.90  2004/06/30 04:44:55  mmorozov
// bugfix: в функции vcmGetAnotherParentForm не учитывалось что могут подать Component = nil;
//
// Revision 1.89  2004/06/11 07:10:06  mmorozov
// change: в качестве идентификатора настройки при чтении, записи выбора пользователя в диалоге используется Message.Name;
//
// Revision 1.88  2004/06/02 10:59:29  mmorozov
// bugfix: в Get_InClose проверяем что _f_Form <> nil;
//
// Revision 1.87  2004/05/20 13:29:39  law
// - new method: TvcmInterfacedFrom.CallCloseQuery.
// - new event: TvcmInterfacedFrom.OnCloseQueryEx.
//
// Revision 1.86  2004/05/12 13:03:34  am
// change: при сохранении ModalResult'а не выполняем замену (mrYes на mrOk)
//
// Revision 1.85  2004/04/10 10:45:38  am
// change: настройка состояния чекбоксов в confirmation диалогах теперь видима
//
// Revision 1.84  2004/04/09 11:50:49  law
// - new behavior: прикручен контроль за Tl3Form.
//
// Revision 1.83  2004/04/07 14:41:10  law
// - bug fix: не закрывалась модальная форма.
//
// Revision 1.82  2004/04/07 06:38:39  am
// change: "Запомнить выбор и больше не показывать это сообщение."
//
// Revision 1.81  2004/04/06 09:12:09  law
// - new method: TvcmForm.Close работает "почти" как TCustomForm.Close, но с использованием _SafeClose.
//
// Revision 1.80  2004/04/05 16:13:29  law
// - bug fix: восстановил вызов события OnClose у формы - это Лехе Никитину надо было для контекстного поиска.
//
// Revision 1.79  2004/04/05 15:49:36  law
// - new behavior: в DoClose VCM'ной формы вставлен Assert о необходимости пользоваться другим методом.
//
// Revision 1.78  2004/04/04 17:44:32  migel
// - fix: проблемы с фокусом.
//
// Revision 1.77  2004/04/02 07:40:14  law
// - change: в VCM'ных формах обрабатываем WM_Close и в нем вызываем _SafeClose, а не Close - для унификации и избежания двойного вызова CloseQuery.
//
// Revision 1.76  2004/04/01 13:44:43  law
// - bug fix: поиск по истории при _MakeSingleChild не учитывал GUID формы (CQ OIT5-6957).
//
// Revision 1.75  2004/03/31 14:48:55  am
// bugfix: при удалении тулбаров убираем Parent!!! Иначе док в своём деструкторе попытается удалить тулбары ещё раз (потому как сообшение об изменении набора контролов до него доходит слишком поздно, видимо)
//
// Revision 1.74  2004/03/29 17:08:25  mmorozov
// new: public property TvcmForm.FloatID;
//
// Revision 1.73  2004/03/25 08:32:06  mmorozov
// new: type TOnPositionDockRect;
// new: event TvcmForm.OnPositionDockRect;
//
// Revision 1.72  2004/03/23 15:11:53  am
// change: TraverseClients - вызываем OnTest не у контролов, а у компонентов, которыми владеем
//
// Revision 1.71  2004/03/19 15:03:23  mmorozov
// new: в метод _HasForm добавлен параметр (UserType : Integer = vcm_utAny);
//
// Revision 1.70  2004/03/11 12:18:05  law
// - bug fix: неправильно определялся контейнер для плавающей формы.
//
// Revision 1.69  2004/03/10 14:38:53  am
// change: align'им vcm'ные диалоги по левому краю
//
// Revision 1.68  2004/03/05 18:04:44  law
// - new behavior: в CloseQuery не спрашиваем пользователя и не сохраняем настройки, если уже идет процесс закрытия формы.
//
// Revision 1.67  2004/03/05 15:30:33  law
// - change: в vcmLoad*Param передаем массив пар, а не массив строк.
//
// Revision 1.66  2004/03/01 14:53:52  am
// bugfix: CloseQuery теперь вызывается и для детей.
//
// Revision 1.65  2004/03/01 13:53:30  law
// - new behavior: сохраняем/восстанавливаем положение и размеры всех плавающих и модальных форм.
//
// Revision 1.64  2004/02/26 15:54:26  law
// - new behavior: сохраняем состояние Maximized основной формы.
//
// Revision 1.63  2004/02/19 09:51:54  am
// bugfixs: запись значений
//
// Revision 1.62  2004/02/18 09:11:08  am
// new: у message'ей появилось свойство Key - путь, по которому они сохраняются в настройках
// change: в vcmSettings есть возможность сохранять в группу, отличную от _vcmGroup,
//         передавая группу в пути и выставляя aGroupInPath
//
// Revision 1.61  2004/02/05 17:00:37  law
// - new behavior: вычитываем Toolbar'ы из настроек, но пока плюем на то, что прочитали.
//
// Revision 1.60  2004/02/03 08:29:43  demon
// - bug fix: не правильно работала операция _Get_NativeMainForm, если это свойство спрашивалось у MainForm (результат - Assert)
//
// Revision 1.59  2004/01/30 17:14:43  law
// - new method version: IvcmContainer._HasForm.
//
// Revision 1.58  2004/01/30 16:32:17  law
// - new behavior: записываем/читаем результат диалога.
//
// Revision 1.57  2004/01/30 15:38:07  law
// - new behavior: подготовлено место для сохранения выбора в диалоге.
//
// Revision 1.56  2004/01/30 15:09:51  law
// - change: в нулевом приближение сделано рисование Check'а.
//
// Revision 1.55  2004/01/30 14:03:36  law
// - change: задел на использование NeedCheck.
//
// Revision 1.54  2004/01/29 16:44:19  law
// - new method: IvcmContainer._MakeSingleChild.
//
// Revision 1.53  2004/01/29 15:16:31  law
// - new prop: _IvcmForm._NativeMainForm.
//
// Revision 1.52  2004/01/28 13:58:14  law
// - new prop: TvcmMessagesCollectionItem._VisibleCaption.
//
// Revision 1.51  2004/01/28 11:11:12  law
// - new methods versions: TvcmForm._Say, Ask - с возможностью задания данных для форматки.
//
// Revision 1.49  2004/01/28 09:02:04  law
// - new methods: _vcmSay, TvcmForm._Say.
//
// Revision 1.48  2004/01/28 08:37:05  law
// - new methods: vcmAsk, TvcmForm.Ask.
//
// Revision 1.47  2004/01/28 08:22:54  law
// - change: при использовании идентификатора сообщения берем кнопки и тип диалога у сообщения, описанного в MenuManager.
//
// Revision 1.46  2004/01/27 17:45:01  law
// - new method versions: _vcmMessageDlg, TvcmForm._MessageDlg.
//
// Revision 1.45  2004/01/27 14:41:58  law
// - new method: TvcmForm._MessageDlg.
//
// Revision 1.44  2004/01/27 14:29:34  law
// - rename proc: _MessageDlg -> _vcmMessageDlg.
//
// Revision 1.43  2004/01/27 13:31:51  law
// - new proc: _MessageDlg.
//
// Revision 1.42  2004/01/20 15:57:56  law
// - bug fix: Tl3Form._SafeClose - не вызывал CloseQuery.
//
// Revision 1.41  2004/01/16 17:14:01  law
// - new behavior: очищаем Toolbar'ы/формы и внутри дочерних компонент.
//
// Revision 1.40  2004/01/10 14:00:30  law
// - bug fix: Разные окна стали связанны (CQ OIT5-5181).
//
// Revision 1.39  2004/01/08 13:01:35  law
// - new proc: vcmGetTopParentForm.
//
// Revision 1.38  2003/12/27 12:29:45  nikitin75
// temporary: WMNCPaint call inherited only: непонятно как перерисовать (обновить) обрамление окна;
//
// Revision 1.37  2003/12/02 14:53:55  law
// - bug fix: восстановлена функциональность MDI-приложения.
//
// Revision 1.36  2003/11/28 13:01:34  law
// - new behavior: опираемся на идентификаторы форм, а не на имена.
//
// Revision 1.35  2003/11/27 15:56:26  law
// - new prop: _TvcmEntityForm.OnNeedUpdateStatus.
//
// Revision 1.34  2003/11/26 16:38:47  law
// - new behavior: _IvcmForm.Container всегда возвращает гарантированно не nil.
//
// Revision 1.33  2003/11/11 17:07:46  law
// - bug fix: для модальной формы не возвращался результат.
//
// Revision 1.32  2003/10/22 12:33:55  law
// - bug fix: невовремя убивался Toolbar.
//
// Revision 1.31  2003/10/09 16:06:35  law
// - bug fix: при поиске контейнера не "перепрыгивали" не через VCM-формы.
//
// Revision 1.30  2003/10/03 09:14:03  law
// - bug fix: очищаем PopupMenu в подходящий момент.
//
// Revision 1.29  2003/09/30 10:08:01  law
// - bug fix: дочерним формам не выставлялся флаг _InClose.
//
// Revision 1.28  2003/09/29 12:38:00  law
// - bug fix: при отложенном удалении форм опять стали моргать toolbar'ы. Починил.
//
// Revision 1.27  2003/09/26 11:38:38  law
// - bug fix: не закрывались модальные формы.
//
// Revision 1.26  2003/09/25 17:00:28  law
// - new behavior: сделано отложенное убивание форм.
//
// Revision 1.25  2003/09/25 13:58:09  law
// - new method: TvcmForm._SafeClose.
//
// Revision 1.24  2003/09/19 17:45:10  law
// - new behavior: не даем вызывать _ManualUpdateActions, когда форма уже убивается.
//
// Revision 1.23  2003/09/10 15:12:48  law
// - new method: TvcmForm._ManualUpdateActions.
//
// Revision 1.22  2003/07/30 08:44:02  law
// - bug fix: неправильно работал WM_NCPaint при _Lock.
//
// Revision 1.21  2003/07/29 13:02:38  law
// - bug fix: перерисовываем родителя формы, при смене _Caption'а.
//
// Revision 1.20  2003/07/22 12:22:18  law
// - new behavior: избавились от мерцания при переходе от списка к рубрикатору и обратно.
//
// Revision 1.19  2003/07/16 16:18:57  law
// - new behavior: перерисовываем формы, после Unlock диспетчера форм.
//
// Revision 1.18  2003/07/16 13:24:34  demon
// - bug fix: было зависание при загрузке документа в залоченную форму.
//
// Revision 1.17  2003/07/16 10:18:14  demon
// - bug fix: был AV при поиске контейнера MainForm.
//
// Revision 1.16  2003/07/15 07:53:02  law
// - bug fix: не находился котейнер у плавающих форм.
//
// Revision 1.15  2003/06/04 12:00:44  law
// - bug fix: в Design-Time валилась форма сущности.
//
// Revision 1.14  2003/06/03 14:08:15  law
// - bug fix: не собиралось с опцией _vcmNeedL3.
// - bug fix: при закрытии приложения не освобождались модули.
//
// Revision 1.13  2003/05/23 11:53:09  law
// - bug fix: TvcmForm не отдавала интерфейс _IvcmForm.
//
// Revision 1.12  2003/04/29 13:28:54  law
// - new methods: IvcmFormDispatcher._Lock, Unlock.
//
// Revision 1.11  2003/04/28 13:02:35  law
// - remove const: vcm_opDone.
// - new prop: _IvcmParams.Done.
//
// Revision 1.10  2003/04/24 12:30:35  law
// - new method version: _TvcmEntityForm._Make.
//
// Revision 1.9  2003/04/23 15:26:35  demon
// - add: добавлен метод _SafeClose
//
// Revision 1.8  2003/04/22 19:02:07  law
// - new behavior: отказываемся от MDI форм при включенном флаге _SDI.
//
// Revision 1.7  2003/04/22 15:22:25  law
// - bug fix: vcmGetParentForm в случае с придоченной формой добиралась до самой верхней, а не до непосредственного родителя.
//
// Revision 1.6  2003/04/22 14:03:01  law
// - new behavior: сделана обработка операций, описанных на основной форме.
//
// Revision 1.5  2003/04/22 12:26:36  law
// - new prop: TvcmForm.Container.
//
// Revision 1.4  2003/04/03 15:43:55  law
// - change: из TvcmMainForm выделил класс TvcmDispatcher.
//
// Revision 1.3  2003/04/01 16:10:45  law
// - new behavior: сделана регистрация сущностей от форм в списке у главной формы.
//
// Revision 1.2  2003/04/01 15:27:51  law
// - new interface: _IvcmEntityForm.
//
// Revision 1.1  2003/04/01 12:54:49  law
// - переименовываем MVC в VCM.
//
// Revision 1.9  2003/03/20 17:26:39  law
// - change: сделаны более удобочитаемые пути к сущностям и операциям.
//
// Revision 1.8  2003/03/17 12:24:51  law
// - new behavior: в нулевом приближении сделана автоматическая сборка контекстного меню.
//
// Revision 1.7  2003/03/14 12:20:54  law
// - change: отвязываем vcm от l3.
//
// Revision 1.6  2003/03/14 09:22:37  law
// - change: отвязываем vcm от l3.
//
// Revision 1.5  2003/02/26 18:12:35  law
// - new property: IvcmDispatcher._ActiveEntity.
//
// Revision 1.4  2003/02/26 16:22:43  law
// - new behavior: сделана обработка операция и создание форм.
//
// Revision 1.3  2003/02/24 13:02:24  law
// - help added.
//
// Revision 1.2  2003/02/24 11:11:31  law
// - new unit: vcmEntityForm.
//

{$Include vcmDefine.inc }

interface

{$IfNDef NoVCM}
uses
  Windows,
  Messages,

  Classes,
  Controls,
  Forms,
  Dialogs,

  l3Interfaces,
  l3VCLStrings,
  l3IID,
  l3InternalInterfaces,
  l3StringIDEx,

  l3CProtoObject,
  l3Forms,
  l3ProtoIntegerList,

  //vcmDialogs,

  afwInterfaces,
  
  vcmExternalInterfaces,
  vcmInterfaces,
  vcmGUI,
  vcmBase,
  vcmMessages,
  vcmUserInteractiveForm,
  vcmLayoutImplementation
  ;

type
  TvcmCloseQueryEvent = procedure(Sender       : TObject;
                                  var CanClose : Boolean;
                                  aCaller      : TCustomForm) of object;
                                  
  TvcmInterfacedForm = class(TvcmUserInteractiveForm)
    protected
    // internal fields
      f_VCMClosing     : Boolean;
    private
    // internal fields
      f_OnCloseQueryEx : TvcmCloseQueryEvent;
    private
    // message handlers
      procedure WMClose(var Message: TWMClose);
        message WM_Close;
        {-}
      procedure WMSetText(var Message: TWMSetText);
        message WM_SETTEXT;
        {-}
      procedure CMRelease(var Message: TMessage);
        message CM_RELEASE;
        {-}
      procedure vcmMsgCloseForm(var Message: TMessage);
        message vcm_msgCloseForm;
        {-}
    protected
    // property methods
      function Get_Dispatcher: IvcmDispatcher;
        {-}
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
      procedure DoClose(var Action: TCloseAction);
        override;
        {-}
      function  IsModal: Boolean;
        virtual;
        {-}
      procedure ClearModal;
        virtual;
        {-}
      function  IsContained: Boolean;
        virtual;
        {-}
      procedure BeforeKill;
        virtual;
        {-}
      procedure DoLoadFromSettings;
        virtual;
        {-}
      procedure DoSaveInSettings;
        virtual;
        {-}
      function NeedSaveInSettings: Boolean;
        virtual;
        {-}
    {$If not defined(DesignTimeLibrary)}
    {$IfDef l3HackedVCL}
    function IsAcceptableControlForTabNavigation(aControl: TWinControl): Boolean; override;
   procedure SelectNext(CurControl: TWinControl;
     GoForward: Boolean;
     CheckTabStop: Boolean); override;
    {$EndIf l3HackedVCL}
    {$IfEnd} //not DesignTimeLibrary
    public
    // public methods
      procedure Close;
        {-}
      procedure KillMe;
        virtual;
        abstract;
        {-}
      function  SafeClose: Boolean;
        virtual;
        abstract;
        {-}
      function CloseQuery: Boolean;
        override;
        {-}
      function CallCloseQuery(aCaller : TCustomForm): Boolean;
        virtual;
        {-}
      procedure DoUpdateStatus;
        virtual;
        {-}
    public
    // public methods
      property VCMClosing: Boolean
        read f_VCMClosing;
        {-}
      property Dispatcher: IvcmDispatcher
        read Get_Dispatcher;
        {-}
    published
    // published _events
      property OnCloseQueryEx: TvcmCloseQueryEvent
        read f_OnCloseQueryEx
        write f_OnCloseQueryEx;
        {-}
  end;//TvcmInterfacedForm

  TvcmTextForm = class(TvcmInterfacedForm, IafwTextControl)
    private
    // internal fields
      f_Text   : Il3CString;
    protected
    // property methods
      function  pm_GetCCaption: IafwCString;
      procedure pm_SetCCaption(const aValue: Il3CString);
        {-}
      function  pm_GetCaption: Tl3DString;
      procedure pm_SetCaption(const aValue: Tl3DString);
        {-}
    protected
    // protected methods
      procedure WMGetText(var Msg: TMessage);
        message WM_GetText;
        {-}
      procedure WMGetTextLength(var Msg: TMessage);
        message WM_GetTextLength;
        {-}
      procedure WMSetText(var Msg: TMessage);
        message WM_SetText;
        {-}
      procedure CreateParams(var aParams: TCreateParams);
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
      procedure NotifyContainerCaptionChanged;
        {-}
      function NeedNotifyContainerOnCaptionChanged: Boolean;
        virtual;
        {-}
    public
    // public properties
      property CCaption: Il3CString
        read f_Text
        write pm_SetCCaption;
        {-}
    published
    // public properties
      property Caption: Tl3DString
        read pm_GetCaption
        write pm_SetCaption;
        {-}
  end;//TvcmTextForm

  TOnPositionDockRect = procedure (Sender         : TObject;
                                   DragDockObject : TDragDockObject) of Object;

  _vcmUnicodeFormParent_ = TvcmTextForm;
  {$Include w:\Common\Components\GUI\Garant\VCM\Implementation\Visual\vcmUnicodeForm.inc}
   TvcmForm = class(_vcmUnicodeForm_)
   {* Базовый класс форм приложения построенного на библиотеке vcm. }
    protected
    // internal fields
      f_Form               : IvcmForm;
      f_OnPositionDockRect : TOnPositionDockRect;
    // public fields
      f_FloatID            : Integer;
      f_FloatWindowState   : Integer;
      f_FloatWindowBounds  : TRect;
    private
    // message handlers
      procedure CMTextChanged (var Message: TMessage);
        message CM_TEXTCHANGED;
        {-}
      procedure CMShowingChanged(var Message: TMessage);
        message CM_SHOWINGCHANGED;
        {-}
    protected                     
    // inherited methods
      procedure PositionDockRect(DragDockObject: TDragDockObject);
        override;
        {-}
    // internal methods
      procedure Cleanup;
        override;
        {-}
      class function FormImplementationClass: TClass;
        virtual;
        {-}
      function Get_Container: IvcmContainer;
        {-}
      function Get_NativeMainForm: IvcmContainer;
        {-}
      function DoShowModal: Integer;
        {-}                            
    public
    // public methods
      {$IfDef XE}
      constructor Create(anOwner: TComponent);
        override;
        {* - создает форму. }
      {$EndIf XE}
      constructor CreateNew(anOwner: TComponent; aDummy: integer = 0);
        override;
        {* - создает форму. }
      function  COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
        override;
        {-}
      procedure ManualUpdateActions;
        virtual;
        {-}
      procedure UpdateActions;
        override;
        {-}
      procedure FormDispatcherUnlocked;
        virtual;
        {-}
      function IsAcceptable(aDataUpdate: Boolean): Boolean; virtual;
    public
    // public properties
      property Container: IvcmContainer
        read Get_Container;
        {* - контейнер в котором содержится форма. }
      property NativeMainForm: IvcmContainer
        read Get_NativeMainForm;
        {-}
      property OnPositionDockRect : TOnPositionDockRect
        read f_OnPositionDockRect
        write f_OnPositionDockRect;
        {-}
      property FloatID : Integer
        read f_FloatID
        write f_FloatID;
        {* - идентификатор плавающего навигатора, в котором находилась форма. }
      property FloatWindowState : Integer
        read f_FloatWindowState
        write f_FloatWindowState;
        {* - для запоминания состояния плавающей формы в которой находилась
             форма. Например была минимизирована. }
      property FloatWindowBounds : TRect
        read f_FloatWindowBounds
        write f_FloatWindowBounds;
        {* - положение плавающего окна. }
    protected
      property ParentFont
        default false;
        {-}    
  end;//TvcmForm

  TvcmFormImplementation = class(TvcmLayoutImplementation, IvcmForm)
    protected
    // interface methods
      // IvcmForm
      function  Get_Container: IvcmContainer;
        {-}
      function  Get_NativeMainForm: IvcmContainer;
        {-}
      function  Get_Caption: IvcmCString;
        {-}
      procedure Set_Caption(const aValue: IvcmCString);
        {-}
      function  Get_Dispatcher: IvcmDispatcher;
        {-}
      function  Get_InClose: Boolean;
        {-}
      function  SafeClose: Boolean;
        {-}
      function  ShowModal: Integer;
        {-}
    protected
      function GetIsAcceptable(aDataUpdate: Boolean): Boolean; override;
    public
    // public methods
      constructor Create(aForm: TvcmForm);
        reintroduce;
        {-}
      class function Make(aForm: TvcmForm): IvcmForm;
        {-}
  end;//TvcmFormImplementation
  RvcmFormImplementation = class of TvcmFormImplementation;
{$EndIf NoVCM}

implementation

{$IfNDef NoVCM}
uses
  SysUtils,

//  Themes,
//  UxTheme,

  l3String,
  l3Base,
  l3CacheableBase,

  l3Bits,

  vcmUserControls,
  afwFacade,
  afwFont,
  afwVCL
  ,
  vcmMessagesCollectionItem,
  vcmBaseMenuManager,
  vcmMenuManager,
  vcmMainForm,
  {$IfDef vcmUseSettings}
  vcmSettings,
  {$EndIf vcmUseSettings}

  {$IFDEF nsTest}
  afwAnswer,
  {$ENDIF nsTest}

  vcmInternalConst,
  vcmIEntityFormList,

  vtDialogsResEx,

  l3VCLFormPtrList,

  vcmMessagesSupport,
  Consts,
  Graphics,
  Menus
  ;

{$Include w:\Common\Components\GUI\Garant\VCM\Implementation\Visual\vcmUnicodeForm.inc}

// start class TvcmFormImplementation

constructor TvcmFormImplementation.Create(aForm: TvcmForm);
  //reintroduce;
  {-}
begin
 inherited Create(aForm);
end;

class function TvcmFormImplementation.Make(aForm: TvcmForm): IvcmForm;
  {-}
var
 l_Form : TvcmFormImplementation;
begin
 l_Form := Create(aForm);
 try
  Result := l_Form;
 finally
  vcmFree(l_Form);
 end;//try..finally
end;

function TvcmFormImplementation.Get_Container: IvcmContainer;
  {-}
begin
 Result := TvcmForm(Control).Container;
end;

function TvcmFormImplementation.Get_NativeMainForm: IvcmContainer;
  {-}
begin
 Result := TvcmForm(Control).NativeMainForm;
end;

function TvcmFormImplementation.Get_Caption: IvcmCString;
  {-}
begin
 if (Control = nil) then // http://mdp.garant.ru/pages/viewpage.action?pageId=290948175
  Result := nil
 else
  Result := TvcmForm(Control).CCaption;
end;

procedure TvcmFormImplementation.Set_Caption(const aValue: IvcmCString);
  {-}
begin
 TvcmForm(Control).CCaption := aValue;
end;

function TvcmFormImplementation.Get_Dispatcher: IvcmDispatcher;
  {-}
begin
 Result := TvcmForm(Control).Dispatcher;
end;

function TvcmFormImplementation.Get_InClose: Boolean;
  {-}
begin
 if (Control = nil) then
  Result := true
 else
  Result := TvcmForm(Control).VCMClosing;
end;

function TvcmFormImplementation.SafeClose: Boolean;
  {-}
begin
 if (Control = nil) then
  Result := false
 else
  Result := TvcmForm(Control).SafeClose;
end;

function TvcmFormImplementation.ShowModal: Integer;
  {-}
begin
 if (Control = nil) then
  Result := mrCancel
 else
  Result := TvcmForm(Control).DoShowModal;
end;

function TvcmFormImplementation.GetIsAcceptable(aDataUpdate: Boolean): Boolean;
begin
 if Assigned(Control) then
  Result := TvcmForm(Control).IsAcceptable(aDataUpdate)
 else
  Result := inherited GetIsAcceptable(aDataUpdate);
end;

// start class TvcmForm

{$IfDef XE}
constructor TvcmForm.Create(anOwner: TComponent);
  //override;
  {* - создает форму. }
begin
 OldCreateOrder := true;
 inherited;
 afwHackControlFont(Self);
 f_Form := RvcmFormImplementation(FormImplementationClass).Make(Self);
 f_FloatID := 0;
 f_FloatWindowState := 0;
 SetRectEmpty(f_FloatWindowBounds);
end;
{$EndIf XE}

constructor TvcmForm.CreateNew(anOwner: TComponent; aDummy: Integer);
  //override;
  {* - создает форму. }
begin
 inherited;
 {$IfDef XE}
 assert(f_Form = nil, 'По идее по новой идеологии XE - мы не должны придти сюда');
 {$EndIf XE}
 OldCreateOrder := true;
 afwHackControlFont(Self);
 f_Form := RvcmFormImplementation(FormImplementationClass).Make(Self);
 f_FloatID := 0;
 f_FloatWindowState := 0;
 SetRectEmpty(f_FloatWindowBounds);
end;

class function TvcmForm.FormImplementationClass: TClass;
  //virtual;
  {-}
begin
 Result := TvcmFormImplementation;
end;

procedure TvcmForm.PositionDockRect(DragDockObject: TDragDockObject);
  //override;
  {-}
begin
 inherited PositionDockRect(DragDockObject);
 if Assigned(f_OnPositionDockRect) then
  f_OnPositionDockRect(Self, DragDockObject);
end;

procedure TvcmForm.Cleanup;
  //override;
  {-}
var
 l_Form : IvcmLayoutInternal;
begin
 inherited;
 if Supports(f_Form, IvcmLayoutInternal, l_Form) then
  try
   l_Form.ClearLinkToControl;
  finally
   l_Form := nil;
  end;//try..finally
 f_Form := nil;
end;

function TvcmForm.COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
  //override;
  {-}
begin
 if IID.EQ(IvcmForm) and (f_Form <> nil) then
  Result := Tl3HResult_C(f_Form.QueryInterface(IID.IID, Obj))
 else
  Result := inherited COMQueryInterface(IID, Obj);
end;

procedure TvcmForm.ManualUpdateActions;
begin
 UpdateActions;          
end;

procedure TvcmForm.UpdateActions;
  //virtual;
  {-}

  procedure TraverseClients(Container: TWinControl);
  var
   I       : Integer;
   Control : TControl;
  begin//TraverseClients
    if not VCMClosing AND
       (Container.Showing or {эта проверка избавляет от лишних OnTest'ов на невидимых формах,
                             но она может приводить к непрорисовке кнопок на тулбарах}
       not (Container is TCustomForm)) then
    begin
     I := 0;
     while I < Container.ComponentCount do
     begin
      if Container.Components[I] is TControl then
      begin
       Control := Container.Components[I] as TControl;
       if not (csDestroying in Control.ComponentState) then
       begin
        if (csActionClient in Control.ControlStyle) {and Control.Visible} then
          Control.InitiateAction;
        if (Control is TWinControl) AND
           not (csDestroying in Control.ComponentState) then
         TraverseClients(TWinControl(Control));
       end;//not (csDestroying in Control.ComponentState)
      end;//if Container.Components[I]
      Inc(I);
     end;//while I < Container.ComponentCount
    end;//if Container.Showing
  end;//TraverseClients

var
 I   : Integer;
 l_D : IvcmDispatcher;
begin
 if (csDesigning in ComponentState) or
    (csDestroying in ComponentState)
    or not Showing or
    VCMClosing then Exit;
 // - Showing раскомментировал - типа чтобы пореже дергалось
 //   если что-то отвалится - надо будет разбираться.
 { Update form }
 InitiateAction;
 { Update main menu's top-most items }
 if Menu <> nil then
   for I := 0 to Menu.Items.Count - 1 do
     with Menu.Items[I] do
       if Visible then InitiateAction;
 { Update any controls }
 l_D := Dispatcher;
 if (l_D <> nil) then
 begin
  l_D.BeginOp(true);
  try
   TraverseClients(Self);
  finally
   l_D.EndOp;
  end;//try..finally
 end;//l_D <> nil
end;

procedure TvcmForm.FormDispatcherUnlocked;
//  virtual;
  {-}
begin

end;

function TvcmForm.IsAcceptable(aDataUpdate: Boolean): Boolean;
begin
 Result := True;
end;

procedure TvcmForm.CMTextChanged (var Message: TMessage);
  //message CM_TEXTCHANGED;
  {-}
begin
 inherited;
 if (Parent <> nil) then
  Parent.Invalidate;
end;

procedure TvcmForm.CMShowingChanged(var Message: TMessage);
  //message CM_SHOWINGCHANGED;
  {-}
begin
 {$IfNDef DesignTimeLibrary}
 if Showing {$IfDef l3HackedVCL}AND IsRealInstance {$ENdIf} then
  ManualUpdateActions;
 {$EndIf DesignTimeLibrary}
 inherited;
 {$IfNDef DesignTimeLibrary}
 {$IfDef l3HackedVCL}
 UpdateShowing;
 {$EndIf}
 {$EndIf DesignTimeLibrary}
end;

type
  TvcmNULLContainer = class(Tl3CProtoObject, IvcmContainer)
    protected
    // interface methods
     function NeedSetFocusToMainObjectFormOnRefresh: Boolean;
     {* Надо ли передвигать фокус в главную форму при изменении сборки }
     procedure InitFromPrevContainer(const aPrevContainer: IvcmContainer;
      aForClone: Boolean);
        {-}
     function Get_NativeMainForm: IvcmContainer;
        {-}
      procedure RegForm(const aForm : IvcmEntityForm);
        {-}
      procedure UnregForm(const aForm : IvcmEntityForm);
        {-}
      function InsertForm(const aForm: IvcmEntityForm): Boolean;
        {* - вставляет форму в контейнер. }
      procedure RemoveForm(const aForm : IvcmEntityForm);
        {* - сообщение об уничтожении формы. }
      function HasForm(aZoneType    : TvcmZoneType = vcm_ztAny;
                       aRecursive   : Boolean = true;
                       theForm      : PIvcmEntityForm = nil;
                       aUserType    : TvcmUserType = vcm_utAny;
                       aGUID        : PGUID = nil;
                       aSubUserType : TvcmUserType = vcm_utAny): Boolean;
        overload;
        {* - проверяет есть ли в контейнере такая форма. }
      function HasForm(const aName  : TvcmFormID;
                       aZoneType    : TvcmZoneType = vcm_ztAny;
                       aRecursive   : Boolean = true;
                       theForm      : PIvcmEntityForm = nil;
                       aUserType    : TvcmUserType = vcm_utAny;
                       aGUID        : PGUID = nil;
                       aSubUserType : TvcmUserType = vcm_utAny): Boolean;
        overload;
        {* - проверяет есть ли в контейнере такая форма. }
      function Operation(const anOp    : TvcmOPID;
                         const aParams : IvcmExecuteParams): Boolean;
        overload;
        { Выполнение операции по имени сущности. }
      function Operation(const anOp    : TvcmOPID;
                         const aParams : IvcmTestParams): Boolean;
        overload;
        { Выполнение операции по имени сущности. }
      function Operation(const anOp : TvcmOPID;
                         aMode      : TvcmOperationMode = vcm_omExecute): Boolean;
        overload;
        { Выполнение операции по имени сущности. }
      function IsNull: Boolean;
        {-}
      procedure IvcmContainer_FormStyle(const aForm  : IvcmEntityForm;
                                        const aStyle : IvcmFormStyle);
      procedure IvcmContainer.FormStyle = IvcmContainer_FormStyle;
        {* - определим стиль формы. }
      procedure SetFocusToMainObjectForm;
        {* - устанавливаем фокус в самую вложенную форму указанной зоны. }
      procedure ChildDataSourceChanged(const aChild : IvcmEntityForm;
                                       const anOld  : IvcmFormDataSource;
                                       const aNew   : IvcmFormDataSource);
        {* - вызывается при изменении источника данных вложенной формы. }
      function pm_GetEntityFormIterator: IvcmEntityFormIterator;
        {* - итератор форм контейнера. }
      function pm_GetFormSetIterator: IvcmFormSetIterator;
        {* - итератор сборок в контейнере. }
      function pm_GetAggregateIterator: IvcmAggregateIterator;
        {* - итератор аггрегаций в контейнере. }
      function Get_AsForm: IvcmEntityForm;
      procedure SetTabCaption(const aTabCaption: IvcmCString);
    public
    // public methods
      class function Make: IvcmContainer;
        {-}
  end;//TvcmNULLContainer

class function TvcmNULLContainer.Make: IvcmContainer;
  {-}
var
 l_Container : TvcmNULLContainer;
begin
 l_Container := Create;
 try
  Result := l_Container;
 finally
  vcmFree(l_Container);
 end;//try..finally
end;

function TvcmNULLContainer.NeedSetFocusToMainObjectFormOnRefresh: Boolean;
  {* Надо ли передвигать фокус в главную форму при изменении сборки }
begin
 Result := False;
end;

procedure TvcmNULLContainer.InitFromPrevContainer(const aPrevContainer: IvcmContainer;
 aForClone: Boolean);
begin
 Assert(False);
end;

function TvcmNULLContainer.Get_NativeMainForm: IvcmContainer;
  {-}
begin
 Result := nil;
end;

procedure TvcmNULLContainer.RegForm(const aForm : IvcmEntityForm);
begin
end;

procedure TvcmNULLContainer.UnregForm(const aForm : IvcmEntityForm);
begin
end;

function TvcmNULLContainer.InsertForm(const aForm: IvcmEntityForm): Boolean;
  {* - вставляет форму в контейнер. }
begin
 Result := false;
end;

procedure TvcmNULLContainer.RemoveForm(const aForm : IvcmEntityForm);
  {* - сообщение об уничтожении формы. }
begin

end;

function TvcmNULLContainer.HasForm(aZoneType    : TvcmZoneType = vcm_ztAny;
                                   aRecursive   : Boolean = true;
                                   theForm      : PIvcmEntityForm = nil;
                                   aUserType    : TvcmUserType = vcm_utAny;
                                   aGUID        : PGUID = nil;
                                   aSubUserType : TvcmUserType = vcm_utAny): Boolean;
  //overload;
  {* - проверяет есть ли в контейнере такая форма. }
begin
 Result := HasForm(fm_Any, aZoneType, aRecursive, theForm, aUserType, aGUID,
  aSubUserType);
end;

function TvcmNULLContainer.HasForm(const aName  : TvcmFormID;
                                   aZoneType    : TvcmZoneType = vcm_ztAny;
                                   aRecursive   : Boolean = true;
                                   theForm      : PIvcmEntityForm = nil;
                                   aUserType    : TvcmUserType = vcm_utAny;
                                   aGUID        : PGUID = nil;
                                   aSubUserType : TvcmUserType = vcm_utAny): Boolean;
  {* - проверяет есть ли в контейнере такая форма. }
begin
 Result := false;
end;

function TvcmNULLContainer.Operation(const anOp    : TvcmOPID;
                                     const aParams : IvcmExecuteParams): Boolean;
  //overload;
  { Выполнение операции по имени сущности. }
begin
 aParams.DoneStatus := vcm_dsNullContainer;
 Result := false;
end;

function TvcmNULLContainer.Operation(const anOp    : TvcmOPID;
                                     const aParams : IvcmTestParams): Boolean;
  //overload;
  { Выполнение операции по имени сущности. }
begin
 aParams.DoneStatus := vcm_dsNullContainer;
 Result := false;
end;

function TvcmNULLContainer.Operation(const anOp : TvcmOPID;
                                     aMode      : TvcmOperationMode = vcm_omExecute): Boolean;
  //overload;
  { Выполнение операции по имени сущности. }
begin
 if (aMode = vcm_omTest) then
  Result := Operation(anOp, TvcmTestParams.Make)
 else
  Result := Operation(anOp, vcmParams);
end;

function TvcmNULLContainer.IsNull: Boolean;
  {-}
begin
 Result := true;
end;

procedure TvcmNULLContainer.IvcmContainer_FormStyle(const aForm  : IvcmEntityForm;
                                                    const aStyle : IvcmFormStyle);
  {* - определим стиль формы. }
begin

end;//FormStyle

function TvcmNULLContainer.pm_GetEntityFormIterator: IvcmEntityFormIterator;
  {* - итератор форм контейнера. }
begin
 Result := nil;
end;

function TvcmNULLContainer.pm_GetFormSetIterator: IvcmFormSetIterator;
  {* - итератор сборок в контейнере. }
begin
 Assert(False);
end;

function TvcmNULLContainer.pm_GetAggregateIterator: IvcmAggregateIterator;
  {* - итератор аггрегаций в контейнере. }
begin
 Assert(False);
end;

function TvcmNULLContainer.Get_AsForm: IvcmEntityForm;
begin
 Assert(false);
 Result := nil;
end;

procedure TvcmNULLContainer.SetTabCaption(const aTabCaption: IvcmCString);
begin
 Assert(False);
end;


procedure TvcmNULLContainer.ChildDataSourceChanged(const aChild : IvcmEntityForm;
                                                   const anOld  : IvcmFormDataSource;
                                                   const aNew   : IvcmFormDataSource);
  {* - вызывается при изменении источника данных вложенной формы. }
begin
end;

procedure TvcmNULLContainer.SetFocusToMainObjectForm;
begin
end;

function TvcmForm.Get_Container: IvcmContainer;
  {-}
var
 l_Form : TCustomForm;
begin
 Result := nil;
 l_Form := Self;
 while true do
 begin
  l_Form := afw.GetAnotherParentForm(l_Form);
  if (l_Form = nil) then
   break
  else
   if Supports(l_Form, IvcmContainer, Result) then
    break
 end;//while true
 if (Result = nil) then
  Result := TvcmNULLContainer.Make;
end;

function TvcmForm.Get_NativeMainForm: IvcmContainer;
  {-}
var
 l_Form : TCustomForm;
begin
 l_Form := afw.GetMainForm(Self);
 if l_Form = nil then
 begin
  if not Supports(self, IvcmContainer, Result) then
   Assert(csDestroying in ComponentState);
 end
 else
  if not Supports(l_Form, IvcmContainer, Result) then
   Assert(csDestroying in ComponentState);
end;

function TvcmForm.DoShowModal: Integer;
  {-}
begin
 Result := ShowModal;
end;

// start class TvcmInterfacedForm

type
 _Unknown_Child_ = TvcmInterfacedForm;
{$I l3ImplCleanup.inc}
begin
 inherited;
end;

procedure TvcmInterfacedForm.BeforeKill;
  //virtual;
  {-}
begin
end;

procedure TvcmInterfacedForm.DoLoadFromSettings;
  //virtual;
  {-}
begin
end;

procedure TvcmInterfacedForm.DoSaveInSettings;
  //virtual;
  {-}
begin
end;

function TvcmInterfacedForm.NeedSaveInSettings: Boolean;
begin
 Result := True;
end;

{$If not defined(DesignTimeLibrary)}
{$IfDef l3HackedVCL}
function TvcmInterfacedForm.IsAcceptableControlForTabNavigation(aControl: TWinControl): Boolean;
begin
 if Assigned(afwFacade.g_IsAcceptableControlForTabNavigationHook) then
  Result := afwFacade.g_IsAcceptableControlForTabNavigationHook(aControl)
 else
  Result := true;
end;

procedure TvcmInterfacedForm.SelectNext(CurControl: TWinControl;
  GoForward: Boolean;
  CheckTabStop: Boolean);
begin
 if not Assigned(afwFacade.g_DoTabHook) OR
    not afwFacade.g_DoTabHook(CurControl, not GoForward) then
  inherited;
end;//TafwBaseControl.SelectNext
{$EndIf l3HackedVCL}
{$IfEnd} //not DesignTimeLibrary

procedure TvcmInterfacedForm.ClearModal;
  //virtual;
  {-}
begin
 Exclude(FFormState, fsModal);
end;

procedure TvcmInterfacedForm.Close;
  {-}
var
 l_Action: TCloseAction;
begin
 if IsModal then
  SafeClose
 else
 begin
  l_Action := caFree;
  inherited DoClose(l_Action);
  // - здесь именно inherited, т.к. в "родном" поднимаем Exception
  Case l_Action of
   caNone : ;
   caHide : Hide;
   caFree : SafeClose;
   caMinimize : WindowState := wsMinimized;
  end;//Case l_Action
 end;//IsModal
end;

procedure TvcmInterfacedForm.DoUpdateStatus;
  //virtual;
  {-}
begin
end;

procedure TvcmInterfacedForm.WMClose(var Message: TWMClose);
  //message WM_Close;
  {-}
begin
 Close;
end;

procedure TvcmInterfacedForm.WMSetText(var Message: TWMSetText);
  // message WM_SETTEXT;
  {-}
var
 l_Char: PChar;
begin
 l_Char := Message.Text;
 while l_Char^ <> #0 do
 begin
  if l_Char^ in [#1..Pred(' ')] then
   l_Char^ := ' ';
  Inc(l_Char);
 end;
 inherited;
end;

procedure TvcmInterfacedForm.CMRelease(var Message: TMessage);
  //message CM_RELEASE;
  {-}
begin
 KillMe;
end;

procedure TvcmInterfacedForm.vcmMsgCloseForm(var Message: TMessage);
  //message vcm_msgCloseForm;
  {-}
begin
 KillMe;
end;

function TvcmInterfacedForm.IsModal: Boolean;
  //virtual;
  {-}
begin
 Result := (fsModal in FFormState);
end;

function TvcmInterfacedForm.IsContained: Boolean;
  //virtual;
  {-}
begin
 Result := IsContained;
end;

procedure TvcmInterfacedForm.DoClose(var Action: TCloseAction);
  //override;
  {-}
begin
 Assert(IsModal, 'Для закрытия VCM-форм пользуйтесь методом SafeClose');
 Action := caFree;
 // - освобождаем все модальные окна.
 inherited;
end;

function TvcmInterfacedForm.CloseQuery: Boolean;
  //override;
  {-}
begin
 Result := CallCloseQuery(Self);
end;

function TvcmInterfacedForm.CallCloseQuery(aCaller : TCustomForm): Boolean;
  //virtual;
  {-}
var
 l_Index : Integer;
 l_List: TvcmObjectList;
begin
 if VCMClosing then
  // - нас уже спрашивали и мы уже находимся в процессе закрытия
  Result := true
 else
 begin
  Result := inherited CloseQuery;
  if Result then
  begin
   l_List := TvcmObjectList.Make;
   try
    for l_Index := 0 to ComponentCount-1 do
     if Components[l_Index] is TvcmInterfacedForm then
      l_List.Add(Components[l_Index]);

    if Assigned(f_OnCloseQueryEx) then
     f_OnCloseQueryEx(Self, Result, aCaller);
    if Result then
    begin
     for l_Index := 0 to l_List.Count-1 do
     begin
      Result := TvcmInterfacedForm(l_List.Items[l_Index]).CallCloseQuery(aCaller);
      if not Result then
       Exit;
     end;//for l_Index
     DoSaveInSettings;
    end;//Result
   finally
    vcmFree(l_List);
   end;
  end;//Result
 end;
end;

function TvcmInterfacedForm.Get_Dispatcher: IvcmDispatcher;
  {-}
begin
 Result := vcmDispatcher;
end;

// start class TvcmTextForm

procedure TvcmTextForm.Cleanup;
  //override;
  {-}
begin
 f_Text := nil;
 inherited;
end;

procedure TvcmTextForm.NotifyContainerCaptionChanged;
var
 l_Parent: TWinControl;
 l_Container: IafwMainFormContainer;
begin
 if NeedNotifyContainerOnCaptionChanged then
 begin
  l_Parent := Self;
  while (l_Parent <> nil) do
  begin
   l_Parent := l_Parent.Parent;
   if Supports(l_Parent, IafwMainFormContainer, l_Container) then
   try
    l_Container.UpdateFormCaption(Self);
    Break;
   finally
    l_Container := nil;
   end;//try..finally
  end;//while (l_Parent <> nil)...
 end;
end;//NotifyContainerCaptionChanged

function TvcmTextForm.NeedNotifyContainerOnCaptionChanged: Boolean;
begin
 Result := True;
end;

procedure TvcmTextForm.CreateParams(var aParams: TCreateParams);
  //override;
  {-}
begin
 if not vcmIsNil(CCaption) then
  {$IfDef XE}
  WindowText := StrNew(PChar(l3DStr(CCaption)));
  {$Else  XE}
  WindowText := StrNew(PChar(vcmStr(CCaption)));
  {$EndIf XE}
 inherited;
end;

procedure TvcmTextForm.WMGetText(var Msg: TMessage);
  {message WM_GetText;}
  {-}
begin
 with Msg do
  {$IfDef XE}
  Result := StrLen(StrLCopy(PChar(LParam), PChar(l3DStr(CCaption)), WParam - 1));
  {$Else  XE}
  Result := StrLen(StrLCopy(PChar(LParam), PChar(vcmStr(CCaption)), WParam - 1));
  {$EndIf XE}
end;

procedure TvcmTextForm.WMGetTextLength(var Msg: TMessage);
  {message WM_GetTextLength;}
  {-}
begin
 Msg.Result := vcmLen(CCaption);
end;

procedure TvcmTextForm.WMSetText(var Msg: TMessage);
  {message WM_SetText;}
  {-}
begin
 if (Msg.lParam <> 0) then
 begin
  Msg.Result := Ord(true);
  CCaption := vcmCStr(PChar(Msg.lParam));
 end//Msg.lParam <> 0
 else
  Msg.Result := Ord(false);
end;                                                                    

function TvcmTextForm.pm_GetCCaption: IafwCString;
  {-}
begin
 Result := f_Text;
end;

procedure TvcmTextForm.pm_SetCCaption(const aValue: Il3CString);
  {-}
var
 l_Value: Il3CString;
 l_Container: IafwMainFormContainer;
begin
 l_Value := vcmReplaceEnters(aValue);
 if not vcmSame(f_Text, l_Value) then
 begin
  f_Text := l_Value;
  Perform(CM_TEXTCHANGED, 0, 0);
  SendDockNotification(afw_CM_TEXTCHANGED, 0, Integer(l_Value));
  //if HandleAllocated then
   // Без этого вызова не обновлялся заголовок кнопки на таскбаре с выключенными темами.
   // ЦК27048
   (*CallWindowProc(DefWndProc, Handle, WM_SetText, 0, Integer(PChar(vcmStr(f_Text))))*)
{  begin
   if ThemeServices.ThemesAvailable and IsThemeActive then
    CallWindowProc(DefWndProc, Handle, WM_SetText, 0, Integer(PChar(vcmStr(f_Text))))
   else
    RedrawWindow(Handle, nil, 0, RDW_FRAME + RDW_INVALIDATE);
  end;//HandleAllocated}
  NotifyContainerCaptionChanged;
 end;//not vcmSame(f_Text, aValue)
end;

function TvcmTextForm.pm_GetCaption: Tl3DString;
  {-}
begin
 Result := vcmDStr(CCaption);            
end;

procedure TvcmTextForm.pm_SetCaption(const aValue: Tl3DString);
  {-}
begin
 CCaption := vcmCStr(aValue);
end;
{$EndIf  NoVCM}

end.

