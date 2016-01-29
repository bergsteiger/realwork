object frSubCombo: TfrSubCombo
  Left = 0
  Top = 0
  Width = 212
  Height = 191
  TabOrder = 0
  OnResize = FrameResize
  object btSubID: TevButton
    Left = 129
    Top = 10
    Height = 22
    Flat = False
    ImageIndex = 230
    Images = dmStandardRes.ilOffice
    OnClick = btSubIDClick
  end
  object seSubID: TvtSpinEdit
    Left = 7
    Top = 8
    Width = 121
    Height = 24
    UseMaxValue = False
    TabOrder = 0
  end
  object otlSub: TvtOutliner
    Left = 12
    Top = 33
    Width = 100
    Height = 135
    AutoRowHeight = False
    ProtectColor.BackColor = clRed
    ProtectColor.TextColor = clWhite
    SelectColor.BackColor = clHighlight
    SelectColor.TextColor = clHighlightText
    SelectNonFocusColor.BackColor = clBtnFace
    SelectNonFocusColor.TextColor = clBtnText
    OnGetItemImage = otlSubGetItemImage
    ParentColor = False
    TabOrder = 1
    TabStop = True
    Visible = False
    OnActionElement = otlSubActionElement
  end
end
