object InetExpertsUIModule: TInetExpertsUIModule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 326
  Width = 461
  object ApplicationTypeWizardPage1: TExpertsFrameWizardPage
    OnFrameCreate = ApplicationTypeWizardPage1CreateFrame
    OnFrameCreated = ApplicationTypeWizardPage1FrameCreated
    OnFrameOptionChanged = ApplicationTypeWizardPage1FrameOptionChanged
    OnEnterPage = ApplicationTypeWizardPage1EnterPage
    Left = 224
    Top = 24
  end
  object WebServerProjectWizard: TExpertsWizard
    WizardPages = <
      item
        WizardPage = PlatformFrameWizardPage
      end
      item
        WizardPage = ApplicationTypeWizardPage1
      end
      item
        WizardPage = FrameWorkWizardPage
      end
      item
        WizardPage = PortsWizardPage
      end
      item
        WizardPage = CertFilesWizardPage
      end
      item
        WizardPage = ApacheWizardPage
      end>
    Caption = 'New Web Server Application'
    ShowSteps = False
    HelpContext = 0
    OnLoadImage = WebServerProjectWizardLoadImage
    Left = 56
    Top = 24
  end
  object PortsWizardPage: TExpertsFrameWizardPage
    OnFrameCreate = PortsWizardPageCreateFrame
    OnFrameCreated = PortsWizardPageFrameCreated
    OnFrameOptionChanged = PortsWizardPageFrameOptionChanged
    OnEnterPage = PortsWizardPageEnterPage
    Left = 216
    Top = 104
  end
  object CertFilesWizardPage: TExpertsFrameWizardPage
    OnFrameCreate = CertFilesWizardPageCreateFrame
    OnFrameCreated = CertFilesWizardPageFrameCreated
    Left = 208
    Top = 184
  end
  object ApacheWizardPage: TExpertsFrameWizardPage
    OnFrameCreate = ApacheWizardPageFrameCreate
    OnFrameCreated = ApacheWizardPageFrameCreated
    Left = 192
    Top = 256
  end
  object FrameWorkWizardPage: TExpertsFrameWizardPage
    OnFrameCreate = FrameWorkWizardPageFrameCreate
    OnFrameCreated = FrameWorkWizardPageFrameCreated
    Left = 56
    Top = 256
  end
  object PlatformFrameWizardPage: TExpertsFrameWizardPage
    OnFrameCreate = PlatformFrameWizardPageFrameCreate
    OnFrameCreated = PlatformFrameWizardPageFrameCreated
    OnFrameOptionChanged = PlatformFrameWizardPageFrameOptionChanged
    Left = 64
    Top = 128
  end
end
