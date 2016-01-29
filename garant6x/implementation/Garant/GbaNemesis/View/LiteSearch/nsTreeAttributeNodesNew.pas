unit nsTreeAttributeNodesNew;

// $Id: nsTreeAttributeNodesNew.pas,v 1.3 2010/11/01 17:20:11 lulin Exp $

// $Log: nsTreeAttributeNodesNew.pas,v $
// Revision 1.3  2010/11/01 17:20:11  lulin
// {RequestLink:237994238}.
// - передаём ссылку на "модель".
// - делаем, чтобы собирались другие проекты.
//
// Revision 1.2  2010/11/01 13:20:46  lulin
// {RequestLink:237994238}.
//
// Revision 1.1  2009/11/06 13:06:48  lulin
// - избавился от ручной передачи параметров через поле Data.
//
// Revision 1.77  2009/10/21 16:26:05  lulin
// - переносим на модель ноды оболочки.
//
// Revision 1.76  2009/07/31 17:30:07  lulin
// - убираем мусор.
//
// Revision 1.75  2009/02/10 18:47:31  lulin
// - <K>: 133891247. Выделяем интерфейсы работы с адаптером и советами дня.
//
// Revision 1.74  2009/02/09 19:17:30  lulin
// - <K>: 133891247. Выделяем интерфейсы поиска.
//
// Revision 1.73  2008/10/30 15:09:22  lulin
// - <K>: 121159648.
//
// Revision 1.72  2008/01/10 07:23:08  oman
// Переход на новый адаптер
//
// Revision 1.71.4.1  2007/11/21 10:26:28  oman
// Перепиливаем на новый адаптер
//
// Revision 1.71  2007/08/14 14:29:57  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.70  2007/03/29 13:18:58  oman
// Вычитываем таки параметры контекстного фильтра для атрибутов
//
// Revision 1.69  2007/03/29 10:20:52  oman
// - fix: Пытаемся читать настройки контекстной фильтрации. Пока безуспешно
//
// Revision 1.68  2007/03/29 09:31:46  oman
// - new: Контекстная фильтрация атрибутов - первое приближение
//  (cq24456)
//
// Revision 1.67  2007/03/29 06:43:22  oman
// - new: Деревья атрибутов умеют накладывать дополнительные
//  фильтры (TextOpt и Trim) (cq24456)
//
// Revision 1.66  2007/03/28 14:52:15  oman
// - new: Избавляемся от ContextParams в КЗ (cq24456)
// - new: Деревья почти готовы для переключения на новый
//  контекстный фильтр (cq24456)
//
// Revision 1.65  2007/03/28 11:05:35  oman
// Начинаем дружить деревья атрибутов с контекстным фильтром
//
// Revision 1.64  2007/03/28 08:39:45  oman
// cleanup
//
// Revision 1.63  2007/03/27 11:59:34  oman
// Переводим тэг атрибутов на константную строку
//
// Revision 1.62  2007/03/27 06:57:08  oman
// - fix: СБрасываем кэш
//
// Revision 1.61  2007/03/14 16:41:47  lulin
// - cleanup.
//
// Revision 1.60  2007/03/06 13:30:49  oman
// Cleanup - убран мусорный параметр
//
// Revision 1.59  2007/03/02 15:16:59  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.58  2007/02/08 15:31:48  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.57  2007/02/07 14:30:50  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.56  2007/02/06 15:20:59  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.55  2007/02/02 09:10:50  lulin
// - упрощаем преобразование строк.
//
// Revision 1.54  2007/02/02 08:39:25  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.53  2007/02/02 07:23:36  oman
// - fix: Прошляпили begin - end
//
// Revision 1.52  2007/01/30 15:24:23  lulin
// - текст ноды - теперь более простого типа.
//
// Revision 1.51  2007/01/22 11:19:33  lulin
// - cleanup.
//
// Revision 1.50  2006/12/25 10:19:23  lulin
// - параметры строки теперь получаем одним вызовом, а не тремя.
//
// Revision 1.49  2006/12/22 11:47:37  lulin
// - не перевычисляем длину текста при работе с нодами.
//
// Revision 1.48  2006/09/27 13:42:15  mmorozov
// В рамках работы над CQ: OIT500022679.
//
// - remove: TTagSearch, TTagSearchList, TAvailableTags. В списки были не работоспособны, в единственном месте где списки использовались, можно было обойтись _IAttributeInfo;
// - remove: неиспользуемые операции в enSelectedAttributesForm (enSelectedList: opAdd, opDelete, opChangeOperation);
// - new: TnsTaggedTreeInfo наделен логикой;
//
// Revision 1.47  2006/09/25 13:00:51  mmorozov
// - new behaviour: фильтруем все папки кроме "Мои документы" при сохранении/открытии объектов из моих документов;
// - new behaviour: папка "Мои документы" не скрывается при фильтрации по типу объекта;
// - _move: интерфейсы перенесены в модуль _nsInterfaces;
//
// Revision 1.46  2006/09/13 09:46:21  oman
// - new beh: Поддержка свернуть/развернуть для новых деревьях -
//  убираение устаревших операций/интерфейсов(InsExpandedState)
//  /классов (cq22540)
//
// Revision 1.45  2006/04/20 14:31:23  lulin
// - распиливаем листы.
// - правим после Вовановых переименований методов.
//
// Revision 1.44  2006/04/20 08:53:53  oman
// - new beh: перекладываем StdStr в _StdRes
//
// Revision 1.43  2006/03/22 08:41:54  oman
// - new beh: Перекладываем все текстовые константы в три места (StdStr, DebugStr и SystemStr)
//
// Revision 1.42  2005/11/22 18:54:32  lulin
// - продолжаем пилить дерево на разные функциональные части.
//
// Revision 1.41  2005/11/22 18:29:34  lulin
// - продолжаем пилить дерево на разные функциональные части.
//
// Revision 1.40  2005/11/22 17:28:13  lulin
// - продолжаем пилить дерево на разные функциональные части.
//
// Revision 1.39  2005/11/21 17:32:07  lulin
// - cleanup.
//
// Revision 1.38  2005/11/21 15:38:38  lulin
// - вставлены директивы CVS.
//

