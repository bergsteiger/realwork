unit nscEditor;
{* Редактор с поддержкой набора доступных команд, для проекта Немезис. }

{ Библиотека "Nemesis Controls" }
{ Начал: Люлин А.В.             }
{ Модуль: nscEditor -           }
{ Начат: 17.11.2004 21:26       }
{ $Id: nscEditor.pas,v 1.32 2015/06/23 13:33:20 dinishev Exp $ }

// $Log: nscEditor.pas,v $
// Revision 1.32  2015/06/23 13:33:20  dinishev
// {Requestlink:602001677}
//
// Revision 1.31  2015/06/16 10:19:30  dinishev
// {Requestlink:259171453}
//
// Revision 1.30  2015/03/12 10:12:54  lulin
// - перетряхиваем слова.
//
// Revision 1.29  2010/12/02 12:24:11  lulin
// {RequestLink:244195072}.
// [$244712576].
//
// Revision 1.28  2010/12/01 15:02:18  lulin
// {RequestLink:244195072}.
//
// Revision 1.27  2010/12/01 14:57:35  lulin
// {RequestLink:244195072}.
//
// Revision 1.26  2010/12/01 11:32:35  lulin
// {RequestLink:239375984}.
//
// Revision 1.25  2010/11/30 15:00:04  lulin
// {RequestLink:239375984}.
//
// Revision 1.24  2009/06/10 12:26:50  lulin
// - цепляем фильтр имён блоков к экспорту.
// - восстанавливаем код пропавший (точнее пролюбленный) при переносе на модель.
// - фильтруем полностью выделенные блоки.
//
// Revision 1.23  2006/11/10 17:15:50  lulin
// - объединил с веткой.
//
// Revision 1.22.6.1  2006/11/09 11:48:58  lulin
// - разрешаем честное скроллирование консультаций - сильно выиграли в скорости.
//
// Revision 1.22  2006/07/03 10:56:10  oman
// - new beh: Публикуем операции WordLeft и WordRight (cq21546)
//
// Revision 1.21  2006/06/08 13:37:39  lulin
// - подготавливаем контролы к обработке числа повторений нажатия клавиши.
//
// Revision 1.20  2006/06/05 08:42:50  lulin
// - заплатка для борьбы с рудиментапи при скроллировании, при включенных блоках (CQ OIT5-21050).
//
// Revision 1.19  2006/05/02 14:24:36  dinishev
// Заплатка для текста ответа на консультацию
//
// Revision 1.18  2005/07/25 12:43:44  lulin
// - bug fix: не компилировался пакет компонент с Эверестом из HEAD.
//
// Revision 1.17  2005/07/19 09:37:45  lulin
// - избавился от посылки сообщений.
//
// Revision 1.16  2005/01/17 10:49:55  lulin
// - new behavior: давим Paste по ShortCut'у, если таковой назначен в VCM.
//
// Revision 1.15  2005/01/14 17:24:06  lulin
// - в ProcessCommand добавлен параметр aForce - сигнализирующий, что такого ShortCut'а нету в VCM и что не надо умничать с обработкой комманды.
//
// Revision 1.14  2004/11/25 15:28:49  lulin
// - new behavior: редактор для Немезиса теперь обрабатывает Ctrl-стрелки ТОЛЬКО в пользовательских комментариях.
//
// Revision 1.13  2004/11/25 08:33:49  lulin
// - перенес поддержку операций с TnscEditor на TevEditorWithOperations.
//
// Revision 1.12  2004/11/24 17:26:58  lulin
// - bug fix: не компилировалась библиотека.
//
// Revision 1.11  2004/11/24 16:27:04  lulin
// - добавлены операции с параметрами шрифта.
//
// Revision 1.10  2004/11/24 16:12:55  lulin
// - добавлены операции с колонками и строками таблицы.
//
// Revision 1.9  2004/11/24 15:50:48  lulin
// - добавлена операция - вставить таблицу.
//
// Revision 1.8  2004/11/24 13:47:47  lulin
// - new behavior: обработчики операций от контролов теперь вызываются, когда надо выполнить операции.
//
// Revision 1.7  2004/11/24 12:35:50  lulin
// - new behavior: обработчики операций от контролов теперь привязываются к операциям.
//
// Revision 1.6  2004/11/18 18:05:42  lulin
// - new unit: _vcmDefaultOperations.
//
// Revision 1.5  2004/11/18 17:45:27  lulin
// - new method: IvcmOperationsProvider.ProvideOps.
//
// Revision 1.4  2004/11/18 17:33:54  lulin
// - new interface: IvcmParamsPrim.
//
// Revision 1.3  2004/11/18 15:58:47  lulin
// - отвязываем библиотеки от VCM без использования inc'ов.
//
// Revision 1.2  2004/11/17 19:05:07  lulin
// - new interface: IvcmEntitiesProvider.
//
// Revision 1.1  2004/11/17 18:39:08  lulin
// - new unit: nscEditor.
//

