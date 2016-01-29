unit evAbortFilter;

{ Библиотека "Эверест"    }
{ Начал: Лукьянец Р.В.       }
{ Модуль: evAbortFilter - }
{ Начат: 17.09.2007 15:46 }
{ $Id: evAbortFilter.pas,v 1.5 2014/03/27 14:19:58 lulin Exp $ }

// $Log: evAbortFilter.pas,v $
// Revision 1.5  2014/03/27 14:19:58  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.4  2013/10/18 14:11:22  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.3  2010/04/14 16:34:33  lulin
// {RequestLink:191730233}.
//
// Revision 1.2  2007/12/04 12:46:58  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.1.2.1  2007/09/18 12:45:52  oman
// - new: Учимся прерывать перемывку текста для превью (cq25478)
//

{$Include evDefine.inc }

interface

uses
 l3Types,
 l3Variant,

 k2Prim,
 k2TagFilter,

 afwinterfaces
 ;

type
 TevAbortFilter = class(Tk2TagFilter, IafwAbortableProcess)
 protected
  // IafwAbortableProcess
  procedure IafwAbortableProcess.Abort = IafwAbortableProcess_Abort;
  procedure IafwAbortableProcess_Abort;
 private
  f_LastChecked: Cardinal;
  f_Aborted: Boolean;
  f_Rised: Boolean;
 private
  function IsAborted: Boolean;
   {-}
 protected
      function  NeedsCheckBrackets: Boolean;
   override;
        {-}
  procedure CloseStructure(NeedUndo: Boolean);
   override;
    {-}
 public
  procedure StartTag(TagID: Long);
   override;
    {-}
  procedure StartChild(TypeID: Tl3VariantDef);
   override;
    {-}
 end;//TevAbortFilter

implementation

uses
 Windows,

 l3Except,

 afwFacade
 ;

const
 cTimeOut = 40;

{ TevAbortFilter }

function TevAbortFilter.IsAborted: Boolean;
begin
 Result := f_Aborted;
 if f_Aborted and not f_Rised then
 begin
  f_Rised := True;
  raise El3AbortLoad.Create('');
 end;
 if not f_Aborted and ((GetTickCount - f_LastChecked) > cTimeOut) then
 begin
  afw.ProcessMessages;
  f_LastChecked := GetTickCount;
 end;
end;

function TevAbortFilter.NeedsCheckBrackets: Boolean;
  {-}
begin
 Result := false;
end;

procedure TevAbortFilter.CloseStructure(NeedUndo: Boolean);
begin
 if not IsAborted then
  inherited CloseStructure(NeedUndo)
{ else
  inherited CloseStructure(true)};
end;

procedure TevAbortFilter.IafwAbortableProcess_Abort;
begin
 f_Aborted := True;
end;

procedure TevAbortFilter.StartChild(TypeID: Tl3VariantDef);
begin
 if not IsAborted then
  inherited StartChild(TypeID);
end;

procedure TevAbortFilter.StartTag(TagID: Long);
begin
 if not IsAborted then
  inherited StartTag(TagID);
end;

end.

