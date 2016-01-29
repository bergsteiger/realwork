unit nsCRTypeStringValueMap;
{* реализаци€ мапы "строка"-"строка" }

// $Log: nsCRTypeStringValueMap.pas,v $
// Revision 1.34  2015/11/06 12:42:28  kostitsin
// опечатка
//
// Revision 1.33  2012/01/19 09:26:40  gensnet
// http://mdp.garant.ru/pages/viewpage.action?pageId=281515328
//
// Revision 1.32  2011/09/05 12:19:05  lulin
// {RequestLink:281511037}.
//
// Revision 1.31  2011/06/07 14:13:07  lulin
// - не падаем, если не нашлась нода из настроек.
//
// Revision 1.30  2011/06/07 11:09:28  lulin
// {RequestLink:268345098}.
// - вычищаем хвосты.
//
// Revision 1.29  2011/06/07 10:08:14  lulin
// {RequestLink:268345098}.
//
// Revision 1.28  2011/06/07 08:29:54  lulin
// {RequestLink:268345098}.
// - избавл€емс€ от дублировани€ кода.
//
// Revision 1.27  2009/12/04 11:53:01  lulin
// - перенесли на модель и добились собираемости.
//
// Revision 1.26  2009/05/15 07:49:25  oman
// - new: „иним настройки конфигурации - [$125404858]
//
// Revision 1.25  2009/05/14 12:48:25  oman
// - new: √отовим потроха - [$125404858]
//
// Revision 1.24  2009/05/12 13:31:18  oman
// - new: «аготовки - [$125404858]
//
// Revision 1.23  2009/02/20 12:25:12  lulin
// - <K>: 136941122.
//
// Revision 1.22  2009/02/10 15:43:25  lulin
// - <K>: 133891247. ¬ыдел€ем интерфейсы локализации.
//
// Revision 1.21  2008/12/25 12:19:26  lulin
// - <K>: 121153186.
//
// Revision 1.20  2008/12/24 19:49:11  lulin
// - <K>: 121153186.
//
// Revision 1.19  2008/12/04 14:58:38  lulin
// - <K>: 121153186.
//
// Revision 1.18  2008/06/20 06:19:07  oman
// - new: √отовимс€ к второму представлению мапы — – (cq29294)
//
// Revision 1.17  2008/03/11 11:25:26  oman
// - fix: ѕытаемс€ жить на кривых базах (cq28563)
//
// Revision 1.16  2008/01/15 19:10:16  lulin
// - подготавливаемс€ к генерации с модели.
//
// Revision 1.15  2008/01/10 07:23:10  oman
// ѕереход на новый адаптер
//
// Revision 1.14.4.1  2007/11/23 10:15:20  oman
// ѕерепиливаем на новый адаптер
//
// Revision 1.14  2007/04/05 10:49:22  lulin
// - повторное использование кода.
//
// Revision 1.13  2007/04/05 10:22:27  lulin
// - избавл€емс€ от лишних преобразований строк.
//
// Revision 1.12  2007/03/01 13:08:36  lulin
// - используем модификаторы константности и отложенно грузим ресурсные строки.
//
// Revision 1.11  2007/02/12 16:38:55  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.10  2007/02/10 13:25:52  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.9  2007/02/07 19:36:07  lulin
// - переводим мапы на строки с кодировкой.
//
// Revision 1.8  2007/02/07 19:13:27  lulin
// - переводим мапы на строки с кодировкой.
//
// Revision 1.7  2007/02/07 17:48:27  lulin
// - избавл€емс€ от копировани€ строк при чтении из настроек.
//
// Revision 1.6  2007/02/06 07:52:41  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.5  2006/12/29 10:27:04  lulin
// - добавлена еще одна верси€ добавлени€ строки в список.
//
// Revision 1.4  2006/12/22 15:48:48  lulin
// - добавлены модификаторы константности.
//
// Revision 1.3  2006/12/22 15:06:18  lulin
// - текст ноды - теперь структура с длиной и кодовой страницей.
//
// Revision 1.2  2006/11/03 09:45:25  oman
// Merge with B_NEMESIS_6_4_0
//
// Revision 1.1.2.2  2006/10/31 16:18:59  oman
// - fix: — – переведены со строк на типы (cq23213)
//
// Revision 1.1.2.1  2006/10/25 07:54:48  oman
// √отовимс€ к завершению локализации настроек — –
//
// Revision 1.1  2006/10/10 13:18:45  oman
// - fix: ћапа дл€ типов — –. ѕока полужива€ - не выделено пон€тие
//  "¬се документы" и нет четкой типизации, потом надо будет докрутить
//   (cq22964)
//

