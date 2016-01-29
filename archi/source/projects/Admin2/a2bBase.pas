unit a2bBase;

{ $Id: a2bBase.pas,v 1.23 2015/01/22 08:32:54 lukyanets Exp $}

// $Log: a2bBase.pas,v $
// Revision 1.23  2015/01/22 08:32:54  lukyanets
// Более правильный тип
//
// Revision 1.22  2013/01/17 07:57:01  fireton
// - погорячились с удалением "мусорных" стадий
//
// Revision 1.21  2013/01/16 11:27:20  fireton
// - изменён порядок и названия стадий
//
// Revision 1.20  2009/04/02 13:11:30  fireton
// - [$137470683]. Правка огрехов в отрисовке дерева пользователей.
//
// Revision 1.19  2008/10/07 12:27:14  voba
// no message
//
// Revision 1.18  2007/04/17 11:39:38  fireton
// - регионы в имени пользователей
//
// Revision 1.17  2007/03/26 13:16:30  fireton
// - мелкий багфикс там и сям
//
// Revision 1.16  2007/02/08 14:22:09  fireton
// - bug fix
// - доработан экспорт и импорт
//
// Revision 1.15  2007/01/30 08:47:38  fireton
// - переезд на новую версию VCM
//
// Revision 1.14  2006/11/28 10:17:49  fireton
// - bugfix: унификация констант
//
// Revision 1.13  2006/11/23 09:13:20  fireton
// - добавлен пункт "Публикация" в правах на группу документов
//
// Revision 1.12  2006/11/22 16:22:20  fireton
// - переход на новую инкарнацию VCM
//
// Revision 1.11  2005/09/14 10:49:30  fireton
// - add: на Ia2Persistent добавился IsNew
//
// Revision 1.10  2005/08/29 15:03:48  fireton
// - промежуточный коммит (профили группы)
//
// Revision 1.9  2005/08/22 13:12:59  fireton
// - промежуточный коммит (реализация визуальной части - bug fix и группы пользователей)
//
// Revision 1.8  2005/08/20 11:01:53  fireton
// - промежуточный коммит (реализация визуальной части и подгонка под сборки)
//
// Revision 1.7  2005/08/17 14:10:58  fireton
// - промежуточный коммит (подгонка под систему сборок)
//
// Revision 1.6  2005/08/15 07:57:42  fireton
// - введение служебного интерфейса: Ia2Service
//
// Revision 1.5  2005/08/09 13:02:59  fireton
// - доработка Ta2MarkedList
//
// Revision 1.4  2005/08/05 14:58:24  fireton
// - реализация бизнес-объектов
//
// Revision 1.3  2005/08/04 16:30:54  fireton
// - реализация бизнес-объектов
//
// Revision 1.2  2005/08/02 15:14:20  fireton
// - реализация бизнес-объектов
//
// Revision 1.1  2005/07/29 16:53:07  fireton
// - первый коммит
//

interface
uses
 Classes,

 l3Base,
 l3DatLst,
 l3ObjectStringList,


 Dt_Const,
 Dt_Types,
 Dt_User,

 vcmInterfaces,
 vcmFormDataSource,

 a2Interfaces;

const
 a2cNewItemID     = 0;
 a2cAllUsersGroup = High(TUserGrID);

const
 cStdRightsItemName : array[0..9] of String = ('Название и атрибуты',
                                               'Текст и справка',
                                               'Гиперссылки',
                                               'Метки',
                                               'Блоки',
                                               'Ключевые слова',
                                               'Классификация',
                                               'Юридические операции',
                                               'Аннотация',
                                               'Публикация');

 cDictRightsItemName : array[0..4] of String = ('Неспецифичные словари',
                                                'Классификатор',
                                                'Новый классификатор',
                                                'Ключевые слова',
                                                'Издания');


