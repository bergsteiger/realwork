unit vtColorBoxStrings;

{ $Id: vtColorBoxStrings.pas,v 1.7 2012/10/26 17:15:07 lulin Exp $ }

// $Log: vtColorBoxStrings.pas,v $
// Revision 1.7  2012/10/26 17:15:07  lulin
// - вычищаем поддержку ветки редактора.
//
// Revision 1.6  2009/03/24 09:31:08  lulin
// - bug fix: не собирался Архивариус в ветке.
//
// Revision 1.5  2009/03/23 15:09:07  lulin
// [$139442655]. Переименовываем файл.
//
// Revision 1.4  2009/03/23 14:54:24  lulin
// [$139442655]. Переименовываем новый контрол.
//
// Revision 1.3  2009/03/18 10:14:30  oman
// - fix: Поддержка стилы cbNoNames (К-137463980)
//
// Revision 1.2  2009/03/17 15:05:27  oman
// - fix: Пытаемся рисовать (К-137463980)
//
// Revision 1.1  2009/03/17 07:32:22  oman
// - fix: Заготовки контрола (К-137463980)
//
//

{$Include vtDefine.inc}

interface

uses
 Graphics,
 
 l3TreeInterfaces,

 ctFakeBoxStrings
 ;

type
 TvtColorBoxStrings = class(TctFakeBoxStrings)
 protected
  function DoMakeChild: Il3SimpleNode; override;
    {* Создать первого ребенка }
 public
  function DefaultColorColor: TColor;
  function NoneColorColor: TColor;
  function DrawNames: Boolean;
 end;//TvtColorBoxStrings

implementation

uses
 vtColorBoxStringsItemNode,
 vtColorBox
 ;

{ TvtColorBoxStrings }

function TvtColorBoxStrings.DefaultColorColor: TColor;
begin
 Result := TvtColorBox(SubOwner).DefaultColorColor
end;

function TvtColorBoxStrings.DoMakeChild: Il3SimpleNode;
begin
 Result := TvtColorBoxStringsItemNode.Make(Self, 0);
end;

function TvtColorBoxStrings.DrawNames: Boolean;
begin
 Result := TvtColorBox(SubOwner).DrawNames
end;

function TvtColorBoxStrings.NoneColorColor: TColor;
begin
 Result := TvtColorBox(SubOwner).NoneColorColor
end;

end.
