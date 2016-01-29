unit l3ComponentInfoHelper;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Interfaces
 , Windows
 , Controls
 , Menus
 , Classes
 , l3Core
;

type
 TRTTIInfoType = (
  itHierarchyOnly
  , itDetailed
 );//TRTTIInfoType
 
 Tl3ComponentInfoHelper = class(Tl3ProtoObject, Il3GetMessageListener)
  {* Отображаем RTTI-информацию о компонентах.
Alt+Ctrl+Shift+LClick - подробная информация;
Alt+Ctrl+Shift+RClick - краткая информация вместе с иерархией вложенности;
Alt+Ctrl+Shift+C - контрол, захвативший ввод;
Alt+Ctrl+Shift+A - контрол в фокусе. }
  procedure ObjectPropFound(anObject: TObject;
   var aValue: AnsiString);
  procedure OnJumpToObjectProp(const aLinkData: AnsiString);
  procedure ShowRTTIMessageForObject(anObject: TObject;
   aInfoType: TRTTIInfoType;
   aBindedControl: TControl);
  function FormatMenuInfo(aMenu: TMenuItem;
   const aCaption: AnsiString): AnsiString;
  procedure PopupMenuCallback(aMenu: TMenuItem);
  function FormatMenuInfoForControl(aControl: TControl): AnsiString;
  procedure FormatObjectInfo(anObject: TObject;
   anInfoType: TRTTIInfoType;
   out aResult: AnsiString);
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  procedure GetMessageListenerNotify(Code: Integer;
   aWParam: WPARAM;
   Msg: PMsg;
   var theResult: Tl3HookProcResult);
 end;//Tl3ComponentInfoHelper
 
implementation

uses
 l3ImplUses
 , l3ListenersManager
 , Messages
 , Forms
 , TypInfo
 , ActnList
 , StrUtils
 , SysUtils
 , l3PopupMenuHelper
 , l3FormatActionInfoHelper
 , l3HugeMessageDlgWithWikiHelper
 , l3GetComponentFromPointHelper
 , l3FormatObjectInfoHelper
 , l3IterateComponentParents
;

type
 TControlFriend = class(TControl)
  {* Друг для TControl }
 end;//TControlFriend
 
end.
