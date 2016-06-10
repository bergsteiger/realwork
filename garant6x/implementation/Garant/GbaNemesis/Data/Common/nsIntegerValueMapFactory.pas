unit nsIntegerValueMapFactory;
{* реализация менеджера мап "строка"-"число" }

{$Include nsDefine.inc }

interface

uses
 l3ProtoObject,
 L10nInterfaces
 ;

type
 TnsIntegerValueMapFactory = class(Tl3ProtoObject, InsIntegerValueMapFactory)
 private
  function MakeMap(const aID: TnsValueMapID): InsValueMap;
 public
  class function Make: InsIntegerValueMapFactory;
 end;

implementation

uses
 SysUtils,
 Dialogs,

 l3Base,
 l3Types,
 l3Interfaces,
 l3Date,

 vtInterfaces,

 vcmUserControls,
 vcmInterfaces,
 vcmMenuManager,

 nevInterfaces,

 nscInterfaces,

 nsValueMapsIDs,
 nsTypedIntegerValueMap,
 nsInternalIntegerValueMap,
 nsIntegerValueMap,
 {$If not (defined(Monitorings) or defined(Admin))}
 nsListSortTypeMap,
 {$IfEnd}
 {$If defined(Admin)}
 nsUserListFilterTypesMap,
 {$IfEnd defined(Admin)}
 nsSettings,
 {$If not (defined(Monitorings) or defined(Admin))}
 ChatTypes,
 {$IfEnd not (defined(Monitorings) or defined(Admin))}

 StdRes,
 SystemStr,
 bsTypes,
 nsTypes,
 nsConst,

 {$If not (defined(Monitorings) or defined(Admin))}
 vtNavigator,
 {$IfEnd not (defined(Monitorings) or defined(Admin))}

 FoldersDomainInterfaces,
 vcmToolbarMenuRes
 {$If not (defined(Monitorings) or defined(Admin))}
 ,
 vcmTabbedContainerRes
 {$IfEnd not (defined(Monitorings) or defined(Admin))}
 ;

{ TnsIntegerValueMapManager }

const
{$If not (defined(Monitorings) or defined(Admin))}
(* map_MainMenu: array [TnsMainMenuType] of PvcmStringId = (
  @str_mmtDefault,
  @str_mmtInherited
 );*)

 map_NavigatorPosition: array [TNavigatorState] of PvcmStringID = (
  @str_li_np_Normal, // nsNormal
  @str_li_np_Minimized, // nsMinimazed
  @str_li_np_AutoHide // nsAutoHide
 );

 map_NavigatorSheetPosition: array [TnsNavigatorFormPositionType] of PvcmStringID = (
  @str_li_nfp_Left, // nfpLeftNavigator
  @str_li_nfp_Right, // nfpRightNavigator
  @str_li_nfp_Float // nfpFloating
 );

 map_AdapterLanguageMap: array [TbsLanguage] of AnsiString = (
  li_il_Russian, // LG_RUSSIAN // Русский
	li_il_English, // LG_ENGLISH // Английский
	li_il_French, // LG_FRENCH // Французский
	li_il_German, // LG_GERMAN // Немецкий
	li_il_Spanish, // LG_SPANISH // Испанский
	li_il_Italian	  // LG_ITALIAN // Итальянский
 );
{$IfEnd not (defined(Monitorings) or defined(Admin))}

{$If not Defined(Admin) AND not Defined(Monitorings) }
 map_FolderFilters : Array [TnsFolderFilter] of PvcmSTringID = (
  @str_ffAllObjects, // fftNone
  @str_ffBookmarks, // fftBookmark
  @str_ffLists, // fftList
  @str_ffQueries, // fftQuery
  //@str_ffFilters, // fftFilter
  @str_ffListAndBookmarks //fftListAndBookMarks
 );
{$IfEnd}

{$If not Defined(Admin) AND not Defined(Monitorings) }
 map_UnderCOntrolSortType : Array [TnsUCSortType] of PvcmSTringID = (
  @str_ucstChanging, // ucstChanging
  @str_ucstAlphabet // ucstAlphabet
 );
{$IfEnd}

 map_pi_List_OrderType : array [TbsSortOrder] of PvcmStringID = (
	@str_SortAscending, // SO_ASCENDING
	@str_SortDescending// SO_DESCENDING
 );

 map_lstCRType : array [TlstCRType] of PvcmStringID = (
  @str_crtCorrespondents, // crtCorrespondents
  @str_crtRespondents, // crtRespondents
  @str_crtNone // crtNone
 );

 map_Interface_Language: array [TbsLanguage] of PvcmStringID = (
  @str_li_il_Russian, // LG_RUSSIAN
  @str_li_il_English, // LG_ENGLISH
  @str_li_il_French, // LG_FRENCH
  @str_li_il_German, // LG_GERMAN
  @str_li_il_Spanish, // LG_SPANISH
  @str_li_il_Italian // LG_ITALIAN
 );

 {$If not Defined(Admin) AND not Defined(Monitorings) }
 map_DocumentAndLinkOpenKind: array [TvcmMainFormOpenKind] of PvcmStringID = (
  @str_pi_InCurrentTab,   // okInCurrentTab
  @str_pi_InNewTab,       // okInNewTab
  @str_pi_InNewWindow     // okInNewWindow
 );
 {$IfEnd}

 map_MainMenuKind: array [TnsMainMenuKind] of AnsiString = (
  li_mmkProfNews,
  li_mmkDefault
 );

class function TnsIntegerValueMapFactory.Make: InsIntegerValueMapFactory;
var
 l_Fac: TnsIntegerValueMapFactory;
begin
 l_Fac := Create;
 try
  Result := l_Fac;
 finally
  FreeAndNil(l_Fac)
 end;
