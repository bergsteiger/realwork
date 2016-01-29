unit evConvertTextTools;

{ ���������� "�������"    }
{ �����: ����� �.�.       }
{ ������: evConvertTextTools- }
{ �����: 19.07.2005 11:06 }
{ $Id: evConvertTextTools.pas,v 1.17 2014/04/30 11:23:52 lulin Exp $ }

// $Log: evConvertTextTools.pas,v $
// Revision 1.17  2014/04/30 11:23:52  lulin
// - ���������� �����������.
//
// Revision 1.16  2014/04/10 16:32:21  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.15  2014/03/21 16:24:50  lulin
// - ������������� ������ � ������.
//
// Revision 1.14  2013/04/04 11:18:51  lulin
// - ���������.
//
// Revision 1.13  2010/06/24 11:45:16  lulin
// {RequestLink:219123904}.
//
// Revision 1.12  2009/07/11 09:24:41  lulin
// - ����������� �� ������� ������� ��������� ������.
//
// Revision 1.11  2009/07/08 15:51:58  lulin
// {RequestLink:141264340}. �7.
//
// Revision 1.10  2009/04/09 14:12:36  lulin
// [$140837386]. �15.
//
// Revision 1.9  2009/03/31 12:04:35  lulin
// [$140286997].
//
// Revision 1.8  2008/05/08 16:10:54  lulin
// - ��������� � ������ <K>: 90442475.
//
// Revision 1.7  2008/05/07 18:29:48  lulin
// - ��������� � ������ <K>: 90441963.
//
// Revision 1.6  2008/04/10 17:34:24  lulin
// - <K>: 89097983.
//
// Revision 1.5  2008/04/09 17:57:07  lulin
// - ������� ��� � ������ <K>: 89096854.
//
// Revision 1.4  2008/03/28 10:33:04  dinishev
// Bug fix: �������� ��������������� ��� �������� � ����� Everest
//
// Revision 1.3  2008/03/03 20:05:45  lulin
// - <K>: 85721135.
//
// Revision 1.2  2007/12/04 12:47:00  lulin
// - ������������� ����� � HEAD.
//
// Revision 1.1.2.7  2007/09/14 13:26:04  lulin
// - ��������� � ������ B_Tag_Clean.
//
// Revision 1.1.2.6.12.1  2007/09/12 15:23:00  lulin
// - ����������� �� ������, ������������ ���������������� ��������� ��������.
//
// Revision 1.1.2.6  2006/08/02 10:51:52  lulin
// - ��������� � ������ � ������� ������� �� �����������.
//
// Revision 1.1.2.5.16.1  2006/07/28 14:11:13  lulin
// - ������ ������� ������������������ ���������.
//
// Revision 1.1.2.5  2005/11/05 07:33:33  lulin
// - cleanup: ������ �������� �������������� ������� � ���������.
//
// Revision 1.1.2.4  2005/11/04 11:22:09  lulin
// - cleanup: � ��������� ����� ����� ������������������ - �� �������� ������ �� ����� ����������� �������.
//
// Revision 1.1.2.3  2005/09/23 16:03:54  lulin
// - ������� ������ � ������ ������������.
//
// Revision 1.1.2.2  2005/08/31 08:39:23  lulin
// - cleanup: ������ �������� ���������� �����.
//
// Revision 1.1.2.1  2005/07/19 08:25:03  lulin
// - ��������� �� ������� ��������� ��� ����������� ������ ��������� - ������� ����������� �� ����� �������� Search/_Replace.
//

{$Include evDefine.inc }

interface

uses
  l3Types,
  
  evTypes,
  evInternalInterfaces,
  evSearch,

  nevBase,
  nevTools
  ;

type
  TevInPlaceTextConverter = class(TevBaseReplacer)
    private
    // internal fields
      f_OnConvert : TevTextConvertEvent;
    protected
    // internal methods
      function ReplaceFunc(const aView : InevView;
                           const anOp   : InevOp;
                           const aBlock : InevRange): Boolean;
        override;
        {-}
    public
    // public methods
      class function Make(anOnConvert : TevTextConvertEvent;
                          anOptions   : TevSearchOptionSet = []): IevReplacer;
        reintroduce;
        {-}
  end;//TevInPlaceTextConverter

  TevTextConverter = class(TevBaseReplacer)
    private
    // internal fields
      f_OnConvert : TevTextBufConvertProc;
    protected
    // internal methods
      function ReplaceFunc(const aView : InevView;
                           const anOp   : InevOp;
                           const aBlock : InevRange): Boolean;
        override;
        {-}
    public
    // public methods
      class function Make(anOnConvert : TevTextBufConvertProc;
                          anOptions   : TevSearchOptionSet = []): IevReplacer;
        reintroduce;
        {-}
  end;//TevTextConverter

