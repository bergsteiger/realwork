object Form1: TForm1
  Left = 256
  Top = 112
  BorderStyle = bsDialog
  Caption = 'FormProcessing'
  ClientHeight = 482
  ClientWidth = 572
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  DesignSize = (
    572
    482)
  PixelsPerInch = 96
  TextHeight = 13
  object Label13: TLabel
    Left = 11
    Top = 54
    Width = 43
    Height = 13
    Caption = 'Input file:'
  end
  object Label14: TLabel
    Left = 11
    Top = 83
    Width = 48
    Height = 13
    Caption = 'Ouput file:'
  end
  object Label75: TLabel
    Left = 193
    Top = 16
    Width = 163
    Height = 16
    Caption = 'Form Processing Demo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object edPDFfilename: TEdit
    Left = 81
    Top = 49
    Width = 284
    Height = 21
    TabOrder = 0
  end
  object edSavePDFTo: TEdit
    Left = 81
    Top = 80
    Width = 284
    Height = 21
    TabOrder = 1
    Text = 'C:\Output.pdf'
  end
  object btnSaveFileName: TButton
    Left = 372
    Top = 80
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 2
    OnClick = btnSaveFileNameClick
  end
  object btnLoadPDF: TButton
    Left = 373
    Top = 46
    Width = 89
    Height = 25
    Caption = 'Load document'
    TabOrder = 3
    OnClick = btnLoadPDFClick
  end
  object btnSave: TButton
    Left = 492
    Top = 450
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 4
    OnClick = btnSaveClick
  end
  object pgcntrlFormProcessing: TPageControl
    Left = 6
    Top = 101
    Width = 561
    Height = 340
    ActivePage = tbshReadEditform
    Anchors = []
    TabOrder = 5
    object tbshReadEditform: TTabSheet
      Caption = 'Read/Edit form'
      object sgFields: TStringGrid
        Left = 4
        Top = 5
        Width = 546
        Height = 274
        ColCount = 9
        DefaultColWidth = 148
        DefaultRowHeight = 16
        FixedCols = 0
        RowCount = 20
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goEditing]
        TabOrder = 0
        ColWidths = (
          34
          62
          102
          83
          112
          121
          62
          72
          148)
      end
      object btnGetFormFields: TButton
        Left = 354
        Top = 283
        Width = 92
        Height = 25
        Caption = 'Get form fields'
        TabOrder = 1
        OnClick = btnGetFormFieldsClick
      end
      object btnSetformfields: TButton
        Left = 450
        Top = 283
        Width = 102
        Height = 25
        Caption = 'Set form fields'
        TabOrder = 2
        OnClick = btnSetformfieldsClick
      end
    end
    object tbshAddform: TTabSheet
      Caption = 'Add form fields'
      ImageIndex = 1
      object Label1: TLabel
        Left = 8
        Top = 67
        Width = 38
        Height = 13
        Caption = 'Settings'
      end
      object Label2: TLabel
        Left = 7
        Top = 251
        Width = 84
        Height = 13
        Caption = 'Measurement unit'
      end
      object rgrpAddform: TRadioGroup
        Left = 7
        Top = 2
        Width = 539
        Height = 63
        Caption = 'Select form field to be added'
        Columns = 6
        ItemIndex = 0
        Items.Strings = (
          'Text box'
          'Combo box'
          'List box'
          'Push button'
          'Check box'
          'Radio button')
        TabOrder = 0
        OnClick = rgrpAddformClick
      end
      object pctrlAddformsettings: TPageControl
        Left = 7
        Top = 81
        Width = 539
        Height = 161
        ActivePage = tbshTextbox
        TabOrder = 1
        object tbshPushButton: TTabSheet
          Caption = 'PushButton'
          TabVisible = False
          object Label183: TLabel
            Left = 4
            Top = 9
            Width = 18
            Height = 13
            Caption = 'Left'
          end
          object Label184: TLabel
            Left = 88
            Top = 6
            Width = 19
            Height = 13
            Caption = 'Top'
          end
          object Label188: TLabel
            Left = 3
            Top = 34
            Width = 25
            Height = 13
            Caption = 'Right'
          end
          object Label187: TLabel
            Left = 88
            Top = 34
            Width = 33
            Height = 13
            Caption = 'Bottom'
          end
          object Label190: TLabel
            Left = 4
            Top = 91
            Width = 51
            Height = 13
            Caption = 'Field name'
          end
          object Label191: TLabel
            Left = 192
            Top = 91
            Width = 84
            Height = 13
            Caption = 'Background color'
          end
          object Label186: TLabel
            Left = 192
            Top = 34
            Width = 66
            Height = 13
            Caption = 'Down caption'
          end
          object Label185: TLabel
            Left = 192
            Top = 6
            Width = 71
            Height = 13
            Caption = 'Normal caption'
          end
          object Label3: TLabel
            Left = 192
            Top = 63
            Width = 77
            Height = 13
            Caption = 'Rollover caption'
          end
          object Label4: TLabel
            Left = 383
            Top = 6
            Width = 59
            Height = 13
            Caption = 'Border width'
          end
          object Label5: TLabel
            Left = 4
            Top = 120
            Width = 35
            Height = 13
            Caption = 'Page #'
          end
          object Label56: TLabel
            Left = 192
            Top = 120
            Width = 57
            Height = 13
            Caption = 'Border color'
          end
          object Label57: TLabel
            Left = 383
            Top = 63
            Width = 30
            Height = 13
            Caption = 'Action'
          end
          object edFormPushLeft: TEdit
            Left = 33
            Top = 3
            Width = 49
            Height = 21
            TabOrder = 0
          end
          object edFormPushTop: TEdit
            Left = 129
            Top = 3
            Width = 49
            Height = 21
            TabOrder = 1
          end
          object edFormPushRight: TEdit
            Left = 33
            Top = 30
            Width = 49
            Height = 21
            TabOrder = 2
          end
          object edFormPushBottom: TEdit
            Left = 129
            Top = 31
            Width = 49
            Height = 21
            TabOrder = 3
          end
          object edFormPushFieldname: TEdit
            Left = 61
            Top = 86
            Width = 98
            Height = 21
            TabOrder = 4
          end
          object spedPushBorderWidth: TSpinEdit
            Left = 450
            Top = 3
            Width = 47
            Height = 22
            MaxValue = 100
            MinValue = 0
            TabOrder = 5
            Value = 1
          end
          object cbFormPushPageno: TComboBox
            Left = 61
            Top = 114
            Width = 47
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 6
          end
          object edFormPushNormal: TEdit
            Left = 277
            Top = 3
            Width = 98
            Height = 21
            TabOrder = 7
          end
          object edFormPushDown: TEdit
            Left = 277
            Top = 30
            Width = 98
            Height = 21
            TabOrder = 8
          end
          object edFormPushRollover: TEdit
            Left = 277
            Top = 58
            Width = 98
            Height = 21
            TabOrder = 9
          end
          object cbPushBtnAction: TComboBox
            Left = 450
            Top = 58
            Width = 75
            Height = 21
            ItemHeight = 13
            TabOrder = 12
            Text = 'pbaNone '
            Items.Strings = (
              'pbaNone '
              'pbaSubmit'
              'pbaReset '
              'pbaJavaScript')
          end
          object btnPushbtnfont: TButton
            Left = 450
            Top = 30
            Width = 63
            Height = 21
            Caption = 'Font'
            TabOrder = 10
            OnClick = btnPushbtnfontClick
          end
          object GroupBox4: TGroupBox
            Left = 375
            Top = 85
            Width = 155
            Height = 65
            TabOrder = 11
            object Label58: TLabel
              Left = 6
              Top = 41
              Width = 64
              Height = 13
              Caption = 'Submit format'
            end
            object Label7: TLabel
              Left = 7
              Top = 12
              Width = 51
              Height = 13
              Caption = 'Java script'
            end
            object Label6: TLabel
              Left = 5
              Top = 12
              Width = 57
              Height = 13
              Caption = 'Submit URL'
            end
            object cbFormsubmitformat: TComboBox
              Left = 75
              Top = 37
              Width = 75
              Height = 21
              ItemHeight = 13
              TabOrder = 0
              Text = 'fsfHTML '
              Items.Strings = (
                'fsfHTML '
                'fsfFDF '
                'fsfXML')
            end
            object edFormPushSubmitURL: TEdit
              Left = 76
              Top = 9
              Width = 75
              Height = 21
              TabOrder = 1
            end
            object edFormPushJavascript: TEdit
              Left = 75
              Top = 8
              Width = 75
              Height = 21
              TabOrder = 2
            end
          end
          object btnBorderColor: TButton
            Left = 282
            Top = 91
            Width = 35
            Height = 20
            Caption = '...'
            TabOrder = 13
            OnClick = btnBorderColorClick
          end
          object btnBackColor: TButton
            Left = 283
            Top = 117
            Width = 35
            Height = 20
            Caption = '...'
            TabOrder = 14
            OnClick = btnBackColorClick
          end
        end
        object tbshCheckbox: TTabSheet
          Caption = 'Checkbox'
          ImageIndex = 1
          TabVisible = False
          object Label8: TLabel
            Left = 5
            Top = 10
            Width = 18
            Height = 13
            Caption = 'Left'
          end
          object Label9: TLabel
            Left = 99
            Top = 10
            Width = 19
            Height = 13
            Caption = 'Top'
          end
          object Label10: TLabel
            Left = 99
            Top = 37
            Width = 33
            Height = 13
            Caption = 'Bottom'
          end
          object Label11: TLabel
            Left = 5
            Top = 37
            Width = 25
            Height = 13
            Caption = 'Right'
          end
          object Label12: TLabel
            Left = 5
            Top = 95
            Width = 51
            Height = 13
            Caption = 'Field name'
          end
          object Label15: TLabel
            Left = 5
            Top = 123
            Width = 27
            Height = 13
            Caption = 'Value'
          end
          object Label16: TLabel
            Left = 202
            Top = 66
            Width = 84
            Height = 13
            Caption = 'Background color'
          end
          object Label17: TLabel
            Left = 392
            Top = 8
            Width = 35
            Height = 13
            Caption = 'Page #'
          end
          object Label18: TLabel
            Left = 203
            Top = 8
            Width = 59
            Height = 13
            Caption = 'Border width'
          end
          object Label19: TLabel
            Left = 203
            Top = 121
            Width = 34
            Height = 13
            Caption = 'Symbol'
          end
          object Label59: TLabel
            Left = 203
            Top = 36
            Width = 55
            Height = 13
            Caption = 'Border style'
          end
          object Label60: TLabel
            Left = 202
            Top = 92
            Width = 57
            Height = 13
            Caption = 'Border color'
          end
          object edFormCheckLeft: TEdit
            Left = 40
            Top = 5
            Width = 49
            Height = 21
            TabOrder = 0
          end
          object edFormCheckTop: TEdit
            Left = 143
            Top = 5
            Width = 49
            Height = 21
            TabOrder = 1
          end
          object edFormCheckBottom: TEdit
            Left = 143
            Top = 34
            Width = 49
            Height = 21
            TabOrder = 2
          end
          object edFormCheckRight: TEdit
            Left = 40
            Top = 34
            Width = 49
            Height = 21
            TabOrder = 3
          end
          object edFormCheckFieldname: TEdit
            Left = 80
            Top = 93
            Width = 98
            Height = 21
            TabOrder = 4
          end
          object cbFormCheckPageno: TComboBox
            Left = 442
            Top = 5
            Width = 47
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 5
          end
          object spedFormCheckBwidth: TSpinEdit
            Left = 290
            Top = 5
            Width = 47
            Height = 22
            MaxValue = 100
            MinValue = 0
            TabOrder = 6
            Value = 1
          end
          object chkFormCheckValue: TCheckBox
            Left = 80
            Top = 123
            Width = 57
            Height = 17
            Caption = 'ON/OFF'
            TabOrder = 7
          end
          object cbformcheckboxsymbol: TComboBox
            Left = 290
            Top = 119
            Width = 90
            Height = 21
            ItemHeight = 13
            TabOrder = 9
            Text = 'pfcsCheck'
            Items.Strings = (
              'pfcsCheck'
              'pfcsCircle '
              'pfcsCross'
              'pfcsDiamond'
              'pfcsSquare '
              'pfcsStar')
          end
          object cbCheckboxBorderstyle: TComboBox
            Left = 290
            Top = 33
            Width = 76
            Height = 21
            ItemHeight = 13
            TabOrder = 8
            Text = 'bsSolid '
            Items.Strings = (
              'bsSolid '
              'bsDashed '
              'bsBeveled'
              'bsInset'
              'bsUnderline')
          end
          object btnCBBackClr: TButton
            Left = 291
            Top = 63
            Width = 35
            Height = 20
            Caption = '...'
            TabOrder = 10
            OnClick = btnBorderColorClick
          end
          object btnCBBrdrClr: TButton
            Left = 292
            Top = 89
            Width = 35
            Height = 20
            Caption = '...'
            TabOrder = 11
            OnClick = btnBackColorClick
          end
        end
        object tbshRadiobutton: TTabSheet
          Caption = 'Radiobutton'
          ImageIndex = 2
          TabVisible = False
          object Label38: TLabel
            Left = 5
            Top = 10
            Width = 18
            Height = 13
            Caption = 'Left'
          end
          object Label45: TLabel
            Left = 99
            Top = 10
            Width = 19
            Height = 13
            Caption = 'Top'
          end
          object Label46: TLabel
            Left = 5
            Top = 37
            Width = 25
            Height = 13
            Caption = 'Right'
          end
          object Label47: TLabel
            Left = 99
            Top = 37
            Width = 33
            Height = 13
            Caption = 'Bottom'
          end
          object Label48: TLabel
            Left = 5
            Top = 95
            Width = 51
            Height = 13
            Caption = 'Field name'
          end
          object Label49: TLabel
            Left = 5
            Top = 123
            Width = 27
            Height = 13
            Caption = 'Value'
          end
          object Label50: TLabel
            Left = 382
            Top = 101
            Width = 35
            Height = 13
            Caption = 'Page #'
          end
          object Label51: TLabel
            Left = 205
            Top = 9
            Width = 84
            Height = 13
            Caption = 'Background color'
          end
          object Label52: TLabel
            Left = 382
            Top = 8
            Width = 34
            Height = 13
            Caption = 'Symbol'
          end
          object Label70: TLabel
            Left = 205
            Top = 39
            Width = 57
            Height = 13
            Caption = 'Border color'
          end
          object Label71: TLabel
            Left = 205
            Top = 69
            Width = 59
            Height = 13
            Caption = 'Border width'
          end
          object Label72: TLabel
            Left = 205
            Top = 100
            Width = 55
            Height = 13
            Caption = 'Border style'
          end
          object Selected: TLabel
            Left = 382
            Top = 70
            Width = 92
            Height = 13
            Caption = 'Selected item index'
          end
          object edformRadioLeft: TEdit
            Left = 40
            Top = 5
            Width = 49
            Height = 21
            TabOrder = 0
          end
          object edformRadioTop: TEdit
            Left = 143
            Top = 5
            Width = 49
            Height = 21
            TabOrder = 1
          end
          object edformRadioRight: TEdit
            Left = 40
            Top = 34
            Width = 49
            Height = 21
            TabOrder = 2
          end
          object edformRadioBottom: TEdit
            Left = 143
            Top = 34
            Width = 49
            Height = 21
            TabOrder = 3
          end
          object edformRadioFieldname: TEdit
            Left = 80
            Top = 93
            Width = 98
            Height = 21
            TabOrder = 4
          end
          object edformRadioFielddvalue: TEdit
            Left = 80
            Top = 123
            Width = 98
            Height = 21
            TabOrder = 5
          end
          object cbFormRadioPageno: TComboBox
            Left = 425
            Top = 96
            Width = 47
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 6
          end
          object cbFormRadioSymbol: TComboBox
            Left = 425
            Top = 5
            Width = 80
            Height = 21
            ItemHeight = 13
            TabOrder = 7
            Text = 'pfcsCheck '
            Items.Strings = (
              'pfcsCheck '
              'pfcsCircle '
              'pfcsCross'
              'pfcsDiamond'
              'pfcsSquare '
              'pfcsStar')
          end
          object spedRadioBorderWidth: TSpinEdit
            Left = 294
            Top = 65
            Width = 47
            Height = 22
            MaxValue = 100
            MinValue = 0
            TabOrder = 8
            Value = 1
          end
          object cbRadioBorderStyle: TComboBox
            Left = 294
            Top = 96
            Width = 76
            Height = 21
            ItemHeight = 13
            TabOrder = 10
            Text = 'bsSolid '
            Items.Strings = (
              'bsSolid '
              'bsDashed '
              'bsBeveled'
              'bsInset'
              'bsUnderline')
          end
          object btnRadioFont: TButton
            Left = 205
            Top = 122
            Width = 72
            Height = 25
            Caption = 'Font'
            TabOrder = 12
            OnClick = btnRadioFontClick
          end
          object chkRadioAtleastone: TCheckBox
            Left = 382
            Top = 39
            Width = 146
            Height = 17
            Caption = 'Atleast one selected item'
            TabOrder = 9
          end
          object edRadioItemindex: TEdit
            Left = 478
            Top = 65
            Width = 49
            Height = 21
            TabOrder = 11
          end
          object btnRBBackClr: TButton
            Left = 293
            Top = 8
            Width = 35
            Height = 20
            Caption = '...'
            TabOrder = 13
            OnClick = btnBorderColorClick
          end
          object btnRBBrdrClr: TButton
            Left = 294
            Top = 34
            Width = 35
            Height = 20
            Caption = '...'
            TabOrder = 14
            OnClick = btnBackColorClick
          end
        end
        object tbshTextbox: TTabSheet
          Caption = 'Textbox'
          ImageIndex = 3
          TabVisible = False
          object Label20: TLabel
            Left = 5
            Top = 10
            Width = 18
            Height = 13
            Caption = 'Left'
          end
          object Label21: TLabel
            Left = 92
            Top = 10
            Width = 19
            Height = 13
            Caption = 'Top'
          end
          object Label22: TLabel
            Left = 92
            Top = 37
            Width = 33
            Height = 13
            Caption = 'Bottom'
          end
          object Label23: TLabel
            Left = 5
            Top = 37
            Width = 25
            Height = 13
            Caption = 'Right'
          end
          object Label24: TLabel
            Left = 5
            Top = 95
            Width = 51
            Height = 13
            Caption = 'Field name'
          end
          object Label25: TLabel
            Left = 5
            Top = 120
            Width = 27
            Height = 13
            Caption = 'Value'
          end
          object Label26: TLabel
            Left = 192
            Top = 9
            Width = 84
            Height = 13
            Caption = 'Background color'
          end
          object Label27: TLabel
            Left = 370
            Top = 121
            Width = 35
            Height = 13
            Caption = 'Page #'
          end
          object Label28: TLabel
            Left = 192
            Top = 121
            Width = 55
            Height = 13
            Caption = 'Justification'
          end
          object Label61: TLabel
            Left = 192
            Top = 37
            Width = 57
            Height = 13
            Caption = 'Border color'
          end
          object Label62: TLabel
            Left = 192
            Top = 93
            Width = 55
            Height = 13
            Caption = 'Border style'
          end
          object Label63: TLabel
            Left = 192
            Top = 65
            Width = 59
            Height = 13
            Caption = 'Border width'
          end
          object edFormTextLeft: TEdit
            Left = 33
            Top = 5
            Width = 49
            Height = 21
            TabOrder = 0
          end
          object edFormTextTop: TEdit
            Left = 129
            Top = 5
            Width = 49
            Height = 21
            TabOrder = 1
          end
          object edFormTextBottom: TEdit
            Left = 129
            Top = 34
            Width = 49
            Height = 21
            TabOrder = 2
          end
          object edFormTextRight: TEdit
            Left = 33
            Top = 34
            Width = 49
            Height = 21
            TabOrder = 3
          end
          object edFormTextfieldname: TEdit
            Left = 80
            Top = 89
            Width = 98
            Height = 21
            TabOrder = 4
          end
          object edFormTextValue: TEdit
            Left = 80
            Top = 117
            Width = 98
            Height = 21
            TabOrder = 5
          end
          object cbformTextpageno: TComboBox
            Left = 421
            Top = 117
            Width = 47
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 6
          end
          object chkformTextTran: TCheckBox
            Left = 371
            Top = 3
            Width = 77
            Height = 17
            Caption = 'Transparent'
            TabOrder = 7
          end
          object chkformTextIsMulti: TCheckBox
            Left = 371
            Top = 21
            Width = 77
            Height = 17
            Caption = 'Is multi line'
            TabOrder = 8
          end
          object chkformTextIsPass: TCheckBox
            Left = 371
            Top = 40
            Width = 77
            Height = 17
            Caption = 'Is password'
            TabOrder = 9
          end
          object chkformTextIsfile: TCheckBox
            Left = 371
            Top = 58
            Width = 77
            Height = 17
            Caption = 'Is file select'
            TabOrder = 10
          end
          object cbformTextJust: TComboBox
            Left = 280
            Top = 117
            Width = 76
            Height = 21
            ItemHeight = 13
            TabOrder = 11
            Text = 'fjLeftJustified '
            Items.Strings = (
              'fjLeftJustified '
              'fjCentered '
              'fjRightJustified')
          end
          object btnTextFont: TButton
            Left = 456
            Top = 5
            Width = 72
            Height = 25
            Caption = 'Font'
            TabOrder = 12
            OnClick = btnTextFontClick
          end
          object cbtextboxBorderStyle: TComboBox
            Left = 280
            Top = 89
            Width = 76
            Height = 21
            ItemHeight = 13
            TabOrder = 14
            Text = 'bsSolid '
            Items.Strings = (
              'bsSolid '
              'bsDashed '
              'bsBeveled'
              'bsInset'
              'bsUnderline')
          end
          object spedTextboxBorderwidth: TSpinEdit
            Left = 280
            Top = 61
            Width = 47
            Height = 22
            MaxValue = 100
            MinValue = 0
            TabOrder = 16
            Value = 1
          end
          object chkTextboxIsDonotScroll: TCheckBox
            Left = 371
            Top = 77
            Width = 91
            Height = 17
            Caption = 'Is do not scroll'
            TabOrder = 13
          end
          object chkTextboxSpellcheck: TCheckBox
            Left = 371
            Top = 96
            Width = 115
            Height = 17
            Caption = 'Is do not spell check'
            TabOrder = 15
          end
          object btnTBBackClr: TButton
            Left = 281
            Top = 7
            Width = 35
            Height = 20
            Caption = '...'
            TabOrder = 17
            OnClick = btnBorderColorClick
          end
          object btnTBBrdrClr: TButton
            Left = 282
            Top = 33
            Width = 35
            Height = 20
            Caption = '...'
            TabOrder = 18
            OnClick = btnBackColorClick
          end
        end
        object tbshcombobox: TTabSheet
          Caption = 'Combobox'
          ImageIndex = 4
          TabVisible = False
          object Label29: TLabel
            Left = 5
            Top = 10
            Width = 18
            Height = 13
            Caption = 'Left'
          end
          object Label30: TLabel
            Left = 99
            Top = 10
            Width = 19
            Height = 13
            Caption = 'Top'
          end
          object Label31: TLabel
            Left = 5
            Top = 37
            Width = 25
            Height = 13
            Caption = 'Right'
          end
          object Label32: TLabel
            Left = 99
            Top = 37
            Width = 33
            Height = 13
            Caption = 'Bottom'
          end
          object Label33: TLabel
            Left = 5
            Top = 67
            Width = 51
            Height = 13
            Caption = 'Field name'
          end
          object Label34: TLabel
            Left = 375
            Top = 93
            Width = 35
            Height = 13
            Caption = 'Page #'
          end
          object Label35: TLabel
            Left = 201
            Top = 38
            Width = 84
            Height = 13
            Caption = 'Background color'
          end
          object Label64: TLabel
            Left = 201
            Top = 67
            Width = 59
            Height = 13
            Caption = 'Border width'
          end
          object Label65: TLabel
            Left = 201
            Top = 11
            Width = 57
            Height = 13
            Caption = 'Border color'
          end
          object Label66: TLabel
            Left = 201
            Top = 96
            Width = 55
            Height = 13
            Caption = 'Border style'
          end
          object Label36: TLabel
            Left = 3
            Top = 90
            Width = 46
            Height = 13
            Caption = 'Add items'
          end
          object Label37: TLabel
            Left = 376
            Top = 67
            Width = 92
            Height = 13
            Caption = 'Selected item index'
          end
          object edformComboLeft: TEdit
            Left = 40
            Top = 5
            Width = 49
            Height = 21
            TabOrder = 0
          end
          object edformComboTop: TEdit
            Left = 143
            Top = 5
            Width = 49
            Height = 21
            TabOrder = 1
          end
          object edformComboRight: TEdit
            Left = 40
            Top = 34
            Width = 49
            Height = 21
            TabOrder = 2
          end
          object edformComboBottom: TEdit
            Left = 143
            Top = 34
            Width = 49
            Height = 21
            TabOrder = 3
          end
          object edformComboFieldname: TEdit
            Left = 62
            Top = 62
            Width = 130
            Height = 21
            TabOrder = 4
          end
          object chkFormComboIsSorted: TCheckBox
            Left = 375
            Top = 7
            Width = 77
            Height = 17
            Caption = 'Is sorted list'
            TabOrder = 5
          end
          object chkFormComboIsEdit: TCheckBox
            Left = 375
            Top = 34
            Width = 72
            Height = 17
            Caption = 'Is editable'
            TabOrder = 6
          end
          object cbFormComboPageno: TComboBox
            Left = 416
            Top = 93
            Width = 47
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 7
          end
          object spedComboBorderwidth: TSpinEdit
            Left = 288
            Top = 62
            Width = 47
            Height = 22
            MaxValue = 100
            MinValue = 0
            TabOrder = 8
            Value = 1
          end
          object cbComboBorderStyle: TComboBox
            Left = 287
            Top = 92
            Width = 76
            Height = 21
            ItemHeight = 13
            TabOrder = 10
            Text = 'bsSolid '
            Items.Strings = (
              'bsSolid '
              'bsDashed '
              'bsBeveled'
              'bsInset'
              'bsUnderline')
          end
          object btnCombofont: TButton
            Left = 198
            Top = 119
            Width = 72
            Height = 25
            Caption = 'Font'
            TabOrder = 12
            OnClick = btnCombofontClick
          end
          object lstbxComboAddItem: TListBox
            Left = 62
            Top = 110
            Width = 130
            Height = 34
            ItemHeight = 13
            TabOrder = 9
          end
          object edComboSelecteditemindex: TEdit
            Left = 474
            Top = 62
            Width = 49
            Height = 21
            TabOrder = 11
          end
          object btnComBBrdrClr: TButton
            Left = 288
            Top = 7
            Width = 35
            Height = 20
            Caption = '...'
            TabOrder = 13
            OnClick = btnBorderColorClick
          end
          object btnComBBackClr: TButton
            Left = 288
            Top = 34
            Width = 35
            Height = 20
            Caption = '...'
            TabOrder = 14
            OnClick = btnBackColorClick
          end
          object edFormComboAddItem: TEdit
            Left = 62
            Top = 86
            Width = 97
            Height = 21
            TabOrder = 15
          end
          object btnComboBoxAddItem: TButton
            Left = 160
            Top = 87
            Width = 30
            Height = 20
            Caption = 'Add'
            TabOrder = 16
            OnClick = btnComboBoxAddItemClick
          end
        end
        object tbshListbox: TTabSheet
          Caption = 'Listbox'
          ImageIndex = 5
          TabVisible = False
          object Label39: TLabel
            Left = 5
            Top = 10
            Width = 18
            Height = 13
            Caption = 'Left'
          end
          object Label40: TLabel
            Left = 99
            Top = 10
            Width = 19
            Height = 13
            Caption = 'Top'
          end
          object Label41: TLabel
            Left = 99
            Top = 37
            Width = 33
            Height = 13
            Caption = 'Bottom'
          end
          object Label42: TLabel
            Left = 5
            Top = 37
            Width = 25
            Height = 13
            Caption = 'Right'
          end
          object Label43: TLabel
            Left = 3
            Top = 64
            Width = 51
            Height = 13
            Caption = 'Field name'
          end
          object Label44: TLabel
            Left = 376
            Top = 93
            Width = 35
            Height = 13
            Caption = 'Page #'
          end
          object Label53: TLabel
            Left = 201
            Top = 37
            Width = 84
            Height = 13
            Caption = 'Background color'
          end
          object Label54: TLabel
            Left = 201
            Top = 8
            Width = 57
            Height = 13
            Caption = 'Border color'
          end
          object Label67: TLabel
            Left = 202
            Top = 64
            Width = 59
            Height = 13
            Caption = 'Border width'
          end
          object Label68: TLabel
            Left = 202
            Top = 90
            Width = 55
            Height = 13
            Caption = 'Border style'
          end
          object Label69: TLabel
            Left = 3
            Top = 90
            Width = 46
            Height = 13
            Caption = 'Add items'
          end
          object edFormListLeft: TEdit
            Left = 40
            Top = 5
            Width = 49
            Height = 21
            TabOrder = 0
          end
          object edFormListtop: TEdit
            Left = 143
            Top = 5
            Width = 49
            Height = 21
            TabOrder = 1
          end
          object chkFormlistIsSorted: TCheckBox
            Left = 376
            Top = 4
            Width = 82
            Height = 17
            Caption = 'Is sorted list'
            TabOrder = 2
          end
          object chkFormListMultiSelect: TCheckBox
            Left = 376
            Top = 34
            Width = 82
            Height = 17
            Caption = 'Is multi select'
            TabOrder = 3
          end
          object edFormListBottom: TEdit
            Left = 143
            Top = 34
            Width = 49
            Height = 21
            TabOrder = 4
          end
          object edFormListRight: TEdit
            Left = 40
            Top = 34
            Width = 49
            Height = 21
            TabOrder = 5
          end
          object edFormListFieldname: TEdit
            Left = 61
            Top = 61
            Width = 131
            Height = 21
            TabOrder = 6
          end
          object cbFormListPageno: TComboBox
            Left = 426
            Top = 92
            Width = 47
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 7
          end
          object spedListBoxBorderWidth: TSpinEdit
            Left = 290
            Top = 60
            Width = 47
            Height = 22
            MaxValue = 100
            MinValue = 0
            TabOrder = 8
            Value = 1
          end
          object cbListBoxBorderStyle: TComboBox
            Left = 290
            Top = 91
            Width = 76
            Height = 21
            ItemHeight = 13
            TabOrder = 10
            Text = 'bsSolid '
            Items.Strings = (
              'bsSolid '
              'bsDashed '
              'bsBeveled'
              'bsInset'
              'bsUnderline')
          end
          object btnListboxfont: TButton
            Left = 376
            Top = 61
            Width = 72
            Height = 25
            Caption = 'Font'
            TabOrder = 9
            OnClick = btnListboxfontClick
          end
          object btnLBBackClr: TButton
            Left = 290
            Top = 33
            Width = 35
            Height = 20
            Caption = '...'
            TabOrder = 11
            OnClick = btnBorderColorClick
          end
          object btnLBBrdrClr: TButton
            Left = 290
            Top = 3
            Width = 35
            Height = 20
            Caption = '...'
            TabOrder = 12
            OnClick = btnBackColorClick
          end
          object edFormListAddItem: TEdit
            Left = 62
            Top = 86
            Width = 97
            Height = 21
            TabOrder = 13
          end
          object lstbxListBoxItems: TListBox
            Left = 62
            Top = 110
            Width = 130
            Height = 34
            ItemHeight = 13
            TabOrder = 14
          end
          object btnListAddItem: TButton
            Left = 162
            Top = 87
            Width = 30
            Height = 20
            Caption = 'Add'
            TabOrder = 15
            OnClick = btnListAddItemClick
          end
        end
      end
      object btnAddFormField: TButton
        Left = 472
        Top = 248
        Width = 74
        Height = 25
        Caption = 'Add'
        TabOrder = 2
        OnClick = btnAddFormFieldClick
      end
      object cbAddFormMeasure: TComboBox
        Left = 99
        Top = 248
        Width = 71
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 3
        Items.Strings = (
          'Pixels'
          'Points'
          'Inches'
          'MM'
          'Twips')
      end
    end
    object tbshFlatten: TTabSheet
      Caption = 'Flatten form'
      ImageIndex = 2
      object GroupBox1: TGroupBox
        Left = 7
        Top = 2
        Width = 293
        Height = 63
        Caption = 'Flatten form field by index'
        TabOrder = 0
        object Label55: TLabel
          Left = 13
          Top = 29
          Width = 50
          Height = 13
          Caption = 'Field index'
        end
        object edFlattenIndex: TEdit
          Left = 78
          Top = 26
          Width = 55
          Height = 21
          TabOrder = 0
        end
        object btnFlattenindex: TButton
          Left = 211
          Top = 22
          Width = 75
          Height = 25
          Caption = 'Flatten'
          TabOrder = 1
          OnClick = btnFlattenindexClick
        end
      end
      object GroupBox2: TGroupBox
        Left = 7
        Top = 68
        Width = 293
        Height = 63
        Caption = 'Flatten form field by name'
        TabOrder = 1
        object Label73: TLabel
          Left = 13
          Top = 27
          Width = 51
          Height = 13
          Caption = 'Field name'
        end
        object edFlattenName: TEdit
          Left = 78
          Top = 25
          Width = 121
          Height = 21
          TabOrder = 0
        end
        object btnflattenName: TButton
          Left = 211
          Top = 21
          Width = 75
          Height = 25
          Caption = 'Flatten'
          TabOrder = 1
          OnClick = btnflattenNameClick
        end
      end
      object GroupBox3: TGroupBox
        Left = 7
        Top = 135
        Width = 293
        Height = 63
        Caption = 'Flatten form field on page(s)'
        TabOrder = 2
        object Label74: TLabel
          Left = 13
          Top = 27
          Width = 55
          Height = 13
          Caption = 'Page range'
        end
        object edFlattenPage: TEdit
          Left = 78
          Top = 26
          Width = 121
          Height = 21
          TabOrder = 0
        end
        object btnflattenPage: TButton
          Left = 211
          Top = 22
          Width = 75
          Height = 25
          Caption = 'Flatten'
          TabOrder = 1
          OnClick = btnflattenPageClick
        end
      end
    end
    object tbshOthers: TTabSheet
      Caption = 'Others'
      ImageIndex = 3
      TabVisible = False
    end
  end
  object btnReset: TButton
    Left = 8
    Top = 449
    Width = 75
    Height = 25
    Caption = 'Reset'
    TabOrder = 6
    OnClick = btnResetClick
  end
  object cbOpenAfterCreate: TCheckBox
    Left = 373
    Top = 454
    Width = 114
    Height = 17
    Caption = 'Open After Create'
    TabOrder = 7
  end
  object gtPDFDocument1: TgtPDFDocument
    About = 'Gnostice PDFtoolkit (www.gnostice.com)'
    Version = '3.0'
    OpenAfterSave = False
    MergeOptions = []
    EMailAfterSave = False
    ShowSetupDialog = False
    Left = 512
    Top = 42
  end
  object OpenDialog1: TOpenDialog
    Left = 480
    Top = 42
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 536
    Top = 8
  end
  object ColorDialog1: TColorDialog
    Left = 505
    Top = 5
  end
  object ColorDialog2: TColorDialog
    Left = 472
    Top = 8
  end
  object SaveDialog1: TSaveDialog
    Left = 480
    Top = 72
  end
end
