inherited frmFDGUIxFormsError: TfrmFDGUIxFormsError
  Left = 374
  Top = 372
  Caption = 'FireDAC Error'
  ClientHeight = 420
  ClientWidth = 445
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  OnShow = FormShow
  ExplicitWidth = 451
  ExplicitHeight = 448
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlTop: TPanel
    Width = 445
    ExplicitWidth = 445
    inherited Bevel2: TBevel
      Width = 434
      ExplicitWidth = 434
    end
    inherited lblPrompt: TLabel
      Width = 328
      Caption = 
        'The application performed an incorrect operation with the databa' +
        'se.'
      ExplicitWidth = 328
    end
  end
  inherited pnlButtons: TPanel
    Top = 119
    Width = 445
    Height = 35
    TabOrder = 2
    ExplicitTop = 119
    ExplicitWidth = 445
    ExplicitHeight = 35
    inherited Bevel3: TBevel
      Top = 0
      Width = 434
      Height = 31
      ExplicitTop = 0
      ExplicitWidth = 434
      ExplicitHeight = 31
    end
    inherited btnOk: TButton
      Left = 283
      Top = 7
      TabOrder = 1
      ExplicitLeft = 283
      ExplicitTop = 7
    end
    inherited btnCancel: TButton
      Left = 364
      Top = 7
      Cancel = False
      Caption = 'Details'
      ModalResult = 0
      TabOrder = 2
      OnClick = DetailsBtnClick
      ExplicitLeft = 364
      ExplicitTop = 7
    end
    object btnCopy: TButton
      Left = 5
      Top = 7
      Width = 75
      Height = 23
      Caption = '&Copy'
      TabOrder = 0
      OnClick = btnCopyClick
    end
  end
  object pnlAdvanced: TPanel
    Left = 0
    Top = 154
    Width = 445
    Height = 266
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    Visible = False
    DesignSize = (
      445
      266)
    object pcAdvanced: TPageControl
      Left = 5
      Top = 0
      Width = 436
      Height = 261
      ActivePage = tsAdvanced
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 0
      object tsAdvanced: TTabSheet
        Caption = 'Error'
        DesignSize = (
          428
          233)
        object Bevel1: TBevel
          Left = 5
          Top = 200
          Width = 418
          Height = 32
          Anchors = [akLeft, akRight, akBottom]
          Shape = bsTopLine
        end
        object NativeLabel: TLabel
          Left = 5
          Top = 29
          Width = 54
          Height = 13
          Caption = 'Error code:'
        end
        object Label1: TLabel
          Left = 5
          Top = 147
          Width = 69
          Height = 13
          Anchors = [akLeft, akBottom]
          Caption = 'Server object:'
        end
        object Label2: TLabel
          Left = 195
          Top = 29
          Width = 50
          Height = 13
          Caption = 'Error kind:'
        end
        object Label3: TLabel
          Left = 5
          Top = 174
          Width = 106
          Height = 13
          Anchors = [akLeft, akBottom]
          Caption = 'Command text offset:'
        end
        object Label4: TLabel
          Left = 5
          Top = 53
          Width = 64
          Height = 13
          Caption = 'Message text:'
        end
        object Label8: TLabel
          Left = 5
          Top = 5
          Width = 134
          Height = 13
          Caption = 'Advanced Error Information'
        end
        object edtErrorCode: TEdit
          Left = 117
          Top = 24
          Width = 72
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 0
          Text = '00000'
        end
        object edtServerObject: TEdit
          Left = 113
          Top = 144
          Width = 310
          Height = 21
          TabStop = False
          Anchors = [akLeft, akRight, akBottom]
          ReadOnly = True
          TabOrder = 2
          Text = 'QWE'
        end
        object edtMessage: TMemo
          Left = 5
          Top = 72
          Width = 418
          Height = 66
          TabStop = False
          Anchors = [akLeft, akTop, akRight, akBottom]
          Lines.Strings = (
            'DbMessageText')
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 1
        end
        object edtErrorKind: TEdit
          Left = 308
          Top = 26
          Width = 117
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 6
          Text = 'RecordLocked'
        end
        object edtCommandTextOffset: TEdit
          Left = 195
          Top = 171
          Width = 48
          Height = 21
          TabStop = False
          Anchors = [akLeft, akBottom]
          ReadOnly = True
          TabOrder = 3
          Text = '00000'
        end
        object btnPrior: TButton
          Left = 267
          Top = 207
          Width = 75
          Height = 23
          Anchors = [akRight, akBottom]
          Caption = '&<<'
          TabOrder = 4
          OnClick = BackClick
        end
        object btnNext: TButton
          Left = 348
          Top = 207
          Width = 75
          Height = 23
          Anchors = [akRight, akBottom]
          Caption = '>&>'
          TabOrder = 5
          OnClick = NextClick
        end
      end
      object tsQuery: TTabSheet
        Caption = 'Query'
        ImageIndex = 1
        DesignSize = (
          428
          233)
        object Label9: TLabel
          Left = 5
          Top = 26
          Width = 74
          Height = 13
          Caption = 'Command text:'
        end
        object Label5: TLabel
          Left = 5
          Top = 131
          Width = 109
          Height = 13
          Anchors = [akLeft, akBottom]
          Caption = 'Command parameters:'
        end
        object Label10: TLabel
          Left = 5
          Top = 5
          Width = 137
          Height = 13
          Caption = 'Failed Command Information'
        end
        object lvCommandParams: TListView
          Left = 5
          Top = 150
          Width = 418
          Height = 78
          Anchors = [akLeft, akRight, akBottom]
          Columns = <
            item
              Caption = 'Name'
              Width = 150
            end
            item
              Caption = 'Value'
              Width = 250
            end>
          TabOrder = 0
          ViewStyle = vsReport
        end
      end
      object tsOther: TTabSheet
        Caption = 'Other'
        ImageIndex = 2
        DesignSize = (
          428
          233)
        object Label6: TLabel
          Left = 5
          Top = 29
          Width = 180
          Height = 13
          Caption = 'Exception class name:'
        end
        object Label7: TLabel
          Left = 5
          Top = 56
          Width = 180
          Height = 13
          Caption = 'FireDAC error code:'
        end
        object Label11: TLabel
          Left = 5
          Top = 5
          Width = 180
          Height = 13
          Caption = 'Exception Object Information'
        end
        object Label12: TLabel
          Left = 5
          Top = 83
          Width = 180
          Height = 13
          Caption = 'FireDAC object name:'
        end
        object edtClassName: TEdit
          Left = 191
          Top = 26
          Width = 160
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 0
          Text = 'EODBCNativeException'
        end
        object edtADCode: TEdit
          Left = 191
          Top = 53
          Width = 160
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 1
          Text = '12345'
        end
        object edtADObjName: TEdit
          Left = 191
          Top = 80
          Width = 234
          Height = 21
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          ReadOnly = True
          TabOrder = 2
          Text = 'FDQuery1'
        end
      end
    end
  end
  object pnlMsg: TPanel
    Left = 0
    Top = 39
    Width = 445
    Height = 80
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object memMsg: TMemo
      Left = 5
      Top = 2
      Width = 434
      Height = 72
      Lines.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6')
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
end
