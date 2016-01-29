unit vcmUserControls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/vcmUserControls.pas"
// Начат: 20.02.2009 16:07
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::VCM::vcmUserControls
//
// Управляющие элементы, взаимодействующие с пользователем
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmExternalInterfaces,
  Classes
  {$If not defined(NoVCL)}
  ,
  ActnList
  {$IfEnd} //not NoVCL
  
  ;

type
 IvcmBaseObjectDef = interface(IvcmBase)
   ['{C2874075-FAA7-4C00-B3BE-F6FD56ED5433}']
   function Get_Caption: IvcmCString;
   function Get_Name: TvcmString;
   property Caption: IvcmCString
     read Get_Caption;
     {* пользовательское имя объекта }
   property Name: TvcmString
     read Get_Name;
     {* имя объекта }
 end;//IvcmBaseObjectDef

 IvcmUserFriendlyControl = interface(IvcmBaseObjectDef)
  {* Базовый интерфейс для объектов имеющих отображение для пользователя }
   ['{F12A7495-DA83-4EEE-A5C1-77957F72E98A}']
   function Get_ImageIndex: Integer;
   function Get_Hint: IvcmCString;
   function Get_LongHint: IvcmCString;
   property ImageIndex: Integer
     read Get_ImageIndex;
   property Hint: IvcmCString
     read Get_Hint;
     {* подсказка для пункта меню, представляющего объект }
   property LongHint: IvcmCString
     read Get_LongHint;
     {* детальная подсказка для пункта меню, представляющего объект }
 end;//IvcmUserFriendlyControl

 IvcmIdentifiedUserFriendlyControl = interface(IvcmUserFriendlyControl)
  {* Базовый интерфейс для объектов имеющих отображение для пользователя и идентификатор }
   ['{218D3AE5-6CA7-4CF3-B27B-B277C74C4165}']
   function Get_ID: TvcmControlID;
   property ID: TvcmControlID
     read Get_ID;
     {* идентификатор объекта }
 end;//IvcmIdentifiedUserFriendlyControl

  TvcmOperationOption = (
   {* Режим отбражения операции в меню и на панели инструментов. }
    vcm_ooShowInMainToolbar // Операция будет показана на панели                                   инструментов главной формы
  , vcm_ooShowInChildToolbar // Операция будет показана на панели                                   инструментов формы сущности
  , vcm_ooShowInContextMenu // Операция будет показана в контекстном меню
  , vcm_ooShowInMainMenu // Операция будет показана в главном меню                                   главной формы.
  , vcm_ooShowInChildMenu // Операция будет показана в меню формы                                   сущности
  );//TvcmOperationOption

  TvcmOperationMode = (
   {* Режим выполнения операции. }
    vcm_omTest // Режим проверки доступности операции
  , vcm_omExecute // Режим непосредственного выполенения                       операции
  , vcm_omAggregateExecute
  );//TvcmOperationMode

  TvcmOperationCallType = (
    vcm_octShortCut
  , vcm_octMainMenu
  , vcm_octContextMenu
  , vcm_octToolbar
  );//TvcmOperationCallType

  TvcmUserType = 0..31;
   {* Тип формы. }

  TvcmUserTypes = set of TvcmUserType;

  TvcmOperationOptions = set of TvcmOperationOption;

 IvcmOperationDef = interface(IvcmIdentifiedUserFriendlyControl)
  {* Описание операции }
   ['{1563410C-852B-4365-A993-8A50640BADA1}']
   function Get_VisibleToUser: Boolean;
   function Get_IsCaptionUnique: Boolean;
   function Get_StatesCount: Integer;
   function Get_IsDefault: Boolean;
   function Get_GroupID: Integer;
   function Get_Category: TvcmString;
   function Get_OperationType: TvcmOperationType;
   function Get_ShortCut: TShortCut;
   function Get_SecondaryShortCuts: TShortCutList;
   function Get_ExcludeUserTypes: TvcmUserTypes;
   function Get_State(anIndex: Integer): IvcmUserFriendlyControl;
   function Get_ContextMenuWeight: Integer;
   function Get_Options: TvcmOperationOptions;
   property VisibleToUser: Boolean
     read Get_VisibleToUser;
   property IsCaptionUnique: Boolean
     read Get_IsCaptionUnique;
     {* определяет является ли имя операции уникальным в пределах всех
             операций формы }
   property StatesCount: Integer
     read Get_StatesCount;
   property IsDefault: Boolean
     read Get_IsDefault;
   property GroupID: Integer
     read Get_GroupID;
     {* группа внутри категории }
   property Category: TvcmString
     read Get_Category;
     {* категория объекта }
   property OperationType: TvcmOperationType
     read Get_OperationType;
   property ShortCut: TShortCut
     read Get_ShortCut;
   property SecondaryShortCuts: TShortCutList
     read Get_SecondaryShortCuts;
   property ExcludeUserTypes: TvcmUserTypes
     read Get_ExcludeUserTypes;
   property State[anIndex: Integer]: IvcmUserFriendlyControl
     read Get_State;
   property ContextMenuWeight: Integer
     read Get_ContextMenuWeight;
   property Options: TvcmOperationOptions
     read Get_Options;
 end;//IvcmOperationDef

  TvcmToolBarPos = (
    vcm_tbpTop
  , vcm_tbpBottom
  , vcm_tbpLeft
  , vcm_tbpRight
  , vcm_tbpNone
  );//TvcmToolBarPos

  TvcmToolBarPoses = set of TvcmToolBarPos;

  TvcmEffectiveToolBarPos = Low(TvcmToolBarPos)..Pred(High(TvcmToolBarPos));

  TvcmEffectiveToolBarPoses = set of TvcmEffectiveToolBarPos;

 IvcmOperationsDefIterator = interface(IUnknown)
  {* Итератор описаний операций }
   ['{3B8CFB31-F1BF-469A-A248-1C613BA636C9}']
   function Get_Next: IvcmOperationDef;
   property Next: IvcmOperationDef
     read Get_Next;
     {* следующий описатель операции }
 end;//IvcmOperationsDefIterator

 IvcmOperationalIdentifiedUserFriendlyControl = interface(IvcmIdentifiedUserFriendlyControl)
  {* Базовый интерфейс для объектов имеющих отображение для пользователя и операции }
   ['{0F52E633-4306-4D75-93D1-5F259A9B3D45}']
   function Get_OperationsDefIterator: IvcmOperationsDefIterator;
   function Get_ToolbarPos: TvcmToolBarPos;
   property OperationsDefIterator: IvcmOperationsDefIterator
     read Get_OperationsDefIterator;
     {* итератор описаний операций. Может быть nil }
   property ToolbarPos: TvcmToolBarPos
     read Get_ToolbarPos;
     {* любой объект, обладающий набором операций, может отображать их в тулбаре }
 end;//IvcmOperationalIdentifiedUserFriendlyControl
{$IfEnd} //not NoVCM

implementation

end.