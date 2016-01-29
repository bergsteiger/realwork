unit evNodeUpdateGenerator;

{ - Генератор для обновления параграфа, содержащегося в ноде - }

{ $Id: evNodeUpdateGenerator.pas,v 1.12 2015/01/19 18:41:56 lulin Exp $}

// $Log: evNodeUpdateGenerator.pas,v $
// Revision 1.12  2015/01/19 18:41:56  lulin
// {RequestLink:580710025}
//
// Revision 1.11  2014/04/09 14:19:24  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.10  2014/04/08 12:35:09  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.9  2013/10/21 15:42:58  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.8  2013/10/21 10:30:41  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.7  2009/03/04 16:25:52  lulin
// - <K>: 137470629. Bug fix: не собирался Архивариус.
//
// Revision 1.6  2007/12/04 12:47:03  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.4.4.2  2006/02/08 18:18:51  lulin
// - пока безуспешные попытки собрать Archi с Эверестом из ветки.
//
// Revision 1.4.4.1  2005/05/18 12:42:47  lulin
// - отвел новую ветку.
//
// Revision 1.2.2.1  2005/04/28 09:18:29  lulin
// - объединил с веткой B_Tag_Box.
//
// Revision 1.3.2.1  2005/04/25 14:04:57  lulin
// - bug fix: не компилировался Архивариус.
//
// Revision 1.3  2005/04/20 14:19:44  lulin
// - убираем прямое обращение к тегу.
//
// Revision 1.2  2005/04/05 08:36:40  fireton
// - приведение к up to date
//
// Revision 1.1  2005/02/22 13:16:38  fireton
// - первый коммит
//

interface
uses
 SysUtils,
 
 l3Types,
 l3Tree_TLB,

 k2Interfaces,
 k2Tags,
 k2TagGen,

 k2DocumentGenerator
 ;

type

 TevNodeUpdateGenerator = class(Tk2DocumentGenerator)
 private
  f_Node: Il3Node;
 protected
  function AddChild(var aChild: Tk2StackAtom): Long; override;
 public
  constructor Create(const aNode: Il3Node; anOwner: Tk2TagGeneratorOwner = nil);
  procedure Cleanup; override;
 end;

implementation
uses
 k2InternalInterfaces,
 k2Base,

 LeafPara_Const
 ;

constructor TevNodeUpdateGenerator.Create(const aNode: Il3Node; anOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited Create(anOwner);
 f_Node := aNode;
end;

function TevNodeUpdateGenerator.AddChild(var aChild: Tk2StackAtom): Long;
  {-}
var
 l_TC : Ik2TagBoxContainer;

begin
 Result := inherited AddChild(aChild);
 if aChild.IsKindOf(k2_typLeafPara) then
 begin
  if Supports(f_Node, Ik2TagBoxContainer, l_TC) then
  try
   l_TC.SetTag(aChild.Box);
  finally
   l_TC := nil;
  end;
 end;
end;

procedure TevNodeUpdateGenerator.Cleanup;
begin
 f_Node := nil;
 inherited;
end;

end.
