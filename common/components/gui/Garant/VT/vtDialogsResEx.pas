unit vtDialogsResEx;

{ Библиотека "VT"         }
{ Начал: Люлин А.В.       }
{ Модуль: vtDialogsResEx - }
{ Начат: 04.04.2011 19:08 }
{ $Id: vtDialogsResEx.pas,v 1.5 2015/10/14 11:30:38 lulin Exp $ }

// $Log: vtDialogsResEx.pas,v $
// Revision 1.5  2015/10/14 11:30:38  lulin
// - не падаем на выходе из Эвереста.
//
// Revision 1.4  2013/04/05 12:02:45  lulin
// - портируем.
//
// Revision 1.3  2012/05/28 08:59:41  lulin
// {RequestLink:290264810}
//
// Revision 1.2  2011/04/28 12:53:33  lulin
// {RequestLink:259892768}.
// - делаем тест модификации списка.
//
// Revision 1.1  2011/04/04 16:04:02  lulin
// {RequestLink:259175088}.
//

{$I vtDefine.inc }

interface

uses
  Controls,
  
  Dialogs,

  l3Interfaces
  ;

function vtGetDlgBtnCaption(aBtn: TMsgDlgBtn): Il3CString;
  {-}
function vtGetDlgBtnResult(aBtn: TMsgDlgBtn): TModalResult;
  {-}
function vtGetDlgResultBtn(aBtn: TModalResult): TMsgDlgBtn;
  {-}
function vtGetDlgCaption(aType : TMsgDlgType): String;
  {-}

implementation

uses
  l3StringIDEx,
  l3ConstStrings,

  afwInterfaces,
  afwFacade,

  vtDialogsRes
  ;

const
 cButtonCaptions : array [TMsgDlgBtn] of Pl3StringIDEx =(
   @str_vtMsgDlgYes,
   @str_vtMsgDlgNo,
   @str_vtMsgDlgOK,
   @str_vtMsgDlgCancel,
   @str_vtMsgDlgAbort,
   @str_vtMsgDlgRetry,
   @str_vtMsgDlgIgnore,
   @str_vtMsgDlgAll,
   @str_vtMsgDlgNoToAll,
   @str_vtMsgDlgYesToAll,
   @str_vtMsgDlgHelp
   {$IfDef XE}
   , nil
   {$EndIf}
   );

function vtGetDlgBtnCaption(aBtn: TMsgDlgBtn): Il3CString;
begin
 if not str_vtMsgDlgYes.rLocalized then
 // http://mdp.garant.ru/pages/viewpage.action?pageId=290264810
  if (afw.Application <> nil) then
   if (afw.Application.LocaleInfo <> nil) then
    if (afw.Application.LocaleInfo.Language <> afw_lngRussian) then
     afw.Application.ApplyActiveLanguage(Tl3ConstStrings.Instance);
 Result := cButtonCaptions[aBtn].AsCStr;
end;

const
 cModalResults: array[TMsgDlgBtn] of Integer = (
   mrYes, mrNo, mrOk, mrCancel, mrAbort, mrRetry, mrIgnore, mrAll, mrNoToAll,
   mrYesToAll, 0{$IfDef XE}, 0{$EndIf});

function vtGetDlgBtnResult(aBtn: TMsgDlgBtn): TModalResult;
begin
 Result := cModalResults[aBtn];
end;

function vtGetDlgResultBtn(aBtn: TModalResult): TMsgDlgBtn;
  {-}
var
 l_Index : TMsgDlgBtn;
begin
 for l_Index := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
  if (cModalResults[l_Index] = aBtn) then
  begin
   Result := l_Index;
   Exit;
  end;//cModalResults[l_Index] = aBtn
 Result := mbHelp;
 Assert(false); 
end;

const
  imap_vt_DislogCaptions : array [TMsgDlgType] of Pl3StringIDEx = (
   @str_vtMsgDlgWarning,
   @str_vtMsgDlgError,
   @str_vtMsgDlgInformation,
   @str_vtMsgDlgConfirm,
   @str_vtMsgDlgCustom
  );

function vtGetDlgCaption(aType : TMsgDlgType): String;
begin
 Result := imap_vt_DislogCaptions[aType].AsStr;
end;

end.

