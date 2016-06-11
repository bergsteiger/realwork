inherited frmFDGUIxFormsDesignTimeOptions: TfrmFDGUIxFormsDesignTimeOptions
  Caption = 'FireDAC Setup'
  ClientHeight = 417
  ClientWidth = 349
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlTop: TPanel
    Width = 349
    TabOrder = 2
    inherited Bevel2: TBevel
      Width = 339
    end
    inherited lblPrompt: TLabel
      Width = 169
      Caption = 'Setup FireDAC design time settings'
    end
  end
  inherited pnlButtons: TPanel
    Top = 379
    Width = 349
    TabOrder = 0
    inherited Bevel3: TBevel
      Width = 339
    end
    inherited btnOk: TButton
      Left = 188
    end
    inherited btnCancel: TButton
      Left = 269
    end
  end
  object PageControl1: TPageControl
    Left = 5
    Top = 41
    Width = 340
    Height = 335
    ActivePage = TabSheet1
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Meta Data'
      object btnRefreshMetadata: TButton
        Left = 4
        Top = 275
        Width = 158
        Height = 25
        Caption = 'Refresh  meta data cache'
        TabOrder = 0
        OnClick = btnRefreshMetadataClick
      end
      object GroupBox1: TGroupBox
        Left = 4
        Top = 3
        Width = 321
        Height = 76
        Caption = 'Restrict objects list by catalog and/or schema:'
        TabOrder = 2
        object Label2: TLabel
          Left = 8
          Top = 20
          Width = 41
          Height = 13
          Caption = '&Catalog:'
          FocusControl = edtCatalog
        end
        object Label3: TLabel
          Left = 8
          Top = 47
          Width = 41
          Height = 13
          Caption = '&Schema:'
          FocusControl = edtSchema
        end
        object edtCatalog: TEdit
          Left = 56
          Top = 17
          Width = 255
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          Text = 'edtCatalog'
        end
        object edtSchema: TEdit
          Left = 56
          Top = 44
          Width = 255
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
          Text = 'Edit1'
        end
      end
      object GroupBox2: TGroupBox
        Left = 4
        Top = 82
        Width = 321
        Height = 49
        Caption = 'Restrict objects list by ownership:'
        TabOrder = 4
        object cbMy: TCheckBox
          Left = 8
          Top = 22
          Width = 41
          Height = 14
          Caption = '&My'
          TabOrder = 0
        end
        object cbOther: TCheckBox
          Left = 68
          Top = 22
          Width = 55
          Height = 14
          Caption = '&Other'
          TabOrder = 1
        end
        object cbSystem: TCheckBox
          Left = 129
          Top = 22
          Width = 66
          Height = 14
          Caption = 'S&ystem'
          TabOrder = 2
        end
      end
      object GroupBox3: TGroupBox
        Left = 4
        Top = 134
        Width = 321
        Height = 49
        Caption = 'Restrict objects by mask:'
        TabOrder = 1
        object Label6: TLabel
          Left = 8
          Top = 20
          Width = 28
          Height = 13
          Caption = 'M&ask:'
        end
        object edtMask: TEdit
          Left = 56
          Top = 17
          Width = 255
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          Text = 'Edit1'
        end
      end
      object GroupBox4: TGroupBox
        Left = 4
        Top = 187
        Width = 321
        Height = 49
        Caption = 'Restrict tables list by kind:'
        TabOrder = 3
        object cbTable: TCheckBox
          Left = 8
          Top = 22
          Width = 52
          Height = 14
          Caption = '&Table'
          TabOrder = 0
        end
        object cbView: TCheckBox
          Left = 68
          Top = 22
          Width = 55
          Height = 14
          Caption = '&View'
          TabOrder = 1
        end
        object cbSynonym: TCheckBox
          Left = 129
          Top = 22
          Width = 66
          Height = 14
          Caption = 'Sy&nonym'
          TabOrder = 2
        end
        object cbTempTable: TCheckBox
          Left = 201
          Top = 22
          Width = 72
          Height = 14
          Caption = 'T&emp table'
          TabOrder = 3
        end
      end
      object cbFullName: TCheckBox
        Left = 12
        Top = 248
        Width = 141
        Height = 17
        Caption = 'Use full object names'
        TabOrder = 5
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Other'
      ImageIndex = 1
      object GroupBox5: TGroupBox
        Left = 4
        Top = 3
        Width = 321
        Height = 49
        Caption = 'Tracing:'
        TabOrder = 0
        object cbTraceDT: TCheckBox
          Left = 8
          Top = 22
          Width = 161
          Height = 14
          Caption = '&Enable design-time tracing'
          TabOrder = 0
        end
      end
      object GroupBox6: TGroupBox
        Left = 3
        Top = 58
        Width = 321
        Height = 49
        Caption = 'Query Editor:'
        TabOrder = 1
        object cbDClickFE: TCheckBox
          Left = 8
          Top = 22
          Width = 161
          Height = 14
          Caption = '&Double click calls Fields Editor'
          TabOrder = 0
        end
      end
    end
  end
end
