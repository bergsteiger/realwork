unit evCommentParaHotSpotTester;

{ Библиотека "Эверест"    }
{ Начал: Люлин А.В.       }
{ Модуль: evCommentParaHotSpot - }
{ Начат: 11.11.2004 14:06 }
{ $Id: evCommentParaHotSpotTester.pas,v 1.1 2014/07/25 12:39:52 lulin Exp $ }

// $Log: evCommentParaHotSpotTester.pas,v $
// Revision 1.1  2014/07/25 12:39:52  lulin
// - готовимся к рисованию фабрик.
//
// Revision 1.12  2012/04/24 09:49:13  dinishev
// {Requestlink:360025064}
//
// Revision 1.11  2010/03/02 13:34:35  lulin
// {RequestLink:193823544}.
//
// Revision 1.10  2010/03/01 17:08:23  lulin
// {RequestLink:193823544}.
//
// Revision 1.9  2009/07/10 16:15:41  lulin
// - избавляемся от лишнего дёрганья счётчиков ссылок.
//
// Revision 1.8  2009/06/01 09:28:16  lulin
// [$148572882].
//
// Revision 1.7  2007/12/04 12:46:59  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.4.8.6  2007/09/14 13:26:04  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.4.8.5.2.1  2007/09/12 15:23:00  lulin
// - избавляемся от метода, дублирующего функциональность получения атрибута.
//
// Revision 1.4.8.5  2007/02/12 16:40:19  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.4.8.4  2007/01/24 10:21:42  oman
// - new: Локализация библиотек - ev (cq24078)
//
// Revision 1.4.8.3  2007/01/05 14:37:18  lulin
// - cleanup.
//
// Revision 1.4.8.2  2006/11/03 11:00:03  lulin
// - объединил с веткой 6.4.
//
// Revision 1.4.8.1.24.1  2006/10/20 07:17:07  lulin
// - избавляемся от опроса состояния клавиатуры.
//
// Revision 1.4.8.1  2005/06/14 10:01:30  lulin
// - избавился от передачи безликого интерфейса (теперь передается View).
//
// Revision 1.4  2005/03/24 12:08:12  lulin
// - remove method: Ik2TagBox._Tag.
// - new method: Ik2TagBox._Target.
//
// Revision 1.3  2005/03/19 16:39:50  lulin
// - спрятаны ненужные методы.
//
// Revision 1.2  2004/12/24 12:53:42  lulin
// - изменен дизайн пользовательских комментариев.
//
// Revision 1.1  2004/11/11 11:56:44  lulin
// - new behavior: для блока с комментарием теперь всегда сделана возможность сворачивать/разворачивать его при помощи мыши.
//

{$Include evDefine.inc }

interface

uses
  l3Interfaces,
  
  afwInterfaces,

  evDocumentPartHotSpotTester,

  nevTools
  ;

type
  TevCommentParaHotSpotTester = class(TevDocumentPartHotSpotTester)
    protected
    //internal methods
      function  GetHintPrefix(const aState : TafwCursorState): Il3CString;
        override;
        {-}
    public
    //public methods
      function  ShowParts(const aView: InevControlView): Boolean;
        override;
        {-}
  end;//TevCommentParaHotSpotTester

implementation

uses
  k2Tags,
  k2Base,
  
  evInternalInterfaces,

  nevInterfaces,
  nevGUIInterfaces
  ;

// start class TevCommentParaHotSpotTester

function TevCommentParaHotSpotTester.ShowParts(const aView: InevControlView): Boolean;
  //override;
  {-}
begin
 {$IfDef evCommentParaHasPlus}
 Result := true;
 // - всегда рисуем рамку вокруг блока с комментарием
 {$Else  evCommentParaHasPlus}
 Result := false;
 {$EndIf evCommentParaHasPlus}
end;

function TevCommentParaHotSpotTester.GetHintPrefix(const aState : TafwCursorState): Il3CString;
  //virtual;
  {-}
begin
 Result := nil;
 Case Area of
  ev_oaCollapse   :
   if GetRedirect.BoolA[k2_tiCollapsed] then
    Result := str_nevcphExpand.AsCStr
   else
    Result := str_nevcphCollapse.AsCStr;
  ev_oaLeftEdge   :
   Result := str_nevcphSelect.AsCStr;
  ev_oaProperties :
  begin
(*   if (ssCtrl in aState.rKeys) then
    Result := nevIntegerMapManager.Map[imap_nev_CommentParaHint].ValueToDisplayName(ord(nev_cphMove))
   else
   if (ssShift in aState.rKeys) then
    Result := nevIntegerMapManager.Map[imap_nev_CommentParaHint].ValueToDisplayName(ord(nev_cphChangeTopBorder))
   else*)
    Result := str_nevcphProperties.AsCStr;
  end;//ev_oaProperties
(*  ev_oaBottomEdge :
   if (ssShift in aState.rKeys) then
    Result := nevIntegerMapManager.Map[imap_nev_CommentParaHint].ValueToDisplayName(ord(nev_cphChangeBottomBorder))
   else
    Exit;*)
  else
   Exit;
 end;//Case Area
end;

end.

