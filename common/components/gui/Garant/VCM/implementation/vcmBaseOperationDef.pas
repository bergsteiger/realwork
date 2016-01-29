unit vcmBaseOperationDef;
{* Базовый класс описания операции. }

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmBaseOperationDef - }
{ Начат: 25.02.2003 13:36 }
{ $Id: vcmBaseOperationDef.pas,v 1.46 2015/10/19 13:53:56 kostitsin Exp $ }

// $Log: vcmBaseOperationDef.pas,v $
// Revision 1.46  2015/10/19 13:53:56  kostitsin
// рисуем TvcmBaseOperationsCollectionItem
//
// Revision 1.45  2015/07/09 15:59:40  kostitsin
// {requestlink: 127042272 }
//
// Revision 1.44  2015/07/09 12:40:32  kostitsin
// {requestlink: 127042272 } - грохнул ещё один _TvcmInterfaceList.
//
// Revision 1.43  2013/07/05 09:10:33  lulin
// - чистим код.
//
// Revision 1.42  2013/07/01 12:28:54  morozov
// {RequestLink:382416588}
//
// Revision 1.41  2012/08/07 14:37:37  lulin
// {RequestLink:358352265}
//
// Revision 1.40  2012/07/17 11:52:44  lulin
// {RequestLink:378541134}
//
// Revision 1.39  2012/07/17 11:12:07  lulin
// {RequestLink:378541134}
//
// Revision 1.38  2012/04/11 15:28:37  lulin
// - пытаемся разобраться с "галочками".
//
// Revision 1.37  2011/12/08 16:29:58  lulin
// {RequestLink:273590436}
// - чистка кода.
//
// Revision 1.36  2010/09/15 18:14:59  lulin
// {RequestLink:235047275}.
//
// Revision 1.35  2010/07/16 16:07:04  lulin
// {RequestLink:197496539}.
//
// Revision 1.34  2010/04/30 15:15:42  lulin
// {RequestLink:207389954}.
// - чистка комментариев.
//
// Revision 1.33  2009/02/20 13:44:16  lulin
// - <K>: 136941122.
//
// Revision 1.32  2009/02/12 17:09:12  lulin
// - <K>: 135604584. Выделен модуль с внутренними константами.
//
// Revision 1.31  2007/04/26 13:29:42  oman
// - new: Жирность можно задавать в DesignTime - добавилось
//  свойство <_Operation>.IsDefault (cq24612)
//
// Revision 1.30  2007/04/12 07:57:07  lulin
// - используем строки с кодировкой.
//
// Revision 1.29  2007/04/10 14:06:20  lulin
// - используем строки с кодировкой.
//
// Revision 1.28  2007/04/10 13:20:08  lulin
// - используем строки с кодировкой.
//
// Revision 1.27  2007/01/26 11:53:00  oman
// - fix: Операции без назначенных обработчиков не были видимы
//  пользователю (cq24210)
//
// Revision 1.26  2006/04/17 07:34:42  mmorozov
// - bugfix: не правильно создавался список, его использование  приводило к AV (DesignTime);
//
// Revision 1.25  2006/04/11 10:30:05  oman
// - fix: Не собиралась библиотека
//
// Revision 1.24  2006/04/11 08:46:23  oman
// - fix: Более экономно кэшируем информацию и состояниях
//
// Revision 1.23  2006/04/11 08:15:34  oman
// - fix: После отвязывания от операции утрачивалась информация о состояниях
//
// Revision 1.22  2006/03/20 13:03:50  lulin
// - new behavior: выливаем параметры состояний операции.
//
// Revision 1.21  2006/01/20 11:33:08  mmorozov
// 1. Нельзя было на панель инструментов положить неколько операций из разных сущностей с одинаковыми именами;
// 2. Если в панели инструментов встречаются операции с одинаковыми названиями, то им автоматически добавляется суффикс в виде названия сущности;
// 3. Появилась возможность указать, что контекстные операции сущности должны показываться в отдельном пункте меню;
// 3.
//
// Revision 1.20  2005/02/02 12:56:30  am
// change: правки, связанные с переделками TvcmBaseOperationCollectionItem._Handled()
//
// Revision 1.19  2005/01/27 15:24:01  am
// change: показываем в настройке тулбаров операции, публикуемые самими контролами
//
// Revision 1.18  2005/01/27 14:01:12  am
// change: показываем в настройке тулбаров только те операции, для которых установлен OnExecute.
//
// Revision 1.17  2005/01/25 10:25:50  lulin
// - bug fix: в настройке не показывались операции, которые по-умолчанию не показываются на Toolbar'ах.
//
// Revision 1.16  2004/11/18 16:29:52  lulin
// - отвязываем библиотеки от VCM без использования inc'ов.
//
// Revision 1.15  2004/09/10 16:47:12  lulin
// - оптимизация - удалось избежать повторного пересоздания OpDef.
//
// Revision 1.14  2004/09/10 16:21:42  lulin
// - оптимизация - кешируем OpDef и передаем ссылку на OperationItem, а не на кучу параметров.
//
// Revision 1.13  2004/09/07 10:32:09  am
// change: оптимизация и багфикс, связанный с _VisibleToUser
//
// Revision 1.12  2004/08/31 07:56:39  am
// change: перенёс вычисление "видимости" операции с def'а на item
//
// Revision 1.11  2004/08/19 14:14:41  am
// new: OperationDef._VisibleToUser - доступна ли операция пользователю в настройке тулбаров
// new: UserTypeDef._UserVisibleOpCount - количество доступных пользователю операций
//
// Revision 1.10  2004/03/11 12:29:35  nikitin75
// + SecondaryShortCuts support;
//
// Revision 1.9  2004/02/02 15:05:34  law
// - remove proc: vcmMakeBaseOperationDef.
// - new method: TvcmBaseOperationDef.Make.
//
// Revision 1.7  2003/10/28 11:25:43  law
// - new prop: IvcmOperationDef._GroupID.
//
// Revision 1.6  2003/07/24 13:07:12  law
// - new prop: IvcmOperationDef._ExcludeUserTypes.
//
// Revision 1.5  2003/04/08 12:34:45  law
// - new prop: IvcmOperationDef.Options.
// - new prop: TvcmOperationsCollectionItem.Options.
//
// Revision 1.4  2003/04/04 12:56:29  law
// - new prop: IvcmOperationDef.ShortCut.
//
// Revision 1.3  2003/04/04 10:58:57  law
// - bug fix: была ошибка в имени типа TvcmControlID.
//
// Revision 1.2  2003/04/02 13:50:30  law
// - new const: vcm_otInternal.
//
// Revision 1.1  2003/04/01 12:54:41  law
// - переименовываем MVC в VCM.
//
// Revision 1.8  2003/03/27 14:36:52  law
// - new prop: операция теперь имеет картинку.
//
// Revision 1.7  2003/03/26 16:10:32  law
// - new prop: сделано свойство _Category для операции.
//
// Revision 1.6  2003/03/21 10:13:32  law
// - cleanup: удалены модули vcm*Repository.
//
// Revision 1.5  2003/03/20 16:42:56  law
// - change: всем объектам кроме Name добавлено свойство Caption.
//
// Revision 1.4  2003/03/11 13:03:57  law
// - new behavior: сделано автоматическое определение идентификаторов сущностей и операций.
//
// Revision 1.3  2003/02/27 09:00:03  law
// - cleanup.
//
// Revision 1.2  2003/02/25 17:59:45  law
// - new behavior: начал писать обвязку для выполнения операций модуля.
//
// Revision 1.1  2003/02/25 11:08:05  law
// - change: добавлено определение операций модуля.
//

