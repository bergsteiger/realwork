unit vtColorBoxStringsItemNode;

{ $Id: vtColorBoxStringsItemNode.pas,v 1.4 2009/03/18 10:14:30 oman Exp $ }

// $Log: vtColorBoxStringsItemNode.pas,v $
// Revision 1.4  2009/03/18 10:14:30  oman
// - fix: Поддержка стилы cbNoNames (К-137463980)
//
// Revision 1.3  2009/03/17 15:05:27  oman
// - fix: Пытаемся рисовать (К-137463980)
//
// Revision 1.2  2009/03/17 13:48:47  oman
// - fix: Заготовки для отрисовки (К-137463980)
//
// Revision 1.1  2009/03/17 07:32:22  oman
// - fix: Заготовки контрола (К-137463980)
//
//

{$Include vtDefine.inc}

interface

uses
 l3InternalInterfaces,
 l3IID,

 ComboBoxStrings,
 ctComboBoxStringsItemNode
 ;

type
 TvtColorBoxStringsItemNode = class(TctComboBoxStringsItemNode)
 public
  constructor Create(aStrings: TComboBoxStrings; anIndex: Integer); override;
  function COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult; override;
 end;//TvtColorBoxStringsItemNode

implementation

uses
 Graphics,

 l3Interfaces,
 l3Base,

 vtColorBoxStrings,
 vtColorBoxNodePainter
 ;

{ TvtColorBoxStringsItemNode }

function TvtColorBoxStringsItemNode.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
var
 l_Color: TColor;
 l_Text: Il3CString;
begin
 if IID.EQ(Il3NodePainter) then
 begin
  Result.SetOk;
  with Strings.Items[pm_GetIndexInParent] do
  begin
   l_Color := TColor(LinkedObject);
   l_Text := l3CStr(AsWStr);
  end;
  if l_Color = clDefault then
    l_Color := TvtColorBoxStrings(Strings).DefaultColorColor
  else if l_Color = clNone then
    l_Color := TvtColorBoxStrings(Strings).NoneColorColor;
  Il3NodePainter(Obj) := TvtColorBoxNodePainter.Make(l_Text, l_Color, TvtColorBoxStrings(Strings).DrawNames);
 end
 else
  Result := inherited COMQueryInterface(IID, Obj);
end;

constructor TvtColorBoxStringsItemNode.Create(aStrings: TComboBoxStrings;
  anIndex: Integer);
begin
 inherited Create(aStrings, anIndex);
 Assert(aStrings is TvtColorBoxStrings);
end;

end.