type
 Ta2Profile = class(Tl3Base, Ia2Profile, Ia2Persistent)
 private
  f_DisplayName: string;
 protected
  f_ID: TUserID;
  f_Name: string;
  f_Modified: Boolean;
  procedure DoRevert; virtual;
  procedure DoSave; virtual;
  function pm_GetDisplayName: string;
  { - Ia2Profile methods -}
  function pm_GetID: Longword;
  function pm_GetName: string;
  procedure pm_SetName(const Value: string); virtual;
  { - Ia2Persistent property methods -}
  function pm_GetModified: Boolean;
  procedure pm_SetModified(const Value: Boolean);
  function pm_GetIsNew: Boolean;
  { - Ia2Persistent methods - }
  procedure Save;
  procedure Revert;
 public
  constructor Create;
  property DisplayName: string read pm_GetDisplayName;
  { - Ia2Profile properties -}
  property ID: TUserID read pm_GetID write f_ID;
  property Name: string read pm_GetName write pm_SetName;
  { - Ia2Persistent properties - }
  property Modified: Boolean read pm_GetModified write pm_SetModified;
  property IsNew: Boolean read pm_GetIsNew;
 end;

 Ta2MarkedList = class(Tl3StringDataList, Ia2MarkedList)
 private
  f_Modified: Boolean;
  f_Persistent: Pointer;
  { - Ia2MarkedList property methods -}
  function pm_GetName(Index: Integer): string;
  function pm_GetState(Index: Integer): Integer;
  function pm_GetTotal: LongInt;
  procedure pm_SetState(Index: Integer; const Value: Integer);
 protected
  procedure Cleanup; override;
 public
  constructor Create(aPersistent: Ia2Persistent);
  property Modified: Boolean read f_Modified write f_Modified;
 end;

 Ta2GroupRightsObject = class(Tl3Base, Ia2MarkedList)
 private
  f_Modified: Boolean;
  f_Persistent: Pointer;
  f_RightsMask: TUGAccessMask;
  function pm_GetIsSpecial: Boolean;
  { - Ia2MarkedList property methods -}
  function pm_GetName(Index: Integer): string;
  function pm_GetState(Index: Integer): Integer;
  function pm_GetTotal: LongInt;
  procedure pm_SetState(Index: Integer; const Value: Integer);
 public
  constructor Create(aPersistent: Ia2Persistent; aRightsMask: TUGAccessMask);
  property IsSpecial: Boolean read pm_GetIsSpecial;
  property Modified: Boolean read f_Modified write f_Modified;
  property RightsMask: TUGAccessMask read f_RightsMask write f_RightsMask;
 end;

 Ta2GroupRightsList = class(Tl3ObjectStringList, Ia2GroupRightsList)
 private
  { - Ia2GroupRightsList property methods -}
  function pm_GetIsSpecial(Index: Integer): Boolean;
  function pm_GetName(Index: Integer): string;
  function pm_GetTotal: Integer;
  { - Ia2GroupRightsList methods - }
  function GetRights(Index: Integer): Ia2MarkedList;
 protected
 public
  { - Ia2GroupRightsList properties - }
  property Total: Integer read pm_GetTotal;
  property Name[Index: Integer]: string read pm_GetName;
  property IsSpecial[Index: Integer]: Boolean read pm_GetIsSpecial;
 end;

 Ta2RepositionContainer = class(Tl3Base, Ia2RepositionContainer)
 private
  f_Profile  : Ia2Profile;
  f_ParentID : Integer;
  function pm_GetParentID: Integer;
  function pm_GetProfile: Ia2Profile;
 public
  constructor Create(aProfile: Ia2Profile; aParentID: Integer);
  class function Make(aProfile: Ia2Profile; aParentID: Integer = -1):
      Ia2RepositionContainer;

 end;

function GetSelectStateFromMask(aMask : TTblMaskRec; aIndex  : Integer): Integer;

procedure SetSelectStateToMask(var aMask : TTblMaskRec; aIndex  : Integer; aSelectState : Integer);


implementation

uses
 SysUtils,

 l3Bits,

 DT_Stage,
 DtSupport;

var
 a2vAllStagesArray: array of TStageType;


function GetSelectStateFromMask(aMask : TTblMaskRec; aIndex  : Integer): Integer;
begin
 Result := 0;
 If l3TestBit(aMask.DenyMask, aIndex) then
  Result := 2
 else
  If l3TestBit(aMask.AllowMask, aIndex) then
   Result := 1;
end;

procedure SetSelectStateToMask(var aMask : TTblMaskRec; aIndex  : Integer; aSelectState : Integer);
begin
 Case aSelectState of
  0 :
   begin
    l3ClearBit(aMask.AllowMask, aIndex);
    l3ClearBit(aMask.DenyMask, aIndex);
   end;
  1 :
   begin
    l3SetBit(aMask.AllowMask, aIndex);
    l3ClearBit(aMask.DenyMask, aIndex);
   end
  else
   begin
    l3SetBit(aMask.DenyMask, aIndex);
    l3ClearBit(aMask.AllowMask, aIndex);
   end;
 end;
end;

constructor Ta2Profile.Create;
begin
 inherited Create;
 f_ID := a2cNewItemID;
 f_Name := '';
 f_Modified := False;
end;

procedure Ta2Profile.DoRevert;
begin
 // empty in base class
end;

procedure Ta2Profile.DoSave;
begin
 // empty in base class
end;

function Ta2Profile.pm_GetDisplayName: string;
begin
 Result := f_DisplayName;
end;

function Ta2Profile.pm_GetID: Longword;
begin
 Result := f_ID;
end;

function Ta2Profile.pm_GetIsNew: Boolean;
begin
 Result := (f_ID = a2cNewItemID);
end;

function Ta2Profile.pm_GetModified: Boolean;
begin
 Result := f_Modified;
end;

function Ta2Profile.pm_GetName: string;
begin
 Result := f_Name;
end;

procedure Ta2Profile.pm_SetModified(const Value: Boolean);
begin
 f_Modified := Value;
end;

procedure Ta2Profile.pm_SetName(const Value: string);
begin
 if Value <> f_Name then
 begin
  f_Name := Value;
  f_Modified := True;
 end;
