object evpText: TevpText
  Left = 302
  Top = 123
  Width = 696
  Height = 480
  HelpType = htKeyword
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  UserTypes = <>
  OnInit = vcmEntityFormInit
  PixelsPerInch = 96
  TextHeight = 13
  object Editor: TevEditor
    Left = 0
    Top = 0
    Width = 688
    Height = 453
    Canvas.DrawSpecial = False
    Align = alClient
    TextSource = TextSource
    TabOrder = 0
    TabStop = True
  end
  object Entities: TvcmEntities
    Entities = <
      item
        Name = 'File'
        Caption = #1060#1072#1081#1083
        Operations = <
          item
            Name = 'Save'
            OnTest = FileSaveTest
            OnExecute = FileSaveExecute
          end
          item
            Name = 'SaveAs'
            OnExecute = FileSaveAsExecute
          end>
        Controls = <>
      end
      item
        Name = 'Edit'
        Caption = #1055#1088#1072#1074#1082#1072
        Operations = <
          item
            Name = 'Undo'
            OnTest = EditUndoTest
            OnExecute = EditUndoExecute
          end
          item
            Name = 'Redo'
            OnTest = EditRedoTest
            OnExecute = EditRedoExecute
          end
          item
            Name = 'Cut'
            OnTest = EditCutTest
            OnExecute = EditCutExecute
          end
          item
            Name = 'Copy'
            OnTest = EditCopyTest
            OnExecute = EditCopyExecute
          end
          item
            Name = 'Paste'
            OnTest = EditPasteTest
            OnExecute = EditPasteExecute
          end
          item
            Name = 'SpecialPaste'
            OnTest = EditPasteTest
            OnExecute = EditSpecialPasteExecute
          end
          item
            Name = 'Delete'
            OnTest = EditDeleteTest
            OnExecute = EditDeleteExecute
          end>
        Controls = <>
      end
      item
        Name = 'View'
        Caption = #1042#1080#1076
        Operations = <
          item
            Name = 'ShowSpecial'
            OnTest = ViewShowSpecialTest
            OnExecute = ViewShowSpecialExecute
          end>
        Controls = <>
      end
      item
        Name = 'Table'
        Caption = #1058#1072#1073#1083#1080#1094#1072
        Operations = <
          item
            Name = 'Insert'
            OnTest = TableInsertTest
            OnExecute = TableInsertExecute
          end>
        Controls = <>
      end
      item
        Name = 'Font'
        Caption = #1064#1088#1080#1092#1090
        Operations = <
          item
            Name = 'Bold'
            OnTest = FontBoldTest
            OnExecute = FontBoldExecute
          end
          item
            Name = 'Italic'
            OnTest = FontItalicTest
            OnExecute = FontItalicExecute
          end
          item
            Name = 'Underline'
            OnTest = FontUnderlineTest
            OnExecute = FontUnderlineExecute
          end
          item
            Name = 'StrikeOut'
            OnTest = FontStrikeOutTest
            OnExecute = FontStrikeOutExecute
          end>
        Category = #1060#1086#1088#1084#1072#1090
        Controls = <>
      end>
    Events = <>
    Left = 10
    Top = 10
  end
  object TextSource: TevTextSource
    Left = 40
    Top = 10
  end
end
