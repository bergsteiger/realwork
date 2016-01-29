unit evReg;

{ ���������� ""         }
{ �����: ����� �.�.     }
{ ������: evReg - ������ ��� ����������� ���������� ���������}
{ �����: 20.03.97 18:59 }
{ $Id: evReg.pas,v 1.44 2015/04/24 14:54:16 lulin Exp $ }

// $Log: evReg.pas,v $
// Revision 1.44  2015/04/24 14:54:16  lulin
// - ���������� define.
//
// Revision 1.43  2009/07/24 08:04:15  oman
// �� ����������
//
// Revision 1.42  2008/04/02 14:22:01  lulin
// - cleanup.
//
// Revision 1.41  2007/12/04 12:47:04  lulin
// - ������������� ����� � HEAD.
//
// Revision 1.36.14.13  2007/09/20 16:17:28  lulin
// - cleanup.
//
// Revision 1.36.14.12  2007/03/06 12:31:46  lulin
// - ������� ����������� ��� ������� ���� �������� ��������� ������ ������.
//
// Revision 1.36.14.11  2007/03/06 12:08:43  lulin
// - ������� ����������� ��� ������� ���� �������� ��������� ������ ������.
//
// Revision 1.36.14.10  2007/03/06 11:59:03  lulin
// - ������� ����������� �������� ������ �� ������, � �� �������� ������ ������.
//
// Revision 1.36.14.9  2006/12/14 10:41:03  lulin
// - cleanup.
//
// Revision 1.36.14.8  2005/10/11 10:34:19  lulin
// - bug fix: �� ���������� ����������.
// - ������ _Preview ��������� � ���������� VT.
//
// Revision 1.36.14.7  2005/09/23 09:51:07  lulin
// - ����� ��������� ��������� � ����� �������.
//
// Revision 1.36.14.6  2005/08/30 13:54:04  lulin
// - new class: TevQueryCardEditor.
//
// Revision 1.36.14.5  2005/05/31 12:13:30  lulin
// - bug fix: �� �������������� ������� �����.
//
// Revision 1.36.14.4  2005/05/30 11:35:42  lulin
// - new unit: vtGroupBox.
//
// Revision 1.36.14.3  2005/05/30 09:55:56  lulin
// - ����� ��������� � ���������� VT.
//
// Revision 1.36.14.2  2005/05/24 08:48:30  lulin
// - bug fix: �� ���������������.
//
// Revision 1.36.14.1  2005/05/19 13:18:43  lulin
// - remove unit: evFont.
//
// Revision 1.36  2004/10/25 16:18:01  lulin
// - ��� ������ �� TeePreviewPanel ��������� � TevCustomPreviewPanel.
//
// Revision 1.35  2004/10/13 13:59:53  am
// change: TevGroupBox - ����� "���������" ������������ Caption ��� NT4.0
//
// Revision 1.34  2004/09/16 11:30:50  lulin
// - ����� ������� ������� � ������������ ��������� ����������.
//
// Revision 1.33  2004/06/30 12:16:03  mmorozov
// new: ����������� TevLabel;
//
// Revision 1.32  2004/05/14 16:27:59  law
// - remove class: TevTextObjectGenerator.
// - remove class: TevTextObjectParser.
//
// Revision 1.31  2004/05/14 16:07:56  law
// - new units: evFileGenerator, evPlainTextGenerator.
//
// Revision 1.30  2004/04/23 16:09:04  law
// - new unit: evEdit.
//
// Revision 1.29  2003/10/14 16:35:42  law
// - rename unit: evTxtSrc -> evTextSource.
//
// Revision 1.28  2003/10/13 15:31:11  law
// - rename unit: evEdWnd -> evEditorWindow.
//
// Revision 1.27  2003/02/13 12:27:31  law
// - cleanup: IevFont ������������ � _TevCustomFont, ����� �� ������ ��� � �����������.
//
// Revision 1.26  2002/10/01 08:51:28  narry
// no message
//
// Revision 1.25  2002/04/05 15:25:44  law
// - bug fix.
//
// Revision 1.24  2002/03/27 17:10:09  law
// - new unit: evLoadDocumentManager.
//
// Revision 1.23  2002/01/08 09:25:07  law
// - rename class: TevDOSFiler -> Tl3Filer.
//
// Revision 1.22  2001/12/18 14:06:34  law
// - new unit: evSaveDocumentManager.
//
// Revision 1.21  2001/11/20 10:21:11  law
// - cleanup.
//
// Revision 1.20  2001/10/23 09:02:47  law
// - new unit: evEvdReader.
//
// Revision 1.19  2001/10/19 16:20:22  law
// - new unit: evEvdWriter.
//
// Revision 1.18  2001/10/18 14:54:36  law
// - new unit: l3WindowsStorageFiler.
//
// Revision 1.17  2001/10/16 07:54:59  law
// - cleanup.
//
// Revision 1.16  2001/10/04 09:52:03  law
// - new behavior: ������� ����������� ����������� ��������� �������� �� ���������.
//
// Revision 1.15  2001/10/04 08:05:52  law
// - new behavior: ������� ����������� ����������� ��������� �������� �� ���������.
//
// Revision 1.14  2001/10/03 14:53:20  law
// - new unit: evAction.
//
// Revision 1.13  2001/08/30 16:34:02  law
// - new version: ���������� �� Delphi 6.
//
// Revision 1.12  2001/08/29 07:32:08  law
// - cleanup.
//
// Revision 1.11  2001/04/05 08:57:36  law
// - cleanup: ������������� ������� WinTypes � WinProcs ������� �� Windows.
//
// Revision 1.10  2001/03/11 13:00:05  voba
// �������� ����� TevHyperlinkReplacer
//
// Revision 1.9  2000/12/15 15:10:37  law
// - ��������� ��������� Log.
//

