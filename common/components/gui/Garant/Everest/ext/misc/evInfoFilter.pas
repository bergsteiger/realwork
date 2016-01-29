unit evInfoFilter;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evInfoFilter - }
{ Начат: 10.01.2003 18:19 }
{ $Id: evInfoFilter.pas,v 1.5 2010/11/30 11:47:05 lulin Exp $ }

// $Log: evInfoFilter.pas,v $
// Revision 1.5  2010/11/30 11:47:05  lulin
// {RequestLink:228688602}.
// - борьба с предупреждениями.
//
// Revision 1.4  2010/06/02 10:08:01  fireton
// - не удаляем лог между CloseStream/OpenStream
//
// Revision 1.3  2010/05/12 09:44:29  fireton
// - ReportDocID
//
// Revision 1.2  2004/06/02 14:45:51  law
// - rename method: Tk2BaseStackGenerator.Atom2String -> VariantAsString.
// - сделан фильтр для сбора информации о документах со строками в кодировке _1252.
//
// Revision 1.1  2003/01/10 15:41:44  law
// - new unit: evInfoFilter.
//

{$I evDefine.inc }

interface

uses
  l3Types,
  l3Base,
  l3Filer,
  
  k2StackGenerator
  ;

type
  TevInfoFilter = class(Tk2CustomStackGeneratorExEx)
    private
      f_IsNew: Boolean;
    // internal fields
      f_Name  : String;
    protected
    // internal fields
      f_Filer : Tl3DOSFiler;
    protected
    // internal methods
      procedure OpenStream;
        override;
        {-}
      procedure CloseStream(NeedUndo: Bool);
        override;
        {-}
    public
    // public methods
      constructor Create(const aName: String = '');
        reintroduce;
        {-}
  end;//TevInfoFilter

  TevInfoFilterEx = class(TevInfoFilter)
    protected
    // internal fields
      f_WasOut : Bool;
    protected
    // property methods
      procedure pm_SetDocID(aValue: Long);
        override;
        {-}
      procedure ReportDocID;
        {-}
  end;//TevInfoFilterEx

implementation
uses
 SysUtils;

// start class TevInfoFilter

constructor TevInfoFilter.Create(const aName: String = '');
  //reintroduce;
  {-}
begin
 inherited Create;
 if (aName = '') then
  f_Name := ClassName + '.log'
 else
  f_Name := aName;
 f_IsNew := True; 
end;

procedure TevInfoFilter.OpenStream;
  //override;
  {-}
var
 l_FMode: Tl3FileMode;
begin
 inherited;
 if f_IsNew then
 begin
  l_FMode := l3_fmWrite;
  f_IsNew := False;
 end
 else
  l_FMode := l3_fmAppend;
 f_Filer := Tl3DOSFiler.Make(f_Name, l_FMode);
 f_Filer.Open;
end;

procedure TevInfoFilter.CloseStream(NeedUndo: Bool);
  //override;
  {-}
begin
 f_Filer.Close;
 l3Free(f_Filer);
 inherited;
end;

// start class TevInfoFilterEx

procedure TevInfoFilterEx.pm_SetDocID(aValue: Long);
  //override;
  {-}
begin
 inherited;
 f_WasOut := False;
end;

procedure TevInfoFilterEx.ReportDocID;
begin
 f_Filer.WriteLn(Format('%d', [DocID]));
 f_WasOut := True;
end;

end.