{$Include vcmDefine.inc }

interface

uses
  Classes,
  ActnList,

  vcmUserControls,
  vcmInterfaces,
  vcmExternalInterfaces,

  vcmBase,
  vcmBaseOperationsCollectionItem,
  vcmIdentifiedUserFriendlyWithCategory,
  vcmUserFriendlyControlList
  ;

type
  IvcmOpHolder = interface(IUnknown)
    ['{91AE0428-9435-4971-BED0-157375D9E635}']
    // public methods
      procedure ClearOp;
        {-}
  end;//IvcmOpHolder

  TvcmBaseOperationDef = class(TvcmIdentifiedUserFriendlyWithCategory, IvcmOperationDef, IvcmOpHolder)
   {* Базовый класс описания операции. }
    private
    // internal fields
      f_Op                  : TvcmBaseOperationsCollectionItemPrim;
      f_ShortCut            : TShortCut;
      f_SecondaryShortCuts  : TShortCutList;
      f_OperationType       : TvcmOperationType;
      f_Options             : TvcmOperationOptions;
      f_ExcludeUserTypes    : TvcmUserTypes;
      f_VisibleToUser       : Integer;
      f_IsCaptionUnique     : Boolean;
      f_States              : TvcmUserFriendlyControlList;
      f_IsDefault           : Boolean;
    protected
    // interface methods
      // IvcmOperationDef
      function Get_Caption: IvcmCString;
        override;
        {-}
      function Get_Hint: IvcmCString;
        override;
        {-}
      function Get_LongHint: IvcmCString;
        override;
        {-}
      function Get_ImageIndex: Integer;
        override;
        {-}
      function Get_Category: TvcmString;
        override;
        {-}
      function Get_GroupID: Integer;
        override;
        {-}
      function Get_OperationType: TvcmOperationType;
        {-}
      function Get_ShortCut: TShortCut;
        {-}
      function Get_SecondaryShortCuts: TShortCutList;
        {-}
      function Get_Options: TvcmOperationOptions;
        {-}
      function Get_ExcludeUserTypes: TvcmUserTypes;
        {-}
      function Get_VisibleToUser: Boolean;
        {-}
      function Get_IsCaptionUnique: Boolean;
        {* - определяет является ли имя операции уникальным в пределах всех
             операций формы. }
      function Get_StatesCount: Integer;
        {-}
      function Get_State(anIndex: Integer): IvcmUserFriendlyControl;
        {-}
      function Get_IsDefault: Boolean;
        {-}
      function Get_ContextMenuWeight: Integer;
      // IvcmOpHolder
      procedure ClearOp;
        {-}
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(anOp: TvcmBaseOperationsCollectionItemPrim);
        reintroduce;
        {-}
      class function Make(anOp: TvcmBaseOperationsCollectionItemPrim): IvcmOperationDef;
        {* - возвращает базовый описатель операции. }
  end;//TvcmBaseOperationDef


