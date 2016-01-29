unit eeVirtualNode;
{* Базовая реализация виртуального узла дерева. }

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: eeVirtualNode - }
{ Начат: 29.05.2003 19:28 }
{ $Id: eeVirtualNode.pas,v 1.5 2015/01/25 17:43:27 kostitsin Exp $ }

// $Log: eeVirtualNode.pas,v $
// Revision 1.5  2015/01/25 17:43:27  kostitsin
// рисуем TeeNode
//
// Revision 1.4  2014/12/05 14:51:03  kostitsin
// {requestlink: 570118718 } - eeInterfaces
//
// Revision 1.3  2014/04/03 17:10:31  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.2  2012/11/01 07:10:30  lulin
// - вычищаем мусор.
//
// Revision 1.1  2010/04/21 16:52:40  lulin
// {RequestLink:144575972}.
// - переходим к абсолютным путям для включаемых файлов.
//
// Revision 1.2  2009/10/20 17:59:26  lulin
// {RequestLink:159360578}. №4.
//
// Revision 1.54  2009/10/20 17:55:59  lulin
// {RequestLink:159360578}. №4.
//
// Revision 1.52  2009/07/20 11:21:58  lulin
// - заставляем работать F1 после - {RequestLink:141264340}. №7, 32, 33.
//
// Revision 1.51  2008/04/07 06:18:39  lulin
// - cleanup.
//
// Revision 1.50  2008/03/20 09:48:12  lulin
// - cleanup.
//
// Revision 1.49  2007/12/04 12:47:34  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.48.24.8  2007/03/20 13:58:40  lulin
// - избавляемся от лишних преобразований строк.
//
// Revision 1.48.24.7  2007/02/16 17:54:08  lulin
// - избавляемся от стандартного строкового типа.
//
// Revision 1.48.24.6  2006/12/22 15:06:32  lulin
// - текст ноды - теперь структура с длиной и кодовой страницей.
//
// Revision 1.48.24.5  2005/07/28 15:37:08  lulin
// - правки в соответствии с изменениями Вована в интерфейсах нотификаторов.
//
// Revision 1.48.24.4  2005/07/21 14:56:12  lulin
// - выделен класс виртуальных нод, обладающих флагами.
//
// Revision 1.48.24.3  2005/07/21 14:47:33  lulin
// - базовая виртуальная нода вынесена в отдельный модуль.
//
// Revision 1.48.24.2  2005/07/21 14:16:38  lulin
// - интерфейсы для нотификации переехали в модуль базовых интерфейсов.
//
// Revision 1.48.24.1  2005/07/15 10:14:06  lulin
// - избавляемся от использования самостийной функции преобразования интерфейсов.
//
// Revision 1.48  2004/06/22 12:56:04  law
// - убран метод Set_AllChildrenCount, т.к. он теперь реализован в родительском классе.
//
// Revision 1.47  2004/06/21 16:12:40  law
// - bug fix: в классе Tl3CustomVirtualNode был абстрактный метод Set_AllChildrenCount.
//
// Revision 1.46  2004/06/21 15:44:22  law
// - в Tl3CustomVirtualNode.ReleaseChilds добавлен Assert, т.к. она все равно нерабочая.
//
// Revision 1.45  2004/06/03 17:29:13  law
// - правки в связи с появлением интерфейса Il3Base.
//
// Revision 1.44  2004/06/01 14:56:28  law
// - удалены конструкторы Tl3VList.MakeLongint, MakeLongintSorted - пользуйтесь _Tl3LongintList.
//
// Revision 1.43  2004/05/27 14:31:59  law
// - new methods: _Tl3_CBase.IsCacheable, _NeedStoreInPool.
//
// Revision 1.42  2004/05/27 08:59:10  law
// - change: исбавился от лишнего метода IsMyIntf - вместо нео теперь всегда используется IsSame.
//
// Revision 1.41  2004/05/26 18:17:19  law
// - change: Il3Node теперь наследуется от Il3SimpleNode.
//
// Revision 1.40  2004/05/26 14:21:59  law
// - change: скестил "ежа с ужом" (старые деревья с новыми).
//
// Revision 1.39  2004/04/27 07:25:31  law
// - remove prop: IeeNode.Expanded.
// - cleanup: из TeeNode убрано знание про _Tl3Tree.
//
// Revision 1.38  2004/04/13 13:29:39  law
// - cleanup: убрано лишнее приведение через As к Il3Node.
//
// Revision 1.37  2004/04/13 08:49:48  demon
// - optimise: операция Iterate - не вызывается IsMyIntf, если aFromNode = nil
//
// Revision 1.36  2004/04/08 19:19:41  law
// - optimization: убраны директивы stdcall.
//
// Revision 1.35  2004/04/02 10:54:51  demon
// - new: операция GetLevelForParent вынесена на интерфейс IeeNode
//
// Revision 1.34  2004/02/13 10:05:23  law
// - bug fix: в Cleanup не очищались флаги ноды.
//
// Revision 1.33  2004/01/30 18:23:37  demon
// - cleanup: удалена реализация SortChilds (переехала на TnsBaseNode)
// - new: на интерфейс IeeNode добавлены функции Move, RelocateChild, SortChilds.
//
// Revision 1.32  2004/01/30 11:39:51  demon
// - cleanup: удалена неиспользуемая функция _InsertChild(по имени)
// - new: добавлена функция InsertChildBefore
//
// Revision 1.31  2003/12/27 16:39:02  law
// - new behavior: не прогружаем список при очистке кеша.
//
// Revision 1.30  2003/12/11 19:01:08  law
// - cleanup: навел порядок с AllChildrenCount и ThisChildrenCount.
//
// Revision 1.29  2003/12/11 12:50:11  law
// - rename: все упоминания ChildsCount переименованы в AllChildrenCount.
//
// Revision 1.28  2003/12/10 09:14:07  law
// - new method: Il3InternalNode.Set_NextNodePrim.
//
// Revision 1.27  2003/11/05 16:32:01  law
// - new prop: IeeNode.IsFirst, IsLast.
//
// Revision 1.26  2003/08/21 15:10:14  demon
// - new: в интерфейс IeeNode вынесены свойства PrevNode и NextNode
//
// Revision 1.25  2003/07/28 11:56:54  law
// - new methods: IeeNode.Iterate, IterateF.
//
// Revision 1.24  2003/07/28 09:50:34  demon
// - bug fix : неправильно работал итератор при невозвращении Result
//
// Revision 1.23  2003/07/15 13:44:48  law
// - new prop: IeeNode.ParentNode.
//
// Revision 1.22  2003/07/09 11:29:08  demon
// - bug fix: был AV при рассылке нотификаций от ноды (т. к. была непоправлена старая реализация).
//
// Revision 1.21  2003/07/04 15:28:39  demon
// - fix: Изменился формат операций нотификации.
//
// Revision 1.20  2003/07/02 17:27:36  law
// - bug fix: неправильно удалялся элемент списка (TnsListChild). Проблемы остались, но мячик на стороне сервера.
//
// Revision 1.19  2003/07/01 18:08:11  law
// - new prop: TeeNode.ChildNode.
//
// Revision 1.18  2003/06/25 09:22:31  law
// - change: ParentNodeClass, ChildNodeClass и компания сделаны функциями экземпляров, а не классов.
//
// Revision 1.17  2003/06/21 12:29:25  law
// - new method: IeeNode.Delete.
//
// Revision 1.16  2003/06/11 13:00:46  law
// - new behavior: изменнен алгоритм расчета NumInParent - вместо цикла сделана рекурсия, чтобы кеш NumInParent был эффективнее.
//
// Revision 1.15  2003/06/04 14:39:20  demon
// - bug fix: неправильно присваивался следующий узел.
//
// Revision 1.14  2003/06/03 16:45:07  demon
// - bug fix: использовалась ссылка на неправильный класс (Tl3Node).
//
// Revision 1.13  2003/06/03 14:27:50  demon
// - new method: IeeNode.IsSameNode.
//
// Revision 1.12  2003/06/03 08:21:21  law
// - new prop: IeeNode.HasChild.
//
// Revision 1.11  2003/06/02 15:25:22  law
// - cleanup: перед интерфейсными параметрами поставлен модификатор const.
//
// Revision 1.10  2003/05/30 17:24:48  law
// - change: методы l3*Flag переименованы в l3*Mask.
//
// Revision 1.9  2003/05/30 17:11:21  law
// - new behavior: убрана реализация свойства Parent - т.к. виртуальной ноде она ни к чему.
//
// Revision 1.8  2003/05/30 17:07:48  law
// - cleanup.
//
// Revision 1.7  2003/05/30 14:26:23  law
// - bug fix.
//
// Revision 1.6  2003/05/30 14:25:25  law
// - new behavior: реализован метод Tl3CustomVirtualNode.Get_ChildsCount.
//
// Revision 1.5  2003/05/30 12:26:36  law
// - new class: Tl3CustomVirtualNode.
//
// Revision 1.4  2003/05/29 16:50:39  law
// - new behavior: TeeVirtualNode теперь сама хранит родительский узел (Parent).
//
// Revision 1.3  2003/05/29 16:42:43  law
// - new behavior: TeeVirtualNode теперь сама хранит флаги.
//
// Revision 1.2  2003/05/29 16:22:26  law
// - new behavior: TeeVirtualNode теперь поддерживает интерфейс IeeNode.
//
// Revision 1.1  2003/05/29 15:57:17  law
// - new unit: eeVirtualNode.
//

