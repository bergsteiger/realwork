unit l3Forms;
{* ������� ����� ����, �������������� ������� ������ � ��������� IUnknown. }

{ ���������� "�������"    }
{ �����: ����� �.�. �     }
{ ������: evForms -       }
{ �����: 02.12.1999 12:23 }
{ $Id: l3Forms.pas,v 1.25 2015/01/15 13:50:25 lulin Exp $ }

// $Log: l3Forms.pas,v $
// Revision 1.25  2015/01/15 13:50:25  lulin
// {RequestLink:585926571}. ���������� Interlocked.
//
// Revision 1.24  2014/07/30 12:27:51  lulin
// - ������ ���.
//
// Revision 1.23  2014/07/16 15:56:57  lulin
// - ������ ��� � �������� ������������.
//
// Revision 1.22  2012/08/22 11:14:57  dinishev
// ����������, �.�. �������� �������� vtForm, ������� ��� ��� ������� - ����� ���������� �� vtFrom
//
// Revision 1.21  2012/08/22 08:33:07  dinishev
// ���������� Tl3Form � ��� ����������� ��� ������ � ������� � ��������� ������.
//
// Revision 1.20  2009/01/23 09:48:48  lulin
// - bug fix: �� ���������� ����������.
//
// Revision 1.19  2008/12/12 19:19:30  lulin
// - <K>: 129762414.
//
// Revision 1.18  2008/02/14 19:32:40  lulin
// - �������� ����� ������ � ���������.
//
// Revision 1.17  2008/02/14 14:12:25  lulin
// - <K>: 83920106.
//
// Revision 1.16  2008/02/07 08:37:59  lulin
// - ������� �������� ������� �� ������������ ������.
//
// Revision 1.15  2008/01/25 12:06:59  lulin
// - �������������� ����� � �������.
//
// Revision 1.14  2008/01/25 11:32:14  lulin
// - �������������� ����� � �������.
//
// Revision 1.13  2007/11/14 17:29:35  voba
// - bug fix �������� ����� ����������� �� ����������
//
// Revision 1.12  2007/08/13 17:23:34  lulin
// - cleanup.
//
// Revision 1.11  2007/01/18 10:49:42  lulin
// - �������� ������ ��������� ������ �� ���������.
//
// Revision 1.10  2006/12/10 19:03:40  lulin
// - cleanup.
//
// Revision 1.9  2006/12/10 18:59:06  lulin
// - ����� ����� ������������ � ������������ � �����������.
//
// Revision 1.8  2006/12/10 18:53:33  lulin
// - ���������� ����� ����� ���������� ����� ��� ������ ��������� ����.
//
// Revision 1.7  2006/12/10 18:27:07  lulin
// - ����������� ��������� ��������: �� ������������ ������ ��� ����� ��� ��������� ������ ����.
//
// Revision 1.6  2006/12/08 14:21:08  lulin
// - ������� ������������ ���������� ���, ��� ����� ��� ������ ��������.
//
// Revision 1.5  2006/04/14 13:40:33  lulin
// - ��������� ����������� ����������.
//
// Revision 1.4  2006/04/14 12:11:25  lulin
// - ����� � �������� ���� ����� ���������� ��������.
//
// Revision 1.3  2006/04/14 11:53:13  lulin
// - ��������� ��������� � ���������� _Unknown_ � ���� ����.
//
// Revision 1.2  2005/10/06 13:49:43  lulin
// - cleanup.
//
// Revision 1.1  2005/07/22 13:03:03  lulin
// - ������ � �������� ������� �������� � ���������� L3.
//
// Revision 1.19  2004/09/16 11:30:50  lulin
// - ����� ������� ������� � ������������ ��������� ����������.
//
// Revision 1.18  2004/09/16 09:24:59  lulin
// - bug fix: ���������� �� evCtrl ��������� � DesignTime ������������ �������.
//
// Revision 1.17  2004/09/15 16:20:37  lulin
// - bug fix: AllEverestComponents7 �� ��������� ��-�� Str_Man'�.
// - bug fix: AllEverestComponents7 �� ���������� ��-�� ��������.
//
// Revision 1.16  2004/09/15 14:49:02  lulin
// - Tl3Form ��������� �� "������" l3Unknown.
//
// Revision 1.15  2004/09/13 07:32:58  lulin
// - new behavior: _Tl3InterfacedComponent ������ ����� ������������ ���� ������ � ���� ��������.
//
// Revision 1.14  2004/09/08 11:22:31  lulin
// - new define: _l3NoTrace.
// - new define: l3TraceObjects.
//
// Revision 1.13  2004/07/21 13:53:39  am
// change: Create -> CreateNew (��� ����������� �������� ���� ��� ��������)
//
// Revision 1.12  2004/06/25 16:47:21  migel
// - change/fix: ��� ������������� � win9x ������� �� ����������� ���������� `Interlocked*` �������.
//
// Revision 1.11  2004/06/03 16:54:42  law
// - new method: Il3Base.CheckStamp.
//
// Revision 1.10  2004/04/15 11:34:34  law
// - bug fix: Inc/Dec �������� �� InterlockedIncrement/InterlockedDecrement.
//
// Revision 1.9  2004/04/09 11:50:46  law
// - new behavior: ��������� �������� �� Tl3Form.
//
// Revision 1.8  2003/11/30 11:39:38  law
// - new behavior: �������������� ���� ���������������� ��������.
//
// Revision 1.7  2003/02/26 18:11:06  law
// - new method: AfterFree.
//
// Revision 1.6  2001/10/02 12:23:21  law
// - new method: BeforeRelease.
//
// Revision 1.5  2001/09/04 16:47:26  law
// - comments: xHelpGen.
//
// Revision 1.4  2000/12/15 15:10:35  law
// - ��������� ��������� Log.
//