implementation

uses
  SysUtils,

  vcmRepositoryEx,
  vcmBaseOperationState,
  vcmUserFriendly,

  vcmInternalConst
  ;

// start class TvcmBaseOperationDef

constructor TvcmBaseOperationDef.Create(anOp: TvcmBaseOperationsCollectionItemPrim);
  //reintroduce;
  {-}
begin
 inherited Create(anOp.OperationID,
                  anOp.Name,
                  vcmCStr(anOp.Caption),
                  vcmCStr(anOp.Hint),
                  vcmCStr(anOp.LongHint),
                  //anOp.LongHint,
                  anOp.ImageIndex,
                  {$IfNDef DesignTimeLibrary}
                  anOp.Category
                  {$Else  DesignTimeLibrary}
                  ''
                  {$EndIf DesignTimeLibrary}
                  ,
                  anOp.GroupID);
 f_Op := anOp;
 f_Options := f_Op.Options;
 f_IsCaptionUnique := f_Op.IsCaptionUnique;
 f_VisibleToUser := -1;
 f_IsDefault := f_Op.IsDefault;
 f_States := nil;
end;

class function TvcmBaseOperationDef.Make(anOp: TvcmBaseOperationsCollectionItemPrim): IvcmOperationDef;
  {* - возвращает базовый описатель операции. }
var
 l_OperationDef : TvcmBaseOperationDef;
begin
 l_OperationDef := Create(anOp);
 try
  Result := l_OperationDef;
 finally
  vcmFree(l_OperationDef);
 end;//try..finally
end;

procedure TvcmBaseOperationDef.Cleanup;
  //override;
  {-}
begin
 f_Op := nil;
 FreeAndNil(f_SecondaryShortCuts);
 vcmFree(f_States);
 inherited;
end;

function TvcmBaseOperationDef.Get_Caption: IvcmCString;
  //override;
  {-}
begin
 if (f_Op = nil) then
  Result := inherited Get_Caption
 else
  Result := vcmCStr(f_Op.Caption);
end;

function TvcmBaseOperationDef.Get_Hint: IvcmCString;
  //override;
  {-}
begin
 if (f_Op = nil) then
  Result := inherited Get_Hint
 else
  Result := vcmCStr(f_Op.Hint);
end;

function TvcmBaseOperationDef.Get_LongHint: IvcmCString;
  //override;
  {-}
begin
 if (f_Op = nil) then
  Result := inherited Get_LongHint
 else
  Result := vcmCStr(f_Op.LongHint);
end;

function TvcmBaseOperationDef.Get_ImageIndex: Integer;
  //override;
  {-}
begin
 if (f_Op = nil) then
  Result := inherited Get_ImageIndex
 else
  Result := f_Op.ImageIndex;
end;

function TvcmBaseOperationDef.Get_Category: TvcmString;
  //override;
  {-}
begin
 {$IfNDef DesignTimeLibrary}
 if (f_Op = nil) then
  Result := inherited Get_Category
 else
  Result := f_Op.Category;
 {$Else  DesignTimeLibrary}
 Result := inherited Get_Category;
 {$EndIf DesignTimeLibrary}
end;

function TvcmBaseOperationDef.Get_GroupID: Integer;
  //override;
  {-}
begin
 if (f_Op = nil) then
  Result := inherited Get_GroupID
 else
  Result := f_Op.GroupID;
end;

function TvcmBaseOperationDef.Get_OperationType: TvcmOperationType;
  {-}