{$Include evDefine.inc }

interface

procedure Register;

implementation

uses
  Classes,
  {$IfDef Delphi6}
  DesignIntf,
  VCLEditors,
  {$Else   Delphi6}
  DsgnIntf,
  {$EndIf Delphi6}
  ActnList,
  ImgList,

  l3Types,
  l3Base,

  k2Base,

  evdSchema, // - ���������� ���������� ���������� EVD

  evTypes,
  evConst,
  evEditor,
  evQueryCardEditor,
  evRuler,
  evMemo,
  evEdit,
  evEditorWindow,
  evSubPn,

  evButton,
  evMenu,
  evOpProc,
  evCustomFont,

  evImageIndexProperty,
  
  vtPreviewPanel
  ;

{$R evReg.r32 }

type
  TevSubPanelImageIndexProperty = class(TevImageIndexProperty)
  protected
    function GetImages : TCustomImageList;
      override;
      {-}
  end;//TevSubPanelImageIndexProperty

function TevSubPanelImageIndexProperty.GetImages : TCustomImageList;
  //override;
  {-}
var
 l_C : TPersistent;
begin
 Result := nil;
 l_C := GetComponent(0);
 if (l_C Is TevSubDescriptor) then
 begin
  Result := TevSubDescriptor(l_C).Images;
  if (Result = nil) AND (TevSubDescriptor(l_C).Descriptors <> nil) then
   Result := TevSubDescriptor(l_C).Descriptors.Images;
 end;//l_C Is TevSubLayerDescriptor
end;

procedure Register;
begin
 {evRuler}
 RegisterComponents(evEverestPage, [TevRuler]);
 {evEditor}
 RegisterComponents(evEverestPage, [TevEditor, TevQueryCardEditor]);
 {evMemo}
 RegisterComponents(evEverestPage, [TevMemo]);
 {evEdit}
 RegisterComponents(evEverestPage, [TevEdit]);
 {evSubPn}
 RegisterComponents(evEverestPage, [TevSubPanel]);
 {evButton}
 RegisterComponents(evEverestPage, [TevButton]);
 {evPreviewPanel}
 RegisterComponents(evEverestPage, [TvtPreviewPanel]);
 {evMenu}
 {$IfDef evNeedDisp}
 RegisterNoIcon([TevMenuItem]);
 {$EndIf evNeedDisp}
 {evIntf}
 RegisterPropertyEditor(TypeInfo(String), TevCustomFont, 'Name', TFontNameProperty);
 RegisterPropertyEditor(TypeInfo(TImageIndex), TevSubDescriptor, '', TevSubPanelImageIndexProperty);
end;

end.

