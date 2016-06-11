inherited frmFDGUIxFormsFields: TfrmFDGUIxFormsFields
  Caption = 'FireDAC Field List Editor'
  PixelsPerInch = 96
  TextHeight = 13
  object lbFields: TFDGUIxFormsDblListBox
    Left = 6
    Top = 40
    Width = 344
    Height = 236
    DestCaption = '&Included fields:'
    SrcCaption = '&Source fields:'
    DestListHint = 'A list of included fields'
    SrcListHint = 'A list of accessible source fields'
    IncHint = 'Include field'
    IncAllHint = 'Include all fields'
    ExHint = 'Exclude field'
    ExAllHint = 'Exclude all fields'
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 2
  end
end
