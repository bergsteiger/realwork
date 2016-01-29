unit stdRes;

// $Id: stdRes.pas,v 1.2 2004/10/07 11:52:37 lulin Exp $

// $Log: stdRes.pas,v $
// Revision 1.2  2004/10/07 11:52:37  lulin
// - не компилировалось без define Nemesis.
//
// Revision 1.1  2003/12/09 18:28:26  law
// no message
//
// Revision 1.16  2003/12/02 18:18:04  law
// - new operation: SpecialPaste.
//
// Revision 1.15  2003/12/02 17:44:54  law
// - change: добавлены ShortCut'ы.
//
// Revision 1.14  2003/12/02 17:40:51  law
// - new operations: Edit.Cut, Copy, Paste, Delete.
//
// Revision 1.13  2003/12/02 17:18:49  law
// - new operations: Font.Italic, Underline, Strikeout.
//
// Revision 1.12  2003/12/02 17:08:12  law
// - new operation: Font.Bold.
//
// Revision 1.11  2003/12/02 16:37:24  law
// - new operations: View.ShowSpecial.
//
// Revision 1.10  2003/12/02 16:30:58  law
// - new operations: Edit.Undo, Edit.Redo.
//
// Revision 1.9  2003/12/02 16:25:13  law
// - new operation: Table.Insert.
//
// Revision 1.8  2003/12/02 16:08:29  law
// - new operation: SaveAs.
//
// Revision 1.7  2003/12/02 16:01:03  law
// - new operation: Save.
//
// Revision 1.6  2003/12/02 15:35:43  law
// - new operation: Open.
//
// Revision 1.5  2003/12/02 14:59:49  law
// - выставлены директивы CVS.
//

interface

uses
  SysUtils, Classes, ImgList, Controls, ActnList,
  ActnMan, vcmInterfaces, vcmBaseMenuManager, vcmMenuManager, vcmBaseEntities,
  vcmComponent;

type
  TdmStdRes = class(TDataModule)
    MenuManager: TvcmMenuManager;
    ActionManager: TActionList;
    ilOffice: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmStdRes: TdmStdRes;

const // start VCM generated section
{$WriteableConst On}
  op_View_ShowSpecial : TvcmOPID = (rEn : 'View'; rOp : 'ShowSpecial'; rEnID : 0; rOpID : 0);
   // Вид -> Спецсимволы
  op_Edit_Undo : TvcmOPID = (rEn : 'Edit'; rOp : 'Undo'; rEnID : 0; rOpID : 0);
   // Правка -> Отменить
  op_Edit_Redo : TvcmOPID = (rEn : 'Edit'; rOp : 'Redo'; rEnID : 0; rOpID : 0);
   // Правка -> Вернуть
  op_Edit_Cut : TvcmOPID = (rEn : 'Edit'; rOp : 'Cut'; rEnID : 0; rOpID : 0);
   // Правка -> Вырезать
  op_Edit_Copy : TvcmOPID = (rEn : 'Edit'; rOp : 'Copy'; rEnID : 0; rOpID : 0);
   // Правка -> Копировать
  op_Edit_Paste : TvcmOPID = (rEn : 'Edit'; rOp : 'Paste'; rEnID : 0; rOpID : 0);
   // Правка -> Вставить
  op_Edit_Delete : TvcmOPID = (rEn : 'Edit'; rOp : 'Delete'; rEnID : 0; rOpID : 0);
   // Правка -> Удалить
  op_Edit_SpecialPaste : TvcmOPID = (rEn : 'Edit'; rOp : 'SpecialPaste'; rEnID : 0; rOpID : 0);
   // Правка -> Специальная вставка...
  op_Table_Insert : TvcmOPID = (rEn : 'Table'; rOp : 'Insert'; rEnID : 0; rOpID : 0);
   // Таблица -> Вставить...
  op_File_Exit : TvcmOPID = (rEn : 'File'; rOp : 'Exit'; rEnID : 0; rOpID : 0);
   // Файл -> Выход
  op_File_Save : TvcmOPID = (rEn : 'File'; rOp : 'Save'; rEnID : 0; rOpID : 0);
   // Файл -> Сохранить
  op_File_SaveAs : TvcmOPID = (rEn : 'File'; rOp : 'SaveAs'; rEnID : 0; rOpID : 0);
   // Файл -> Сохранить как...
  op_Font_Bold : TvcmOPID = (rEn : 'Font'; rOp : 'Bold'; rEnID : 0; rOpID : 0);
   // Шрифт -> Жирный
  op_Font_Italic : TvcmOPID = (rEn : 'Font'; rOp : 'Italic'; rEnID : 0; rOpID : 0);
   // Шрифт -> Курсив
  op_Font_Underline : TvcmOPID = (rEn : 'Font'; rOp : 'Underline'; rEnID : 0; rOpID : 0);
   // Шрифт -> Подчеркнутый
  op_Font_StrikeOut : TvcmOPID = (rEn : 'Font'; rOp : 'StrikeOut'; rEnID : 0; rOpID : 0);
   // Шрифт -> Перечеркнутый
  mop_evpDocument_New : TvcmMOPID = (rMo : 'evpDocument'; rOp : 'New'; rMoID : 0; rOpID : 0);
   // Документ -> Новый
  mop_evpDocument_en : TvcmMOPID = (rMo : 'evpDocument'; rOp : 'Open'; rMoID : 0; rOpID : 0);
   // Документ -> Открыть
  mop_evpDocument_GetSaveManager : TvcmMOPID = (rMo : 'evpDocument'; rOp : 'GetSaveManager'; rMoID : 0; rOpID : 0);
   // Документ -> GetSaveManager
const // - идентификаторы форм
  fm_evpText : TvcmFormID = (rName : 'evpText');
   // evpText
  fm_evpMain : TvcmFormID = (rName : 'evpMain');
   // Эверест
// end VCM generated section

implementation

{$R *.dfm}

end.
