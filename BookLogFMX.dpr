program BookLogFMX;

uses
  System.StartUpCopy,
  FMX.Forms,
  MainForm in 'MainForm.pas' {frmMain},
  DataAccessModule in 'DataAccessModule.pas' {dmDataAccess: TDataModule},
  PhotoFrame in 'Frames\PhotoFrame.pas' {frPhoto: TFrame},
  WebBrowserFrame in 'Frames\WebBrowserFrame.pas' {frWebBrowser: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmDataAccess, dmDataAccess);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
