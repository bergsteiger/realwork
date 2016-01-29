unit evControlParaConst;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/evControlParaConst.pas"
// �����: 13.11.2004 13:23
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::Everest::evControlParaConst
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evdTypes,
  l3Const,
  Graphics,
  Windows
  ;

const
  { Control Types }
 evCheckableControls = [ev_ctCheckEdit, ev_ctRadioEdit];
 evFlatBTNControls = [ev_ctButton, ev_ctStateButton];
 evButtonControls = evFlatBTNControls + [ev_ctCollapsedPanel];
  { ����������, ������� ����� ���� ��� ������ }
 evButtonStyleControls = evButtonControls + evCheckableControls;
 evControlsWithButtons = [ev_ctCombo, ev_ctEllipsesEdit, ev_ctSpinedit,ev_ctCalEdit];
 evTextLabel = [ev_ctLabel, ev_ctTextParaLabel];
 evLabelControls = evTextLabel + [ev_ctPictureLabel];
 evNotEditableControls = evButtonStyleControls + evLabelControls;
 evSimpleEditors = [ev_ctEdit, ev_ctEmailEdit, ev_ctMemoEdit, ev_ctPhoneEdit];
 evEditControls = evControlsWithButtons + evSimpleEditors;
 evMaskedControls = [ev_ctCalEdit];
 evTextControls = evEditControls + evLabelControls;
  { Margins }
 BefSpace = l3Inch div 128;
 BefBtbSpase = l3Inch div 64;
 BefUpSpase = l3Inch div 32;
 RightMemoSpase = l3Inch div 32;
 HalfBefSpace = l3Inch div 16;
 ControlWidth = l3Inch div 8;
 ComboBtnWidth = l3Inch div 6;
 BtnWidth = l3Inch div 4;
 AfterPictureLabel = l3Inch div 32;
 BefPictureLabel = l3Inch div 2;
  { Keys }
 evParaCtrlKeys = [VK_ESCAPE, VK_RETURN, VK_LEFT, VK_RIGHT, VK_UP, VK_DOWN,VK_HOME, VK_END];
 evCalParaCtrlKey = [Ord('t'), Ord('T'), Ord('e'), Ord('E')];
 VK_ESCAPE = Windows.VK_ESCAPE;
  { Colors }
 evErrorColor = Graphics.clRed;
 evValidColor = clWindowText;
  { Other }
 evMemoLineCount = 5;
 evLineSeparateChar = ' ';
  { ����������� ����� ��� ������� ������� }

implementation

end.