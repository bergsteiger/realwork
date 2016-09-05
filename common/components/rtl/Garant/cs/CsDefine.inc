{ $Id: CsDefine.inc,v 1.13 2016/05/24 08:25:40 lukyanets Exp $ }

// $Log: CsDefine.inc,v $
// Revision 1.13  2016/05/24 08:25:40  lukyanets
// Cleanup
//
// Revision 1.12  2015/02/24 11:59:38  lukyanets
// Передаем по новому
//
// Revision 1.11  2015/02/19 09:39:35  lukyanets
// Заготовки для проверки альтернативного подхода
//
// Revision 1.10  2015/01/23 06:12:43  lukyanets
// Накоммител лишнего
//
// Revision 1.9  2015/01/22 14:31:37  lukyanets
// Переносим отсылку задачи в более правильное место
//
// Revision 1.8  2015/01/22 11:34:01  lukyanets
// Переносим директивы
//
// Revision 1.7  2014/12/16 07:57:52  lukyanets
// Логирование
//
// Revision 1.6  2014/09/22 12:54:10  lukyanets
// Вычитывали таск не того класса.
//
// Revision 1.5  2014/08/01 11:31:02  lukyanets
// {Requestlink:558466572}. Переопределяем Define
//
// Revision 1.4  2010/05/20 06:30:29  voba
// - не собиралось со старым редактором
//
// Revision 1.3  2006/03/10 09:29:12  voba
// - enh. убрал CsFree etc.
//
// Revision 1.2  2006/02/08 17:24:29  step
// выполнение запросов перенесено из классов-потомков в процедуры объектов
//

{$Define CsDebug}
{$Define csNewQueueTaskLine}
{.$Define ncsSniffMessage}

{$Include evDefine.inc}

{$A-,B-,F+,K-,U-,V-,W-,X+}

{$WriteableConst On}

{$Define csSynchroTransport}

{$If defined(AppServerSide) or defined(ServerAssistantSide)}
  {$DEFINE ServerTasks}
{$IfEnd defined(AppServerSide) or defined(ServerAssistantSide)}

