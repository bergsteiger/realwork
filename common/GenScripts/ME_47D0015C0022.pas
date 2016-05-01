unit evControlParaConst;

// Модуль: "w:\common\components\gui\Garant\Everest\evControlParaConst.pas"
// Стереотип: "Interfaces"
// Элемент модели: "evControlParaConst" MUID: (47D0015C0022)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evdTypes
 , l3Const
 , Windows
 , Graphics
;

const
 evCheckableControls = [ev_ctCheckEdit, ev_ctRadioEdit];
 evFlatBTNControls = [ev_ctButton, ev_ctStateButton];
 evButtonControls = evFlatBTNControls + [ev_ctCollapsedPanel];
  {* Компоненты, которые ведут себя как кнопки }
 evButtonStyleControls = evButtonControls + evCheckableControls;
 evControlsWithButtons = [ev_ctCombo, ev_ctEllipsesEdit, ev_ctSpinedit,ev_ctCalEdit];
 evTextLabel = [ev_ctLabel, ev_ctTextParaLabel];
 evLabelControls = evTextLabel + [ev_ctPictureLabel];
 evNotEditableControls = evButtonStyleControls + evLabelControls;
 evSimpleEditors = [ev_ctEdit, ev_ctEmailEdit, ev_ctMemoEdit, ev_ctPhoneEdit];
 evEditControls = evControlsWithButtons + evSimpleEditors;
 evMaskedControls = [ev_ctCalEdit];
 evTextControls = evEditControls + evLabelControls;
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
 evParaCtrlKeys = [VK_ESCAPE, VK_RETURN, VK_LEFT, VK_RIGHT, VK_UP, VK_DOWN,VK_HOME, VK_END];
 evCalParaCtrlKey = [Ord('t'), Ord('T'), Ord('e'), Ord('E')];
 VK_ESCAPE = Windows.VK_ESCAPE;
 evErrorColor = Graphics.clRed;
 evValidColor = clWindowText;
 evMemoLineCount = 5;
 evLineSeparateChar = ' ';
  {* Разделитель строк при вставке пробела }

implementation

uses
 l3ImplUses
;

end.
