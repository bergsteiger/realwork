unit eeProcessor;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: eeProcessor -   }
{ Начат: 20.10.2003 19:20 }
{ $Id: eeProcessor.pas,v 1.15 2015/10/09 14:48:33 kostitsin Exp $ }

// $Log: eeProcessor.pas,v $
// Revision 1.15  2015/10/09 14:48:33  kostitsin
// {requestlink: 604917289 } - инициализируем неинициализированное
//
// Revision 1.14  2015/10/08 05:45:31  dinishev
// {Requestlink:567555433}
//
// Revision 1.13  2014/04/30 11:23:57  lulin
// - выпрямляем зависимости.
//
// Revision 1.12  2014/04/11 15:30:40  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.11  2014/04/07 17:57:06  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.10  2014/04/04 17:53:42  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.9  2014/04/03 17:10:31  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.8  2014/03/26 15:51:59  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.7  2014/03/25 11:53:32  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.6  2014/03/20 12:23:58  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.5  2013/10/21 15:43:05  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.4  2013/10/21 10:30:51  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.3  2013/07/31 12:24:48  morozov
// {RequestLink: 474153528}
//
// Revision 1.2  2010/11/24 11:12:22  lulin                                      
// {RequestLink:238945411}.
//
// Revision 1.1  2010/04/21 16:52:40  lulin
// {RequestLink:144575972}.
// - переходим к абсолютным путям для включаемых файлов.
//
// Revision 1.1  2009/11/30 15:52:20  lulin
// {RequestLink:159352472}.
//
// Revision 1.28  2009/07/23 13:42:13  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.27  2009/03/05 13:09:38  lulin
// - <K>: 137470629. Используем ссылки на типы.
//
// Revision 1.26  2009/03/04 13:32:52  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.25  2009/03/03 17:42:02  lulin
// - <K>: 137470629. Убран ненужный промежуточный модуль.
//
// Revision 1.24  2008/11/11 09:01:46  lulin
// - <K>: 114459503.
// - F1 не собиралась.
//
// Revision 1.23  2008/07/14 16:37:45  lulin
// - поправлен комментарий.
//
// Revision 1.22  2008/07/02 14:55:02  lulin
// - <K>: 97353892.
//
// Revision 1.21  2008/06/20 14:48:54  lulin
// - используем префиксы элементов.
//
// Revision 1.20  2007/12/04 12:47:34  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.19.8.21  2007/09/06 09:37:39  lulin
// - переименовано свойство.
//
// Revision 1.19.8.20  2007/09/04 17:27:39  lulin
// - убран ненужный параметр.
//
// Revision 1.19.8.19  2007/08/02 19:41:39  lulin
// - cleanup.
//
// Revision 1.19.8.18  2006/06/22 14:19:28  lulin
// - bug fix: падали при вставке параграфов вслед комментарием из буфера обмена (CQ OIT5-19704).
//
// Revision 1.19.8.17  2006/03/30 11:49:24  lulin
// - cleanup: вытираем код для редактирования комментариев не в виде дерева.
//
// Revision 1.19.8.16  2005/12/14 15:07:16  lulin
// - bug fix: при установке стиля не сбрасывались собственные параметры параграфа (CQ OIT5-18649).
//
// Revision 1.19.8.15  2005/12/14 12:48:22  lulin
// - не даем вставлять комментарии внутри подписи.
//
// Revision 1.19.8.14  2005/12/14 09:42:04  lulin
// - убрал лишний параметр, из-за которого не компилировался HEAD.
//
// Revision 1.19.8.13  2005/12/09 16:48:32  lulin
// - убрана лишняя конкретизация типа.
//
// Revision 1.19.8.12  2005/12/09 16:36:38  lulin
// - убрано лишнее заворачивание параграфа в комментарий.
//
// Revision 1.19.8.11  2005/12/09 15:44:11  lulin
// - bug fix: слишком поздно корректировали стиль параграфов в комментарии (CQ OIT5-18487).
//
// Revision 1.19.8.10  2005/11/21 10:38:01  lulin
// - cleanup.
//
// Revision 1.19.8.9  2005/11/21 09:56:57  lulin
// - удален ненужный глобальный метод.
//
// Revision 1.19.8.8  2005/11/21 09:33:13  lulin
// - типизируем более конкретно параметр метода _DoCheckParaOp.
//
// Revision 1.19.8.7  2005/11/21 09:10:30  lulin
// - bug fix: не даем вставить два подряд комментария.
//
// Revision 1.19.8.6  2005/11/21 08:28:38  lulin
// - валидируем тип вставляемого параграфа, и если он не комментарий, то заворачиваем его в комментарий.
//
// Revision 1.19.8.5  2005/11/09 15:28:27  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.19.8.4  2005/07/21 05:05:06  lulin
// - распилил модуль с TextSource на несколько.
//
// Revision 1.19.8.3  2005/07/15 12:41:59  lulin
// - теперь процеесор операций знает не про безликого Owner'а, а про вполне конкретный DocumentContainer.
//
// Revision 1.19.8.2  2005/07/15 10:14:05  lulin
// - избавляемся от использования самостийной функции преобразования интерфейсов.
//
// Revision 1.19.8.1  2005/07/13 15:48:30  lulin
// - new unit: evEditorWindowTextSource.
//
// Revision 1.19  2005/03/28 11:32:10  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.18  2005/03/10 11:35:12  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.17  2005/03/09 18:40:22  lulin
// - remove method: Tk2AtomR.DeleteChild.
// - new method: _Ik2Tag.DeleteChild.
//
// Revision 1.16  2005/01/31 17:38:22  lulin
// - bug fix: параграфам в таблицах и блоках не выставлялся стиль "Пользовательский комментарий".
//
// Revision 1.15  2004/11/17 17:32:06  lulin
// - окончательно починена синхронизация вставки/удаления комментариев, отъехавшая в связи с переходом на блоки.
//
// Revision 1.14  2004/11/16 10:02:23  lulin
// - cleanup: избавляемся от кода, связанного с тем, что комментарии были не в блоке.
//
// Revision 1.13  2004/11/11 18:24:13  lulin
// - в первом приближении сделано корректное удаление блоков с комментариями.
//
// Revision 1.12  2004/11/04 14:03:06  lulin
// - bug fix: при Undo была ошибка о невозможности вставить комментарий (CQ OIT5-10709).
//
// Revision 1.11  2004/07/08 12:20:43  law
// - new behavior: вставляем комментарий не в SBS а после него (CQ OIT5-8052).
//
// Revision 1.10  2004/05/25 11:31:38  law
// - bug fix: не всегда вставлялись комментарии пользователя в оглавление (CQ OIT5-7125).
//
// Revision 1.9  2004/03/22 13:37:37  law
// - bug fix: "При редактировании пользовательских комментариев пропадает значок «пользовательского комментария» на полях" (CQ OIT5-5474).
//
// Revision 1.8  2004/03/22 13:13:32  law
// - new interface: IeeEditorEx.
//
// Revision 1.7  2004/01/10 12:32:01  law
// - bug fix:  CQ OIT5-4347:
// demon (12.09.2003): Ошибка только в том, что эти вставленные параграфы оказываются не комментариями пользователя, а просто текстом.
// А вставлять, думаю можно....
//
// Revision 1.6  2003/12/03 15:50:51  law
// - bug fix: не вызывалось событие OnUserCommentDelete, не исчезала иконка в SubPanel (CQ OIT5-4675).
//
// Revision 1.5  2003/11/17 17:10:42  law
// - bug fix: можно было удалить не только комментарии, но и целиком выделенные блоки документа.
//
// Revision 1.4  2003/10/30 11:51:44  law
// - bug fix: не всегда проверялась возможность вставки параграфа.
//
// Revision 1.3  2003/10/21 11:15:40  law
// - new behavior: не даем удалять параграфы, которые не пользовательские комментарии, в частности картинки.
//
// Revision 1.2  2003/10/20 16:02:04  law
// - change: начата поддержка "листьевых" параграфов.
// - new behavior: задел на неудаление параграфом (картинок в частности).
//
// Revision 1.1  2003/10/20 15:42:20  law
// - new unit: eeProcessor.
// - new method: TevCustomProcessor._DoCheckParaOp (virtual).
//

