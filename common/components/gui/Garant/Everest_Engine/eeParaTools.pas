unit eeParaTools;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: eeParaTools -   }
{ Начат: 14.10.2004 08:41 }
{ $Id: eeParaTools.pas,v 1.3 2014/04/25 15:58:48 lulin Exp $ }

// $Log: eeParaTools.pas,v $
// Revision 1.3  2014/04/25 15:58:48  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.2  2014/04/07 17:57:06  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.1  2010/04/21 16:52:40  lulin
// {RequestLink:144575972}.
// - переходим к абсолютным путям для включаемых файлов.
//
// Revision 1.1  2009/09/14 11:28:08  lulin
// - выводим пути и для незавершённых модулей.
//
// Revision 1.10  2009/07/23 08:14:42  lulin
// - вычищаем ненужное использование процессора операций.
//
// Revision 1.9  2009/06/25 12:57:33  lulin
// - вычищаем ненужный контекст.
//
// Revision 1.8  2009/03/03 17:42:02  lulin
// - <K>: 137470629. Убран ненужный промежуточный модуль.
//
// Revision 1.7  2007/12/04 12:47:33  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.5.4.10  2006/11/03 11:00:11  lulin
// - объединил с веткой 6.4.
//
// Revision 1.5.4.9.6.1  2006/11/01 16:40:21  oman
// - fix: AV при поиске нумерованного параграфа (cq23383)
//
// Revision 1.5.4.9  2006/08/28 14:05:35  oman
// - new beh: Ближайший нумерованный параграф умеем теперь
//  искать и сначала вниз (cq22407)
//
// Revision 1.5.4.8  2006/06/22 09:19:24  lulin
// - cleanup: вычищены устаревшие методы.
//
// Revision 1.5.4.7  2006/04/26 15:01:55  lulin
// - bug fix: падали, когда не приводилось к нужному интерфейсу, в частности при вставке комментария в толковом словаре.
//
// Revision 1.5.4.6  2006/04/26 14:26:31  oman
// - fix: interface not supported при поиске следующего/предыдущего параграфа (cq20704)
//
// Revision 1.5.4.5  2006/04/24 09:26:57  oman
// - new beh: выделены утилитные функции для поиска ближайшего
//  листьевого параграфа
//
// Revision 1.5.4.4  2005/11/09 15:28:27  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.5.4.3  2005/11/04 16:48:00  lulin
// - базовый объект теперь поддерживает свое удаление.
//
// Revision 1.5.4.2  2005/06/06 15:36:12  lulin
// - продолжаем бороться со знанием о природе реализации курсоров.
//
// Revision 1.5.4.1  2005/05/18 12:42:49  lulin
// - отвел новую ветку.
//
// Revision 1.3.2.1  2005/04/28 09:18:32  lulin
// - объединил с веткой B_Tag_Box.
//
// Revision 1.4.2.1  2005/04/23 16:07:28  lulin
// - удален временный интерфейс Ik2TagBox.
//
// Revision 1.4  2005/04/21 05:11:41  lulin
// - используем _Box (пока из-за постоянных преобразований туда и обратно - по скорости стало только хуже).
//
// Revision 1.3  2005/03/30 11:56:24  lulin
// - bug fix: не удалялся комментарий из документа, который лежит в кеше (CQ OIT5-13060).
//
// Revision 1.2  2004/11/17 17:32:06  lulin
// - окончательно починена синхронизация вставки/удаления комментариев, отъехавшая в связи с переходом на блоки.
//
// Revision 1.1  2004/10/14 09:32:56  lulin
// - new behavior: теперь комментарии синхронизируются между различными окнами.
//

{$Include eeDefine.inc }

interface

uses
  eeInterfaces,
  eeInterfacesEx
  ;

function eeFindNumberedPara(const aPara: IeePara; const aEditor: IeeDocumentEx;
 const aSearchDown: Boolean = False): IeeLeafPara;
  { Ищет ближайший нумерованный параграф, сначала вверх, потом вниз }
function eePrevOverallPara(const aPara: IeePara; const aEditor: IeeDocumentEx): IeePara;
  { Ищет предыдущий параграф, с заходом в родителей }
function eeNextOverallPara(const aPara: IeePara; const aEditor: IeeDocumentEx): IeePara;
  { Ищет следующий параграф, с заходом в родителей }

implementation

uses
  SysUtils,

  l3Interfaces,

  k2Interfaces,

  evMsgCode,
  evParaTools,

  nevTools,
  
  eePara
  ;

function eeFindNumberedPara(const aPara: IeePara; const aEditor: IeeDocumentEx;
 const aSearchDown: Boolean = False): IeeLeafPara;
var
 l_Para: InevPara;
 l_ParaLeaf: InevLeafPara;
begin
 if Assigned(aPara) then
 begin
  if aPara.AsObject.QT(InevPara, l_Para, aEditor.Processor) then
  begin
   l_ParaLeaf := evFindNumberedPara(l_Para, aSearchDown);
   if not Assigned(l_ParaLeaf) OR
      not Supports(TeePara.Make(l_ParaLeaf.AsObject, aEditor), IeeLeafPara, Result) then
    Result := nil;
  end
  else
  begin
   Assert(false);
   Result := nil;
  end;
 end
 else
  Result := nil;
end;

function eePrevOverallPara(const aPara: IeePara; const aEditor: IeeDocumentEx): IeePara;
var
 l_Para: InevPara;
 l_ParaLeaf: InevPara;
begin
 if aPara.AsObject.QT(InevPara, l_Para, aEditor.Processor) then
 begin
  l_ParaLeaf := evPrevOverallPara(l_Para);
  if not Assigned(l_ParaLeaf) OR
     not Supports(TeePara.Make(l_ParaLeaf.AsObject, aEditor), IeeLeafPara, Result) then
   Result := nil;
 end
 else
 begin
  Assert(false);
  Result := nil;
 end;
end;

function eeNextOverallPara(const aPara: IeePara; const aEditor: IeeDocumentEx): IeePara;
var
 l_Para: InevPara;
 l_ParaLeaf: InevPara;
begin
 if aPara.AsObject.QT(InevPara, l_Para, aEditor.Processor) then
 begin
  l_ParaLeaf := evNextOverallPara(l_Para);
  if not Assigned(l_ParaLeaf) OR
     not Supports(TeePara.Make(l_ParaLeaf.AsObject, aEditor), IeeLeafPara, Result) then
   Result := nil;
 end
 else
 begin
  Assert(false);
  Result := nil;
 end;
end;

end.

