unit vcmOperationParams;

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmOperationParams - }
{ Начат: 14.01.2004 15:46 }
{ $Id: vcmOperationParams.pas,v 1.18 2013/07/05 09:10:35 lulin Exp $ }

// $Log: vcmOperationParams.pas,v $
// Revision 1.18  2013/07/05 09:10:35  lulin
// - чистим код.
//
// Revision 1.17  2013/04/25 14:22:38  lulin
// - портируем.
//
// Revision 1.16  2011/07/29 15:08:37  lulin
// {RequestLink:209585097}.
//
// Revision 1.15  2009/02/20 13:44:19  lulin
// - <K>: 136941122.
//
// Revision 1.14  2007/04/12 07:57:09  lulin
// - используем строки с кодировкой.
//
// Revision 1.13  2007/04/10 14:06:22  lulin
// - используем строки с кодировкой.
//
// Revision 1.12  2006/03/20 13:03:52  lulin
// - new behavior: выливаем параметры состояний операции.
//
// Revision 1.11  2004/09/13 08:56:10  lulin
// - new behavior: TvcmPrimCollectionItem теперь может кешироваться и распределяться в пуле объектов.
//
// Revision 1.10  2004/09/10 16:21:46  lulin
// - оптимизация - кешируем OpDef и передаем ссылку на OperationItem, а не на кучу параметров.
//
// Revision 1.9  2004/07/30 13:07:18  law
// - cleanup.
//
// Revision 1.8  2004/07/30 12:50:18  law
// - bug fix: ShortCut'ами формы затирались ShortCut'ы MenuManager'а.
//
// Revision 1.7  2004/07/30 08:44:04  law
// - bug fix: неправильно определалась необходимость сохранения свойства SecondaryShortCuts.
//
// Revision 1.6  2004/03/11 10:45:04  nikitin75
// + Assign для присваивания SecondaryShortCuts;
//
// Revision 1.5  2004/03/09 11:37:03  nikitin75
// + поддержка нескольких shortcut'ов для операции;
//
// Revision 1.4  2004/03/09 07:17:57  nikitin75
// + поддержка нескольких shortcut'ов для операции;
//
// Revision 1.3  2004/01/14 14:45:45  law
// - new prop: TvcmOperationState.Checked.
//
// Revision 1.2  2004/01/14 13:58:03  law
// - new units: vcmOperationState, vcmOperationStates.
//
// Revision 1.1  2004/01/14 12:58:47  law
// - new units: vcmOperationParams.
//

{$Include vcmDefine.inc }

interface

{$IfNDef NoVCM}
uses
  Classes,
  ImgList,
  ActnList,

  vcmInterfaces,

  vcmBaseCollectionItem
  ;

type
  TvcmOperationParams = class(TvcmBaseCollectionItem)
    private
    // property fields
      f_Hint               : AnsiString;
      f_LongHint           : AnsiString;
      f_ShortCut           : TShortCut;
      f_SecondaryShortCuts : TShortCutList;
      f_ImageIndex         : TImageIndex;
    protected
    // property methods
      function  pm_GetHint: AnsiString;
        virtual;
      procedure pm_SetHint(const aValue: AnsiString);
        virtual;
        {-}
      function  pm_GetLongHint: AnsiString;
        virtual;
      procedure pm_SetLongHint(const aValue: AnsiString);
        virtual;
        {-}
      function  pm_GetImageIndex: TImageIndex;
        virtual;
      procedure pm_SetImageIndex(aValue: TImageIndex);
        virtual;
      function  ImageIndexStored: Boolean;
        virtual;
        {-}
      function  pm_GetShortCut: TShortCut;
        virtual;
      procedure pm_SetShortCut(aValue: TShortCut);
        virtual;
        {-}
      function  pm_GetSecondaryShortCuts: TShortCutList;
        virtual;
        {-}
      procedure pm_SetSecondaryShortCuts(aValue: TShortCutList);
        virtual;
        {-}
      function  SecondaryShortCutsStored: Boolean;
        virtual;
        {-}
      function  ShortCutStored: Boolean;
        virtual;
        {-}
      function HintStored: Boolean;
        virtual;
        {-}
      function LongHintStored: Boolean;
        virtual;
        {-}
      procedure ChangeCaption(const anOld, aNew: AnsiString);
        override;
        { Вызывается при изменении заголовка. }
      procedure Cleanup;
        override;
        {-}
      procedure BeforeAddToCache;
        override;
        {-}
    public
    // public methods
      constructor Create(Collection: TCollection);
        override;
        {-}
      procedure Assign(P: TPersistent);
        override;
        {-}
      function QueryInterface(const IID: TGUID; out Obj): HResult;
        override;
        {-}
    published
    // published properties
      property Hint: AnsiString
        read pm_GetHint
        write pm_SetHint
        stored HintStored;
        { Текст всплывающей подсказки. }
      property LongHint: AnsiString
        read pm_GetLongHint
        write pm_SetLongHint
        stored LongHintStored;
        { Текст подсказки, отображаемой в статусной строке приложения. }
      property ShortCut: TShortCut
        read pm_GetShortCut
        write pm_SetShortCut
        stored ShortCutStored
        default 0;
        { "Горячая" клавиша для вызова операции. }
      property SecondaryShortCuts: TShortCutList
        read pm_GetSecondaryShortCuts
        write pm_SetSecondaryShortCuts
        stored SecondaryShortCutsStored;
        { Список дополнительных "горячих" клавиш для вызова операции. }
      property ImageIndex: TImageIndex
        read pm_GetImageIndex
        write pm_SetImageIndex
        stored ImageIndexStored
        default -1;
        { Индекс картинки, связанной с операцией }
  end;//TvcmOperationParams
{$EndIf NoVCM}

