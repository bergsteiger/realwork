unit vcmBaseOperationState;

{ Ѕиблиотека "vcm"        }
{ јвтор: Ћюлин ј.¬. ©     }
{ ћодуль: vcmBaseOperationState - }
{ Ќачат: 21.02.2003 19:09 }
{ $Id: vcmBaseOperationState.pas,v 1.12 2015/08/16 16:03:24 kostitsin Exp $ }

// $Log: vcmBaseOperationState.pas,v $
// Revision 1.12  2015/08/16 16:03:24  kostitsin
// {requestlink: 605157327 }
//
// Revision 1.11  2015/06/03 12:26:27  lulin
// - пытаемс€ разрулить зависимости.
//
// Revision 1.10  2013/04/25 14:22:38  lulin
// - портируем.
//
// Revision 1.9  2010/11/01 19:38:22  lulin
// {RequestLink:237994238}.
// - учитываем ifdef дл€ состо€ний операций.
//
// Revision 1.8  2010/08/31 18:25:46  lulin
// {RequestLink:224134305}.
//
// Revision 1.7  2006/03/20 13:03:52  lulin
// - new behavior: выливаем параметры состо€ний операции.
//
// Revision 1.6  2004/03/19 12:02:47  law
// - bug fix: дл€ состо€ни€ операции был пустой Hint (CQ OIT5-6070).
//
// Revision 1.5  2004/01/15 11:07:47  law
// - new behavior: если ImageIndex не задан, то берем его от операции.
//
// Revision 1.4  2004/01/14 18:43:24  law
// - new behavior:  перевел обработку части операции на "состо€ни€".
//
// Revision 1.3  2004/01/14 17:32:24  law
// - new behavior: берем Caption из операции, а не из Name.
//
// Revision 1.2  2004/01/14 17:25:07  law
// - new behavior: мапируем свойство _States на операцию, живущую в StdRes.
//
// Revision 1.1  2004/01/14 16:18:17  law
// - new units: vcmBaseOperationState, vcmBaseOperationStates.
//
// Revision 1.4  2004/01/14 14:54:26  law
// - bug fix.

{$Include vcmDefine.inc }

interface

{$If not defined(NoVCM)}
uses
  Classes,
  ImgList,
  
  vcmOperationParams,
  vcmExternalInterfaces
  ;

type
  TvcmBaseOperationState = class(TvcmOperationParams)
    private
    // property fields
      f_Visible : Boolean;
      f_Enabled : Boolean;
      f_Checked : Boolean;
    protected
    // property methods
      function  pm_GetCaption: AnsiString;
        override;
      function GetCaptionStored: Boolean;
        override;
        {-}
      function  pm_GetHint: AnsiString;
        override;
        {-}
      function  pm_GetImageIndex: TImageIndex;
        override;
      function  ImageIndexStored: Boolean;
        override;
        {-}
    protected
    // property methods
      function Operation: TvcmOperationParams;
        {-}
    public
    // public methods
      constructor Create(Collection: TCollection);
        override;
        {-}
      function StateIndex : TvcmOperationStateIndex;
        {-}
    published
    // published properties
      property Visible: Boolean
        read f_Visible
        write f_Visible
        default true;
        {-}
      property Enabled: Boolean
        read f_Enabled
        write f_Enabled
        default true;
        {-}
      property Checked: Boolean
        read f_Checked
        write f_Checked
        default false;
        {-}
  end;//TvcmBaseOperationState
{$IfEnd}  

implementation

{$If not defined(NoVCM)}
uses
  SysUtils,

  vcmBaseCollectionItem
  ;

// start class TvcmBaseOperationState

constructor TvcmBaseOperationState.Create(Collection: TCollection);
  //override;
  {-}
begin
 inherited;
 Visible := true;
 Enabled := true;
end;

function TvcmBaseOperationState.StateIndex : TvcmOperationStateIndex;
  {-}
begin
 Result.rID := Self.Index;
end;

function TvcmBaseOperationState.Operation: TvcmOperationParams;
  {-}
begin
 if (Collection <> nil) AND (Collection.Owner Is TvcmOperationParams) then
  Result := TvcmOperationParams(Collection.Owner)
 else
  Result := nil; 
end;

function TvcmBaseOperationState.pm_GetCaption: AnsiString;
  //override;
  {-}
begin
 Result := inherited pm_GetCaption;
 if (Operation <> nil) AND ((Result = '') OR ANSISameText(Result, Name)) then
  Result := Operation.Caption;
end;

function TvcmBaseOperationState.GetCaptionStored: Boolean;
  //override;
  {-}
begin
 Result := (Operation = nil) OR not ANSISameText(Caption, Operation.Caption);
end;

function TvcmBaseOperationState.pm_GetHint: AnsiString;
  //override;
  {-}
begin
 Result := inherited pm_GetHint;
 if (Result = '') then
 begin
  Result := Caption;
  Hint := Result;
  // - дл€ того, чтобы запустить цепочку присвоений Hint -> LongHint -> Description  
 end;//Result = ''
end;

function TvcmBaseOperationState.pm_GetImageIndex: TImageIndex;
  //override;
begin
 Result := inherited pm_GetImageIndex;
 if (Result = -1) AND (Operation <> nil) then
  Result := Operation.ImageIndex;
end;

function TvcmBaseOperationState.ImageIndexStored: Boolean;
  //override;
  {-}
begin
 if (Operation = nil) then
  Result := inherited ImageIndexStored
 else
  Result := (ImageIndex <> Operation.ImageIndex); 
end;
{$IfEnd}

end.