{$Include nsDefine.inc }

interface

uses
  Classes,

  l3Interfaces,
  l3BaseWithID,
  l3ValueMap,
  l3Types,
  l3Tree_TLB,
  l3TreeInterfaces,

  vcmExternalInterfaces,
  vcmInterfaces,
  afwInterfaces,
  L10nInterfaces,

  bsTypes,
  bsInterfaces
  ;

type
 _afwApplicationDataUpdate_Parent_ = Tl3ValueMap;
 {$Include afwApplicationDataUpdate.imp.pas}
 TnsCRTypeStringValueMap = class(_afwApplicationDataUpdate_,
                                 InsStringValueMap,
                                 InsStringsSource,
                                 IbsCRSettingsConverter)
 private
  // Il3IntegerValueMap
  function DisplayNameToValue(const aDisplayName: Il3CString): Il3CString;
  function ValueToDisplayName(const aValue: Il3CString): Il3CString;
  // InsStringsSource
  procedure FillStrings(const aStrings: IvcmStrings);
  // IbsCRSettingsConverter
  function GetCRNodeByValue(const aValue: Il3CString): IbsFrozenNode;
 private
  //f_SettingsMap: InsIntegerValueMap;
  //f_UserMap: InsIntegerValueMap;
  //f_UseSpecialValue: Boolean;
  f_Tree: Il3SimpleTree;
 private
(*  function FindAdapterNodeByText(const aValue: Il3CString): Il3SimpleNode;*)
(*  function FindAdapterNodeByType(const aType: TbsPrefixItemType): Il3SimpleNode;*)
 protected
  procedure CheckTree;
  procedure DoGetDisplayNames(const aList: Il3StringsEx);
   override;
  function GetMapSize: Integer;
   override;
  procedure Cleanup;
   override;
  procedure FinishDataUpdate;
   override;
 public
  constructor Create(const aID: TnsValueMapID{; aUIMapID: TnsValueMapID;
   NeedUseSpecialValue: Boolean});
   reintroduce;
  class function Make(const aID: TnsValueMapID{; aUIMapID: TnsValueMapID;
   NeedUseSpecialValue: Boolean}): InsStringValueMap;
 end;//TnsCRTypeStringValueMap

implementation

uses
  SysUtils,

  l3Base,
  l3String,
  l3Nodes,

  vcmBase,
  afwFacade,  

  bsFrozenNode,
  bsUtils,

  BaseTypesUnit,
  DynamicTreeUnit,

  DataAdapter,

  nsValueMapsIDs,
  nsValueMaps,
  nsTreeStruct
  ;

{$Include afwApplicationDataUpdate.imp.pas}

{ TnsStringValueMap }

(*const
 c_SpecialValue = PIT_USER_TYPE;*)

procedure TnsCRTypeStringValueMap.FinishDataUpdate;
begin
 inherited;
 f_Tree := nil;
end;

procedure TnsCRTypeStringValueMap.Cleanup;
begin
 //f_SettingsMap := nil;
 //f_UserMap := nil;
 f_Tree := nil;
 inherited;
end;