{$Include evDefine.inc }

interface

uses
  l3Interfaces,
  l3Types,
  l3Variant,

  k2Interfaces,
  
  evEditorWindowProcessor,

  nevBase,
  nevTools
  ;

type
  TeeProcessor = class(TevEditorWindowProcessor)
    protected
    // internal methods
      procedure DoCheckParaOp(aParent  : Tl3Variant;
                              var aChild     : Tl3Variant;
                              anOp           : Tl3Operation;
                              anIndex        : TnevParaIndex);
        override;
        {* - проверить операцию с параграфом. }
  end;//TeeProcessor

implementation

uses
  SysUtils,

  l3Base,
  l3InterfacesMisc,

  k2Tags,
  k2OpMisc,

  evdStyles,
  evParaTools,
  
  eeInterfaces,
  eeInterfacesEx,
  eeExceptions,
  eePara,

  LeafPara_Const,
  CommentPara_Const,
  Document_Const,
  SBS_Const,

  evDocumentsCache
  ;

resourcestring
  cCannotInsertPara = 'Сюда нельзя вставить комментарий';
  cCannotDeletePara = 'Нельзя удалять не комментарии';

// start class TeeProcessor

procedure TeeProcessor.DoCheckParaOp(aParent  : Tl3Variant;
                                     var aChild     : Tl3Variant;
                                     anOp           : Tl3Operation;
                                     anIndex        : TnevParaIndex);
  //override;
  {* - проверить операцию с параграфом. }
