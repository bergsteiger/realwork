unit eeSubList;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: eeSubList -     }
{ Начат: 12.02.2003 18:21 }
{ $Id: eeSubList.pas,v 1.1 2015/01/20 11:54:23 lulin Exp $ }

// $Log: eeSubList.pas,v $
// Revision 1.1  2015/01/20 11:54:23  lulin
// - правим зависимости.
//
// Revision 1.1  2014/12/09 14:16:03  kostitsin
// {requestlink: 580710238 }
//
// Revision 1.31  2014/12/05 14:51:04  kostitsin
// {requestlink: 570118718 } - eeInterfaces
//
// Revision 1.30  2014/04/25 16:12:06  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.29  2014/04/11 15:30:31  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.28  2014/04/07 17:57:00  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.27  2014/04/04 17:53:35  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.26  2013/10/21 15:42:59  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.25  2013/10/21 10:30:43  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.24  2010/02/11 13:45:28  lulin
// - выкидываем неудавшийся фасад.
//
// Revision 1.23  2009/07/23 16:45:59  lulin
// - чистим код.
//
// Revision 1.22  2009/07/23 13:42:13  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.21  2009/04/06 17:51:28  lulin
// [$140837386]. №11.
//
// Revision 1.20  2009/03/04 13:32:52  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.19  2009/03/03 17:42:02  lulin
// - <K>: 137470629. Убран ненужный промежуточный модуль.
//
// Revision 1.18  2007/12/04 12:47:34  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.16.4.8  2007/09/14 13:26:09  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.16.4.7.2.1  2007/09/12 19:56:50  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.16.4.7  2007/09/11 18:50:00  lulin
// - удален ненужный параметр.
//
// Revision 1.16.4.6  2007/04/18 11:00:13  oman
// warning fix
//
// Revision 1.16.4.5  2007/02/16 17:54:08  lulin
// - избавляемся от стандартного строкового типа.
//
// Revision 1.16.4.4  2007/01/05 14:37:22  lulin
// - cleanup.
//
// Revision 1.16.4.3  2005/11/09 15:28:27  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.16.4.2  2005/07/19 12:50:09  lulin
// - часть базовых интерфейсов переехала в модуль nevTools.
//
// Revision 1.16.4.1  2005/05/18 12:42:49  lulin
// - отвел новую ветку.
//
// Revision 1.15.2.1  2005/04/28 09:18:32  lulin
// - объединил с веткой B_Tag_Box.
//
// Revision 1.15.4.1  2005/04/23 16:07:28  lulin
// - удален временный интерфейс Ik2TagBox.
//
// Revision 1.15  2005/03/28 11:32:10  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.14  2005/03/24 14:10:34  lulin
// - удалены ненужные методы.
//
// Revision 1.13  2005/03/21 16:28:19  lulin
// - переходим к _Ik2Tag.
//
// Revision 1.12  2005/03/19 16:39:54  lulin
// - спрятаны ненужные методы.
//
// Revision 1.11  2004/10/13 10:33:33  lulin
// - new behavior: синхронизируем удаление комментариев.
//
// Revision 1.10  2004/10/12 12:51:50  lulin
// - bug fix: ошибка List Index Out Of Bounds - при удалении несуществующей закладки (CQ OIT5-10262).
//
// Revision 1.9  2004/10/11 09:44:00  lulin
// - сделана возможность сразу указывать имя метки при ее установке.
//
// Revision 1.8  2004/04/08 19:19:41  law
// - optimization: убраны директивы stdcall.
//
// Revision 1.7  2004/03/03 12:45:07  law
// - new param default value: IeeSubList.Add(anID: Integer = ee_SubAutoID).
//
// Revision 1.6  2004/01/06 13:25:44  law
// - bug fix: Sub ставился на курсор, а не на параграф (CQ OIT5-5784).
//
// Revision 1.5  2003/09/09 11:04:00  demon
// - bug fix: AV при получении списка закладок при отсутствии документа.
//
// Revision 1.4  2003/09/08 14:12:43  law
// - new method: TeeSubList._Make.
// - new prop: IeeDocument.Bookmarks.
//
// Revision 1.3  2003/09/02 12:26:25  law
// - new method: TeeHotSpot._Make.
//
// Revision 1.2  2003/02/13 13:36:27  law
// - new prop: _IeeSub.Name, IeeSubList.SubByID.
//
// Revision 1.1  2003/02/12 15:29:18  law
// - new units.
//

{$Include evDefine.inc }

interface