end;

function TnsIntegerValueMapFactory.MakeMap(const aID: TnsValueMapID): InsValueMap;
begin
{$If defined(Admin)}
 // Администратор - TUserListFilterTypes - Типы фильтрации дерева пользователей
 if aID.rID = imap_UserListFilterTypes.rID then
  Result:=TnsUserListFilterTypesMap.Make
 else
{$ElseIf not (defined(Monitorings) or defined(Admin))}
 // Настройки - pi_Document_PermanentSelection - Выделение текста
 if aID.rID = imap_pi_Document_PermanentSelection.rID then
  Result:=TnsIntegerValueMap.Make(imap_pi_Document_PermanentSelection,
   [nsIntegerValueMapRecord(str_li_dpts_Permanent, Ord(True)),
    nsIntegerValueMapRecord(str_li_dpts_Resetable, Ord(False))])
 else
 // Настройки - imap_pi_BaseSearch_BuildShortList - Список после Базового Поиска
 if aID.rID = imap_pi_BaseSearch_BuildShortList.rID then
  Result:=TnsIntegerValueMap.Make(imap_pi_BaseSearch_BuildShortList,
   [nsIntegerValueMapRecord(str_li_bsl_Breaf, Ord(True)),
    nsIntegerValueMapRecord(str_li_bsl_Full, Ord(False))])
 else
 // Настройки - TbsLanguage - язык интерфейса для адаптера
 if aID.rID = imap_IfaceLanguage.rID then
  Result:=TnsInternalTypedIntegerValueMap.Make(imap_IfaceLanguage,
   TypeInfo(TbsLanguage), map_AdapterLanguageMap)
 else
 // Настройки - TNavigatorState - Положение навигатора
 if aID.rID = imap_NavigatorPosition.rID then
  Result:=TnsTypedIntegerValueMap.Make(imap_NavigatorPosition,
   TypeInfo(TNavigatorState), map_NavigatorPosition)
 else
 // Настройки - TnsNavigatorFormPositionType - Положение вкладок в навигатор
 if aID.rID = imap_NavigatorSheetPosition.rID then
  Result:=TnsTypedIntegerValueMap.Make(imap_NavigatorSheetPosition,
   TypeInfo(TnsNavigatorFormPositionType), map_NavigatorSheetPosition)
 else
 // http://mdp.garant.ru/pages/viewpage.action?pageId=434744658
 (* if aID.rID = imap_pi_MainMenuType.rID then
  Result:=TnsTypedIntegerValueMap.Make(imap_pi_MainMenuType,
   TypeInfo(TnsMainMenuType), map_MainMenu)
 else *)
 // Настройки - GblAdapter.TSortType - Положение вкладок в навигатор
 if aID.rID = imap_pi_List_SortType.rID then
  Result:=TnsListSortTypeMap.Make
 else
 // Настройки - TbsSortOrder - Положение вкладок в навигатор
{$IfEnd not (defined(Monitorings) or defined(Admin))}
 if aID.rID = imap_pi_List_OrderType.rID then
  Result:=TnsTypedIntegerValueMap.Make(imap_pi_List_OrderType,
   TypeInfo(TbsSortOrder), map_pi_List_OrderType)
 else
 // Настройки - TlstCRType - Типы корресподентов/респондентов для вкладки документа
 if aID.rID = imap_lstCRType.rID then
  Result:=TnsTypedIntegerValueMap.Make(imap_lstCRType,
   TypeInfo(TlstCRType), map_lstCRType)
 else
 // ??? - TbsLanguage - Язык
 if aID.rID = imap_Interface_Language.rID then
  Result:=TnsTypedIntegerValueMap.Make(imap_Interface_Language,
   TypeInfo(TbsLanguage), map_Interface_Language)
 else
 // Папки - TnsFolderFilter - Фильтры папок
 {$If not Defined(Admin) AND not Defined(Monitorings) }
 if aID.rID = imap_FolderFilters.rID then
  Result:=TnsTypedIntegerValueMap.Make(imap_FolderFilters,
   TypeInfo(TnsFolderFilter), map_FolderFilters)
 else
 {$IfEnd}
 // На контроле - TnsUCSortType - Тип сортировки
 {$If not Defined(Admin) AND not Defined(Monitorings) }
 if aID.rID = imap_UnderCOntrolSortType.rID then
  Result:=TnsTypedIntegerValueMap.Make(imap_UnderCOntrolSortType,
   TypeInfo(TnsUCSortType), map_UnderCOntrolSortType)
 else
 {$IfEnd}
 // Папки - TnsFolderFilter - Фильтры папок
 {$If not Defined(Admin) AND not Defined(Monitorings) }
 if aID.rID = imap_FolderFilters.rID then
  Result:=TnsTypedIntegerValueMap.Make(imap_FolderFilters,
   TypeInfo(TnsFolderFilter), map_FolderFilters)
 else
 {$IfEnd}
 // Настрйоки - TvcmMainFormOpenKind - поведение при открытии документов и ссылок
 {$If not Defined(Admin) AND not Defined(Monitorings) }
 if aID.rID = imap_DocumentAndLinkOpenKind.rID then
  Result:=TnsTypedIntegerValueMap.Make(imap_DocumentAndLinkOpenKind,
   TypeInfo(TvcmMainFormOpenKind), map_DocumentAndLinkOpenKind)
 else
 {$IfEnd}
 if aID.rID = imap_MainMenuKind.rID then
  Result := TnsInternalTypedIntegerValueMap.Make(imap_MainMenuKind,
   TypeInfo(TnsMainMenuKind), map_MainMenuKind)
 else
  Result := nil;
end;

end.

