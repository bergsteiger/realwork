unit nscNewInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Nemesis"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Nemesis/nscNewInterfaces.pas"
// Начат: 29.10.2008 13:20
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi For F1::Nemesis::nscNewInterfaces
//
// Интерфейсы компонентов проекта "Немезис"
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Nemesis\nscDefine.inc}

interface

{$If defined(Nemesis)}
uses
  l3Interfaces
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  ;

type
 InscContextFilterState = interface(IUnknown)
  {* Состояние контекстного фильтра }
   ['{4FEA5B19-4FA8-4681-86A8-7712B950A926}']
   function pm_GetActive: Boolean;
   function pm_GetContext: Il3CString;
   function pm_GetActiveContext: Il3CString;
   function pm_GetCaretPos: Integer;
   function NeedRefilterTree: Boolean;
   property Active: Boolean
     read pm_GetActive;
   property Context: Il3CString
     read pm_GetContext;
   property ActiveContext: Il3CString
     read pm_GetActiveContext;
   property CaretPos: Integer
     read pm_GetCaretPos;
 end;//InscContextFilterState

 InscContextFilterListener = interface(IUnknown)
  {* Слушатель событий контекстного фильтра }
   ['{BF8E1FFC-F292-46FE-80CA-64806B40588B}']
   procedure ContextCanBeChanged(aHandle: Integer;
    const aFilterName: Il3CString;
    const aState: InscContextFilterState);
     {* событие возможной смены контекста. Генерируется при уходе фокуса из
             поля ввода и уничтожении компонента }
   procedure FilterRemoving(aHandle: Integer);
 end;//InscContextFilterListener

 InscPageControlNotification = interface(IUnknown)
  {* Для уведомления о событиях компонента с вкладками }
   ['{2E50A778-1920-4AB5-8647-2FA1426CCCAD}']
   procedure TabActivate;
     {* Cобытие активации вкладки }
 end;//InscPageControlNotification

 TnscToolTipKind = (
   nsc_ttkNone
 , nsc_ttkInformation
 , nsc_ttkWarning
 , nsc_ttkError
 );//TnscToolTipKind

 InscStatusBarItemDefsList = interface;
 { - предварительное описание InscStatusBarItemDefsList. }

 InscStatusBarItemDef = interface(IUnknown)
   ['{F1A38933-0087-4D5E-ABE9-F1D39315F958}']
   procedure SubscribeOnNotification(const aServer: InscStatusBarItemDef);
   function Get_Caption: Il3CString;
   function Get_UseToolTip: Boolean;
   function Get_RequireAutoPopup: Boolean;
   function Get_AutoPopupTimeout: Cardinal;
   function Get_TootTipKind: TnscToolTipKind;
   function Get_ShowCaption: Boolean;
   function Get_Enabled: Boolean;
   procedure Set_Enabled(aValue: Boolean);
   function Get_SubscribedList: InscStatusBarItemDefsList;
   property Caption: Il3CString
     read Get_Caption;
   property UseToolTip: Boolean
     read Get_UseToolTip;
   property RequireAutoPopup: Boolean
     read Get_RequireAutoPopup;
   property AutoPopupTimeout: Cardinal
     read Get_AutoPopupTimeout;
   property TootTipKind: TnscToolTipKind
     read Get_TootTipKind;
   property ShowCaption: Boolean
     read Get_ShowCaption;
   property Enabled: Boolean
     read Get_Enabled
     write Set_Enabled;
   property SubscribedList: InscStatusBarItemDefsList
     read Get_SubscribedList;
 end;//InscStatusBarItemDef

 InscStatusBarItemDefsList = interface(IUnknown)
   ['{A7A6F65A-CECA-46D4-A878-F1330AF47317}']
   function pm_GetCount: Integer;
   function pm_GetItems(anIndex: Integer): InscStatusBarItemDef;
   procedure Add(const aDef: InscStatusBarItemDef);
   property Count: Integer
     read pm_GetCount;
   property Items[anIndex: Integer]: InscStatusBarItemDef
     read pm_GetItems;
 end;//InscStatusBarItemDefsList

 InscStatusBarItemsProvider = interface(IUnknown)
   ['{FC82FD20-A8E7-406B-9BCA-1D42AEE15833}']
   function Get_Items: InscStatusBarItemDefsList;
   property Items: InscStatusBarItemDefsList
     read Get_Items;
 end;//InscStatusBarItemsProvider

 InscStatusBarItemsVisualizer = interface(IUnknown)
   ['{AB7E2AE6-1CC8-4CC0-B297-E7834151CAB9}']
   procedure RegisterProvider(const aProvider: InscStatusBarItemsProvider);
   procedure UnregisterProvider(const aProvider: InscStatusBarItemsProvider);
 end;//InscStatusBarItemsVisualizer

{$If defined(Nemesis) AND not defined(NoVCM)}
 InscStatusBarOperationDef = interface(InscStatusBarItemDef)
   ['{30B59FB0-01BE-4CA3-930C-70209C211197}']
   function Get_Operation: TvcmOpSelector;
   property Operation: TvcmOpSelector
     read Get_Operation;
 end;//InscStatusBarOperationDef
{$IfEnd} //Nemesis AND not NoVCM

  TsbdSeparatorPos = (
    spLeft
  , spMiddle
  , spRight
  );//TsbdSeparatorPos

 InscStatusBarDelimiterDef = interface(InscStatusBarItemDef)
   ['{7600F2A4-90B6-4661-AFDF-3E6EFC638004}']
   function Get_SeparatorPos: TsbdSeparatorPos;
   function Get_IsSeparatorVisible: Boolean;
   function Get_Width: integer;
   property SeparatorPos: TsbdSeparatorPos
     read Get_SeparatorPos;
   property IsSeparatorVisible: Boolean
     read Get_IsSeparatorVisible;
   property Width: integer
     read Get_Width;
 end;//InscStatusBarDelimiterDef

 InscBaseSearchPromptNode = interface(IUnknown)
   ['{6B2CAEE8-1173-4C45-9204-0F32EF856714}']
   function OpenDocument: Boolean;
   function IsLinkOnDocument: Boolean;
 end;//InscBaseSearchPromptNode
{$IfEnd} //Nemesis

implementation

end.