constructor TnsCRTypeStringValueMap.Create(const aID: TnsValueMapID{; aUIMapID: TnsValueMapID;
 NeedUseSpecialValue: Boolean});
begin
 inherited Create(aID);
 //f_SettingsMap := nsIntegerMapManager.Map[imap_SettingsCRTypes];
 //f_UserMap := nsIntegerMapManager.Map[aUIMapID];
 //f_UseSpecialValue := NeedUseSpecialValue;
end;

function TnsCRTypeStringValueMap.DisplayNameToValue(const aDisplayName: Il3CString): Il3CString;
  {-}
(*var
 l_Node: Il3SimpleNode;
 l_Type: TbsPrefixItemType;*)
begin
 Result := aDisplayName;
(* if f_UseSpecialValue and DefDataAdapter.UseUserATPrefix and l3Same(DefDataAdapter.UserATPrefixName, aDisplayName) then
  l_Type := c_SpecialValue
 else
 begin
  l_Node := FindAdapterNodeByText(aDisplayName);
  if (l_Node <> nil) then
  begin
   l_Type := bsGetCRType(l_Node);
   if l_Type = PIT_UNDEFINED then
    l_Type := TbsPrefixItemType(f_UserMap.DisplayNameToValue(aDisplayName))
  end//l_Node <> nil
  else
   l_Type := TbsPrefixItemType(f_UserMap.DisplayNameToValue(aDisplayName));
 end;
 Result := f_SettingsMap.ValueToDisplayName(Ord(l_Type));*)
end;

procedure TnsCRTypeStringValueMap.FillStrings(const aStrings: IvcmStrings);
begin
 DoGetDisplayNames(aStrings);
end;

(*function TnsCRTypeStringValueMap.FindAdapterNodeByType(
  const aType: TbsPrefixItemType): Il3SimpleNode;

 function FindType(const anIntf: Il3Node) : Boolean;
 begin
  Result := bsGetCRType(anIntf) = aType;
 end;

var
 l_Root: Il3Node;
begin
 l_Root := defDataAdapter.CRSimpleListTypeRootNode;
 if Assigned(l_Root) then
  Result := defDataAdapter.CRSimpleListTypeRootNode.IterateF(l3L2NA(@FindType), imOneLevel or imCheckResult)
 else
  Result := nil;
end;*)

(*function TnsCRTypeStringValueMap.FindAdapterNodeByText(const aValue: Il3CString): Il3SimpleNode;
  {-}
begin
 Result := l3SearchByName(defDataAdapter.CRSimpleListTypeRootNode, aValue, imOneLevel);
end;*)

const
 cSep = '\';

function TnsCRTypeStringValueMap.GetCRNodeByValue(const aValue: Il3CString): IbsFrozenNode;
(*var
 l_AdapterNode: INodeBase;*)
var
 l_Path : Tl3WString;
 l_N    : Il3SimpleNode;
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 CheckTree;
 l_Path := aValue.AsWStr;
 l_N := l3GetSPartPath(f_Tree, l_Path, cSep);
