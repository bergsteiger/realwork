unit nsThreadNotifier;

{ Автор: Тучнин Д.А. © }
{ Модуль: nsThreadNotifier - объект для синхронизации нотификаций, приходящих с сервера в другой триаде}
{ Начат: 25.10.2005 13:00 }

{ $Id: nsThreadNotifier.pas,v 1.9 2015/01/15 14:17:12 lulin Exp $ }
//$Log: nsThreadNotifier.pas,v $
//Revision 1.9  2015/01/15 14:17:12  lulin
//{RequestLink:585926571}. Используем Interlocked.
//
//Revision 1.8  2012/08/03 13:17:23  kostitsin
//[$380616604]
// - nsThreadNotifier
//
//Revision 1.7  2008/08/05 06:31:07  lulin
//- переименовываем в рамках <K>: 93264761.
//
//Revision 1.6  2008/02/14 17:08:45  lulin
//- cleanup.
//
//Revision 1.5  2008/01/10 07:23:30  oman
//Переход на новый адаптер
//
//Revision 1.4.22.4  2007/12/11 07:02:38  oman
//Перепиливаем на новый адаптер
//
//Revision 1.4.22.3  2007/12/10 09:39:34  oman
//Перепиливаем на новый адаптер
//
//Revision 1.4.22.2  2007/12/10 09:23:56  oman
//Перепиливаем на новый адаптер
//
//Revision 1.4.22.1  2007/11/16 14:03:50  oman
//Перепиливаем на новый адаптер
//
//Revision 1.4  2005/11/30 16:56:20  lulin
//- при синхронизации посылаем объект, а не буфер.
//
//Revision 1.3  2005/11/21 14:11:01  lulin
//- нотификатор выделен в шаблон.
//
//Revision 1.2  2005/11/15 11:31:27  migel
//- fix: при выходе из оболочки ожидаем полного цикла прохождения нотификации (CQ: 17910).
//
//Revision 1.1  2005/10/25 09:18:34  demon
//- new behavior: выделен отдельный объект (и модуль) TnsThreadNotifier для обработки нотификаций не в основной триаде
//

interface
uses
  Classes,
  Windows,
  Messages,

  l3Base,
  l3CacheableBase,
  
  vcmBase,

  FoldersUnit
  ;

type
  _ThreadNotifierParent_ = TvcmCacheableBase;
  {$Include l3ThreadNotifier.int.pas}
  TnsThreadNotifier = class(_ThreadNotifier_)
  end;//TnsThreadNotifier

  TnsDoneNotifierThread = class(TThread)
    private
      f_DoneNotifier: IDoneNotifier;
    protected
      procedure Execute;
        override;
        {-}
    public
      constructor Create(aDoneNotifier: IDoneNotifier);
        reintroduce;
        {-}
  end;//TnsDoneNotifierThread

implementation

uses
  l3Interlocked,
  
  afwFacade,

  SysUtils
  ;

{$Include l3ThreadNotifier.int.pas}  

// Start class TnsDoneNotifierThread

procedure TnsDoneNotifierThread.Execute;
begin
 try
  try
   f_DoneNotifier.Done;
  finally
   f_DoneNotifier := nil;
  end;
 except
  on E: Exception do
   l3System.Exception2Log(E);
 end;
end;

constructor TnsDoneNotifierThread.Create(aDoneNotifier: IDoneNotifier);
begin
 inherited Create(True);
 //
 f_DoneNotifier := aDoneNotifier;
end;

end.