{$Include evDefine.inc }

interface

uses
  Windows,

  l3Interfaces,
  l3Types,
  l3TreeInterfaces,
  l3Tree_TLB,
  l3Base,
  l3Nodes,
  l3VirtualNode,

  eeInterfaces
  ;

type
  TeeVirtualNode = class(Tl3VirtualFlagsNode, IeeNode)
   {* Базовая реализация виртуального узла дерева. }
    private
    // interface methods
      // IeeNode
      function  IeeNode_Get_Text: Il3CString;
      procedure IeeNode_Set_Text(const aValue: Il3CString);
        {-}
      function  IeeNode_Get_ID: Integer;
      procedure IeeNode_Set_ID(aValue: Integer);
        {-}
      function  IeeNode_Get_HasChild: Boolean;
        {-}
      function  IeeNode_Get_ChildNode: IeeNode;
        {-}
      function  IeeNode_Get_ParentNode: IeeNode;
        {-}
      function  IeeNode_Get_NextNode: IeeNode;
        {-}
      function  IeeNode_Get_PrevNode: IeeNode;
        {-}
      function  Get_IsFirst: Boolean;
        {-}
      function  Get_IsLast: Boolean;
        {-}
      function  IeeNode_InsertChild(const aNode: IeeNode): IeeNode;
        {-}
      function  IeeNode_InsertChildBefore(const aNextChild: IeeNode; const aChild: IeeNode): IeeNode;
        {-}
      procedure IeeNode_Changing;
        {-}
      procedure IeeNode_Changed;
        {-}
      procedure IeeNode_Remove;
        {* - удалить узел из дерева. }
      procedure IeeNode_Delete;
        {* - удалить узел из дерева. }
      procedure IeeNode_RemoveChildren;
        {* - освободить дочерние узлы. }
      function  IeeNode_Move(aDirection : TeeDirection) : Boolean;
        {* - переместить узел. }
      procedure RelocateChild(const aChild: IeeNode);
        {* - перемещает указанного ребенка, руководствуясь критериями
             сортировки относительно других детей (в пределах одного уровня)}
      procedure IeeNode_SortChilds;
        {* - пересортировывает всех детей (один уровень)}
      function  IeeNode_IsSameNode(const aNode: IeeNode): Boolean;
        {-}
      function  IeeNode_GetLevelForParent(const aParent: IeeNode): Integer;
        {* Рассчитывает уровеньтекущей Ноду относительно заданного Paretnt'а }
      function  IeeNode_Iterate(Action          : TeeNodeAction;
                                IterMode        : Integer = 0;
                                const aFromNode : IeeNode = nil) : IeeNode;
       {* - перебрать все дочерние узлы. IterMode см. imExpandOnly etc. }
      function  IeeNode_IterateF(Action          : TeeNodeAction;
                                 IterMode        : Integer = 0;
                                 const aFromNode : IeeNode = nil) : IeeNode;
       {* - перебрать все дочерние узлы и освободить заглушку для Action. }
      function  IeeNode.Get_Text = IeeNode_Get_Text;
      procedure IeeNode.Set_Text = IeeNode_Set_Text;
      function  IeeNode.Get_ID = IeeNode_Get_ID;
      procedure IeeNode.Set_ID = IeeNode_Set_ID;
      procedure IeeNode.Changing = IeeNode_Changing;
      procedure IeeNode.Changed = IeeNode_Changed;
      procedure IeeNode.Remove = IeeNode_Remove;
      procedure IeeNode.Delete = IeeNode_Delete;
      procedure IeeNode.RemoveChildren = IeeNode_RemoveChildren;
      function  IeeNode.Move = IeeNode_Move;
      function  IeeNode.Get_HasChild = IeeNode_Get_HasChild;
      function  IeeNode.Get_ChildNode = IeeNode_Get_ChildNode;
      function  IeeNode.Get_ParentNode = IeeNode_Get_ParentNode;
      function  IeeNode.Get_NextNode = IeeNode_Get_NextNode;
      function  IeeNode.Get_PrevNode = IeeNode_Get_PrevNode;
      function  IeeNode.InsertChild = IeeNode_InsertChild;
      function  IeeNode.InsertChildBefore = IeeNode_InsertChildBefore;
      procedure IeeNode.SortChilds = IeeNode_SortChilds;
      function  IeeNode.IsSameNode = IeeNode_IsSameNode;
      function  IeeNode.GetLevelForParent = IeeNode_GetLevelForParent;
      function  IeeNode.Iterate = IeeNode_Iterate;
      function  IeeNode.IterateF = IeeNode_IterateF;
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
  end;//TeeVirtualNode

implementation

uses
  SysUtils,
  
  l3Bits,
  l3InterfacesMisc,
  l3String,

  eeNode,
  eeNodeUtils
  ;

// start class TeeVirtualNode  

procedure TeeVirtualNode.Cleanup;
  //override;
  {-}
begin
 Set_ParentNode(nil);
 inherited;
end;

function TeeVirtualNode.IeeNode_Get_Text: Il3CString;
  {-}
begin
 Result := l3CStr(Self);
end;

procedure TeeVirtualNode.IeeNode_Set_Text(const aValue: Il3CString);
  {-}
begin
 Set_Text(l3PCharLen(aValue));
end;

function TeeVirtualNode.IeeNode_Get_ID: Integer;
  {-}
var
 l_HandleNode : Il3HandleNode;
begin
 if Supports(Self, Il3HandleNode, l_HandleNode) then
  try
   Result := l_HandleNode.Handle;
  finally
   l_HandleNode := nil;
  end//try..finally
 else
  Result := 0;
end;

procedure TeeVirtualNode.IeeNode_Set_ID(aValue: Integer);
  {-}
var
 l_HandleNode : Il3HandleNode;
begin
 if Supports(Self, Il3HandleNode, l_HandleNode) then
  try
   l_HandleNode.Handle := aValue;
  finally
   l_HandleNode := nil;
  end;//try..finally
end;

function TeeVirtualNode.IeeNode_Get_HasChild: Boolean;
  {-}
begin
 Result := HasChild;
end;

function TeeVirtualNode.IeeNode_Get_ChildNode: IeeNode;
  {-}
begin
 Result := TeeNode.Make(ChildNode);
end;

function TeeVirtualNode.IeeNode_Get_ParentNode: IeeNode;
  {-}
begin
 Result := TeeNode.Make(ParentNode);
end;

function TeeVirtualNode.IeeNode_Get_NextNode: IeeNode;
  {-}
begin
 Result := TeeNode.Make(NextNode);
end;

function TeeVirtualNode.IeeNode_Get_PrevNode: IeeNode;
  {-}
begin
 Result := TeeNode.Make(PrevNode);
end;

function TeeVirtualNode.Get_IsFirst: Boolean;
  {-}
begin
 Result := IsFirst;
end;

function TeeVirtualNode.Get_IsLast: Boolean;
  {-}
begin
 Result := IsLast;
end;

function TeeVirtualNode.IeeNode_InsertChild(const aNode: IeeNode): IeeNode;
  //overload;
  {-}
var
 l_Node : Il3Node;
begin
 if Supports(aNode, Il3Node, l_Node) then begin
  Result := aNode;
  InsertChild(l_Node);
 end else
  Result := nil;
end;

function TeeVirtualNode.IeeNode_InsertChildBefore(const aNextChild: IeeNode;
                                                  const aChild: IeeNode): IeeNode;
  //overload;
  {-}
var
 l_Child,
 l_NextChild : Il3Node;
begin
 if Supports(aChild, Il3Node, l_Child) and
    Supports(aNextChild, Il3Node, l_NextChild) then
 begin
  Result := aChild;
  InsertChildBefore(l_NextChild, l_Child);
 end
 else
  Result := nil;
end;

procedure TeeVirtualNode.IeeNode_Changing;
  {-}
begin
 Changing;
end;

procedure TeeVirtualNode.IeeNode_Changed;
  {-}
begin
 Changed;
end;

procedure TeeVirtualNode.IeeNode_Remove;
  {* - удалить узел из дерева. }
begin
 Remove;
end;

procedure TeeVirtualNode.IeeNode_Delete;
  {* - удалить узел из дерева. }
begin
 Delete;
end;

procedure TeeVirtualNode.IeeNode_RemoveChildren;
  {* - освободить дочерние узлы. }
begin
 ReleaseChilds;
end;

function TeeVirtualNode.IeeNode_Move(aDirection : TeeDirection) : Boolean;
  //overload;
  {* - переместить узел. }
begin
 Result := Move(eeDirection2l3Direction(aDirection));
end;

procedure TeeVirtualNode.RelocateChild(const aChild: IeeNode);
  {* - перемещает указанного ребенка, руководствуясь критериями
       сортировки относительно других детей (в пределах одного уровня)}
var
 l_Child : Il3Node;
begin
 if Supports(aChild, Il3Node, l_Child) then
  try
   SortChilds(l_Child);
  finally
   l_Child := nil;
  end;//try..finally
end;

procedure TeeVirtualNode.IeeNode_SortChilds;
  {* - пересортировывает всех детей (один уровень)}
begin
 SortChilds(nil);
end;

function TeeVirtualNode.IeeNode_IsSameNode(const aNode: IeeNode): Boolean;
  {-}
var
 l_Node : Il3Node;
begin
 Result := l3IEQ(Self, aNode);
 if not Result then
 begin
  if Supports(aNode, Il3Node, l_Node) then
   try
    Result := IsSame(l_Node);
   finally
    l_Node := nil;
   end;//try..finally
 end;//not Result
end;

function TeeVirtualNode.IeeNode_GetLevelForParent(const aParent: IeeNode): Integer;
 {* Рассчитывает уровеньтекущей Ноду относительно заданного Paretnt'а }
var
 l_Parent : Il3Node;
begin
 if Supports(aParent, Il3Node, l_Parent) then
  try
   Result := GetLevelForParent(l_Parent);
  finally
   l_Parent := nil;
  end
 else
  Result := -1;
end;

function TeeVirtualNode.IeeNode_Iterate(Action          : TeeNodeAction;
                                        IterMode        : Integer = 0;
                                        const aFromNode : IeeNode = nil) : IeeNode;
 {* - перебрать все дочерние узлы. IterMode см. imExpandOnly etc. }

 function l_CheckNode(const aNode: Il3Node): Boolean;
 begin
  Result := Action(TeeNode.Make(aNode));
 end;

var
 l_FromNode : Il3Node;
begin
 Supports(aFromNode, Il3Node, l_FromNode);
 Result := TeeNode.Make(IterateF(l3L2NA(@l_CheckNode), IterMode, l_FromNode));
end;

function TeeVirtualNode.IeeNode_IterateF(Action          : TeeNodeAction;
                                         IterMode        : Integer = 0;
                                         const aFromNode : IeeNode = nil) : IeeNode;
 {* - перебрать все дочерние узлы и освободить заглушку для Action. }
begin
 try
  Result := IeeNode_Iterate(Action, IterMode, aFromNode);
 finally
  l3FreeFA(Tl3FreeAction(Action));
 end;//try..finally
end;

end.