var
 l_ID : Integer;
 l_Container : InevObjectHolder;

 procedure CorrectParaStyle(aPara: Tl3Variant);

 var
  l_Op : InevOp;

  procedure CorrectParaStylePrim(aPara: Tl3Variant);
  var
   l_Index : Integer;
  begin
   if aPara.IsKindOf(k2_typLeafPara) then
    aPara.IntW[k2_tiStyle, l_Op] := ev_saUserComment
   else
   begin
    for l_Index := 0 to Pred(aPara.ChildrenCount) do
     CorrectParaStylePrim(aPara.Child[l_Index]);
   end;//aPara.IsKindOf(k2_typLeafPara)
  end;

 var
  l_U : Boolean;
  l_M : Boolean;
 begin
  l_U := False;
  l_M := False;
  l_Op := Context;
  if (l_Op <> nil) then
  begin
   l_U := l_Op.SaveUndo;
   l_M := l_Op.DeleteMapped;
   l_Op.SaveUndo := false;
   l_Op.DeleteMapped := true;
  end;//l_Op <> nil
  CorrectParaStylePrim(aPara);
  if (l_Op <> nil) then
  begin
   l_Op.SaveUndo := l_U;
   l_Op.DeleteMapped := l_M;
  end;//l_Op <> nil
 end;

 procedure lp_NotifyOtherTexts(const anObj: InevObject);

  function lp_DoContainer(aDoc: PIUnknown; anIndex: Integer): Boolean;
  var
   l_AnotherContainer : InevDocumentContainer;
   l_Para : InevObject;
   l_ParaPID : Integer;
   l_List : InevObjectList;
   l_ListItemObj : InevObject;
   l_Obj : TObject;
   l_ParaObject : InevPara;
   l_SameText : Boolean;
   l_Op : InevOp;
  begin
   Result := True;
   l_AnotherContainer := InevDocumentContainer(aDoc^);
   if not l3IEQ(l_AnotherContainer, l_Container) AND
    l_AnotherContainer.IsSameText(l_Container) and
    not l_AnotherContainer.Processor.InOp then
   begin
    if l_AnotherContainer.FindObjByID(l_ID, l_Para) then
    begin
     l_ParaPID := l_Para.PID;
     l_List := l_Para.OwnerObj;
     if (l_ParaPID + 1 < l_List.Count) then
     begin
      l_ListItemObj := l_List[l_ParaPID + 1];
      if (l_ListItemObj.AsObject.IsKindOf(k2_typCommentPara)) then
      begin
       if l_ListItemObj.AsObject.QT(InevObject, l_ParaObject) then
       begin
        l_Op := k2StartOp(l_AnotherContainer.Processor);
        if not l_ParaObject.Edit.Delete(False, l_Op) then
         Assert(false);
        l_Op := nil;
       end//l_ListItemObj.QT
       else
        Assert(false);
      end;//(l_ListItemObj.IsKindOf(k2_typCommentPara))
      l_ListItemObj := nil;
     end;//(l_ParaPID + 1 < l_List.Count)
     l_List := nil;
    end;//l_AnotherContainer.FindObjByID
   end;//not l3IEQ
   l_AnotherContainer := nil;
  end;//lp_DoContainer

 var
  l_PID : Integer;
 begin
  Assert(anObj <> nil);
  l_PID := anObj.PID;
  if (l_PID > 0) then
  begin
   l_ID := anObj.OwnerObj[l_PID - 1].AsObject.IntA[k2_tiHandle];
   TevDocumentsCache.IterateF(l3L2IA(@lp_DoContainer));
  end;//if (l_PID > 0)
 end;//lp_NotifyOtherTexts

