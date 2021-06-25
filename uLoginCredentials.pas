{
   15/10/20 [V4.5 R4.3] /MK Change - Added DatabasePath to be passed into the Show function so the screen can show a stored Username and Password.
                                   - Disable the Username and Password entry if there are LogInCredentials stored already.
                                   - Added an Edit button so that if the Username and Password is disabled the user has the option to edit them.
}

unit uLoginCredentials;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  cxLabel, dxCntner, dxEditor, dxEdLib, StdCtrls, cxButtons, cxControls,
  cxContainer, cxEdit, cxGroupBox, LoginCredentials, CredentialsStore;

type
  TfmLoginCredentials = class(TForm)
    cxGroupBox1: TcxGroupBox;
    okButton: TcxButton;
    cancelButton: TcxButton;
    usernameTextEdit: TdxEdit;
    passwordTextEdit: TdxEdit;
    lUsername: TcxLabel;
    lPassword: TcxLabel;
    btnEdit: TcxButton;
    cxLabel1: TcxLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function Show (APath : String) : TLoginCredentials;
  end;

var
  fmLoginCredentials: TfmLoginCredentials;

implementation

{$R *.DFM}

procedure TfmLoginCredentials.FormActivate(Sender: TObject);
begin
   if ( Length(usernameTextEdit.Text) = 0 ) then
      usernameTextEdit.SetFocus;
end;

procedure TfmLoginCredentials.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if ( ModalResult = mrOK ) then
      begin
         Canclose := (Trim(usernameTextEdit.text) <> '') and (Trim(passwordTextEdit.text) <> '');
         if not CanClose then
            MessageDlg('Username && password are required.',mtWarning,[mbOK],0);
      end;
end;

class function TfmLoginCredentials.Show (APath : String) : TLoginCredentials;
var
   CurLoginCredentials : TLoginCredentials;
begin
   Result := nil;
   with TfmLoginCredentials.Create(nil) do
      try
         usernameTextEdit.Enabled := True;
         passwordTextEdit.Enabled := True;
         
         CurLoginCredentials := TCredentialsStore.Load(APath);
         if ( CurLoginCredentials <> nil ) then
            try
               usernameTextEdit.Text := CurLoginCredentials.Username;
               usernameTextEdit.Enabled := False;
               passwordTextEdit.Text := CurLoginCredentials.Password;
               passwordTextEdit.Enabled := False;
            finally
               CurLoginCredentials.Free;
            end;

         btnEdit.Visible := ( not(usernameTextEdit.Enabled) );

         if ( ShowModal <> mrOK ) and ( (Length(usernameTextEdit.Text) = 0) or (Length(passwordTextEdit.Text) = 0) ) then Exit;

         Result := TLoginCredentials.Create();
         Result.Username := Trim(usernameTextEdit.Text);
         Result.Password := Trim(passwordTextEdit.Text);
      finally
         Free;
      end;
end;

procedure TfmLoginCredentials.FormCreate(Sender: TObject);
begin
   usernameTextEdit.Text := '';
   passwordTextEdit.Text := '';
end;

procedure TfmLoginCredentials.btnEditClick(Sender: TObject);
begin
   usernameTextEdit.Enabled := True;
   passwordTextEdit.Enabled := True;
   usernameTextEdit.SetFocus;
end;

end.