{$Include nscDefine.inc }  

interface

uses
  l3Types,

  k2Interfaces,
  
  eeEditor
  ;

type
  TnscEditor = class(TeeEditor)
   {* Редактор с поддержкой набора доступных команд, для проекта Немезис. }
    protected
    // internal methods
      {$IfNDef DesignTimeLibrary}
      function  ProcessCommandEx(Cmd     : Long;
                                 aForce  : Boolean;
                                 _wParam : Cardinal;
                                 aCount  : Integer): Bool;
        override;
        {-process the specified command, return true if processed}
      function MakeExportFilters(aSelection: Boolean; aForExport : Boolean): Ik2TagGenerator;
        override;
        {-}
      {$EndIf  DesignTimeLibrary}
  end;//TnscEditor

implementation

uses
  afwFacade,
  
  evOp,
  evMsgCode
  
  {$IfNDef DesignTimeLibrary}
  ,
  evdBlockNameAdder,
  f1ExternalHyperlinkEliminator,
  evdHeaderHyperlinkAdder,

  nsConst
  {$EndIf  DesignTimeLibrary}
  ;

// start class TnscEditor

{$IfNDef DesignTimeLibrary}
function TnscEditor.ProcessCommandEx(Cmd     : Long;
                                     aForce  : Boolean;
                                     _wParam : Cardinal;
                                     aCount  : Integer): Bool;
  //override;
  {-process the specified command, return true if processed}
begin
 if aForce then
  Result := inherited ProcessCommandEx(Cmd, aForce, _wParam, aCount)
 else
 begin
  Case Cmd of
   ev_ocPaste:
    if not InUserComment then
     Result := false
    else
     Result := inherited ProcessCommandEx(Cmd, aForce, _wParam, aCount);
   else
    Result := inherited ProcessCommandEx(Cmd, aForce, _wParam, aCount);
  end;//Case Cmd
 end;//aForce
end;

function TnscEditor.MakeExportFilters(aSelection: Boolean; aForExport : Boolean): Ik2TagGenerator;
  //override;
  {-}
begin
 Result := inherited MakeExportFilters(aSelection, aForExport);
 if aForExport then
 begin
  if aSelection then
  begin
   if afw.Application.Settings.LoadBoolean(pi_Document_ExportWithBlockNames, dv_Document_ExportWithBlockNames) then
    TevdBlockNameAdder.SetTo(Result)
{   else
    TevdHeaderHyperlinkAdder.SetTo(Result)};
  end//aSelection
  else
   TevdHeaderHyperlinkAdder.SetTo(Result);
  Tf1ExternalHyperlinkEliminator.SetTo(Result);
 end //aForExport
 else
  Tf1ExternalHyperlinkEliminator.SetTo(Result);
end;
{$EndIf  DesignTimeLibrary}

end.