{$include nsDefine.inc}

interface

// <no_string>

uses
 l3Interfaces,
 l3IID,
 l3Types,
 l3Base,
 l3Nodes,
 l3Tree,
 l3Tree_TLB,
 l3TreeInterfaces,

 afwInterfaces,

 vcmExternalInterfaces,

 DynamicTreeUnit,

 nsTypes,
 nsDataResetTreeStruct,
 nsOneLevelTreeStruct,
 nsFilterableTreeStruct,
 nsNodes,

 SearchDomainInterfaces,
 nsNewCachableNode
 ;

type
  TnsLogicNode = class(Tl3PlaceNode, InsLogicOperation)
  private
   f_LogicOperation : TLogicOperation;
  protected
    function  GetAsPCharLen: Tl3PCharLenPrim;
      override;
      {-}
   function pm_GetOperation : TLogicOperation;
   procedure pm_SetOperation(aValue : TLogicOperation);
  public
   procedure Cleanup;
     override;
   constructor Create(aOperation: TLogicOperation);
     reintroduce;
     overload;
   class function Make(aOperation: TLogicOperation): Il3Node;
     reintroduce;
  end;//TnsLogicNode

  TnsSelectedNode = class(TnsNewCachableNode)
  private
   f_Brief   : boolean;
   f_Caption : Il3CString;
  protected
    function  GetAsPCharLen: Tl3PCharLenPrim;
      override;
      {-}
   procedure Cleanup;
     override;
  public
   constructor Create(const aNode: INodeBase;
                      aBrief: Boolean);
     reintroduce;
     overload;

   class function Make(const aNode: INodeBase;
                       aBrief: Boolean): Il3Node;
     reintroduce;
     overload;
  end;//TnsSelectedNode

  TnsSelectedRoot = class(Tl3PlaceNode)
  {-}
  protected
  // protected methods
    function  GetAsPCharLen: Tl3PCharLenPrim;
      override;
      {-}
  public
  // public methods
   class function Make : Il3SimpleRootNode;
     reintroduce;
     {-}
  end;//TnsSelectedRoot

implementation

