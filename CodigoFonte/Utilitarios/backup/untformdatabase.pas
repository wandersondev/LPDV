unit untformdatabase;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons;

type

  { TFormDataBase }

  TFormDataBase = class(TForm)
    btnConfirmar: TBitBtn;
    BitBtn2: TBitBtn;
    cbxTipo: TComboBox;
    edtBanco: TEdit;
    edtIP: TEdit;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    Image1: TImage;
    ImageListTipos: TImageList;
    Label1: TLabel;
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