implementation

{$IfNDef NoVCM}
uses
  SysUtils,

  Menus,

  vcmBase,
  vcmUserControls,
  vcmUserFriendly
  ;

// start class TvcmOperationParams

constructor TvcmOperationParams.Create(Collection: TCollection);
  //override;
  {-}
begin
 inherited;
 ImageIndex := -1;
end;

procedure TvcmOperationParams.Cleanup;
  //override;
  {-}
begin
 FreeAndNil(f_SecondaryShortCuts);
 inherited;
end;

procedure TvcmOperationParams.BeforeAddToCache;
  //override;
  {-}
begin
 inherited;
 f_Hint := '';
 f_LongHint := '';
 f_ShortCut := 0;
end;

function TvcmOperationParams.pm_GetHint: AnsiString;
  //virtual;
begin
 Result := f_Hint;
end;

procedure TvcmOperationParams.pm_SetHint(const aValue: AnsiString);
  {-}
begin
 if (f_Hint <> aValue) then begin
  if (f_Hint = LongHint) then
   LongHint := aValue;
  f_Hint := aValue;
 end;//f_Hint <> aValue
end;

function TvcmOperationParams.pm_GetLongHint: AnsiString;
  //virtual;
  {-}
begin
 Result := f_LongHint;
end;

procedure TvcmOperationParams.pm_SetLongHint(const aValue: AnsiString);
  //virtual;
  {-}
begin
 f_LongHint := aValue;
end;

function TvcmOperationParams.pm_GetImageIndex: TImageIndex;
  //virtual;
  {-}
begin
 Result := f_ImageIndex;
end;

procedure TvcmOperationParams.pm_SetImageIndex(aValue: TImageIndex);
  //virtual;
  {-}
begin
 f_ImageIndex := aValue;
end;

function TvcmOperationParams.ImageIndexStored: Boolean;
  //virtual;
  {-}
begin
 Result := (f_ImageIndex >= 0);
end;

function TvcmOperationParams.pm_GetShortCut: TShortCut;
  //virtual;
  {-}
begin
 Result := f_ShortCut;
end;

procedure TvcmOperationParams.pm_SetShortCut(aValue: TShortCut);
  //virtual;
  {-}
begin
 f_ShortCut := aValue;
end;

function TvcmOperationParams.pm_GetSecondaryShortCuts: TShortCutList;
  //virtual;
  {-}
begin
 if f_SecondaryShortCuts = nil then
  f_SecondaryShortCuts := TShortCutList.Create;
 Result := f_SecondaryShortCuts;
end;

procedure TvcmOperationParams.pm_SetSecondaryShortCuts(aValue: TShortCutList);
  //virtual;
  {-}
begin
 if (aValue <> nil) then
 begin
  if f_SecondaryShortCuts = nil then
   f_SecondaryShortCuts := TShortCutList.Create;
  f_SecondaryShortCuts.Assign(aValue)
 end//aValue <> nil
 else
 if (f_SecondaryShortCuts <> nil) then
  f_SecondaryShortCuts.Clear;
end;

function TvcmOperationParams.SecondaryShortCutsStored: Boolean;
  //virtual;
  {-}
begin
 Result := (SecondaryShortCuts <> nil) AND (SecondaryShortCuts.Count > 0);
end;

function TvcmOperationParams.ShortCutStored: Boolean;
  //virtual;
  {-}
begin
 Result := (f_ShortCut <> 0);
end;

function TvcmOperationParams.HintStored: Boolean;
  {-}
begin
 Result := (Hint <> Caption);
end;

function TvcmOperationParams.LongHintStored: Boolean;
  {-}
begin
 Result := (LongHint <> Hint);
end;

procedure TvcmOperationParams.Assign(P: TPersistent);
  //override;
  {-}
begin
 inherited;
 if (P Is TvcmOperationParams) then begin
  Hint := TvcmOperationParams(P).Hint;
  LongHint := TvcmOperationParams(P).LongHint;
  ShortCut := TvcmOperationParams(P).ShortCut;
  SecondaryShortCuts := TvcmOperationParams(P).SecondaryShortCuts;
  ImageIndex := TvcmOperationParams(P).ImageIndex;
 end;//TvcmBaseOperationsCollectionItem
end;

function TvcmOperationParams.QueryInterface(const IID: TGUID; out Obj): HResult;
  //override;
  {-}
var
 l_UF : TvcmUserFriendly;  
begin
 if IsEqualGUID(IID, IvcmUserFriendlyControl) then
 begin
  Result := S_Ok;
  l_UF := TvcmUserFriendly.Create(Name, vcmCStr(Caption), vcmCStr(Hint), vcmCStr(LongHint), ImageIndex);
  try
   IvcmUserFriendlyControl(Obj) := l_UF;
  finally
   vcmFree(l_UF);
  end;//try..finally
 end//IsEqualGUID(IID, IvcmUserFriendlyControl)
 else
  Result := inherited QueryInterface(IID, Obj);
end;

procedure TvcmOperationParams.ChangeCaption(const anOld, aNew: AnsiString);
  //override;
  { Вызывается при изменении заголовка. }
begin
 inherited;
 if (anOld = Hint) then
  Hint := aNew;
end;
{$EndIf NoVCM}

end.

