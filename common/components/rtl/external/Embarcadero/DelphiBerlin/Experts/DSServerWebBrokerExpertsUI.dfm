inherited DSServerWebBrokerExpertsUIModule: TDSServerWebBrokerExpertsUIModule
  OldCreateOrder = True
  inherited WebServerProjectWizard: TExpertsWizard
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
        WizardPage = ApacheWizardPage
      end
      item
        WizardPage = CertFilesWizardPage
      end
      item
        WizardPage = FeaturesWizardPage
      end
      item
        WizardPage = ServerClassWizardPage
      end
      item
        WizardPage = LocationWizardPage
      end>
  end
  inherited ApacheWizardPage: TExpertsFrameWizardPage
    Left = 360
    Top = 216
  end
  object FeaturesWizardPage: TExpertsFeaturesWizardPage
    OnFeatureChecked = FeaturesWizardPageFeatureChecked
    OnWizardPageCreated = FeaturesWizardPageWizardPageCreated
    OnEnterPage = FeaturesWizardPageEnterPage
    Left = 288
    Top = 256
  end
  object ServerClassWizardPage: TExpertsFrameWizardPage
    OnFrameCreate = ServerClassWizardPageCreateFrame
    OnFrameCreated = ServerClassWizardPageFrameCreated
    OnFrameOptionChanged = ServerClassWizardPageFrameOptionChanged
    OnEnterPage = ServerClassWizardPageEnterPage
    Left = 64
    Top = 200
  end
  object LocationWizardPage: TExpertsFrameWizardPage
    OnFrameCreate = LocationWizardPageFrameCreate
    Left = 320
    Top = 152
  end
end