(* if (l_N = nil) then
 // http://mdp.garant.ru/pages/viewpage.action?pageId=281511037
 begin
  Assert(f_Tree.RootNode = nil);
  Result := nil;
  Exit;
 end;//l_N = nil*)
 Assert(l_N <> nil);
 if (l_N.Parent = nil) then
 // - заточка дл€ отсутствующей настройки
 //   возвращаем "¬се документы".
 begin
  Result := TbsCRTypeFrozen.Make(l_N.Child As INodeBase);
  Exit;
 end;//l_N.Parent = nil
 Result := TbsCRTypeFrozen.Make(l_N As INodeBase);
 Assert(l3IsNil(l_Path));
 Assert(l3Ends(l_N.Text, aValue.AsWStr));
(* if Supports(FindAdapterNodeByType(TbsPrefixItemType(f_SettingsMap.DisplayNameToValue(aValue))),
    INodeBase, l_AdapterNode) then
  Result := TbsCRTypeFrozen.Make(l_AdapterNode)
 else
  Result := nil;*)
 {$Else}
 Result := nil;
 Assert(false);
 {$IfEnd}
end;

procedure TnsCRTypeStringValueMap.CheckTree;
begin
 if (f_Tree = nil) then
  f_Tree := TnsTreeStruct.Make(defDataAdapter.CRSimpleListTypeRootNode As INodeBase,
                               false);
end;

procedure TnsCRTypeStringValueMap.DoGetDisplayNames(const aList: Il3StringsEx);

 function DoNode(const aIntf : Il3SimpleNode) : Boolean;
 var
  l_S : Il3CString;
  l_N : Il3SimpleNode;
  l_Sep : Il3CString;
 begin//DoNode
  Result := false;
  l_N := aIntf;
  l_S := l3CStr(l_N.Text);
  l_Sep := l3CStr(cSep);
  while true do
  begin
   l_N := l_N.Parent;
   if (l_N = nil) then
    // - вр€д ли такое может быть, но проверить - не помешает
    break;
   if (l_N.Parent = nil) then
    // - выкидываем корень
    break;
   l_S := l3Cat([l3CStr(l_N.Text), l_Sep, l_S]);
  end;//while true
  aList.Add(l_S);
 end;//DoNode

(*var
 l_Idx: TbsPrefixItemType;
 l_Node: Il3SimpleNode;*)
begin
 CheckTree;
 aList.Clear;
 f_Tree.SimpleIterateF(l3L2SNA(@DoNode));
(* for l_Idx := Low(TbsPrefixItemType) to High(TbsPrefixItemType) do
  if (l_Idx <> PIT_UNDEFINED) and ((l_IDX <> c_SpecialValue) or (f_UseSpecialValue and DefDataAdapter.UseUserATPrefix)) then
  begin
   if (l_Idx = c_SpecialValue) then
    aList.Add(DefDataAdapter.UserATPrefixName)
   else
   begin
    l_Node := FindAdapterNodeByType(l_Idx);
    if Assigned(l_Node) then
     aList.Add(l_Node.Text)
    else
     aList.Add(f_UserMap.ValueToDisplayName(Ord(l_Idx)));
   end;
  end;//l_Idx <> PIT_UNDEFINED*)
end;

class function TnsCRTypeStringValueMap.Make(
  const aID: TnsValueMapID{; aUIMapID: TnsValueMapID;
   NeedUseSpecialValue: Boolean}): InsStringValueMap;
var
 l_Map: TnsCRTypeStringValueMap;
begin
 l_Map := Create(aID{, aUIMapID, NeedUseSpecialValue});
 try
  Result := l_Map;
 finally
  vcmFree(l_Map);
 end;
end;

function TnsCRTypeStringValueMap.GetMapSize: Integer;
begin
 Result := 0;
 Assert(false);
 // - если сюда попадЄм, то надо будет вернуть количество нод в дереве
(* Result := f_UserMap.MapSize - 1;
 if not (f_UseSpecialValue and DefDataAdapter.UseUserATPrefix) then
  Dec(Result);*)
end;

function TnsCRTypeStringValueMap.ValueToDisplayName(const aValue: Il3CString): Il3CString;
(*var
 l_Type: TbsPrefixItemType;
 l_Node: Il3SimpleNode;*)
begin
 Result := aValue;
(* l_Type := TbsPrefixItemType(f_SettingsMap.DisplayNameToValue(aValue));
 if f_UseSpecialValue and DefDataAdapter.UseUserATPrefix and (l_Type = c_SpecialValue) then
  Result := DefDataAdapter.UserATPrefixName
 else
 begin
  l_Node := FindAdapterNodeByType(l_Type);
  if Assigned(l_Node) then
   Result := l3CStr(l_Node.Text)
  else
   Result := f_UserMap.ValueToDisplayName(Ord(l_Type));
 end;*)
end;

end.