implementation

uses
  l3Base,
  l3String,

  k2Tags,

  evParaTools,
  evTextParaOpEx
  ;

// start class TevInPlaceTextConverter

class function TevInPlaceTextConverter.Make(anOnConvert : TevTextConvertEvent;
                                            anOptions   : TevSearchOptionSet = []): IevReplacer;
  //reintroduce;
  {-}
var
 l_Replacer : TevInPlaceTextConverter;
begin
 Assert(Assigned(anOnConvert));
 l_Replacer := Create;
 try
  l_Replacer.Options := anOptions;
  l_Replacer.f_OnConvert := anOnConvert;
  Result := l_Replacer;
 finally
  l3Free(l_Replacer);
 end;//try..finally
end;

function TevInPlaceTextConverter.ReplaceFunc(const aView : InevView;
                                             const anOp   : InevOp;
                                             const aBlock : InevRange): Boolean;
  //override;
  {-}
var
 l_TextPara  : InevObject;
 l_Text      : Tl3PCharLen;
 l_TextStart : PAnsiChar;
 l_OS        : Tl3String;
 l_B         : TevPair;
begin
 Result := true;
 // - ����� ��-������ ���� ����������
 l_TextPara := aBlock.Obj^;
 l_B := aBlock.Borders;
 if (l_B.Len > 0) then
 begin
  l_Text := l_TextPara.AsObject.PCharLenA[k2_tiText];
  if not l3IsNil(l_Text) then
  begin
   l_TextStart := l_Text.S + l_B.rStart;
   l_OS := Tl3String.Make(l3PCharLen(l_TextStart, l_B.Len, l_Text.SCodePage));
   try
    if (f_OnConvert(Self, l_TextStart, l_OS.Len, l_Text.SCodePage)) then
    begin
     l_TextPara.Invalidate([nev_spExtent]);
     OevTextConvert.ToUndo(anOp,
                           l_TextPara.AsObject,
                           l_B.rStart,
                           l_OS.AsPCharLen,
                           l3PCharLen(l_TextStart, l_OS.Len, l_Text.SCodePage));
     anOp.MarkModified(l_TextPara.AsObject);
     // - ������� ���� ����������� ������                      
    end;//f_OnConvert..
   finally
    l3Free(l_OS);
   end;//try..finally
  end;//not l3IsNil(l_Text)
 end;//l_B.Len > 0
end;

// start class TevTextConverter

class function TevTextConverter.Make(anOnConvert : TevTextBufConvertProc;
                                     anOptions   : TevSearchOptionSet = []): IevReplacer;
  //reintroduce;
  {-}
var
 l_Replacer : TevTextConverter;
begin
 Assert(Assigned(anOnConvert));
 l_Replacer := Create;
 try
  l_Replacer.Options := anOptions;
  l_Replacer.f_OnConvert := anOnConvert;
  Result := l_Replacer;
 finally
  l3Free(l_Replacer);
 end;//try..finally
end;

function TevTextConverter.ReplaceFunc(const aView : InevView;
                                      const anOp   : InevOp;
                                      const aBlock : InevRange): Boolean;
  //override;
  {-}
var
 l_S : Tl3PCharLen;
 l_B : TevPair;
begin
 Result := true;
 // - ����� ��-������ ���� ���������� 
 l_B := aBlock.Borders;
 if (l_B.Len > 0) then
 begin
  with aBlock.Obj.AsObject.PCharLenA[k2_tiText] do
   l_S.Init(S + l_B.rStart, l_B.Len, SCodePage);
  if not l3IsNil(l_S) then
  begin
   if f_OnConvert(l_S) then
   begin
    if (l_S.S <> nil) then
     aBlock.Text.Modify.InsertString(aView, l3CStr(l_S), anOp, true, [misfDirect]);
   end;//f_OnConvert(l_S)
  end;//not l3IsNil(l_S)
 end;//l_B.Len > 0..
end;
  
end.

