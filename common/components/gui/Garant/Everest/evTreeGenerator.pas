unit evTreeGenerator;

{ $Id: evTreeGenerator.pas,v 1.17 2015/01/19 18:41:57 lulin Exp $}

// $Log: evTreeGenerator.pas,v $
// Revision 1.17  2015/01/19 18:41:57  lulin
// {RequestLink:580710025}
//
// Revision 1.16  2014/04/09 14:19:24  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.15  2014/04/07 17:56:59  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.14  2013/10/21 15:42:58  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.13  2013/10/21 10:30:41  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.12  2009/03/04 16:25:52  lulin
// - <K>: 137470629. Bug fix: не собирался Архивариус.
//
// Revision 1.11  2008/06/17 21:26:58  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.10  2007/12/04 12:47:06  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.7.4.3  2007/11/28 13:35:07  dinishev
// Не компилировалось
//
// Revision 1.7.4.2  2006/02/08 18:18:51  lulin
// - пока безуспешные попытки собрать Archi с Эверестом из ветки.
//
// Revision 1.7.4.1  2005/05/18 12:42:48  lulin
// - отвел новую ветку.
//
// Revision 1.4.2.2  2005/05/18 12:32:10  lulin
// - очередной раз объединил ветку с HEAD.
//
// Revision 1.4.2.1  2005/04/28 09:18:30  lulin
// - объединил с веткой B_Tag_Box.
//
// Revision 1.5.2.2  2005/04/26 09:34:52  lulin
// - bug fix: в параграфах оставалась ссылка на умерший документ.
//
// Revision 1.5.2.1  2005/04/25 14:04:57  lulin
// - bug fix: не компилировался Архивариус.
//
// Revision 1.5  2005/04/20 14:19:44  lulin
// - убираем прямое обращение к тегу.
//
// Revision 1.4  2005/04/05 08:36:40  fireton
// - приведение к up to date
//
// Revision 1.3  2005/03/03 14:27:57  fireton
// - change: добавлены параметры - идентификатор тэга для отступа и "нулевой" уровень
//
// Revision 1.2  2005/02/18 11:00:31  fireton
// - исправления и дополнения
//
// Revision 1.1  2005/02/16 15:02:26  fireton
// - первый коммит
//

interface

uses
 SysUtils,
 l3Types,
 l3Tree_TLB,
 l3Nodes,
 l3InternalInterfaces,
 l3Units,
 k2TagGen,
 k2InternalInterfaces,
 k2DocumentGenerator,
 evParaDrawNode
 ;

type

 EevBadEvdTreeFormat = class (Exception)
 end;

 TevTreeGenerator = class(Tk2DocumentGenerator)
 private
  f_LevelIndent: Integer; // отступ в случае, если используется k2_tiFirstIndent
  f_Root: Il3Node;
  f_CurParentNode: Il3Node;
  f_CurLevel: Integer;
  f_LevelTag: Integer;
  f_ZeroLevel: Integer;
 protected
  function AddChild(var aChild: Tk2StackAtom): Long; override;
        {-}
  procedure OpenStream; override;
        {-}
 procedure CloseStream(NeedUndo: Bool); override;
        {-}
 public
  constructor Create(aRoot: Il3Node; anLevelTag: Integer; anOwner: Tk2TagGeneratorOwner = nil);
  procedure Cleanup; override;
  property LevelIndent: Integer read f_LevelIndent write f_LevelIndent;
  property Root: Il3Node read f_Root;
  property ZeroLevel: Integer read f_ZeroLevel write f_ZeroLevel;
 end;

implementation

uses
 Graphics,

 l3Defaults,
 
 k2Base,
 k2Tags,
 evConst,
 evDef,
 evParaTools,
 evParaDrawTools,

 LeafPara_Const
 ;

resourcestring
 SBadEvdTreeFormat = 'Неправильный формат evd-дерева';

constructor TevTreeGenerator.Create(aRoot: Il3Node; anLevelTag: Integer; anOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited Create(anOwner);
 f_Root := aRoot;
 f_LevelTag := anLevelTag;
 f_LevelIndent := 2;
 f_ZeroLevel := 0;
end;

function TevTreeGenerator.AddChild(var aChild: Tk2StackAtom): Long;
  {-}
var
 l_LevelValueMultiplier: Integer;
 l_Level: Integer;
 //l_Noe: Il3Node;
const
 cIndentUnit = def_FirstIndent div 2;
begin
 if aChild.IsKindOf(k2_typLeafPara) then
 begin
  with aChild.Box.Attr[f_LevelTag] do
  begin
   if f_LevelTag = k2_tiFirstIndent then
    l_LevelValueMultiplier := (f_LevelIndent*cIndentUnit)
   else
    l_LevelValueMultiplier := 1;
   if IsValid then
    l_Level := (AsLong div l_LevelValueMultiplier) - f_ZeroLevel
   else
    l_Level := 0;
  end;
  if (l_Level >= 0) then
  begin
   aChild.Box.IntA[f_LevelTag] := 0;
   // ищем ноду, которая станет родителем новой
   while (l_Level <> f_CurLevel)  do
   begin
    if l_Level < f_CurLevel then
    begin
     f_CurParentNode := f_CurParentNode.ParentNode;
     if f_CurParentNode = nil then
      raise EevBadEvdTreeFormat.Create(SBadEvdTreeFormat);
     Dec(f_CurLevel);
    end
    else
    begin
     f_CurParentNode := f_CurParentNode.ChildNode;
     if f_CurParentNode = nil then
      raise EevBadEvdTreeFormat.Create(SBadEvdTreeFormat);
     Inc(f_CurLevel);
     f_CurParentNode := f_CurParentNode.PrevNode; // берем последнего ребенка в списке
    end;
   end;
   f_CurParentNode.InsertChild(TevParaDrawNode.Make(aChild.Box));
   Result := -1;
   Exit;
  end;//l_Level >= 0
 end;
 Result := inherited AddChild(aChild);
end;

procedure TevTreeGenerator.Cleanup;
begin
 f_Root := nil;
 f_CurParentNode := nil;
 inherited;
end;

procedure TevTreeGenerator.CloseStream(NeedUndo: Bool);
begin
 inherited;
 Root.Changed;
end;

procedure TevTreeGenerator.OpenStream;
begin
 Root.Changing;
 f_CurParentNode := f_Root;
 f_CurLevel := 0;
 inherited;
end;

end.