uses
  Classes,

  l3Interfaces,
  l3Types,
  l3Base,

  k2Interfaces,

  nevBase,

  eeConst,
  eeInterfaces,
  eeInterfacesEx,
  eeTagEditorTool
  ;

type
  TeeSubList = class(TeeTagEditorTool, IeeSubList)
    private
    // internal fields
      f_Handle: Integer;
    protected
    // interface methods
      // IeeSubList
      function Get_Count: Integer;
        {-}
      function Get_Subs(anIndex: Integer): IeeSub;
        {-}
      function Get_SubsByID(anID: Integer): IeeSub;
        {-}
      function Add(anID  : Integer = ee_SubAutoID;
                   const aName : Il3CString = nil): IeeSub;
        {-}
    public
    // public methods
      constructor Create(aTagWrap   : Tl3Variant;
                         const aDocument  : IeeDocumentEx;
                         aHandle          : Integer;
                         const aProcessor : InevProcessor);
        reintroduce;
        {-}
      class function Make(aTagWrap   : Tl3Variant;
                          const aDocument  : IeeDocumentEx;
                          aHandle          : Integer;
                          const aProcessor : InevProcessor = nil): IeeSubList;
        reintroduce;
        {-}
  end;//TeeSubList

implementation

uses
  l3String,

  k2Tags,
  
  evInternalInterfaces,

  nevTools,
  
  eeSub,

  Document_Const
  ;

// start class TeeSubList

constructor TeeSubList.Create(aTagWrap   : Tl3Variant;
                              const aDocument  : IeeDocumentEx;
                              aHandle          : Integer;
                              const aProcessor : InevProcessor);
  //reintroduce;
  {-}
begin
 inherited Create(aTagWrap, aDocument, aProcessor);
 f_Handle := aHandle;
end;

class function TeeSubList.Make(aTagWrap   : Tl3Variant;
                               const aDocument  : IeeDocumentEx;
                               aHandle          : Integer;
                               const aProcessor : InevProcessor = nil): IeeSubList;
  {-}
var
 l_SubList : TeeSubList;
begin
 l_SubList := Create(aTagWrap, aDocument, aHandle, aProcessor);
 try
  Result := l_SubList;
 finally
  l3Free(l_SubList);
 end;//try..finally
end;

function TeeSubList.Get_Count: Integer;
  {-}
begin
 if (TagInst = nil) then
  Result := 0
 else
  with TagInst.rAtomEx([k2_tiSubs,
                      k2_tiChildren, k2_tiHandle, f_Handle]) do
   if IsValid then
    Result := ChildrenCount
   else
    Result := 0;
end;

function TeeSubList.Get_Subs(anIndex: Integer): IeeSub;
  {-}
var
 l_Child : Tl3Variant;
begin
 if (TagInst = nil) then
  Result := nil
 else
  with TagInst.rAtomEx([k2_tiSubs,
                      k2_tiChildren, k2_tiHandle, f_Handle]) do
  begin
   if IsValid then
   begin
    try
     l_Child := Child[anIndex];
    except
     on EListError do
     begin
      Result := TeeSub.Make(Document,
                            -1,
                            IntA[k2_tiHandle],
                            0);
      Exit;                      
     end;//on EListError
    end;//try..except
    if l_Child.IsValid then
     Result := TeeSub.Make(Document,
                           l_Child.IntA[k2_tiHandle],
                           IntA[k2_tiHandle],
                           0)
    else
     Result := TeeSub.Make(Document,
                           -1,
                           IntA[k2_tiHandle],
                           0);
   end//IsValid
   else
    Result := TeeSub.Make(Document,
                          -1,
                          f_Handle,
                          0);
  end;//with TagInst..
end;

function TeeSubList.Get_SubsByID(anID: Integer): IeeSub;
  {-}
begin
 Result := TeeSub.Make(Document, anID, f_Handle, 0);
end;

function TeeSubList.Add(anID  : Integer = ee_SubAutoID;
                        const aName : Il3CString = nil): IeeSub;
  {-}
var
 l_EP  : Tl3Variant;
 l_Sub : IevSub;
begin
 if (TagInst = nil) OR TagInst.IsKindOf(k2_typDocument) then
  l_EP := Document.EntryPoint
 else
  l_EP := TagInst;
 if (anID = ee_SubAutoID) then
  l_Sub := Document.NewSubEx[f_Handle]
 else
  l_Sub := Document.SubEx[anID, f_Handle];
 if (aName <> nil) then
  l_Sub.Name := aName.AsWStr; 
 l_Sub.SetTo(l_EP);
 Result := Get_SubsByID(l_Sub.ID);
end;

end.