{$Include l3Define.inc }

interface

uses
  {$IfNDef DesignTimeLibrary}
  Messages,
  {$EndIf  DesignTimeLibrary}
  Windows,

  {$IfNDef DesignTimeLibrary}
  Graphics,
  {$EndIf  DesignTimeLibrary}

  Classes,
  Forms,
  
  l3Types,
  l3Const,
  l3Base,
  l3IID
  ;

type
  _l3Unknown_Parent_ = TForm;
  {$Define _UnknownIsComponent}
  {$Include l3Unknown.imp.pas}
  Tl3Form = class(_l3Unknown_)
   {* ������� ����� ����, �������������� ������� ������ � ��������� IUnknown. }
    private
    // internal fields
      {$IfNDef DesignTimeLibrary}
      f_Canvas : TCanvas;
      {$EndIf  DesignTimeLibrary}
    protected
    // internal methods
      // Il3Base
      {$IfDef DesignTimeLibrary}
      function CheckStamp(const aGUID: TGUID): Boolean;
        {-}
      {$EndIf DesignTimeLibrary}
      {$IfNDef DesignTimeLibrary}
      procedure WndProc(var Message: TMessage);
        override;
        {-}
      {$EndIf  DesignTimeLibrary}
      {$Include l3DefineCleanup.inc}
    public
    // public methods
    function  QueryInterface(const IID: TGUID; out Obj): HResult;
      override;
      {* - ���������� ������ QueryInterface ���������� IUnknown. }
    function  COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
      virtual;
      {* - ����� ��� ���������� QueryInterface (��� ���������� � ��������). }
  end;//Tl3Form

implementation

uses
  SysUtils,

  {$IfNDef DesignTimeLibrary}
  Menus,
  {$EndIf  DesignTimeLibrary}

  l3Interfaces,
  l3Interlocked
  ;

{$Include l3Unknown.imp.pas}

// start class Tl3Form

