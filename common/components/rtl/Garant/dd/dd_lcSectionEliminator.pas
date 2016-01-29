unit dd_lcSectionEliminator;
{ Удаляет псевдономера страниц из текста судебных постановлений }
// $Id: dd_lcSectionEliminator.pas,v 1.12 2013/10/21 17:31:11 lulin Exp $

// $Log: dd_lcSectionEliminator.pas,v $
// Revision 1.12  2013/10/21 17:31:11  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.11  2013/10/21 15:43:16  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.10  2013/10/21 10:31:05  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.9  2013/10/18 14:11:37  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.8  2013/04/11 16:46:29  lulin
// - отлаживаем под XE3.
//
// Revision 1.7  2013/03/28 10:21:09  narry
// Удаляет не только разрывы разделов, но и разрывы страниц
//


interface

uses
 k2Interfaces, ddTypes, DT_Types, l3Types, k2Types,
 k2TagFilter,

 k2Base
 ;

type
 Tdd_lcSectionEliminator = class(Tk2TagFilter)
 private
  f_OnError: TddErrorEvent;
  f_SectionCount: Integer;
 protected
  procedure DoStartChild(TypeID: Tk2Type); override;
    // internal methods
  function NeedTranslateChildToNext: Boolean; override;
 public
  procedure CloseStructure(NeedUndo: Boolean); override;
  property OnError: TddErrorEvent read f_OnError write f_OnError;
 end;

implementation

uses
 l3Base, l3String, k2Tags,
 SectionBreak_Const, Document_Const, SysUtils, PageBreak_Const;

procedure Tdd_lcSectionEliminator.CloseStructure(NeedUndo: Boolean);
var
 l_Msg: AnsiString;
begin
 if CurrentType.IsKindOf(k2_typDocument) and (f_sectionCount > 0) then
 begin
  l_Msg:= Format('Удалено разрывов разделов - %d. Возможно, остались номера страниц.', [f_SectionCount]);
  if Assigned(f_OnError) then
   f_OnError(l_Msg)
  else
   l3System.Msg2Log(l_Msg);
 end;
 inherited;
end;

procedure Tdd_lcSectionEliminator.DoStartChild(TypeID: Tk2Type);
begin
 inherited;
 if CurrentType.IsKindOf(k2_typDocument) then
  f_SectionCount:= 0;
end;


function Tdd_lcSectionEliminator.NeedTranslateChildToNext: Boolean;
begin
 with CurrentType do
  Result := not IsKindOf([k2_typSectionBreak, k2_typPageBreak]);
 if not Result then
  Inc(f_SectionCount);
end;

end.