uses
 SysUtils,

 DataAdapter,

 l3String,
 l3InterfacesMisc,

 vcmBase,

 bsUtils,

 nsConst,
 nsAttributeTreeCacheNew,
 {$IfNDef Admin}
 nsSearchClasses,
 {$EndIf  Admin}
 nsSettings,
 nsTreeStruct,
 nsAttributeTreeFilters,

 StdRes
 ;

{ TnsLogicNode }

procedure TnsLogicNode.Cleanup;
begin
 inherited;
 f_LogicOperation := loNone;
end;

constructor TnsLogicNode.Create(aOperation: TLogicOperation);
begin
 f_LogicOperation := aOperation;
end;

class function TnsLogicNode.Make(aOperation: TLogicOperation): Il3Node;
Var
 l_Node: TnsLogicNode;
begin
 l_Node := TnsLogicNode.Create(aOperation);
 try
  Result := l_Node;
 finally
  l3Free(l_Node);
 end;
end;

function TnsLogicNode.pm_GetOperation: TLogicOperation;
begin
 Result := f_LogicOperation;
end;

function TnsLogicNode.GetAsPCharLen: Tl3PCharLenPrim;
  //override;
  {-}
begin
 case f_LogicOperation of
  loNone:
   l3AssignNil(Result);
  loAnd:
   Result := vcmCStr(str_LogicOpAndTreeCaption).AsWStr;
  loOr:
   Result := vcmCStr(str_LogicOpOrTreeCaption).AsWStr;
  loNot:
   Result := vcmCStr(str_LogicOpExceptTreeCaption).AsWStr;
  else
   l3AssignNil(Result);
 end;//case f_LogicOperation
end;

procedure TnsLogicNode.pm_SetOperation(aValue: TLogicOperation);
begin
 f_LogicOperation := aValue;
end;

{ TnsSelectedRoot }

class function TnsSelectedRoot.Make: Il3SimpleRootNode;
Var
 l_Node: TnsSelectedRoot;
begin
 l_Node := TnsSelectedRoot.Create;
 try
  Result := l_Node;
 finally
  l3Free(l_Node);
 end;
end;

function TnsSelectedRoot.GetAsPCharLen: Tl3PCharLenPrim;
  //override;
  {-}
begin
 Result := vcmCStr(str_SelectedAttributedRootNode).AsWStr;
end;

{ TnsSelectedNode }

procedure TnsSelectedNode.Cleanup;
begin
 f_Caption := nil;
 inherited;
end;

constructor TnsSelectedNode.Create(const aNode: INodeBase;
  aBrief: Boolean);
begin
 inherited Create(aNode);
 f_Brief := aBrief;
end;

class function TnsSelectedNode.Make(const aNode: INodeBase;
  aBrief: Boolean): Il3Node;
var
 l_Node: TnsSelectedNode;
begin
 l_Node := Create(aNode, aBrief);
 try
  Supports(l_Node, Il3Node, Result);
 finally
  vcmFree(l_Node);
 end;
end;

function TnsSelectedNode.GetAsPCharLen: Tl3PCharLenPrim;
  //override;
  {-}
var
 l_Str            : Il3CString;
 l_Path           : Il3CString;
 l_ParentNode     : INodeBase;
 l_PrevParentNode : INodeBase;
begin
 if (f_Caption = nil) and Assigned(AdapterNode) then
 begin
  l_Str := nsGetCaption(AdapterNode);
  if f_Brief then
  begin
   AdapterNode.GetParent(l_ParentNode);
   if (l_ParentNode <> nil) then
   begin
    l_ParentNode.GetParent(l_PrevParentNode);
    if (l_PrevParentNode <> nil) then
    begin
     l_Path := nil;
     repeat
      l_Path := l3Cat([l3Cat(nsGetCaption(l_ParentNode), '\'), l_Path]);
      l_ParentNode := l_PrevParentNode;
      l_ParentNode.GetParent(l_PrevParentNode);
     until l_PrevParentNode = nil;
     l_Str := l3Cat(l3Cat([l3Cat(l_Str, #13'['), l_Path]), ']');
    end;//l_PrevParentNode <> nil
   end;//l_ParentNode <> nil
  end;//f_Brief
  f_Caption := l_Str;
 end;//f_Caption = nil
 Result := l3PCharLen(f_Caption);
end;

end.