type
 _Unknown_Child_ = Tl3Form;
{$Include l3ImplCleanup.inc}
begin
 {$IfNDef DesignTimeLibrary}
 l3Free(f_Canvas);
 {$EndIf  DesignTimeLibrary}
 inherited;
end;

function Tl3Form.QueryInterface(const IID: TGUID; out Obj): HResult;
  {override;}
  {-}
var
 l_Res : Tl3HResult;  
begin
 l_Res := COMQueryInterface(Tl3GUID_C(IID), Obj);
 if l_Res.Fail then
  Result := inherited QueryInterface(IID, Obj)
 else
  Result := l_Res.Res; 
end;

function Tl3Form.COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
  {virtual;}
  {-}
begin
 if TObject(Self).GetInterface(IID.IID, Obj) then
  Result.SetOk
 else
 begin
  Pointer(Obj) := nil;
  Result.SetNOINTERFACE;
 end;//TObject(Self).GetInterface(IID.IID, Obj)
end;

{$IfDef DesignTimeLibrary}
function Tl3Form.CheckStamp(const aGUID: TGUID): Boolean;
  {-}
begin
 if l3SystemDown then
  Result := false
 else
  Result := IsEqualGUID(l3System.GetStamp, aGUID);
end;
{$EndIf DesignTimeLibrary}

{$IfNDef DesignTimeLibrary}
type
  TMenuItemAccess = class(TMenuItem);

procedure Tl3Form.WndProc(var Message: TMessage);
  //override;
  {-}
var
  SaveIndex : Integer;
  MenuItem  : TMenuItem;
  DC        : HDC;
begin
  with Message do
    case Msg of
      WM_DRAWITEM:
       if (Message.wParam = 0) then {V - WM_DRAWITEM �������� �� ������ Menu, Message.wParam = 0 ��� ����� ����}
        with PDrawItemStruct(Message.LParam)^ do
          if (CtlType = ODT_MENU) and Assigned(Menu) then
          begin
            MenuItem := Menu.FindItem(itemID, fkCommand);
            if (MenuItem <> nil) then
            begin
              if (f_Canvas = nil) then
               f_Canvas := TCanvas.Create;
              with f_Canvas do
              try
                SaveIndex := SaveDC(hDC);
                try
                  Handle := hDC;
                  Font := Screen.MenuFont;
                  Menus.DrawMenuItem(MenuItem, f_Canvas, rcItem,
                    TOwnerDrawState(LongRec(itemState).Lo));
                finally
                  Handle := 0;
                  RestoreDC(hDC, SaveIndex)
                end;
              finally
                //Free;
              end;//try..finally
              Exit;
            end;//MenuItem <> nil
          end;//CtlType = ODT_MENU..
      WM_MEASUREITEM:
       if (Message.wParam = 0) then {V - WM_DRAWITEM �������� �� ������ Menu, Message.wParam = 0 ��� ����� ����}
        with PMeasureItemStruct(Message.LParam)^ do
          if (CtlType = ODT_MENU) and Assigned(Menu) then
          begin
            MenuItem := Menu.FindItem(itemID, fkCommand);
            if (MenuItem <> nil) then
            begin
              DC := GetWindowDC(Handle);
              try
                if (f_Canvas = nil) then
                 f_Canvas := TCanvas.Create;
                with f_Canvas do
                try
                  SaveIndex := SaveDC(DC);
                  try
                    Handle := DC;
                    Font := Screen.MenuFont;
                    TMenuItemAccess(MenuItem).MeasureItem(f_Canvas,
                      Integer(itemWidth), Integer(itemHeight));
                  finally
                    Handle := 0;
                    RestoreDC(DC, SaveIndex);
                  end;
                finally
                  //f_Canvas.Free;
                end;//try..finally
              finally
                ReleaseDC(Handle, DC);
              end;//try..finally
              Exit;
            end;//MenuItem <> nil
          end;//CtlType = ODT_MENU..
    end;//case Msg of
 inherited;
end;
{$EndIf  DesignTimeLibrary}

end.