var
 l_Para   : IeePara;
 l_Editor : IeeEditor;
 l_Child  : Tl3Variant;
 l_ChildObj: InevObject;
begin
 inherited;
 if (Document As InevDocumentContainer).TextSource.CastAnyEditorTo(IeeEditor, l_Editor) then
  try
   Case anOp of
    l3_opDelete:
    begin
     // http://mdp.garant.ru/pages/viewpage.action?pageId=474153528
     if (aChild.IsKindOf(k2_typCommentPara)) then
     begin
      if (aChild.QT(InevObject, l_ChildObj)) then
      try
       l_Container := l_ChildObj.Holder;
       lp_NotifyOtherTexts(l_ChildObj);
      finally
       l_ChildObj := nil;
       l_Container := nil;
      end;// try..finally
     end;// aChild.IsKindOf(k2_typCommentPara)
     if not InUndo then
      if not IsCheckOff then
       if not evInPara(aChild, k2_typCommentPara) then
       // - проверяем, что вставляем внутрь комментария
        if evInPara(aChild, k2_typDocument) then
        // - проверяем, что вставляем в кого-то, кто принадлежит документу
        // http://mdp.garant.ru/pages/viewpage.action?pageId=97353892
         raise EeeCannotDeletePara.Create(cCannotDeletePara);
    end;//l3_opDelete
    l3_opInsert:
    begin
     if not InUndo AND not IsCheckOff then
     begin
      CorrectParaStyle(aChild);
      if evInPara(aParent, k2_typCommentPara) then
       // - это уже комментарий - вставлять можно
       Exit;
      l_Para := TeePara.Make(aParent.Child[Pred(anIndex)], l_Editor As IeeDocumentEx);
      try
       if not l_Editor.CanSplitPara(l_Para) then
        raise EeeCannotInsertPara.Create(cCannotInsertPara);
       if evInPara(aParent, k2_typSBS) then
        // - не даем вставлять комментарии внутри подписи.
        raise EeeCannotInsertPara.Create(cCannotInsertPara);
       if not aChild.IsKindOf(k2_typCommentPara) then
       begin
        if (anIndex > 0) AND ((anIndex < aParent.ChildrenCount) AND
           aParent.Child[Pred(anIndex)].IsKindOf(k2_typCommentPara)) then
         raise EeeCannotInsertPara.Create(cCannotInsertPara);
        l_Child := k2_typCommentPara.MakeTag.AsObject;
        try
         l_Child.AddChild(aChild);
         l_Child.SetRef(aChild);
        finally
         l_Child := nil;
        end;//try..finally
       end;//not aChild.IsKindOf(ee_idCommentPara)
      finally
       l_Para := nil;
      end;//try..finally
     end;//not InUndo
    end;//l3_opInsert
   end;//Case anOp
  finally
   l_Editor := nil;
  end;//try..finally
end;

end.

