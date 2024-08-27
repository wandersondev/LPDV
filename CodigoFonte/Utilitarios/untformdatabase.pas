unit untformdatabase;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, BGRACustomDrawn;

type

  { TFormDataBase }

  TFormDataBase = class(TForm)
    BCDPanel1: TBCDPanel;
    BCDPanel2: TBCDPanel;
    BCDPanel3: TBCDPanel;
    BitBtn2: TBitBtn;
    btnConfirmar: TBitBtn;
    cbxTipo: TComboBox;
    edtBanco: TEdit;
    edtIP: TEdit;
    edtSenha: TEdit;
    edtUsuario: TEdit;
    Image1: TImage;
    ImageListTipos: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    lbBanco: TLabel;
    lbBanco1: TLabel;
    lbBanco2: TLabel;
    lbBanco3: TLabel;
    procedure btnConfirmarClick(Sender: TObject);
  private

  public

  end;

var
  FormDataBase: TFormDataBase;

implementation

{$R *.lfm}

{ TFormDataBase }

procedure TFormDataBase.btnConfirmarClick(Sender: TObject);
begin
  ShowMessage('Gravar arquivo');
end;

initialization
Classes.RegisterClass(TFormDataBase);
finalization
Classes.UnRegisterClass(TFormDataBase);
end.