end;

procedure Ta2Profile.Revert;
begin
 if f_Modified then
 begin
  DoRevert;
  f_DisplayName := f_Name;
 end;
end;

procedure Ta2Profile.Save;
begin
 if f_Modified then
 begin
  DoSave;
  f_DisplayName := f_Name;
 end;
end;

constructor Ta2MarkedList.Create(aPersistent: Ia2Persistent);
begin
 inherited CreateSize(SizeOf(Integer));
 f_Persistent := Pointer(aPersistent);
 f_Modified := False;
end;

procedure Ta2MarkedList.Cleanup;
begin
 f_Persistent := nil;
 inherited;
end;

function Ta2MarkedList.pm_GetName(Index: Integer): string;
begin
 Result := PasStr[Index];
end;

function Ta2MarkedList.pm_GetState(Index: Integer): Integer;
begin
 if Select[Index] then
  Result := 1
 else
  Result := 0; 
end;

function Ta2MarkedList.pm_GetTotal: LongInt;
begin
 Result := Count;
end;

procedure Ta2MarkedList.pm_SetState(Index: Integer; const Value: Integer);
begin
 if Select[Index] <> (Value = 1) then
 begin
  Select[Index] := (Value = 1);
  Ia2Persistent(f_Persistent).Modified := True;
  f_Modified := True;
 end;
end;

constructor Ta2GroupRightsObject.Create(aPersistent: Ia2Persistent; aRightsMask: TUGAccessMask);
begin
 inherited Create;
 f_Persistent := Pointer(aPersistent);
 f_RightsMask := aRightsMask;
 f_Modified := False;
end;

function Ta2GroupRightsObject.pm_GetIsSpecial: Boolean;
begin
 Result := f_RightsMask.ID <= 4;
end;

function Ta2GroupRightsObject.pm_GetName(Index: Integer): string;
var
 l_RightsType: Integer;
begin
 l_RightsType := f_RightsMask.ID;
 if not (l_RightsType in [agDictions, agStages]) then
  l_RightsType := agIncluded;
 case l_RightsType of
  agIncluded   :
   Result := cStdRightsItemName[Index];
  agDictions   :
   Result := cDictRightsItemName[Index];
  agStages     :
   Result := cStagesStringUserOrder[Index+1].rName;
 end;
end;

function Ta2GroupRightsObject.pm_GetState(Index: Integer): Integer;
begin
 if f_RightsMask.ID = agStages then
  Index := StageTypeToBitIndex(cStagesStringUserOrder[Index+1].rStageID);
 Result := GetSelectStateFromMask(f_RightsMask.MaskRec, Index);
end;

function Ta2GroupRightsObject.pm_GetTotal: LongInt;
var
 l_RightsType: Integer;
begin
 l_RightsType := f_RightsMask.ID;
 if not (l_RightsType in [agDictions, agStages]) then
  l_RightsType := agIncluded;

 case l_RightsType of
  agIncluded   :
   Result := High(cStdRightsItemName)+1;
  agDictions   :
   Result := High(cDictRightsItemName)+1;
  agStages     :
   Result := High(cStagesStringUserOrder);
 end;
end;

procedure Ta2GroupRightsObject.pm_SetState(Index: Integer; const Value: Integer);
begin
 if f_RightsMask.ID = agStages then
  Index := StageTypeToBitIndex(cStagesStringUserOrder[Index+1].rStageID);
 SetSelectStateToMask(f_RightsMask.MaskRec, Index, Value);
 Ia2Persistent(f_Persistent).Modified := True;
 f_Modified := True;
end;

function Ta2GroupRightsList.GetRights(Index: Integer): Ia2MarkedList;
begin
 Result := Ta2GroupRightsObject(Objects[Index]);
end;

function Ta2GroupRightsList.pm_GetIsSpecial(Index: Integer): Boolean;
begin
 Result := Ta2GroupRightsObject(Objects[Index]).IsSpecial;
end;

function Ta2GroupRightsList.pm_GetName(Index: Integer): string;
begin
 Result := Strings[Index];
end;

function Ta2GroupRightsList.pm_GetTotal: Integer;
begin
 Result := Count;
end;

constructor Ta2RepositionContainer.Create(aProfile: Ia2Profile; aParentID: Integer);
begin
 inherited Create;
 f_Profile := aProfile;
 f_ParentID := aParentID;
end;

class function Ta2RepositionContainer.Make(aProfile: Ia2Profile; aParentID: Integer = -1): Ia2RepositionContainer;
var
 l_Cont: Ia2RepositionContainer;
begin
 try
  l_Cont := Ta2RepositionContainer.Create(aProfile, aParentID);
  Result := l_Cont;
 finally
  l_Cont := nil;
 end;
end;

function Ta2RepositionContainer.pm_GetParentID: Integer;
begin
 Result := f_ParentID;
end;

function Ta2RepositionContainer.pm_GetProfile: Ia2Profile;
begin
 Result := f_Profile;
end;

end.