begin
 if (f_Op = nil) then
  Result := f_OperationType
 else
  Result := f_Op.OperationType;
end;

function TvcmBaseOperationDef.Get_ShortCut: TShortCut;
  {-}
begin
 if (f_Op = nil) then
  Result := f_ShortCut
 else
  Result := f_Op.ShortCut; 
end;

function TvcmBaseOperationDef.Get_SecondaryShortCuts: TShortCutList;
  {-}
begin
 if (f_Op = nil) then
  Result := f_SecondaryShortCuts
 else
  Result := f_Op.SecondaryShortCuts;
end;

function TvcmBaseOperationDef.Get_Options: TvcmOperationOptions;
  {-}
begin
 if (f_Op = nil) then
  Result := f_Options
 else
 begin
  Result := f_Op.Options;
  f_Options := Result;
 end;//f_Op = nil
end;

function TvcmBaseOperationDef.Get_ExcludeUserTypes: TvcmUserTypes;
  {-}
begin
 if (f_Op = nil) then
  Result := f_ExcludeUserTypes
 else
  Result := f_Op.ExcludeUserTypes;
end;

function TvcmBaseOperationDef.Get_IsCaptionUnique: Boolean;
  {* - определяет является ли имя операции уникальным в пределах всех
       операций формы. }
begin
 if Assigned(f_Op) then
  Result := f_Op.IsCaptionUnique
 else
  Result := f_IsCaptionUnique;
end;

function TvcmBaseOperationDef.Get_StatesCount: Integer;
  {-}
begin
 if Assigned(f_Op) and Assigned(f_Op.States) then
  Result := f_Op.States.Count
 else
  if Assigned(f_States) then
   Result := f_States.Count
  else
   Result := 0;
end;

function TvcmBaseOperationDef.Get_State(anIndex: Integer): IvcmUserFriendlyControl;
  {-}
begin
 if Assigned(f_Op) and Assigned(f_Op.States) then
  Result := f_Op.States.Items[anIndex] As IvcmUserFriendlyControl
 else
  if Assigned(f_States) then
   Result := f_States[anIndex]
  else
   Result := nil;
end;

function TvcmBaseOperationDef.Get_VisibleToUser: Boolean;
begin
 if f_VisibleToUser = -1 then
  if not vcmIsNil(Get_Caption) AND
     (Get_OperationType in vcmToolbarOpTypes) then
   f_VisibleToUser := 1
  else
   f_VisibleToUser := 0;

 Result := f_VisibleToUser > 0;
end;

procedure TvcmBaseOperationDef.ClearOp;
  {-}
var
 l_Idx: Integer;
 l_StateDef: TvcmUserFriendly;
begin
 if (f_Op <> nil) then
 begin
  f_Caption := vcmCStr(f_Op.Caption);
  f_Hint := vcmCStr(f_Op.Hint);
  f_LongHint := vcmCStr(f_Op.LongHint);
  //f_Description := f_Op.LongHint;
  f_ImageIndex := f_Op.ImageIndex;
  {$IfNDef DesignTimeLibrary}
  f_Category := f_Op.Category;
  {$EndIf DesignTimeLibrary}
  f_GroupID := f_Op.GroupID;
  f_Options := f_Op.Options;
  f_OperationType := f_Op.OperationType;
  f_ShortCut := f_Op.ShortCut;
  f_SecondaryShortCuts := TShortCutList.Create;
  if Assigned(f_Op.SecondaryShortCuts) then
   f_SecondaryShortCuts.Assign(f_Op.SecondaryShortCuts);
  f_ExcludeUserTypes := f_Op.ExcludeUserTypes;
  f_IsDefault := f_Op.IsDefault;
  if f_Op.States.Count > 0 then
  begin
   f_States := TvcmUserFriendlyControlList.Create;
   for l_Idx := 0 to f_Op.States.Count - 1 do
    with TvcmBaseOperationState(f_Op.States.Items[l_Idx]) do
    begin
     l_StateDef := TvcmUserFriendly.Create(Name, vcmCStr(Caption), vcmCStr(Hint), vcmCStr(LongHint), ImageIndex);
     try
      f_States.Add(l_StateDef as IvcmUserFriendlyControl);
     finally
      vcmFree(l_StateDef);
     end;
    end;
  end;
 end;//f_Op <> nil
 f_Op := nil;
end;

function TvcmBaseOperationDef.Get_IsDefault: Boolean;
begin
 if (f_Op = nil) then
  Result := f_IsDefault
 else
  Result := f_Op.IsDefault;
end;

function TvcmBaseOperationDef.Get_ContextMenuWeight: Integer;
begin
 if (f_Op = nil) then
  Result := -1
 else
  Result := f_Op.ContextMenuWeight;
end;

end.

